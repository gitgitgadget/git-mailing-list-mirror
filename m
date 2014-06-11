From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 3/7] Win32: fix potential multi-threading issue
Date: Wed, 11 Jun 2014 11:37:42 +0200
Message-ID: <1402479466-8500-4-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:07 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jm-3F
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-lb0-f190.google.com with SMTP id p9sf1016671lbv.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=desF9fuxkSREOug6vpOdb/xucQDytnqcQDrJvJMIdqg=;
        b=PoIwT29r6LKxsTtDbg7/549wRubAf9U1p7J3m4QWLZuYE3Em4BrVX/S9cIgNhdw5ey
         BO8wiM2mfJ4VFRxGzWi66mKFtTz1MgHweMUbbjdILoAUOkDEZfYvVtKqFpR7wxfg+Q/1
         13YfZyJMF87bPZ7KZWUomn8i6p+2Bjoyt6CLo/4rKNtcOGxMORGIHNQwuwjCBQKe0Kqj
         YS3PN0gVSBopyyrBQl3ZDdo0kubgt8zVr7URn5GuVXsjQZZkc3p/XEhMBpn9YcaGguct
         9g8t/dXniWvOjwbnxo6httCur4e/4vE5QLitf/4aHJ77DRsNNfApYsDP7L8Zw7vHpt/N
         WBgA==
X-Received: by 10.180.149.211 with SMTP id uc19mr132154wib.1.1402479485939;
        Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.186.8 with SMTP id fg8ls245945wic.7.gmail; Wed, 11 Jun
 2014 02:38:04 -0700 (PDT)
X-Received: by 10.194.6.138 with SMTP id b10mr229368wja.0.1402479484793;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id eh2si1288589wib.2.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 939621C00A9; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251353>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 18:04:16 +0100

...by removing a static buffer in do_stat_internal.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1c0b153..6849815 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -441,7 +441,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 {
 	int namelen;
-	static char alt_name[PATH_MAX];
+	char alt_name[PATH_MAX];
 
 	if (!do_lstat(follow, file_name, buf))
 		return 0;
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
