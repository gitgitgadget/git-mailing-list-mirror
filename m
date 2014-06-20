From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 10/11] trace: add trace_performance facility to
 debug performance issues
Date: Fri, 20 Jun 2014 23:10:07 +0200
Message-ID: <53A4A32F.40502@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBLWGSKOQKGQEX4GNZSA@googlegroups.com Fri Jun 20 23:10:07 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBLWGSKOQKGQEX4GNZSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBLWGSKOQKGQEX4GNZSA@googlegroups.com>)
	id 1Wy64U-000146-Ui
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:10:06 +0200
Received: by mail-lb0-f189.google.com with SMTP id s7sf476518lbd.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Lf+vM8J0AxggUemJ5t8aeKJqx5d9HwmPBRrYog9Tfck=;
        b=KzO/b4O2g4lb0tV8BXEM9jLTfrsb+7Faosd4J7RZ+FRGj74Sz1egRgBNHxqaq85D6Y
         GMT+vI6bi5EozpwgXLa9zmTY9SzJgJROU3ejfyDCAZ7L+8W4DjGL0mkiV42EY6+l4eek
         MWCPWfmZsFQTnpISpjNIoBPfv5IPXrJsKeKu3WtoiundAcmf681mrMtrzhs4g3pAxHWO
         qLncfqfVTMvyy2smTskKDUknZIGfe8ldaKx4gdz1M6Smit9lWd9UvoFWBGKgW0CfM+fq
         iVeV2TrUUI7bmB25zRhzG5jM8Cy0A0/hpAJP5Ngp98h81wP/6aYt/1q3XjaiLKON8ICj
         gY1g==
X-Received: by 10.152.6.99 with SMTP id z3mr21130laz.36.1403298606813;
        Fri, 20 Jun 2014 14:10:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.199.8 with SMTP id jg8ls207192lac.5.gmail; Fri, 20 Jun
 2014 14:10:05 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr546153lbq.8.1403298605710;
        Fri, 20 Jun 2014 14:10:05 -0700 (PDT)
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id mx7si223108wic.1.2014.06.20.14.10.05
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:10:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232 as permitted sender) client-ip=2a00:1450:400c:c00::232;
Received: by mail-wg0-f50.google.com with SMTP id x13so4182667wgg.33
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:10:05 -0700 (PDT)
X-Received: by 10.195.17.164 with SMTP id gf4mr7304665wjd.45.1403298605623;
        Fri, 20 Jun 2014 14:10:05 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fb15sm7917655wid.23.2014.06.20.14.10.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:10:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252289>

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
index 88e05b9..65cd887 100644
--- a/trace.c
+++ b/trace.c
@@ -164,6 +164,27 @@ void trace_strbuf_fl(const char *file, int line, const char *key,
 	print_trace_line(key, &buf);
 }
 
+static const char *GIT_TRACE_PERFORMANCE = "GIT_TRACE_PERFORMANCE";
+
+static void trace_performance_vprintf_fl(const char *file, int line,
+					 uint64_t nanos, const char *format,
+					 va_list ap)
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
@@ -195,6 +216,23 @@ void trace_strbuf(const char *key, const struct strbuf *data)
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
 
 void trace_printf_key_fl(const char *file, int line, const char *key,
@@ -215,6 +253,15 @@ void trace_argv_printf_fl(const char *file, int line, const char **argv,
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
index c4964aa..f491471 100644
--- a/trace.h
+++ b/trace.h
@@ -21,6 +21,14 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(const char *key, const struct strbuf *data);
 
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
@@ -56,6 +64,13 @@ extern void trace_strbuf(const char *key, const struct strbuf *data);
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
@@ -65,6 +80,9 @@ extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, const char *key,
 			    const struct strbuf *data);
+__attribute__((format (printf, 4, 5)))
+extern void trace_performance_fl(const char *file, int line,
+				 uint64_t nanos, const char *fmt, ...);
 
 #endif /* HAVE_VARIADIC_MACROS */
 
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
