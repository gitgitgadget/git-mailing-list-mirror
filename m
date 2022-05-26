Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F767C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiEZAbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346515AbiEZAbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:31:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6092A5ABD
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l30so202601wrb.8
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLtVQsLUvyzFrQMmmpebj+2sVEO7f4dIBopPxPk7I+M=;
        b=UIztTURI5ffaiF91M+LxzbZoMwokkd29oZDV9CYD3rv5HijlegZQZxfA1Pb17QAP8R
         fRCXENsom3i/6fU3vhbJwfSe8TrD12oJUKIHnzY6Nf11wn8t3tUZUaxT7IS608RFLICd
         /TvuhvMGR0hHR9dEch65kJqzkZluI9Sb9AYo3Aj9LqHYvkJS8UmG4zkaizLjH7FFcPns
         7eXLlwcb/IrabgAwHRX3N5TvSAqCbDZFqOrWLT6/xsobikY11BdoUGXeLndmGw4KcQl8
         NLPqUIW5JqOUAekXTmfeBrZZAM9Y42XOjC3zmoBfPpQbTQjPwSS5G2/fULAEYyY/OsO/
         vvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLtVQsLUvyzFrQMmmpebj+2sVEO7f4dIBopPxPk7I+M=;
        b=B7R+XN2WClbO0DEsZm6tIelhnnCQ9cUg4+KWPQeZ2arjinUzdj21pcp1AwYqmBC2kG
         sIBRZBIYn+QVw1Ab7h0SlLfKcSrVg1Lo+2PJpRisKCwN8dY/htnGsO+XEawP39I3GifM
         3vIDNOMWuxA5TvTYZlTzQgYV0H6JcrHK5jcgVEz9JFndZPomI/2doG5w4AUXeHmiXQy6
         Kd21u1ot85PmvNuWQrK5yZQfo682Y6hzAYanGk05F2uIg+XsvdnaSdsq7rhzeVydC5SN
         QHqcsHlC+sO/8J0SvFJwQe10KAvAuqLY7709ek9ReypS41uzQ3ajniKXWT3XvvM5YH+k
         Donw==
X-Gm-Message-State: AOAM533a+dkHHTj+6lWqRA+cXD8fTG2BNSFPInAMPkxhJps6OxwcWyPW
        GCMbXhZaj89YKO7ruyNL2GSlGtLbdf6EbQ==
X-Google-Smtp-Source: ABdhPJyf65eG4SLzbLJ8k2yZ7b7bE4955FKEZ2FwKOFhlFAMQLUBpkN96725KmyNgqfGin3ga5TKqg==
X-Received: by 2002:adf:d1ef:0:b0:20e:79af:7701 with SMTP id g15-20020adfd1ef000000b0020e79af7701mr23990737wrd.486.1653525089053;
        Wed, 25 May 2022 17:31:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003973c54bd69sm3138968wmb.1.2022.05.25.17.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:31:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/3] trace2: emit "signal" events after calling BUG()
Date:   Thu, 26 May 2022 02:30:44 +0200
Message-Id: <RFC-patch-3.3-b099a3a4a96-20220525T234908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a wrapper for the abort(3) function to correspond to the existing
wrapper for exit(3). See ee4512ed481 (trace2: create new combined
trace facility, 2019-02-22) for the introduction of the exit(3)
wrapper. See also the more recent 368b5843158 (common-main.c: call
exit(), don't return, 2021-12-07) discussing how the exit() wrapper
macro it and the trace2 machinery interact.

As reported (off the ML) by Josh Steadmon we have "start" events that
are not followed by corresponding "exit" events. I first considered
logging an "exit" here, but that would be incorrect, we didn't call
exit, on abort() we do the equivalent of:

	kill(getpid(), SIGABRT);

So let's instead update the documentation to note that those
interested in seeing a marker for process exit need to be looking for
either an "exit" or a "signal" event.

We then need to add a *_fl() function similar to the existing
"tr2main_signal_handler()" function. Until now we'd only been emitting
these "signal" events from our own signal handlers.

Reported-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-trace2.txt | 13 +++++++++----
 git-compat-util.h                      |  9 +++++++++
 t/t0210-trace2-normal.sh               |  1 +
 trace2.c                               | 19 +++++++++++++++++++
 trace2.h                               |  8 ++++++++
 trace2/tr2_tgt.h                       |  3 +++
 trace2/tr2_tgt_event.c                 | 11 +++++++++--
 trace2/tr2_tgt_normal.c                | 11 +++++++++--
 trace2/tr2_tgt_perf.c                  | 11 +++++++++--
 9 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index f4a8a690878..55ecfd8c30c 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -421,7 +421,9 @@ only present on the "start" and "atexit" events.
 ------------
 
 `"exit"`::
-	This event is emitted when git calls `exit()`.
+	This event is emitted when git calls `exit()`. This event will
+	be produced for all regular ending of the git process, but it
+	might also exit via a "signal".
 +
 ------------
 {
@@ -435,7 +437,7 @@ only present on the "start" and "atexit" events.
 `"atexit"`::
 	This event is emitted by the Trace2 `atexit` routine during
 	final shutdown.  It should be the last event emitted by the
-	process.
+	process, unless it was aborted (see "signal").
 +
 (The elapsed time reported here is greater than the time reported in
 the "exit" event because it runs after all other atexit tasks have
@@ -452,8 +454,11 @@ completed.)
 
 `"signal"`::
 	This event is emitted when the program is terminated by a user
-	signal.  Depending on the platform, the signal event may
-	prevent the "atexit" event from being generated.
+	signal, which includes git itself calling abort(3). Depending
+	on the platform, the signal event may prevent the "exit"
+	and/or "atexit" events from being generated. E.g. if BUG() was
+	invoked we'll emit an "error" event followed by a "signal"
+	event, and nothing else.
 +
 ------------
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..ea3177b2771 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1403,6 +1403,15 @@ int cmd_main(int, const char **);
 int trace2_cmd_exit_fl(const char *file, int line, int code);
 #define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
 
+/*
+ * Intercept calls to abort() to log that we aborted.
+ */
+void trace2_cmd_signal_fl(const char *file, int line, int signo);
+#define abort() do { \
+	trace2_cmd_signal_fl(__FILE__, __LINE__, SIGABRT); \
+	abort(); \
+} while (0)
+
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
  * reported as a leak by tools like LSAN or valgrind. The argument
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 910a6af8058..25fffdba80e 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -162,6 +162,7 @@ test_expect_success 'BUG messages are written to trace2' '
 		start _EXE_ trace2 007bug
 		cmd_name trace2 (trace2)
 		error the bug message
+		signal elapsed:_TIME_ code:6
 	EOF
 	test_cmp expect actual
 '
diff --git a/trace2.c b/trace2.c
index e01cf77f1a8..250b2424bfa 100644
--- a/trace2.c
+++ b/trace2.c
@@ -230,6 +230,25 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
 	return code;
 }
 
+void trace2_cmd_signal_fl(const char *file, int line, int signo)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_signal_fl)
+			tgt_j->pfn_signal_fl(file, line, us_elapsed_absolute,
+					     signo);
+}
+
 void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
 			    va_list ap)
 {
diff --git a/trace2.h b/trace2.h
index 1b109f57d0a..4f456f2fc62 100644
--- a/trace2.h
+++ b/trace2.h
@@ -112,6 +112,14 @@ int trace2_cmd_exit_fl(const char *file, int line, int code);
 
 #define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
 
+/*
+ * Emit a 'signal' event. Used to log that we called abort() e.g. via
+ * the BUG() function.
+ */
+void trace2_cmd_signal_fl(const char *file, int line, int signo);
+
+#define trace2_cmd_signal(signo) (trace2_cmd_signal_fl(__FILE__, __LINE__, (signo)))
+
 /*
  * Emit an 'error' event.
  *
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 65f94e15748..fbc33650c5d 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -20,6 +20,8 @@ typedef void(tr2_tgt_evt_start_fl_t)(const char *file, int line,
 typedef void(tr2_tgt_evt_exit_fl_t)(const char *file, int line,
 				    uint64_t us_elapsed_absolute, int code);
 typedef void(tr2_tgt_evt_signal_t)(uint64_t us_elapsed_absolute, int signo);
+typedef void(tr2_tgt_evt_signal_fl_t)(const char *file, int line,
+				      uint64_t us_elapsed_absolute, int signo);
 typedef void(tr2_tgt_evt_atexit_t)(uint64_t us_elapsed_absolute, int code);
 
 typedef void(tr2_tgt_evt_error_va_fl_t)(const char *file, int line,
@@ -111,6 +113,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_start_fl_t                  *pfn_start_fl;
 	tr2_tgt_evt_exit_fl_t                   *pfn_exit_fl;
 	tr2_tgt_evt_signal_t                    *pfn_signal;
+	tr2_tgt_evt_signal_fl_t                 *pfn_signal_fl;
 	tr2_tgt_evt_atexit_t                    *pfn_atexit;
 	tr2_tgt_evt_error_va_fl_t               *pfn_error_va_fl;
 	tr2_tgt_evt_command_path_fl_t           *pfn_command_path_fl;
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c5c8cfbbaa0..df947378a51 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -177,14 +177,15 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	jw_release(&jw);
 }
 
-static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+static void fn_signal_fl(const char *file, int line,
+			 uint64_t us_elapsed_absolute, int signo)
 {
 	const char *event_name = "signal";
 	struct json_writer jw = JSON_WRITER_INIT;
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_intmax(&jw, "signo", signo);
 	jw_end(&jw);
@@ -193,6 +194,11 @@ static void fn_signal(uint64_t us_elapsed_absolute, int signo)
 	jw_release(&jw);
 }
 
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	fn_signal_fl(__FILE__, __LINE__, us_elapsed_absolute, signo);
+}
+
 static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 {
 	const char *event_name = "atexit";
@@ -624,6 +630,7 @@ struct tr2_tgt tr2_tgt_event = {
 	.pfn_start_fl = fn_start_fl,
 	.pfn_exit_fl = fn_exit_fl,
 	.pfn_signal = fn_signal,
+	.pfn_signal_fl = fn_signal_fl,
 	.pfn_atexit = fn_atexit,
 	.pfn_error_va_fl = fn_error_va_fl,
 	.pfn_command_path_fl = fn_command_path_fl,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index c42fbade7f0..8e2bc5027fe 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -105,17 +105,23 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_release(&buf_payload);
 }
 
-static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+static void fn_signal_fl(const char *file, int line,
+			 uint64_t us_elapsed_absolute, int signo)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 	double elapsed = (double)us_elapsed_absolute / 1000000.0;
 
 	strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d", elapsed,
 		    signo);
-	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
+	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
 
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	fn_signal_fl(__FILE__, __LINE__, us_elapsed_absolute, signo);
+}
+
 static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
@@ -336,6 +342,7 @@ struct tr2_tgt tr2_tgt_normal = {
 	.pfn_start_fl = fn_start_fl,
 	.pfn_exit_fl = fn_exit_fl,
 	.pfn_signal = fn_signal,
+	.pfn_signal_fl = fn_signal_fl,
 	.pfn_atexit = fn_atexit,
 	.pfn_error_va_fl = fn_error_va_fl,
 	.pfn_command_path_fl = fn_command_path_fl,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a1eff8bea31..4ce18d3f12e 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -193,18 +193,24 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_release(&buf_payload);
 }
 
-static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+static void fn_signal_fl(const char *file, int line,
+			 uint64_t us_elapsed_absolute, int signo)
 {
 	const char *event_name = "signal";
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	strbuf_addf(&buf_payload, "signo:%d", signo);
 
-	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+	perf_io_write_fl(file, line, event_name, NULL,
 			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
 	strbuf_release(&buf_payload);
 }
 
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	fn_signal_fl(__FILE__, __LINE__, us_elapsed_absolute, signo);
+}
+
 static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 {
 	const char *event_name = "atexit";
@@ -560,6 +566,7 @@ struct tr2_tgt tr2_tgt_perf = {
 	.pfn_start_fl = fn_start_fl,
 	.pfn_exit_fl = fn_exit_fl,
 	.pfn_signal = fn_signal,
+	.pfn_signal_fl = fn_signal_fl,
 	.pfn_atexit = fn_atexit,
 	.pfn_error_va_fl = fn_error_va_fl,
 	.pfn_command_path_fl = fn_command_path_fl,
-- 
2.36.1.1046.g586767a6996

