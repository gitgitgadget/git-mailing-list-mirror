From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 11/14] compat/nedmalloc/malloc.c.h: fix compilation
 under MinGW-W64
Date: Wed,  8 Oct 2014 22:01:04 +0400
Message-ID: <1412791267-13356-12-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBLP62WQQKGQESANTCYI@googlegroups.com Wed Oct 08 20:15:14 2014
Return-path: <msysgit+bncBCE7TAPITACRBLP62WQQKGQESANTCYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBLP62WQQKGQESANTCYI@googlegroups.com>)
	id 1XbvlW-0001Rq-KR
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:15:10 +0200
Received: by mail-lb0-f186.google.com with SMTP id z12sf846773lbi.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=gnj0GZ/BMghyZwtS9Z5vicnxeYie35pthG6O8IVMBWM=;
        b=Pm3Mfz/gqfZ+xMStzz3hDMec6fSppgNE24lytoH8Y4v7amz8PSCtfJRG4k4YQ5Uxme
         OvEV1rUX8+eX06OjTnWOpTzPvjGbfv0wNy6wh/iWJINjU3eSrdlicqDnfbSy1Wjr6js+
         7UO+GWqlY6NR6/La+t+QZwPcR0zhNjjbdYK7biN8/1Y7tkzKAZahIU9Aw6M8mXuqDwV0
         Ak4zhSo+B1sAVBwTX9S8Kq25eGG1npLdWrjmUFdr2luqC0TR1lmW8fJLCk0gtPqe3/G0
         sELfeRxJVQ86doahFm6S/wdd+FbE39vpzb7U49Lo6lSetPvvjmpFz1eyABSo5YfDFMmW
         zO8A==
X-Received: by 10.152.87.101 with SMTP id w5mr25180laz.13.1412792110454;
        Wed, 08 Oct 2014 11:15:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.18.131 with SMTP id w3ls95336lad.79.gmail; Wed, 08 Oct
 2014 11:15:08 -0700 (PDT)
X-Received: by 10.112.6.138 with SMTP id b10mr27953lba.18.1412792108814;
        Wed, 08 Oct 2014 11:15:08 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id rb5si152278lbb.0.2014.10.08.11.15.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:15:08 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvYF-0003Rz-Bh; Wed, 08 Oct 2014 22:01:27 +0400
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

1. Unlike MinGW, MinGW-W64 already provides _ReadWriteBarrier macro,
   so don't try to redefine it.

2. MinGW-W64 has a strange definition FORCEINLINE as
   extern __inline__ __attribute__((__always_inline__,__gnu_inline__))

   'extern' doesn't work together with 'static', so #undef MinGW-W64
   version of FORCEINLINE.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/nedmalloc/malloc.c.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..a6c8cac 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -715,6 +715,10 @@ struct mallinfo {
 #endif /* HAVE_USR_INCLUDE_MALLOC_H */
 #endif /* NO_MALLINFO */
 
+#ifdef __MINGW64_VERSION_MAJOR
+  #undef FORCEINLINE
+#endif
+
 /*
   Try to persuade compilers to inline. The most critical functions for
   inlining are defined as macros, so these aren't used for them.
@@ -1382,7 +1386,9 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 
   /*** Atomic operations ***/
   #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
-    #define _ReadWriteBarrier() __sync_synchronize()
+    #ifndef _ReadWriteBarrier
+      #define _ReadWriteBarrier() __sync_synchronize()
+    #endif
   #else
     static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
     {
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
