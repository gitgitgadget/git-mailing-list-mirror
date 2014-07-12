From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 07/17] trace: add infrastructure to augment trace
 output with additional info
Date: Sat, 12 Jul 2014 02:02:18 +0200
Message-ID: <53C07B0A.6010709@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBBXWQGPAKGQESAUSFPA@googlegroups.com Sat Jul 12 02:02:16 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBBXWQGPAKGQESAUSFPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBBXWQGPAKGQESAUSFPA@googlegroups.com>)
	id 1X5klc-0002kT-2K
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:02:16 +0200
Received: by mail-lb0-f187.google.com with SMTP id n15sf182666lbi.14
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=zHVJvWgpwKPjQpu5AgLJqO2UsJNFR38zIt2pfWyes98=;
        b=QPvtyvFUnThPnbJZHY5inJ2iJStvtIM5VM+FDMASK/f360lq0UraEVuWLuPm0fpQb8
         lMuY+CaHBawQeOAGqu/JOZ5wzUZacUKBS0majO7eyncKI1q4SFmIYSRHE1ExB/5f9/I1
         IUT/cfC6mzQMmbTkA60gKYGNon06bg2tJ8lVPyS2hkUSp0e7vPYL/VB7I8Tm+0grAQOx
         Lg1u8ENPgVK2wvbvKNxo7wnVgN3FM9HeZf4Ipeg16pwmvloLBIyXJtytvel7ExKUqCLo
         s7ePIKYBpiaUeKn572DXKYTVkeB+AiG1c82xA0xOHYfmozpMa6zdwRI/1Ze8w/Q18Asw
         hnCg==
X-Received: by 10.152.179.227 with SMTP id dj3mr20253lac.0.1405123335793;
        Fri, 11 Jul 2014 17:02:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.166 with SMTP id x6ls15951lal.100.gmail; Fri, 11 Jul
 2014 17:02:14 -0700 (PDT)
X-Received: by 10.152.7.71 with SMTP id h7mr215898laa.2.1405123334465;
        Fri, 11 Jul 2014 17:02:14 -0700 (PDT)
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com [2a00:1450:400c:c00::233])
        by gmr-mx.google.com with ESMTPS id iz18si1879wic.3.2014.07.11.17.02.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:02:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::233 as permitted sender) client-ip=2a00:1450:400c:c00::233;
Received: by mail-wg0-f51.google.com with SMTP id y10so1730263wgg.10
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:02:14 -0700 (PDT)
X-Received: by 10.180.188.50 with SMTP id fx18mr9072137wic.76.1405123334369;
        Fri, 11 Jul 2014 17:02:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f6sm8201330wja.25.2014.07.11.17.02.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:02:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253362>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 47 +++++++++++++++++++++++++++++++++--------------
 trace.h |  2 +-
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/trace.c b/trace.c
index 8662b79..3d02bcc 100644
--- a/trace.c
+++ b/trace.c
@@ -85,17 +85,37 @@ void trace_disable(struct trace_key *key)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
+static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
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
+static void print_trace_line(struct trace_key *key, struct strbuf *buf)
+{
+	/* append newline if missing */
+	if (buf->len && buf->buf[buf->len - 1] != '\n')
+		strbuf_addch(buf, '\n');
+
+	write_or_whine_pipe(get_trace_fd(key), buf->buf, buf->len, err_msg);
+	strbuf_release(buf);
+}
+
 static void trace_vprintf(struct trace_key *key, const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!trace_want(key))
+	if (!prepare_trace_line(key, &buf))
 		return;
 
-	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_vaddf(&buf, format, ap);
-	trace_strbuf(key, &buf);
-	strbuf_release(&buf);
+	print_trace_line(key, &buf);
 }
 
 void trace_printf_key(struct trace_key *key, const char *format, ...)
@@ -114,32 +134,31 @@ void trace_printf(const char *format, ...)
 	va_end(ap);
 }
 
-void trace_strbuf(struct trace_key *key, const struct strbuf *buf)
+void trace_strbuf(struct trace_key *key, const struct strbuf *data)
 {
-	int fd = get_trace_fd(key);
-	if (!fd)
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!prepare_trace_line(key, &buf))
 		return;
 
-	write_or_whine_pipe(fd, buf->buf, buf->len, err_msg);
+	strbuf_addbuf(&buf, data);
+	print_trace_line(key, &buf);
 }
 
 void trace_argv_printf(const char **argv, const char *format, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	int fd = get_trace_fd(NULL);
-	if (!fd)
+
+	if (!prepare_trace_line(NULL, &buf))
 		return;
 
-	set_try_to_free_routine(NULL);	/* is never reset */
 	va_start(ap, format);
 	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
-	strbuf_addch(&buf, '\n');
-	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
-	strbuf_release(&buf);
+	print_trace_line(NULL, &buf);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index d85ac4c..28c1089 100644
--- a/trace.h
+++ b/trace.h
@@ -22,6 +22,6 @@ extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(struct trace_key *key, const char *format, ...);
-extern void trace_strbuf(struct trace_key *key, const struct strbuf *buf);
+extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
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
