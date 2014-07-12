From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 13/17] trace: add trace_performance facility to
 debug performance issues
Date: Sat, 12 Jul 2014 02:06:28 +0200
Message-ID: <53C07C04.5020708@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBAPYQGPAKGQEI3JWCHY@googlegroups.com Sat Jul 12 02:06:26 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBAPYQGPAKGQEI3JWCHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBAPYQGPAKGQEI3JWCHY@googlegroups.com>)
	id 1X5kpe-0006jb-Nx
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:06:26 +0200
Received: by mail-we0-f186.google.com with SMTP id t60sf171620wes.23
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=mvs1q4wVTRpHO+T181IEqEv3FTNvMiRP1SEOL8o9hYM=;
        b=HbD8Ag9um5UNnkSXyG3FBj8KjgHAkn94d9mcBDhDro5eNDys6hS9HIQpdq75c2cYnp
         /EA8Vh2Nko/VSgP72eF1u3ke2M4P1pMbYsdqhtkAODDKzr9Un+kfKgIzuHqK/bv+vKmz
         z07YQmTiW1Drnd+Fl0jJXzHMkeAEMofXDjCSezZ4zrZVHQq/z6A9mep38Hq57den3asc
         ihdf6b8188kSP/2x9IrF0wK4t5r4sCzyzFZnxpG7ovzkDP94i1HGduykaGriy+Jt4M0D
         LeOKYdogoYBHygW1Vs4OH6b9RBRRKHXX2LI4c7ZNkLhN0SmxvSWGBkfmbw/y0EKDJvFr
         WRhQ==
X-Received: by 10.152.27.162 with SMTP id u2mr16487lag.16.1405123586408;
        Fri, 11 Jul 2014 17:06:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.65 with SMTP id w1ls123764laj.85.gmail; Fri, 11 Jul
 2014 17:06:25 -0700 (PDT)
X-Received: by 10.152.7.71 with SMTP id h7mr216933laa.2.1405123585165;
        Fri, 11 Jul 2014 17:06:25 -0700 (PDT)
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id cj4si7224wid.0.2014.07.11.17.06.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:06:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233 as permitted sender) client-ip=2a00:1450:400c:c05::233;
Received: by mail-wi0-f179.google.com with SMTP id cc10so22124wib.12
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:06:25 -0700 (PDT)
X-Received: by 10.180.212.12 with SMTP id ng12mr9188065wic.9.1405123585006;
        Fri, 11 Jul 2014 17:06:25 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o12sm383546wiw.5.2014.07.11.17.06.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:06:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253368>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 4b893a5..c843e68 100644
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
@@ -79,6 +87,13 @@ extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
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
@@ -88,6 +103,9 @@ extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
+__attribute__((format (printf, 4, 5)))
+extern void trace_performance_fl(const char *file, int line,
+				 uint64_t nanos, const char *fmt, ...);
 
 #endif /* HAVE_VARIADIC_MACROS */
 
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
