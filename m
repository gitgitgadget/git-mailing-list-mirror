From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 20:15:04 +0100
Message-ID: <20050710201504.A22477@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk> <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org> <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk> <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net> <20050710134624.B3279@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 21:17:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrhJ7-0004aw-8e
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 21:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGJTRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jul 2005 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVGJTRA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 15:17:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261161AbVGJTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 15:15:11 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrhGd-0001Nc-4B; Sun, 10 Jul 2005 20:15:07 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrhGb-0006JE-5r; Sun, 10 Jul 2005 20:15:05 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org>; from torvalds@osdl.org on Sun, Jul 10, 2005 at 09:51:16AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2005 at 09:51:16AM -0700, Linus Torvalds wrote:
> On Sun, 10 Jul 2005, Russell King wrote:
> > It means that rsync --delete-after can (in theory) be used when
> > making changes available to the upstream maintainer.
>=20
> I'd suggest against that from a safety standpoint (no backups), but w=
hat=20
> you _can_ do is to upload only the objects I don't have.=20
>=20
> This actually works - I already synced several weeks ago with Paul=20
> Mackerras, who had made his ppc64 git thing contain only the objects =
that=20
> I didn't have.

Ok, let's give this a go then.  However, I'm not confident in this
working, especially after seeing the output of git-fsck-cache --full...
and I've no idea _why_ it's complaining.

I've pushed this (partial) tree out to
master.kernel.org:~rmk/linux-2.6-arm.git

Below is the usual mail.

$ export | grep GIT_
declare -x GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"/home/rmk/git/linux-2.6/=
=2Egit/objects"
$ git-fsck-cache --full
error: cannot read sha1_file for 0084227438c28d26bc2d089b1facc4675310f7=
41
bad sha1 entry '0084227438c28d26bc2d089b1facc4675310f741'
error: cannot read sha1_file for 008c1ddc1fc2854b64fcb49a40f1c933d116fb=
5c
bad sha1 entry '008c1ddc1fc2854b64fcb49a40f1c933d116fb5c'
=2E..
error: cannot read sha1_file for 83c28d2c90fe720b5a315b89301cf3a519ffed=
88
bad sha1 entry '83c28d2c90fe720b5a315b89301cf3a519ffed88'
dangling commit 043d051615aa5da09a7e44f1edbb69798458e067
dangling commit a92b7b80579fe68fe229892815c750f6652eb6a9
$ grep . .git/refs/heads/*
=2Egit/refs/heads/master:ec6bced6c7b92904f5ead39c9c1b8dc734e6eff0
=2Egit/refs/heads/origin:f179bc77d09b9087bfc559d0368bba350342ac76
=2Egit/refs/heads/smp:053a7b5b7617a72d7c61b6f84196d1c0f79b9849
$ cd $GIT_ALTERNATE_OBJECT_DIRECTORIES/../..
$ git-fsck-cache --full
$=20

Could this be because cogito doesn't know how to handle this setup
properly yet?  Have I just destroyed my git tree by trying to apply
stuff to it?

---

Linus, Andrew,

Please incorporate the latest ARM changes, which can be found at:

	master.kernel.org:/home/rmk/linux-2.6-arm.git

This will update the following files:

 arch/arm/mach-omap/Kconfig              |  221 -----
 arch/arm/mach-omap/Makefile             |   40=20
 arch/arm/mach-omap/Makefile.boot        |    4=20
 arch/arm/mach-omap/board-generic.c      |  100 --
 arch/arm/mach-omap/board-h2.c           |  189 ----
 arch/arm/mach-omap/board-h3.c           |  207 -----
 arch/arm/mach-omap/board-innovator.c    |  282 ------
 arch/arm/mach-omap/board-netstar.c      |  153 ---
 arch/arm/mach-omap/board-osk.c          |  171 ----
 arch/arm/mach-omap/board-perseus2.c     |  191 ----
 arch/arm/mach-omap/board-voiceblue.c    |  258 ------
 arch/arm/mach-omap/clock.c              | 1076 -----------------------=
---
 arch/arm/mach-omap/clock.h              |  112 --
 arch/arm/mach-omap/common.c             |  549 -------------
 arch/arm/mach-omap/common.h             |   36=20
 arch/arm/mach-omap/dma.c                | 1086 -----------------------=
---
 arch/arm/mach-omap/fpga.c               |  188 ----
 arch/arm/mach-omap/gpio.c               |  762 ------------------
 arch/arm/mach-omap/irq.c                |  219 -----
 arch/arm/mach-omap/leds-h2p2-debug.c    |  144 ---
 arch/arm/mach-omap/leds-innovator.c     |  103 --
 arch/arm/mach-omap/leds-osk.c           |  198 ----
 arch/arm/mach-omap/leds.c               |   61 -
 arch/arm/mach-omap/leds.h               |    3=20
 arch/arm/mach-omap/mcbsp.c              |  685 ----------------
 arch/arm/mach-omap/mux.c                |  163 ---
 arch/arm/mach-omap/ocpi.c               |  114 --
 arch/arm/mach-omap/pm.c                 |  632 ---------------
 arch/arm/mach-omap/sleep.S              |  314 -------
 arch/arm/mach-omap/time.c               |  424 ----------
 arch/arm/mach-omap/usb.c                |  593 --------------
 arch/arm/Kconfig                        |    6=20
 arch/arm/Makefile                       |    6=20
 arch/arm/configs/enp2611_defconfig      |   20=20
 arch/arm/configs/ixdp2400_defconfig     |   20=20
 arch/arm/configs/ixdp2401_defconfig     |   20=20
 arch/arm/configs/ixdp2800_defconfig     |   20=20
 arch/arm/configs/ixdp2801_defconfig     |   20=20
 arch/arm/configs/omap_h2_1610_defconfig |  117 +-
 arch/arm/mach-ixp2000/core.c            |   55 -
 arch/arm/mach-ixp2000/enp2611.c         |    1=20
 arch/arm/mach-ixp2000/ixdp2x00.c        |    1=20
 arch/arm/mach-ixp2000/ixdp2x01.c        |    1=20
 arch/arm/mach-omap1/Kconfig             |  144 +++
 arch/arm/mach-omap1/Makefile            |   30=20
 arch/arm/mach-omap1/Makefile.boot       |    3=20
 arch/arm/mach-omap1/board-generic.c     |   99 ++
 arch/arm/mach-omap1/board-h2.c          |  188 ++++
 arch/arm/mach-omap1/board-h3.c          |  206 ++++
 arch/arm/mach-omap1/board-innovator.c   |  281 ++++++
 arch/arm/mach-omap1/board-netstar.c     |  152 +++
 arch/arm/mach-omap1/board-osk.c         |  170 ++++
 arch/arm/mach-omap1/board-perseus2.c    |  190 ++++
 arch/arm/mach-omap1/board-voiceblue.c   |  257 ++++++
 arch/arm/mach-omap1/fpga.c              |  188 ++++
 arch/arm/mach-omap1/id.c                |  188 ++++
 arch/arm/mach-omap1/io.c                |  115 ++
 arch/arm/mach-omap1/irq.c               |  234 +++++
 arch/arm/mach-omap1/leds-h2p2-debug.c   |  144 +++
 arch/arm/mach-omap1/leds-innovator.c    |  103 ++
 arch/arm/mach-omap1/leds-osk.c          |  194 ++++
 arch/arm/mach-omap1/leds.c              |   61 +
 arch/arm/mach-omap1/leds.h              |    3=20
 arch/arm/mach-omap1/serial.c            |  200 ++++
 arch/arm/mach-omap1/time.c              |  436 ++++++++++
 arch/arm/mm/Kconfig                     |    2=20
 arch/arm/mm/mm-armv.c                   |    4=20
 arch/arm/plat-omap/Kconfig              |  112 ++
 arch/arm/plat-omap/Makefile             |   17=20
 arch/arm/plat-omap/clock.c              | 1323 +++++++++++++++++++++++=
+++++++++
 arch/arm/plat-omap/clock.h              |  120 ++
 arch/arm/plat-omap/common.c             |  135 +++
 arch/arm/plat-omap/cpu-omap.c           |  128 +++
 arch/arm/plat-omap/dma.c                | 1116 +++++++++++++++++++++++=
+++
 arch/arm/plat-omap/gpio.c               |  762 ++++++++++++++++++
 arch/arm/plat-omap/mcbsp.c              |  758 ++++++++++++++++++
 arch/arm/plat-omap/mux.c                |  160 +++
 arch/arm/plat-omap/ocpi.c               |  114 ++
 arch/arm/plat-omap/pm.c                 |  632 +++++++++++++++
 arch/arm/plat-omap/sleep.S              |  314 +++++++
 arch/arm/plat-omap/usb.c                |  593 ++++++++++++++
 include/asm-arm/arch-ixp2000/platform.h |    1=20
 include/asm-arm/arch-omap/board-h2.h    |    5=20
 include/asm-arm/arch-omap/board-h3.h    |    5=20
 include/asm-arm/arch-omap/board-osk.h   |    5=20
 include/asm-arm/arch-omap/board.h       |   12=20
 include/asm-arm/arch-omap/common.h      |   36=20
 include/asm-arm/arch-omap/dma.h         |    1=20
 include/asm-arm/arch-omap/hardware.h    |   24=20
 include/asm-arm/arch-omap/irqs.h        |    3=20
 include/asm-arm/arch-omap/mux.h         |   28=20
 include/asm-arm/arch-omap/omap16xx.h    |   32=20
 include/asm-arm/arch-omap/system.h      |   21=20
 93 files changed, 10164 insertions(+), 9450 deletions(-)

through these changes:

=46rom: Tony Lindgren: Sun Jul 10 19:58:20 BST 2005
=09
	[PATCH] ARM: 2803/1: OMAP update 11/11: Add cpufreq support
=09
	Patch from Tony Lindgren
=09
	This patch adds minimal cpufreq support for OMAP
	taking advantage of the clock framework.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:19 BST 2005
=09
	[PATCH] ARM: 2805/1: OMAP update 10/11: Update H2 defconfig
=09
	Patch from Tony Lindgren
=09
	This patch updates H2 defconfig.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:18 BST 2005
=09
	[PATCH] ARM: 2804/1: OMAP update 9/11: Update OMAP arch files
=09
	Patch from Tony Lindgren
=09
	This patch by various OMAP developers syncs the OMAP
	specific arch files with the linux-omap tree.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:17 BST 2005
=09
	[PATCH] ARM: 2802/1: OMAP update 8/11: Update OMAP arch files
=09
	Patch from Tony Lindgren
=09
	This patch by various OMAP developers syncs the OMAP
	specific arch files with the linux-omap tree.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:15 BST 2005
=09
	[PATCH] ARM: 2812/1: OMAP update 7c/11: Move arch-omap to plat-omap
=09
	Patch from Tony Lindgren
=09
	This patch move common OMAP code from arch-omap to plat-omap
	directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:14 BST 2005
=09
	[PATCH] ARM: 2809/1: OMAP update 7b/11: Move arch-omap to plat-omap
=09
	Patch from Tony Lindgren
=09
	This patch move common OMAP code from arch-omap to plat-omap
	directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:13 BST 2005
=09
	[PATCH] ARM: 2807/1: OMAP update 7a/11: Move arch-omap to plat-omap
=09
	Patch from Tony Lindgren
=09
	This patch move common OMAP code from arch-omap to plat-omap
	directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:12 BST 2005
=09
	[PATCH] ARM: 2801/1: OMAP update 6/11: Split OMAP1 common code into id=
, io and serial
=09
	Patch from Tony Lindgren
=09
	This patch by Juha Yrj=C3=B6l=C3=A4 and other OMAP developers splits
	OMAP1 specific common code into OMAP1 id, io, and serial
	code in mach-omap1 directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:11 BST 2005
=09
	[PATCH] ARM: 2806/1: OMAP update 5/11: Move board files into mach-omap=
1 directory
=09
	Patch from Tony Lindgren
=09
	This patch by Paul Mundt and other OMAP developers
	moves OMAP1 board files into mach-omap1 directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:10 BST 2005
=09
	[PATCH] ARM: 2799/1: OMAP update 4/11: Move OMAP1 LED code into mach-o=
map1 directory
=09
	Patch from Tony Lindgren
=09
	This patch by Paul Mundt and other OMAP developers
	moves OMAP1 specific LED code into mach-omap1 directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:09 BST 2005
=09
	[PATCH] ARM: 2800/1: OMAP update 3/11: Move OMAP1 core code into mach-=
omap1 directory
=09
	Patch from Tony Lindgren
=09
	This patch by Paul Mundt and other OMAP developers
	moves OMAP1 specific IRQ, time, and FPGA code into
	mach-omap1 directory.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:08 BST 2005
=09
	[PATCH] ARM: 2798/1: OMAP update 2/11: Change ARM Kconfig to support o=
map1 and omap2
=09
	Patch from Tony Lindgren
=09
	This patch by Paul Mundt and other OMAP developers modifies
	ARM specific Kconfig to allow sharing code between OMAP1 and
	OMAP2 architectures.
	In order to share code between OMAP1 and OMAP2, all OMAP1
	specific code is moved into mach-omap1 directory in the
	following patch. A new mach-omap2 directory will be added
	later on.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Tony Lindgren: Sun Jul 10 19:58:06 BST 2005
=09
	[PATCH] ARM: 2797/1: OMAP update 1/11: Update include files
=09
	Patch from Tony Lindgren
=09
	This patch by various OMAP developers syncs the OMAP
	specific include files with the linux-omap tree.
=09
	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Deepak Saxena: Sun Jul 10 19:44:55 BST 2005
=09
	[PATCH] ARM: 2796/1: Fix ARMv5[TEJ] check in MMU initalization
=09
	Patch from Deepak Saxena
=09
	The code in mm-armv.c checks for the condition (cpu_architecture()<=3D=
 ARMv5)
	in a few places but should be checking for ARMv5TEJ as the MMU is shar=
ed
	across all v5 variations.
=09
	Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Lennert Buytenhek: Sun Jul 10 19:44:54 BST 2005
=09
	[PATCH] ARM: 2795/1: update ixp2000 defconfigs
=09
	Patch from Lennert Buytenhek
=09
	Update the ixp2000 defconfigs from 2.6.12-git6 to 2.6.13-rc2.
=09
	Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

=46rom: Lennert Buytenhek: Sun Jul 10 19:44:53 BST 2005
=09
	[PATCH] ARM: 2793/1: platform serial support for ixp2000
=09
	Patch from Lennert Buytenhek
=09
	This patch converts the ixp2000 serial port over to a platform
	serial device.
=09
	Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
	Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>



--=20
Russell King
