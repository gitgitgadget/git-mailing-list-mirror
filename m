From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 13/14] git-compat-util.h: fix integer overflow on
 IL32P64 systems
Date: Wed,  8 Oct 2014 22:01:06 +0400
Message-ID: <1412791267-13356-14-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBJH62WQQKGQE3OH6DVI@googlegroups.com Wed Oct 08 20:15:03 2014
Return-path: <msysgit+bncBCE7TAPITACRBJH62WQQKGQE3OH6DVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f60.google.com ([74.125.83.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBJH62WQQKGQE3OH6DVI@googlegroups.com>)
	id 1XbvlN-0001Lx-0y
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:15:01 +0200
Received: by mail-ee0-f60.google.com with SMTP id e51sf844530eek.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=eHdv3LXfp6Eo0Y8CpBi8zDvFWsMfNDlS0He8rD+SgjA=;
        b=BWIH5YTESdbZdF1XE6qphq7Gp38loftFHlkTNYR/lAa7QGJp28slzYneHprOcWI8QC
         5MPk1kvrtTbkJZQuGciklNkLgEKCyhdr4IZUl8i/QsK9PxU97pAqj8jEKRVGR7S41ASl
         7deMBl9xu7+HpR46siNDE2/63WgOpaAj4N+zmuemVfAdQ+NvGphC4tRqRq8HOe4hqLfe
         6Ccm98O/pWUYPBSNHZUUSPJirx5hV7arstZBvRjYASaSlu7vd5BTX0uELcO77q9Eq6BD
         sqTkN/N3zBEu7uqnGcoKMuvZe13RDplIqsA3ftW5W+pi6VUA9IJL1l19ce3ZZeqr7lud
         eeCg==
X-Received: by 10.181.13.172 with SMTP id ez12mr92477wid.8.1412792100772;
        Wed, 08 Oct 2014 11:15:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.101 with SMTP id gd5ls139737wib.16.gmail; Wed, 08 Oct
 2014 11:15:00 -0700 (PDT)
X-Received: by 10.180.106.197 with SMTP id gw5mr4753869wib.1.1412792100229;
        Wed, 08 Oct 2014 11:15:00 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id us10si125712lbc.1.2014.10.08.11.15.00
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:15:00 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvYI-0003Rz-64; Wed, 08 Oct 2014 22:01:30 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
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

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b338277..101c9d7 100644
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
