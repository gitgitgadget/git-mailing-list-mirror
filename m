From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 13/16] mingw: use poll-emulation from gnulib
Date: Wed,  3 Nov 2010 17:31:31 +0100
Message-ID: <1288801894-1168-14-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGW-0002aC-Mb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762Ab0KCQcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0KCQcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:17 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xbuYPpgz2jgp+JVIj4n3Fof0+5bgZyM04HxLUmc0380=;
        b=t36JAwF0UTJqKT5DssNxrqI7xICda+TQKFvsvusyfVhTt58/ak0bo+OR4RQUTrH6VS
         ZgJ6M9tfT4HtqMkUWQdMUpwHd7iCtYvImGquxkoqTgVolln6aEpYAIwOPmWwe7j0YmdC
         MIKUhVDm6uHqv8Uc3vlCP1SxFdu2zhuwbS8dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d+dKAgDD2jkXAXCPViZOlTKM8XK38RhDhhMo21lZx1c7+eAOZ4vOVokel0+bT2jdRx
         rIE16QbXFvdluhTi2NTIVpCYKPXxraEdm9LeQdbfytkpa6l1wynAJxnYu7fVd0nThieB
         axkKd9YyJpUKn/1rkcF2PtcmbRuyq9wL/W+zo=
Received: by 10.213.105.148 with SMTP id t20mr4663701ebo.30.1288801936669;
        Wed, 03 Nov 2010 09:32:16 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id q58sm6704580eeh.9.2010.11.03.09.32.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160617>

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
1.7.3.2.161.gd6e00
