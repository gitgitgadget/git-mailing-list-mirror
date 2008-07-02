From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 10/12] Add ANSI control code emulation for the
 Windows console
Date: Wed,  2 Jul 2008 10:32:10 +0200
Message-ID: <1214987532-23640-10-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Peter <git@peter.is-a-geek.org>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:27 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.173])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmE-0001Fp-8f
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:22 +0200
Received: by py-out-1314.google.com with SMTP id u10so7771569pyb.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=6m3IVO25tWIZPzub0EwYZ7hP1E3iadHZpNIA+NOGnB8=;
        b=u+2u633TUxz3vfA8qFBARMiS9a7+EYvpU3tP27wkLYAi4Dn67K9lzupuDlY8fCy2hw
         y+j/sDx+RCe1ASjE7+Ne+dJXzyU/CZ9BTIoMm/SeqOaJ3c5Zzb3Ai9U+OuvU9rrDGrgq
         IRhyMjfp5SPPNtpmDSiyZn6LbkA59dnfEW0X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=q2JrdoT2/7K+mtK0RpjLZ7IrkD9NiMvxYxJtmKZRZ2pedZUZoJK+dDxpiaarBSCQph
         YSqJFugjTolcNrsUmNAg//E5hBba4q3h3u5UbvHsmgPfdsR6tLaUu0AUJo1cHoi1w4Ah
         M+wiKRpt+ijbxTVHwEyxYQxezvtKwryy1moCA=
Received: by 10.141.78.14 with SMTP id f14mr480675rvl.14.1214987542154;
        Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2550prf.0;
	Wed, 02 Jul 2008 01:32:22 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.106.1 with SMTP id e1mr8846888agc.7.1214987541570; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si7857869yxd.0.2008.07.02.01.32.20; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEfK019120; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0R017527; Wed, 2 Jul 2008 10:32:14 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-9-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87109>


From: Peter <git@peter.is-a-geek.org>

This adds only the minimum necessary to keep git pull/merge's diffstat from
wrapping. Notably absent is support for the K (erase) operation, and support
for POSIX write.

Cygwin does not need the WIN_ANSI define, since it has its own (more complete)
ANSI emulation.

Signed-off-by: Peter Harris <git@peter.is-a-geek.org>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile          |    6 +
 compat/winansi.c  |  309 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    7 ++
 3 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 compat/winansi.c

diff --git a/Makefile b/Makefile
index 5914e1a..a7f2dcb 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
+	WIN_ANSI = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -981,6 +982,11 @@ ifdef NO_EXTERNAL_GREP
 	BASIC_CFLAGS += -DNO_EXTERNAL_GREP
 endif
 
+ifdef WIN_ANSI
+	COMPAT_CFLAGS += -DWIN_ANSI
+	COMPAT_OBJS += compat/winansi.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/compat/winansi.c b/compat/winansi.c
new file mode 100644
index 0000000..86c3fd2
--- /dev/null
+++ b/compat/winansi.c
@@ -0,0 +1,309 @@
+#include <windows.h>
+#include "../git-compat-util.h"
+
+/*
+ Functions to be wrapped:
+*/
+#undef printf
+#undef fputs
+
+/*
+ ANSI codes to implement: m, K
+*/
+
+static HANDLE console;
+static WORD plain_attr;
+static WORD attr;
+static int negative;
+
+static void init(void)
+{
+    CONSOLE_SCREEN_BUFFER_INFO sbi;
+
+    static int initialized = 0;
+    if (initialized)
+	return;
+
+    console = GetStdHandle(STD_OUTPUT_HANDLE);
+    if (console == INVALID_HANDLE_VALUE)
+	console = NULL;
+
+    if (!console)
+	return;
+
+    GetConsoleScreenBufferInfo(console, &sbi);
+    attr = plain_attr = sbi.wAttributes;
+    negative = 0;
+
+    initialized = 1;
+}
+
+
+#define FOREGROUND_ALL (FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE)
+#define BACKGROUND_ALL (BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE)
+
+static void set_console_attr(void)
+{
+    WORD attributes = attr;
+    if (negative) {
+	attributes &= ~FOREGROUND_ALL;
+	attributes &= ~BACKGROUND_ALL;
+
+	/* This could probably use a bitmask instead of a series of ifs */
+	if (attr & FOREGROUND_RED)
+	    attributes |= BACKGROUND_RED;
+	if (attr & FOREGROUND_GREEN)
+	    attributes |= BACKGROUND_GREEN;
+	if (attr & FOREGROUND_BLUE)
+	    attributes |= BACKGROUND_BLUE;
+
+	if (attr & BACKGROUND_RED)
+	    attributes |= FOREGROUND_RED;
+	if (attr & BACKGROUND_GREEN)
+	    attributes |= FOREGROUND_GREEN;
+	if (attr & BACKGROUND_BLUE)
+	    attributes |= FOREGROUND_BLUE;
+    }
+    SetConsoleTextAttribute(console, attributes);
+}
+
+static const char *set_attr(const char *str)
+{
+    const char *func;
+    size_t len = strspn(str, "0123456789;");
+    func = str + len;
+
+    switch (*func) {
+    case 'm':
+	do {
+	    long val = strtol(str, (char **)&str, 10);
+	    switch (val) {
+	    case 0: /* reset */
+		attr = plain_attr;
+		negative = 0;
+		break;
+	    case 1: /* bold */
+		attr |= FOREGROUND_INTENSITY;
+		break;
+	    case 2:  /* faint */
+	    case 22: /* normal */
+		attr &= ~FOREGROUND_INTENSITY;
+		break;
+	    case 3:  /* italic */
+		/* Unsupported */
+		break;
+	    case 4:  /* underline */
+	    case 21: /* double underline */
+		/* Wikipedia says this flag does nothing */
+		/* Furthermore, mingw doesn't define this flag
+		attr |= COMMON_LVB_UNDERSCORE; */
+		break;
+	    case 24: /* no underline */
+		/* attr &= ~COMMON_LVB_UNDERSCORE; */
+		break;
+	    case 5:  /* slow blink */
+	    case 6:  /* fast blink */
+		/* We don't have blink, but we do have background intensity */
+		attr |= BACKGROUND_INTENSITY;
+		break;
+	    case 25: /* no blink */
+		attr &= ~BACKGROUND_INTENSITY;
+		break;
+	    case 7:  /* negative */
+		negative = 1;
+		break;
+	    case 27: /* positive */
+		negative = 0;
+		break;
+	    case 8:  /* conceal */
+	    case 28: /* reveal */
+		/* Unsupported */
+		break;
+	    case 30: /* Black */
+		attr &= ~FOREGROUND_ALL;
+		break;
+	    case 31: /* Red */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_RED;
+		break;
+	    case 32: /* Green */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_GREEN;
+		break;
+	    case 33: /* Yellow */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_RED | FOREGROUND_GREEN;
+		break;
+	    case 34: /* Blue */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_BLUE;
+		break;
+	    case 35: /* Magenta */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_RED | FOREGROUND_BLUE;
+		break;
+	    case 36: /* Cyan */
+		attr &= ~FOREGROUND_ALL;
+		attr |= FOREGROUND_GREEN | FOREGROUND_BLUE;
+		break;
+	    case 37: /* White */
+		attr |= FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE;
+		break;
+	    case 38: /* Unknown */
+		break;
+	    case 39: /* reset */
+		attr &= ~FOREGROUND_ALL;
+		attr |= (plain_attr & FOREGROUND_ALL);
+		break;
+	    case 40: /* Black */
+		attr &= ~BACKGROUND_ALL;
+		break;
+	    case 41: /* Red */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_RED;
+		break;
+	    case 42: /* Green */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_GREEN;
+		break;
+	    case 43: /* Yellow */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_RED | BACKGROUND_GREEN;
+		break;
+	    case 44: /* Blue */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_BLUE;
+		break;
+	    case 45: /* Magenta */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_RED | BACKGROUND_BLUE;
+		break;
+	    case 46: /* Cyan */
+		attr &= ~BACKGROUND_ALL;
+		attr |= BACKGROUND_GREEN | BACKGROUND_BLUE;
+		break;
+	    case 47: /* White */
+		attr |= BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE;
+		break;
+	    case 48: /* Unknown */
+		break;
+	    case 49: /* reset */
+		attr &= ~BACKGROUND_ALL;
+		attr |= (plain_attr & BACKGROUND_ALL);
+		break;
+	    default:
+		/* Unsupported code */
+		break;
+	    }
+	    str++;
+	} while (*(str-1) == ';');
+
+	set_console_attr();
+	break;
+    case 'K':
+	/* TODO */
+	break;
+    default:
+	/* Unsupported code */
+	break;
+    }
+
+    return func + 1;
+}
+
+static int ansi_emulate(const char *str, FILE *stream)
+{
+    int rv = 0;
+    const char *pos = str;
+
+    while (*pos) {
+	pos = strstr(str, "\033[");
+	if (pos) {
+	    size_t len = pos - str;
+
+	    if (len) {
+		size_t output_len = fwrite(str, 1, len, stream);
+		rv += output_len;
+		if (output_len < len)
+		    return rv;
+	    }
+
+	    str = pos + 2;
+	    rv += 2;
+
+	    fflush(stream);
+
+	    pos = set_attr(str);
+	    rv += pos - str;
+	    str = pos;
+	} else {
+	    rv += strlen(str);
+	    fputs(str, stream);
+	    return rv;
+	}
+    }
+    return rv;
+}
+
+int git_fputs(const char *str, FILE *stream)
+{
+    int rv;
+
+    init();
+
+    if (!console)
+	return fputs(str, stream);
+
+    if (!isatty(fileno(stream)))
+	return fputs(str, stream);
+
+    rv = ansi_emulate(str, stream);
+
+    if (rv >= 0)
+	return 0;
+    else
+	return EOF;
+}
+
+int git_printf(const char *format, ...)
+{
+    va_list list;
+
+    char small_buf[256];
+    char *buf = small_buf;
+    int len, rv;
+
+    init();
+
+    if (!console)
+	goto abort;
+
+    if (!isatty(fileno(stdout)))
+	goto abort;
+
+    va_start(list, format);
+    len = vsnprintf(small_buf, sizeof(small_buf), format, list);
+    va_end(list);
+
+    if (len > sizeof(small_buf) - 1) {
+	buf = malloc(len + 1);
+	if (!buf)
+	    goto abort;
+
+	va_start(list, format);
+	len = vsnprintf(buf, len + 1, format, list);
+	va_end(list);
+    }
+
+    rv = ansi_emulate(buf, stdout);
+
+    if (buf != small_buf)
+	free(buf);
+    return rv;
+
+abort:
+    va_start(list, format);
+    rv = vprintf(format, list);
+    va_end(list);
+    return rv;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 545df59..fc5168e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,4 +357,11 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 # define FORCE_DIR_SET_GID 0
 #endif
 
+#ifdef WIN_ANSI
+extern int git_fputs(const char *str, FILE *stream);
+extern int git_printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
+#define fputs git_fputs
+#define printf(...) git_printf(__VA_ARGS__)
+#endif
+
 #endif
-- 
1.5.6.1.255.g32571
