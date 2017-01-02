Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442191FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 11:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbdABLPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 06:15:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56814 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751307AbdABLPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 06:15:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 308AA2093A;
        Mon,  2 Jan 2017 06:15:00 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Jan 2017 06:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=YW9
        +vGbbDoafcUW5EeLLbMovxVo=; b=iSYPnU3H0lVl1tcZvwqlR7eeYrLxS2eMBJs
        36ID7VDQ0Qpr/Qxuy4Ipt8YJ13XLNzeihZERheXXtWaOFwsPeqmxlU00ndtTEPIl
        v+ooHuBZ/Bj3SgG7ObnsKFlwq6WCTb3RQ6Gni1L8yaxuDKi0NLzJPTBP/Bb49R1p
        vABKwBYk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=YW9+vGbbDoafcUW5EeLLbMovxVo=; b=OThdi
        oG+veSFBphgcbnMsWiZCpQr5B0DjKT5sdGhM9mHhNNPd98MjLdQQY4gGf6cg7gFO
        x8+zBRwTJ9KBlpmpy4u3AuYmwLaSZzHIxtgBKKC1ajQRo6hdqjTVGlORoadD1zmQ
        aK+XuyiTDDhIeTFFk6mdmjo77mXyqdwMuVDfhU=
X-ME-Sender: <xms:NDZqWIdamtlxm7kA7ymFPILFqU_S0MjNO1-yXXAFOQz6Wk0H69-WUg>
X-Sasl-enc: Bk/r0uGrsF8b9SVLQr0tiflFwsBly01GfcrXHRO0QJ7k 1483355699
Received: from localhost (p5dc51a6b.dip0.t-ipconnect.de [93.197.26.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60F087E808;
        Mon,  2 Jan 2017 06:14:59 -0500 (EST)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/5] error/warning framework: prepare for l10n
Date:   Mon,  2 Jan 2017 12:14:50 +0100
Message-Id: <79ba4093dbf26b27e4f0e728ab9362c26558c1b2.1483354746.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.11.0.372.g2fcea0e476
In-Reply-To: <cover.1483354746.git.git@drmicha.warpmail.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, errors, warnings etc. are output with a fixed prefix "error: "
etc. that is not subject to l10n.

Change the call signatures of error_routine() etc. so that they receive
the prefix as first argument.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 apply.c           |  2 +-
 apply.h           |  4 ++--
 daemon.c          |  3 ++-
 fast-import.c     |  4 ++--
 git-compat-util.h | 10 +++++-----
 http-backend.c    |  4 ++--
 run-command.c     |  4 ++--
 usage.c           | 48 ++++++++++++++++++++++++------------------------
 8 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/apply.c b/apply.c
index 2ed808d429..0f93792e1c 100644
--- a/apply.c
+++ b/apply.c
@@ -112,7 +112,7 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
-static void mute_routine(const char *msg, va_list params)
+static void mute_routine(const char *prefix, const char *msg, va_list params)
 {
 	/* do nothing */
 }
diff --git a/apply.h b/apply.h
index b3d6783d55..56b5622868 100644
--- a/apply.h
+++ b/apply.h
@@ -100,8 +100,8 @@ struct apply_state {
 	 * set_error_routine() or set_warn_routine() to install muting
 	 * routines when in verbosity_silent mode.
 	 */
-	void (*saved_error_routine)(const char *err, va_list params);
-	void (*saved_warn_routine)(const char *warn, va_list params);
+	void (*saved_error_routine)(const char *prefix, const char *err, va_list params);
+	void (*saved_warn_routine)(const char *prefix, const char *warn, va_list params);
 
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
diff --git a/daemon.c b/daemon.c
index 473e6b6b63..cd52a25001 100644
--- a/daemon.c
+++ b/daemon.c
@@ -114,8 +114,9 @@ static void loginfo(const char *err, ...)
 	va_end(params);
 }
 
-static void NORETURN daemon_die(const char *err, va_list params)
+static void NORETURN daemon_die(const char *prefix, const char *err, va_list params)
 {
+	/* no need to pass down prefix */
 	logreport(LOG_ERR, err, params);
 	exit(1);
 }
diff --git a/fast-import.c b/fast-import.c
index f561ba833b..4576f12163 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -496,13 +496,13 @@ static void end_packfile(void);
 static void unkeep_all_packs(void);
 static void dump_marks(void);
 
-static NORETURN void die_nicely(const char *err, va_list params)
+static NORETURN void die_nicely(const char *prefix, const char *err, va_list params)
 {
 	static int zombie;
 	char message[2 * PATH_MAX];
 
 	vsnprintf(message, sizeof(message), err, params);
-	fputs("fatal: ", stderr);
+	fputs(prefix, stderr);
 	fputs(message, stderr);
 	fputc('\n', stderr);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 87237b092b..f1bf0a6749 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -439,11 +439,11 @@ static inline int const_error(void)
 #define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
-extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-extern void set_error_routine(void (*routine)(const char *err, va_list params));
-extern void (*get_error_routine(void))(const char *err, va_list params);
-extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
-extern void (*get_warn_routine(void))(const char *warn, va_list params);
+extern void set_die_routine(NORETURN_PTR void (*routine)(const char *prefix, const char *err, va_list params));
+extern void set_error_routine(void (*routine)(const char *prefix, const char *err, va_list params));
+extern void (*get_error_routine(void))(const char *prefix, const char *err, va_list params);
+extern void set_warn_routine(void (*routine)(const char *prefix, const char *warn, va_list params));
+extern void (*get_warn_routine(void))(const char *prefix, const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
 extern void set_error_handle(FILE *);
 
diff --git a/http-backend.c b/http-backend.c
index eef0a361f4..5c235e8b52 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -577,12 +577,12 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 }
 
 static int dead;
-static NORETURN void die_webcgi(const char *err, va_list params)
+static NORETURN void die_webcgi(const char *prefix, const char *err, va_list params)
 {
 	if (dead <= 1) {
 		struct strbuf hdr = STRBUF_INIT;
 
-		vreportf("fatal: ", err, params);
+		vreportf(prefix, err, params);
 
 		http_status(&hdr, 500, "Internal Server Error");
 		hdr_nocache(&hdr);
diff --git a/run-command.c b/run-command.c
index ca905a9e80..3133bf5320 100644
--- a/run-command.c
+++ b/run-command.c
@@ -618,9 +618,9 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
-static NORETURN void die_async(const char *err, va_list params)
+static NORETURN void die_async(const char *prefix, const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf(prefix, err, params);
 
 	if (in_async()) {
 		struct async *async = pthread_getspecific(async_key);
diff --git a/usage.c b/usage.c
index 17f52c1b5c..4270b04bf9 100644
--- a/usage.c
+++ b/usage.c
@@ -24,26 +24,26 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	fputc('\n', fh);
 }
 
-static NORETURN void usage_builtin(const char *err, va_list params)
+static NORETURN void usage_builtin(const char *prefix, const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf(prefix, err, params);
 	exit(129);
 }
 
-static NORETURN void die_builtin(const char *err, va_list params)
+static NORETURN void die_builtin(const char *prefix, const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf(prefix, err, params);
 	exit(128);
 }
 
-static void error_builtin(const char *err, va_list params)
+static void error_builtin(const char *prefix, const char *err, va_list params)
 {
-	vreportf("error: ", err, params);
+	vreportf(prefix, err, params);
 }
 
-static void warn_builtin(const char *warn, va_list params)
+static void warn_builtin(const char *prefix, const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	vreportf(prefix, warn, params);
 }
 
 static int die_is_recursing_builtin(void)
@@ -54,33 +54,33 @@ static int die_is_recursing_builtin(void)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
-static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
-static void (*error_routine)(const char *err, va_list params) = error_builtin;
-static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
+static NORETURN_PTR void (*usage_routine)(const char *prefix, const char *err, va_list params) = usage_builtin;
+static NORETURN_PTR void (*die_routine)(const char *prefix, const char *err, va_list params) = die_builtin;
+static void (*error_routine)(const char *prefix, const char *err, va_list params) = error_builtin;
+static void (*warn_routine)(const char *prefix, const char *err, va_list params) = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
-void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
+void set_die_routine(NORETURN_PTR void (*routine)(const char *prefix, const char *err, va_list params))
 {
 	die_routine = routine;
 }
 
-void set_error_routine(void (*routine)(const char *err, va_list params))
+void set_error_routine(void (*routine)(const char *prefix, const char *err, va_list params))
 {
 	error_routine = routine;
 }
 
-void (*get_error_routine(void))(const char *err, va_list params)
+void (*get_error_routine(void))(const char *prefix, const char *err, va_list params)
 {
 	return error_routine;
 }
 
-void set_warn_routine(void (*routine)(const char *warn, va_list params))
+void set_warn_routine(void (*routine)(const char *prefix, const char *warn, va_list params))
 {
 	warn_routine = routine;
 }
 
-void (*get_warn_routine(void))(const char *warn, va_list params)
+void (*get_warn_routine(void))(const char *prefix, const char *warn, va_list params)
 {
 	return warn_routine;
 }
@@ -101,7 +101,7 @@ void NORETURN usagef(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	usage_routine(err, params);
+	usage_routine("usage: ", err, params);
 	va_end(params);
 }
 
@@ -120,7 +120,7 @@ void NORETURN die(const char *err, ...)
 	}
 
 	va_start(params, err);
-	die_routine(err, params);
+	die_routine("fatal: ", err, params);
 	va_end(params);
 }
 
@@ -159,7 +159,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 
 	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	die_routine("fatal: ", fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 }
 
@@ -170,7 +170,7 @@ int error_errno(const char *fmt, ...)
 	va_list params;
 
 	va_start(params, fmt);
-	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	error_routine("error: ", fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 	return -1;
 }
@@ -181,7 +181,7 @@ int error(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	error_routine(err, params);
+	error_routine("error: ", err, params);
 	va_end(params);
 	return -1;
 }
@@ -192,7 +192,7 @@ void warning_errno(const char *warn, ...)
 	va_list params;
 
 	va_start(params, warn);
-	warn_routine(fmt_with_err(buf, sizeof(buf), warn), params);
+	warn_routine("warning: ", fmt_with_err(buf, sizeof(buf), warn), params);
 	va_end(params);
 }
 
@@ -201,6 +201,6 @@ void warning(const char *warn, ...)
 	va_list params;
 
 	va_start(params, warn);
-	warn_routine(warn, params);
+	warn_routine("warning: ", warn, params);
 	va_end(params);
 }
-- 
2.11.0.372.g2fcea0e476

