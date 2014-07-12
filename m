From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 15/17] wt-status: simplify performance
 measurement by using getnanotime()
Date: Sat, 12 Jul 2014 02:07:36 +0200
Message-ID: <53C07C48.2000004@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBRHYQGPAKGQEQFCKSBY@googlegroups.com Sat Jul 12 02:07:34 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBRHYQGPAKGQEQFCKSBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBRHYQGPAKGQEQFCKSBY@googlegroups.com>)
	id 1X5kqj-0007oW-SW
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:07:33 +0200
Received: by mail-lb0-f192.google.com with SMTP id w7sf187070lbi.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=d/PRCVB0on0HdCOc8bNUBTjULXHe8jHwMRFsn9ntqAA=;
        b=J7ZGnI53jAA7CBbdqvHHxxTAocFBE8irsr/SiD9NkAu8j1Rb7HCdl9aLEj5FAtV+Wo
         99dUV4X14TWyBHQDvtPbC2eJETn2NArDZ0HszHj+TzpykBLk0dU6RNq9O970371SKzHT
         lmLhxDjSfdgmV37t1mNPYp9UxXAUQgICmYxs4w6oghQQmq860EmycYSqphEiBP/6hL7i
         RG/p2eTTKZMp0r4ssAa48WUAZzMSVA/9Vv9TvrBwO6t2I8n7vIXHs+TpbmKcKUqeOSkf
         16ON/mhpg8YsqskmxCCDZ/n4j8b/tNhdBReGARxkkzVlOt8SZ90LAVJzR9c1+elaBsJM
         PUHA==
X-Received: by 10.152.10.35 with SMTP id f3mr17873lab.6.1405123653719;
        Fri, 11 Jul 2014 17:07:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.38 with SMTP id cr6ls137630lad.7.gmail; Fri, 11 Jul 2014
 17:07:32 -0700 (PDT)
X-Received: by 10.112.252.167 with SMTP id zt7mr1400lbc.19.1405123652364;
        Fri, 11 Jul 2014 17:07:32 -0700 (PDT)
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com [2a00:1450:400c:c05::22d])
        by gmr-mx.google.com with ESMTPS id gg16si3603wic.2.2014.07.11.17.07.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:07:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d as permitted sender) client-ip=2a00:1450:400c:c05::22d;
Received: by mail-wi0-f173.google.com with SMTP id cc10so22862wib.12
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:07:32 -0700 (PDT)
X-Received: by 10.194.10.167 with SMTP id j7mr2926085wjb.100.1405123652263;
        Fri, 11 Jul 2014 17:07:32 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pc4sm345353wic.16.2014.07.11.17.07.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:07:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253370>

Calculating duration from a single uint64_t is simpler than from a struct
timeval. Change performance measurement for 'advice.statusuoption' from
gettimeofday() to getnanotime().

Also initialize t_begin to prevent uninitialized variable warning.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 318a191..dfdc018 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -574,14 +574,11 @@ static void wt_status_collect_untracked(struct wt_status *s)
 {
 	int i;
 	struct dir_struct dir;
-	struct timeval t_begin;
+	uint64_t t_begin = getnanotime();
 
 	if (!s->show_untracked_files)
 		return;
 
-	if (advice_status_u_option)
-		gettimeofday(&t_begin, NULL);
-
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
@@ -612,13 +609,8 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	free(dir.ignored);
 	clear_directory(&dir);
 
-	if (advice_status_u_option) {
-		struct timeval t_end;
-		gettimeofday(&t_end, NULL);
-		s->untracked_in_ms =
-			(uint64_t)t_end.tv_sec * 1000 + t_end.tv_usec / 1000 -
-			((uint64_t)t_begin.tv_sec * 1000 + t_begin.tv_usec / 1000);
-	}
+	if (advice_status_u_option)
+		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
 void wt_status_collect(struct wt_status *s)
-- 
2.0.0.406.g2e9ef9b

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
