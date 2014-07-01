From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 16/16] progress: simplify performance measurement
 by using getnanotime()
Date: Wed, 02 Jul 2014 01:05:14 +0200
Message-ID: <53B33EAA.4050407@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBKX5ZSOQKGQEEKD6HYQ@googlegroups.com Wed Jul 02 01:05:18 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBKX5ZSOQKGQEEKD6HYQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBKX5ZSOQKGQEEKD6HYQ@googlegroups.com>)
	id 1X276x-0006Ih-Be
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:05:15 +0200
Received: by mail-la0-f64.google.com with SMTP id mc6sf995160lab.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=qPK+Jkk0Ed8foVjxPbnPopNb/9YL30FnzWSJYuqBlgs=;
        b=Rcb9CRVqq56K/yq2jembc5SwGpPeQSf5JK2RB+9VpBvVBtaKjNK0Ud/3B4uFIDD9/P
         i7noOVt+f17BNj4kqgUKvqr++kyIfRCWq4B/Ad0vkt4hh3xU3C0ojIsuvHb12ePBpdrD
         G0zUpk4mZ6e51aqTUDyVaRmbX5ktGi9TVGX0F/5nqUuRiKFJgpZ0rXf3LSA2URuTclg1
         yi/RhtdXGA7thja0ghQkN/XH79bj2EovgANEbT37t57NYX8Ojm+erh1JJAn5fG8+ruke
         kSOU4SMYctMg0vNZpqRlqWhU9e5HFkr9y6F+Zzj5eRBu8+PCO58X/mVF+UMVrBorXOgr
         5NeA==
X-Received: by 10.180.108.79 with SMTP id hi15mr141769wib.19.1404255915182;
        Tue, 01 Jul 2014 16:05:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.33 with SMTP id gj1ls27730wib.33.gmail; Tue, 01 Jul
 2014 16:05:14 -0700 (PDT)
X-Received: by 10.180.13.196 with SMTP id j4mr3863796wic.0.1404255914484;
        Tue, 01 Jul 2014 16:05:14 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id cj4si811390wid.0.2014.07.01.16.05.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:05:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-x22e.google.com with SMTP id bs8so8674645wib.13
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:05:14 -0700 (PDT)
X-Received: by 10.180.84.168 with SMTP id a8mr39350285wiz.36.1404255914417;
        Tue, 01 Jul 2014 16:05:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id dt7sm48259233wic.6.2014.07.01.16.05.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:05:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252765>

Calculating duration from a single uint64_t is simpler than from a struct
timeval. Change throughput measurement from gettimeofday() to
getnanotime().

Also calculate misec only if needed, and change integer division to integer
multiplication + shift, which should be slightly faster.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 progress.c | 71 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/progress.c b/progress.c
index 261314e..412e6b1 100644
--- a/progress.c
+++ b/progress.c
@@ -12,13 +12,14 @@
 #include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
+#include "trace.h"
 
 #define TP_IDX_MAX      8
 
 struct throughput {
 	off_t curr_total;
 	off_t prev_total;
-	struct timeval prev_tv;
+	uint64_t prev_ns;
 	unsigned int avg_bytes;
 	unsigned int avg_misecs;
 	unsigned int last_bytes[TP_IDX_MAX];
@@ -127,65 +128,65 @@ static void throughput_string(struct strbuf *buf, off_t total,
 void display_throughput(struct progress *progress, off_t total)
 {
 	struct throughput *tp;
-	struct timeval tv;
-	unsigned int misecs;
+	uint64_t now_ns;
+	unsigned int misecs, count, rate;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!progress)
 		return;
 	tp = progress->throughput;
 
-	gettimeofday(&tv, NULL);
+	now_ns = getnanotime();
 
 	if (!tp) {
 		progress->throughput = tp = calloc(1, sizeof(*tp));
 		if (tp) {
 			tp->prev_total = tp->curr_total = total;
-			tp->prev_tv = tv;
+			tp->prev_ns = now_ns;
 		}
 		return;
 	}
 	tp->curr_total = total;
 
+	/* only update throughput every 0.5 s */
+	if (now_ns - tp->prev_ns <= 500000000)
+		return;
+
 	/*
-	 * We have x = bytes and y = microsecs.  We want z = KiB/s:
+	 * We have x = bytes and y = nanosecs.  We want z = KiB/s:
 	 *
-	 *	z = (x / 1024) / (y / 1000000)
-	 *	z = x / y * 1000000 / 1024
-	 *	z = x / (y * 1024 / 1000000)
+	 *	z = (x / 1024) / (y / 1000000000)
+	 *	z = x / y * 1000000000 / 1024
+	 *	z = x / (y * 1024 / 1000000000)
 	 *	z = x / y'
 	 *
 	 * To simplify things we'll keep track of misecs, or 1024th of a sec
 	 * obtained with:
 	 *
-	 *	y' = y * 1024 / 1000000
-	 *	y' = y / (1000000 / 1024)
-	 *	y' = y / 977
+	 *	y' = y * 1024 / 1000000000
+	 *	y' = y * (2^10 / 2^42) * (2^42 / 1000000000)
+	 *	y' = y / 2^32 * 4398
+	 *	y' = (y * 4398) >> 32
 	 */
-	misecs = (tv.tv_sec - tp->prev_tv.tv_sec) * 1024;
-	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
+	misecs = ((now_ns - tp->prev_ns) * 4398) >> 32;
 
-	if (misecs > 512) {
-		struct strbuf buf = STRBUF_INIT;
-		unsigned int count, rate;
+	count = total - tp->prev_total;
+	tp->prev_total = total;
+	tp->prev_ns = now_ns;
+	tp->avg_bytes += count;
+	tp->avg_misecs += misecs;
+	rate = tp->avg_bytes / tp->avg_misecs;
+	tp->avg_bytes -= tp->last_bytes[tp->idx];
+	tp->avg_misecs -= tp->last_misecs[tp->idx];
+	tp->last_bytes[tp->idx] = count;
+	tp->last_misecs[tp->idx] = misecs;
+	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-		count = total - tp->prev_total;
-		tp->prev_total = total;
-		tp->prev_tv = tv;
-		tp->avg_bytes += count;
-		tp->avg_misecs += misecs;
-		rate = tp->avg_bytes / tp->avg_misecs;
-		tp->avg_bytes -= tp->last_bytes[tp->idx];
-		tp->avg_misecs -= tp->last_misecs[tp->idx];
-		tp->last_bytes[tp->idx] = count;
-		tp->last_misecs[tp->idx] = misecs;
-		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
-
-		throughput_string(&buf, total, rate);
-		strncpy(tp->display, buf.buf, sizeof(tp->display));
-		strbuf_release(&buf);
-		if (progress->last_value != -1 && progress_update)
-			display(progress, progress->last_value, NULL);
-	}
+	throughput_string(&buf, total, rate);
+	strncpy(tp->display, buf.buf, sizeof(tp->display));
+	strbuf_release(&buf);
+	if (progress->last_value != -1 && progress_update)
+		display(progress, progress->last_value, NULL);
 }
 
 int display_progress(struct progress *progress, unsigned n)
-- 
2.0.0.406.ge74f8ff

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
