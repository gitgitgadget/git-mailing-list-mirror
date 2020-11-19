Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB0EC63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB41422256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPqkE+fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgKSP4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgKSP4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D707C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:56:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so7662118wmd.4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ypje8YbWy0Cn+itZyt9VfhV9V0SA6fZjBGM9LoYEBEw=;
        b=EPqkE+fxcxHrB3jcWKfRKfb1R1+wiwriaIixbto8whvUSKMzA7/Xpesduz1lMP78DC
         EcXzhHirvzWYMPmqc03uzIUOn2ozZ4Daoc2yQKguBn1AMsfqcdfL4Fb97mmtX4Q2MFLN
         VDJOu8Zi+EjL4nE5F/IghCgGJDE/lkH6M2uezAOYGK3z3HgIXBXNol8kt7VF7OLttxPq
         GFwVvNY81+yVTGQ0zVJ6HwB+QrGmNNg9gwQG/ofhsawHk8W0nsXfrawjtNI5bAwtmg2z
         RFyoDh++X95TQafIuu5laVjp4Ns4mSLXliQGT3NcorvdZXSBTbHS3g0OyR01LxvuSIEK
         i+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ypje8YbWy0Cn+itZyt9VfhV9V0SA6fZjBGM9LoYEBEw=;
        b=rFI+uFnPU5dLdqtVHOD7cS3v6kw3FmBDNjG5v5Kflps5VqfNyNNsJDASN9l6QJShHI
         laXsl1Fdh2UiYWr+GxCBKRc9bo5QGAqI/dLM2Do/vL62UcpP9HcV+A/RXQWP3GsECI0g
         UkzWyzK1T236sieTZJTQPKL3PDt658x1se208JxHdh1NlGEwWT7ijCZ9G+yHyy1j3e8r
         oUH2anXoMmSI6YOCZPJlhafHM0ASmmEEviFSeMUQip38xTXjq4R8xnREMZ9NBCq9+68m
         IMZDMm3+10Zx1K//F0SJRDDEHnfq6T8eaPoQyW4c+s4nobLpwkxpl54xseD22gDQhzTI
         DHpw==
X-Gm-Message-State: AOAM531QHABmlz/Z8c9/VZHMEkq9+6leJh5dm6t4guSoYu9ZVMywGUss
        E+1ZDyULpTh0NYIcSZuEWYeUC7hsK4c=
X-Google-Smtp-Source: ABdhPJwdxHYGYjO/4Zz2Jvz8EjYa1zGJuvpVTzJszllIP/oIatcKFF0gob+HlDTx49TYqQZJQrzJsg==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr4994351wmk.125.1605801377624;
        Thu, 19 Nov 2020 07:56:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm247979wrf.68.2020.11.19.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:56:17 -0800 (PST)
Message-Id: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v2.git.1605801043899.gitgitgadget@gmail.com>
References: <pull.790.v2.git.1605801043899.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:56:16 +0000
Subject: [PATCH v3] hooks: allow input from stdin for commit-related hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Let hooks receive user input if applicable.

Closing stdin originates in f5bbc3225 (Port git commit to C,
2007). Looks like the original shell implementation did have
stdin open. Not clear why the author chose to close it on
the C port (maybe copy&paste).

Allow stdin only for commit-related hooks. Some of the other
hooks pass their own input to the hook, so don't change them.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    hooks: allow input from stdin for commit-related hooks
    
    Let hooks receive user input if applicable.
    
    Closing stdin originates in f5bbc3225 (Port git commit to C, 2007).
    Looks like the original shell implementation did have stdin open. Not
    clear why the author chose to close it on the C port (maybe copy&paste).
    
    The only hook that passes internal information to the hook via stdin is
    pre-push, which has its own logic.
    
    Some references of users requesting this feature. Some of them use
    acrobatics to gain access to stdin: [1] 
    https://stackoverflow.com/q/1067874/764870[2] 
    https://stackoverflow.com/q/47477766/764870[3] 
    https://stackoverflow.com/q/3417896/764870[4] 
    https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165[5] 
    https://github.com/typicode/husky/issues/442

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-790%2Forgads%2Fhooks-stdin-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-790/orgads/hooks-stdin-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/790

Range-diff vs v2:

 1:  6a9bcf9d8b ! 1:  2f7a45c828 hooks: allow input from stdin
     @@ Metadata
      Author: Orgad Shaneh <orgads@gmail.com>
      
       ## Commit message ##
     -    hooks: allow input from stdin
     +    hooks: allow input from stdin for commit-related hooks
      
          Let hooks receive user input if applicable.
      


 builtin/am.c                                  |  6 +--
 builtin/checkout.c                            |  2 +-
 builtin/clone.c                               |  2 +-
 builtin/gc.c                                  |  2 +-
 builtin/merge.c                               |  2 +-
 builtin/rebase.c                              |  2 +-
 builtin/receive-pack.c                        |  2 +-
 commit.c                                      |  2 +-
 read-cache.c                                  |  2 +-
 reset.c                                       |  2 +-
 run-command.c                                 |  9 +++--
 run-command.h                                 | 15 +++++---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 37 ++++++++++++++++++-
 t/t7504-commit-msg-hook.sh                    | 15 ++++++++
 t/t7505-prepare-commit-msg-hook.sh            | 14 +++++++
 15 files changed, 92 insertions(+), 22 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f22c73a05b..1946569d5b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -428,7 +428,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	int ret;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	ret = run_hook_le(NULL, 0, "applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1559,7 +1559,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hook_le(NULL, 0, "pre-applypatch", NULL))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1611,7 +1611,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hook_le(NULL, 0, "post-applypatch", NULL);
 
 	strbuf_release(&sb);
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129..293e8ebd76 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -104,7 +104,7 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
+	return run_hook_le(NULL, 0, "post-checkout",
 			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
 			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
 			   changed ? "1" : "0", NULL);
diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..6cfd2f23be 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -816,7 +816,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
+	err |= run_hook_le(NULL, 0, "post-checkout", oid_to_hex(&null_oid),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 5cd2a43f9f..c790a362df 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,7 +385,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hook_le(NULL, 0, "pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 4c133402a6..1f1d234879 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -474,7 +474,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hook_le(NULL, 0, "post-merge", squash ? "1" : "0", NULL);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7b65525301..c17f7a628b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2014,7 +2014,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
+	    run_hook_le(NULL, 0, "pre-rebase", options.upstream_arg,
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..c1398af755 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1384,7 +1384,7 @@ static const char *push_to_checkout(unsigned char *hash,
 				    const char *work_tree)
 {
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
+	if (run_hook_le(env->v, 0, push_to_checkout_hook,
 			hash_to_hex(hash), NULL))
 		return "push-to-checkout hook declined";
 	else
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
 
diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..a83beac63e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3070,7 +3070,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
+	run_hook_le(NULL, 0, "post-index-change",
 			istate->updated_workdir ? "1" : "0",
 			istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
diff --git a/reset.c b/reset.c
index 2f4fbd07c5..33687b0b5b 100644
--- a/reset.c
+++ b/reset.c
@@ -127,7 +127,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
+		run_hook_le(NULL, 0, "post-checkout",
 			    oid_to_hex(orig ? orig : &null_oid),
 			    oid_to_hex(oid), "1", NULL);
 
diff --git a/run-command.c b/run-command.c
index 2ee59acdc8..21b1f0a5e9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1343,7 +1343,7 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+int run_hook_ve(const char *const *env, int opt, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
@@ -1356,20 +1356,21 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
 	hook.env = env;
-	hook.no_stdin = 1;
+	if (!(opt & RUN_HOOK_ALLOW_STDIN))
+		hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
 
 	return run_command(&hook);
 }
 
-int run_hook_le(const char *const *env, const char *name, ...)
+int run_hook_le(const char *const *env, int opt, const char *name, ...)
 {
 	va_list args;
 	int ret;
 
 	va_start(args, name);
-	ret = run_hook_ve(env, name, args);
+	ret = run_hook_ve(env, opt, name, args);
 	va_end(args);
 
 	return ret;
diff --git a/run-command.h b/run-command.h
index 6472b38bde..e6a850c6fe 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,11 +201,16 @@ int run_command(struct child_process *);
  */
 const char *find_hook(const char *name);
 
+#define RUN_HOOK_ALLOW_STDIN 1
+
 /**
  * Run a hook.
- * The first argument is a pathname to an index file, or NULL
- * if the hook uses the default index file or no index is needed.
- * The second argument is the name of the hook.
+ * The first argument is an array of environment variables, or NULL
+ * if the hook uses the default environment and doesn't require
+ * additional variables.
+ * The second argument is zero or RUN_HOOK_ALLOW_STDIN, which enables
+ * stdin for the child process (the default is no_stdin).
+ * The third argument is the name of the hook.
  * The further arguments correspond to the hook arguments.
  * The last argument has to be NULL to terminate the arguments list.
  * If the hook does not exist or is not executable, the return
@@ -215,8 +220,8 @@ const char *find_hook(const char *name);
  * On execution, .stdout_to_stderr and .no_stdin will be set.
  */
 LAST_ARG_MUST_BE_NULL
-int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
+int run_hook_le(const char *const *env, int opt, const char *name, ...);
+int run_hook_ve(const char *const *env, int opt, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..e915ffe546 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -7,6 +7,7 @@ test_description='pre-commit and pre-merge-commit hooks'
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 PRECOMMIT="$HOOKDIR/pre-commit"
 PREMERGE="$HOOKDIR/pre-merge-commit"
+POSTCOMMIT="$HOOKDIR/post-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -28,11 +29,15 @@ test_expect_success 'sample script setup' '
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
+	! read -r line || echo "$line" > hook_input
+	exit 0
+	EOF
 '
 
 test_expect_success 'root commit' '
@@ -278,4 +283,34 @@ test_expect_success 'check the author in hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'with user input' '
+	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
+	echo "user input" > user_input &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" < user_input &&
+	test_cmp user_input hook_input
+'
+
+test_expect_success 'post-commit with user input' '
+	test_when_finished "rm -f \"$POSTCOMMIT\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$POSTCOMMIT" &&
+	echo "user input" > user_input &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" < user_input &&
+	test_cmp user_input hook_input
+'
+
+test_expect_success 'with user input (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" user_input hook_input" &&
+	cp "$HOOKDIR/user-input.sample" "$PREMERGE" &&
+	echo "user input" > user_input &&
+	git checkout side &&
+	git merge -m "merge master" master < user_input &&
+	git checkout master &&
+	test_cmp user_input hook_input
+'
+
 test_done
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..ad467aad86 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -294,5 +294,20 @@ test_expect_success 'hook is called for reword during `rebase -i`' '
 
 '
 
+# now a hook that accepts input and writes it as the commit message
+cat > "$HOOK" <<'EOF'
+#!/bin/sh
+! read -r line || echo "$line" > "$1"
+EOF
+chmod +x "$HOOK"
+
+test_expect_success 'hook with user input' '
+
+	echo "additional" >> file &&
+	git add file &&
+	echo "user input" | git commit -m "additional" &&
+	commit_msg_is "user input"
+
+'
 
 test_done
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 94f85cdf83..16a161f129 100755
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
+	echo "more" >> file &&
+	git add file &&
+	echo "user input" | git commit -m "more" &&
+	test "$(git log -1 --pretty=format:%s)" = "message (no editor) user input"
+
+'
+
 test_expect_success 'with hook (-m editor)' '
 
 	echo "more" >> file &&

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
