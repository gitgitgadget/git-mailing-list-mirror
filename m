From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 04/11] trace: factor out printing to the trace file
Date: Wed, 11 Jun 2014 09:58:25 +0200
Message-ID: <53980C21.5080203@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBIUY4COAKGQEWK7HH5Y@googlegroups.com Wed Jun 11 09:58:28 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIUY4COAKGQEWK7HH5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIUY4COAKGQEWK7HH5Y@googlegroups.com>)
	id 1WudQR-0006DT-EV
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:58:27 +0200
Received: by mail-wg0-f55.google.com with SMTP id a1sf558035wgh.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=id8OtimL/G6UpcGobgBJrsxmyJvLd5H2SqTIR5j0YQ0=;
        b=wGNk6YFarMXNqzZTvjWEGo7nBrM2wlOYhb8vPXULXpc+G7/j4YMrgZP9nKR/QVTYoN
         m+234EH+9BOQu21kvMWLlBsBt4tAFBrfUuPW2+y/8VQsTcvbBC96QsbpUt61Fuf7UB8t
         HdJei0oGaJPT9IGx/WECxd30Hxe3ddnaCEDu7tTBLFHG4qHhBS+bomAiwqYaSxTt4jh1
         4TKtsZbCFwr3/rM06sZog7s4NckSfgGJ/dZPPqv3m8fLto7IVkShIQuIG7SgoV3IdHhe
         DFX45KTb052dqSc9i6WRHlfqfaEG92p4Tg7J/BvLRK0gKvOipVAwBRw1tCXmd6pGlMD4
         fgnA==
X-Received: by 10.152.28.229 with SMTP id e5mr4493lah.27.1402473507098;
        Wed, 11 Jun 2014 00:58:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.65 with SMTP id h1ls363558laa.67.gmail; Wed, 11 Jun 2014
 00:58:25 -0700 (PDT)
X-Received: by 10.112.204.201 with SMTP id la9mr4615797lbc.3.1402473505906;
        Wed, 11 Jun 2014 00:58:25 -0700 (PDT)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id s1si1258709wiw.3.2014.06.11.00.58.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:58:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235 as permitted sender) client-ip=2a00:1450:400c:c05::235;
Received: by mail-wi0-f181.google.com with SMTP id n3so563657wiv.2
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:58:25 -0700 (PDT)
X-Received: by 10.180.198.178 with SMTP id jd18mr44962712wic.24.1402473505804;
        Wed, 11 Jun 2014 00:58:25 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y8sm36299910eef.5.2014.06.11.00.58.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:58:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251333>

Opening and writing to the trace file is currently duplicated in
trace_strbuf() and trace_argv_printf(). Factor out this logic to prepare
for adding timestamp and file:line to trace output.

In case of trace_argv_printf(), this adds an additional trace_want() check
to prevent unnecessary string formatting.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/trace.c b/trace.c
index 3e31558..b7ca51b 100644
--- a/trace.c
+++ b/trace.c
@@ -62,6 +62,21 @@ static int get_trace_fd(const char *key, int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
+/* Print 'buf' verbatim to trace file designated by env var 'key' */
+static void do_trace_print(const char *key, const struct strbuf *buf)
+{
+	int fd, need_close = 0;
+
+	fd = get_trace_fd(key, &need_close);
+	if (!fd)
+		return;
+
+	write_or_whine_pipe(fd, buf->buf, buf->len, err_msg);
+
+	if (need_close)
+		close(fd);
+}
+
 static void trace_vprintf(const char *key, const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -71,7 +86,7 @@ static void trace_vprintf(const char *key, const char *format, va_list ap)
 
 	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_vaddf(&buf, format, ap);
-	trace_strbuf(key, &buf);
+	do_trace_print(key, &buf);
 	strbuf_release(&buf);
 }
 
@@ -93,26 +108,15 @@ void trace_printf(const char *format, ...)
 
 void trace_strbuf(const char *key, const struct strbuf *buf)
 {
-	int fd, need_close = 0;
-
-	fd = get_trace_fd(key, &need_close);
-	if (!fd)
-		return;
-
-	write_or_whine_pipe(fd, buf->buf, buf->len, err_msg);
-
-	if (need_close)
-		close(fd);
+	do_trace_print(key, buf);
 }
 
 void trace_argv_printf(const char **argv, const char *format, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	int fd, need_close = 0;
 
-	fd = get_trace_fd("GIT_TRACE", &need_close);
-	if (!fd)
+	if (!trace_want("GIT_TRACE"))
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
@@ -122,11 +126,8 @@ void trace_argv_printf(const char **argv, const char *format, ...)
 
 	sq_quote_argv(&buf, argv, 0);
 	strbuf_addch(&buf, '\n');
-	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
+	do_trace_print("GIT_TRACE", &buf);
 	strbuf_release(&buf);
-
-	if (need_close)
-		close(fd);
 }
 
 static const char *quote_crnl(const char *path)
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
