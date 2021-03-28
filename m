Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C38C433E3
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A27D6199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhC1C06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhC1C0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:26:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E872C0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y124-20020a1c32820000b029010c93864955so6769447wmy.5
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3AttzulvWHG4Ki/5/b/tLp+mDDPyLNYQc4/L192/qs=;
        b=H+NfV/BLo2BlnEyUZEUlHWwFUitJwwe3GAjA2A4adY8JGmLP35/zz5Lffi2Zy8NBNf
         nNG6Q54BVWjJhqChPHuA1w91XbnUphwrZE7SrxmWFt4WE6xnppS/wQWRxZXeRN5L5w3c
         wAkt3Wpn366Au+cb71I5M28j7LH3LralH/vs2FCpr/uZ4XSzle2FDckYhiiAvBKyZv2K
         IVaCHvV54nESwhrgjeKkcBIaCL2ZxNFE0qGD1tLpTy0XKcN1WnX34J8YKDFsSwSR5Ybe
         /MS49vLBB4H/QFUZQ0i/YbanaGfsXU6x7YlIqVXUmNor5WZii34DKcOev2Lr6k4M03+I
         Xaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3AttzulvWHG4Ki/5/b/tLp+mDDPyLNYQc4/L192/qs=;
        b=IJ3wkib5nhBVaYaVo5KwGOwVEuxhMquYipVZRXWc1fPsB9j34Qd7fE7YeCy03zFD19
         QaA4ql5t2Z4qjGXFgS3M9gmLs+QvJt8h4VFJEqf+g+7Qr3HHn/MsvuTsN2SYcWpmfHO0
         SzkXYTF53euglBi889kDRYo1gX6hGd4QuT/Fuk8RJcs7lKjJcer+jOHDdQIWrme1P8ov
         cwySWpsnADyvResm1vnYJhUI4u1rUUxm43g1y/j/ifW6fSnWxlKuGhHBLpw10JiL5WfC
         rCvKWhyvCxCMermcwk0Q7alebrtgmDodcTL6uhBzuor69ZbqOM6+JrceIN/Qn+FQgHLq
         8obA==
X-Gm-Message-State: AOAM5315CJsvU9khS144qU/MQRs+8dWXGxtnym5UsOTcu3o4XVfA8mUm
        E1XzzkPVCCWh0R1Vpf8baX6WzeoCrIC5yg==
X-Google-Smtp-Source: ABdhPJxB9NITO1bhvkxnULCstQPf0fXNGydhkgrpClr7HlNJqKjAvs4SPMJRDly5qox1dAoZRbW74w==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr19100695wmj.52.1616898380744;
        Sat, 27 Mar 2021 19:26:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11sm17887305wmi.3.2021.03.27.19.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:26:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] usage.c: add a non-fatal bug() function to go with BUG()
Date:   Sun, 28 Mar 2021 04:26:03 +0200
Message-Id: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a bug() function that works like error() except the message is
prefixed with "bug:" instead of "error:".

The reason this is needed is for e.g. the fsck code. If we encounter
what we'd consider a BUG() in the middle of fsck traversal we'd still
like to try as hard as possible to go past that object and complete
the fsck, instead of hard dying. A follow-up commit will introduce
such a use in object-file.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/api-error-handling.txt          |  8 ++++-
 Documentation/technical/api-trace2.txt        |  4 +--
 git-compat-util.h                             |  3 ++
 run-command.c                                 | 11 +++++++
 t/helper/test-trace2.c                        | 14 +++++++--
 t/t0210-trace2-normal.sh                      | 19 ++++++++++++
 usage.c                                       | 29 +++++++++++++++++++
 7 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 8be4f4d0d6a..9d6ac6f6649 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,7 +1,7 @@
 Error reporting in git
 ======================
 
-`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+`BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
 various kinds.
 
 - `BUG` is for failed internal assertions that should never happen,
@@ -18,6 +18,12 @@ various kinds.
   to the user and returns -1 for convenience in signaling the error
   to the caller.
 
+- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
+  has the same non-fatal semantics as `error`. It's meant to signal an
+  internal bug in a library whose caller might still want to attempt
+  some amount of graceful recovery, or to append other error output of
+  their own.
+
 - `warning` is for reporting situations that probably should not
   occur but which the user (and Git) can continue to work around
   without running into too many problems.  Like `error`, it
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 3f52f981a2d..cafe373f405 100644
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
index 9ddf9d7044b..13c1dcf9dcc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -463,6 +463,7 @@ NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int bug(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -497,6 +498,8 @@ static inline int const_error(void)
 typedef void (*report_fn)(const char *, va_list params);
 
 void set_die_routine(NORETURN_PTR report_fn routine);
+void set_bug_routine(report_fn routine);
+report_fn get_bug_routine(void);
 void set_error_routine(report_fn routine);
 report_fn get_error_routine(void);
 void set_warn_routine(report_fn routine);
diff --git a/run-command.c b/run-command.c
index be6bc128cd9..8b818b063ff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -348,6 +348,12 @@ static void fake_fatal(const char *err, va_list params)
 	vreportf("fatal: ", err, params);
 }
 
+static void child_bug_fn(const char *err, va_list params)
+{
+	const char msg[] = "bug() should not be called in child\n";
+	xwrite(2, msg, sizeof(msg) - 1);
+}
+
 static void child_error_fn(const char *err, va_list params)
 {
 	const char msg[] = "error() should not be called in child\n";
@@ -371,9 +377,12 @@ static void NORETURN child_die_fn(const char *err, va_list params)
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
 	static void (*old_errfn)(const char *err, va_list params);
+	static void (*old_bugfn)(const char *err, va_list params);
 
 	old_errfn = get_error_routine();
 	set_error_routine(fake_fatal);
+	old_bugfn = get_bug_routine();
+	set_bug_routine(fake_fatal);
 	errno = cerr->syserr;
 
 	switch (cerr->err) {
@@ -399,6 +408,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 		error_errno("cannot exec '%s'", cmd->argv[0]);
 		break;
 	}
+	set_bug_routine(old_bugfn);
 	set_error_routine(old_errfn);
 }
 
@@ -789,6 +799,7 @@ int start_command(struct child_process *cmd)
 		 * called, they can take stdio locks and malloc.
 		 */
 		set_die_routine(child_die_fn);
+		set_error_routine(child_bug_fn);
 		set_error_routine(child_error_fn);
 		set_warn_routine(child_warn_fn);
 
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f93633f895a..6248427e4bf 100644
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
@@ -206,6 +206,15 @@ static int ut_007bug(int argc, const char **argv)
 	BUG("the bug message");
 }
 
+static int ut_008bug(int argc, const char **argv)
+{
+	/*
+	 * Exercise BUG() to ensure that the message is printed to trace2.
+	 */
+	bug("the bug message");
+	return 0;
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -222,7 +231,8 @@ static struct unit_test ut_table[] = {
 	{ ut_004child,    "004child",  "[<child_command_line>]" },
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
-	{ ut_007bug,      "007bug",    "" },
+	{ ut_007BUG,      "007bug",    "" },
+	{ ut_008bug,      "008bug",    "" },
 };
 /* clang-format on */
 
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 0cf3a63b75b..9c866af971f 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -166,6 +166,25 @@ test_expect_success 'BUG messages are written to trace2' '
 	test_cmp expect actual
 '
 
+# Verb 008bug
+#
+# Check that BUG writes to trace2
+
+test_expect_success 'bug messages are written to trace2' '
+	test_when_finished "rm trace.normal actual expect" &&
+	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 008bug &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 008bug
+		cmd_name trace2 (trace2)
+		error the bug message
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/usage.c b/usage.c
index c7d233b0de9..34bd3abf048 100644
--- a/usage.c
+++ b/usage.c
@@ -69,6 +69,13 @@ static NORETURN void die_builtin(const char *err, va_list params)
 	exit(128);
 }
 
+static void bug_builtin(const char *err, va_list params)
+{
+	trace2_cmd_error_va(err, params);
+
+	vreportf("bug: ", err, params);
+}
+
 static void error_builtin(const char *err, va_list params)
 {
 	trace2_cmd_error_va(err, params);
@@ -109,6 +116,7 @@ static int die_is_recursing_builtin(void)
  * (ugh), so keep things static. */
 static NORETURN_PTR report_fn usage_routine = usage_builtin;
 static NORETURN_PTR report_fn die_routine = die_builtin;
+static report_fn bug_routine = bug_builtin;
 static report_fn error_routine = error_builtin;
 static report_fn warn_routine = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
@@ -118,11 +126,22 @@ void set_die_routine(NORETURN_PTR report_fn routine)
 	die_routine = routine;
 }
 
+
+void set_bug_routine(report_fn routine)
+{
+	bug_routine = routine;
+}
+
 void set_error_routine(report_fn routine)
 {
 	error_routine = routine;
 }
 
+report_fn get_bug_routine(void)
+{
+	return bug_routine;
+}
+
 report_fn get_error_routine(void)
 {
 	return error_routine;
@@ -223,6 +242,16 @@ int error_errno(const char *fmt, ...)
 	return -1;
 }
 
+int bug(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	bug_routine(err, params);
+	va_end(params);
+	return -1;
+}
+
 #undef error
 int error(const char *err, ...)
 {
-- 
2.31.1.445.g91d8e479b0a

