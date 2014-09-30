From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 13/14] git-compat-util.h: fix integer overflow on
 IL32P64 systems
Date: Tue, 30 Sep 2014 11:02:42 +0400
Message-ID: <1412060563-22041-14-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB6FQVGQQKGQEHQIVP7Y@googlegroups.com Tue Sep 30 09:15:05 2014
Return-path: <msysgit+bncBCE7TAPITACRB6FQVGQQKGQEHQIVP7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB6FQVGQQKGQEHQIVP7Y@googlegroups.com>)
	id 1XYreL-0004n6-3J
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:15:05 +0200
Received: by mail-wg0-f58.google.com with SMTP id k14sf950214wgh.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X3MQPXvRnkFle5T8VeR/B2Eu8kNwKiKyNTLfWpJK6Q0=;
        b=xnk6mSTPesB8ijLuGobJu/+8X+9/RUxPOiFd/J/BpjkExW60mQn3nGMMTBdndkPLJ7
         QrgP5ak/E2MoDO4PEnsHH+27DyA52DZIWvCJSh8Q0m79Zw6UE5mnooYqe6m0idvaNZWe
         u6GbEpuDqUdlSwSEayExrhoNhUAesPlbN3H7KQnMhDIYgrd1qtTcp4nDbpZhPXmTktvi
         mXl/a553mQwqtHRMIT+g8dvHg7FcXkJR3RTKmO0e/mGj3XG6VSeHrh0o9u3gcPwZPvxx
         8H7yt5W5ml5h/L9Q5hrv/ftRjmVb/QvVR4+maVPn/XxTMciXsNOybHVFUPG8u6sN8oj+
         CxVQ==
X-Received: by 10.180.78.101 with SMTP id a5mr16927wix.19.1412061304838;
        Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.89.99 with SMTP id bn3ls8132wib.8.gmail; Tue, 30 Sep 2014
 00:15:04 -0700 (PDT)
X-Received: by 10.180.87.228 with SMTP id bb4mr515490wib.3.1412061304389;
        Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id go4si736608wib.3.2014.09.30.00.15.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:15:04 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSw-0004X0-37; Tue, 30 Sep 2014 11:03:18 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257659>

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
