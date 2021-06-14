Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECFC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA461245
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhFNKk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:27 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41896 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhFNKhN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:13 -0400
Received: by mail-wr1-f44.google.com with SMTP id o3so13978532wri.8
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8beOkfWpcE16od71qmf64VjLMSAc1uewpLPaCHbK6XM=;
        b=KY/wSR9BKAlOUSEm1byKg2rttqjUYJBANASizLBnt0a7FHpF+Azn2Z285nyzB+Au2h
         /EmyoY1sFxsWq5wHKcvGmFWiyRGA+4vIPS+m10/45HQvXQYV8vmQ1KBp+PXlT55FdyMg
         3nqD2NozKFEv/h2yoMxvXBTteMMYSh0euyQuE/bXAGP/PRhR6pawHeXgpBqBFrdHmQ62
         GKwv3yJ0x20Jvbox5IqfxGx+1IiejkrsjPgdFQuw1+aKVLh1wS1JOF9lY2Q/ONJwIyTm
         HhD4RYNySjGGG2f52kAx6bTBoqmVoilSUTyj+l4KBlf00BOqFk4uXMjY1hGtwNobi/iY
         kVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8beOkfWpcE16od71qmf64VjLMSAc1uewpLPaCHbK6XM=;
        b=n4qla0k91HDF/oH7XuMIPQEVXYXnvDbPAJDlTxIxciJ1LCgEKLKKUZRTT4/r9IRRyf
         wgEFRxoNphmpkXLjfT5jKUwu6Qr8KhvseYK3rKv1mMV/oJDj5jP7yK5TVDWc54kgdmzD
         0YJ/D8b5SJhVuCaorbsVemM7V+AhheO/fmH59hJM3ZoQHZ6JfyoZ6ulr6PdCJlp3wUnt
         2f/wVSRIRzSQXsXuaqb7pHQxD8nIBvroCHR/ZZMeAimvcuLTu5CZUABItuRFBKdf5k2I
         yPsaWGsSA+5c7ZMqiDm3eRV3Hq2GjEpsX3fgYD4y3L1Y1e4DmiJMPypopYXq4ruWhjKC
         3pgw==
X-Gm-Message-State: AOAM532e38QTa7yZmda/qG2HEUMcLYhyRalHRUK2mYkzQZd8qN7Z1TtS
        kozhBM09X7dBYSTbMO/w2HXy5yLiynsm5g==
X-Google-Smtp-Source: ABdhPJyEntn+F+kD6IlojsTEphN9xo/S/SHb9xFGhaUExG2YX7jTSOh/zIW9bOp1t6pGrYBOztc0Pg==
X-Received: by 2002:a05:6000:151:: with SMTP id r17mr17631386wrx.151.1623666849647;
        Mon, 14 Jun 2021 03:34:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 29/30] hooks: fix a TOCTOU in "did we run a hook?" heuristic
Date:   Mon, 14 Jun 2021 12:33:18 +0200
Message-Id: <patch-29.30-793f112f7ab-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
680ee550d72 (commit: skip discarding the index if there is no
pre-commit hook, 2017-08-14).

We can fix the race passing around information about whether or not we
ran the hook in question, instead of running hook_exists() after the
fact to check if the hook in question exists. This problem has been
noted on-list when 680ee550d72 was discussed[1], but had not been
fixed.

In addition to fixing this for the pre-commit hook as suggested there
I'm also fixing this for the pre-merge-commit hook. See
6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
the introduction of its previous behavior.

Let's also change this for the push-to-checkout hook. Now instead of
checking if the hook exists and either doing a push to checkout or a
push to deploy we'll always attempt a push to checkout. If the hook
doesn't exist we'll fall back on push to deploy. The same behavior as
before, without the TOCTOU race. See 0855331941b (receive-pack:
support push-to-checkout hook, 2014-12-01) for the introduction of the
previous behavior.

This leaves uses of hook_exists() in two places that matter. The
"reference-transaction" check in refs.c, see 67541597670 (refs:
implement reference transaction hook, 2020-06-19), and the
prepare-commit-msg hook, see 66618a50f9c (sequencer: run
'prepare-commit-msg' hook, 2018-01-24).

In both of those cases we're saving ourselves CPU time by not
preparing data for the hook that we'll then do nothing with if we
don't have the hook. So using this "invoked_hook" pattern doesn't make
sense in those cases.

More importantly, in those cases the worst we'll do is miss that we
"should" run the hook because a new hook appeared, whereas in the
pre-commit and pre-merge-commit cases we'll skip an important
discard_cache() on the bases of our faulty guess.

I do think none of these races really matter in practice. It would be
some one-off issue as a hook was added or removed. I did think it was
stupid that we didn't pass a "did this run?" flag instead of doing
this guessing at a distance though, so now we're not guessing anymore.

1. https://lore.kernel.org/git/20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 18 +++++++++++-------
 builtin/merge.c        | 16 ++++++++++------
 builtin/receive-pack.c |  8 +++++---
 commit.c               |  1 +
 commit.h               |  3 ++-
 hook.c                 |  4 ++++
 hook.h                 | 10 ++++++++++
 sequencer.c            |  4 ++--
 8 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index dad4e565443..a66727a612a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -725,11 +725,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 	int merge_contains_scissors = 0;
+	int invoked_hook = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hook,
+					  "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -1045,10 +1047,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && hook_exists("pre-commit")) {
+	if (!no_verify && invoked_hook) {
 		/*
-		 * Re-read the index as pre-commit hook could have updated it,
-		 * and write it out as a tree.  We must do this before we invoke
+		 * Re-read the index as the pre-commit-commit hook was invoked
+		 * and could have updated it. We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
 		discard_cache();
@@ -1060,7 +1062,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+	if (run_commit_hook(use_editor, index_file, NULL, "prepare-commit-msg",
 			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
@@ -1077,7 +1079,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
+	    run_commit_hook(use_editor, index_file, NULL, "commit-msg",
+			    git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1830,7 +1833,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), NULL, "post-commit",
+			NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 6128b60942f..0425c9bf2b5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -844,15 +844,18 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
+	int invoked_hook = 0;
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file,
+					  &invoked_hook, "pre-merge-commit",
+					  NULL))
 		abort_commit(remoteheads, NULL);
 	/*
-	 * Re-read the index as pre-merge-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
+	 * Re-read the index as the pre-merge-commit hook was invoked
+	 * and could have updated it. We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (hook_exists("pre-merge-commit"))
+	if (invoked_hook)
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
@@ -873,7 +876,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
+			    "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -882,7 +886,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
-					  "commit-msg",
+					  NULL, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ec90e10477a..cd658f41d58 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1439,10 +1439,12 @@ static const char *push_to_deploy(unsigned char *sha1,
 static const char *push_to_checkout_hook = "push-to-checkout";
 
 static const char *push_to_checkout(unsigned char *hash,
+				    int *invoked_hook,
 				    struct strvec *env,
 				    const char *work_tree)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
@@ -1460,6 +1462,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 {
 	const char *retval, *work_tree, *git_dir = NULL;
 	struct strvec env = STRVEC_INIT;
+	int invoked_hook = 0;
 
 	if (worktree && worktree->path)
 		work_tree = worktree->path;
@@ -1477,10 +1480,9 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!hook_exists(push_to_checkout_hook))
+	retval = push_to_checkout(sha1, &invoked_hook, &env, work_tree);
+	if (!invoked_hook)
 		retval = push_to_deploy(sha1, &env, work_tree);
-	else
-		retval = push_to_checkout(sha1, &env, work_tree);
 
 	strvec_clear(&env);
 	return retval;
diff --git a/commit.c b/commit.c
index e8147a88fc6..cf62ebceae5 100644
--- a/commit.c
+++ b/commit.c
@@ -1697,6 +1697,7 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file,
+		    int *invoked_hook,
 		    const char *name, ...)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
diff --git a/commit.h b/commit.h
index df42eb434f3..b5a542993c6 100644
--- a/commit.h
+++ b/commit.h
@@ -363,7 +363,8 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file,
+		    int *invoked_hook, const char *name, ...);
 
 /* Sign a commit or tag buffer, storing the result in a header. */
 int sign_with_header(struct strbuf *buf, const char *keyid);
diff --git a/hook.c b/hook.c
index 17ae65eca31..3cf51460279 100644
--- a/hook.c
+++ b/hook.c
@@ -138,6 +138,9 @@ static int notify_hook_finished(int result,
 	/* |= rc in cb */
 	hook_cb->rc |= result;
 
+	if (hook_cb->invoked_hook)
+		*hook_cb->invoked_hook = 1;
+
 	return 1;
 }
 
@@ -152,6 +155,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 		.rc = 0,
 		.hook_name = hook_name,
 		.options = options,
+		.invoked_hook = options->invoked_hook,
 	};
 	if (options->absolute_path) {
 		strbuf_add_absolute_path(&abs_path, hook_path);
diff --git a/hook.h b/hook.h
index 5f895032341..9d163e6f992 100644
--- a/hook.h
+++ b/hook.h
@@ -57,6 +57,15 @@ struct run_hooks_opt
 	 * for an example.
 	 */
 	consume_sideband_fn consume_sideband;
+
+	/*
+	 * A pointer which if provided will be set to 1 or 0 depending
+	 * on if a hook was invoked (i.e. existed), regardless of
+	 * whether or not that was successful. Used for avoiding
+	 * TOCTOU races in code that would otherwise call hook_exist()
+	 * after a "maybe hook run" to see if a hook was invoked.
+	 */
+	int *invoked_hook;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -81,6 +90,7 @@ struct hook_cb_data {
 	const char *hook_name;
 	struct hook *run_me;
 	struct run_hooks_opt *options;
+	int *invoked_hook;
 };
 
 /*
diff --git a/sequencer.c b/sequencer.c
index ec2761e47d9..2440b9dccd8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1204,7 +1204,7 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	} else {
 		arg1 = "message";
 	}
-	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+	if (run_commit_hook(0, r->index_file, NULL, "prepare-commit-msg", name,
 			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
 
@@ -1534,7 +1534,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	run_commit_hook(0, r->index_file, "post-commit", NULL);
+	run_commit_hook(0, r->index_file, NULL, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

