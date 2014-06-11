From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 10/11] trace: add trace_performance facility to
 debug performance issues
Date: Wed, 11 Jun 2014 10:01:28 +0200
Message-ID: <53980CD8.5090801@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBWMZ4COAKGQEOVHWFVY@googlegroups.com Wed Jun 11 10:01:30 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBWMZ4COAKGQEOVHWFVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBWMZ4COAKGQEOVHWFVY@googlegroups.com>)
	id 1WudTO-0000WA-9I
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 10:01:30 +0200
Received: by mail-la0-f58.google.com with SMTP id s18sf1001218lam.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=S/BAos7ht0/76Ybmr8jQFyf4BEkbvbnBYcCq+vL/vqc=;
        b=HN6CSon234YWOE2Y/6oDheFnpP6mrMvPoDap21bEt38SHl2H4vK0Qks35IE5+ZFGKY
         o+UamUpxBlIhoWrMLNB816Kzi7MQ6ncrqZof6JXEgAA8KLJimHExBrx7gokYVf/Sj7u0
         yjXPaOcSigIDuwgPF1C42PYFZMw4C2kCkeYcVu9y44Z3MpucRsqhATgOhdSWKfbS7qX/
         5v0a7iEUXo0OFSN53+Ef/IpIc0hKVTKDpAupk5BlzDQWrsJD630HWqN+HlH+FA7+DfIv
         OPEUcGjeNkpKwZlLNxXhJJQzjLLbWjgjrJNzcusIM7Lbvh+sjP9TMtvGjoWFY6fD0aNE
         I0MA==
X-Received: by 10.152.18.225 with SMTP id z1mr4720lad.10.1402473690122;
        Wed, 11 Jun 2014 01:01:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.20.201 with SMTP id p9ls397818lae.46.gmail; Wed, 11 Jun
 2014 01:01:28 -0700 (PDT)
X-Received: by 10.152.43.3 with SMTP id s3mr869651lal.5.1402473688814;
        Wed, 11 Jun 2014 01:01:28 -0700 (PDT)
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com [2a00:1450:400c:c00::22f])
        by gmr-mx.google.com with ESMTPS id e12si1262647wiv.1.2014.06.11.01.01.28
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:01:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22f as permitted sender) client-ip=2a00:1450:400c:c00::22f;
Received: by mail-wg0-f47.google.com with SMTP id k14so7684624wgh.30
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 01:01:28 -0700 (PDT)
X-Received: by 10.180.86.4 with SMTP id l4mr11408866wiz.61.1402473688704;
        Wed, 11 Jun 2014 01:01:28 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b44sm39222155eem.45.2014.06.11.01.01.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:01:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251339>

Add trace_performance and trace_performance_since macros that print a
duration and an optional printf-formatted text to the file specified in
environment variable GIT_TRACE_PERFORMANCE.

These macros, in conjunction with getnanotime(), are intended to simplify
performance measurements from within the application (i.e. profiling via
manual instrumentation, rather than using an external profiling tool).

Unless enabled via GIT_TRACE_PERFORMANCE, these macros have no noticeable
impact on performance, so that test code for well known time killers may
be shipped in release builds. Alternatively, a developer could provide an
additional performance patch (not meant for master) that allows reviewers
to reproduce performance tests more easily, e.g. on other platforms or
using their own repositories.

Usage examples:

Simple use case (measure one code section):

  uint64_t start = getnanotime();
  /* code section to measure */
  trace_performance_since(start, "foobar");

Medium use case (measure consecutive code sections):

  uint64_t start = getnanotime();
  /* first code section to measure */
  start = trace_performance_since(start, "first foobar");
  /* second code section to measure */
  trace_performance_since(start, "second foobar");

Complex use case (measure repetitive code sections):

  uint64_t t = 0;
  for (;;) {
    /* ignore */
    t -= getnanotime();
    /* code section to measure */
    t += getnanotime();
    /* ignore */
  }
  trace_performance(t, "frotz");

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 trace.h | 24 ++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/trace.c b/trace.c
index 4bd52f2..0551509 100644
--- a/trace.c
+++ b/trace.c
@@ -153,6 +153,27 @@ void trace_strbuf_fl(const char *file, int line, const char *key,
 	print_trace_line(key, &buf);
 }
 
+static const char *GIT_TRACE_PERFORMANCE = "GIT_TRACE_PERFORMANCE";
+
+static void trace_performance_vfl(const char *file, int line,
+				      uint64_t nanos, const char *format,
+				      va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(file, line, GIT_TRACE_PERFORMANCE, &buf))
+		return;
+
+	strbuf_addf(&buf, "performance: %.9f s", (double) nanos / 1000000000);
+
+	if (format && *format) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, format, ap);
+	}
+
+	print_trace_line(GIT_TRACE_PERFORMANCE, &buf);
+}
+
 #ifndef HAVE_VARIADIC_MACROS
 
 void trace_printf(const char *format, ...)
@@ -184,6 +205,24 @@ void trace_strbuf(const char *key, const struct strbuf *data)
 	trace_strbuf_fl(NULL, 0, key, data);
 }
 
+uint64_t trace_performance(uint64_t nanos, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vfl(NULL, 0, nanos, format, ap);
+	va_end(ap);
+	return getnanotime();
+}
+
+uint64_t trace_performance_since(uint64_t start, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vfl(NULL, 0, getnanotime() - start, format, ap);
+	va_end(ap);
+	return getnanotime();
+}
+
 #else
 
 void trace_printf_key_fl(const char *file, int line, const char *key,
@@ -204,6 +243,16 @@ void trace_argv_printf_fl(const char *file, int line, const char **argv,
 	va_end(ap);
 }
 
+uint64_t trace_performance_fl(const char *file, int line, uint64_t nanos,
+			      const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vfl(file, line, nanos, format, ap);
+	va_end(ap);
+	return getnanotime();
+}
+
 #endif /* HAVE_VARIADIC_MACROS */
 
 
diff --git a/trace.h b/trace.h
index c4964aa..9687563 100644
--- a/trace.h
+++ b/trace.h
@@ -21,6 +21,20 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(const char *key, const struct strbuf *data);
 
+/*
+ * Prints specified time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
+ * Returns current time in nanoseconds.
+ */
+__attribute__((format (printf, 2, 3)))
+extern uint64_t trace_performance(uint64_t nanos, const char *format, ...);
+
+/*
+ * Prints time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
+ * Returns current time in nanoseconds.
+ */
+__attribute__((format (printf, 2, 3)))
+extern uint64_t trace_performance_since(uint64_t start, const char *format, ...);
+
 #else
 
 /*
@@ -56,6 +70,13 @@ extern void trace_strbuf(const char *key, const struct strbuf *data);
 #define trace_strbuf(key, data) \
 	trace_strbuf_fl(__FILE__, __LINE__, key, data)
 
+#define trace_performance(nanos, ...) \
+	trace_performance_fl(__FILE__, __LINE__, nanos, __VA_ARGS__)
+
+#define trace_performance_since(start, ...) \
+	trace_performance_fl(__FILE__, __LINE__, getnanotime() - (start), \
+			     __VA_ARGS__)
+
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
 extern void trace_printf_key_fl(const char *file, int line, const char *key,
@@ -65,6 +86,9 @@ extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, const char *key,
 			    const struct strbuf *data);
+__attribute__((format (printf, 4, 5)))
+extern uint64_t trace_performance_fl(const char *file, int line,
+				     uint64_t nanos, const char *fmt, ...);
 
 #endif /* HAVE_VARIADIC_MACROS */
 
-- 
1.9.2.msysgit.0.501.gaeecf09

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
