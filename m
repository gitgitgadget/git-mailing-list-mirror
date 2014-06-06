From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 3/5] Warn if the Windows console font doesn't
 support Unicode
Date: Fri,  6 Jun 2014 15:42:51 +0200
Message-ID: <1402062173-9602-4-git-send-email-kasal@ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com Fri Jun 06 15:43:24 2014
Return-path: <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>)
	id 1WsuQO-0000em-UA
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:16 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf306190lab.12
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Eztdv1mKfaVGzfFYd/4cpYkIaP7yfdFHW8lT4H4Y+sQ=;
        b=nrIQQo/3xAb55WyvXUkerhDEz4i4c4fw0ownjVLhpVz54CONxjD6maj4jZNaoOs9OK
         Tnba07MOycKV7hduAGWctKIjcXXYbWBbOajC21uro7Cot18qe1wYSg24XZDvh9oZWL8o
         6Bp3Pz+EZtqtO0uuEDuyQwAoJjKjhSPx4jzm3OiXRPpLf20R2+T+qlat4Bn5ucFWcHF9
         RAgEwMj0LvOr1mXTCZ1ltRlAIM0TBTMu2xB9v2xR7cPUh/1c5ktltLsRKWhRR+CPkY2V
         oqxo1BdteLU451SusvsNkFc8VWKjMa9J/Ie5nAXn3X8EhIV/GVgbVqXzpTWXLfmjZVyU
         7ddg==
X-Received: by 10.152.203.193 with SMTP id ks1mr7911lac.29.1402062196727;
        Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.3 with SMTP id w3ls129384law.72.gmail; Fri, 06 Jun 2014
 06:43:15 -0700 (PDT)
X-Received: by 10.112.54.169 with SMTP id k9mr1319114lbp.1.1402062195797;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s1si1302906wiw.3.2014.06.06.06.43.15
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 9B33B1C00A6; Fri,  6 Jun 2014 15:43:15 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250906>

From: Karsten Blees <blees@dcon.de>

Unicode console output won't display correctly with default settings
because the default console font ("Terminal") only supports the system's
OEM charset. Unfortunately, this is a user specific setting, so it cannot
be easily fixed by e.g. some registry tricks in the setup program.

This change prints a warning on exit if console output contained non-ascii
characters and the console font is supposedly not a TrueType font (which
usually have decent Unicode support).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/winansi.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index c4be401..bec6713 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -2,8 +2,11 @@
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
 
+#undef NOGDI
 #include "../git-compat-util.h"
 #include <malloc.h>
+#include <wingdi.h>
+#include <winreg.h>
 
 /*
  Functions to be wrapped:
@@ -27,6 +30,62 @@ static WORD attr;
 static int negative;
 static FILE *last_stream = NULL;
 
+#ifdef __MINGW32__
+typedef struct _CONSOLE_FONT_INFOEX {
+	ULONG cbSize;
+	DWORD nFont;
+	COORD dwFontSize;
+	UINT FontFamily;
+	UINT FontWeight;
+	WCHAR FaceName[LF_FACESIZE];
+} CONSOLE_FONT_INFOEX, *PCONSOLE_FONT_INFOEX;
+#endif
+
+typedef BOOL (WINAPI *PGETCURRENTCONSOLEFONTEX)(HANDLE, BOOL,
+		PCONSOLE_FONT_INFOEX);
+
+static void print_font_warning(void)
+{
+	warning("Your console font probably doesn\'t support Unicode. If "
+		"you experience strange characters in the output, consider "
+		"switching to a TrueType font such as Lucida Console!");
+}
+
+static void check_truetype_font(void)
+{
+	static int truetype_font_checked;
+	DWORD fontFamily = 0;
+	PGETCURRENTCONSOLEFONTEX pGetCurrentConsoleFontEx;
+
+	/* don't do this twice */
+	if (truetype_font_checked)
+		return;
+	truetype_font_checked = 1;
+
+	/* GetCurrentConsoleFontEx is available since Vista */
+	pGetCurrentConsoleFontEx = (PGETCURRENTCONSOLEFONTEX) GetProcAddress(
+			GetModuleHandle("kernel32.dll"), "GetCurrentConsoleFontEx");
+	if (pGetCurrentConsoleFontEx) {
+		CONSOLE_FONT_INFOEX cfi;
+		cfi.cbSize = sizeof(cfi);
+		if (pGetCurrentConsoleFontEx(console, 0, &cfi))
+			fontFamily = cfi.FontFamily;
+	} else {
+		/* pre-Vista: check default console font in registry */
+		HKEY hkey;
+		if (ERROR_SUCCESS == RegOpenKeyExA(HKEY_CURRENT_USER, "Console", 0,
+				KEY_READ, &hkey)) {
+			DWORD size = sizeof(fontFamily);
+			RegQueryValueExA(hkey, "FontFamily", NULL, NULL,
+					(LPVOID) &fontFamily, &size);
+			RegCloseKey(hkey);
+		}
+	}
+
+	if (!(fontFamily & TMPF_TRUETYPE))
+		atexit(print_font_warning);
+}
+
 static int is_console(FILE *stream)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
@@ -69,6 +128,13 @@ static int write_console(const char *str, size_t len)
 
 	WriteConsoleW(console, wbuf, wlen, NULL, NULL);
 
+	/*
+	 * if non-ascii characters are printed, check that the current console
+	 * font supports this
+	 */
+	if (wlen != len)
+		check_truetype_font();
+
 	/* return original (utf-8 encoded) length */
 	return len;
 }
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
