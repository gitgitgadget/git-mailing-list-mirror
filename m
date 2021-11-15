Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16632C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED49961A09
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352564AbhKOXbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353011AbhKOXSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98634C09CE56
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 133so15282509wme.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOLbbNtA8xFA5qFv3IKa1TuN/+QkC5AreF3Z88D/VH4=;
        b=KSjSlAXT9d0RBu3Zf7MhIpBUabrk0ryqBpE7Pu/r5DvyX7lR2XfOMs9A/B6Fs3y+Ue
         47pQZS+TNlkEZBfpBWg9N1AkUHWX5dUeJx2aM0URLylYOLPcHXbrAQsQdewVZP6Uhc4Q
         T3zHeXkuhcqlvNPbRXS1JWp7+owOxGWMD1cLYu3YUARJNZQKjqDIYM5gx44gERaWaID3
         LKTB7AYanRDz5tqZtPBaFcCBXYk8V5zOslK7HrhT79b/QmwOeNS8D/KBqlynRO9pWnO2
         taY0guPILG7lFuiLIIKqW3FOVEeeh+DcUQo+HKFMBoj7uJxN0uvmPLzjPl5t89nT/EH+
         xOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOLbbNtA8xFA5qFv3IKa1TuN/+QkC5AreF3Z88D/VH4=;
        b=lpBDi2bhZPt6jGvXFkOgMR9/oBBDgdKjALXN4OWYG7G3lsbUfYFj3UxrKUH626MP+R
         uHTMaloL56robqwJjTR9yumPqwD95EimIHORPc1GEyhEMOFzFPWTlJSAY/jhQnXFux9s
         P2x9S70gFXwOEz4drC7RCWxRh29FpNOCVWBZ5uhRIECvvKZ30C9csAPvI4w9kTpJanKO
         77iERNRkE+t68++GVVeja4h6UG8Tj284LfuKmGPqd7aPp/HWlVk6uaEQW5RSKlvTxWOX
         85sY3VzVxMqk0pjpVeXi0grloL0w+QWyYASru4nFTIvuyQEqI8Jzw5rRAd+wkhrpv1wK
         KrgQ==
X-Gm-Message-State: AOAM531TmIlPiwZTmRTYXSgbV7vlx9MXG8ZyaYeabUlQLiVcYqcrjFBM
        KSMzywnacc0r55+8baurzK+veMk3r/IBfg==
X-Google-Smtp-Source: ABdhPJyv1kFZfPsugow2mQsahAScap45FDBdE9yJD7gwkauuEdsbuhzGnBVv4MiR6EkG1J1J0mIuyg==
X-Received: by 2002:a1c:3b04:: with SMTP id i4mr2157510wma.126.1637014727733;
        Mon, 15 Nov 2021 14:18:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 19/21] usage API: use C99 macros for {usage,usagef,die,error,warning,die}*()
Date:   Mon, 15 Nov 2021 23:18:29 +0100
Message-Id: <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "usage" family of functions to be defined in terms of C99
variadic macros, as we've optionally done with the BUG() macro and
BUG_fl() function since d8193743e08 (usage.c: add BUG() function,
2017-05-12), and unconditionally since 765dc168882 (git-compat-util:
always enable variadic macros, 2021-01-28).

This would have been possible before having a hard dependency on C99,
but as the dual implementations of C99 and pre-C99 macros and
functions adjusted in preceding commits show, doing so would have been
rather painful.

By having these be macros we'll now log meaningful "file" and "line"
entries in trace2 events. Before this we'd log "usage.c" in all of
them, and the line would be the relevant locations in that file.

To do this we need to not only introduce X_fl() functions for
{die,error,warning,die}{,_errno}(), but also change all the callers of
the set_*() and get_() functions in usage.h to take "file" and "line"
arguments.

Neither the built-in {die,error,warning,die}{,_errno}() nor anyone
else does anything useful with these "file" and "line" arguments for
now, but it means we can define all our macros and functions
consistently.

It also opens the door for a follow-up change where these functions
could optionally emit the file name and line number, e.g. for
DEVELOPER=1 builds, or depending on configuration.

It might be a good change to remove the "fmt" key from the "error"
events as a follow-up change. As these few examples from running the
test suite show it's sometimes redundant (same as the "msg"), rather
useless (just a "%s"), or something we could now mostly aggregate by
file/line instead of the normalized printf format:

      1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a valid task","fmt":"'%s' is not a valid task"}
      1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(then) atom used more than once","fmt":"%s"}
      1 file":"builtin/fast-import.c","line":411,"msg":"Garbage after mark: N :202 :302x","fmt":"Garbage after mark: %s"}

"Mostly" here assumes that it would be OK if the aggregation changed
between git versions, which may be what all users of trace2 want. The
change that introduced the "fmt" code was ee4512ed481 (trace2: create
new combined trace facility, 2019-02-22), and the documentation change
was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
2019-02-22).

Both are rather vague on what problem "fmt" solved exactly, aside from
the obvious one of it being impossible to do meaningful aggregations
due to the "file" and "line" being the same everywhere, which isn't
the case now.

In any case, let's leave "fmt" be for now, the above summary was given
in case it's interesting to remove it in the future, e.g. to save
space in trace2 payloads.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c               |  2 +-
 builtin/fast-import.c |  5 +--
 daemon.c              |  3 +-
 http-backend.c        |  5 +--
 run-command.c         | 15 ++++----
 trace2.h              |  3 --
 usage.c               | 79 ++++++++++++++++++++-----------------------
 usage.h               | 49 +++++++++++++++++++--------
 8 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/apply.c b/apply.c
index 5c9872f8c10..1a505a2e097 100644
--- a/apply.c
+++ b/apply.c
@@ -123,7 +123,7 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
-static void mute_routine(const char *msg, va_list params)
+static void mute_routine(const char *file, int line, const char *msg, va_list params)
 {
 	/* do nothing */
 }
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4e2432bb491..687c7194842 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -399,14 +399,15 @@ static void end_packfile(void);
 static void unkeep_all_packs(void);
 static void dump_marks(void);
 
-static NORETURN void die_nicely(const char *err, va_list params)
+static NORETURN void die_nicely(const char *file, int line, const char *err,
+				va_list params)
 {
 	va_list cp;
 	static int zombie;
 	report_fn die_message_fn = get_die_message_routine();
 
 	va_copy(cp, params);
-	die_message_fn(err, params);
+	die_message_fn(__FILE__, __LINE__, err, params);
 
 	if (!zombie) {
 		char message[2 * PATH_MAX];
diff --git a/daemon.c b/daemon.c
index b1fcbe0d6fa..2dc46e37852 100644
--- a/daemon.c
+++ b/daemon.c
@@ -131,7 +131,8 @@ static void loginfo(const char *err, ...)
 	va_end(params);
 }
 
-static void NORETURN daemon_die(const char *err, va_list params)
+static void NORETURN daemon_die(const char *file, int line, const char *err,
+				va_list params)
 {
 	logreport(LOG_ERR, err, params);
 	exit(1);
diff --git a/http-backend.c b/http-backend.c
index 982cb62c7cb..185fd84887d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -655,13 +655,14 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 }
 
 static int dead;
-static NORETURN void die_webcgi(const char *err, va_list params)
+static NORETURN void die_webcgi(const char *file, int line, const char *err,
+				va_list params)
 {
 	if (dead <= 1) {
 		struct strbuf hdr = STRBUF_INIT;
 		report_fn die_message_fn = get_die_message_routine();
 
-		die_message_fn(err, params);
+		die_message_fn(__FILE__, __LINE__, err, params);
 
 		http_status(&hdr, 500, "Internal Server Error");
 		hdr_nocache(&hdr);
diff --git a/run-command.c b/run-command.c
index 48b5fe19a80..c7d410f20a8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -340,19 +340,19 @@ static void child_close_pair(int fd[2])
 	child_close(fd[1]);
 }
 
-static void child_error_fn(const char *err, va_list params)
+static void child_error_fn(const char *file, int line, const char *err, va_list params)
 {
 	const char msg[] = "error() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
-static void child_warning_fn(const char *err, va_list params)
+static void child_warn_fn(const char *file, int line, const char *err, va_list params)
 {
-	const char msg[] = "warning() should not be called in child\n";
+	const char msg[] = "warn() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
-static void NORETURN child_die_fn(const char *err, va_list params)
+static void NORETURN child_die_fn(const char *file, int line, const char *err, va_list params)
 {
 	const char msg[] = "die() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
@@ -783,7 +783,7 @@ int start_command(struct child_process *cmd)
 		 */
 		set_die_routine(child_die_fn);
 		set_error_routine(child_error_fn);
-		set_warning_routine(child_warning_fn);
+		set_warning_routine(child_warn_fn);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
@@ -1071,11 +1071,12 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
-static NORETURN void die_async(const char *err, va_list params)
+static NORETURN void die_async(const char *file, int line, const char *err,
+			       va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
 
-	die_message_fn(err, params);
+	die_message_fn(__FILE__, __LINE__, err, params);
 
 	if (in_async()) {
 		struct async *async = pthread_getspecific(async_key);
diff --git a/trace2.h b/trace2.h
index 1b109f57d0a..713271d2c24 100644
--- a/trace2.h
+++ b/trace2.h
@@ -120,9 +120,6 @@ int trace2_cmd_exit_fl(const char *file, int line, int code);
 void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
 			    va_list ap);
 
-#define trace2_cmd_error_va(fmt, ap) \
-	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
-
 /*
  * Emit a 'pathname' event with the canonical pathname of the current process
  * This gives post-processors a simple field to identify the command without
diff --git a/usage.c b/usage.c
index 4b93744137d..e6f609fe49a 100644
--- a/usage.c
+++ b/usage.c
@@ -31,7 +31,7 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 	write_in_full(2, msg, p - msg);
 }
 
-static NORETURN void usage_builtin(const char *err, va_list params)
+static NORETURN void usage_builtin(const char *file, int line, const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
 
@@ -55,35 +55,35 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 	exit(129);
 }
 
-static void die_message_builtin(const char *err, va_list params)
+static void die_message_builtin(const char *file, int line, const char *err, va_list params)
 {
-	trace2_cmd_error_va(err, params);
+	trace2_cmd_error_va_fl(file, line, err, params);
 	vreportf("fatal: ", err, params);
 }
 
 /*
- * We call trace2_cmd_error_va() in the below functions first and
+ * We call trace2_cmd_error_va_fl(file, line, ...) in the below functions first and
  * expect it to va_copy 'params' before using it (because an 'ap' can
  * only be walked once).
  */
-static NORETURN void die_builtin(const char *err, va_list params)
+static NORETURN void die_builtin(const char *file, int line, const char *err, va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
 
-	die_message_fn(err, params);
+	die_message_fn(file, line, err, params);
 	exit(128);
 }
 
-static void error_builtin(const char *err, va_list params)
+static void error_builtin(const char *file, int line, const char *err, va_list params)
 {
-	trace2_cmd_error_va(err, params);
+	trace2_cmd_error_va_fl(file, line, err, params);
 
 	vreportf("error: ", err, params);
 }
 
-static void warning_builtin(const char *warn, va_list params)
+static void warning_builtin(const char *file, int line, const char *warn, va_list params)
 {
-	trace2_cmd_error_va(warn, params);
+	trace2_cmd_error_va_fl(file, line, warn, params);
 
 	vreportf("warning: ", warn, params);
 }
@@ -178,21 +178,18 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
-void NORETURN usage(const char *fmt)
-{
-	usagef("%s", fmt);
-}
-
-void NORETURN usagef(const char *fmt, ...)
+NORETURN
+void usage_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 
 	va_start(ap, fmt);
-	usage_routine(fmt, ap);
+	usage_routine(file, line, fmt, ap);
 	va_end(ap);
 }
 
-void NORETURN die(const char *fmt, ...)
+NORETURN
+void die_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 
@@ -202,14 +199,15 @@ void NORETURN die(const char *fmt, ...)
 	}
 
 	va_start(ap, fmt);
-	die_routine(fmt, ap);
+	die_routine(file, line, fmt, ap);
 	va_end(ap);
 }
 
-void NORETURN die_errno(const char *fmt, ...)
+NORETURN
+void die_errno_fl(const char *file, int line, const char *fmt, ...)
 {
-	char buf[1024];
 	va_list ap;
+	char buf[1024];
 
 	if (die_is_recursing()) {
 		fputs("fatal: recursion detected in die_errno handler\n",
@@ -218,72 +216,67 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 
 	va_start(ap, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	die_routine(file, line, fmt_with_err(buf, sizeof(buf), fmt), ap);
 	va_end(ap);
 }
 
-#undef die_message
-int die_message(const char *fmt, ...)
+int die_message_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 
 	va_start(ap, fmt);
-	die_message_routine(fmt, ap);
+	die_message_routine(file, line, fmt, ap);
 	va_end(ap);
-	return 128;
+	return -1;
 }
 
-#undef die_message_errno
-int die_message_errno(const char *fmt, ...)
+int die_message_errno_fl(const char *file, int line, const char *fmt, ...)
 {
-	char buf[1024];
 	va_list ap;
 
 	va_start(ap, fmt);
-	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	die_message_routine(file, line, fmt, ap);
 	va_end(ap);
 	return -1;
 }
 
-#undef error
-int error(const char *fmt, ...)
+int error_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 
 	va_start(ap, fmt);
-	error_routine(fmt, ap);
+	error_routine(file, line, fmt, ap);
 	va_end(ap);
 	return -1;
 }
 
-#undef error_errno
-int error_errno(const char *fmt, ...)
+int error_errno_fl(const char *file, int line, const char *fmt, ...)
 {
-	char buf[1024];
 	va_list ap;
+	char buf[1024];
 
 	va_start(ap, fmt);
-	error_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	error_routine(file, line, fmt_with_err(buf, sizeof(buf), fmt), ap);
 	va_end(ap);
 	return -1;
 }
 
-void warning(const char *fmt, ...)
+void warning_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
 
 	va_start(ap, fmt);
-	warning_routine(fmt, ap);
+	warning_routine(file, line, fmt, ap);
 	va_end(ap);
 }
 
-void warning_errno(const char *fmt, ...)
+void warning_errno_fl(const char *file, int line, const char *fmt, ...)
 {
 	char buf[1024];
 	va_list ap;
 
 	va_start(ap, fmt);
-	warning_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	warning_routine(file, line, fmt_with_err(buf, sizeof(buf), fmt), ap);
 	va_end(ap);
 }
 
@@ -313,7 +306,7 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 		abort();
 	in_bug = 1;
 
-	trace2_cmd_error_va(fmt, params_copy);
+	trace2_cmd_error_va_fl(file, line, fmt, params_copy);
 
 	if (BUG_exit_code)
 		exit(BUG_exit_code);
@@ -339,7 +332,7 @@ int bug_fl(const char *file, int line, const char *fmt, ...)
 	va_start(ap, fmt);
 	BUG_vfl_common(file, line, fmt, ap);
 	va_end(ap);
-	trace2_cmd_error_va(fmt, cp);
+	trace2_cmd_error_va_fl(file, line, fmt, cp);
 
 	return -1;
 }
diff --git a/usage.h b/usage.h
index df02fe9bcaf..e4a65ad755a 100644
--- a/usage.h
+++ b/usage.h
@@ -106,25 +106,41 @@ extern int BUG_exit_code;
 /* If bug() is called we must have a BUG() invocation afterwards */
 extern int bug_called_must_BUG;
 
-/* General helper functions */
-NORETURN void usage(const char *err);
-NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-
 /* General helper functions invoked via macro wrappers */
 __attribute__((format (printf, 3, 4))) NORETURN
+void usage_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4))) NORETURN
+void die_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4))) NORETURN
+void die_errno_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+int die_message_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+int die_message_errno_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+int error_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+int error_errno_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void warning_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+void warning_errno_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int bug_fl(const char *file, int line, const char *fmt, ...);
 
 /* General helper macros */
+#define usage(...) usage_fl(__FILE__, __LINE__, "%s", __VA_ARGS__)
+#define usagef(...) usage_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define die(...) die_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define die_errno(...) die_errno_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define die_message(...) die_message_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define die_message_errno(...) die_message_errno_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define error(...) error_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define error_errno(...) error_errno_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define warning(...) warning_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define warning_errno(...) warning_errno_fl(__FILE__, __LINE__, __VA_ARGS__)
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
 #define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
 #define BUG_if_bug() do { \
@@ -135,7 +151,8 @@ int bug_fl(const char *file, int line, const char *fmt, ...);
 } while (0)
 
 /* Setting custom handling routines */
-typedef void (*report_fn)(const char *, va_list params);
+typedef void (*report_fn)(const char *file, int line, const char *fmt,
+			  va_list params);
 void set_die_routine(NORETURN_PTR report_fn routine);
 report_fn get_die_message_routine(void);
 void set_error_routine(report_fn routine);
@@ -154,8 +171,10 @@ static inline int const_error(void)
 {
 	return -1;
 }
-#define error(...) (error(__VA_ARGS__), const_error())
-#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
+#undef error
+#undef error_errno
+#define error(...) (error_fl(__FILE__, __LINE__, __VA_ARGS__), const_error())
+#define error_errno(...) (error_errno_fl(__FILE__, __LINE__, __VA_ARGS__), const_error())
 #endif
 
 #endif
-- 
2.34.0.rc2.809.g11e21d44b24

