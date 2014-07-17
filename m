From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 12/13] Win32: patch Windows environment on startup
Date: Thu, 17 Jul 2014 17:38:05 +0200
Message-ID: <1405611486-10176-13-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Ve-0H
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-wi0-f188.google.com with SMTP id z2sf293631wiv.15
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=kvyQ+Jb9Jf3+EzPeTIKVMo5yGtpumVcw/I+/1gc+Oi8=;
        b=ivjipiPh3FwqTjXpqkUeaLrg8ImRbE/8j3ztJs4Wp5NdAAOV7mKUG5P/0kCUuqYEJ6
         sZRcloT2hF93GrXobSiU/IAeZ84rR05Nk7RQmQ9PN80C2n8UeYMk2iH4fGWKJqzFAgoi
         4GsuGKYYPYpOe0ZXhI7BkGwxf7f/XHmD6Cb47RK1gj5WbgGETMPVM/uhb2JVReVUKzl3
         E6FvfKhP//hRpfyJFqPYET1XlGDFnuH3G5U8m4Lj1Ftgi0anFj4pQKmGlNkYuEEeuQqB
         Yj6FdPOaJhT1TlIIRYIP/mI83/hngaORQQk1nIVqW9JL1WR7rsqJe6pkNN5l79703iki
         TVeg==
X-Received: by 10.152.1.226 with SMTP id 2mr10800lap.11.1405611495678;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.134 with SMTP id o6ls225488lal.4.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.112.142.106 with SMTP id rv10mr3723290lbb.5.1405611494751;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608386wij.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 914501C01AF; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253751>

From: Karsten Blees <blees@dcon.de>

Fix Windows specific environment settings on startup rather than checking
for special values on every getenv call.

As a side effect, this makes the patched environment (i.e. with properly
initialized TMPDIR and TERM) available to child processes.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9dc6bf6..6d4ec56 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1250,7 +1250,7 @@ static int do_putenv(char **env, const char *name, int size, int free_old)
 	return size;
 }
 
-static char *do_getenv(const char *name)
+char *mingw_getenv(const char *name)
 {
 	char *value;
 	int pos = bsearchenv(environ, name, environ_size - 1);
@@ -1260,18 +1260,6 @@ static char *do_getenv(const char *name)
 	return value ? &value[1] : NULL;
 }
 
-char *mingw_getenv(const char *name)
-{
-	char *result = do_getenv(name);
-	if (!result && !strcmp(name, "TMPDIR")) {
-		/* on Windows it is TMP and TEMP */
-		result = do_getenv("TMP");
-		if (!result)
-			result = do_getenv("TEMP");
-	}
-	return result;
-}
-
 int mingw_putenv(const char *namevalue)
 {
 	ALLOC_GROW(environ, (environ_size + 1) * sizeof(char*), environ_alloc);
@@ -2113,6 +2101,17 @@ void mingw_startup()
 	/* sort environment for O(log n) getenv / putenv */
 	qsort(environ, i, sizeof(char*), compareenv);
 
+	/* fix Windows specific environment settings */
+
+	/* on Windows it is TMP and TEMP */
+	if (!mingw_getenv("TMPDIR")) {
+		const char *tmp = mingw_getenv("TMP");
+		if (!tmp)
+			tmp = mingw_getenv("TEMP");
+		if (tmp)
+			setenv("TMPDIR", tmp, 1);
+	}
+
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
 
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
