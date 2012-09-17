From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v6 1/4] make poll available for other platforms lacking it
Date: Mon, 17 Sep 2012 08:53:26 +0200
Message-ID: <k36hdm$kti$1@ger.gmane.org>
References: <k36h3i$ihb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 08:54:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDVDe-0008WE-GD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 08:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab2IQGxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 02:53:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:54382 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab2IQGxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 02:53:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TDVDQ-0008OF-2X
	for git@vger.kernel.org; Mon, 17 Sep 2012 08:53:56 +0200
Received: from dsdf-4db53772.pool.mediaways.net ([77.181.55.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 08:53:56 +0200
Received: from jojo by dsdf-4db53772.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 08:53:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53772.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205658>

move poll.[ch] out of compat/win32/ into compat/poll/ and adjust
Makefile with the changed paths. Adding comments to Makefile about how/when
to enable it and add logic for this

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 Makefile                      | 20 +++++++++++++++-----
 compat/{win32 => poll}/poll.c |  0
 compat/{win32 => poll}/poll.h |  0
 3 files changed, 15 insertions(+), 5 deletions(-)
 rename compat/{win32 => poll}/poll.c (100%)
 rename compat/{win32 => poll}/poll.h (100%)

diff --git a/Makefile b/Makefile
index ac49320..7893297 100644
--- a/Makefile
+++ b/Makefile
@@ -152,6 +152,11 @@ all::
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_SYS_POLL_H if you don't have sys/poll.h.
+#
+# Define NO_POLL if you do not have or don't want to use poll().
+# This also implies NO_SYS_POLL_H.
+#
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
@@ -598,10 +603,10 @@ LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
+LIB_H += compat/poll/poll.h
 LIB_H += compat/precompose_utf8.h
 LIB_H += compat/terminal.h
 LIB_H += compat/win32/dirent.h
-LIB_H += compat/win32/poll.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += connected.h
@@ -1220,7 +1225,7 @@ ifeq ($(uname_S),Windows)
  NO_PREAD = YesPlease
  NEEDS_CRYPTO_WITH_SSL = YesPlease
  NO_LIBGEN_H = YesPlease
- NO_SYS_POLL_H = YesPlease
+ NO_POLL_H = YesPlease
  NO_SYMLINK_HEAD = YesPlease
  NO_IPV6 = YesPlease
  NO_UNIX_SOCKETS = YesPlease
@@ -1261,7 +1266,7 @@ ifeq ($(uname_S),Windows)
  BASIC_CFLAGS 
= -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE 
 -DHAVE_STRING_H
-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
  COMPAT_OBJS = compat/msvc.o compat/winansi.o \
   compat/win32/pthread.o compat/win32/syslog.o \
-  compat/win32/poll.o compat/win32/dirent.o
+  compat/win32/dirent.o
  COMPAT_CFLAGS 
= -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex 
 -Icompat/win32
-DSTRIP_EXTENSION=\".exe\"
  BASIC_LDFLAGS 
= -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
  EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1316,7 +1321,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
  NO_PREAD = YesPlease
  NEEDS_CRYPTO_WITH_SSL = YesPlease
  NO_LIBGEN_H = YesPlease
- NO_SYS_POLL_H = YesPlease
+ NO_POLL_H = YesPlease
  NO_SYMLINK_HEAD = YesPlease
  NO_UNIX_SOCKETS = YesPlease
  NO_SETENV = YesPlease
@@ -1351,7 +1356,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
  COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
  COMPAT_OBJS += compat/mingw.o compat/winansi.o \
   compat/win32/pthread.o compat/win32/syslog.o \
-  compat/win32/poll.o compat/win32/dirent.o
+  compat/win32/dirent.o
  EXTLIBS += -lws2_32
  PTHREAD_LIBS =
  X = .exe
@@ -1605,6 +1610,11 @@ ifdef NO_GETTEXT
  BASIC_CFLAGS += -DNO_GETTEXT
  USE_GETTEXT_SCHEME ?= fallthrough
 endif
+ifdef NO_POLL
+ NO_SYS_POLL_H = YesPlease
+ COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
+ COMPAT_OBJS += compat/poll/poll.o
+endif
 ifdef NO_STRCASESTR
  COMPAT_CFLAGS += -DNO_STRCASESTR
  COMPAT_OBJS += compat/strcasestr.o
diff --git a/compat/win32/poll.c b/compat/poll/poll.c
similarity index 100%
rename from compat/win32/poll.c
rename to compat/poll/poll.c
diff --git a/compat/win32/poll.h b/compat/poll/poll.h
similarity index 100%
rename from compat/win32/poll.h
rename to compat/poll/poll.h
-- 
1.7.12 
