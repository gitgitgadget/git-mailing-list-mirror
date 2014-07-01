From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 15/16] wt-status: simplify performance
 measurement by using getnanotime()
Date: Wed, 02 Jul 2014 01:04:32 +0200
Message-ID: <53B33E80.8020306@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBAH5ZSOQKGQEXFCB56Y@googlegroups.com Wed Jul 02 01:04:32 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBAH5ZSOQKGQEXFCB56Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBAH5ZSOQKGQEXFCB56Y@googlegroups.com>)
	id 1X276G-0005tj-Ll
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:04:32 +0200
Received: by mail-la0-f64.google.com with SMTP id mc6sf1003176lab.19
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jbSDIcWMP5Ex+AlV66+yWzd56i8ONdaBzUomu5aovmU=;
        b=c3jDwfvt2OzYbrge2eFJUyxgUAncX4xBcVBfY80f/GUxCZPjDByzK2uYWTe2JAGsnm
         BBHxmtJuqRXFdTVgX3duSeE0CTh9obMS73ghjZFV7xkS8j/cgT6TYWkOCaSLu0Vu9Lb1
         Y4P9qYIsMRJq/mmVcyMfvCQJJp58ba/8b8u6Nbu5pWgA2fVFFivDq3Doq+GEtbclzisU
         8Uke/eRjzDusUD+Ybfc2JOsRWj9Jf0lbXYK3kMeTqUF7MYe5mj5rO5leWXcbc8uRYHL4
         s/ydH/LkBsk0ZBhvUvN2V3thImiYYlDENuPsy5J/VpJAAMNz49UDH4Qsrlpm4AMw4cHW
         I9Xg==
X-Received: by 10.180.91.107 with SMTP id cd11mr2397wib.12.1404255872462;
        Tue, 01 Jul 2014 16:04:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.229 with SMTP id u5ls641078wia.30.canary; Tue, 01 Jul
 2014 16:04:31 -0700 (PDT)
X-Received: by 10.180.13.18 with SMTP id d18mr3853373wic.2.1404255871695;
        Tue, 01 Jul 2014 16:04:31 -0700 (PDT)
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com [2a00:1450:400c:c03::22a])
        by gmr-mx.google.com with ESMTPS id b9si330228wic.2.2014.07.01.16.04.31
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:04:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a as permitted sender) client-ip=2a00:1450:400c:c03::22a;
Received: by mail-we0-f170.google.com with SMTP id w61so10346065wes.15
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:04:31 -0700 (PDT)
X-Received: by 10.180.19.65 with SMTP id c1mr40165285wie.16.1404255871596;
        Tue, 01 Jul 2014 16:04:31 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q11sm48248006wib.14.2014.07.01.16.04.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:04:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252764>

Calculating duration from a single uint64_t is simpler than from a struct
timeval. Change performance measurement for 'advice.statusuoption' from
gettimeofday() to getnanotime().

Also initialize t_begin to prevent uninitialized variable warning.

Signed-off-by: Karsten Blees <blees@dcon.de>
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
