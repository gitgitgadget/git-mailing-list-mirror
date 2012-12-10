From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCHv2] mingw_rmdir: do not prompt for retry when non-empty
Date: Mon, 10 Dec 2012 15:42:27 +0100
Message-ID: <1355150547-8212-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB2XJS6DAKGQEISMF5YY@googlegroups.com Mon Dec 10 15:43:08 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB2XJS6DAKGQEISMF5YY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB2XJS6DAKGQEISMF5YY@googlegroups.com>)
	id 1Ti4ZT-0000bu-UB
	for gcvm-msysgit@m.gmane.org; Mon, 10 Dec 2012 15:43:04 +0100
Received: by mail-ee0-f58.google.com with SMTP id e49sf1200224eek.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 10 Dec 2012 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6WlDPfDJlldS8UhyXwkRoZmUa5F3pgbKGDxIKup/9MQ=;
        b=D/S0jE0vZSCEdci3SnzniAw0XzvKIOk3GU32UbFjvaTvSFwJv15kvhXFcimYeCGmvM
         pzhNL4xu8OmmOwkHH0yRdWhuDezQVx3BIENmDh9RqJOOf343aEgtXOWb0NNu9vkRheVY
         4v/Zp5xWyq2O+PSifXpDgt9hZJzbkDQho4ZBfnCaFZkjC+L2RseQ/tJEr4BYiIEUVHJP
         1YgRr/4cF3Tn0mLK/Oqfqc5ZHnqcU8n89k6RByZsiqwgfBBklQAQ95os7o48XWmfIatM
         z9njkOSzVyGb4Ju4dTjkJix5Yznglwl0z8UHvZ9tQKOcrRufAb3PIxeUqs0Qgch2mx8m
         dz+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=6WlDPfDJlldS8UhyXwkRoZmUa5F3pgbKGDxIKup/9MQ=;
        b=ozUCd2q9WqGSvrSU9e86bVp6/Vy9QLuulE/HjzNjNvz1rmeK4B5AfxB5fQ7odbcGpi
         +wy7dc7BWvCmDYYZNpL2dizTpkBaBKISw44i7VURGSJTyPpN4POSEe/ykBG8Rg50+IPx
         y2IFj/NCff/Oen0dEMKsMgqzO5uFlgfw5eAiIYYOJmGSB+mQr5AO2ikwQyOvABojxLML
         QQFjsw0WhPfgxxMhYXGgdAkM7f3Su9/oCLBnw5bOuA+hudJP1q04fgdGnIer+9ALKyUG
         Rs3cEteav8C/Y/H5JJJBWEN/rs65iypnICXzbpSW+NfepTETFkfhnukK3ZKIdJMWSCaQ
         sS4g==
Received: by 10.180.99.7 with SMTP id em7mr1048581wib.1.1355150571446;
        Mon, 10 Dec 2012 06:42:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.66 with SMTP id n2ls959206wiz.9.canary; Mon, 10 Dec
 2012 06:42:49 -0800 (PST)
Received: by 10.204.130.141 with SMTP id t13mr2183178bks.3.1355150569836;
        Mon, 10 Dec 2012 06:42:49 -0800 (PST)
Received: by 10.204.130.141 with SMTP id t13mr2183177bks.3.1355150569822;
        Mon, 10 Dec 2012 06:42:49 -0800 (PST)
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com [209.85.214.48])
        by gmr-mx.google.com with ESMTPS id v18si2881131bkw.1.2012.12.10.06.42.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2012 06:42:49 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.214.48 as permitted sender) client-ip=209.85.214.48;
Received: by mail-bk0-f48.google.com with SMTP id jc3so1372953bkc.21
        for <msysgit@googlegroups.com>; Mon, 10 Dec 2012 06:42:49 -0800 (PST)
Received: by 10.204.0.70 with SMTP id 6mr4434738bka.104.1355150569575;
        Mon, 10 Dec 2012 06:42:49 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id u3sm14279967bkw.9.2012.12.10.06.42.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2012 06:42:48 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.3.gafa53b0.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.214.48 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211256>

in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
a check was added to prevent us from retrying to delete a directory
that is both in use and non-empty.

However, this logic was slightly flawed; since we didn't return
immediately, we end up falling out of the retry-loop, but right into
the prompting-loop.

Fix this by setting errno, and guarding the prompting-loop with an
errno-check.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's the second version of this patch, sorry for the slight delay.

 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1eb974f..440224c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -260,6 +260,8 @@ int mingw_rmdir(const char *pathname)
 
 	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
+			errno = err_win_to_posix(GetLastError());
+		if (errno != EACCES)
 			break;
 		if (!is_dir_empty(wpathname)) {
 			errno = ENOTEMPTY;
@@ -275,7 +277,7 @@ int mingw_rmdir(const char *pathname)
 		Sleep(delay[tries]);
 		tries++;
 	}
-	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
+	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
 	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
 			"Should I try again?", pathname))
 	       ret = _wrmdir(wpathname);
-- 
1.8.0.msysgit.0.3.gafa53b0.dirty

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
