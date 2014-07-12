From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 10/17] trace: move code around, in preparation to
 file:line output
Date: Sat, 12 Jul 2014 02:04:29 +0200
Message-ID: <53C07B8D.9050308@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBCXXQGPAKGQE3XX2HIQ@googlegroups.com Sat Jul 12 02:04:28 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBCXXQGPAKGQE3XX2HIQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBCXXQGPAKGQE3XX2HIQ@googlegroups.com>)
	id 1X5knj-0004sA-Cs
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:04:27 +0200
Received: by mail-wi0-f183.google.com with SMTP id q5sf1022wiv.10
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=c6toQIb4FIenjLszf2tDsNZ3cJeHkqZJ7vd4iFyumbQ=;
        b=bOJ4mlKw0g5nb/hthiudBQGudl2DNzHvQ5jZiZcQRAdXBb+3BUJEPs1iIIVnkqjcqJ
         eLZSlH03XDgBDDHGA+WPsz5J3P3zs1aa2Ptc/QIG2l3kahW8bB9WwN+btu/2aT2IbFdC
         FUyK778zv3SdOS8wVr0zNv/aMGtKpBl2IR/N/EErytgz9F0pmXJE2qk23YmacqJ6Hf7a
         Bbkn85DS698EkG52Z1iLpdPg3k3rsftW9BH6cQpxElQv51V/6MiAurXUhwn8dkAheM4h
         3K2NAT+cnM1jQKWSS16LjtR9hd4rGSydzbsbKHswhO6fYsx/zbPBmwxW8Jfs2GeW1yiR
         q69Q==
X-Received: by 10.180.211.111 with SMTP id nb15mr30713wic.4.1405123466545;
        Fri, 11 Jul 2014 17:04:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.12 with SMTP id y12ls161927wiv.19.gmail; Fri, 11 Jul
 2014 17:04:25 -0700 (PDT)
X-Received: by 10.180.84.8 with SMTP id u8mr808121wiy.7.1405123465802;
        Fri, 11 Jul 2014 17:04:25 -0700 (PDT)
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com [2a00:1450:400c:c03::22f])
        by gmr-mx.google.com with ESMTPS id d9si4610wie.3.2014.07.11.17.04.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:04:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f as permitted sender) client-ip=2a00:1450:400c:c03::22f;
Received: by mail-we0-f175.google.com with SMTP id k48so1798412wev.34
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:04:25 -0700 (PDT)
X-Received: by 10.194.219.225 with SMTP id pr1mr2969542wjc.34.1405123465706;
        Fri, 11 Jul 2014 17:04:25 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u10sm8190157wjz.43.2014.07.11.17.04.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:04:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253365>

No functional changes, just move stuff around so that the next patch isn't
that ugly...

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 36 ++++++++++++++++++------------------
 trace.h | 12 ++++++++----
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/trace.c b/trace.c
index 18e5d93..e8ce619 100644
--- a/trace.c
+++ b/trace.c
@@ -132,20 +132,20 @@ static void trace_vprintf(struct trace_key *key, const char *format, va_list ap)
 	print_trace_line(key, &buf);
 }
 
-void trace_printf_key(struct trace_key *key, const char *format, ...)
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
+	if (!prepare_trace_line(NULL, &buf))
+		return;
+
 	va_start(ap, format);
-	trace_vprintf(NULL, format, ap);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
+
+	sq_quote_argv(&buf, argv, 0);
+	print_trace_line(NULL, &buf);
 }
 
 void trace_strbuf(struct trace_key *key, const struct strbuf *data)
@@ -159,20 +159,20 @@ void trace_strbuf(struct trace_key *key, const struct strbuf *data)
 	print_trace_line(key, &buf);
 }
 
-void trace_argv_printf(const char **argv, const char *format, ...)
+void trace_printf(const char *format, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-
-	if (!prepare_trace_line(NULL, &buf))
-		return;
-
 	va_start(ap, format);
-	strbuf_vaddf(&buf, format, ap);
+	trace_vprintf(NULL, format, ap);
 	va_end(ap);
+}
 
-	sq_quote_argv(&buf, argv, 0);
-	print_trace_line(NULL, &buf);
+void trace_printf_key(struct trace_key *key, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
+	va_end(ap);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index 28c1089..b4800e7 100644
--- a/trace.h
+++ b/trace.h
@@ -13,15 +13,19 @@ struct trace_key {
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 
-__attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
-__attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
+
+__attribute__((format (printf, 1, 2)))
+extern void trace_printf(const char *format, ...);
+
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(struct trace_key *key, const char *format, ...);
+
+__attribute__((format (printf, 2, 3)))
+extern void trace_argv_printf(const char **argv, const char *format, ...);
+
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 #endif /* TRACE_H */
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
