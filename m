Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65262C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiEaQ7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344582AbiEaQ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516BE694A4
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1556069wms.3
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XygDQ4SuLrPkqUzIfHmK98tDTU1rQo825V2QyWacjMY=;
        b=SJdR3k/KOkLSWPSHiHrIa1m5JMceBKJNOynGj7sUafBj1Z6aaLwere0jaNHBom9AWh
         jJHBV/uL3VbuurDxdPWbgQzDnGeGKpjYxwqA3ZLZxkJ5JR/kZyvEUZuOIFSJ9evuxl0L
         tMAalNCnt2UK9ZCAhfGZzf67GJOpI67RwEd6pj85ROHOULmd2NR9eFTKkkz3Alg3AQPJ
         SxKmD4GrgtU0/aW3asdGaGAMCaVEGmn2yVvcYYec32JG22n1HpWPe4d5TCOWzefkv1yX
         mXIO0Q3TqdsPuZJKA8u+0f0iDD2KOGjt5OqKKhGAscvEasceuFvLqrH3tE5jP1CaCbrP
         6aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XygDQ4SuLrPkqUzIfHmK98tDTU1rQo825V2QyWacjMY=;
        b=1Lh2a0m6iPhhDyQEhKf6fXjnAho7BFGtRyHSKvliqa6hEXMfy+WoEEXlqEVuzQsBji
         jjlZVqiHAkIX9n2shP/VlfIsUPGm1vOf9UJvaynb7IyJgOd4hFpl8B5BcTF+m24ZWjef
         YdTVrU1BWGixKu9249fDoP1U/lIWllFzNHQLW79TKL/V7ZtsLpb1TBuNM50psXTnqhW5
         y37NhZ1yd2k+MEgyFrT9rkgdxURbOCDl/z15sbly9b/jH0BQZ3QENGnodtivG/RRdvZT
         MDH/dH4CSTsb4EYKHkkL+NSndJiEiMH7n7KQzZ1HE5pd9xOTg/TnURzbmNqDJ6ARnDlR
         ZwDg==
X-Gm-Message-State: AOAM532VG1FHy5FO9f/Aa4TmwjvnV9+7C+mqipl6A1MCmBU4NEKnITDU
        97dZ0Pc/NG9yCFiffiMIbPn2Fo2Uw+duzA==
X-Google-Smtp-Source: ABdhPJykHQsDb4yVfFH+tU/IrLl3a7qkY42+JE7OhP7Sqoc6gl1o2VcsO0AFPfJXNjSUQ+2B+dliyg==
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id u11-20020a05600c19cb00b0039751db446fmr24694741wmq.182.1654016345404;
        Tue, 31 May 2022 09:59:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:04 -0700 (PDT)
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
Subject: [PATCH v2 2/6] usage.c: add a non-fatal bug() function to go with BUG()
Date:   Tue, 31 May 2022 18:58:44 +0200
Message-Id: <patch-v2-2.6-2d0527f86dc-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
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

I'd previously proposed this as part of another series[1], in that
use-case we ended thinking a BUG() would be better (and eventually
96e41f58fe1 (fsck: report invalid object type-path combinations,
2021-10-01) ended up with neither). Here though we'll end up
converting various existing code that was already doing what we're
doing better with this new API.

1. https://lore.kernel.org/git/YGRXomWwRYPdXZi3@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/api-error-handling.txt          | 19 ++++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 common-main.c                                 | 11 ++++
 git-compat-util.h                             | 12 +++++
 t/helper/test-trace2.c                        | 22 +++++++-
 t/t0210-trace2-normal.sh                      | 52 +++++++++++++++++++
 usage.c                                       | 30 +++++++++--
 7 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 8be4f4d0d6a..c4131dc3a2c 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,12 +1,29 @@
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
index bb0100f6024..0e35243724d 100644
--- a/common-main.c
+++ b/common-main.c
@@ -63,6 +63,16 @@ int main(int argc, const char **argv)
 	exit(result);
 }
 
+static void check_bug_if_BUG(void)
+{
+	if (!bug_called_must_BUG)
+		return;
+
+	/* BUG_vfl() calls exit(), which calls us again */
+	bug_called_must_BUG = 0;
+	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
+}
+
 int common_exit(const char *file, int line, int code)
 {
 	/*
@@ -73,6 +83,7 @@ int common_exit(const char *file, int line, int code)
 	 */
 	code &= 0xff;
 
+	check_bug_if_BUG();
 	trace2_cmd_exit_fl(file, line, code);
 
 	return code;
diff --git a/git-compat-util.h b/git-compat-util.h
index a446a363de2..a80079a06fe 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1320,9 +1320,21 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
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
+	if (bug_called_must_BUG) { \
+		bug_called_must_BUG = 0; \
+		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
+	} \
+} while (0)
 
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 59b124bb5f1..97346554674 100644
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
@@ -206,6 +206,22 @@ static int ut_007bug(int argc, const char **argv)
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
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -222,7 +238,9 @@ static struct unit_test ut_table[] = {
 	{ ut_004child,    "004child",  "[<child_command_line>]" },
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
-	{ ut_007bug,      "007bug",    "" },
+	{ ut_007BUG,      "007bug",    "" },
+	{ ut_008bug,      "008bug",    "" },
+	{ ut_009bug_BUG,  "009bug_BUG","" },
 };
 /* clang-format on */
 
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 37c359bd5a2..1b63945cf91 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -168,6 +168,58 @@ test_expect_success 'BUG messages are written to trace2' '
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
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/usage.c b/usage.c
index b738dd178b3..c37b94f1a40 100644
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
@@ -322,6 +328,20 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
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
2.36.1.1100.g16130010d07

