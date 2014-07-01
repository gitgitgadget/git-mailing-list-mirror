From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 07/16] trace: add infrastructure to augment trace
 output with additional info
Date: Wed, 02 Jul 2014 00:59:18 +0200
Message-ID: <53B33D46.5020008@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBRX2ZSOQKGQERYLCWGQ@googlegroups.com Wed Jul 02 00:59:19 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBRX2ZSOQKGQERYLCWGQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBRX2ZSOQKGQERYLCWGQ@googlegroups.com>)
	id 1X271D-0002qQ-5i
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:59:19 +0200
Received: by mail-we0-f191.google.com with SMTP id q59sf1079156wes.28
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ql4NdmltBwXUrEskbQcQovwGdJn/FsDY8pOKlS4VjZ0=;
        b=Fj8g7p8h8Fao/PgZhlNrloZtKkb8d9kbDMe+EQYChv+/eUlsf2eVFBoyJAuZuaOwAS
         yz/yQIvVqXp+Z0bKjcWIPasVVGv5P5Drnet7fUZr4px4R5lbviFwVRdEApuLqcmn0q8Z
         6+0hDxH+pOd/tZCTqClqY2p97WGSNtSRPSiSatPhe/ZkXnGSzeCnBaDXI7DGcn5YutNq
         FD5VUPWXJkWWu35ZnU0QKhuE49CcCLN6KEjB67YrFaWOt3WzW0cCHJKUGS9OhtGSccSY
         9MpPCUfp2CHeafXgZLUgPbeRIEugAl6JnbUjfVXMRdC7mE1u0U5m/jpmmdnQ4zerzbhO
         K3vQ==
X-Received: by 10.180.37.107 with SMTP id x11mr145659wij.18.1404255558918;
        Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.97.99 with SMTP id dz3ls521872wib.9.canary; Tue, 01 Jul
 2014 15:59:18 -0700 (PDT)
X-Received: by 10.180.82.134 with SMTP id i6mr3851575wiy.1.1404255558213;
        Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com [2a00:1450:400c:c00::22c])
        by gmr-mx.google.com with ESMTPS id m9si888202wiw.0.2014.07.01.15.59.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c as permitted sender) client-ip=2a00:1450:400c:c00::22c;
Received: by mail-wg0-f44.google.com with SMTP id x13so10289435wgg.15
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
X-Received: by 10.181.13.5 with SMTP id eu5mr40016966wid.58.1404255558145;
        Tue, 01 Jul 2014 15:59:18 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gq4sm14366951wib.8.2014.07.01.15.59.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:59:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252756>

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
index fbfd9f4..e69455f 100644
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
