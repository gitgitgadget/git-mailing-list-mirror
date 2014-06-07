From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 2/6] Detect console streams more reliably on Windows
Date: Sat,  7 Jun 2014 09:57:21 +0200
Message-ID: <1402127845-4862-3-git-send-email-kasal@ucw.cz>
References: <20140606183935.GA4197@camelia.ucw.cz>
 <1402127845-4862-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com Sat Jun 07 09:57:33 2014
Return-path: <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>)
	id 1WtBVJ-0004YK-9y
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:57:29 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf441413lab.12
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=r6UVGkRLYsGQ+wxI7he/a1MLzH5/Qe8fiYqQkHEPbLM=;
        b=LsJ0eQRSRkvP665df4rmG1mFF/c0jPrpJkYc9PpB/G8KlKGYrBlern/gJreUjBnOge
         Kpjvx8tCpz28qiFNFmCg5oxQIbL/90Ak7YoZLRqSUvfuE+BKzcZ61y9WIqFi2YgkEh/n
         /dTnEqKz4rzkakXs+XV05ztiihnDoBO3qOocQGM4xHrLRiY6PnuKO189jyGPPo6JhPa6
         QskoLmRhXpxQWFt2+9udKqs2Q/UOC4fbZ3uWOB80jMRh0QFHz6FcCElHe1W5gtRl+OV0
         i/JtGYqrWo88f4TP0nWb5aFJZICiJTFD9PMOWF3omoQ1YKODYcPevzzaq7q6SVjTZkA3
         MbwQ==
X-Received: by 10.152.18.225 with SMTP id z1mr3129lad.10.1402127848903;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.37 with SMTP id g5ls205182lah.3.gmail; Sat, 07 Jun 2014
 00:57:27 -0700 (PDT)
X-Received: by 10.112.149.162 with SMTP id ub2mr88399lbb.18.1402127847915;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id se3si75212wic.3.2014.06.07.00.57.27
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id AB5401C00A6; Sat,  7 Jun 2014 09:57:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402127845-4862-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251039>

From: Karsten Blees <blees@dcon.de>
Date: Sat, 31 Jul 2010 00:04:02 +0000

GetStdHandle(STD_OUTPUT_HANDLE) doesn't work for stderr if stdout is
redirected. Use _get_osfhandle of the FILE* instead.

_isatty() is true for all character devices (including parallel and serial
ports). Check return value of GetConsoleScreenBufferInfo instead to
reliably detect console handles (also don't initialize internal state from
an uninitialized CONSOLE_SCREEN_BUFFER_INFO structure if the function
fails).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/winansi.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index abe0fea..c4be401 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -25,27 +25,39 @@ static HANDLE console;
 static WORD plain_attr;
 static WORD attr;
 static int negative;
+static FILE *last_stream = NULL;
 
-static void init(void)
+static int is_console(FILE *stream)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	HANDLE hcon;
 
 	static int initialized = 0;
-	if (initialized)
-		return;
 
-	console = GetStdHandle(STD_OUTPUT_HANDLE);
-	if (console == INVALID_HANDLE_VALUE)
-		console = NULL;
+	/* use cached value if stream hasn't changed */
+	if (stream == last_stream)
+		return console != NULL;
 
-	if (!console)
-		return;
+	last_stream = stream;
+	console = NULL;
 
-	GetConsoleScreenBufferInfo(console, &sbi);
-	attr = plain_attr = sbi.wAttributes;
-	negative = 0;
+	/* get OS handle of the stream */
+	hcon = (HANDLE) _get_osfhandle(_fileno(stream));
+	if (hcon == INVALID_HANDLE_VALUE)
+		return 0;
+
+	/* check if its a handle to a console output screen buffer */
+	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
+		return 0;
+
+	if (!initialized) {
+		attr = plain_attr = sbi.wAttributes;
+		negative = 0;
+		initialized = 1;
+	}
 
-	initialized = 1;
+	console = hcon;
+	return 1;
 }
 
 static int write_console(const char *str, size_t len)
@@ -292,12 +304,7 @@ int winansi_fputs(const char *str, FILE *stream)
 {
 	int rv;
 
-	if (!isatty(fileno(stream)))
-		return fputs(str, stream);
-
-	init();
-
-	if (!console)
+	if (!is_console(stream))
 		return fputs(str, stream);
 
 	rv = ansi_emulate(str, stream);
@@ -315,12 +322,7 @@ int winansi_vfprintf(FILE *stream, const char *format, va_list list)
 	char *buf = small_buf;
 	va_list cp;
 
-	if (!isatty(fileno(stream)))
-		goto abort;
-
-	init();
-
-	if (!console)
+	if (!is_console(stream))
 		goto abort;
 
 	va_copy(cp, list);
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
