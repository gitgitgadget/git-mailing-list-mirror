From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/5] config.mak.uname: support MSys2
Date: Thu, 14 Jan 2016 17:51:22 +0100 (CET)
Message-ID: <e63d391a79396e095d2ebb139bb44c390e50bb62.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl7U-0004cD-8y
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbcANQv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:51:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:53072 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbcANQv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:51:26 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lf0M7-1Zp80S2EyF-00qhxX; Thu, 14 Jan 2016 17:51:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0CD5EeAygtYyl9SS30F/bmTHA5l5B+cesYi9tdv1dlhqSRvX0NQ
 unuR8yvnSO0hRMWPcnzdqjylXaZtD8dftiexCUuCvwODugLN47EjhMYZmN1Nm2VSin7brgH
 Yopi7ZrxF+t+XaP981vPu5S7KlSM3FDAiO27HlMGK0vQdsslYTR5rkEXVdYgl88fiCVObS1
 Mx+XdwWScg6F/3yzJ6QBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mcqm0zI/39E=:H0+kHZ9ZGKKKKqzImPsWQu
 DplZXY18VZY+gpR7VQmWDrFUsPE9besk9FshjG/0upG+ml2/FZxP6LjYvijtcmGQlsCUlrVeJ
 b9pbwQYC5yvXSf7kfr5O7ERyGzBZyku+P9JfzC9m/KR1DD3XN20tIgaRoo8CJ/RFkGt1nREvB
 tHOwJdl/p6QPWJ6Pb8hXKDAUi/kkCrYPWLk7j7WFq+xn+5HsRupD+zcY5fsvxosc1ReFYnCe9
 Ax99ErpxRNPTEhhku3nLkhY7HEhD5Yz0DbAbcgbE6aC7z/PYjlrFKR6KnLuFwWrV/QpFYb9bk
 nShfnbXoyiANCJv8wVDtS9t2vYWClhHjEF5mfyelbVyD7ntn63bCBAAK2nMTlbT431poHfrRF
 MqS6Dr6J/d0/SeDhe3TSs8k91OzzvkbBj94nI27Gg35WD6belKP2mCgFS+McnUBJX87cvfl3N
 VyGc+qV/p2nb+bvGlcnqEgtZKh6ZHJml45nkE9J0auZCVNNRCX37k0+3bWxMd3iXwCGmC9VVg
 +msZSb7mfVmIsV0LYEC8LlM6B6EVppQ2QCDqc16+dKH5i31Zn9IbpBQSxpUo1+a0HON2dP7VP
 /9nCy19K5f5NA/mJSo1TK0wTOmzDrkunK/dLjATi2lFVpNY/UCjfl7w9ZD/PUtTo6QMAh9o8J
 Sn+/PNf4MtgVNI3r4Fbu56Y3EXDvrTf89S9njxsYZFDYGYqGHTPmrqziRPmqqod84/2gOh0I8
 KrXl6esrnx9+jKuxPlYq5ycYJlusYl1jqyoOZzGa89iQFzXENreJl2FswgCDlNG605Tsnw4k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284060>

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
2.7.0.windows.1.7.g55a05c8
