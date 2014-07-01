From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 13/16] trace: add trace_performance facility to
 debug performance issues
Date: Wed, 02 Jul 2014 01:03:17 +0200
Message-ID: <53B33E35.6090506@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBNP4ZSOQKGQEXNRGNYQ@googlegroups.com Wed Jul 02 01:03:21 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBNP4ZSOQKGQEXNRGNYQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBNP4ZSOQKGQEXNRGNYQ@googlegroups.com>)
	id 1X2754-0005Ao-8f
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:03:18 +0200
Received: by mail-wg0-f58.google.com with SMTP id z12sf1048274wgg.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=W7SJx1Mi1+XNqJnXtzuUBUgoW9X/qqGaNgWCrScZzQc=;
        b=glil13oXcjZihWU2/RPJ00nlSeQGfoWFACHcr/Herar7RM6ARFWXr2LnBzLR1ip1w0
         bCLD60lcp3LFJ7q58UGT08utaupWBPnIVlfUyrELKR0odSD1foYgiyqdbPOlmNw0ZEM4
         5wImbTRWQPkAXy6V4k+1w46WCO5JYNGvUAAqxyBQv2IEMOh7RwMOvVIzcqGCVetRaQLa
         gij4GOvEQ0Qt0EJbyBOEuP9bs2ioE8iqoN23HxHKQh3BkhQM7P6Hw0icaSkloLjr56CB
         ZYrLnUblXAIXdpwahU7P4CNziu2lb87UhxSWuwJpYdK3eLNFdidw6fJFN4EgO8tP7om0
         0+Lw==
X-Received: by 10.180.20.68 with SMTP id l4mr2340wie.1.1404255797972;
        Tue, 01 Jul 2014 16:03:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.104.2 with SMTP id ga2ls674709wib.2.gmail; Tue, 01 Jul
 2014 16:03:17 -0700 (PDT)
X-Received: by 10.194.3.34 with SMTP id 2mr1700147wjz.4.1404255797221;
        Tue, 01 Jul 2014 16:03:17 -0700 (PDT)
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id cj4si811179wid.0.2014.07.01.16.03.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:03:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233 as permitted sender) client-ip=2a00:1450:400c:c05::233;
Received: by mail-wi0-f179.google.com with SMTP id cc10so8597660wib.0
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:03:17 -0700 (PDT)
X-Received: by 10.181.11.166 with SMTP id ej6mr38798639wid.75.1404255797122;
        Tue, 01 Jul 2014 16:03:17 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hc4sm51009945wjc.38.2014.07.01.16.03.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:03:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252762>

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
 trace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 trace.h | 18 ++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/trace.c b/trace.c
index b9d7272..af64dbb 100644
--- a/trace.c
+++ b/trace.c
@@ -169,6 +169,27 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 	print_trace_line(key, &buf);
 }
 
+static struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
+
+static void trace_performance_vprintf_fl(const char *file, int line,
+					 uint64_t nanos, const char *format,
+					 va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(file, line, &trace_perf_key, &buf))
+		return;
+
+	strbuf_addf(&buf, "performance: %.9f s", (double) nanos / 1000000000);
+
+	if (format && *format) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, format, ap);
+	}
+
+	print_trace_line(&trace_perf_key, &buf);
+}
+
 #ifndef HAVE_VARIADIC_MACROS
 
 void trace_printf(const char *format, ...)
@@ -200,6 +221,23 @@ void trace_strbuf(const char *key, const struct strbuf *data)
 	trace_strbuf_fl(NULL, 0, key, data);
 }
 
+void trace_performance(uint64_t nanos, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vprintf_fl(NULL, 0, nanos, format, ap);
+	va_end(ap);
+}
+
+void trace_performance_since(uint64_t start, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vprintf_fl(NULL, 0, getnanotime() - start,
+				     format, ap);
+	va_end(ap);
+}
+
 #else
 
 void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
@@ -220,6 +258,15 @@ void trace_argv_printf_fl(const char *file, int line, const char **argv,
 	va_end(ap);
 }
 
+void trace_performance_fl(const char *file, int line, uint64_t nanos,
+			      const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_performance_vprintf_fl(file, line, nanos, format, ap);
+	va_end(ap);
+}
+
 #endif /* HAVE_VARIADIC_MACROS */
 
 
diff --git a/trace.h b/trace.h
index 6ad29dd..92d0fa6 100644
--- a/trace.h
+++ b/trace.h
@@ -31,6 +31,14 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
+/* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
+__attribute__((format (printf, 2, 3)))
+extern void trace_performance(uint64_t nanos, const char *format, ...);
+
+/* Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled. */
+__attribute__((format (printf, 2, 3)))
+extern void trace_performance_since(uint64_t start, const char *format, ...);
+
 #else
 
 /*
@@ -71,6 +79,13 @@ extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 #define trace_strbuf(key, data) \
 	trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data)
 
+#define trace_performance(nanos, ...) \
+	trace_performance_fl(TRACE_CONTEXT, __LINE__, nanos, __VA_ARGS__)
+
+#define trace_performance_since(start, ...) \
+	trace_performance_fl(TRACE_CONTEXT, __LINE__, getnanotime() - (start), \
+			     __VA_ARGS__)
+
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
 extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
@@ -80,6 +95,9 @@ extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
+__attribute__((format (printf, 4, 5)))
+extern void trace_performance_fl(const char *file, int line,
+				 uint64_t nanos, const char *fmt, ...);
 
 #endif /* HAVE_VARIADIC_MACROS */
 
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
