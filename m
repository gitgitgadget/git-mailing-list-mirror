From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/5] config.mak.uname: support MSys2
Date: Wed, 13 Jan 2016 14:30:53 +0100 (CET)
Message-ID: <e63d391a79396e095d2ebb139bb44c390e50bb62.1452691805.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:31:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLWd-0002jV-FV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbcAMNbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:31:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:52389 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758871AbcAMNbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:31:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0McVKy-1aasOc2SOG-00Hgei; Wed, 13 Jan 2016 14:30:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pnfp/lDCbLCMfPefwaQh8WNS4lnN9Q4qsYSr8fLnZQ3yS9T0Mhy
 6xrKXP0xe1yDwjMU89zf4e79gMnqNxQY8OP3c0KMnQl4RMhpvQ4q8FQQ6v9I32QilaD1++p
 3fpsE64+qcTo4Jgn+GCAkUAlTv2GUT5G0IZcWngeSS0bvrIjMO+vwwjuk8Agdsf0mKg1UaL
 o/NpBqgrpdSXRr5FO2ZmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pTILZKMkKO8=:j5/knRbdp1/8wUSaIVje8F
 3vUMLyD+msGgKKIv6VZvj7awGz/2owCPRivoPP0tY73xJrHm75q+qiWk+igLOxwuyosABICBv
 KK0STCUbT9HbNHvq5YrngD6Q+OIcrvlldoyMRAPnq6lOQKgf+SuRkgSTqCiv5UTOcQbyaxSee
 Qrgc69n5cs5UkdAgy9V28tHX0noOu6eISXjHLrxwTbWtQDovAmo2Wdu/BU1DTncTdK5IZCyJS
 JByMzcHRoOxW+iQGuNZdUV105MAbPR1UxbzbpurvSmobgLbjLu2EhijuLU+jxixapDiuVCgos
 o+swsFiHwLsb827AAykBn2sV7dxMdSfX0q1F18z0W1CmO/+aWIDXWdugOOsHGzVrRFY092oOL
 mOT6QsiwUOxHfeaPOtDEwlmnqr/N4A8n7D9zBeowwCuuntRYJnbb9203XJsNW/00jeSJNX1tK
 yJ9g8lxFn6i1pSXg+505gNCC7lb2TY2kXuZQwKytVF7n6Mi6tlVbGMKDWzqVoLUgqXFenR/rk
 kjyhFw5YLn3GQsxHHqAg8Xg1XgLC9fxppnYAeRRW2iG1RhcJUUw7wZX5PMXxYdJUgd7kX3YW3
 VNK6IM9zU8/BWYIR1SqFv1Bk4t/ymWxxsDc+FdOaJ+hPm4s0oloXitGpoEp2Rfw6rAW5inWa2
 OBBtoHeRUUoqiWVy1DuS3iI4d5FGN9oFXiedftIac8Gp33SaG1yiwuyWNz6q1tB8G0V0HR8vw
 LdS9oulAGsjj755bQzxwLkjDBKpfNP2P2TySie0fDdPG8fNFMlD8A186XJLn36eMFqXdm26i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283918>

For a long time, Git for Windows lagged behind Git's 2.x releases because
the Git for Windows developers wanted to let that big jump coincide with
a well-needed jump away from MSys to MSys2.

To understand why this is such a big issue, it needs to be noted that
many parts of Git are not written in portable C, but instead Git relies
on a POSIX shell and Perl to be available.

To support the scripts, Git for Windows has to ship a minimal POSIX
emulation layer with Bash and Perl thrown in, and when the Git for
Windows effort started in August 2007, this developer settled on using
MSys, a stripped down version of Cygwin. Consequently, the original name
of the project was "msysGit" (which, sadly, caused a *lot* of confusion
because few Windows users know about MSys, and even less care).

To compile the C code of Git for Windows, MSys was used, too: it sports
two versions of the GNU C Compiler: one that links implicitly to the
POSIX emulation layer, and another one that targets the plain Win32 API
(with a few convenience functions thrown in).  Git for Windows'
executables are built using the latter, and therefore they are really
just Win32 programs. To discern executables requiring the POSIX
emulation layer from the ones that do not, the latter are called MinGW
(Minimal GNU for Windows) when the former are called MSys executables.

This reliance on MSys incurred challenges, too, though: some of our
changes to the MSys runtime -- necessary to support Git for Windows
better -- were not accepted upstream, so we had to maintain our own
fork. Also, the MSys runtime was not developed further to support e.g.
UTF-8 or 64-bit, and apart from lacking a package management system
until much later (when mingw-get was introduced), many packages provided
by the MSys/MinGW project lag behind the respective source code
versions, in particular Bash and OpenSSL. For a while, the Git for
Windows project tried to remedy the situation by trying to build newer
versions of those packages, but the situation quickly became untenable,
especially with problems like the Heartbleed bug requiring swift action
that has nothing to do with developing Git for Windows further.

Happily, in the meantime the MSys2 project (https://msys2.github.io/)
emerged, and was chosen to be the base of the Git for Windows 2.x. Just
like MSys, MSys2 is a stripped down version of Cygwin, but it is
actively kept up-to-date with Cygwin's source code.  Thereby, it already
supports Unicode internally, and it also offers the 64-bit support that
we yearned for since the beginning of the Git for Windows project.

MSys2 also ported the Pacman package management system from Arch Linux
and uses it heavily. This brings the same convenience to which Linux
users are used to from `yum` or `apt-get`, and to which MacOSX users are
used to from Homebrew or MacPorts, or BSD users from the Ports system,
to MSys2: a simple `pacman -Syu` will update all installed packages to
the newest versions currently available.

MSys2 is also *very* active, typically providing package updates
multiple times per week.

It still required a two-month effort to bring everything to a state
where Git's test suite passes, many more months until the first official
Git for Windows 2.x was released, and a couple of patches still await
their submission to the respective upstream projects. Yet without MSys2,
the modernization of Git for Windows would simply not have happened.

This commit lays the ground work to supporting MSys2-based Git builds.

Assisted-by: Waldek Maleska <weakcamel@users.github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index f34dcaa..b0592c1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,7 +518,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
@@ -541,8 +541,25 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
+	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
 else
-	NO_CURL = YesPlease
+	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
+		# MSys2
+		CC = gcc
+		prefix = /mingw32
+		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0
+		INSTALL = /bin/install
+		NO_R_TO_GCC_LINKER = YesPlease
+		INTERNAL_QSORT = YesPlease
+		HAVE_LIBCHARSET_H = YesPlease
+		NO_GETTEXT = YesPlease
+		USE_LIBPCRE= YesPlease
+		NO_CURL =
+		USE_NED_ALLOCATOR = YesPlease
+	else
+		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
+		NO_CURL = YesPlease
+	endif
 endif
 endif
 ifeq ($(uname_S),QNX)
-- 
2.6.3.windows.1.300.g1c25e49
