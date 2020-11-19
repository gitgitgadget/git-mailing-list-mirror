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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BFDC388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D2D2225B
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1JpYei4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKSU4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKSU4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 15:56:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF64C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so7805856wrr.13
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LdJ/cYKaCsSZ7FkEXTQbDpYnlcgEK1KZAnazXELNgMM=;
        b=n1JpYei4V7+B2J4b9tRQx3LeNW3t+8z/20opzPjAYGpxWETp5AbfkMAxetdehzIVlS
         WCTgSUpdGlNe0mqYJVsgTC42S5hE5gzN9IFQ0duj5eioIg2uYvmP5mct51O/WEbGs7Pi
         fBqPBwoeUi6QhuPhqI/ttd/Mlk038Oin4i8rN8af2VgsMaWO2J2501YjkGOqMqzgeqIm
         FORVv/hK/fVRrUz/llT2BMrEEL4AskmFX8GnezpQgYR8LJD315OEfIovFtc63Xd4UMcE
         y9Fiq9UlwoAnIUYZ4KKELoGbWM68Q5tOC4UHePy9Dartv73jH/aq+eX4Ii0PdbXlgelk
         nA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LdJ/cYKaCsSZ7FkEXTQbDpYnlcgEK1KZAnazXELNgMM=;
        b=dYQ4T4KkJfezNpZQsyBQdOusfJq8T8FPHMwQUP02Zskyx8bpcl5bsTKvbZcLHCaC/h
         Y8qayo8/60b6rg1nv42xIJAR38KuAXQTnqSEqHGyUJSu9g3CGrSfpvwTkIqMBkA4Ln0n
         AaHlWsg7yqw1MWzyMuiQCKc5VDy/h8baKYowPF5A8R6Q1DWA+4/63XANTuBBbjLNFLOG
         Yx+qa4PgcVaW/Lh2ENZXzhfxe395DcJ3MBOpA/46AxiT4b95Do60ab4DdlOosYWwbNUK
         Bx6rmTC03DNTmKJKTaMZk0/oMRHNscR0l20GS75hqs77HArleRA4tE7b5wEEN8SFtfG1
         w3AA==
X-Gm-Message-State: AOAM530vibaUKR2XSaJNWsWyIytmdw5uyns0Ua+txb2um9ZIgk5H75oY
        6RYoS2jScP8lQubZ0NfZp5QFD8UgQps=
X-Google-Smtp-Source: ABdhPJx9WiEARI67l9cAfPfLFaEJe+4OdjNUyLcIbk6fnmJ7+/A4N1m0kbfhumkI2fr31lo7ujjsyA==
X-Received: by 2002:adf:a551:: with SMTP id j17mr13498869wrb.217.1605819392118;
        Thu, 19 Nov 2020 12:56:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm1798402wrs.22.2020.11.19.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 12:56:31 -0800 (PST)
Message-Id: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 20:56:28 +0000
Subject: [PATCH v4 0/2] hooks: allow input from stdin for commit-related hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let hooks receive user input if applicable.

Closing stdin originates in f5bbc3225 (Port git commit to C, 2007). Looks
like the original shell implementation did have stdin open. Not clear why
the author chose to close it on the C port (maybe copy&paste).

The only hook that passes internal information to the hook via stdin is
pre-push, which has its own logic.

Some references of users requesting this feature. Some of them use
acrobatics to gain access to stdin: [1] 
https://stackoverflow.com/q/1067874/764870[2] 
https://stackoverflow.com/q/47477766/764870[3] 
https://stackoverflow.com/q/3417896/764870[4] 
https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165[5] 
https://github.com/typicode/husky/issues/442

Orgad Shaneh (2):
  hooks: allow input from stdin for commit-related hooks
  commit: fix stdin conflict between message and hook

 builtin/commit.c                              | 14 ++++--
 builtin/merge.c                               | 12 +++--
 commit.c                                      |  4 +-
 commit.h                                      |  3 +-
 run-command.c                                 |  6 +--
 run-command.h                                 | 17 +++++--
 sequencer.c                                   |  6 +--
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 46 ++++++++++++++++++-
 t/t7504-commit-msg-hook.sh                    | 15 ++++++
 t/t7505-prepare-commit-msg-hook.sh            | 14 ++++++
 10 files changed, 113 insertions(+), 24 deletions(-)


base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-790%2Forgads%2Fhooks-stdin-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-790/orgads/hooks-stdin-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/790

Range-diff vs v3:

 1:  2f7a45c828 ! 1:  3bd6024a23 hooks: allow input from stdin for commit-related hooks
     @@ Commit message
      
          Closing stdin originates in f5bbc3225 (Port git commit to C,
          2007). Looks like the original shell implementation did have
     -    stdin open. Not clear why the author chose to close it on
     -    the C port (maybe copy&paste).
     +    stdin open.
      
     -    Allow stdin only for commit-related hooks. Some of the other
     -    hooks pass their own input to the hook, so don't change them.
     +    This allows for example prompting the user to choose an issue
     +    in prepare-commit-msg, and add "Fixes #123" to the commit message.
      
     -    Signed-off-by: Orgad Shaneh <orgads@gmail.com>
     +    Another possible use-case is running sanity test on pre-commit,
     +    and having a prompt like "This and that issue were found in your
     +    changes. Are you sure you want to commit? [Y/N]".
      
     - ## builtin/am.c ##
     -@@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
     - 	int ret;
     - 
     - 	assert(state->msg);
     --	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
     -+	ret = run_hook_le(NULL, 0, "applypatch-msg", am_path(state, "final-commit"), NULL);
     - 
     - 	if (!ret) {
     - 		FREE_AND_NULL(state->msg);
     -@@ builtin/am.c: static void do_commit(const struct am_state *state)
     - 	const char *reflog_msg, *author, *committer = NULL;
     - 	struct strbuf sb = STRBUF_INIT;
     - 
     --	if (run_hook_le(NULL, "pre-applypatch", NULL))
     -+	if (run_hook_le(NULL, 0, "pre-applypatch", NULL))
     - 		exit(1);
     - 
     - 	if (write_cache_as_tree(&tree, 0, NULL))
     -@@ builtin/am.c: static void do_commit(const struct am_state *state)
     - 		fclose(fp);
     - 	}
     - 
     --	run_hook_le(NULL, "post-applypatch", NULL);
     -+	run_hook_le(NULL, 0, "post-applypatch", NULL);
     - 
     - 	strbuf_release(&sb);
     - }
     -
     - ## builtin/checkout.c ##
     -@@ builtin/checkout.c: struct branch_info {
     - static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
     - 			      int changed)
     - {
     --	return run_hook_le(NULL, "post-checkout",
     -+	return run_hook_le(NULL, 0, "post-checkout",
     - 			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
     - 			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
     - 			   changed ? "1" : "0", NULL);
     -
     - ## builtin/clone.c ##
     -@@ builtin/clone.c: static int checkout(int submodule_progress)
     - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
     - 		die(_("unable to write new index file"));
     - 
     --	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
     -+	err |= run_hook_le(NULL, 0, "post-checkout", oid_to_hex(&null_oid),
     - 			   oid_to_hex(&oid), "1", NULL);
     - 
     - 	if (!err && (option_recurse_submodules.nr > 0)) {
     -
     - ## builtin/gc.c ##
     -@@ builtin/gc.c: static int need_to_gc(void)
     - 	else
     - 		return 0;
     - 
     --	if (run_hook_le(NULL, "pre-auto-gc", NULL))
     -+	if (run_hook_le(NULL, 0, "pre-auto-gc", NULL))
     - 		return 0;
     - 	return 1;
     - }
     -
     - ## builtin/merge.c ##
     -@@ builtin/merge.c: static void finish(struct commit *head_commit,
     - 	}
     - 
     - 	/* Run a post-merge hook */
     --	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
     -+	run_hook_le(NULL, 0, "post-merge", squash ? "1" : "0", NULL);
     - 
     - 	apply_autostash(git_path_merge_autostash(the_repository));
     - 	strbuf_release(&reflog_message);
     +    Allow stdin only for commit-related hooks. Some of the other
     +    hooks pass their own input to the hook, so don't change them.
      
     - ## builtin/rebase.c ##
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 
     - 	/* If a hook exists, give it a chance to interrupt*/
     - 	if (!ok_to_skip_pre_rebase &&
     --	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
     -+	    run_hook_le(NULL, 0, "pre-rebase", options.upstream_arg,
     - 			argc ? argv[0] : NULL, NULL))
     - 		die(_("The pre-rebase hook refused to rebase."));
     - 
     +    Note: If pre-commit reads from stdin, and git commit is executed
     +    with -F - (read message from stdin), the message is not read
     +    correctly. This is fixed in the follow-up commit.
      
     - ## builtin/receive-pack.c ##
     -@@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned char *hash,
     - 				    const char *work_tree)
     - {
     - 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
     --	if (run_hook_le(env->v, push_to_checkout_hook,
     -+	if (run_hook_le(env->v, 0, push_to_checkout_hook,
     - 			hash_to_hex(hash), NULL))
     - 		return "push-to-checkout hook declined";
     - 	else
     +    Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
       ## commit.c ##
      @@ commit.c: int run_commit_hook(int editor_is_used, const char *index_file,
     @@ commit.c: int run_commit_hook(int editor_is_used, const char *index_file,
       	strvec_clear(&hook_env);
       
      
     - ## read-cache.c ##
     -@@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
     - 	else
     - 		ret = close_lock_file_gently(lock);
     - 
     --	run_hook_le(NULL, "post-index-change",
     -+	run_hook_le(NULL, 0, "post-index-change",
     - 			istate->updated_workdir ? "1" : "0",
     - 			istate->updated_skipworktree ? "1" : "0", NULL);
     - 	istate->updated_workdir = 0;
     -
     - ## reset.c ##
     -@@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
     - 					    reflog_head);
     - 	}
     - 	if (run_hook)
     --		run_hook_le(NULL, "post-checkout",
     -+		run_hook_le(NULL, 0, "post-checkout",
     - 			    oid_to_hex(orig ? orig : &null_oid),
     - 			    oid_to_hex(oid), "1", NULL);
     - 
     -
       ## run-command.c ##
      @@ run-command.c: const char *find_hook(const char *name)
       	return path.buf;
       }
       
      -int run_hook_ve(const char *const *env, const char *name, va_list args)
     -+int run_hook_ve(const char *const *env, int opt, const char *name, va_list args)
     ++int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args)
       {
       	struct child_process hook = CHILD_PROCESS_INIT;
       	const char *p;
     @@ run-command.c: int run_hook_ve(const char *const *env, const char *name, va_list
       		strvec_push(&hook.args, p);
       	hook.env = env;
      -	hook.no_stdin = 1;
     -+	if (!(opt & RUN_HOOK_ALLOW_STDIN))
     -+		hook.no_stdin = 1;
     ++	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);
       	hook.stdout_to_stderr = 1;
       	hook.trace2_hook_name = name;
       
     - 	return run_command(&hook);
     - }
     - 
     --int run_hook_le(const char *const *env, const char *name, ...)
     -+int run_hook_le(const char *const *env, int opt, const char *name, ...)
     - {
     - 	va_list args;
     +@@ run-command.c: int run_hook_le(const char *const *env, const char *name, ...)
       	int ret;
       
       	va_start(args, name);
      -	ret = run_hook_ve(env, name, args);
     -+	ret = run_hook_ve(env, opt, name, args);
     ++	ret = run_hook_ve(env, 0, name, args);
       	va_end(args);
       
       	return ret;
     @@ run-command.h: int run_command(struct child_process *);
      - * The first argument is a pathname to an index file, or NULL
      - * if the hook uses the default index file or no index is needed.
      - * The second argument is the name of the hook.
     -+ * The first argument is an array of environment variables, or NULL
     ++ * The env argument is an array of environment variables, or NULL
      + * if the hook uses the default environment and doesn't require
      + * additional variables.
     -+ * The second argument is zero or RUN_HOOK_ALLOW_STDIN, which enables
     ++ * The flags argument is an OR'ed collection of feature bits like
     ++ * RUN_HOOK_ALLOW_STDIN defined above, which enables
      + * stdin for the child process (the default is no_stdin).
     -+ * The third argument is the name of the hook.
     ++ * The name argument is the name of the hook.
        * The further arguments correspond to the hook arguments.
        * The last argument has to be NULL to terminate the arguments list.
        * If the hook does not exist or is not executable, the return
     -@@ run-command.h: const char *find_hook(const char *name);
     -  * On execution, .stdout_to_stderr and .no_stdin will be set.
     +  * value will be zero.
     +  * If it is executable, the hook will be executed and the exit
     +  * status of the hook is returned.
     +- * On execution, .stdout_to_stderr and .no_stdin will be set.
     ++ * On execution, .stdout_to_stderr will be set, and .no_stdin will be
     ++ * set unless RUN_HOOK_ALLOW_STDIN flag is requested.
        */
       LAST_ARG_MUST_BE_NULL
     --int run_hook_le(const char *const *env, const char *name, ...);
     + int run_hook_le(const char *const *env, const char *name, ...);
      -int run_hook_ve(const char *const *env, const char *name, va_list args);
     -+int run_hook_le(const char *const *env, int opt, const char *name, ...);
     -+int run_hook_ve(const char *const *env, int opt, const char *name, va_list args);
     ++int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args);
       
       /*
        * Trigger an auto-gc
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'sample sc
       	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
       	EOF
      +	write_script "$HOOKDIR/user-input.sample" <<-\EOF
     -+	! read -r line || echo "$line" > hook_input
     -+	exit 0
     ++	! read -r line || echo "$line" >hook_input
      +	EOF
       '
       
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'check the
      +test_expect_success 'with user input' '
      +	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
      +	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
     -+	echo "user input" > user_input &&
     ++	echo "user input" >user_input &&
      +	echo "more" >>file &&
      +	git add file &&
     -+	git commit -m "more" < user_input &&
     ++	git commit -m "more" <user_input &&
      +	test_cmp user_input hook_input
      +'
      +
     ++test_expect_failure 'with user input combined with -F -' '
     ++	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
     ++	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
     ++	echo "user input" >user_input &&
     ++	echo "more" >>file &&
     ++	git add file &&
     ++	git commit -F - <user_input &&
     ++	! test_path_is_file hook_input
     ++'
     ++
      +test_expect_success 'post-commit with user input' '
      +	test_when_finished "rm -f \"$POSTCOMMIT\" user_input hook_input" &&
      +	cp "$HOOKDIR/user-input.sample" "$POSTCOMMIT" &&
     -+	echo "user input" > user_input &&
     ++	echo "user input" >user_input &&
      +	echo "more" >>file &&
      +	git add file &&
     -+	git commit -m "more" < user_input &&
     ++	git commit -m "more" <user_input &&
      +	test_cmp user_input hook_input
      +'
      +
      +test_expect_success 'with user input (merge)' '
      +	test_when_finished "rm -f \"$PREMERGE\" user_input hook_input" &&
      +	cp "$HOOKDIR/user-input.sample" "$PREMERGE" &&
     -+	echo "user input" > user_input &&
     ++	echo "user input" >user_input &&
      +	git checkout side &&
     -+	git merge -m "merge master" master < user_input &&
     ++	git merge -m "merge master" master <user_input &&
      +	git checkout master &&
      +	test_cmp user_input hook_input
      +'
     @@ t/t7504-commit-msg-hook.sh: test_expect_success 'hook is called for reword durin
       '
       
      +# now a hook that accepts input and writes it as the commit message
     -+cat > "$HOOK" <<'EOF'
     ++cat >"$HOOK" <<'EOF'
      +#!/bin/sh
     -+! read -r line || echo "$line" > "$1"
     ++! read -r line || echo "$line" >"$1"
      +EOF
      +chmod +x "$HOOK"
      +
      +test_expect_success 'hook with user input' '
      +
     -+	echo "additional" >> file &&
     ++	echo "additional" >>file &&
      +	git add file &&
      +	echo "user input" | git commit -m "additional" &&
      +	commit_msg_is "user input"
     @@ t/t7505-prepare-commit-msg-hook.sh: test_expect_success 'with hook (-m)' '
       
      +test_expect_success 'with hook (-m and input)' '
      +
     -+	echo "more" >> file &&
     ++	echo "more" >>file &&
      +	git add file &&
      +	echo "user input" | git commit -m "more" &&
      +	test "$(git log -1 --pretty=format:%s)" = "message (no editor) user input"
 -:  ---------- > 2:  e048a9db62 commit: fix stdin conflict between message and hook

-- 
gitgitgadget
