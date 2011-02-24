From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: new behaviour in git merge
Date: Thu, 24 Feb 2011 14:33:53 +1100
Message-ID: <20110224143353.ddaa316a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Feb_2011_14_33_53_+1100_w0/Fqe2QEBudOY.Z"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 04:34:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsRy0-0000jz-SW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 04:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab1BXDeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 22:34:06 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:43386 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932298Ab1BXDeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 22:34:04 -0500
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id DB356144BA5
	for <git@vger.kernel.org>; Thu, 24 Feb 2011 14:34:01 +1100 (EST)
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167774>

--Signature=_Thu__24_Feb_2011_14_33_53_+1100_w0/Fqe2QEBudOY.Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am not sure when this started, but I think git has changed its behaviour
when merging.   As you all know, I do a lot of merging of trees for
linux-next each day.  Today I noticed that when I merge a tree, sometimes
the timestamps are modified for files that are not modified on one side
of the merge.  It is not consistent and it is not all the files that are
modified on the HEAD side (relative to the merge-base).

For example, today when I merged the drm tree:

$ git merge drm/drm-next
Auto-merging drivers/gpu/drm/drm_info.c
Removing drivers/gpu/drm/i830/Makefile
Removing drivers/gpu/drm/i830/i830_dma.c
Removing drivers/gpu/drm/i830/i830_drv.c
Removing drivers/gpu/drm/i830/i830_drv.h
Removing drivers/gpu/drm/i830/i830_irq.c
Auto-merging drivers/gpu/drm/i915/i915_drv.c
Auto-merging drivers/gpu/drm/i915/i915_drv.h
Auto-merging drivers/gpu/drm/i915/intel_sdvo.c
Auto-merging drivers/gpu/drm/radeon/atombios_crtc.c
Auto-merging drivers/gpu/drm/radeon/evergreen_blit_kms.c
Auto-merging drivers/gpu/drm/radeon/r600.c
Auto-merging drivers/gpu/drm/radeon/r600_blit_kms.c
Auto-merging drivers/gpu/drm/radeon/r600_cs.c
Auto-merging drivers/gpu/drm/radeon/r600d.h
Auto-merging drivers/gpu/drm/radeon/radeon_device.c
Auto-merging drivers/gpu/drm/radeon/radeon_display.c
Auto-merging drivers/gpu/drm/radeon/radeon_mode.h
Auto-merging drivers/gpu/drm/radeon/radeon_ttm.c
Auto-merging drivers/gpu/drm/radeon/rv770.c
Removing include/drm/i830_drm.h
Merge made by recursive.
 drivers/gpu/drm/Kconfig                     |   47 +-
 drivers/gpu/drm/Makefile                    |    3 +-
 drivers/gpu/drm/drm_crtc.c                  |   33 +
 drivers/gpu/drm/drm_drv.c                   |   48 +-
 drivers/gpu/drm/drm_edid.c                  |   19 +-
 drivers/gpu/drm/drm_edid_modes.h            |    4 +-
 drivers/gpu/drm/drm_fb_helper.c             |    5 +
 drivers/gpu/drm/drm_gem.c                   |    5 +-
 drivers/gpu/drm/drm_hashtab.c               |   27 +-
 drivers/gpu/drm/drm_info.c                  |   27 +-
 drivers/gpu/drm/drm_ioctl.c                 |  115 +--
 drivers/gpu/drm/drm_irq.c                   |   14 +-
 drivers/gpu/drm/drm_mm.c                    |  570 ++++++-----
 drivers/gpu/drm/drm_modes.c                 |    6 +-
 drivers/gpu/drm/drm_pci.c                   |  205 ++++-
 drivers/gpu/drm/drm_platform.c              |   75 ++-
 drivers/gpu/drm/drm_stub.c                  |   21 +-
 drivers/gpu/drm/drm_usb.c                   |  117 ++
 drivers/gpu/drm/i810/i810_dma.c             |   18 +-
 drivers/gpu/drm/i810/i810_drv.c             |   20 +-
 drivers/gpu/drm/i830/Makefile               |    8 -
 drivers/gpu/drm/i830/i830_dma.c             | 1560 -----------------------=
----
 drivers/gpu/drm/i830/i830_drv.c             |  107 --
 drivers/gpu/drm/i830/i830_drv.h             |  295 -----
 drivers/gpu/drm/i830/i830_irq.c             |  186 ----
 drivers/gpu/drm/i915/i915_drv.c             |   23 +-
 drivers/gpu/drm/i915/i915_drv.h             |    7 +
 drivers/gpu/drm/i915/i915_gem.c             |  103 ++-
 drivers/gpu/drm/i915/intel_sdvo.c           |    2 +-
 drivers/gpu/drm/mga/mga_dma.c               |    2 +-
 drivers/gpu/drm/mga/mga_drv.c               |   13 +-
 drivers/gpu/drm/nouveau/nouveau_drv.c       |   21 +-
 drivers/gpu/drm/nouveau/nouveau_mem.c       |    2 +-
 drivers/gpu/drm/nouveau/nouveau_object.c    |    2 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c     |   31 +-
 drivers/gpu/drm/nouveau/nouveau_state.c     |    4 +-
 drivers/gpu/drm/nouveau/nv17_tv.c           |    4 +-
 drivers/gpu/drm/nouveau/nv17_tv.h           |    2 +-
 drivers/gpu/drm/nouveau/nv17_tv_modes.c     |    2 +-
 drivers/gpu/drm/nouveau/nv50_instmem.c      |    4 +-
 drivers/gpu/drm/nouveau/nvc0_instmem.c      |    2 +-
 drivers/gpu/drm/r128/r128_drv.c             |   14 +-
 drivers/gpu/drm/radeon/atombios_crtc.c      |    8 +-
 drivers/gpu/drm/radeon/evergreen_blit_kms.c |    2 +-
 drivers/gpu/drm/radeon/r600.c               |    2 +-
 drivers/gpu/drm/radeon/r600_audio.c         |    1 +
 drivers/gpu/drm/radeon/r600_blit_kms.c      |    2 +-
 drivers/gpu/drm/radeon/r600_cs.c            |  353 ++++--
 drivers/gpu/drm/radeon/r600_hdmi.c          |    1 +
 drivers/gpu/drm/radeon/r600d.h              |    5 +
 drivers/gpu/drm/radeon/radeon.h             |   90 +--
 drivers/gpu/drm/radeon/radeon_asic.h        |   77 ++-
 drivers/gpu/drm/radeon/radeon_benchmark.c   |    4 +-
 drivers/gpu/drm/radeon/radeon_cp.c          |    4 +-
 drivers/gpu/drm/radeon/radeon_cs.c          |    2 +-
 drivers/gpu/drm/radeon/radeon_device.c      |    4 +-
 drivers/gpu/drm/radeon/radeon_display.c     |    4 +-
 drivers/gpu/drm/radeon/radeon_drv.c         |   49 +-
 drivers/gpu/drm/radeon/radeon_fb.c          |   12 +-
 drivers/gpu/drm/radeon/radeon_gart.c        |   38 +-
 drivers/gpu/drm/radeon/radeon_gem.c         |   96 ++-
 drivers/gpu/drm/radeon/radeon_kms.c         |    4 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |    4 +-
 drivers/gpu/drm/radeon/radeon_mode.h        |    1 +
 drivers/gpu/drm/radeon/radeon_object.c      |   28 +-
 drivers/gpu/drm/radeon/radeon_object.h      |    7 +-
 drivers/gpu/drm/radeon/radeon_ring.c        |    4 +-
 drivers/gpu/drm/radeon/radeon_test.c        |    4 +-
 drivers/gpu/drm/radeon/radeon_ttm.c         |   10 +-
 drivers/gpu/drm/radeon/rv770.c              |    2 +-
 drivers/gpu/drm/savage/savage_drv.c         |   14 +-
 drivers/gpu/drm/sis/sis_drv.c               |   13 +-
 drivers/gpu/drm/tdfx/tdfx_drv.c             |   13 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c       |    3 +-
 drivers/gpu/drm/ttm/ttm_bo.c                |    3 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c        |   34 +-
 drivers/gpu/drm/ttm/ttm_tt.c                |   12 +-
 drivers/gpu/drm/via/via_drv.c               |   13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c      |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         |   23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c         |    5 +-
 include/drm/Kbuild                          |    1 -
 include/drm/drm.h                           |    4 +
 include/drm/drmP.h                          |  120 ++-
 include/drm/drm_crtc.h                      |   13 +-
 include/drm/drm_hashtab.h                   |    6 +-
 include/drm/drm_mm.h                        |   49 +-
 include/drm/drm_mode.h                      |   29 +
 include/drm/drm_usb.h                       |   15 +
 include/drm/i830_drm.h                      |  342 ------
 include/drm/ttm/ttm_bo_driver.h             |    6 +-
 include/drm/ttm/ttm_page_alloc.h            |    8 +-
 92 files changed, 1755 insertions(+), 3565 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_usb.c
 delete mode 100644 drivers/gpu/drm/i830/Makefile
 delete mode 100644 drivers/gpu/drm/i830/i830_dma.c
 delete mode 100644 drivers/gpu/drm/i830/i830_drv.c
 delete mode 100644 drivers/gpu/drm/i830/i830_drv.h
 delete mode 100644 drivers/gpu/drm/i830/i830_irq.c
 create mode 100644 include/drm/drm_usb.h
 delete mode 100644 include/drm/i830_drm.h

Then the timestamps on all these files were updated (this is the list of
files rsync has decided to copy - I checked and the timestamps are indeed
modified):

Documentation/devicetree/booting-without-of.txt
Documentation/devicetree/bindings/eeprom.txt
Documentation/devicetree/bindings/marvell.txt
Documentation/devicetree/bindings/xilinx.txt
Documentation/devicetree/bindings/ata/fsl-sata.txt
Documentation/devicetree/bindings/gpio/8xxx_gpio.txt
Documentation/devicetree/bindings/gpio/gpio.txt
Documentation/devicetree/bindings/gpio/led.txt
Documentation/devicetree/bindings/i2c/fsl-i2c.txt
Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
Documentation/devicetree/bindings/mtd/mtd-physmap.txt
Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
Documentation/devicetree/bindings/net/mdio-gpio.txt
Documentation/devicetree/bindings/net/phy.txt
Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
Documentation/devicetree/bindings/net/can/sja1000.txt
Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
Documentation/devicetree/bindings/powerpc/4xx/cpm.txt
Documentation/devicetree/bindings/powerpc/4xx/emac.txt
Documentation/devicetree/bindings/powerpc/4xx/ndfc.txt
Documentation/devicetree/bindings/powerpc/4xx/ppc440spe-adma.txt
Documentation/devicetree/bindings/powerpc/4xx/reboot.txt
Documentation/devicetree/bindings/powerpc/fsl/board.txt
Documentation/devicetree/bindings/powerpc/fsl/diu.txt
Documentation/devicetree/bindings/powerpc/fsl/dma.txt
Documentation/devicetree/bindings/powerpc/fsl/ecm.txt
Documentation/devicetree/bindings/powerpc/fsl/gtm.txt
Documentation/devicetree/bindings/powerpc/fsl/guts.txt
Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
Documentation/devicetree/bindings/powerpc/fsl/mcm.txt
Documentation/devicetree/bindings/powerpc/fsl/mcu-mpc8349emitx.txt
Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
Documentation/devicetree/bindings/powerpc/fsl/sec.txt
Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/gpio.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/serial.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/brg.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/i2c.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/pic.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/cpm/usb.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/firmware.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/par_io.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/pincfg.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/ucc.txt
Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe/usb.txt
Documentation/devicetree/bindings/powerpc/nintendo/gamecube.txt
Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
Documentation/devicetree/bindings/spi/fsl-spi.txt
Documentation/devicetree/bindings/spi/spi-bus.txt
Documentation/devicetree/bindings/usb/fsl-usb.txt
Documentation/devicetree/bindings/usb/usb-ehci.txt
Documentation/laptops/hpfall.c
Documentation/misc-devices/lis3lv02d
arch/arm/mach-exynos4/Kconfig
arch/arm/mach-exynos4/Makefile.boot
arch/arm/mach-exynos4/clock.c
arch/arm/mach-exynos4/cpu.c
arch/arm/mach-exynos4/cpufreq.c
arch/arm/mach-exynos4/dev-audio.c
arch/arm/mach-exynos4/dev-pd.c
arch/arm/mach-exynos4/dev-sysmmu.c
arch/arm/mach-exynos4/dma.c
arch/arm/mach-exynos4/gpiolib.c
arch/arm/mach-exynos4/headsmp.S
arch/arm/mach-exynos4/hotplug.c
arch/arm/mach-exynos4/init.c
arch/arm/mach-exynos4/irq-combiner.c
arch/arm/mach-exynos4/irq-eint.c
arch/arm/mach-exynos4/localtimer.c
arch/arm/mach-exynos4/mach-smdkc210.c
arch/arm/mach-exynos4/mach-smdkv310.c
arch/arm/mach-exynos4/mach-universal_c210.c
arch/arm/mach-exynos4/platsmp.c
arch/arm/mach-exynos4/setup-i2c0.c
arch/arm/mach-exynos4/setup-i2c1.c
arch/arm/mach-exynos4/setup-i2c2.c
arch/arm/mach-exynos4/setup-i2c3.c
arch/arm/mach-exynos4/setup-i2c4.c
arch/arm/mach-exynos4/setup-i2c5.c
arch/arm/mach-exynos4/setup-i2c6.c
arch/arm/mach-exynos4/setup-i2c7.c
arch/arm/mach-exynos4/setup-sdhci-gpio.c
arch/arm/mach-exynos4/setup-sdhci.c
arch/arm/mach-exynos4/time.c
arch/arm/mach-exynos4/include/mach/debug-macro.S
arch/arm/mach-exynos4/include/mach/entry-macro.S
arch/arm/mach-exynos4/include/mach/hardware.h
arch/arm/mach-exynos4/include/mach/io.h
arch/arm/mach-exynos4/include/mach/irqs.h
arch/arm/mach-exynos4/include/mach/memory.h
arch/arm/mach-exynos4/include/mach/pwm-clock.h
arch/arm/mach-exynos4/include/mach/regs-clock.h
arch/arm/mach-exynos4/include/mach/regs-irq.h
arch/arm/mach-exynos4/include/mach/regs-mem.h
arch/arm/mach-exynos4/include/mach/regs-pmu.h
arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
arch/arm/mach-exynos4/include/mach/smp.h
arch/arm/mach-exynos4/include/mach/sysmmu.h
arch/arm/mach-exynos4/include/mach/system.h
arch/arm/mach-exynos4/include/mach/timex.h
arch/arm/mach-exynos4/include/mach/uncompress.h
arch/arm/mach-exynos4/include/mach/vmalloc.h
arch/arm/mach-msm/devices-iommu.c
arch/arm/mach-mx5/devices-imx50.h
arch/arm/mach-vt8500/include/mach/vmalloc.h
arch/arm/plat-versatile/headsmp.S
arch/arm/plat-versatile/localtimer.c
drivers/char/virtio_console.c
deleting drivers/gpu/drm/i830/i830_irq.c
deleting drivers/gpu/drm/i830/i830_drv.h
deleting drivers/gpu/drm/i830/i830_drv.c
deleting drivers/gpu/drm/i830/i830_dma.c
deleting drivers/gpu/drm/i830/Makefile
drivers/gpu/drm/Kconfig
drivers/gpu/drm/Makefile
drivers/gpu/drm/drm_crtc.c
drivers/gpu/drm/drm_drv.c
drivers/gpu/drm/drm_edid.c
drivers/gpu/drm/drm_edid_modes.h
drivers/gpu/drm/drm_fb_helper.c
drivers/gpu/drm/drm_gem.c
drivers/gpu/drm/drm_hashtab.c
drivers/gpu/drm/drm_info.c
drivers/gpu/drm/drm_ioctl.c
drivers/gpu/drm/drm_irq.c
drivers/gpu/drm/drm_mm.c
drivers/gpu/drm/drm_modes.c
drivers/gpu/drm/drm_pci.c
drivers/gpu/drm/drm_platform.c
drivers/gpu/drm/drm_stub.c
drivers/gpu/drm/drm_usb.c
drivers/gpu/drm/i810/i810_dma.c
drivers/gpu/drm/i810/i810_drv.c
drivers/gpu/drm/i915/i915_drv.c
drivers/gpu/drm/i915/i915_drv.h
drivers/gpu/drm/i915/i915_gem.c
drivers/gpu/drm/i915/intel_sdvo.c
drivers/gpu/drm/mga/mga_dma.c
drivers/gpu/drm/mga/mga_drv.c
drivers/gpu/drm/nouveau/nouveau_drv.c
drivers/gpu/drm/nouveau/nouveau_mem.c
drivers/gpu/drm/nouveau/nouveau_object.c
drivers/gpu/drm/nouveau/nouveau_sgdma.c
drivers/gpu/drm/nouveau/nouveau_state.c
drivers/gpu/drm/nouveau/nv17_tv.c
drivers/gpu/drm/nouveau/nv17_tv.h
drivers/gpu/drm/nouveau/nv17_tv_modes.c
drivers/gpu/drm/nouveau/nv50_instmem.c
drivers/gpu/drm/nouveau/nvc0_instmem.c
drivers/gpu/drm/r128/r128_drv.c
drivers/gpu/drm/radeon/atombios_crtc.c
drivers/gpu/drm/radeon/evergreen_blit_kms.c
drivers/gpu/drm/radeon/r600.c
drivers/gpu/drm/radeon/r600_audio.c
drivers/gpu/drm/radeon/r600_blit_kms.c
drivers/gpu/drm/radeon/r600_cs.c
drivers/gpu/drm/radeon/r600_hdmi.c
drivers/gpu/drm/radeon/r600d.h
drivers/gpu/drm/radeon/radeon.h
drivers/gpu/drm/radeon/radeon_asic.h
drivers/gpu/drm/radeon/radeon_benchmark.c
drivers/gpu/drm/radeon/radeon_cp.c
drivers/gpu/drm/radeon/radeon_cs.c
drivers/gpu/drm/radeon/radeon_device.c
drivers/gpu/drm/radeon/radeon_display.c
drivers/gpu/drm/radeon/radeon_drv.c
drivers/gpu/drm/radeon/radeon_fb.c
drivers/gpu/drm/radeon/radeon_gart.c
drivers/gpu/drm/radeon/radeon_gem.c
drivers/gpu/drm/radeon/radeon_kms.c
drivers/gpu/drm/radeon/radeon_legacy_crtc.c
drivers/gpu/drm/radeon/radeon_mode.h
drivers/gpu/drm/radeon/radeon_object.c
drivers/gpu/drm/radeon/radeon_object.h
drivers/gpu/drm/radeon/radeon_ring.c
drivers/gpu/drm/radeon/radeon_test.c
drivers/gpu/drm/radeon/radeon_ttm.c
drivers/gpu/drm/radeon/rv770.c
drivers/gpu/drm/savage/savage_drv.c
drivers/gpu/drm/sis/sis_drv.c
drivers/gpu/drm/tdfx/tdfx_drv.c
drivers/gpu/drm/ttm/ttm_agp_backend.c
drivers/gpu/drm/ttm/ttm_bo.c
drivers/gpu/drm/ttm/ttm_page_alloc.c
drivers/gpu/drm/ttm/ttm_tt.c
drivers/gpu/drm/via/via_drv.c
drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
drivers/misc/lis3lv02d/lis3lv02d.c
drivers/misc/lis3lv02d/lis3lv02d.h
drivers/misc/lis3lv02d/lis3lv02d_i2c.c
drivers/misc/lis3lv02d/lis3lv02d_spi.c
drivers/net/wireless/iwlegacy/iwl-3945-debugfs.c
drivers/net/wireless/iwlegacy/iwl-3945-fh.h
drivers/net/wireless/iwlegacy/iwl-3945-hw.h
drivers/net/wireless/iwlegacy/iwl-3945-rs.c
drivers/net/wireless/iwlegacy/iwl-3945.c
drivers/net/wireless/iwlegacy/iwl-3945.h
drivers/net/wireless/iwlegacy/iwl-4965-debugfs.h
drivers/net/wireless/iwlegacy/iwl-4965-eeprom.c
drivers/net/wireless/iwlegacy/iwl-4965-hw.h
drivers/net/wireless/iwlegacy/iwl-4965-led.c
drivers/net/wireless/iwlegacy/iwl-4965.c
drivers/net/wireless/iwlegacy/iwl3945-base.c
drivers/net/wireless/rtlwifi/rtl8192c/fw_common.c
drivers/net/wireless/rtlwifi/rtl8192c/fw_common.h
drivers/net/wireless/rtlwifi/rtl8192cu/rf.h
drivers/platform/x86/hp_accel.c
drivers/scsi/fcoe/fcoe_ctlr.c
drivers/watchdog/m54xx_wdt.c
deleting include/drm/i830_drm.h
include/drm/Kbuild
include/drm/drm.h
include/drm/drmP.h
include/drm/drm_crtc.h
include/drm/drm_hashtab.h
include/drm/drm_mm.h
include/drm/drm_mode.h
include/drm/drm_usb.h
include/drm/ttm/ttm_bo_driver.h
include/drm/ttm/ttm_page_alloc.h
include/linux/hid-roccat.h
include/linux/i2c-tegra.h
include/linux/i2c/atmel_mxt_ts.h
include/media/s5p_fimc.h
net/bluetooth/l2cap_core.c

I am pretty sure that git did not used to do this. Has anyone else seen
this?  I am running git version 1.7.4.1 from Debian unstable.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__24_Feb_2011_14_33_53_+1100_w0/Fqe2QEBudOY.Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNZdGhAAoJEDMEi1NhKgbsggcH/RSJ/BVzvVXz/AUaMaG1J3Ko
c9Y5LA5Uoegc/ZNHUO4gSCNAdGcu7Mk0TnErd7xdtH3uJsOHN0kNI9tFT8OL/Wjx
KZgcloAJrJv9UoLfA9xqcOtEMG02a0PAfw1pHP1eVL6wBG8TbZ3n9iD+OvT/RaAD
sxS2KlFAzDrqAqX67LW0i7CVpnP39+iQuKiJ+0ycY/P+vVi4pJ5kSnWAwF66bMBl
S7H8f5Os7EQEjWt3iMlsfdE9DpIWCwCMMiy259UMTql8QokHZEW+UIojdyjCUKYa
eSWXC+/zZGoGHQq2Lcj2BAn6r7C6MDAPDnP6APAiPGWfQri6s/aX9fG94TDKBy4=
=Ecpo
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Feb_2011_14_33_53_+1100_w0/Fqe2QEBudOY.Z--
