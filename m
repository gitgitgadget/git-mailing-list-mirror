From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 05/13] Win32: unify environment case-sensitivity
Date: Thu, 17 Jul 2014 17:37:58 +0200
Message-ID: <1405611486-10176-6-git-send-email-kasal@ucw.cz>
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
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Vm-BL
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-wg0-f58.google.com with SMTP id l18sf278482wgh.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=bepWEWc1E5hXatFFwEgUpcIVvnfa9UypTmnJYqhklIo=;
        b=GlqkvvpZUh2PWbQm5JyRPTOZwUsY3QS8KkhrwvQKb4N7ZegtS5MwdCcR3437xXw9sJ
         4c0zEecUWGzb6829IoQAu40+Y/87P6IN19ECNV3uQjyO+c1sIDLSKsJ7VjTo8MYUW11X
         Jse7injf5ZpjE1svMIXpUK7X8f5/NLwC3pCtAQ5dpExsXHjBOAmDaqRI8WHP2zht4VfS
         G9Qv34bzvEoCDzxSZA4BFaXJlfHk9fMxfRMXVj9pGhsK3SpquoK3sTSAaMBpuszswkPV
         qf00I9Y0AC0WNN8xmFx7HoYxHmD/W+2TOu1VzLIqwty2MIqFRDPwbxNrEWyjjEJx06iv
         FSSw==
X-Received: by 10.180.37.165 with SMTP id z5mr7749wij.10.1405611496016;
        Thu, 17 Jul 2014 08:38:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.197 with SMTP id eg5ls936688wic.1.canary; Thu, 17 Jul
 2014 08:38:15 -0700 (PDT)
X-Received: by 10.180.90.13 with SMTP id bs13mr2138310wib.6.1405611495384;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si374714wiw.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 644F21C01A6; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253754>

From: Karsten Blees <blees@dcon.de>

The environment on Windows is case-insensitive. Some environment functions
(such as unsetenv and make_augmented_environ) have always used case-
sensitive comparisons instead, while others (getenv, putenv, sorting in
spawn*) were case-insensitive.

Prevent potential inconsistencies by using case-insensitive comparison in
lookup_env (used by putenv, unsetenv and make_augmented_environ).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 47e866c..fe869ed 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1198,8 +1198,7 @@ static int lookup_env(char **env, const char *name, size_t nmln)
 	int i;
 
 	for (i = 0; env[i]; i++) {
-		if (0 == strncmp(env[i], name, nmln)
-		    && '=' == env[i][nmln])
+		if (!strncasecmp(env[i], name, nmln) && '=' == env[i][nmln])
 			/* matches */
 			return i;
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
