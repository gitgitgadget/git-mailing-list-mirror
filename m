Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0A9C2D0C1
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B90206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCEYzOdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFQIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34610 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfLFQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so8394150wrr.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=WR9v7uUMGbZKC0pqPNgbuLUcOcDKJoZhbIRLyauyNFg=;
        b=MCEYzOdWr6Uqd/OGaEcuPl+0GdnH4SDMFoZO+XApuYV9QDbUNdueTqPAhgPhKBn8ff
         IhH39TofCWk2jncdl0trATCSExl9+azmHgxLWtPlYNNMkIwF/f1fKXcYJOgeNZagPWFU
         h8pXU3blgrFycW9UKi3armohfpDXSKJpJdChHlMMQg8EGyyvbjHMnNxt4fRd4390UVy7
         yHdM8XPhL0wdyZwolV6RxxvMJZBeSU4ZP0NV+oedJfofVurm6SNOeH8oVFmklhHwAkBZ
         Q88DG/edyNvgmJv3MVU9hk4wg52277Cm/CMHdsG0CdHW2VSsgcip3VAJDBAK3ZvCjyTW
         e7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=WR9v7uUMGbZKC0pqPNgbuLUcOcDKJoZhbIRLyauyNFg=;
        b=nDEKRKNBRKeeBQjTeptQn/GsQ3iiOZDH7sXwchf6vAgA/Xr8K22I3J3uzUKseQOAz/
         L31xWvefdbypUtb0dkzmXV80/JTRal8DgO/LxpfsHdXf8o4fnhIwp2aMs/H61SiyxXI6
         b0Oyat9Ce61DRvYa6eKWlFJfOAdZ+getWviWiHVAK8bCJHGxKJ4H9Ws1kox0pfoj/JCg
         nX6ybMDA1Pl1bWJ++JQuefD9YwYfCCCBzOFUNsQ9nvzWTKZ774k3VOwD2WwrwjgHy9Jz
         QU2M6NoWys78ROX24k23+Dyo1VpQPyFnfYPN9UgDRTB+9i2WhZtrVJaUDTTFc/1nDJSC
         pDeA==
X-Gm-Message-State: APjAAAUG5EeUKTuD6zaRApuKCzm5p90358U01EBSspseTpI5OTWn/EQY
        xhelCUcVRZpq2hIzCpr3fna5vuGE
X-Google-Smtp-Source: APXvYqzQM0XPjdcOEWNm4K7+XM0vvPBlOxS0zMH6Wx5OKBKyy1/ndXIIP3Vh3Atkh/z9qqv1QTt/qg==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr15904359wrx.44.1575648509962;
        Fri, 06 Dec 2019 08:08:29 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/9] commit: fix advice for empty commits during rebases
Date:   Fri,  6 Dec 2019 16:06:05 +0000
Message-Id: <20191206160614.631724-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <pull.417.git.1571787022.gitgitgadget@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've added some more commits to improve the test coverage and handle
edit & reword as well as pick commands. I've also changed the advice
printed by an empty cherry-pick performed during a rebase to be the
same whether it is part of a sequence of cherry-picks or just a single
pick.

There are a couple of RFC patches at the end that change the advice
for fixups that empty HEAD and change the handling of CHERRY_PICK_HEAD
so if a user commits a conflict resolution the authorship is
preserved. They can be split into a separate series if necessary to
avoid holding up the earlier patches.

The first patch is a general cleanup, not really related to the rest
of the series

These patches are based on a merge of ra/cherry-pick-revert-skip and
pw/sequencer-compare-with-right-parent-to-check-empty-commits


Johannes Schindelin (1):
  cherry-pick: add test for `--skip` advice in `git commit`

Phillip Wood (8):
  t3404: use test_cmp_rev
  cherry-pick: check commit error messages
  sequencer: write CHERRY_PICK_HEAD for reword and edit
  commit: use enum value for multiple cherry-picks
  commit: encapsulate determine_whence() for sequencer
  commit: give correct advice for empty commit during a rebase
  [RFC] rebase: fix advice when a fixup creates an empty commit
  [RFC] rebase -i: leave CHERRY_PICK_HEAD when there are conflicts

 builtin/commit.c                |  68 +++++++++----
 sequencer.c                     |  93 +++++++++++++++---
 sequencer.h                     |   4 +-
 t/t3403-rebase-skip.sh          |  97 ++++++++++++++++--
 t/t3404-rebase-interactive.sh   | 168 +++++++++++++++++++++++---------
 t/t3507-cherry-pick-conflict.sh |  23 +++++
 t/t3510-cherry-pick-sequence.sh |   3 +-
 t/t7512-status-help.sh          |   2 -
 wt-status.h                     |  16 ++-
 9 files changed, 387 insertions(+), 87 deletions(-)

Range-diff to what is in pu at the moment

 -:  ---------- >  1:  a4ad3e798c t3404: use test_cmp_rev
 1:  b9f97083f1 =  2:  1e9ea48348 cherry-pick: add test for `--skip` advice in `git commit`
 2:  8eff6be234 <  -:  ---------- sequencer: export the function to get the path of `.git/rebase-merge/`
 -:  ---------- >  3:  f9be4dc3ae cherry-pick: check commit error messages
 -:  ---------- >  4:  fe15c61f1e sequencer: write CHERRY_PICK_HEAD for reword and edit
 -:  ---------- >  5:  d2cc4a59f1 commit: use enum value for multiple cherry-picks
 -:  ---------- >  6:  06ab99b367 commit: encapsulate determine_whence() for sequencer
 3:  116a408b6f !  7:  637f17212b commit: give correct advice for empty commit during a rebase
    @@
      ## Metadata ##
    -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Commit message ##
         commit: give correct advice for empty commit during a rebase
    @@ Commit message
         cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
         line in an interactive rebase). On the other hand, it is not possible to
         run a rebase during a cherry-pick, meaning: if both `rebase-merge/` and
    -    `sequencer/` exist, we still want to advise to use `git cherry-pick
    -    --skip`.
    +    `sequencer/` exist or CHERRY_PICK_HEAD and REBASE_HEAD point to the same
    +    commit , we still want to advise to use `git cherry-pick --skip`.
     
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/commit.c ##
     @@ builtin/commit.c: N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
      "    git commit --allow-empty\n"
      "\n");
      
    -+static const char empty_rebase_advice[] =
    ++static const char empty_rebase_pick_advice[] =
     +N_("Otherwise, please use 'git rebase --skip'\n");
     +
      static const char empty_cherry_pick_advice_single[] =
      N_("Otherwise, please use 'git cherry-pick --skip'\n");
      
    -@@ builtin/commit.c: static enum commit_msg_cleanup_mode cleanup_mode;
    - static const char *cleanup_arg;
    - 
    - static enum commit_whence whence;
    --static int sequencer_in_use;
    -+static int sequencer_in_use, rebase_in_progress;
    - static int use_editor = 1, include_status = 1;
    - static int have_option_m;
    - static struct strbuf message = STRBUF_INIT;
    -@@ builtin/commit.c: static void determine_whence(struct wt_status *s)
    - 		whence = FROM_CHERRY_PICK;
    - 		if (file_exists(git_path_seq_dir()))
    - 			sequencer_in_use = 1;
    -+		if (file_exists(git_path_rebase_merge_dir()))
    -+			rebase_in_progress = 1;
    - 	}
    - 	else
    - 		whence = FROM_COMMIT;
     @@ builtin/commit.c: static const char *prepare_index(int argc, const char **argv, const char *prefix
    - 	if (whence != FROM_COMMIT) {
    - 		if (whence == FROM_MERGE)
      			die(_("cannot do a partial commit during a merge."));
    --		else if (whence == FROM_CHERRY_PICK)
    -+		else if (whence == FROM_CHERRY_PICK) {
    -+			if (rebase_in_progress && !sequencer_in_use)
    -+				die(_("cannot do a partial commit during a rebase."));
    + 		else if (is_from_cherry_pick(whence))
      			die(_("cannot do a partial commit during a cherry-pick."));
    -+		}
    ++		else if (is_from_rebase(whence))
    ++			die(_("cannot do a partial commit during a rebase."));
      	}
      
      	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    + 	 */
    + 	else if (whence == FROM_MERGE)
    + 		hook_arg1 = "merge";
    +-	else if (is_from_cherry_pick(whence)) {
    ++	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
    + 		hook_arg1 = "commit";
    + 		hook_arg2 = "CHERRY_PICK_HEAD";
    + 	}
    +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    + 		run_status(stdout, index_file, prefix, 0, s);
    + 		if (amend)
      			fputs(_(empty_amend_advice), stderr);
    - 		else if (whence == FROM_CHERRY_PICK) {
    +-		else if (is_from_cherry_pick(whence)) {
    ++		else if (is_from_cherry_pick(whence) ||
    ++			 whence == FROM_REBASE_PICK) {
      			fputs(_(empty_cherry_pick_advice), stderr);
    --			if (!sequencer_in_use)
    --				fputs(_(empty_cherry_pick_advice_single), stderr);
    + 			if (whence == FROM_CHERRY_PICK_SINGLE)
    + 				fputs(_(empty_cherry_pick_advice_single), stderr);
     -			else
    -+			if (sequencer_in_use)
    ++			else if (whence == FROM_CHERRY_PICK_MULTI)
      				fputs(_(empty_cherry_pick_advice_multi), stderr);
    -+			else if (rebase_in_progress)
    -+				fputs(_(empty_rebase_advice), stderr);
     +			else
    -+				fputs(_(empty_cherry_pick_advice_single), stderr);
    ++				fputs(_(empty_rebase_pick_advice), stderr);
      		}
      		return 0;
      	}
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    - 	if (amend && whence != FROM_COMMIT) {
    - 		if (whence == FROM_MERGE)
      			die(_("You are in the middle of a merge -- cannot amend."));
    --		else if (whence == FROM_CHERRY_PICK)
    -+		else if (whence == FROM_CHERRY_PICK) {
    -+			if (rebase_in_progress && !sequencer_in_use)
    -+				die(_("You are in the middle of a rebase -- cannot amend."));
    + 		else if (is_from_cherry_pick(whence))
      			die(_("You are in the middle of a cherry-pick -- cannot amend."));
    -+		}
    ++		else if (whence == FROM_REBASE_PICK)
    ++			die(_("You are in the middle of a rebase -- cannot amend."));
      	}
      	if (fixup_message && squash_message)
      		die(_("Options --squash and --fixup cannot be used together"));
    +@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    + 		use_message = edit_message;
    + 	if (amend && !use_message && !fixup_message)
    + 		use_message = "HEAD";
    +-	if (!use_message && !is_from_cherry_pick(whence) && renew_authorship)
    ++	if (!use_message && !is_from_cherry_pick(whence) &&
    ++	    !is_from_rebase(whence) && renew_authorship)
    + 		die(_("--reset-author can be used only with -C, -c or --amend."));
    + 	if (use_message) {
    + 		use_message_buffer = read_commit_message(use_message);
    +@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    + 			author_message_buffer = use_message_buffer;
    + 		}
    + 	}
    +-	if (is_from_cherry_pick(whence) && !renew_authorship) {
    ++	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
    ++	    !renew_authorship) {
    + 		author_message = "CHERRY_PICK_HEAD";
    + 		author_message_buffer = read_commit_message(author_message);
    + 	}
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
    - 			reduce_heads_replace(&parents);
    - 	} else {
      		if (!reflog_msg)
    --			reflog_msg = (whence == FROM_CHERRY_PICK)
    --					? "commit (cherry-pick)"
    --					: "commit";
    -+			reflog_msg = (whence != FROM_CHERRY_PICK)
    -+					? "commit"
    -+					: rebase_in_progress && !sequencer_in_use
    + 			reflog_msg = is_from_cherry_pick(whence)
    + 					? "commit (cherry-pick)"
    ++					: is_from_rebase(whence)
     +					? "commit (rebase)"
    -+					: "commit (cherry-pick)";
    + 					: "commit";
      		commit_list_insert(current_head, &parents);
      	}
    +
    + ## sequencer.c ##
    +@@ sequencer.c: static int try_to_commit(struct repository *r,
    + 	return res;
    + }
    + 
    ++static int write_rebase_head(struct object_id *oid)
    ++{
    ++	if (update_ref("rebase", "REBASE_HEAD", oid,
    ++		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
    ++		return error(_("could not update %s"), "REBASE_HEAD");
    ++
    ++	return 0;
    ++}
    ++
    + static int do_commit(struct repository *r,
    + 		     const char *msg_file, const char *author,
    +-		     struct replay_opts *opts, unsigned int flags)
    ++		     struct replay_opts *opts, unsigned int flags,
    ++		     struct object_id *oid)
    + {
    + 	int res = 1;
    + 
    +@@ sequencer.c: static int do_commit(struct repository *r,
    + 			return res;
    + 		}
    + 	}
    +-	if (res == 1)
    ++	if (res == 1) {
    ++		if (is_rebase_i(opts) && oid)
    ++			if (write_rebase_head(oid))
    ++			    return -1;
    + 		return run_git_commit(r, msg_file, opts, flags);
    ++	}
    + 
    + 	return res;
    + }
    +@@ sequencer.c: static int do_pick_commit(struct repository *r,
    + 		flags |= ALLOW_EMPTY;
    + 	if (!opts->no_commit) {
    + 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
    +-			res = do_commit(r, msg_file, author, opts, flags);
    ++			res = do_commit(r, msg_file, author, opts, flags,
    ++					commit? &commit->object.oid : NULL);
    + 		else
    + 			res = error(_("unable to parse commit author"));
    + 		*check_todo = !!(flags & EDIT_MSG);
    +@@ sequencer.c: static int make_patch(struct repository *r,
    + 	p = short_commit_name(commit);
    + 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
    + 		return -1;
    +-	if (update_ref("rebase", "REBASE_HEAD", &commit->object.oid,
    +-		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
    +-		res |= error(_("could not update %s"), "REBASE_HEAD");
    ++	res |= write_rebase_head(&commit->object.oid);
    + 
    + 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
    + 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
    +@@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
    + int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
    + {
    + 	if (file_exists(git_path_cherry_pick_head(r))) {
    +-		*whence = file_exists(git_path_seq_dir()) ?
    +-			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
    ++		struct object_id cherry_pick_head, rebase_head;
    ++
    ++		if (file_exists(git_path_seq_dir()))
    ++			*whence = FROM_CHERRY_PICK_MULTI;
    ++		if (file_exists(rebase_path()) &&
    ++		    !get_oid("REBASE_HEAD", &rebase_head) &&
    ++		    !get_oid("CHERRY_PICK_HEAD", &cherry_pick_head) &&
    ++		    oideq(&rebase_head, &cherry_pick_head))
    ++			*whence = FROM_REBASE_PICK;
    ++		else
    ++			*whence = FROM_CHERRY_PICK_SINGLE;
    ++
    + 		return 1;
    + 	}
      
     
      ## t/t3403-rebase-skip.sh ##
    -@@ t/t3403-rebase-skip.sh: test_expect_success 'moved back to branch correctly' '
    +@@ t/t3403-rebase-skip.sh: test_expect_success 'correct advice upon picking empty commit' '
    + 	test_must_fail git rebase -i --onto goodbye \
    + 		amended-goodbye^ amended-goodbye 2>err &&
    + 	test_i18ngrep "previous cherry-pick is now empty" err &&
    +-	test_i18ngrep "git cherry-pick --skip" err &&
    ++	test_i18ngrep "git rebase --skip" err &&
    + 	test_must_fail git commit &&
    +-	test_i18ngrep "git cherry-pick --skip" err
    ++	test_i18ngrep "git rebase --skip" err
    + '
      
    - test_debug 'gitk --all & sleep 1'
    + test_expect_success 'correct authorship when committing empty pick' '
    +@@ t/t3403-rebase-skip.sh: test_expect_success 'correct advice upon rewording empty commit' '
    + 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
    + 	) &&
    + 	test_i18ngrep "previous cherry-pick is now empty" err &&
    +-	test_i18ngrep "git cherry-pick --skip" err &&
    ++	test_i18ngrep "git rebase --skip" err &&
    + 	test_must_fail git commit &&
    +-	test_i18ngrep "git cherry-pick --skip" err
    ++	test_i18ngrep "git rebase --skip" err
    + '
      
    -+test_expect_success 'correct advice upon empty commit' '
    -+	git checkout -b rebase-skip &&
    -+	test_commit a1 &&
    -+	test_tick &&
    -+	git commit --amend -m amended --no-edit &&
    -+	test_must_fail git rebase -m --onto a1 HEAD^ 2>err &&
    + test_expect_success 'correct advice upon editing empty commit' '
    +@@ t/t3403-rebase-skip.sh: test_expect_success 'correct advice upon editing empty commit' '
    + 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
    + 	) &&
    + 	test_i18ngrep "previous cherry-pick is now empty" err &&
    +-	test_i18ngrep "git cherry-pick --skip" err &&
    ++	test_i18ngrep "git rebase --skip" err &&
    + 	test_must_fail git commit &&
     +	test_i18ngrep "git rebase --skip" err
     +'
     +
    - test_done
    ++test_expect_success 'correct advice upon cherry-picking an empty commit during a rebase' '
    ++	test_when_finished "git rebase --abort" &&
    ++	(
    ++		set_fake_editor &&
    ++		test_must_fail env FAKE_LINES="1 exec_git_cherry-pick_amended-goodbye" \
    ++			git rebase -i goodbye^ goodbye 2>err
    ++	) &&
    ++	test_i18ngrep "previous cherry-pick is now empty" err &&
    ++	test_i18ngrep "git cherry-pick --skip" err &&
    ++	test_must_fail git commit 2>err &&
    ++	test_i18ngrep "git cherry-pick --skip" err
    ++'
    ++
    ++test_expect_success 'correct advice upon multi cherry-pick picking an empty commit during a rebase' '
    ++	test_when_finished "git rebase --abort" &&
    ++	(
    ++		set_fake_editor &&
    ++		test_must_fail env FAKE_LINES="1 exec_git_cherry-pick_goodbye_amended-goodbye" \
    ++			git rebase -i goodbye^^ goodbye 2>err
    ++	) &&
    ++	test_i18ngrep "previous cherry-pick is now empty" err &&
    ++	test_i18ngrep "git cherry-pick --skip" err &&
    ++	test_must_fail git commit 2>err &&
    + 	test_i18ngrep "git cherry-pick --skip" err
    + '
    + 
    +
    + ## t/t3404-rebase-interactive.sh ##
    +@@ t/t3404-rebase-interactive.sh: test_expect_success 'post-commit hook is called' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'correct error message for partial commit after empty pick' '
    ++	test_when_finished "git rebase --abort" &&
    ++	(
    ++		set_fake_editor &&
    ++		FAKE_LINES="2 1 1" &&
    ++		export FAKE_LINES &&
    ++		test_must_fail git rebase -i A D
    ++	) &&
    ++	echo x >file1 &&
    ++	test_must_fail git commit file1 2>err &&
    ++	test_i18ngrep "cannot do a partial commit during a rebase." err
    ++'
    ++
    ++test_expect_success 'correct error message for commit --amend after empty pick' '
    ++	test_when_finished "git rebase --abort" &&
    ++	(
    ++		set_fake_editor &&
    ++		FAKE_LINES="1 1" &&
    ++		export FAKE_LINES &&
    ++		test_must_fail git rebase -i A D
    ++	) &&
    ++	echo x>file1 &&
    ++	test_must_fail git commit -a --amend 2>err &&
    ++	test_i18ngrep "middle of a rebase -- cannot amend." err
    ++'
    ++
    + # This must be the last test in this file
    + test_expect_success '$EDITOR and friends are unchanged' '
    + 	test_editor_unchanged
    +
    + ## wt-status.h ##
    +@@ wt-status.h: enum commit_whence {
    + 	FROM_COMMIT,     /* normal */
    + 	FROM_MERGE,      /* commit came from merge */
    + 	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
    +-	FROM_CHERRY_PICK_MULTI /* commit came from a sequence of cherry-picks */
    ++	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
    ++	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
    + };
    + 
    + static inline int is_from_cherry_pick(enum commit_whence whence)
    +@@ wt-status.h: static inline int is_from_cherry_pick(enum commit_whence whence)
    + 		whence == FROM_CHERRY_PICK_MULTI;
    + }
    + 
    ++static inline int is_from_rebase(enum commit_whence whence)
    ++{
    ++	return whence == FROM_REBASE_PICK;
    ++}
    ++
    + struct wt_status_change_data {
    + 	int worktree_status;
    + 	int index_status;
 -:  ---------- >  8:  6a00263595 [RFC] rebase: fix advice when a fixup creates an empty commit
 -:  ---------- >  9:  8b5ca6b60b [RFC] rebase -i: leave CHERRY_PICK_HEAD when there are conflicts

-- 
2.24.0
