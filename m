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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B1C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1EA23C19
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgLIUHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLIUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:07:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE6C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:06:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so3097149wrj.7
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OvSQAr+ATrO1jOrg50o0diY35uya6Y1TWueL2f6EK7w=;
        b=AOQL3VGlvUvpe4jh1wjTPbXA95TggfcOOxKVBTLynUNjeBa9jMsVtXr6ekIdGRV2RH
         u39otS3U+Sze5OQMDqXvuRVhbABYl75bhY3sQ+pd0rbsziT/LVGR5GAhVwG7N+ZT7O3n
         5635jQMqgeaLmmussGKoGFrT8MRNPKL5dKTFUqILB8RqV/ip/qlszMnIN8gfTbxsrhUr
         /MfjoydA/e9cR0QB0c/q+C+Uvb2SF82KnmH5n5y6RtWRLbaAG93ceuVcn8XjnAQdHeEv
         68ib+FpN3CtSb8yENBI9QyXa7lKxdiyUn7YpKCa/b82iYOAOf9olcZqYN/Rcwjzk8QY8
         8U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OvSQAr+ATrO1jOrg50o0diY35uya6Y1TWueL2f6EK7w=;
        b=lxzC4q2N/2zdR9Aee1sNkSvzY4YtyixnPX3nf5tJx0+9HtdHL7MCSokaO7Hw5PDbYR
         dqVf+kL+z128ANZRS4K5qp/Zoo/jimEsuNAGeud/dQ8jrZ8W31JJiGE3MIzBi2Cg7G0I
         4CMUgTfqrzJq8sH6vFQZxxQK6JadPIJde6xWp7/55upPecrlpWZw7SOl1eajfraW4gcJ
         ROYCZTI+wm/J191UX6IdA3yTCzCLcLitBsCbNVDmzDzEKA+pHQ+oTQxbHR9I5jclLEeR
         vXsA+GhdyCeIlGWxxmWJl8dprMny4gKoJHEtvXTVfPkoLVQQ+JX/8QW0yyDHkhJC5qg5
         dPuw==
X-Gm-Message-State: AOAM532bO9Gqy4r5CRCtndei9EiPmPrlxqIIqnKq+r4hv7yb/wJXPYJO
        1KJNnmHsfjUWeilnF1Szh1mfsJd4Z60=
X-Google-Smtp-Source: ABdhPJyVvLBomohCay3mXmxwCn93ANZhHK9vagMROYHm1BaLGsRBbiT47cafdUFyeJ57mNa9lXfNGw==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr4510935wru.174.1607544409916;
        Wed, 09 Dec 2020 12:06:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm5208014wme.4.2020.12.09.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:06:49 -0800 (PST)
Message-Id: <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
References: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 20:06:46 +0000
Subject: [PATCH v5 0/2] hooks: allow input from stdin for commit-related hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Orgad Shaneh <orgads@gmail.com>
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
https://stackoverflow.com/q/1067874/764870 [2]
https://stackoverflow.com/q/47477766/764870 [3]
https://stackoverflow.com/q/3417896/764870 [4]
https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165 [5]
https://github.com/typicode/husky/issues/442

Orgad Shaneh (2):
  hooks: lay foundations for passing stdin to hooks
  hooks: allow input from stdin for commit-related hooks

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


base-commit: 3cf59784d42c4152a0b3de7bb7a75d0071e5f878
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-790%2Forgads%2Fhooks-stdin-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-790/orgads/hooks-stdin-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/790

Range-diff vs v4:

 2:  e048a9db62c ! 1:  27e66d43c83 commit: fix stdin conflict between message and hook
     @@ Metadata
      Author: Orgad Shaneh <orgads@gmail.com>
      
       ## Commit message ##
     -    commit: fix stdin conflict between message and hook
     +    hooks: lay foundations for passing stdin to hooks
      
     -    If git commit is executed with -F - (meaning read the commit message
     -    from stdin), and pre-commit hook is also reading from stdin, the
     -    message itself was consumed by the hook before reaching the point
     -    where it is read for the commit message.
     -
     -    Fix this by detecting this case, and passing this information to
     -    run_commit_hook.
     +    Used in the follow-up commit for enabling stdin for commit-related
     +    hooks.
      
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
     - 	int old_display_comment_prefix;
     - 	int merge_contains_scissors = 0;
     -+	int message_from_stdin = logfile && !strcmp(logfile, "-");
     -+	const unsigned hook_flags = message_from_stdin ? 0 : RUN_HOOK_ALLOW_STDIN;
     - 
       	/* This checks and barfs if author is badly specified */
       	determine_author_info(author_ident);
       
      -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
     -+	if (!no_verify &&
     -+	    run_commit_hook(use_editor, index_file, hook_flags, "pre-commit", NULL))
     ++	if (!no_verify && run_commit_hook(use_editor, index_file, 0, "pre-commit", NULL))
       		return 0;
       
       	if (squash_message) {
     -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 	if (have_option_m && !fixup_message) {
     - 		strbuf_addbuf(&sb, &message);
     - 		hook_arg1 = "message";
     --	} else if (logfile && !strcmp(logfile, "-")) {
     -+	} else if (message_from_stdin) {
     - 		if (isatty(0))
     - 			fprintf(stderr, _("(reading log message from standard input)\n"));
     - 		if (strbuf_read(&sb, 0, 0) < 0)
      @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
       		return 0;
       	}
       
      -	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
     -+	if (run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "prepare-commit-msg",
     ++	if (run_commit_hook(use_editor, index_file, 0, "prepare-commit-msg",
       			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
       		return 0;
       
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       
       	if (!no_verify &&
      -	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
     -+	    run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "commit-msg",
     -+			    git_path_commit_editmsg(), NULL)) {
     ++	    run_commit_hook(use_editor, index_file, 0, "commit-msg", git_path_commit_editmsg(), NULL)) {
       		return 0;
       	}
       
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
       	repo_rerere(the_repository, 0);
       	run_auto_maintenance(quiet);
      -	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
     -+	run_commit_hook(use_editor, get_index_file(), RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
     ++	run_commit_hook(use_editor, get_index_file(), 0, "post-commit", NULL);
       	if (amend && !no_post_rewrite) {
       		commit_post_rewrite(the_repository, current_head, &oid);
       	}
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
       	const char *index_file = get_index_file();
       
      -	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
     -+	if (!no_verify &&
     -+	    run_commit_hook(0 < option_edit, index_file, RUN_HOOK_ALLOW_STDIN,
     -+			    "pre-merge-commit", NULL)) {
     ++	if (!no_verify && run_commit_hook(0 < option_edit, index_file, 0, "pre-merge-commit", NULL))
       		abort_commit(remoteheads, NULL);
     -+	}
       	/*
       	 * Re-read the index as pre-merge-commit hook could have updated it,
     - 	 * and write it out as a tree.  We must do this before we invoke
      @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
       		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
       	write_merge_heads(remoteheads);
       	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
      -	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
     --			    git_path_merge_msg(the_repository), "merge", NULL))
     -+	if (run_commit_hook(0 < option_edit, get_index_file(), RUN_HOOK_ALLOW_STDIN,
     -+			    "prepare-commit-msg", git_path_merge_msg(the_repository),
     -+			    "merge", NULL))
     ++	if (run_commit_hook(0 < option_edit, get_index_file(), 0, "prepare-commit-msg",
     + 			    git_path_merge_msg(the_repository), "merge", NULL))
       		abort_commit(remoteheads, NULL);
       	if (0 < option_edit) {
     - 		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
      @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
       	}
       
       	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
      -					  "commit-msg",
     -+					  RUN_HOOK_ALLOW_STDIN, "commit-msg",
     ++					  0, "commit-msg",
       					  git_path_merge_msg(the_repository), NULL))
       		abort_commit(remoteheads, NULL);
       
     @@ commit.c: int run_commit_hook(int editor_is_used, const char *index_file,
       		strvec_push(&hook_env, "GIT_EDITOR=:");
       
       	va_start(args, name);
     --	ret = run_hook_ve(hook_env.v, RUN_HOOK_ALLOW_STDIN, name, args);
     +-	ret = run_hook_ve(hook_env.v, name, args);
      +	ret = run_hook_ve(hook_env.v, flags, name, args);
       	va_end(args);
       	strvec_clear(&hook_env);
     @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, voi
       
       #endif /* COMMIT_H */
      
     + ## run-command.c ##
     +@@ run-command.c: const char *find_hook(const char *name)
     + 	return path.buf;
     + }
     + 
     +-int run_hook_ve(const char *const *env, const char *name, va_list args)
     ++int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args)
     + {
     + 	struct child_process hook = CHILD_PROCESS_INIT;
     + 	const char *p;
     +@@ run-command.c: int run_hook_ve(const char *const *env, const char *name, va_list args)
     + 	while ((p = va_arg(args, const char *)))
     + 		strvec_push(&hook.args, p);
     + 	hook.env = env;
     +-	hook.no_stdin = 1;
     ++	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);
     + 	hook.stdout_to_stderr = 1;
     + 	hook.trace2_hook_name = name;
     + 
     +@@ run-command.c: int run_hook_le(const char *const *env, const char *name, ...)
     + 	int ret;
     + 
     + 	va_start(args, name);
     +-	ret = run_hook_ve(env, name, args);
     ++	ret = run_hook_ve(env, 0, name, args);
     + 	va_end(args);
     + 
     + 	return ret;
     +
     + ## run-command.h ##
     +@@ run-command.h: int run_command(struct child_process *);
     +  */
     + const char *find_hook(const char *name);
     + 
     ++#define RUN_HOOK_ALLOW_STDIN 1
     ++
     + /**
     +  * Run a hook.
     +- * The first argument is a pathname to an index file, or NULL
     +- * if the hook uses the default index file or no index is needed.
     +- * The second argument is the name of the hook.
     ++ * The env argument is an array of environment variables, or NULL
     ++ * if the hook uses the default environment and doesn't require
     ++ * additional variables.
     ++ * The flags argument is an OR'ed collection of feature bits like
     ++ * RUN_HOOK_ALLOW_STDIN defined above, which enables
     ++ * stdin for the child process (the default is no_stdin).
     ++ * The name argument is the name of the hook.
     +  * The further arguments correspond to the hook arguments.
     +  * The last argument has to be NULL to terminate the arguments list.
     +  * If the hook does not exist or is not executable, the return
     +  * value will be zero.
     +  * If it is executable, the hook will be executed and the exit
     +  * status of the hook is returned.
     +- * On execution, .stdout_to_stderr and .no_stdin will be set.
     ++ * On execution, .stdout_to_stderr will be set, and .no_stdin will be
     ++ * set unless RUN_HOOK_ALLOW_STDIN flag is requested.
     +  */
     + LAST_ARG_MUST_BE_NULL
     + int run_hook_le(const char *const *env, const char *name, ...);
     +-int run_hook_ve(const char *const *env, const char *name, va_list args);
     ++int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args);
     + 
     + /*
     +  * Trigger an auto-gc
     +
       ## sequencer.c ##
      @@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
       	} else {
       		arg1 = "message";
       	}
      -	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
     --			    arg1, arg2, NULL))
     -+	if (run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN,
     -+			    "prepare-commit-msg", name, arg1, arg2, NULL))
     ++	if (run_commit_hook(0, r->index_file, 0, "prepare-commit-msg", name,
     + 			    arg1, arg2, NULL))
       		ret = error(_("'prepare-commit-msg' hook failed"));
       
     - 	return ret;
      @@ sequencer.c: static int try_to_commit(struct repository *r,
       		goto out;
       	}
       
      -	run_commit_hook(0, r->index_file, "post-commit", NULL);
     -+	run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
     ++	run_commit_hook(0, r->index_file, 0, "post-commit", NULL);
       	if (flags & AMEND_MSG)
       		commit_post_rewrite(r, current_head, oid);
       
     -
     - ## t/t7503-pre-commit-and-pre-merge-commit-hooks.sh ##
     -@@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with user input' '
     - 	test_cmp user_input hook_input
     - '
     - 
     --test_expect_failure 'with user input combined with -F -' '
     -+test_expect_success 'with user input combined with -F -' '
     - 	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
     - 	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
     - 	echo "user input" >user_input &&
 1:  3bd6024a236 ! 2:  25db4da3cd5 hooks: allow input from stdin for commit-related hooks
     @@ Commit message
      
          Let hooks receive user input if applicable.
      
     -    Closing stdin originates in f5bbc3225 (Port git commit to C,
     -    2007). Looks like the original shell implementation did have
     -    stdin open.
     +    Closing stdin originates in f5bbc3225 (Port git commit to C, 2007).
     +    Looks like the original shell implementation did have stdin open.
      
     -    This allows for example prompting the user to choose an issue
     -    in prepare-commit-msg, and add "Fixes #123" to the commit message.
     +    Due to stdin being closed, hooks that require user input have to either
     +    read the input directly from the console (which can't work when running
     +    from GUI applications), or popup a GUI dialog (which is inconvenient
     +    when running from the terminal).
      
     -    Another possible use-case is running sanity test on pre-commit,
     -    and having a prompt like "This and that issue were found in your
     -    changes. Are you sure you want to commit? [Y/N]".
     +    This allows for example prompting the user to choose an issue in
     +    prepare-commit-msg, and add "Fixes #123" to the commit message.
      
     -    Allow stdin only for commit-related hooks. Some of the other
     -    hooks pass their own input to the hook, so don't change them.
     +    Another possible use-case is running sanity test on pre-commit, and
     +    having a prompt like "This and that issue were found in your changes.
     +    Are you sure you want to commit? [Y/N]".
      
     -    Note: If pre-commit reads from stdin, and git commit is executed
     -    with -F - (read message from stdin), the message is not read
     -    correctly. This is fixed in the follow-up commit.
     +    It's important to note that the hook author should be aware that stdin
     +    is not always applicable. For example, when running from IDE. This can
     +    be checked by isatty on stdin. The hooks should handle cases of closed
     +    input, and possibly fall-back to GUI input, or have sane defaults with
     +    a message to the user on this case.
     +
     +    Allow stdin only for commit-related hooks. Some of the other hooks pass
     +    their own input to the hook, so don't change them.
     +
     +    Note: If pre-commit reads from stdin, and git commit is executed with
     +    -F - (read message from stdin), stdin cannot be passed to the hook,
     +    since it will consume it before reaching the point where it is read for
     +    the commit message.
      
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
     - ## commit.c ##
     -@@ commit.c: int run_commit_hook(int editor_is_used, const char *index_file,
     - 		strvec_push(&hook_env, "GIT_EDITOR=:");
     - 
     - 	va_start(args, name);
     --	ret = run_hook_ve(hook_env.v, name, args);
     -+	ret = run_hook_ve(hook_env.v, RUN_HOOK_ALLOW_STDIN, name, args);
     - 	va_end(args);
     - 	strvec_clear(&hook_env);
     - 
     -
     - ## run-command.c ##
     -@@ run-command.c: const char *find_hook(const char *name)
     - 	return path.buf;
     - }
     - 
     --int run_hook_ve(const char *const *env, const char *name, va_list args)
     -+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args)
     - {
     - 	struct child_process hook = CHILD_PROCESS_INIT;
     - 	const char *p;
     -@@ run-command.c: int run_hook_ve(const char *const *env, const char *name, va_list args)
     - 	while ((p = va_arg(args, const char *)))
     - 		strvec_push(&hook.args, p);
     - 	hook.env = env;
     --	hook.no_stdin = 1;
     -+	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);
     - 	hook.stdout_to_stderr = 1;
     - 	hook.trace2_hook_name = name;
     - 
     -@@ run-command.c: int run_hook_le(const char *const *env, const char *name, ...)
     - 	int ret;
     - 
     - 	va_start(args, name);
     --	ret = run_hook_ve(env, name, args);
     -+	ret = run_hook_ve(env, 0, name, args);
     - 	va_end(args);
     + ## builtin/commit.c ##
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
     + 	int old_display_comment_prefix;
     + 	int merge_contains_scissors = 0;
     ++	int message_from_stdin = logfile && !strcmp(logfile, "-");
     ++	const unsigned hook_flags = message_from_stdin ? 0 : RUN_HOOK_ALLOW_STDIN;
       
     - 	return ret;
     + 	/* This checks and barfs if author is badly specified */
     + 	determine_author_info(author_ident);
     + 
     +-	if (!no_verify && run_commit_hook(use_editor, index_file, 0, "pre-commit", NULL))
     ++	if (!no_verify &&
     ++	    run_commit_hook(use_editor, index_file, hook_flags, "pre-commit", NULL))
     + 		return 0;
     + 
     + 	if (squash_message) {
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 	if (have_option_m && !fixup_message) {
     + 		strbuf_addbuf(&sb, &message);
     + 		hook_arg1 = "message";
     +-	} else if (logfile && !strcmp(logfile, "-")) {
     ++	} else if (message_from_stdin) {
     + 		if (isatty(0))
     + 			fprintf(stderr, _("(reading log message from standard input)\n"));
     + 		if (strbuf_read(&sb, 0, 0) < 0)
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 		return 0;
     + 	}
     + 
     +-	if (run_commit_hook(use_editor, index_file, 0, "prepare-commit-msg",
     ++	if (run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "prepare-commit-msg",
     + 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
     + 		return 0;
     + 
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 	}
     + 
     + 	if (!no_verify &&
     +-	    run_commit_hook(use_editor, index_file, 0, "commit-msg", git_path_commit_editmsg(), NULL)) {
     ++	    run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "commit-msg",
     ++			    git_path_commit_editmsg(), NULL)) {
     + 		return 0;
     + 	}
     + 
     +@@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
     + 
     + 	repo_rerere(the_repository, 0);
     + 	run_auto_maintenance(quiet);
     +-	run_commit_hook(use_editor, get_index_file(), 0, "post-commit", NULL);
     ++	run_commit_hook(use_editor, get_index_file(), RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
     + 	if (amend && !no_post_rewrite) {
     + 		commit_post_rewrite(the_repository, current_head, &oid);
     + 	}
      
     - ## run-command.h ##
     -@@ run-command.h: int run_command(struct child_process *);
     -  */
     - const char *find_hook(const char *name);
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
     + 	struct strbuf msg = STRBUF_INIT;
     + 	const char *index_file = get_index_file();
     + 
     +-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, 0, "pre-merge-commit", NULL))
     ++	if (!no_verify &&
     ++	    run_commit_hook(0 < option_edit, index_file, RUN_HOOK_ALLOW_STDIN,
     ++			    "pre-merge-commit", NULL)) {
     + 		abort_commit(remoteheads, NULL);
     ++	}
     + 	/*
     + 	 * Re-read the index as pre-merge-commit hook could have updated it,
     + 	 * and write it out as a tree.  We must do this before we invoke
     +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
     + 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
     + 	write_merge_heads(remoteheads);
     + 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
     +-	if (run_commit_hook(0 < option_edit, get_index_file(), 0, "prepare-commit-msg",
     +-			    git_path_merge_msg(the_repository), "merge", NULL))
     ++	if (run_commit_hook(0 < option_edit, get_index_file(), RUN_HOOK_ALLOW_STDIN,
     ++			    "prepare-commit-msg", git_path_merge_msg(the_repository),
     ++			    "merge", NULL))
     + 		abort_commit(remoteheads, NULL);
     + 	if (0 < option_edit) {
     + 		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
     +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
     + 	}
     + 
     + 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
     +-					  0, "commit-msg",
     ++					  RUN_HOOK_ALLOW_STDIN, "commit-msg",
     + 					  git_path_merge_msg(the_repository), NULL))
     + 		abort_commit(remoteheads, NULL);
     + 
     +
     + ## sequencer.c ##
     +@@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
     + 	} else {
     + 		arg1 = "message";
     + 	}
     +-	if (run_commit_hook(0, r->index_file, 0, "prepare-commit-msg", name,
     +-			    arg1, arg2, NULL))
     ++	if (run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN,
     ++			    "prepare-commit-msg", name, arg1, arg2, NULL))
     + 		ret = error(_("'prepare-commit-msg' hook failed"));
     + 
     + 	return ret;
     +@@ sequencer.c: static int try_to_commit(struct repository *r,
     + 		goto out;
     + 	}
     + 
     +-	run_commit_hook(0, r->index_file, 0, "post-commit", NULL);
     ++	run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
     + 	if (flags & AMEND_MSG)
     + 		commit_post_rewrite(r, current_head, oid);
       
     -+#define RUN_HOOK_ALLOW_STDIN 1
     -+
     - /**
     -  * Run a hook.
     -- * The first argument is a pathname to an index file, or NULL
     -- * if the hook uses the default index file or no index is needed.
     -- * The second argument is the name of the hook.
     -+ * The env argument is an array of environment variables, or NULL
     -+ * if the hook uses the default environment and doesn't require
     -+ * additional variables.
     -+ * The flags argument is an OR'ed collection of feature bits like
     -+ * RUN_HOOK_ALLOW_STDIN defined above, which enables
     -+ * stdin for the child process (the default is no_stdin).
     -+ * The name argument is the name of the hook.
     -  * The further arguments correspond to the hook arguments.
     -  * The last argument has to be NULL to terminate the arguments list.
     -  * If the hook does not exist or is not executable, the return
     -  * value will be zero.
     -  * If it is executable, the hook will be executed and the exit
     -  * status of the hook is returned.
     -- * On execution, .stdout_to_stderr and .no_stdin will be set.
     -+ * On execution, .stdout_to_stderr will be set, and .no_stdin will be
     -+ * set unless RUN_HOOK_ALLOW_STDIN flag is requested.
     -  */
     - LAST_ARG_MUST_BE_NULL
     - int run_hook_le(const char *const *env, const char *name, ...);
     --int run_hook_ve(const char *const *env, const char *name, va_list args);
     -+int run_hook_ve(const char *const *env, unsigned flags, const char *name, va_list args);
     - 
     - /*
     -  * Trigger an auto-gc
      
       ## t/t7503-pre-commit-and-pre-merge-commit-hooks.sh ##
      @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_description='pre-commit and pre-merge-commit hooks'
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'check the
      +	test_cmp user_input hook_input
      +'
      +
     -+test_expect_failure 'with user input combined with -F -' '
     ++test_expect_success 'with user input combined with -F -' '
      +	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
      +	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
      +	echo "user input" >user_input &&

-- 
gitgitgadget
