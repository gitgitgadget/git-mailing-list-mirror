Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6128C2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3E206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkU/rOaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFQIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34622 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQIj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so8394587wrr.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rDWwEI+LNv9vjMasneiWrih6Zrpg14xC0lNJ4p0LlBg=;
        b=mkU/rOaVWh0uC2yrZdibHz1KKBfMADrP9PWDy2hK723iBV+GLdyerSxOjId8yrx8Ze
         Zx2YYKzzrh2gfoBZr6mkNg0Q5akuGFftmi9m/xpy0afGp0T2BuOKneIs7JWg4Lub2R6Z
         0pqHHshl1upNNAwusUQQDTbEee35L7jOHH3+v/r0KGgvMpksEV9z0B0obzWPgNbnWFX2
         yYcPLmwdKWCsnIa3oX/r8HVpkUlfntU2sQm8roBYzLG9tMBumWKTqWRRJW+WTD6azLtY
         VXiHptVx0QDERVmm4SmOKycbbsxPJhj5yu/gnDY4iRTjKtVnuht2sgm5TW9EDZOmALpX
         IFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rDWwEI+LNv9vjMasneiWrih6Zrpg14xC0lNJ4p0LlBg=;
        b=KZurvHUmjyqI2ZfXTOi1u/h5sTjHb1TXAP1cCv4fn6rJ9/7CwtpEEiRe7fmmQV7ao+
         erIq+0Sa9WRXGG8jEAdpnGpP6lJx9mOT+nGe50meC0YJl0tZhPlBBbSZ/whiPfQt0yGm
         aB/14TdNuZT4s7TfOD757a4LHKlJLilHTlzzSIf+rKLDIPo2f7C4SmxY047AFoWXiT9V
         UDwtcDkfd/3HDOkwP4VAtd4pZP+hZZZiDB+sYpR23vOiyh9o/n2qHAuEzICLFB2RhX9j
         Ic0ny9SuPSlsnjnLe6cKQvQzjG5oKIEfHo9WBH3OU8AMdbCK8zEDXUocJ2Yaxlli2T1S
         a9vw==
X-Gm-Message-State: APjAAAUSbyrWbqxanA/g2GzvQhDIljmDRVsjh4roCf+IBOj5m7ODCg+W
        COHe7GQAjqZmgVoZjqNQmhFvHS8p
X-Google-Smtp-Source: APXvYqz1q9gci5Nhe5dmUpmCpSKgZPASVpcahvTmM6VaQKKWSVTJ0L/QxDjmGD94BEq1G7XtDxrfOw==
X-Received: by 2002:adf:d183:: with SMTP id v3mr16615129wrc.180.1575648516898;
        Fri, 06 Dec 2019 08:08:36 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:36 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 7/9] commit: give correct advice for empty commit during a rebase
Date:   Fri,  6 Dec 2019 16:06:12 +0000
Message-Id: <20191206160614.631724-8-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
`git commit` learned to suggest to run `git cherry-pick --skip` when
trying to cherry-pick an empty patch.

However, it was overlooked that there are more conditions than just a
`git cherry-pick` when this advice is printed (which originally
suggested the neutral `git reset`): the same can happen during a rebase.

Let's suggest the correct command, even during a rebase.

While at it, we adjust more places in `builtin/commit.c` that
incorrectly assumed that the presence of a `CHERRY_PICK_HEAD` meant that
surely this must be a `cherry-pick` in progress.

Note: we take pains to handle the situation when a user runs a `git
cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
line in an interactive rebase). On the other hand, it is not possible to
run a rebase during a cherry-pick, meaning: if both `rebase-merge/` and
`sequencer/` exist or CHERRY_PICK_HEAD and REBASE_HEAD point to the same
commit , we still want to advise to use `git cherry-pick --skip`.

Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c              | 24 ++++++++++++++++-----
 sequencer.c                   | 39 ++++++++++++++++++++++++++++-------
 t/t3403-rebase-skip.sh        | 36 +++++++++++++++++++++++++++-----
 t/t3404-rebase-interactive.sh | 26 +++++++++++++++++++++++
 wt-status.h                   |  8 ++++++-
 5 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d8d4c8e419..c3b6b8a6bd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -59,6 +59,9 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "    git commit --allow-empty\n"
 "\n");
 
+static const char empty_rebase_pick_advice[] =
+N_("Otherwise, please use 'git rebase --skip'\n");
+
 static const char empty_cherry_pick_advice_single[] =
 N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
@@ -449,6 +452,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("cannot do a partial commit during a merge."));
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
+		else if (is_from_rebase(whence))
+			die(_("cannot do a partial commit during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
@@ -765,7 +770,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	else if (whence == FROM_MERGE)
 		hook_arg1 = "merge";
-	else if (is_from_cherry_pick(whence)) {
+	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
 		hook_arg1 = "commit";
 		hook_arg2 = "CHERRY_PICK_HEAD";
 	}
@@ -942,12 +947,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
-		else if (is_from_cherry_pick(whence)) {
+		else if (is_from_cherry_pick(whence) ||
+			 whence == FROM_REBASE_PICK) {
 			fputs(_(empty_cherry_pick_advice), stderr);
 			if (whence == FROM_CHERRY_PICK_SINGLE)
 				fputs(_(empty_cherry_pick_advice_single), stderr);
-			else
+			else if (whence == FROM_CHERRY_PICK_MULTI)
 				fputs(_(empty_cherry_pick_advice_multi), stderr);
+			else
+				fputs(_(empty_rebase_pick_advice), stderr);
 		}
 		return 0;
 	}
@@ -1139,6 +1147,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			die(_("You are in the middle of a merge -- cannot amend."));
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
+		else if (whence == FROM_REBASE_PICK)
+			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
 		die(_("Options --squash and --fixup cannot be used together"));
@@ -1160,7 +1170,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
-	if (!use_message && !is_from_cherry_pick(whence) && renew_authorship)
+	if (!use_message && !is_from_cherry_pick(whence) &&
+	    !is_from_rebase(whence) && renew_authorship)
 		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		use_message_buffer = read_commit_message(use_message);
@@ -1169,7 +1180,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			author_message_buffer = use_message_buffer;
 		}
 	}
-	if (is_from_cherry_pick(whence) && !renew_authorship) {
+	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
+	    !renew_authorship) {
 		author_message = "CHERRY_PICK_HEAD";
 		author_message_buffer = read_commit_message(author_message);
 	}
@@ -1585,6 +1597,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = is_from_cherry_pick(whence)
 					? "commit (cherry-pick)"
+					: is_from_rebase(whence)
+					? "commit (rebase)"
 					: "commit";
 		commit_list_insert(current_head, &parents);
 	}
diff --git a/sequencer.c b/sequencer.c
index 98e007556c..6e153fea76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1430,9 +1430,19 @@ static int try_to_commit(struct repository *r,
 	return res;
 }
 
+static int write_rebase_head(struct object_id *oid)
+{
+	if (update_ref("rebase", "REBASE_HEAD", oid,
+		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+		return error(_("could not update %s"), "REBASE_HEAD");
+
+	return 0;
+}
+
 static int do_commit(struct repository *r,
 		     const char *msg_file, const char *author,
-		     struct replay_opts *opts, unsigned int flags)
+		     struct replay_opts *opts, unsigned int flags,
+		     struct object_id *oid)
 {
 	int res = 1;
 
@@ -1457,8 +1467,12 @@ static int do_commit(struct repository *r,
 			return res;
 		}
 	}
-	if (res == 1)
+	if (res == 1) {
+		if (is_rebase_i(opts) && oid)
+			if (write_rebase_head(oid))
+			    return -1;
 		return run_git_commit(r, msg_file, opts, flags);
+	}
 
 	return res;
 }
@@ -1945,7 +1959,8 @@ static int do_pick_commit(struct repository *r,
 		flags |= ALLOW_EMPTY;
 	if (!opts->no_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
-			res = do_commit(r, msg_file, author, opts, flags);
+			res = do_commit(r, msg_file, author, opts, flags,
+					commit? &commit->object.oid : NULL);
 		else
 			res = error(_("unable to parse commit author"));
 		*check_todo = !!(flags & EDIT_MSG);
@@ -2960,9 +2975,7 @@ static int make_patch(struct repository *r,
 	p = short_commit_name(commit);
 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
-	if (update_ref("rebase", "REBASE_HEAD", &commit->object.oid,
-		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
-		res |= error(_("could not update %s"), "REBASE_HEAD");
+	res |= write_rebase_head(&commit->object.oid);
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
@@ -5260,8 +5273,18 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 {
 	if (file_exists(git_path_cherry_pick_head(r))) {
-		*whence = file_exists(git_path_seq_dir()) ?
-			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
+		struct object_id cherry_pick_head, rebase_head;
+
+		if (file_exists(git_path_seq_dir()))
+			*whence = FROM_CHERRY_PICK_MULTI;
+		if (file_exists(rebase_path()) &&
+		    !get_oid("REBASE_HEAD", &rebase_head) &&
+		    !get_oid("CHERRY_PICK_HEAD", &cherry_pick_head) &&
+		    oideq(&rebase_head, &cherry_pick_head))
+			*whence = FROM_REBASE_PICK;
+		else
+			*whence = FROM_CHERRY_PICK_SINGLE;
+
 		return 1;
 	}
 
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index db7e917248..a927774910 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -97,9 +97,9 @@ test_expect_success 'correct advice upon picking empty commit' '
 	test_must_fail git rebase -i --onto goodbye \
 		amended-goodbye^ amended-goodbye 2>err &&
 	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_i18ngrep "git rebase --skip" err &&
 	test_must_fail git commit &&
-	test_i18ngrep "git cherry-pick --skip" err
+	test_i18ngrep "git rebase --skip" err
 '
 
 test_expect_success 'correct authorship when committing empty pick' '
@@ -120,9 +120,9 @@ test_expect_success 'correct advice upon rewording empty commit' '
 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
 	) &&
 	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_i18ngrep "git rebase --skip" err &&
 	test_must_fail git commit &&
-	test_i18ngrep "git cherry-pick --skip" err
+	test_i18ngrep "git rebase --skip" err
 '
 
 test_expect_success 'correct advice upon editing empty commit' '
@@ -133,8 +133,34 @@ test_expect_success 'correct advice upon editing empty commit' '
 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
 	) &&
 	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_i18ngrep "git rebase --skip" err &&
 	test_must_fail git commit &&
+	test_i18ngrep "git rebase --skip" err
+'
+
+test_expect_success 'correct advice upon cherry-picking an empty commit during a rebase' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 exec_git_cherry-pick_amended-goodbye" \
+			git rebase -i goodbye^ goodbye 2>err
+	) &&
+	test_i18ngrep "previous cherry-pick is now empty" err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
+	test_must_fail git commit 2>err &&
+	test_i18ngrep "git cherry-pick --skip" err
+'
+
+test_expect_success 'correct advice upon multi cherry-pick picking an empty commit during a rebase' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 exec_git_cherry-pick_goodbye_amended-goodbye" \
+			git rebase -i goodbye^^ goodbye 2>err
+	) &&
+	test_i18ngrep "previous cherry-pick is now empty" err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
+	test_must_fail git commit 2>err &&
 	test_i18ngrep "git cherry-pick --skip" err
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d8a05fd439..5afa6f28cd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1602,6 +1602,32 @@ test_expect_success 'post-commit hook is called' '
 	test_cmp expect actual
 '
 
+test_expect_success 'correct error message for partial commit after empty pick' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 1 1" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A D
+	) &&
+	echo x >file1 &&
+	test_must_fail git commit file1 2>err &&
+	test_i18ngrep "cannot do a partial commit during a rebase." err
+'
+
+test_expect_success 'correct error message for commit --amend after empty pick' '
+	test_when_finished "git rebase --abort" &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 1" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A D
+	) &&
+	echo x>file1 &&
+	test_must_fail git commit -a --amend 2>err &&
+	test_i18ngrep "middle of a rebase -- cannot amend." err
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
diff --git a/wt-status.h b/wt-status.h
index 0098fdb0b5..5f81bf7507 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -40,7 +40,8 @@ enum commit_whence {
 	FROM_COMMIT,     /* normal */
 	FROM_MERGE,      /* commit came from merge */
 	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
-	FROM_CHERRY_PICK_MULTI /* commit came from a sequence of cherry-picks */
+	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
+	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
 };
 
 static inline int is_from_cherry_pick(enum commit_whence whence)
@@ -49,6 +50,11 @@ static inline int is_from_cherry_pick(enum commit_whence whence)
 		whence == FROM_CHERRY_PICK_MULTI;
 }
 
+static inline int is_from_rebase(enum commit_whence whence)
+{
+	return whence == FROM_REBASE_PICK;
+}
+
 struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
-- 
2.24.0

