Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D6C63777
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBAA22272
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZABy0gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKSU4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgKSU4g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 15:56:36 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1BC0613D4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so7947628wmb.5
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gIcetYf7ytiK5TTkwao4ZRRAHstrXrEqPcOs/rXjqNM=;
        b=IZABy0gM3sqKd/8wAqRp+6A61jQynh+NI9dROX+w7GFYc+bHCazI6B0f/0HkLEFrTe
         LI0X4Ym6Mxv1OkUGsHHx50tejP6xy1u4DCuLQr8avfOljpmnby8bmgwY/LaJsNsKnXqm
         qHctu1IeK1QrOK+IofI1+nj9Rhi/q4JNFMoJI1LW8FXZ720G5yttAd+EBcqm9JKqi8b8
         XNJLf6PzpV7Ry5+tONZeGasxYA/K6zvA8EVdzqfvWWrqyacpoJyb3QvuBT6vdLv0+e+w
         cpXP82w56gavKb+MBH+rKVD3NtHmtibbw2MWe5umcD+nhYKXsq23ILk5ro6QNN8cOQZZ
         PieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gIcetYf7ytiK5TTkwao4ZRRAHstrXrEqPcOs/rXjqNM=;
        b=HVRDmifrIOPm3fqd0CQuLXvdhwNozl1xok1rfytFBKHL8EYlFc6xHe7or7yej8K0yH
         q3gi5AJfLSYTBoySCo2LxfyPAK61YZpIAhGo9J2p3/F6XqCnSQ3Xmk9dC7y1t6f+Ixn4
         2AX6V2jZfV5L+xr3Kw+gQ7a94JxW1Rwg995+LFfdv3DpJQoFRL3svZ7P6pMzeIiiCbbX
         GwNayJ+nmRGq73D/yz/XCUCMtSGv2/GyaZUlS+oFrVtNQYi7Xhj/zUxPFWUJbAbvI/Bc
         Z8J9GCc3J/MoOSQ2jiimspjo58cfz1CyjZRm6Vz2/1vZeTIwWndb8dkd5HcgEj+lT/g7
         uTqg==
X-Gm-Message-State: AOAM533CQ+ukCREcq/sXivLiQ+4I7Nl7PtlsV4KX3I+Vw29aH3ydu49E
        s4/XClBMO3U8isDii9YaUkZatROkDNg=
X-Google-Smtp-Source: ABdhPJwrTkK42vdPF5pvf3zec/NgW2fwRAO1/2o0dC6aWdAomzsscCKqyPi5Y7ar4VzJuDTwfMMZEw==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr6424017wme.8.1605819392785;
        Thu, 19 Nov 2020 12:56:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm2107851wrp.54.2020.11.19.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 12:56:32 -0800 (PST)
Message-Id: <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
        <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 20:56:29 +0000
Subject: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Let hooks receive user input if applicable.

Closing stdin originates in f5bbc3225 (Port git commit to C,
2007). Looks like the original shell implementation did have
stdin open.

This allows for example prompting the user to choose an issue
in prepare-commit-msg, and add "Fixes #123" to the commit message.

Another possible use-case is running sanity test on pre-commit,
and having a prompt like "This and that issue were found in your
changes. Are you sure you want to commit? [Y/N]".

Allow stdin only for commit-related hooks. Some of the other
hooks pass their own input to the hook, so don't change them.

Note: If pre-commit reads from stdin, and git commit is executed
with -F - (read message from stdin), the message is not read
correctly. This is fixed in the follow-up commit.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 commit.c                                      |  2 +-
 run-command.c                                 |  6 +--
 run-command.h                                 | 17 +++++--
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 46 ++++++++++++++++++-
 t/t7504-commit-msg-hook.sh                    | 15 ++++++
 t/t7505-prepare-commit-msg-hook.sh            | 14 ++++++
 6 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index fe1fa3dc41..775019ec9d 100644
--- a/commit.c
+++ b/commit.c
@@ -1646,7 +1646,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	ret = run_hook_ve(hook_env.v, RUN_HOOK_ALLOW_STDIN, name, args);
 	va_end(args);
 	strvec_clear(&hook_env);
 
diff --git a/run-command.c b/run-command.c
index 2ee59acdc8..38ce53bee5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1343,7 +1343,7 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
@@ -1356,7 +1356,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
 	hook.env = env;
-	hook.no_stdin = 1;
+	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
 
@@ -1369,7 +1369,7 @@ int run_hook_le(const char *const *env, const char *name, ...)
 	int ret;
 
 	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
+	ret = run_hook_ve(env, 0, name, args);
 	va_end(args);
 
 	return ret;
diff --git a/run-command.h b/run-command.h
index 6472b38bde..e613e5e3f9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,22 +201,29 @@ int run_command(struct child_process *);
  */
 const char *find_hook(const char *name);
 
+#define RUN_HOOK_ALLOW_STDIN 1
+
 /**
  * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
+ * The env argument is an array of environment variables, or NULL
+ * if the hook uses the default environment and doesn't require
+ * additional variables.
+ * The flags argument is an OR'ed collection of feature bits like
+ * RUN_HOOK_ALLOW_STDIN defined above, which enables
+ * stdin for the child process (the default is no_stdin).
+ * The name argument is the name of the hook.
  * The further arguments correspond to the hook arguments.
  * The last argument has to be NULL to terminate the arguments list.
  * If the hook does not exist or is not executable, the return
  * value will be zero.
  * If it is executable, the hook will be executed and the exit
  * status of the hook is returned.
- * On execution, .stdout_to_stderr and .no_stdin will be set.
+ * On execution, .stdout_to_stderr will be set, and .no_stdin will be
+ * set unless RUN_HOOK_ALLOW_STDIN flag is requested.
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..7bfb7435c6 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -7,6 +7,7 @@ test_description='pre-commit and pre-merge-commit hooks'
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 PRECOMMIT="$HOOKDIR/pre-commit"
 PREMERGE="$HOOKDIR/pre-merge-commit"
+POSTCOMMIT="$HOOKDIR/post-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -28,11 +29,14 @@ test_expect_success 'sample script setup' '
 	echo $0 >>actual_hooks
 	test $GIT_PREFIX = "success/"
 	EOF
-	write_script "$HOOKDIR/check-author.sample" <<-\EOF
+	write_script "$HOOKDIR/check-author.sample" <<-\EOF &&
 	echo $0 >>actual_hooks
 	test "$GIT_AUTHOR_NAME" = "New Author" &&
 	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
 	EOF
+	write_script "$HOOKDIR/user-input.sample" <<-\EOF
+	! read -r line || echo "$line" >hook_input
+	EOF
 '
 
 test_expect_success 'root commit' '
@@ -278,4 +282,44 @@ test_expect_success 'check the author in hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'with user input' '
+	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
+	echo "user input" >user_input &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" <user_input &&
+	test_cmp user_input hook_input
+'
+
+test_expect_failure 'with user input combined with -F -' '
+	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
+	echo "user input" >user_input &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -F - <user_input &&
+	! test_path_is_file hook_input
+'
+
+test_expect_success 'post-commit with user input' '
+	test_when_finished "rm -f \"$POSTCOMMIT\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$POSTCOMMIT" &&
+	echo "user input" >user_input &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" <user_input &&
+	test_cmp user_input hook_input
+'
+
+test_expect_success 'with user input (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$PREMERGE" &&
+	echo "user input" >user_input &&
+	git checkout side &&
+	git merge -m "merge master" master <user_input &&
+	git checkout master &&
+	test_cmp user_input hook_input
+'
+
 test_done
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..aa76eb7e1f 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -294,5 +294,20 @@ test_expect_success 'hook is called for reword during `rebase -i`' '
 
 '
 
+# now a hook that accepts input and writes it as the commit message
+cat >"$HOOK" <<'EOF'
+#!/bin/sh
+! read -r line || echo "$line" >"$1"
+EOF
+chmod +x "$HOOK"
+
+test_expect_success 'hook with user input' '
+
+	echo "additional" >>file &&
+	git add file &&
+	echo "user input" | git commit -m "additional" &&
+	commit_msg_is "user input"
+
+'
 
 test_done
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 94f85cdf83..aa9c9375e6 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -91,6 +91,11 @@ else
 fi
 test "$GIT_EDITOR" = : && source="$source (no editor)"
 
+if read -r line
+then
+	source="$source $line"
+fi
+
 if test $rebasing = 1
 then
 	echo "$source $(get_last_cmd)" >"$1"
@@ -113,6 +118,15 @@ test_expect_success 'with hook (-m)' '
 
 '
 
+test_expect_success 'with hook (-m and input)' '
+
+	echo "more" >>file &&
+	git add file &&
+	echo "user input" | git commit -m "more" &&
+	test "$(git log -1 --pretty=format:%s)" = "message (no editor) user input"
+
+'
+
 test_expect_success 'with hook (-m editor)' '
 
 	echo "more" >> file &&
-- 
gitgitgadget

