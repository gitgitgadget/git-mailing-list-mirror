From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 07/11] trace: move code around, in preparation to
 file:line output
Date: Fri, 20 Jun 2014 23:07:48 +0200
Message-ID: <53A4A2A4.9050906@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBI6FSKOQKGQE6VTNOPA@googlegroups.com Fri Jun 20 23:07:48 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBI6FSKOQKGQE6VTNOPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f190.google.com ([74.125.82.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBI6FSKOQKGQE6VTNOPA@googlegroups.com>)
	id 1Wy62F-0006vf-Ko
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:07:47 +0200
Received: by mail-we0-f190.google.com with SMTP id x48sf469316wes.17
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=fdejByTqVRNmIpSo4vEiTL02hxp6PJN4OwiNAsJGng8=;
        b=Ag+tP0gmDqARGEKVyjW/aOYGbDcaUQzLHLqw+VLOxj6pYaBTqh+OgeecKkApxk1+BS
         CyZRsCTnRXAsq+qq6v1BzDt7AI5WDCSiS8HNt+qrwEK/km1dFN5B0jsav4SiNXiRfsZl
         GULrB0S0qW3qnIfXi1mo0yLfplJNNf45xIayA3ZboH89rTG2mK2anw4BKD/u6ZDvjyAP
         osd2ToeMJdlkk60gPVjYzhs8D6Hd2AA149MiyNTUvI2fMQzTd/fyxPjnb09PB9RwNFm+
         hPckAX+ItSsgVT0hxDARluNGTXIaUSbnydGew8I/yNy+sW9zzEYu+sIXeKJkZU9WdCz8
         ujEg==
X-Received: by 10.180.208.50 with SMTP id mb18mr25503wic.9.1403298467393;
        Fri, 20 Jun 2014 14:07:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.4 with SMTP id dg4ls143200wib.32.canary; Fri, 20 Jun
 2014 14:07:46 -0700 (PDT)
X-Received: by 10.181.13.133 with SMTP id ey5mr544528wid.0.1403298466646;
        Fri, 20 Jun 2014 14:07:46 -0700 (PDT)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id r13si226899wib.0.2014.06.20.14.07.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:07:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235 as permitted sender) client-ip=2a00:1450:400c:c05::235;
Received: by mail-wi0-f181.google.com with SMTP id n3so1417546wiv.8
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:07:46 -0700 (PDT)
X-Received: by 10.180.79.9 with SMTP id f9mr6893392wix.52.1403298466542;
        Fri, 20 Jun 2014 14:07:46 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wi9sm17698805wjc.23.2014.06.20.14.07.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:07:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252286>

No functional changes, just move stuff around so that the next patch isn't
that ugly...

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 36 ++++++++++++++++++------------------
 trace.h | 12 ++++++++----
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/trace.c b/trace.c
index 9fa6cc7..869fb7b 100644
--- a/trace.c
+++ b/trace.c
@@ -127,20 +127,20 @@ static void trace_vprintf(const char *key, const char *format, va_list ap)
 	print_trace_line(key, &buf);
 }
 
-void trace_printf_key(const char *key, const char *format, ...)
+void trace_argv_printf(const char **argv, const char *format, ...)
 {
+	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	va_start(ap, format);
-	trace_vprintf(key, format, ap);
-	va_end(ap);
-}
 
-void trace_printf(const char *format, ...)
-{
-	va_list ap;
+	if (!prepare_trace_line("GIT_TRACE", &buf))
+		return;
+
 	va_start(ap, format);
-	trace_vprintf("GIT_TRACE", format, ap);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
+
+	sq_quote_argv(&buf, argv, 0);
+	print_trace_line("GIT_TRACE", &buf);
 }
 
 void trace_strbuf(const char *key, const struct strbuf *data)
@@ -154,20 +154,20 @@ void trace_strbuf(const char *key, const struct strbuf *data)
 	print_trace_line(key, &buf);
 }
 
-void trace_argv_printf(const char **argv, const char *format, ...)
+void trace_printf(const char *format, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-
-	if (!prepare_trace_line("GIT_TRACE", &buf))
-		return;
-
 	va_start(ap, format);
-	strbuf_vaddf(&buf, format, ap);
+	trace_vprintf("GIT_TRACE", format, ap);
 	va_end(ap);
+}
 
-	sq_quote_argv(&buf, argv, 0);
-	print_trace_line("GIT_TRACE", &buf);
+void trace_printf_key(const char *key, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
+	va_end(ap);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index e03db2f..5c7f2dc 100644
--- a/trace.h
+++ b/trace.h
@@ -4,14 +4,18 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
-__attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
-__attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
+
+__attribute__((format (printf, 1, 2)))
+extern void trace_printf(const char *format, ...);
+
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(const char *key, const char *format, ...);
+
+__attribute__((format (printf, 2, 3)))
+extern void trace_argv_printf(const char **argv, const char *format, ...);
+
 extern void trace_strbuf(const char *key, const struct strbuf *data);
 
 #endif /* TRACE_H */
-- 
2.0.0.402.g13b8b25

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
