From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 12/15] mingw: use poll-emulation from gnulib
Date: Fri, 22 Oct 2010 02:05:41 +0200
Message-ID: <1287705944-5668-12-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCgq4PmBBoEQzPnjA@googlegroups.com Fri Oct 22 02:07:25 2010
Return-path: <msysgit+bncCOPdven-DxCgq4PmBBoEQzPnjA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCgq4PmBBoEQzPnjA@googlegroups.com>)
	id 1P95AG-0004SJ-UQ
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:20 +0200
Received: by mail-ww0-f58.google.com with SMTP id 28sf109548wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=PfGUsHfLk80lQGLEuxiv6GS4aHTQ2+oa0DHK76Gwzvw=;
        b=SHVntBrNR1lE4Zq7P9ajL9OhsRMFAJkmm0TXCBC0Gp6igxUPmbtE0yRu8bXTjy9zMI
         LzO0tr2QRSOUzFMBMgrp6l5ToWiVAU510GZsq5OqoNrKg7QcZ2V8juL7yeUzCLuRBt++
         p/frfR1qbiuJ7z/mzIS5MryuXF6oeyiOvcQvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=0ZbhYFW3ZcRngSw0pVcOoI5QVVjn8Fu+oQinsljFPJxvGv7R1KBauMgcTNH9N5LfeQ
         A4b53ogUR7zjtqp6qNCkiVOdij/du8RSyasVCGUWf25vw0CwA5M5kN37p6H3m6KkbDS4
         iff3hqbmG+wbz7zOg4I1ccBQQWf4Cl2YQ++5E=
Received: by 10.216.162.6 with SMTP id x6mr15702wek.0.1287706016601;
        Thu, 21 Oct 2010 17:06:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.25.20 with SMTP id y20ls269186eey.1.p; Thu, 21 Oct 2010
 17:06:55 -0700 (PDT)
Received: by 10.14.29.7 with SMTP id h7mr176974eea.24.1287706014885;
        Thu, 21 Oct 2010 17:06:54 -0700 (PDT)
Received: by 10.14.29.7 with SMTP id h7mr176973eea.24.1287706014867;
        Thu, 21 Oct 2010 17:06:54 -0700 (PDT)
Received: from mail-ew0-f54.google.com (mail-ew0-f54.google.com [209.85.215.54])
        by gmr-mx.google.com with ESMTP id q11si1424444eeh.4.2010.10.21.17.06.53;
        Thu, 21 Oct 2010 17:06:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.54 as permitted sender) client-ip=209.85.215.54;
Received: by ewy28 with SMTP id 28so215929ewy.41
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:53 -0700 (PDT)
Received: by 10.213.36.6 with SMTP id r6mr2527474ebd.15.1287706013732;
        Thu, 21 Oct 2010 17:06:53 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2461173eeh.17.2010.10.21.17.06.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.54 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159603>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                |    6 +++-
 compat/mingw.c          |   65 -----------------------------------------------
 compat/mingw.h          |   11 --------
 compat/win32/sys/poll.c |    3 +-
 git-compat-util.h       |    2 +-
 5 files changed, 6 insertions(+), 81 deletions(-)

diff --git a/Makefile b/Makefile
index 2aa067a..46034bf 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,7 @@ LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
+LIB_H += compat/win32/sys/poll.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -1082,7 +1083,7 @@ ifeq ($(uname_S),Windows)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/win32/sys/poll.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1132,7 +1133,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
-		compat/win32/pthread.o compat/win32/syslog.o
+		compat/win32/pthread.o compat/win32/syslog.o \
+		compat/win32/sys/poll.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/mingw.c b/compat/mingw.c
index d88c0d0..b780200 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -408,71 +408,6 @@ int pipe(int filedes[2])
 	return 0;
 }
 
-int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
-{
-	int i, pending;
-
-	if (timeout >= 0) {
-		if (nfds == 0) {
-			Sleep(timeout);
-			return 0;
-		}
-		return errno = EINVAL, error("poll timeout not supported");
-	}
-
-	/* When there is only one fd to wait for, then we pretend that
-	 * input is available and let the actual wait happen when the
-	 * caller invokes read().
-	 */
-	if (nfds == 1) {
-		if (!(ufds[0].events & POLLIN))
-			return errno = EINVAL, error("POLLIN not set");
-		ufds[0].revents = POLLIN;
-		return 0;
-	}
-
-repeat:
-	pending = 0;
-	for (i = 0; i < nfds; i++) {
-		DWORD avail = 0;
-		HANDLE h = (HANDLE) _get_osfhandle(ufds[i].fd);
-		if (h == INVALID_HANDLE_VALUE)
-			return -1;	/* errno was set */
-
-		if (!(ufds[i].events & POLLIN))
-			return errno = EINVAL, error("POLLIN not set");
-
-		/* this emulation works only for pipes */
-		if (!PeekNamedPipe(h, NULL, 0, NULL, &avail, NULL)) {
-			int err = GetLastError();
-			if (err == ERROR_BROKEN_PIPE) {
-				ufds[i].revents = POLLHUP;
-				pending++;
-			} else {
-				errno = EINVAL;
-				return error("PeekNamedPipe failed,"
-					" GetLastError: %u", err);
-			}
-		} else if (avail) {
-			ufds[i].revents = POLLIN;
-			pending++;
-		} else
-			ufds[i].revents = 0;
-	}
-	if (!pending) {
-		/* The only times that we spin here is when the process
-		 * that is connected through the pipes is waiting for
-		 * its own input data to become available. But since
-		 * the process (pack-objects) is itself CPU intensive,
-		 * it will happily pick up the time slice that we are
-		 * relinquishing here.
-		 */
-		Sleep(0);
-		goto repeat;
-	}
-	return 0;
-}
-
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
 	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
diff --git a/compat/mingw.h b/compat/mingw.h
index 51fca2f..99a7467 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -59,16 +59,6 @@ struct passwd {
 
 extern char *getpass(const char *prompt);
 
-#ifndef POLLIN
-struct pollfd {
-	int fd;           /* file descriptor */
-	short events;     /* requested events */
-	short revents;    /* returned events */
-};
-#define POLLIN 1
-#define POLLHUP 2
-#endif
-
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
 	sig_handler_t sa_handler;
@@ -175,7 +165,6 @@ int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
-int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
index 7c52cb6..c1ca0d2 100644
--- a/compat/win32/sys/poll.c
+++ b/compat/win32/sys/poll.c
@@ -24,8 +24,7 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif
 
-#include <config.h>
-#include <alloca.h>
+#include <malloc.h>
 
 #include <sys/types.h>
 #include "poll.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 56dce85..d0a1e48 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -105,9 +105,9 @@
 #include <regex.h>
 #include <utime.h>
 #include <syslog.h>
+#include <sys/poll.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
-#include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
-- 
1.7.3.1.199.g72340
