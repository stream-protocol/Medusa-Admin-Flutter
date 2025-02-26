import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medusa_admin/app/routes/app_pages.dart';
import 'package:medusa_admin/core/utils/medusa_icons_icons.dart';
import 'package:shake/shake.dart';

import '../../../data/service/storage_service.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find<DashboardController>();
  int currentScreen = 0;
  late ShakeDetector detector;
  final appSettings = StorageService.appSettings;
  final bottomNavBarItems = GetPlatform.isIOS
      ? const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(MedusaIcons.tag), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(MedusaIcons.users), label: 'Customers'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add), label: 'More'),
        ]
      : const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tag), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ];

  void onTap(int index) {
    currentScreen = index;
    update();
  }

  @override
  void onReady() {
    if (appSettings.shakeToSearch) {
      detector = ShakeDetector.autoStart(onPhoneShake: () async {
        if (Get.currentRoute != Routes.MEDUSA_SEARCH) {
          await Get.toNamed(Routes.MEDUSA_SEARCH);
        }
      });
    }
    super.onReady();
  }

  @override
  void onClose() {
    if (appSettings.shakeToSearch) {
      detector.stopListening();
    }
    super.onClose();
  }
}
