From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 14:51:19 +0100
Message-ID: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBV5LQ6FAKGQETCXGXMQ@googlegroups.com Thu Mar 14 14:51:43 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBV5LQ6FAKGQETCXGXMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBV5LQ6FAKGQETCXGXMQ@googlegroups.com>)
	id 1UG8ZK-0007FE-Qr
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 14:51:42 +0100
Received: by mail-we0-f192.google.com with SMTP id u54sf630039wey.29
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:mime-version:x-beenthere:x-received:received-spf
         :x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=ck3GJkCSbG0BXNxxkxJKn7dSy8Z6jp7uFCDO6HODNg0=;
        b=Ux8RRn8Nr7jzfLqJZQxYEw83ISBUZFcKshBICjhr+LIZlDQtLCyEAoBTdFHyzxnFqu
         Fqx5O799JHIjlMiRs+rpJu4lqPur9XltIREqi8mS/+Uzu61r7RSLdHnNbCKck5GzHKwt
         efu1UeeabhAKkyBG46VvmwwJhlzYqLaNeVhOoqx1IsfModicEHrW9hzgl0vzbguP6C5V
         zmMEriHo2n8746BNzYwKnPkrMWL1l2yJ7cNDv3I0Wz2ra+rh12SpxUsYeIuop+4+sNLm
         AfFvkJf4P+r9aiuJQTGq8Mwpf1OtV2Xy85CBcrnW4afqLhMBcdb6YNQUejzv6f1A4fbC
        
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:x-beenthere:x-received:received-spf
         :x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=ck3GJkCSbG0BXNxxkxJKn7dSy8Z6jp7uFCDO6HODNg0=;
        b=J9Dijv84T8ZxdGO3iXmSul4qOd6OFlMVntVTouw0ndF1m8XhTRLSqHE9Y27T7UAF6f
         XMbVGdaGF/lBakzdLWfAUPpU+8G/Ylo+fFY8b33g5LsfKR793uZ8KYa+v/aPLEhAy1s3
         sYsnlRY2H/C0roxwSE8bGsbQmt22BSYdGefWTd4Hu+oT5ZDr7fzuIQgZfvYSdq8Bl55L
         dG+6GqdD+AUic72sm2BNnjdg56eceF9bfL3/mhPtZGJ9SnGUD+N/BYpN7P6acpFERzIy
         nxScXLbfRHulvKFQjKHhEBSpIAeAua00YkvB5MFlWcO+MMOnJRqW/gUxSVTx0b7xTTIk
         iSlw= 
X-Received: by 10.180.88.4 with SMTP id bc4mr2484854wib.19.1363269080413;
        Thu, 14 Mar 2013 06:51:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.101.136 with SMTP id fg8ls1724397wib.8.canary; Thu, 14 Mar
 2013 06:51:19 -0700 (PDT)
X-Received: by 10.205.24.134 with SMTP id re6mr286467bkb.7.1363269079624;
        Thu, 14 Mar 2013 06:51:19 -0700 (PDT)
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com [209.85.217.180])
        by gmr-mx.google.com with ESMTPS id i9si226657bki.2.2013.03.14.06.51.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 06:51:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.180 as permitted sender) client-ip=209.85.217.180;
Received: by mail-lb0-f180.google.com with SMTP id q12so1865890lbc.25
        for <msysgit@googlegroups.com>; Thu, 14 Mar 2013 06:51:19 -0700 (PDT)
X-Received: by 10.112.44.66 with SMTP id c2mr1164957lbm.69.1363269079389;
        Thu, 14 Mar 2013 06:51:19 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id mq7sm1231452lab.1.2013.03.14.06.51.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 06:51:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.msysgit.0.3.gd0186ec
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 209.85.217.180 as
 permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218137>

Since ancient times, we have been calling curl_global_init with the
CURL_GLOBAL_ALL-flag, which initializes SSL (and the Win32 socket
stack on Windows).

Initializing SSL takes quite some time on Windows, so let's avoid
doing it when it's not needed.

timing of echo "" | ./git-remote-http.exe origin http://localhost

before

best of 10 runs:
real    0m1.634s
user    0m0.015s
sys     0m0.000s

worst of 10 runs:
real    0m2.701s
user    0m0.000s
sys     0m0.000s

after

best of 10 runs:
real    0m0.018s
user    0m0.000s
sys     0m0.000s

worst of 10 runs:
real    0m0.024s
user    0m0.000s
sys     0m0.015s

Signed-off-by: Erik Faye-Lund <erik.faye-lund@hue.no>
---
 http.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 3b312a8..528a736 100644
--- a/http.c
+++ b/http.c
@@ -343,7 +343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	git_config(http_options, NULL);
 
-	curl_global_init(CURL_GLOBAL_ALL);
+	curl_global_init(CURL_GLOBAL_WIN32 | (prefixcmp(url, "https:") ? 0 :
+	    CURL_GLOBAL_SSL));
 
 	http_proactive_auth = proactive_auth;
 
-- 
1.8.0.msysgit.0.3.gd0186ec

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
For more options, visit https://groups.google.com/groups/opt_out.
