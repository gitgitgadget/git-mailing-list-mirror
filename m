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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C238C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A46723A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgLIUHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbgLIUHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:07:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25189C061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:06:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so3100425wrc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FmgNRbyjUoRS4/6Ti3xTllFp9JJ7Tn2iIHP8SrSOZxs=;
        b=aiNiGm1aiFJnpEE0RhMLUWPJiAgubbt916kDY2NvUmCUfN5ey7DZh+dRgzDIKIorBt
         MAuqnYGpAlQpZr1a4asP2fPqE/R82jNF9GFcMBUCraStDkt2IMqLQl+wWh6BjM11zq+J
         FsFOpBnfAQGWhQh7XGYtGLtONZkkkFpR7TbCKXy1HFJZZLyDZ6OCE8GX6+vClD/MpWcq
         vQ0YYeQ/6gO8eoSCcZCHlTSlQfryL2qcw8fZY2FxjzJ0Z0KWpeTlzWxrpgBBt2nWVCIJ
         CJrzEuTFX596ndzCq6lZd1JX5V32KPrwqMT/4DH4S6JMjU1Lgfadr5ojCbutdIY4BqEY
         h4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FmgNRbyjUoRS4/6Ti3xTllFp9JJ7Tn2iIHP8SrSOZxs=;
        b=mQ0d/zUjQMVwpicwcUQT171h75XJLa+W70YqdM6kcQFOqWK7GChqn6EhxVjynl4/+K
         z1InAQHvBW8s8xv5H1MDs4sSHpkTsxwTRdlMmSYz/PPfj1kJRQVoULCaJNFBBHqE0YMU
         vWrBenws/s/c/LdoTd30s2x9PPO4bjdjyWzNDbIgWlsnGmwUksOkq1R1bV6lJ5P2KMLK
         dU5xhsd1z/T77gghmj0/2AOImVh0tRc8sTIIcpJdOLYQlI/d9lnWt7oYiLKHTejI6TXQ
         0mO02WnF/OK3dboZ0Uuz6SSfKPWJBUWK2H3TBOAPPlUZ3TsI/B1S5gzg23uLXai0/KrJ
         PK/A==
X-Gm-Message-State: AOAM5303r/CjCXIerPY3LJPSP14o4JyHIDTihvzNlmb4Q+PQGsF8qRI/
        XcPwMxAQ23EPNk/VX1VzL9K05YMymVI=
X-Google-Smtp-Source: ABdhPJwXtMZH7Wt8WxneyNCm5dAtBMq9Ae8/DTJeprzNRHpoT9UtlDdNmlPG5Ope+qrA+96G3nLe8Q==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr4433102wrx.7.1607544411537;
        Wed, 09 Dec 2020 12:06:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h184sm5987371wmh.23.2020.12.09.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:06:50 -0800 (PST)
Message-Id: <25db4da3cd5fc7e81141078261086c392541c5d1.1607544408.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
References: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
        <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 20:06:48 +0000
Subject: [PATCH v5 2/2] hooks: allow input from stdin for commit-related hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Let hooks receive user input if applicable.

Closing stdin originates in f5bbc3225 (Port git commit to C, 2007).
Looks like the original shell implementation did have stdin open.

Due to stdin being closed, hooks that require user input have to either
read the input directly from the console (which can't work when running
from GUI applications), or popup a GUI dialog (which is inconvenient
when running from the terminal).

This allows for example prompting the user to choose an issue in
prepare-commit-msg, and add "Fixes #123" to the commit message.

Another possible use-case is running sanity test on pre-commit, and
having a prompt like "This and that issue were found in your changes.
Are you sure you want to commit? [Y/N]".

It's important to note that the hook author should be aware that stdin
is not always applicable. For example, when running from IDE. This can
be checked by isatty on stdin. The hooks should handle cases of closed
input, and possibly fall-back to GUI input, or have sane defaults with
a message to the user on this case.

Allow stdin only for commit-related hooks. Some of the other hooks pass
their own input to the hook, so don't change them.

Note: If pre-commit reads from stdin, and git commit is executed with
-F - (read message from stdin), stdin cannot be passed to the hook,
since it will consume it before reaching the point where it is read for
the commit message.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c                              | 14 ++++--
 builtin/merge.c                               | 12 +++--
 sequencer.c                                   |  6 +--
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 46 ++++++++++++++++++-
 t/t7504-commit-msg-hook.sh                    | 15 ++++++
 t/t7505-prepare-commit-msg-hook.sh            | 14 ++++++
 6 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 70a7842e224..074a57937f1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -695,11 +695,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 	int merge_contains_scissors = 0;
+	int message_from_stdin = logfile && !strcmp(logfile, "-");
+	const unsigned hook_flags = message_from_stdin ? 0 : RUN_HOOK_ALLOW_STDIN;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, 0, "pre-commit", NULL))
+	if (!no_verify &&
+	    run_commit_hook(use_editor, index_file, hook_flags, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -724,7 +727,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (have_option_m && !fixup_message) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
-	} else if (logfile && !strcmp(logfile, "-")) {
+	} else if (message_from_stdin) {
 		if (isatty(0))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
@@ -998,7 +1001,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, 0, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1015,7 +1018,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, 0, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "commit-msg",
+			    git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1701,7 +1705,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), 0, "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 26e6ae15993..d6faca59258 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -836,8 +836,11 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, 0, "pre-merge-commit", NULL))
+	if (!no_verify &&
+	    run_commit_hook(0 < option_edit, index_file, RUN_HOOK_ALLOW_STDIN,
+			    "pre-merge-commit", NULL)) {
 		abort_commit(remoteheads, NULL);
+	}
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
 	 * and write it out as a tree.  We must do this before we invoke
@@ -864,8 +867,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), 0, "prepare-commit-msg",
-			    git_path_merge_msg(the_repository), "merge", NULL))
+	if (run_commit_hook(0 < option_edit, get_index_file(), RUN_HOOK_ALLOW_STDIN,
+			    "prepare-commit-msg", git_path_merge_msg(the_repository),
+			    "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
@@ -873,7 +877,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  0, "commit-msg",
+					  RUN_HOOK_ALLOW_STDIN, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
diff --git a/sequencer.c b/sequencer.c
index 5f48d32e2fa..5190879695a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1203,8 +1203,8 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, 0, "prepare-commit-msg", name,
-			    arg1, arg2, NULL))
+	if (run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN,
+			    "prepare-commit-msg", name, arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
 	return ret;
@@ -1528,7 +1528,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, 0, "post-commit", NULL);
+	run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a20..a243b7efa19 100755
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
+test_expect_success 'with user input combined with -F -' '
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
index 31b9c6a2c1d..aa76eb7e1f9 100755
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
index 94f85cdf831..aa9c9375e63 100755
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
