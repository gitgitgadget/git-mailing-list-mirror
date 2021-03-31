Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36801C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 06:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54D4619D6
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 06:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhCaGwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhCaGwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 02:52:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A416C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 23:52:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so590874wmc.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6YUA2S9L1MoUnBMOw3NtSCsbzms5AjvUFlboqCiMZok=;
        b=E8BF4zTI1yemRhtAearCf/iySz4Tu0uJxx1UdPQX8oKe03Hd7kArPvz/7vibmlQtHJ
         C+C4pwgxdkK9eStJQg+nxk9V9kOrueLYuWSZ0RwHjYYd9zHumhzG2vhVKvHfQ3pHqpwa
         bCgzQr5U2c813VhopaAS2zHRQITvGDrGkbjbReZJlafl8n4A50NVdXP4sMmtqe8L4spY
         LQ/50sGwAcxo/9VPAMfCbba8sjggwnbCucajP91H5fVwoDlyCMO+7nQPe+2kwL6Wv92D
         2UBkmovAdU6U7ws2zCoPSHGL/i/NwtZnlNzAurFWDpob6dQP05NHvB13y3R/O+PI1dRx
         x7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6YUA2S9L1MoUnBMOw3NtSCsbzms5AjvUFlboqCiMZok=;
        b=G6+WVLvYrkSHMwpp+gjWsRpDPwg17Y6o34jUeMPhAJtQCsGXz0DBmUEuyle1o3Nol+
         YR69h5qIsheJbObp9a/4YxsbrRhn67Rw7l9DiFekRpDSustOFIrVOpZW5/J0tjR4bpl0
         V67NSBjXPI3SJ+Mb5wln2VzjcYEbKl3VaAqMSa3RzmPYirGCCTGBNQmz3xMoxVlobMAf
         jim0EHvxgUmF6SGHL5oY5whMCQ1nrwsJdG8zrToxxxlct8DffRA/n/H1pjNSu3DHhVcu
         aoRmPjb3uvBnovujy8lxnYF1RFFet7LzNLJq6UaLilNoH48bc0mfoAuCyehnanoK585y
         iCTg==
X-Gm-Message-State: AOAM532Q3bNvOfW32Dc+WyKbRUjdyht2lRCiRRsYckAn1E6uOQ3V27ev
        Ff1wYkJ0ZgNM9w+g0CkRLN7qEinlcRw=
X-Google-Smtp-Source: ABdhPJxKoulQOnO31dEErHTQBCKHJe26c9llNoP3fJP7aBxvKCpMBcGU2ODo5SssAP/iohjpOvCDJA==
X-Received: by 2002:a1c:6241:: with SMTP id w62mr1660542wmb.79.1617173543040;
        Tue, 30 Mar 2021 23:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm2420765wme.14.2021.03.30.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 23:52:22 -0700 (PDT)
Message-Id: <pull.988.v3.git.git.1617173541301.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
References: <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 06:52:20 +0000
Subject: [PATCH v3] sequencer: fix edit handling for cherry-pick and revert
 messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

save_opts() should save any non-default values.  It was intended to do
this, but since most options in struct replay_opts default to 0, it only
saved non-zero values.  Unfortunately, this does not always work for
options.edit.  Roughly speaking, options.edit had a default value of 0
for cherry-pick but a default value of 1 for revert.  Make save_opts()
record a value whenever it differs from the default.

options.edit was also overly simplistic; we had more than two cases.
The behavior that previously existed was as follows:

                       Non-conflict commits    Right after Conflict
    revert             Edit iff isatty(0)      Edit (ignore isatty(0))
    cherry-pick        No edit                 See above
    Specify --edit     Edit (ignore isatty(0)) See above
    Specify --no-edit  (*)                     See above

    (*) Before stopping for conflicts, No edit is the behavior.  After
        stopping for conflicts, the --no-edit flag is not saved so see
        the first two rows.

However, the expected behavior is:

                       Non-conflict commits    Right after Conflict
    revert             Edit iff isatty(0)      Edit iff isatty(0)
    cherry-pick        No edit                 Edit iff isatty(0)
    Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
    Specify --no-edit  No edit                 No edit

In order to get the expected behavior, we need to change options.edit
to a tri-state: unspecified, false, or true.  When specified, we follow
what it says.  When unspecified, we need to check whether the current
commit being created is resolving a conflict as well as consulting
options.action and isatty(0).  While at it, add a should_edit() utility
function that compresses options.edit down to a boolean based on the
additional information for the non-conflict case.

continue_single_pick() is the function responsible for resuming after
conflict cases, regardless of whether there is one commit being picked
or many.  Make this function stop assuming edit behavior in all cases,
so that it can correctly handle !isatty(0) and specific requests to not
edit the commit message.

Reported-by: Renato Botelho <garga@freebsd.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: fix edit handling for cherry-pick and revert messages
    
    Changes since v2:
    
     * Changed to use <0 for unspecified (instead of == -1), >0 for true
       (instead of == 1).
     * Removed assert() statement.
     * Removed unnecessary "want_edit" local variable
    
    Reported-by: Renato Botelho garga@freebsd.org Signed-off-by: Elijah
    Newren newren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-988%2Fnewren%2Ffix-sequencer-no-edit-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-988/newren/fix-sequencer-no-edit-v3
Pull-Request: https://github.com/git/git/pull/988

Range-diff vs v2:

 1:  376799bd3d99 ! 1:  8fce8c772dee sequencer: fix edit handling for cherry-pick and revert messages
     @@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, struct r
       				"--no-commit", opts->no_commit,
       				"-x", opts->record_origin,
      -				"--edit", opts->edit,
     -+				"--edit", opts->edit == 1,
     ++				"--edit", opts->edit > 0,
       				NULL);
       
       	if (cmd) {
     @@ sequencer.c: static void record_in_rewritten(struct object_id *oid,
       }
       
      +static int should_edit(struct replay_opts *opts) {
     -+	assert(opts->edit >= -1 && opts->edit <= 1);
     -+	if (opts->edit == -1)
     ++	if (opts->edit < 0)
      +		/*
      +		 * Note that we only handle the case of non-conflicted
      +		 * commits; continue_single_pick() handles the conflicted
     @@ sequencer.c: static int save_opts(struct replay_opts *opts)
      -	if (opts->edit)
      -		res |= git_config_set_in_file_gently(opts_file,
      -					"options.edit", "true");
     -+	if (opts->edit != -1)
     ++	if (opts->edit >= 0)
      +		res |= git_config_set_in_file_gently(opts_file, "options.edit",
      +						     opts->edit ? "true" : "false");
       	if (opts->allow_empty)
     @@ sequencer.c: static int pick_commits(struct repository *r,
       {
      -	const char *argv[] = { "commit", NULL };
      +	struct strvec argv = STRVEC_INIT;
     -+	int want_edit;
      +	int ret;
       
       	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
     @@ sequencer.c: static int pick_commits(struct repository *r,
      +	 * we want to edit if the user asked for it, or if they didn't specify
      +	 * and stdin is a tty.
      +	 */
     -+	want_edit = (opts->edit == 1) || ((opts->edit == -1) && isatty(0));
     -+	if (!want_edit)
     ++	if (!opts->edit || (opts->edit < 0 && !isatty(0)))
      +		/*
      +		 * Include --cleanup=strip as well because we don't want the
      +		 * "# Conflicts:" messages.


 builtin/revert.c                |  4 +--
 sequencer.c                     | 52 ++++++++++++++++++++++++++-------
 sequencer.h                     |  6 ++--
 t/t3510-cherry-pick-sequence.sh | 32 +++++++++++++++++++-
 4 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 314a86c5621b..237f2f18d4c0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--signoff", opts->signoff,
 				"--no-commit", opts->no_commit,
 				"-x", opts->record_origin,
-				"--edit", opts->edit,
+				"--edit", opts->edit > 0,
 				NULL);
 
 	if (cmd) {
@@ -230,8 +230,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
-	if (isatty(0))
-		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
diff --git a/sequencer.c b/sequencer.c
index 848204d3dc3f..8ef597ac3a9e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1860,14 +1860,25 @@ static void record_in_rewritten(struct object_id *oid,
 		flush_rewritten_pending();
 }
 
+static int should_edit(struct replay_opts *opts) {
+	if (opts->edit < 0)
+		/*
+		 * Note that we only handle the case of non-conflicted
+		 * commits; continue_single_pick() handles the conflicted
+		 * commits itself instead of calling this function.
+		 */
+		return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
+	return opts->edit;
+}
+
 static int do_pick_commit(struct repository *r,
 			  enum todo_command command,
 			  struct commit *commit,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
-	unsigned int flags = opts->edit ? EDIT_MSG : 0;
-	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
+	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
+	const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
 	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
@@ -3101,9 +3112,9 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->no_commit)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.no-commit", "true");
-	if (opts->edit)
-		res |= git_config_set_in_file_gently(opts_file,
-					"options.edit", "true");
+	if (opts->edit >= 0)
+		res |= git_config_set_in_file_gently(opts_file, "options.edit",
+						     opts->edit ? "true" : "false");
 	if (opts->allow_empty)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.allow-empty", "true");
@@ -4077,7 +4088,7 @@ static int pick_commits(struct repository *r,
 	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-			 opts->record_origin || opts->edit ||
+			 opts->record_origin || should_edit(opts) ||
 			 opts->committer_date_is_author_date ||
 			 opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
@@ -4370,14 +4381,33 @@ static int pick_commits(struct repository *r,
 	return sequencer_remove_state(opts);
 }
 
-static int continue_single_pick(struct repository *r)
+static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 {
-	const char *argv[] = { "commit", NULL };
+	struct strvec argv = STRVEC_INIT;
+	int ret;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+
+	strvec_push(&argv, "commit");
+
+	/*
+	 * continue_single_pick() handles the case of recovering from a
+	 * conflict.  should_edit() doesn't handle that case; for a conflict,
+	 * we want to edit if the user asked for it, or if they didn't specify
+	 * and stdin is a tty.
+	 */
+	if (!opts->edit || (opts->edit < 0 && !isatty(0)))
+		/*
+		 * Include --cleanup=strip as well because we don't want the
+		 * "# Conflicts:" messages.
+		 */
+		strvec_pushl(&argv, "--no-edit", "--cleanup=strip", NULL);
+
+	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
+	strvec_clear(&argv);
+	return ret;
 }
 
 static int commit_staged_changes(struct repository *r,
@@ -4547,7 +4577,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			goto release_todo_list;
 		}
 	} else if (!file_exists(get_todo_path(opts)))
-		return continue_single_pick(r);
+		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
 		goto release_todo_list;
 
@@ -4556,7 +4586,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") ||
 		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
-			res = continue_single_pick(r);
+			res = continue_single_pick(r, opts);
 			if (res)
 				goto release_todo_list;
 		}
diff --git a/sequencer.h b/sequencer.h
index f8b2e4ab8527..d57d8ea23d7a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -31,8 +31,10 @@ enum commit_msg_cleanup_mode {
 struct replay_opts {
 	enum replay_action action;
 
-	/* Boolean options */
+	/* Tri-state options: unspecified, false, or true */
 	int edit;
+
+	/* Boolean options */
 	int record_origin;
 	int no_commit;
 	int signoff;
@@ -71,7 +73,7 @@ struct replay_opts {
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
-#define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
+#define REPLAY_OPTS_INIT { .edit = -1, .action = -1, .current_fixups = STRBUF_INIT }
 
 /*
  * Note that ordering matters in this enum. Not only must it match the mapping
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b76cb6de91d0..49010aa9469d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -65,7 +65,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	# gets interrupted, use a high-enough number that is larger
 	# than the number of parents of any commit we have created
 	mainline=4 &&
-	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours initial..anotherpick &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours --edit initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -84,6 +84,36 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	ours
 	EOF
 	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
+	test_cmp expect actual &&
+	echo "true" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'revert persists opts correctly' '
+	pristine_detach initial &&
+	# to make sure that the session to revert a sequence
+	# gets interrupted, revert commits that are not in the history
+	# of HEAD.
+	test_expect_code 1 git revert -s --strategy=recursive -X patience -X ours --no-edit picked yetanotherpick &&
+	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/head &&
+	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts &&
+	echo "true" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
+	test_cmp expect actual &&
+	echo "recursive" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.strategy >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	patience
+	ours
+	EOF
+	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
+	test_cmp expect actual &&
+	echo "false" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
 	test_cmp expect actual
 '
 

base-commit: 98164e9585e02e31dcf1377a553efe076c15f8c6
-- 
gitgitgadget
