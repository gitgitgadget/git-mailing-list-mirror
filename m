From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 09/12] MINGW: config.mak.uname: drop -DNOGDI
Date: Mon, 28 Apr 2014 17:51:34 +0400
Message-ID: <1398693097-24651-10-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Welyq-00040P-3i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbaD1NwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:52:04 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56337 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaD1Nvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:55 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyK-0004qo-NA; Mon, 28 Apr 2014 17:51:53 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247332>

On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.

Unfortunately, including wingdi.h brings in #define ERROR 0 which
conflicts with several Git internal enums. So, #undef ERROR.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname  | 4 ++--
 git-compat-util.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index a376b32..4883fd5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -363,7 +363,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
@@ -503,7 +503,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
diff --git a/git-compat-util.h b/git-compat-util.h
index aa57a04..48bf0f7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -98,6 +98,8 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+/* wingdi.h defines ERROR=0, undef it to avoid conflicts */
+#undef ERROR
 #define GIT_WINDOWS_NATIVE
 #endif
 
-- 
1.9.1
