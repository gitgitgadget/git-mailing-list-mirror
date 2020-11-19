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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9AC56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F2122267
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvAPMr5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKSU4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKSU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 15:56:35 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD96C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 1so7962812wme.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=trs7+eBEpCvCkRpvjQL4F0mSwzxMWAVMhgcc1nT6Wsg=;
        b=qvAPMr5AkJYzhdKLLyKj+GQ1l2QdriS3AoS7ssw4GiAyHXduKLvU2RqcGRi5Vr685H
         +zYJKyH3nxKC7XCnfHc022i/PJJWjHYfeo1th89K328ekoqk9yTJJC7BS95Oy91vIEVw
         Op5+GZ8dGuQowJRckCjAtzaVY2ujluWK+uXkXVwmacZlYg3nY89CGiDXpyCcAEsxN3VQ
         16SB7hy96emC9J3coCWIUfq8+RU5hjvkgbdrbxzBRRiInayMmWiIoBDs26VUEKRYShqo
         NsPLl6XQ4mdN70aSjOGo3+X1NuTLtta+LSm+rivOiKHT4NLxpnWHWMTjcGcwXegE7EDP
         wyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=trs7+eBEpCvCkRpvjQL4F0mSwzxMWAVMhgcc1nT6Wsg=;
        b=QA7r4mph/RmNn5kLOnvCoP+cPDtU3JkJ03zpdUYpBS2VqLBqYBfHNMpdHo87IjPmWU
         MlIraHcjIj6k9S+GAubfV/7jn988nhe6RDIhEnpKoYWvAeZMxeiSzTyBvwxierPufUyy
         L4bkUfXD0EZwQ0Tc3i3igFFzo/mz1wo45OFVt4aP7FJfI2uIvjj1BNthQTwBd6B4vtq6
         lrv5AFV97w55A0IVvLxVfdKXEMTx0lZjozRmpDKykNQq1ETCwalYYHibuUSrSowQq9l0
         yfG0sfV34OOKM7zrhY/DzUaRxVNr6vrTT02rsMuSkGXb0JkSgVWR/U7Top1hLZ7/FYKs
         unDA==
X-Gm-Message-State: AOAM5338lFbBDCmlC33iq4hgk0odWAuYDJbUfslbsKiutRJcIFnpaW3x
        xplrb1P93K4rXkMqsq2aw++s9dTXEdo=
X-Google-Smtp-Source: ABdhPJxTvYYj4+wh3o3z3HekzgYgP6Z09T9oeMzUhvDavEHiBTBYw/yFcYv+ue3K5pqn1kqAL4N2Ew==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr6835228wml.56.1605819393565;
        Thu, 19 Nov 2020 12:56:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm1659925wmj.2.2020.11.19.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 12:56:33 -0800 (PST)
Message-Id: <e048a9db62ccd7dd3a0e7a4475d2f8b307785de8.1605819390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
        <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 20:56:30 +0000
Subject: [PATCH v4 2/2] commit: fix stdin conflict between message and hook
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

If git commit is executed with -F - (meaning read the commit message
from stdin), and pre-commit hook is also reading from stdin, the
message itself was consumed by the hook before reaching the point
where it is read for the commit message.

Fix this by detecting this case, and passing this information to
run_commit_hook.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c                                 | 14 +++++++++-----
 builtin/merge.c                                  | 12 ++++++++----
 commit.c                                         |  4 ++--
 commit.h                                         |  3 ++-
 sequencer.c                                      |  6 +++---
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh |  2 +-
 6 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..074a57937f 100644
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
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
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
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1015,7 +1018,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, RUN_HOOK_ALLOW_STDIN, "commit-msg",
+			    git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1701,7 +1705,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 4c133402a6..550b38cd20 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -822,8 +822,11 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify &&
+	    run_commit_hook(0 < option_edit, index_file, RUN_HOOK_ALLOW_STDIN,
+			    "pre-merge-commit", NULL)) {
 		abort_commit(remoteheads, NULL);
+	}
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
 	 * and write it out as a tree.  We must do this before we invoke
@@ -850,8 +853,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
-			    git_path_merge_msg(the_repository), "merge", NULL))
+	if (run_commit_hook(0 < option_edit, get_index_file(), RUN_HOOK_ALLOW_STDIN,
+			    "prepare-commit-msg", git_path_merge_msg(the_repository),
+			    "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
@@ -859,7 +863,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
+					  RUN_HOOK_ALLOW_STDIN, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
diff --git a/commit.c b/commit.c
index 775019ec9d..3f5a50164e 100644
--- a/commit.c
+++ b/commit.c
@@ -1631,7 +1631,7 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file,
-		    const char *name, ...)
+		    unsigned flags, const char *name, ...)
 {
 	struct strvec hook_env = STRVEC_INIT;
 	va_list args;
@@ -1646,7 +1646,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, RUN_HOOK_ALLOW_STDIN, name, args);
+	ret = run_hook_ve(hook_env.v, flags, name, args);
 	va_end(args);
 	strvec_clear(&hook_env);
 
diff --git a/commit.h b/commit.h
index 5467786c7b..72215d57fb 100644
--- a/commit.h
+++ b/commit.h
@@ -352,6 +352,7 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file, unsigned flags,
+		    const char *name, ...);
 
 #endif /* COMMIT_H */
diff --git a/sequencer.c b/sequencer.c
index 684ea9d5ce..505101c29c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1171,8 +1171,8 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
-			    arg1, arg2, NULL))
+	if (run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN,
+			    "prepare-commit-msg", name, arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
 	return ret;
@@ -1496,7 +1496,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, r->index_file, RUN_HOOK_ALLOW_STDIN, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 7bfb7435c6..a243b7efa1 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -292,7 +292,7 @@ test_expect_success 'with user input' '
 	test_cmp user_input hook_input
 '
 
-test_expect_failure 'with user input combined with -F -' '
+test_expect_success 'with user input combined with -F -' '
 	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
 	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
 	echo "user input" >user_input &&
-- 
gitgitgadget
