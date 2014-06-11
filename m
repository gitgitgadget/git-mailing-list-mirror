From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 05/11] trace: add infrastructure to augment trace
 output with additional info
Date: Wed, 11 Jun 2014 09:59:13 +0200
Message-ID: <53980C51.6020304@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBUUY4COAKGQETJ6ZDZI@googlegroups.com Wed Jun 11 09:59:17 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBUUY4COAKGQETJ6ZDZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBUUY4COAKGQETJ6ZDZI@googlegroups.com>)
	id 1WudRD-0006xU-Tl
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:59:15 +0200
Received: by mail-wi0-f188.google.com with SMTP id e4sf46362wiv.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=qpBLrcvw3hMYgesaHFOWcRFzaWn3HTVWTJ4LAK3z5tw=;
        b=uOxGGHgEWgvfSUHTvqh89o/7GpXdzyxoXOwJ7sWrfHOL/mS3ltMl4j5vH9bMqcbQhb
         6QJOQuVHJPzUP+9UYpulJlozJMGqQpttq3HfJsoWwdvrF+31WENbwzk518qY4svH+7+8
         IAiBIAX6mD9l5SuXX3f7dzMurBQPKopXFIhSxKgYfqAslcQ5aha9VcclYon3sU8ZmAsW
         VkgznzA4w+n5CZeciLgpgDgPdpHx3QawxI9Nc9w7+3P4IcfUB1zM79P8y3kYgWzqu/Sb
         bnqXxQTEzGsasKhbZdnv42J0HVNC7J9IVtch4hpZ2YU+0xlg2nQQAOQhWE0s4RCQSuiQ
         1GIw==
X-Received: by 10.152.203.193 with SMTP id ks1mr4380lac.29.1402473555434;
        Wed, 11 Jun 2014 00:59:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.169 with SMTP id t9ls396296lat.15.gmail; Wed, 11 Jun
 2014 00:59:14 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr1697748lbq.8.1402473554295;
        Wed, 11 Jun 2014 00:59:14 -0700 (PDT)
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com [2a00:1450:400c:c03::229])
        by gmr-mx.google.com with ESMTPS id x7si1266079wiw.1.2014.06.11.00.59.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:59:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229 as permitted sender) client-ip=2a00:1450:400c:c03::229;
Received: by mail-we0-f169.google.com with SMTP id t60so3434958wes.28
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:59:14 -0700 (PDT)
X-Received: by 10.180.207.9 with SMTP id ls9mr43978892wic.32.1402473554078;
        Wed, 11 Jun 2014 00:59:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v45sm57945805eeg.29.2014.06.11.00.59.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:59:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251334>

To be able to add a common prefix or suffix to all trace output (e.g.
a timestamp or file:line of the caller), factor out common setup and
cleanup tasks of the trace* functions.

When adding a common prefix, it makes sense that the output of each trace
call starts on a new line. Add '\n' in case the caller forgot.

Note that this explicitly limits trace output to line-by-line, it is no
longer possible to trace-print just part of a line. Until now, this was
just an implicit assumption (trace-printing part of a line worked, but
messed up the trace file if multiple threads or processes were involved).

Thread-safety / inter-process-safety is also the reason why we need to do
the prefixing and suffixing in memory rather than issuing multiple write()
calls. Write_or_whine_pipe() / xwrite() is atomic unless the size exceeds
MAX_IO_SIZE (8MB, see wrapper.c). In case of trace_strbuf, this costs an
additional string copy (which should be irrelevant for performance in light
of actual file IO).

While we're at it, rename trace_strbuf's 'buf' argument, which suggests
that the function is modifying the buffer. Trace_strbuf() currently is the
only trace API that can print arbitrary binary data (without barfing on
'%' or stopping at '\0'), so 'data' seems more appropriate.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 45 ++++++++++++++++++++++++++++++++++-----------
 trace.h |  2 +-
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/trace.c b/trace.c
index b7ca51b..c920429 100644
--- a/trace.c
+++ b/trace.c
@@ -77,17 +77,37 @@ static void do_trace_print(const char *key, const struct strbuf *buf)
 		close(fd);
 }
 
+static int prepare_trace_line(const char *key, struct strbuf *buf)
+{
+	if (!trace_want(key))
+		return 0;
+
+	set_try_to_free_routine(NULL);	/* is never reset */
+
+	/* add line prefix here */
+
+	return 1;
+}
+
+static void print_trace_line(const char *key, struct strbuf *buf)
+{
+	/* append newline if missing */
+	if (buf->len && buf->buf[buf->len - 1] != '\n')
+		strbuf_addch(buf, '\n');
+
+	do_trace_print(key, buf);
+	strbuf_release(buf);
+}
+
 static void trace_vprintf(const char *key, const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!trace_want(key))
+	if (!prepare_trace_line(key, &buf))
 		return;
 
-	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_vaddf(&buf, format, ap);
-	do_trace_print(key, &buf);
-	strbuf_release(&buf);
+	print_trace_line(key, &buf);
 }
 
 void trace_printf_key(const char *key, const char *format, ...)
@@ -106,9 +126,15 @@ void trace_printf(const char *format, ...)
 	va_end(ap);
 }
 
-void trace_strbuf(const char *key, const struct strbuf *buf)
+void trace_strbuf(const char *key, const struct strbuf *data)
 {
-	do_trace_print(key, buf);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(key, &buf))
+		return;
+
+	strbuf_addbuf(&buf, data);
+	print_trace_line(key, &buf);
 }
 
 void trace_argv_printf(const char **argv, const char *format, ...)
@@ -116,18 +142,15 @@ void trace_argv_printf(const char **argv, const char *format, ...)
 	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
 
-	if (!trace_want("GIT_TRACE"))
+	if (!prepare_trace_line("GIT_TRACE", &buf))
 		return;
 
-	set_try_to_free_routine(NULL);	/* is never reset */
 	va_start(ap, format);
 	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
-	strbuf_addch(&buf, '\n');
-	do_trace_print("GIT_TRACE", &buf);
-	strbuf_release(&buf);
+	print_trace_line("GIT_TRACE", &buf);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index 8fea50b..e03db2f 100644
--- a/trace.h
+++ b/trace.h
@@ -12,6 +12,6 @@ extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(const char *key, const char *format, ...);
-extern void trace_strbuf(const char *key, const struct strbuf *buf);
+extern void trace_strbuf(const char *key, const struct strbuf *data);
 
 #endif /* TRACE_H */
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
