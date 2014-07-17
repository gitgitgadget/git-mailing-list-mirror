From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 01/13] Revert "Windows: teach getenv to do a
 case-sensitive search"
Date: Thu, 17 Jul 2014 17:37:54 +0200
Message-ID: <1405611486-10176-2-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com Thu Jul 17 17:38:19 2014
Return-path: <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>)
	id 1X7nl9-0008VW-EZ
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-wi0-f183.google.com with SMTP id q5sf316183wiv.10
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=G7eXmlQLX58fDaxFrPZ6wvqug1MLk+ajxTFPxLS74qg=;
        b=eyqSXJKPAouLWvIgsYOwtBsT+pgaqal5bz/sAKWU6SEA1rrHjSDR/g+jmmgS3Y7vPE
         0uGAIL+nJoVACZIH4FctSp0VEWtdN5iXr6rsVfGSAQdp/czHCUJ58kWkr22YgrvN+itM
         s1YvCE6mBToQLIM05bEjeufq8kdZ/3oKawXUb++txgH4uwSP+170BQ17Kgoua7mW85HU
         ZaY+vpw22YCLpxiVsgIi6CiyCayXgMwRaGWhll4RAIN+MEU8sLMHsMLAExhE1L9JGcrw
         pMtCbK5kBrgR4sbsOdp2KzlbOmkl63q3/2GbyX0TGbgDNLHxfmo3BBEoMyL7jVSxbmn8
         wQCw==
X-Received: by 10.180.211.111 with SMTP id nb15mr95064wic.4.1405611495159;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.169 with SMTP id gn9ls441472wib.10.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.180.208.37 with SMTP id mb5mr2139693wic.6.1405611494480;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id mx7si1076315wic.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 5564C1C0197; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253750>

From: Karsten Blees <blees@dcon.de>

This reverts commit df599e9612788b728ce43a03159b85f1fe624d6a.

As of 5e9637c6 "i18n: add infrastructure for translating Git with gettext",
eval_gettext uses MinGW envsubst.exe instead of git-sh-i18n--envsubst.exe
for variable substitution. This breaks git-submodule.sh messages and tests,
as envsubst.exe doesn't support case-sensitive environment lookup (the same
is true for almost everything on Windows, including MSys and Cygwin tools).

30a615ac "Windows/i18n: rename $path to prevent clashes with $PATH" renames
the conflicting variable in git-submodule.sh, so that it works on Windows
(i.e. with case-insensitive environment, regardless of the toolset).

Revert to the documented behaviour of case-insensitive environment on
Windows.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c19e3d9..ca1b6bd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1245,31 +1245,14 @@ char **make_augmented_environ(const char *const *vars)
 }
 
 #undef getenv
-
-/*
- * The system's getenv looks up the name in a case-insensitive manner.
- * This version tries a case-sensitive lookup and falls back to
- * case-insensitive if nothing was found.  This is necessary because,
- * as a prominent example, CMD sets 'Path', but not 'PATH'.
- * Warning: not thread-safe.
- */
-static char *getenv_cs(const char *name)
-{
-	size_t len = strlen(name);
-	int i = lookup_env(environ, name, len);
-	if (i >= 0)
-		return environ[i] + len + 1;	/* skip past name and '=' */
-	return getenv(name);
-}
-
 char *mingw_getenv(const char *name)
 {
-	char *result = getenv_cs(name);
+	char *result = getenv(name);
 	if (!result && !strcmp(name, "TMPDIR")) {
 		/* on Windows it is TMP and TEMP */
-		result = getenv_cs("TMP");
+		result = getenv("TMP");
 		if (!result)
-			result = getenv_cs("TEMP");
+			result = getenv("TEMP");
 	}
 	return result;
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
