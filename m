Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95AEC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbiEURO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiEURO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:14:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60094666A9
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m20so4134032wrb.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hudp7bTUxP85RGVSSWbuHZUCZqVFSw30OWSEBcmw4DY=;
        b=jgrhz3xEjIitaB6M8Q89Klo5RkD6HeLc0fZDUDG9ruGp1vMMSqsp2EDl1JZL/S0u8k
         p32HZQaVGvUu/uWi+MkW4riTQ69V4SIa80REEIzJbERm1K1lBjXdddqKHYYwYeZdxnzB
         hCdJjJvKRy+UR+UpM0j5D5KwDjaRTjxwiB2pPFq0mCffJD4J5kT8GLBE2nruA8G7Z6Dj
         +iugvkVP6tQ6y1uR/9q3a/yukCmO4NVFSSH5Qgj3wrb68GsQmjapzzGmYJF+buIVboIN
         tmXz7Et4w6M7lRltclf3aTHD0J44L+OMKaLDeFo+szsW84OObaKyC3LTgdFmxNZhol4g
         oCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hudp7bTUxP85RGVSSWbuHZUCZqVFSw30OWSEBcmw4DY=;
        b=iYVE9pEsciaKrfm0izP+mh2i4UUC7BG3v5PLKXz37Re3XWm/lE9SsV8HeYscs7dlW9
         N+3MBxqIABUmVKw+8Gp1Fnb1gjH5Fzk1bnMfBKud6HSjDtEKx3qstfnvAKumE+JbKcxf
         RVyYPbNRBEkMEZB6ILNdmHvjRnadNTspGoNjdRZ7CeLScdqPg+UaZgD6oAjiSQFgkao0
         iKGOGqGi7082YKOuP2SwKIrunbjdmkEWQDoWN0JxaYv9cgoCzuTibkpOklJyDk1BAzbx
         s4LNfzZwjX61c2Obn5ycdMFZMn66y1UNg+RU0Rz06efIMFPln4dwsu0Fnc/ACSSkWlgK
         2eeA==
X-Gm-Message-State: AOAM531WPhUAmhaNZTnrjzADnI9KWzepAiN05kpgPPdRQeDgWdJEIhnd
        fQxcMBwv8HJ7YUyFJYsH/basSdJ4lIkrrg==
X-Google-Smtp-Source: ABdhPJx1zt7hXnX1U7dTbU1crALL6XYyyIsIjAmrQ2XXGlGLk0pJ3IEs3MgO4iQUvVNdND9Uoc6M5Q==
X-Received: by 2002:a5d:588a:0:b0:20c:5ddf:2491 with SMTP id n10-20020a5d588a000000b0020c5ddf2491mr12540970wrf.197.1653153292477;
        Sat, 21 May 2022 10:14:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:14:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with BUG()
Date:   Sat, 21 May 2022 19:14:38 +0200
Message-Id: <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a bug() function to use in cases where we'd like to indicate a
runtime BUG(), but would like to deref the BUG() call because we're
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

Any caller to bug() should follow up such calls with BUG_if_bug(),
which will BUG() out (i.e. abort()) if there were any preceding calls
to bug(). As the tests and documentation here show we'll catch missing
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
 .../technical/api-error-handling.txt          | 17 +++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 git-compat-util.h                             | 12 +++++
 t/helper/test-trace2.c                        | 21 +++++++-
 t/t0210-trace2-normal.sh                      | 52 +++++++++++++++++++
 trace2.c                                      |  6 +++
 usage.c                                       | 30 +++++++++--
 7 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 8be4f4d0d6a..f4dffea4af0 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,12 +1,27 @@
 Error reporting in git
 ======================
 
-`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+`BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
 various kinds.
 
 - `BUG` is for failed internal assertions that should never happen,
   i.e. a bug in git itself.
 
+- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
+  prints a "BUG" message instead of calling `abort()`. We then expect
+  `BUG_if_bug()` to be called to `abort()` if there were any calls to
+  `bug()`. If there weren't any a call to `BUG_if_bug()` is a NOOP.
++
+This is for the convenience of APIs who'd like to potentially report
+more than one "bug", such as the optbug() validation in
+parse-options.c.
++
+We call `BUG_if_bug()` ourselves at `exit()` time (via a wrapper, not
+`atexit()`), which guarantees that we'll catch cases where we forgot
+to invoke `BUG_if_bug()` after calls to `bug()`. Thus calling
+`BUG_if_bug()` isn't strictly necessary, but ensures that we die as
+soon as possible.
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
diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..23b36053af4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1269,9 +1269,21 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
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
+#define BUG_if_bug() do { \
+	if (bug_called_must_BUG) { \
+		bug_called_must_BUG = 0; \
+		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
+	} \
+} while (0)
 
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 59b124bb5f1..9d2ad744840 100644
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
@@ -206,6 +206,21 @@ static int ut_007bug(int argc, const char **argv)
 	BUG("the bug message");
 }
 
+static int ut_008bug(int argc, const char **argv)
+{
+	bug("a bug message");
+	bug("another bug message");
+	BUG_if_bug();
+	return 0;
+}
+
+static int ut_009bug_BUG(int argc, const char **argv)
+{
+	bug("a bug message");
+	bug("another bug message");
+	return 0;
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -222,7 +237,9 @@ static struct unit_test ut_table[] = {
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
index 37c359bd5a2..7c0e0017ad3 100755
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
+	see bug() output above
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
+		error see bug() output above
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'bug messages without BUG_if_bug() are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
+		test-tool trace2 009bug_BUG 2>err &&
+	cat >expect <<-\EOF &&
+	a bug message
+	another bug message
+	had bug() output above, in addition missed BUG_if_bug() call
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
+		error had bug() output above, in addition missed BUG_if_bug() call
+		exit elapsed:_TIME_ code:99
+		atexit elapsed:_TIME_ code:99
+	EOF
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/trace2.c b/trace2.c
index e01cf77f1a8..d49d5d5a082 100644
--- a/trace2.c
+++ b/trace2.c
@@ -211,6 +211,12 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
 
 	code &= 0xff;
 
+	if (bug_called_must_BUG) {
+		/* BUG_vfl() calls exit(), which calls us again */
+		bug_called_must_BUG = 0;
+		BUG("had bug() output above, in addition missed BUG_if_bug() call");
+	}
+
 	if (!trace2_enabled)
 		return code;
 
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
2.36.1.960.g7a4e2fc85c9

