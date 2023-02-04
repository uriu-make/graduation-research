#! /bin/bash
sudo apt-get update --allow-releaseinfo-change 
sudo apt-get upgrade -y
#コンパイラ、GDBサーバーとzram管理ツールとウォッチドッグタイマのインストール
sudo apt-get install build-essential gdbserver zram-tools watchdog -y
#X11 port forward関連
#sudo apt-get install x11-apps libgl1-mesa-dev xorg-dev -y 
#swapツールをアンインストール
sudo apt-get remove dphys-swapfile -y
#ウォッチドッグタイマを設定
sudo su -c "echo RuntimeWatchdogSec=10 >> /etc/systemd/system.conf"
sudo su -c "echo dtparam=watchdog=on >> /boot/config.txt"
#PWR LEDをheartbeat(点滅)モードに設定する
sudo su -c "echo dtparam=pwr_led_trigger=heartbeat >> /boot/config.txt"
#Bluetoothを無効化
sudo su -c "echo dtoverlay=pi3-disable-bt >> /boot/config.txt"
#SPIのCS0をGPIO22に、CS1をGPIO23にそれぞれ変更する
sudo su -c "echo dtoverlay=spi0-2cs,cs0_pin=22,cs1_pin=23 >> /boot/config.txt"

#行列計算ライブラリであるOpenBLASをインストール
#sudo apt-get install -y libopenblas64-dev
#不要なパッケージをアンインストール
sudo apt-get autoremove -y
#isolcpuの設定
sudo su -c "sed -i -e 's/rootwait/rootwait isolcpus=2-3/' /boot/cmdline.txt"
#再起動
sudo reboot

#ウォッチドッグタイマのテストコマンド
#sudo su -c "echo 1 > /proc/sys/kernel/sysrq && echo "c" > /proc/sysrq-trigger"
