From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 05/11] trace: add infrastructure to augment trace
 output with additional info
Date: Fri, 20 Jun 2014 23:06:47 +0200
Message-ID: <53A4A267.2060907@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBZWESKOQKGQEVK47WNY@googlegroups.com Fri Jun 20 23:06:47 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBZWESKOQKGQEVK47WNY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f190.google.com ([74.125.82.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBZWESKOQKGQEVK47WNY@googlegroups.com>)
	id 1Wy61H-0005qn-Bw
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:06:47 +0200
Received: by mail-we0-f190.google.com with SMTP id x48sf467621wes.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=kTu8ejWrRq/OEPfwxWUMzo/rTvbJD4J26qTzOEftdRc=;
        b=J7v8JTMeojxLPtJMv9l4CJSo+JCrs5C6Hw+mXFHmGSnFBrxR/Dn+W1tpRNMrSLTwkb
         j96AxyOpD5iMmq6Dp2hIq2Jrw+I7yV1CBEkIc7TLj+cqtA86v1T83LWbMwWboEPbe44y
         mFk67yWiC/y/Ag3BsItgYpBUNwlrW9RUT3bkOPFEdCljHYi0FjxM0cjvBFxYdkwnRGtN
         aNi2I7FSeJzkGGCeYfSQLWcDy8OjfilCUuqUrZKRJQSupnXxDRNOpeG3hD33FYtgFCi+
         3dcqTPZrVClpMZgnY64yQ4DBT5FSDG7cQHBeCxj4Qeo4Sk88bnHxVWbFCEfX8DJ/I7ms
         f+gw==
X-Received: by 10.180.39.209 with SMTP id r17mr25905wik.15.1403298407113;
        Fri, 20 Jun 2014 14:06:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.106.6 with SMTP id gq6ls124722wib.24.gmail; Fri, 20 Jun
 2014 14:06:46 -0700 (PDT)
X-Received: by 10.180.91.73 with SMTP id cc9mr546605wib.4.1403298406307;
        Fri, 20 Jun 2014 14:06:46 -0700 (PDT)
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com [2a00:1450:400c:c03::22a])
        by gmr-mx.google.com with ESMTPS id gc5si251961wic.1.2014.06.20.14.06.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:06:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a as permitted sender) client-ip=2a00:1450:400c:c03::22a;
Received: by mail-we0-f170.google.com with SMTP id w61so4392548wes.29
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:06:46 -0700 (PDT)
X-Received: by 10.180.211.106 with SMTP id nb10mr6975113wic.9.1403298406199;
        Fri, 20 Jun 2014 14:06:46 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w5sm7938995wif.3.2014.06.20.14.06.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:06:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252284>

To be able to add a common prefix or suffix to all trace output (e.g.
a timestamp or file:line of the caller), factor out common setup and
cleanup tasks of the trace* functions.

Some unit-tests use trace output to verify internal state, and variable
output such as timestamps and line numbers are not useful there. Disable
additional trace output if GIT_TRACE_BARE is set.

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
 t/t1510-repo-setup.sh |  2 +-
 t/t5503-tagfollow.sh  |  8 ++++----
 trace.c               | 53 ++++++++++++++++++++++++++++++++++++++++-----------
 trace.h               |  2 +-
 4 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e1b2a99..8db8d68 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -57,7 +57,7 @@ test_repo () {
 			export GIT_WORK_TREE
 		fi &&
 		rm -f trace &&
-		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
+		GIT_TRACE_BARE=1 GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
 		grep '^setup: ' trace >result &&
 		test_cmp expected result
 	)
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index f30c038..dc10143 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -56,7 +56,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_BARE=1 GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $A = $(git rev-parse --verify origin/master)
 	) &&
 	get_needs $U >actual &&
@@ -86,7 +86,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_BARE=1 GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $C = $(git rev-parse --verify origin/cat) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
@@ -122,7 +122,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_BARE=1 GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
@@ -146,7 +146,7 @@ test_expect_success 'new clone fetch master and tags' '
 		cd clone2 &&
 		git init &&
 		git remote add origin .. &&
-		GIT_TRACE_PACKET=$UPATH git fetch &&
+		GIT_TRACE_BARE=1 GIT_TRACE_PACKET=$UPATH git fetch &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
diff --git a/trace.c b/trace.c
index b7ca51b..9fa406e 100644
--- a/trace.c
+++ b/trace.c
@@ -77,17 +77,45 @@ static void do_trace_print(const char *key, const struct strbuf *buf)
 		close(fd);
 }
 
+static int trace_bare = -1;
+
+static int prepare_trace_line(const char *key, struct strbuf *buf)
+{
+	if (!trace_want(key))
+		return 0;
+
+	set_try_to_free_routine(NULL);	/* is never reset */
+
+	/* unit tests may want to disable additional trace output */
+	if (trace_bare < 0)
+		trace_bare = trace_want("GIT_TRACE_BARE");
+	if (trace_bare)
+		return 1;
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
@@ -106,9 +134,15 @@ void trace_printf(const char *format, ...)
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
@@ -116,18 +150,15 @@ void trace_argv_printf(const char **argv, const char *format, ...)
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
