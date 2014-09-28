From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 13/14] git-compat-util.h: fix integer overflow on
 IL32P64 systems
Date: Sun, 28 Sep 2014 17:24:29 +0400
Message-ID: <1411910670-31285-14-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBVU2UCQQKGQEHYTQT6Q@googlegroups.com Sun Sep 28 15:29:59 2014
Return-path: <msysgit+bncBCE7TAPITACRBVU2UCQQKGQEHYTQT6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBVU2UCQQKGQEHYTQT6Q@googlegroups.com>)
	id 1XYEY2-0001Ys-M6
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:29:58 +0200
Received: by mail-lb0-f184.google.com with SMTP id p9sf98173lbv.11
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X3MQPXvRnkFle5T8VeR/B2Eu8kNwKiKyNTLfWpJK6Q0=;
        b=Uu/xsRuGUzNV+hLZJP8eAINnE5bCfHvii3RMTVk3ad9I9LAs5mMGQH+aR62zQyfklP
         JN7HvTIqrFT5jjrKBGFZZEi2aqOOXRSIun5esrEaB8oQ5RVwOU5226dfa4XO/npAqANk
         Gv3fuZzFW+K+k1JZM4vlHprlL+M1ZxMgHAQDpJ1yjvsUBHOZP56gbXnqoACxMTvOs1oq
         TYKO5iY1UuMOtSwcYc/DN8OEpkCpl3M/Oacx6MJgaO7eLhJR1bTPnwFaREhGd5AOw25L
         Xf8YnLRz8AfMCwbmjambiZ0FEENanx7p6F4TFD8ku7qcfHT2LC9zb4qmqetlEjSd7g7k
         BOEw==
X-Received: by 10.180.20.211 with SMTP id p19mr301517wie.2.1411910998486;
        Sun, 28 Sep 2014 06:29:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.92.8 with SMTP id ci8ls356228wib.19.gmail; Sun, 28 Sep
 2014 06:29:57 -0700 (PDT)
X-Received: by 10.194.249.134 with SMTP id yu6mr35510wjc.1.1411910997860;
        Sun, 28 Sep 2014 06:29:57 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id i6si429601wiy.0.2014.09.28.06.29.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:29:57 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEUD-0000Yl-1l; Sun, 28 Sep 2014 17:26:01 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257608>

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9d2d5ab..5f6659c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -474,7 +474,7 @@ extern int git_munmap(void *start, size_t length);
 #endif
 
 #define DEFAULT_PACKED_GIT_LIMIT \
-	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
+	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
 
 #ifdef NO_PREAD
 #define pread git_pread
-- 
2.1.1

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
