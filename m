From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 4/7] MinGW: disable CRT command line globbing
Date: Wed, 11 Jun 2014 11:37:43 +0200
Message-ID: <1402479466-8500-5-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7WG4COAKGQEYZ4OADI@googlegroups.com Wed Jun 11 11:38:08 2014
Return-path: <msysgit+bncBCU63DXMWULRB7WG4COAKGQEYZ4OADI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7WG4COAKGQEYZ4OADI@googlegroups.com>)
	id 1Wueyt-0004KU-6y
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:07 +0200
Received: by mail-wg0-f63.google.com with SMTP id x12sf659184wgg.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ZqwazruxtK7YEIqh5TsxPTj3Jxe3OWbjcK3R8bFCYqs=;
        b=h969xsb2MJrOvw64KAt9u24Dn7EdLpuSma8lzjE6Q4vYDwx/LdO6uB8xn6P9xGWFXO
         622SK8Kz1caGxWaG643B+nN8MIwvdsGAlrUcVVLsAkuSV/EBkE2v5peHOA1pQEnBvZ4F
         Vfse+9w0pY/L5qkQhnhQPDYsht65QFbL8pNf2R8R9U6Hg54jff9LyUKEe6iHFyrcRQET
         JDaL5/gKbmiP0BAp9BMOxePc/q4xIPm8SI8qqT+D780RvVGv4aUkKwmxFx/n3rXxVjzj
         u5WkwDfjS5hJMFLCQ06TZ33++hgrqASeqA9gFI8TwfW8Oe61ZENDVyHl5w4fRUP6WohU
         Y0vA==
X-Received: by 10.180.89.231 with SMTP id br7mr7681wib.8.1402479486949;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.101.132 with SMTP id fg4ls164640wib.28.canary; Wed, 11 Jun
 2014 02:38:06 -0700 (PDT)
X-Received: by 10.194.3.34 with SMTP id 2mr192110wjz.4.1402479486184;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id e12si1287038wiv.1.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 98BA61C00AA; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251354>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 19:52:20 +0100

MingwRT listens to _CRT_glob to decide if __getmainargs should
perform globbing, with the default being that it should.
Unfortunately, __getmainargs globbing is sub-par; for instance
patterns like "*.c" will only match c-sources in the current
directory.

Disable __getmainargs' command line wildcard expansion, so these
patterns will be left untouched, and handled by Git's superior
built-in globbing instead.

MSVC defaults to no globbing, so we don't need to do anything
in that case.

This fixes t5505 and t7810.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6849815..1140a13 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1927,6 +1927,12 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 	return -1;
 }
 
+/*
+ * Disable MSVCRT command line wildcard expansion (__getmainargs called from
+ * mingw startup code, see init.c in mingw runtime).
+ */
+int _CRT_glob = 0;
+
 void mingw_startup()
 {
 	/* copy executable name to argv[0] */
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
