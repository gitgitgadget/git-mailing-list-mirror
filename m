From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Fri, 24 Aug 2012 11:45:24 +0200
Message-ID: <002e01cd81dd$2ffbd080$8ff37180$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Erik Faye-Lund" <kusmabite@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4qSb-00042x-0J
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758719Ab2HXJpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:45:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:64874 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758518Ab2HXJpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:45:41 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lc82v-1TU2Fk3p3t-00jYx8; Fri, 24 Aug 2012 11:45:34 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B3N3Lx3QEXop1QJeuCeNNx9/SoQ==
Content-Language: de
X-Provags-ID: V02:K0:JShne5KSj4Sp2Ydtw4RwGJxk7XC1DeZKAcmsW6vtFA5
 99YXft/dpmyd7/UwLIwAh6vcwNSOv4EcK5DlJtvMt/sGTCSdPv
 QWfm7k/REaP4ZUi+MXhSaMingRquRqZOaOOmDiyp/Wk75LAUOD
 MmvbvSKstO1ywqBx0gWJf6V+nzjcApbVWYfxpE68acyTeusR74
 vdSjYeKgfbz4U+ocDRtxNY2ANQ2YOcx8SdJ+RiaH1qz0OlBCDg
 8APkr2weTzVKcQD4mSSHIeVzmyjupVUtNfYxdegbtUcyTcmkzw
 7Wg/WUqFMGZGAWEap6ipopE2pAfFcFOiiTEuj8hb1TIKWIZ+gX
 HxlXN5ykOFY7X4swIi+0OGhPiEMP2iYyY8pGnfLtou7cgCiSw0
 isg8umPjXS5Tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204197>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
This time I hopefully didn't screw up whitespace and line breaks.

 Makefile            | 18 ++++++++++++++----
 compat/win32/poll.c |  8 ++++++--
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 66e8216..e150816 100644
--- a/Makefile
+++ b/Makefile
@@ -152,6 +152,11 @@ all::
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_SYS_POLL_H if you don't have sys/poll.h.
+#
+# Define NO_POLL if you do not have or do not want to use poll.
+# This also implies NO_SYS_POLL_H.
+#
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
@@ -1216,7 +1221,7 @@ ifeq ($(uname_S),Windows)
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
-	NO_SYS_POLL_H = YesPlease
+	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
@@ -1257,7 +1262,7 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H
-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/poll.o compat/win32/dirent.o
+		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32
-DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1312,7 +1317,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
-	NO_SYS_POLL_H = YesPlease
+	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
@@ -1347,7 +1352,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/poll.o compat/win32/dirent.o
+		compat/win32/dirent.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
@@ -1601,6 +1606,11 @@ ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
 endif
+ifdef NO_POLL
+	NO_SYS_POLL_H = YesPlease
+	COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it finds poll.h
+	COMPAT_OBJS += compat/win32/poll.o
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
diff --git a/compat/win32/poll.c b/compat/win32/poll.c
index 403eaa7..49541f1 100644
--- a/compat/win32/poll.c
+++ b/compat/win32/poll.c
@@ -24,7 +24,9 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif
 
-#include <malloc.h>
+#if defined(WIN32)
+# include <malloc.h>
+#endif
 
 #include <sys/types.h>
 
@@ -48,7 +50,9 @@
 #else
 # include <sys/time.h>
 # include <sys/socket.h>
-# include <sys/select.h>
+# ifndef NO_SYS_SELECT_H
+#  include <sys/select.h>
+# endif
 # include <unistd.h>
 #endif
 
-- 
1.7.12
