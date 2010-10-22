From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 02/16] mingw: implement syslog
Date: Fri, 22 Oct 2010 02:35:13 +0200
Message-ID: <1287707727-5780-3-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com,
	Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCCuYPmBBoERS3JCg@googlegroups.com Fri Oct 22 02:36:46 2010
Return-path: <msysgit+bncCOPdven-DxCCuYPmBBoERS3JCg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCCuYPmBBoERS3JCg@googlegroups.com>)
	id 1P95cg-0002V4-Qm
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:42 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=PNuGi9oZrPwPMOxoAto642ADE8fbbDt47d2tO2O+9T0=;
        b=Oo8+yUs/0hRC6GsR2KCmxtmNo64XeQvacwCn6m9RQfaHlaL81+2yxnZad0leyuO3xO
         0WSrjob2jzwrlKnDucure5CK77gFHH4Jqwaq3VYNEi9uJZP4azrU8otPVDwW4II1/s5G
         WHfNnjnIHPweXmPjKtHdUdyLp3FM1+mgqyv78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=HdyDv6dXJTHqQWBXrxvHx9IzOgRTbZfhnBlbObFCl/0wsuPVw2nq3m/RU00DgLhI2p
         JheLWP0ROr5aIfWFOglZmwKAQB/8AVJUPMpJgTxqH6MRHuBz/lJBy4eeHGlny8drXIMT
         mrIxXBey0zx2PgeFwIYev/UrvcYuj93Q++cls=
Received: by 10.216.240.140 with SMTP id e12mr286702wer.15.1287707778916;
        Thu, 21 Oct 2010 17:36:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.10.153 with SMTP id 25ls270796eev.3.p; Thu, 21 Oct 2010
 17:36:18 -0700 (PDT)
Received: by 10.14.47.193 with SMTP id t41mr153461eeb.17.1287707778106;
        Thu, 21 Oct 2010 17:36:18 -0700 (PDT)
Received: by 10.14.47.193 with SMTP id t41mr153460eeb.17.1287707778088;
        Thu, 21 Oct 2010 17:36:18 -0700 (PDT)
Received: from mail-ew0-f53.google.com (mail-ew0-f53.google.com [209.85.215.53])
        by gmr-mx.google.com with ESMTP id q11si1451301eeh.4.2010.10.21.17.36.17;
        Thu, 21 Oct 2010 17:36:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender) client-ip=209.85.215.53;
Received: by mail-ew0-f53.google.com with SMTP id 10so190969ewy.12
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:17 -0700 (PDT)
Received: by 10.213.19.19 with SMTP id y19mr2544974eba.33.1287707776965;
        Thu, 21 Oct 2010 17:36:16 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2483035eeh.14.2010.10.21.17.36.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159614>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so implement our own using
Window's ReportEvent mechanism.

Strings containing "%1" gets expanded into them selves by ReportEvent,
resulting in an unreadable string. "%2" and above is not a problem.
Unfortunately, on Windows an IPv6 address can contain "%1", so expand
"%1" to "% 1" before reporting. "%%1" is also a problem for ReportEvent,
but that string cannot occur in an IPv6 address.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile              |    5 ++-
 compat/win32/syslog.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/syslog.h |   20 +++++++++++++
 daemon.c              |    2 -
 git-compat-util.h     |    1 +
 5 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

diff --git a/Makefile b/Makefile
index 1f1ce04..d9d9419 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += compat/win32/pthread.h
+LIB_H += compat/win32/syslog.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -1081,7 +1082,7 @@ ifeq ($(uname_S),Windows)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1131,7 +1132,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
-		compat/win32/pthread.o
+		compat/win32/pthread.o compat/win32/syslog.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
new file mode 100644
index 0000000..42b95a9
--- /dev/null
+++ b/compat/win32/syslog.c
@@ -0,0 +1,72 @@
+#include "../../git-compat-util.h"
+#include "../../strbuf.h"
+
+static HANDLE ms_eventlog;
+
+void openlog(const char *ident, int logopt, int facility)
+{
+	if (ms_eventlog)
+		return;
+
+	ms_eventlog = RegisterEventSourceA(NULL, ident);
+
+	if (!ms_eventlog)
+		warning("RegisterEventSource() failed: %lu", GetLastError());
+}
+
+void syslog(int priority, const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+		{"1", "% 1"},
+		{NULL, NULL}
+	};
+	WORD logtype;
+	char *str;
+	int str_len;
+	va_list ap;
+
+	if (!ms_eventlog)
+		return;
+
+	va_start(ap, fmt);
+	str_len = vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	if (str_len < 0) {
+		warning("vsnprintf failed: '%s'", strerror(errno));
+		return;
+	}
+
+	str = malloc(str_len + 1);
+	va_start(ap, fmt);
+	vsnprintf(str, str_len + 1, fmt, ap);
+	va_end(ap);
+	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
+	free(str);
+
+	switch (priority) {
+	case LOG_EMERG:
+	case LOG_ALERT:
+	case LOG_CRIT:
+	case LOG_ERR:
+		logtype = EVENTLOG_ERROR_TYPE;
+		break;
+
+	case LOG_WARNING:
+		logtype = EVENTLOG_WARNING_TYPE;
+		break;
+
+	case LOG_NOTICE:
+	case LOG_INFO:
+	case LOG_DEBUG:
+	default:
+		logtype = EVENTLOG_INFORMATION_TYPE;
+		break;
+	}
+
+	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
+	    (const char **)&sb.buf, NULL);
+
+	strbuf_release(&sb);
+}
diff --git a/compat/win32/syslog.h b/compat/win32/syslog.h
new file mode 100644
index 0000000..70daa7c
--- /dev/null
+++ b/compat/win32/syslog.h
@@ -0,0 +1,20 @@
+#ifndef SYSLOG_H
+#define SYSLOG_H
+
+#define LOG_PID     0x01
+
+#define LOG_EMERG   0
+#define LOG_ALERT   1
+#define LOG_CRIT    2
+#define LOG_ERR     3
+#define LOG_WARNING 4
+#define LOG_NOTICE  5
+#define LOG_INFO    6
+#define LOG_DEBUG   7
+
+#define LOG_DAEMON  (3<<3)
+
+void openlog(const char *ident, int logopt, int facility);
+void syslog(int priority, const char *fmt, ...);
+
+#endif /* SYSLOG_H */
diff --git a/daemon.c b/daemon.c
index d6e20c6..d594375 100644
--- a/daemon.c
+++ b/daemon.c
@@ -5,8 +5,6 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-#include <syslog.h>
-
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..e192831 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -104,6 +104,7 @@
 #include <assert.h>
 #include <regex.h>
 #include <utime.h>
+#include <syslog.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
-- 
1.7.3.1.199.g72340
