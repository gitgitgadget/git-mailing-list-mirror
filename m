From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 09/13] Win32: reduce environment array reallocations
Date: Thu, 17 Jul 2014 17:38:02 +0200
Message-ID: <1405611486-10176-10-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:16 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Vj-65
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-wg0-f63.google.com with SMTP id b13sf266949wgh.28
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=eE4AkwihWcG7qm9CGCHu61e0bpWKa3AXJ+/a4kitufU=;
        b=hkrQ+wzWAM1St11ln5/wi+Nwcxl0XEzKg3MUPLcRgnLMVEBcv5NiXA00WmXMxzgAQG
         yP/Ka6zvDEgHREPyGofYQQT7p2i43So590ttaJU5eSUDQANzaxWv3dNAM2twUAC1RCMa
         lKNRXVBFwDngH3hToJboiuj8V/N2MMGyZfAMNkiR1KE70daMXaCtebUIxKvK5Mn88Xay
         n66z1QOYQjlp9JAJZa5dP7uMyb0Gt4IpaQqRqyHC8fj7RU7pt6wi058WW9z7PeTZ6+j7
         4tMkQog49tL6OXvvvU9cjxUToddokwNvKMurgm6qyBgjnfNb+ofH6yxDG9gC6HrJivR9
         en9Q==
X-Received: by 10.152.179.227 with SMTP id dj3mr393411lac.0.1405611495902;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.134 with SMTP id o6ls225489lal.4.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.152.87.226 with SMTP id bb2mr3031712lab.5.1405611494806;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608385wij.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 7E92E1C01AB; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253746>

From: Karsten Blees <blees@dcon.de>

Move environment array reallocation from do_putenv to the respective
callers. Keep track of the environment size in a global variable. Use
ALLOC_GROW in mingw_putenv to reduce reallocations. Allocate a
sufficiently sized environment array in make_environment_block to prevent
reallocations.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 62 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ffff592..e63fd6a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -898,7 +898,12 @@ static char *path_lookup(const char *cmd, char **path, int exe_only)
 	return prog;
 }
 
-static char **do_putenv(char **env, const char *name, int free_old);
+static int do_putenv(char **env, const char *name, int size, int free_old);
+
+/* used number of elements of environ array, including terminating NULL */
+static int environ_size = 0;
+/* allocated size of environ array, in bytes */
+static int environ_alloc = 0;
 
 static int compareenv(const void *a, const void *b)
 {
@@ -914,31 +919,28 @@ static int compareenv(const void *a, const void *b)
 static wchar_t *make_environment_block(char **deltaenv)
 {
 	wchar_t *wenvblk = NULL;
-	int count = 0;
-	char **e, **tmpenv;
-	int size = 0, wenvsz = 0, wenvpos = 0;
+	char **tmpenv;
+	int i = 0, size = environ_size, wenvsz = 0, wenvpos = 0;
 
-	while (environ[count])
-		count++;
+	while (deltaenv && deltaenv[i])
+		i++;
 
-	/* copy the environment */
-	tmpenv = xmalloc(sizeof(*tmpenv) * (count + 1));
-	memcpy(tmpenv, environ, sizeof(*tmpenv) * (count + 1));
+	/* copy the environment, leaving space for changes */
+	tmpenv = xmalloc((size + i) * sizeof(char*));
+	memcpy(tmpenv, environ, size * sizeof(char*));
 
 	/* merge supplied environment changes into the temporary environment */
-	for (e = deltaenv; e && *e; e++)
-		tmpenv = do_putenv(tmpenv, *e, 0);
+	for (i = 0; deltaenv && deltaenv[i]; i++)
+		size = do_putenv(tmpenv, deltaenv[i], size, 0);
 
 	/* environment must be sorted */
-	for (count = 0; tmpenv[count]; )
-		count++;
-	qsort(tmpenv, count, sizeof(*tmpenv), compareenv);
+	qsort(tmpenv, size - 1, sizeof(char*), compareenv);
 
 	/* create environment block from temporary environment */
-	for (e = tmpenv; *e; e++) {
-		size = 2 * strlen(*e) + 2; /* +2 for final \0 */
+	for (i = 0; tmpenv[i]; i++) {
+		size = 2 * strlen(tmpenv[i]) + 2; /* +2 for final \0 */
 		ALLOC_GROW(wenvblk, (wenvpos + size) * sizeof(wchar_t), wenvsz);
-		wenvpos += xutftowcs(&wenvblk[wenvpos], *e, size) + 1;
+		wenvpos += xutftowcs(&wenvblk[wenvpos], tmpenv[i], size) + 1;
 	}
 	/* add final \0 terminator */
 	wenvblk[wenvpos] = 0;
@@ -1205,19 +1207,19 @@ static int lookupenv(char **env, const char *name, size_t nmln)
 
 /*
  * If name contains '=', then sets the variable, otherwise it unsets it
+ * Size includes the terminating NULL. Env must have room for size + 1 entries
+ * (in case of insert). Returns the new size. Optionally frees removed entries.
  */
-static char **do_putenv(char **env, const char *name, int free_old)
+static int do_putenv(char **env, const char *name, int size, int free_old)
 {
 	char *eq = strchrnul(name, '=');
 	int i = lookupenv(env, name, eq-name);
 
 	if (i < 0) {
 		if (*eq) {
-			for (i = 0; env[i]; i++)
-				;
-			env = xrealloc(env, (i+2)*sizeof(*env));
-			env[i] = (char*) name;
-			env[i+1] = NULL;
+			env[size - 1] = (char*) name;
+			env[size] = NULL;
+			size++;
 		}
 	}
 	else {
@@ -1225,11 +1227,13 @@ static char **do_putenv(char **env, const char *name, int free_old)
 			free(env[i]);
 		if (*eq)
 			env[i] = (char*) name;
-		else
+		else {
 			for (; env[i]; i++)
 				env[i] = env[i+1];
+			size--;
+		}
 	}
-	return env;
+	return size;
 }
 
 #undef getenv
@@ -1247,7 +1251,8 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	environ = do_putenv(environ, namevalue, 1);
+	ALLOC_GROW(environ, (environ_size + 1) * sizeof(char*), environ_alloc);
+	environ_size = do_putenv(environ, namevalue, environ_size, 1);
 	return 0;
 }
 
@@ -2047,7 +2052,9 @@ void mingw_startup()
 		maxlen = max(maxlen, wcslen(wenv[i]));
 
 	/* nedmalloc can't free CRT memory, allocate resizable environment list */
-	environ = xcalloc(i + 1, sizeof(char*));
+	environ = NULL;
+	environ_size = i + 1;
+	ALLOC_GROW(environ, environ_size * sizeof(char*), environ_alloc);
 
 	/* allocate buffer (wchar_t encodes to max 3 UTF-8 bytes) */
 	maxlen = 3 * maxlen + 1;
@@ -2064,6 +2071,7 @@ void mingw_startup()
 		len = xwcstoutf(buffer, wenv[i], maxlen);
 		environ[i] = xmemdupz(buffer, len);
 	}
+	environ[i] = NULL;
 	free(buffer);
 
 	/* initialize critical section for waitpid pinfo_t list */
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
