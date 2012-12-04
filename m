From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 5/6] mingw: reuse tty-version of git_terminal_prompt
Date: Tue,  4 Dec 2012 09:10:41 +0100
Message-ID: <1354608642-5316-6-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBM7A62CQKGQEGUACA3A@googlegroups.com Tue Dec 04 09:11:51 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBM7A62CQKGQEGUACA3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBM7A62CQKGQEGUACA3A@googlegroups.com>)
	id 1TfnbT-0004tJ-2Z
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:43 +0100
Received: by mail-ea0-f186.google.com with SMTP id c1sf1487801eaa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=l6QYIvQ8nC1NT+ASHDA5Vmo0Z7w8qQO0XoeQLHMDrGI=;
        b=cP5DbMSMgOXNa+PCbGfdNY4i865LwuW49teBfza2e8prnHQDzY6F8UjYmB6DH6lglK
         WG9MBQrQNr12phFPGYq7SbGWd3itiCzRJLFolV4btEyd0ns29/138xVp6kZUF4q/QWqz
         M4MOdX0GFTus1wxl+QBXRPwN31o+uEgVo2ZP3Xukt42vBAaC9Ds/ana7zeGkn3uZ2DeV
         mGh8O3di4bxu97ztrH0ihSjmrw40yKRTHifhqT/4NBd6weQ6BXUJ3SmY++s4FZ6+HnXh
         cZuX22CE7z++F4NCoAiB7dhgtBEzTGVAnSial7FiPrbOYs3sIpeSsZrjeSvV79svO6df
         MMJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=l6QYIvQ8nC1NT+ASHDA5Vmo0Z7w8qQO0XoeQLHMDrGI=;
        b=ToDlzMLOH2mPxjIkRKstvQMgw+lkuCbCHsCrDPTSmr0WvUoelg4PZ+iOkf8WVbj28z
         SJgdqsFpL96hdSDWousJs5khL+Au+X79e6avG47rmtvm6ih/UkTjWL1Agd3LmjxLLFU7
         Dmig+vXTAZcF4WWn30RiOCTxOA6dE9eDqCM2io7iLSdusXMRnFxPL5RsZ7M35lgJ9q2S
         KNADytbVetGomBH/jNgGkMWHQfjwojs5OEsG37YpaRMLPeildqGlcAQ01K6ZlGsk5Wah
         DyRi0UBHHvVxwAK8gIPGfg3t9T6I4+7MlxScDtUBMASskYf8jbzs2GVQbbS7Fa34yEgA
         lAew==
Received: by 10.181.11.164 with SMTP id ej4mr331993wid.4.1354608691507;
        Tue, 04 Dec 2012 00:11:31 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.134 with SMTP id cu6ls127609wib.41.gmail; Tue, 04 Dec
 2012 00:11:30 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787905bkx.4.1354608690814;
        Tue, 04 Dec 2012 00:11:30 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1787904bkx.4.1354608690795;
        Tue, 04 Dec 2012 00:11:30 -0800 (PST)
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com [209.85.217.170])
        by gmr-mx.google.com with ESMTPS id v18si44920bkw.1.2012.12.04.00.11.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:30 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.170 as permitted sender) client-ip=209.85.217.170;
Received: by mail-lb0-f170.google.com with SMTP id j14so3196090lbo.29
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:30 -0800 (PST)
Received: by 10.112.29.129 with SMTP id k1mr5571921lbh.102.1354608690610;
        Tue, 04 Dec 2012 00:11:30 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id sx3sm204204lab.9.2012.12.04.00.11.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:29 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.170 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211076>

The getpass-implementation we use on Windows isn't at all ideal;
it works in raw-mode (as opposed to cooked mode), and as a result
does not deal correcly with deletion, arrow-keys etc.

Instead, use cooked mode to read a line at the time, allowing the
C run-time to process the input properly.

Since we set files to be opened in binary-mode by default on
Windows, introduce a FORCE_TEXT macro that expands to the "t"
modifier that forces the terminal to be opened in text-mode so we
do not have to deal with CRLF issues.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 9aecad6..9b5e3d1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -3,8 +3,22 @@
 #include "sigchain.h"
 #include "strbuf.h"
 
+#if defined(HAVE_DEV_TTY) || defined(WIN32)
+
+static void restore_term(void);
+
+static void restore_term_on_signal(int sig)
+{
+	restore_term();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
 #ifdef HAVE_DEV_TTY
 
+#define INPUT_PATH "/dev/tty"
+#define OUTPUT_PATH "/dev/tty"
+
 static int term_fd = -1;
 static struct termios old_term;
 
@@ -18,13 +32,6 @@ static void restore_term(void)
 	term_fd = -1;
 }
 
-static void restore_term_on_signal(int sig)
-{
-	restore_term();
-	sigchain_pop(sig);
-	raise(sig);
-}
-
 static int disable_echo(void)
 {
 	struct termios t;
@@ -46,17 +53,61 @@ error:
 	return -1;
 }
 
+#elif defined(WIN32)
+
+#define INPUT_PATH "CONIN$"
+#define OUTPUT_PATH "CONOUT$"
+#define FORCE_TEXT "t"
+
+static HANDLE hconin = INVALID_HANDLE_VALUE;
+static DWORD cmode;
+
+static void restore_term(void)
+{
+	if (hconin == INVALID_HANDLE_VALUE)
+		return;
+
+	SetConsoleMode(hconin, cmode);
+	CloseHandle(hconin);
+	hconin = INVALID_HANDLE_VALUE;
+}
+
+static int disable_echo(void)
+{
+	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
+	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
+	    FILE_ATTRIBUTE_NORMAL, NULL);
+	if (hconin == INVALID_HANDLE_VALUE)
+		return -1;
+
+	GetConsoleMode(hconin, &cmode);
+	sigchain_push_common(restore_term_on_signal);
+	if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
+		CloseHandle(hconin);
+		hconin = INVALID_HANDLE_VALUE;
+		return -1;
+	}
+
+	return 0;
+}
+
+#endif
+
+#ifndef FORCE_TEXT
+#define FORCE_TEXT
+#endif
+
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	int r;
 	FILE *input_fh, *output_fh;
 
-	input_fh = fopen("/dev/tty", "r");
+	input_fh = fopen(INPUT_PATH, "r" FORCE_TEXT);
 	if (!input_fh)
 		return NULL;
 
-	output_fh = fopen("/dev/tty", "w");
+	output_fh = fopen(OUTPUT_PATH, "w" FORCE_TEXT);
 	if (!output_fh) {
 		fclose(input_fh);
 		return NULL;
-- 
1.8.0.4.g3c6fb4f.dirty

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
