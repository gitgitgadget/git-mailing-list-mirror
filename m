From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 04/11] trace: factor out printing to the trace file
Date: Fri, 20 Jun 2014 23:05:44 +0200
Message-ID: <53A4A228.5090500@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBJ6ESKOQKGQEVLUC3JI@googlegroups.com Fri Jun 20 23:05:46 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBJ6ESKOQKGQEVLUC3JI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJ6ESKOQKGQEVLUC3JI@googlegroups.com>)
	id 1Wy60G-0004lX-6a
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:05:44 +0200
Received: by mail-wi0-f186.google.com with SMTP id z2sf117570wiv.23
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=MtOTEercdlLsVburRkRgV4BFsNva3tvcImdDVkFw4Uc=;
        b=fMkuVSPs6QgOR0daDNg9GK0HryzdjHIg+X37tKfAQ6n0XGweqNYk19fI7eg8XgtIvS
         3y2jB6O68wyRV6LWLQfDVdetUsK+91H8GSxkqM/drBkBfmNBN8lAGrbn6+ozjCmBw8sD
         y8ACIDuVO/aU2SyWJYa5DQfEgTz2Mn8bzjimyXvGrlVzV63XmR9VcAg5u2esLXe2fUDU
         LD3NtAdk/+Rx3oSNUwx/SHl8CNT8aUggEpUai791yz96FfeaHCmUocXnfDLYSah/sylM
         G7+5ZxDD2EGZz3jB44AMnH2YCKnOsHN2NSd0vRZi0PUflccN7ddItGXARHGPMEppdFhu
         e5hA==
X-Received: by 10.180.89.99 with SMTP id bn3mr26039wib.11.1403298343910;
        Fri, 20 Jun 2014 14:05:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.78.38 with SMTP id y6ls129349wiw.17.canary; Fri, 20 Jun
 2014 14:05:42 -0700 (PDT)
X-Received: by 10.194.143.109 with SMTP id sd13mr11397wjb.6.1403298342784;
        Fri, 20 Jun 2014 14:05:42 -0700 (PDT)
Received: from mail-we0-x231.google.com (mail-we0-x231.google.com [2a00:1450:400c:c03::231])
        by gmr-mx.google.com with ESMTPS id cj4si224704wid.0.2014.06.20.14.05.42
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:05:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::231 as permitted sender) client-ip=2a00:1450:400c:c03::231;
Received: by mail-we0-f177.google.com with SMTP id u56so4209683wes.8
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:05:42 -0700 (PDT)
X-Received: by 10.194.2.244 with SMTP id 20mr7031243wjx.26.1403298342692;
        Fri, 20 Jun 2014 14:05:42 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 18sm17901528wju.15.2014.06.20.14.05.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:05:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252283>

Opening and writing to the trace file is currently duplicated in
trace_strbuf() and trace_argv_printf(). Factor out this logic to prepare
for adding timestamp and file:line to trace output.

In case of trace_argv_printf(), this adds an additional trace_want() check
to prevent unnecessary string formatting.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
