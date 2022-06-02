Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B997CCA478
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiFBMZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiFBMZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267351021D8
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k16so6264412wrg.7
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYcrM2+rQj363VFiHNHfuhLYsb6Xz6UT/FeB0q/b5Co=;
        b=S67x8DFTYdPbSo9F0I/6ujIeWwcReLkCZXlBC4wKxp0ICWx7VeH9VxFR/1ZFQQcgXB
         2LtpHC87Axwl8/nW3LW/W27DtSWQMYGNH64hxkujgxk61Xie5wNPR1xlFFh3+lA7S9Qf
         lRH4ZT1kUDzycOhtLXlEuzm8sBTHRkWx0y+TwIrAlTxhPEAK28uWhsabH++LO6iqi/rY
         bh019LsPfo90s9epEhhnTWHzrqYTDmcj0K/bupsOq/ma9nADzrLoymKGjwujl22UUM/9
         BpX3vUbjL77PYaF9Yna/o+sWbc9RguyrvSm76N6BHTpiXiVH8C1Ij8Y0M8MGNL6vASCe
         /Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYcrM2+rQj363VFiHNHfuhLYsb6Xz6UT/FeB0q/b5Co=;
        b=iGtHFLNKEDhGk9LAg4wnPojfU9o6eKvD0R7t7DOnQMSsPcZiDe7ns/UBW8tmNGDZoA
         WHkq8XuPTRxg45DW6wYy1cFS157rhWmqkA7EzryWcE8oKGyAvekVsFPMjwAuAjlZ9bhk
         YeautOCr+lzObGeGe/jUt89siAsnApXL+e5Eo/O9peCmaCA71VvYqxmksbDscOV25ZLX
         ra5NFQRURV3FSc69L/0P6Y5cAXZTeZr7xKea5jnAuTLKt3MqQ6nCoWcBgVtW/R3HbnYH
         ITPp1utXeVTZ8e/g6JaYJQrWETa274igOmGwp5cWvdoUl5Nn5E5Pl2xTyZcylFQ+7Jlo
         fepA==
X-Gm-Message-State: AOAM531HjCI0LHYVxbY0WAUDrSVqLauRzl1eqY2COHJhMbyr4c0kk+E2
        TFvxAWGJPKhiInoJV4gdE7YdqGIUx0jMpg==
X-Google-Smtp-Source: ABdhPJxUbsvlm4XVKZFgSa4ogGdIVfC0VKPz6kaP8pumi5FVr10FJsyZOQmA7GL3Qy11vQnpBihrFg==
X-Received: by 2002:a5d:4906:0:b0:20f:fc2a:987a with SMTP id x6-20020a5d4906000000b0020ffc2a987amr3446477wrq.228.1654172742351;
        Thu, 02 Jun 2022 05:25:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] usage.c: add a non-fatal bug() function to go with BUG()
Date:   Thu,  2 Jun 2022 14:25:33 +0200
Message-Id: <patch-v3-2.6-033f373acaa-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a bug() function to use in cases where we'd like to indicate a
runtime BUG(), but would like to defer the BUG() call because we're
possibly accumulating more bug() callers to exhaustively indicate what
went wrong.

We already have this sort of facility in various parts of the
codebase, just in the form of ad-hoc re-inventions of the
functionality that this new API provides. E.g. this will be used to
replace optbug() in parse-options.c, and the 'error("BUG:[...]' we do
in a loop in builtin/receive-pack.c.

Unlike the code this replaces we'll log to trace2 with this new bug()
function (as with other usage.c functions, including BUG()), we'll
also be able to avoid calls to xstrfmt() in some cases, as the bug()
function itself accepts variadic sprintf()-like arguments.

Any caller to bug() can follow up such calls with BUG_if_bug(),
which will BUG() out (i.e. abort()) if there were any preceding calls
to bug(), callers can also decide not to call BUG_if_bug() and leave
the resulting BUG() invocation until exit() time. There are currently
no bug() API users that don't call BUG_if_bug() themselves after a
for-loop, but allowing for not calling BUG_if_bug() keeps the API
flexible. As the tests and documentation here show we'll catch missing
BUG_if_bug() invocations in our exit() wrapper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/api-error-handling.txt          | 24 +++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 common-main.c                                 |  8 ++
 git-compat-util.h                             | 10 +++
 t/helper/test-trace2.c                        | 29 ++++++-
 t/t0210-trace2-normal.sh                      | 76 +++++++++++++++++++
 usage.c                                       | 33 ++++++--
 7 files changed, 174 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 8be4f4d0d6a..70bf1d3e522 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,12 +1,34 @@
 Error reporting in git
 ======================
 
-`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+`BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
 various kinds.
 
 - `BUG` is for failed internal assertions that should never happen,
   i.e. a bug in git itself.
 
+- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
+  prints a "BUG" message instead of calling `abort()`.
++
+A call to `bug()` will then result in a "real" call to the `BUG()`
+function, either explicitly by invoking `BUG_if_bug()` after call(s)
+to `bug()`, or implicitly at `exit()` time where we'll check if we
+encountered any outstanding `bug()` invocations.
++
+If there were no prior calls to `bug()` before invoking `BUG_if_bug()`
+the latter is a NOOP. The `BUG_if_bug()` function takes the same
+arguments as `BUG()` itself. Calling `BUG_if_bug()` explicitly isn't
+necessary, but ensures that we die as soon as possible.
++
+If you know you had prior calls to `bug()` then calling `BUG()` itself
+is equivalent to calling `BUG_if_bug()`, the latter being a wrapper
+calling `BUG()` if we've set a flag indicating that we've called
+`bug()`.
++
+This is for the convenience of APIs who'd like to potentially report
+more than one "bug", such as the optbug() validation in
+parse-options.c.
+
 - `die` is for fatal application errors.  It prints a message to
   the user and exits with status 128.
 
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index f4a8a690878..77a150b30ee 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -465,8 +465,8 @@ completed.)
 ------------
 
 `"error"`::
-	This event is emitted when one of the `BUG()`, `error()`, `die()`,
-	`warning()`, or `usage()` functions are called.
+	This event is emitted when one of the `BUG()`, `bug()`, `error()`,
+	`die()`, `warning()`, or `usage()` functions are called.
 +
 ------------
 {
diff --git a/common-main.c b/common-main.c
index b6124dd2c2c..c531372f3ff 100644
--- a/common-main.c
+++ b/common-main.c
@@ -59,6 +59,13 @@ int main(int argc, const char **argv)
 	exit(result);
 }
 
+static void check_bug_if_BUG(void)
+{
+	if (!bug_called_must_BUG)
+		return;
+	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
+}
+
 /* We wrap exit() to call common_exit() in git-compat-util.h */
 int common_exit(const char *file, int line, int code)
 {
@@ -70,6 +77,7 @@ int common_exit(const char *file, int line, int code)
 	 */
 	code &= 0xff;
 
+	check_bug_if_BUG();
 	trace2_cmd_exit_fl(file, line, code);
 
 	return code;
diff --git a/git-compat-util.h b/git-compat-util.h
index 1227ff80ca7..ce007102f76 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1320,9 +1320,19 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
+/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
+extern int bug_called_must_BUG;
+
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+__attribute__((format (printf, 3, 4)))
+void bug_fl(const char *file, int line, const char *fmt, ...);
+#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_if_bug(...) do { \
+	if (bug_called_must_BUG) \
+		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
+} while (0)
 
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 59b124bb5f1..180c7f53f31 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -198,7 +198,7 @@ static int ut_006data(int argc, const char **argv)
 	return 0;
 }
 
-static int ut_007bug(int argc, const char **argv)
+static int ut_007BUG(int argc, const char **argv)
 {
 	/*
 	 * Exercise BUG() to ensure that the message is printed to trace2.
@@ -206,6 +206,28 @@ static int ut_007bug(int argc, const char **argv)
 	BUG("the bug message");
 }
 
+static int ut_008bug(int argc, const char **argv)
+{
+	bug("a bug message");
+	bug("another bug message");
+	BUG_if_bug("an explicit BUG_if_bug() following bug() call(s) is nice, but not required");
+	return 0;
+}
+
+static int ut_009bug_BUG(int argc, const char **argv)
+{
+	bug("a bug message");
+	bug("another bug message");
+	/* The BUG_if_bug(...) isn't here, but we'll spot bug() calls on exit()! */
+	return 0;
+}
+
+static int ut_010bug_BUG(int argc, const char **argv)
+{
+	bug("a bug message");
+	BUG("a BUG message");
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -222,7 +244,10 @@ static struct unit_test ut_table[] = {
 	{ ut_004child,    "004child",  "[<child_command_line>]" },
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
-	{ ut_007bug,      "007bug",    "" },
+	{ ut_007BUG,      "007bug",    "" },
+	{ ut_008bug,      "008bug",    "" },
+	{ ut_009bug_BUG,  "009bug_BUG","" },
+	{ ut_010bug_BUG,  "010bug_BUG","" },
 };
 /* clang-format on */
 
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 37c359bd5a2..80e76a4695e 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -168,6 +168,82 @@ test_expect_success 'BUG messages are written to trace2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'bug messages with BUG_if_bug() are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
+		test-tool trace2 008bug 2>err &&
+	cat >expect <<-\EOF &&
+	a bug message
+	another bug message
+	an explicit BUG_if_bug() following bug() call(s) is nice, but not required
+	EOF
+	sed "s/^.*: //" <err >actual &&
+	test_cmp expect actual &&
+
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 008bug
+		cmd_name trace2 (trace2)
+		error a bug message
+		error another bug message
+		error an explicit BUG_if_bug() following bug() call(s) is nice, but not required
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'bug messages without explicit BUG_if_bug() are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
+		test-tool trace2 009bug_BUG 2>err &&
+	cat >expect <<-\EOF &&
+	a bug message
+	another bug message
+	had bug() call(s) in this process without explicit BUG_if_bug()
+	EOF
+	sed "s/^.*: //" <err >actual &&
+	test_cmp expect actual &&
+
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 009bug_BUG
+		cmd_name trace2 (trace2)
+		error a bug message
+		error another bug message
+		error on exit(): had bug() call(s) in this process without explicit BUG_if_bug()
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'bug messages followed by BUG() are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
+		test-tool trace2 010bug_BUG 2>err &&
+	cat >expect <<-\EOF &&
+	a bug message
+	a BUG message
+	EOF
+	sed "s/^.*: //" <err >actual &&
+	test_cmp expect actual &&
+
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 010bug_BUG
+		cmd_name trace2 (trace2)
+		error a bug message
+		error a BUG message
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/usage.c b/usage.c
index b738dd178b3..79900d0287f 100644
--- a/usage.c
+++ b/usage.c
@@ -290,18 +290,24 @@ void warning(const char *warn, ...)
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
 int BUG_exit_code;
 
-static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
+static void BUG_vfl_common(const char *file, int line, const char *fmt,
+			   va_list params)
 {
 	char prefix[256];
-	va_list params_copy;
-	static int in_bug;
-
-	va_copy(params_copy, params);
 
 	/* truncation via snprintf is OK here */
 	snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
 
 	vreportf(prefix, fmt, params);
+}
+
+static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
+{
+	va_list params_copy;
+	static int in_bug;
+
+	va_copy(params_copy, params);
+	BUG_vfl_common(file, line, fmt, params);
 
 	if (in_bug)
 		abort();
@@ -317,11 +323,28 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 {
 	va_list ap;
+
+	bug_called_must_BUG = 0;
+
 	va_start(ap, fmt);
 	BUG_vfl(file, line, fmt, ap);
 	va_end(ap);
 }
 
+int bug_called_must_BUG;
+void bug_fl(const char *file, int line, const char *fmt, ...)
+{
+	va_list ap, cp;
+
+	bug_called_must_BUG = 1;
+
+	va_copy(cp, ap);
+	va_start(ap, fmt);
+	BUG_vfl_common(file, line, fmt, ap);
+	va_end(ap);
+	trace2_cmd_error_va(fmt, cp);
+}
+
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
 {
-- 
2.36.1.1103.gb3ecdfb3e6a

