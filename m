Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A33C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A3C61A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbhKOXUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbhKOXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7DC03E035
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b12so33613345wrh.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Uein13J33hNHfMCTFZGOPOqcobL+adoxDZbgj7HJRY=;
        b=cjDPd71eEuGkRE4yPjLUHhY/JX7yFPzmSSVJYbaU/sEWD7+uzPL05T1lCe+AB5u0fu
         ySM/ZI9gUd00ym8FDDcAmoJCjLz6RbcZja1fishXLZNrblfi3ixsJKwJLw8jqwC6W7ED
         cC+LsMDdA4AbvSwdCeowyxdvIg3msHa9WGJMzIAITaWvE/tlShS3azzA1ghP0FWYC2UZ
         RbbA9hgtOiZJYjn6CPZXjXaluscKApSBxnvXNmgiVKb9k4YkfyCYAOIO6rzQRLr34AEa
         lV1vivWN9t0VInWXU89mcZ7J7MJjqIV8uiLmuZhUBA0ig+i2gE5ropPsZVoWIkg69fJv
         /gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Uein13J33hNHfMCTFZGOPOqcobL+adoxDZbgj7HJRY=;
        b=zczdX7hWnYA/qdkNbDVwxxtP4yVe0KbnY8rMsh+qQWQgADIAtwDPAWL+UsVKkOmdRm
         ROyGe5KCNSxYpWsgcoJAl2W17XmXbPMNVSJodEY9Bf84+37eTN/6Whi0C0Y+zm1TeCG1
         tCerOKMPpQeMhPHI8G3gjWn3UEb+zJExUK1YFbiFxeOgvD0CucuodLYr5foO/PnjT87R
         yi5UCOmYY9qD1VC8pYVdyMfhaTfexy8plsYkw5ayfymLimFMGox2Vb9CXUxZwJjaJ3bY
         0MytHXvO6VIkwop7XOsGyNNh5fWUDVzM5A8tkbEtWA4AogBXVaQznLbp8wQUqY2yKTCP
         TGLQ==
X-Gm-Message-State: AOAM532cGwFMvVVKhigUYDOJk16UeYsR9pWGPQpKP+XNOFThKIQ1RQpF
        BuzRGYl7Y8lf3N7BCO/zscBLbWDELL5Uug==
X-Google-Smtp-Source: ABdhPJzZGiDm2ipUgBOW3RaP+RwoqA14v1IqR/lcLT9BbXfr4EDwq5yZ2NmWQR6OeQzsmHro5wCz9Q==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr3068749wro.320.1637014719808;
        Mon, 15 Nov 2021 14:18:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:39 -0800 (PST)
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
Subject: [RFC PATCH 08/21] usage.c: add a non-fatal bug() function to go with BUG()
Date:   Mon, 15 Nov 2021 23:18:18 +0100
Message-Id: <RFC-patch-08.21-6a384edf6ce-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a bug() function to use in cases where we'd like to indicate a
runtime BUG(), but would like to deref the BUG() call because we're
possibly accumulating more bug() callers to exhaustively indicate what
went wrong. This will be used in place of optbug() in parse-options.c

Any caller to bug() must follow up such calls with BUG_if_bug(), and
as the tests and documentation here show we'll catch missing
BUG_if_bug() invocations in our exit() wrapper.

I'd previously proposed this as part of another series[1], in that
use-case we ended thinking a BUG() would be better (and eventually
96e41f58fe1 (fsck: report invalid object type-path combinations,
2021-10-01) ended up with neither). Here I'll be converting existing
in-tree users to this, so hopefully this won't be controversial.

I'm not bothering to support the "else" branch of
"HAVE_VARIADIC_MACROS". Since 765dc168882 (git-compat-util: always
enable variadic macros, 2021-01-28) we've had a hard dependency on
them, and manually undefining the macro will nowadays result in a hard
compilation error. We should follow up with [2] instead and remove the
"else" codepath.

1. https://lore.kernel.org/git/YGRXomWwRYPdXZi3@coredump.intra.peff.net/
2. https://lore.kernel.org/git/cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/api-error-handling.txt          | 13 ++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 git-compat-util.h                             | 12 +++++
 t/helper/test-trace2.c                        | 27 ++++++++--
 t/t0210-trace2-normal.sh                      | 52 +++++++++++++++++++
 trace2.c                                      |  6 +++
 usage.c                                       | 32 ++++++++++--
 7 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 8be4f4d0d6a..818489bc3d4 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,7 +1,7 @@
 Error reporting in git
 ======================
 
-`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+`BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
 various kinds.
 
 - `BUG` is for failed internal assertions that should never happen,
@@ -18,6 +18,17 @@ various kinds.
   to the user and returns -1 for convenience in signaling the error
   to the caller.
 
+- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
+  returns -1 like error. The user should then call `BUG_if_bug()` to die.
++
+This is for the convenience of APIs who'd like to potentially report
+more than one bug before calling `BUG_if_bug()`, which will invoke
+`BUG()` if there were any preceding calls to `bug()`.
++
+We call `BUG_if_bug()` ourselves in on `exit()` (via a wrapper, not
+`atexit()`), which guarantees that we'll catch cases where we forgot
+to invoke `BUG_if_bug()` following a call or calls to `bug()`.
+
 - `warning` is for reporting situations that probably should not
   occur but which the user (and Git) can continue to work around
   without running into too many problems.  Like `error`, it
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..68e221b95ab 100644
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
index 2f44aa86a8b..9b02a3e05ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1198,9 +1198,21 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
 
+/* usage.c: if bug() is called we must have a BUG() invocation afterwards */
+extern int bug_called_must_BUG;
+
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+__attribute__((format (printf, 3, 4)))
+int bug_fl(const char *file, int line, const char *fmt, ...);
+#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_if_bug() do { \
+	if (bug_called_must_BUG) { \
+		bug_called_must_BUG = 0; \
+		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
+	} \
+} while (0)
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f93633f895a..84bc26fc20c 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -198,14 +198,29 @@ static int ut_006data(int argc, const char **argv)
 	return 0;
 }
 
-static int ut_007bug(int argc, const char **argv)
+/*
+ * Ensure that BUG() and bug() print to trace2.
+ */
+static int ut_007BUG(int argc, const char **argv)
 {
-	/*
-	 * Exercise BUG() to ensure that the message is printed to trace2.
-	 */
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
index 179caa72cfe..970e541a0d1 100644
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
index 43231c8eac0..b411dfb5641 100644
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
@@ -322,6 +328,22 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 
+int bug_called_must_BUG;
+int bug_fl(const char *file, int line, const char *fmt, ...)
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
+
+	return -1;
+}
+
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
 {
-- 
2.34.0.rc2.809.g11e21d44b24

