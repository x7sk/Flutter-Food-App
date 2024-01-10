
class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCart(),
      body: SharedPrefs.instance.getString('token') == null
          ? Center(
              child: Text(
                "You must open an account".tr,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context)
                      .textTheme
                      .headline1!
                      .color!
                      .withOpacity(.5),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Obx(() => cartController.cartDataList.isNotEmpty
                        ? SizedBox(
                            height: Get.height * .48,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cartController.cartDataList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListViewItem(
                                cartData: cartController.cartDataList[index],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: Get.height * .48,
                            child: Center(
                                child: Text(
                              "No Foods In Cart".tr,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color!
                                    .withOpacity(.5),
                              ),
                            )),
                          )),
                    Obx(() {
                      return SizedBox(
                        height: Get.height * .4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              CustomCard(
                                total: cartController.cartTotalPrice(),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              AuthButton(
                                text: 'Checkout'.tr,
                                press: () {
                                  cartController.checkOutCart(
                                      cartData: cartController.cartDataList);
                                  Get.toNamed(Routes.checkoutScreen);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
    );
  }
}
