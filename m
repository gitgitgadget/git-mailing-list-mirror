Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E8BC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C7D22AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgLVAGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLVAGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E9C0619D2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z62so15603734yba.23
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=13m9umWzWchNSUyzLQzXZdvVhBzh116z7X5uxpA1VA8=;
        b=bPJk8qE9fV5pYCslVk6rulLmMDHEXj86qjKXNeKmHmaq2He4ljU0dfgQaAu7dwZ0cA
         FlR+J3fUKxSW/nijtaY/uHHRSVO2fTqHXYM11onX3H4Yxge/TYlKAbUY4Vel9g34DmPg
         /MijtFbMsbj9qZ5fOsKT4ZVbFQ212HWX/qREUILwQdLPoBiVycj04jXHMfhWamTxbFuz
         wkOQeR0+EtRzhjFU1Tpj7cB2ouqepkhC11APdDObtkZLkbXJ5Rklqr3noH4guxMt9hJG
         CppvHUmtjTSWH6n+rSz9IxiJaUZYqsSFpnT7YdbDSqqdXEjwX6jOLR6Cohe8VX/IRxek
         4GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=13m9umWzWchNSUyzLQzXZdvVhBzh116z7X5uxpA1VA8=;
        b=rTBGAJmsxiMP6oa1Zv8r3k+sy0jTgt4VWQ/wtLrldSVeEVJoiADOlEdAPzOWFMUm5b
         bmaQmv+Na6+3LYTnM3ohuNm2BwBn6i2YDNCnXjvuVuGyCPGLDp2cnLORfEqtqS06EGSW
         znohRZxdOnceLxAf6TUMC28dUgh7zMewNe/XzCw37/gBVrb9DD/Liy/4Y06qasvfOYi9
         CXKEphn0Hg7Rrhe5OcWRQF1irbFwOH4UdhZtcARnUXz3LOOXpj+gb38WDwDVTqr70nMd
         khjAtMZivRr3ZdrWZVO56rLpIYCugqVf0o8vJXSb1GQZCqmoNwX4gmbh2tltyXUa1P83
         YTqw==
X-Gm-Message-State: AOAM532NOgQU5CuFkzwkD52pLYm4DOWIShOTJ1fchZh00CoFCAoK4UXj
        p1xQcIwL2Iu+1WMr/SrNKgBElHNXhXrQWbZeIc7k8c7mdh1dOHxT0KbkUBPm4PVu5+GduO+uqO0
        ugM0WE515EdIvOY6V6tEJFWqF2Kn3lyDwQQiSYtzcbUgGr1T1sgyuV5S2XkJzYJCtG9vHyArlwQ
        ==
X-Google-Smtp-Source: ABdhPJwAgyoDI/2OxiJ8Y7hVcbXKPJzv3NiY3YWLUGHSMm2YsiNuqlXihs8ey4nWSNZxnT0hGys0ikaetQ4b+8dlS4o=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d0cf:: with SMTP id
 h198mr25430782ybg.384.1608595514321; Mon, 21 Dec 2020 16:05:14 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:35 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 17/17] run-command: stop thinking about hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hook.h has replaced all run-command.h hook-related functionality.
run-command.h:run_hooks_le/ve and find_hook are no longer used anywhere
in the codebase. So, let's delete the dead code - or, in the one case
where it's still needed, move it to an internal function in hook.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c        | 39 ++++++++++++++++++++++++++++--
 run-command.c | 66 ---------------------------------------------------
 run-command.h | 24 -------------------
 3 files changed, 37 insertions(+), 92 deletions(-)

diff --git a/hook.c b/hook.c
index dc241f7ec5..0ac984983e 100644
--- a/hook.c
+++ b/hook.c
@@ -196,6 +196,41 @@ static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
 	}
 }
 
+static const char *find_legacy_hook(const char *name)
+{
+	static struct strbuf path = STRBUF_INIT;
+
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "hooks/%s", name);
+	if (access(path.buf, X_OK) < 0) {
+		int err = errno;
+
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, STRIP_EXTENSION);
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+		if (errno == EACCES)
+			err = errno;
+#endif
+
+		if (err == EACCES && advice_ignored_hook) {
+			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+			if (!string_list_lookup(&advise_given, name)) {
+				string_list_insert(&advise_given, name);
+				advise(_("The '%s' hook was ignored because "
+					 "it's not set as executable.\n"
+					 "You can disable this warning with "
+					 "`git config advice.ignoredHook false`."),
+				       path.buf);
+			}
+		}
+		return NULL;
+	}
+	return path.buf;
+}
+
+
 struct list_head* hook_list(const struct strbuf* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
@@ -213,7 +248,7 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	git_config(hook_config_lookup, (void*)&cb_data);
 
 	if (have_git_dir())
-		legacy_hook_path = find_hook(hookname->buf);
+		legacy_hook_path = find_legacy_hook(hookname->buf);
 
 	/* Unconditionally add legacy hook, but annotate it. */
 	if (legacy_hook_path) {
@@ -244,7 +279,7 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
 	int could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
 				should_run_hookdir == HOOKDIR_WARN ||
 				should_run_hookdir == HOOKDIR_YES)
-				&& !!find_hook(hookname);
+				&& !!find_legacy_hook(hookname);
 
 	strbuf_addf(&hook_key, "hook.%s.command", hookname);
 
diff --git a/run-command.c b/run-command.c
index 0dce6bec83..16656135dd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1310,72 +1310,6 @@ int async_with_fork(void)
 #endif
 }
 
-const char *find_hook(const char *name)
-{
-	static struct strbuf path = STRBUF_INIT;
-
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0) {
-		int err = errno;
-
-#ifdef STRIP_EXTENSION
-		strbuf_addstr(&path, STRIP_EXTENSION);
-		if (access(path.buf, X_OK) >= 0)
-			return path.buf;
-		if (errno == EACCES)
-			err = errno;
-#endif
-
-		if (err == EACCES && advice_ignored_hook) {
-			static struct string_list advise_given = STRING_LIST_INIT_DUP;
-
-			if (!string_list_lookup(&advise_given, name)) {
-				string_list_insert(&advise_given, name);
-				advise(_("The '%s' hook was ignored because "
-					 "it's not set as executable.\n"
-					 "You can disable this warning with "
-					 "`git config advice.ignoredHook false`."),
-				       path.buf);
-			}
-		}
-		return NULL;
-	}
-	return path.buf;
-}
-
-int run_hook_ve(const char *const *env, const char *name, va_list args)
-{
-	struct child_process hook = CHILD_PROCESS_INIT;
-	const char *p;
-
-	p = find_hook(name);
-	if (!p)
-		return 0;
-
-	strvec_push(&hook.args, p);
-	while ((p = va_arg(args, const char *)))
-		strvec_push(&hook.args, p);
-	hook.env = env;
-	hook.no_stdin = 1;
-	hook.stdout_to_stderr = 1;
-	hook.trace2_hook_name = name;
-
-	return run_command(&hook);
-}
-
-int run_hook_le(const char *const *env, const char *name, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
-	va_end(args);
-
-	return ret;
-}
-
 struct io_pump {
 	/* initialized by caller */
 	int fd;
diff --git a/run-command.h b/run-command.h
index 2ad8271f56..e67bd22c5a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -194,30 +194,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-const char *find_hook(const char *name);
-
-/**
- * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
- * The further arguments correspond to the hook arguments.
- * The last argument has to be NULL to terminate the arguments list.
- * If the hook does not exist or is not executable, the return
- * value will be zero.
- * If it is executable, the hook will be executed and the exit
- * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
- */
-LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
-
 /*
  * Trigger an auto-gc
  */
-- 
2.28.0.rc0.142.g3c755180ce-goog

