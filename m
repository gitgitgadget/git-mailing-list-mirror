Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5430DC7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 14:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCSOtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSOtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 10:49:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBE83E4
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 07:49:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l12so8188424wrm.10
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679237339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DGFk+LyRhkqx1ODta2G6cgEq9+70gS2Y5YzZS+r1mT8=;
        b=V4kK8M16YVHn5zvKbnB40wYmbtFqq+WouNimd7ucGymVnCrZHL0Ol3qRjAA5AQxupQ
         uIC5vUS722vHsMRgddBA3T1Dm3bu8/BFf03dkCdCMEl31JKe/F2fBQxvnLHMkh1+I9kk
         kz1s/0lO+oSLI+5MRrAOFUzkHN7pt4NDuMoWkBrmYvf6rBM5/4SwTTsL5NkbeFweNZUG
         hijdBEqm5FkZ2vhIJi5NNpG4ddEPIGwIwlTzvxzsx1SlE6m1YL2zmmi1DhYoh61Qr+Ay
         3xYhZi1p8Q2Hr3nb28B+2iIYg3NROuI5AJk3jb0cmwUsOFz5Zd2GL+PjOuxYYMVEr7hd
         jEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679237339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGFk+LyRhkqx1ODta2G6cgEq9+70gS2Y5YzZS+r1mT8=;
        b=SrBhLhN+sMnqVYn0F1P+LIIc9rloWdbKSCjKVlhJ9/5h5TgNMMKXc1MVtNle4+0Ry2
         VNc97Gnc0z+MXWn5zMv4DhbpFZkpaY3LqirV9NtgStS7LEvdRQw/YSrRle+wKd6nXGY7
         D9Sjfv6JGkVAvexkHTap6fxzjA+p7iAF3g4yOmszS9l120Mx0VQNnyglsqkZXZs6BW9R
         QZzBPlPEqvN2S1loxjsBtZu18fTW1uEKJRmT1h6o7axb5/+24RG6fg1x+WLoGbF2ogTO
         LfHjD39KtNRUCJ/ud2DWGYtsAn4XmUWalaTW00W6yoGObGQiFY4EQ2Y2u17wzBV6m5sY
         hIZQ==
X-Gm-Message-State: AO0yUKXptQG5a2Ykc7Z5D0aVJFLtPnxpUn1dmqsTsgTE4HhbMyW/yeho
        3UYtTFE+GoVLjXxN5rD1blMxXSbKWkA=
X-Google-Smtp-Source: AK7set/H7KnjDbatUUiDvzm3DlNydyGeBqUALLsYvoboPgn/lTLb8JvMLlSVGlJWQIXPh8nbsmrS6Q==
X-Received: by 2002:adf:e605:0:b0:2ce:ad08:ca4 with SMTP id p5-20020adfe605000000b002cead080ca4mr12011824wrm.35.1679237338655;
        Sun, 19 Mar 2023 07:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d58ed000000b002c5493a17efsm6746071wrd.25.2023.03.19.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:48:58 -0700 (PDT)
Message-Id: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 14:48:57 +0000
Subject: [PATCH] rebase -i: do not update "done" when rescheduling command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the sequencer executes todo commands it appends them to
.git/rebase-merge/done. This file is used by "git status" to show the
recently executed commands. Unfortunately when a command is rescheduled
the command preceding it is erroneously appended to the "done" file.
This means that when rebase stops after rescheduling "pick B" the "done"
file contains

	pick A
	pick B
	pick A

instead of

	pick A
	pick B

Fix this by not updating the "done" file when adding a rescheduled
command back into the "todo" file. A couple of the existing tests are
modified to improve their coverage as none of them trigger this bug or
check the "done" file.

Note that the rescheduled command will still be appended to the "done"
file again when it is successfully executed. Arguably it would be better
not to do that but fixing it would be more involved.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: do not update "done" when rescheduling command
    
    This fixes the output of "git status" when rebase stops for a
    rescheduled command.
    
    Stefan - thanks for reporting this, hopefully it will be easy enough to
    update lazygit to check the last command in the done file as well as the
    second to last command for older versions of git.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1492%2Fphillipwood%2Frebase-dont-write-done-when-rescheduling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1492/phillipwood/rebase-dont-write-done-when-rescheduling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1492

 sequencer.c                   | 15 +++++++--------
 t/t3404-rebase-interactive.sh | 27 +++++++++++++++++----------
 t/t3430-rebase-merges.sh      | 22 ++++++++++++++++------
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1c96a75b1e9..87eeda52595 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3379,7 +3379,8 @@ give_advice:
 	return -1;
 }
 
-static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
+		     int reschedule)
 {
 	struct lock_file todo_lock = LOCK_INIT;
 	const char *todo_path = get_todo_path(opts);
@@ -3389,7 +3390,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	 * rebase -i writes "git-rebase-todo" without the currently executing
 	 * command, appending it to "done" instead.
 	 */
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts) && !reschedule)
 		next++;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
@@ -3402,7 +3403,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'"), todo_path);
 
-	if (is_rebase_i(opts) && next > 0) {
+	if (is_rebase_i(opts) && !reschedule && next > 0) {
 		const char *done = rebase_path_done();
 		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
 		int ret = 0;
@@ -4648,7 +4649,7 @@ static int pick_commits(struct repository *r,
 		const char *arg = todo_item_get_arg(todo_list, item);
 		int check_todo = 0;
 
-		if (save_todo(todo_list, opts))
+		if (save_todo(todo_list, opts, 0))
 			return -1;
 		if (is_rebase_i(opts)) {
 			if (item->command != TODO_COMMENT) {
@@ -4695,8 +4696,7 @@ static int pick_commits(struct repository *r,
 							    todo_list->current),
 				       get_item_line(todo_list,
 						     todo_list->current));
-				todo_list->current--;
-				if (save_todo(todo_list, opts))
+				if (save_todo(todo_list, opts, 1))
 					return -1;
 			}
 			if (item->command == TODO_EDIT) {
@@ -4788,8 +4788,7 @@ static int pick_commits(struct repository *r,
 			       get_item_line_length(todo_list,
 						    todo_list->current),
 			       get_item_line(todo_list, todo_list->current));
-			todo_list->current--;
-			if (save_todo(todo_list, opts))
+			if (save_todo(todo_list, opts, 1))
 				return -1;
 			if (item->commit)
 				return error_with_patch(r,
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e2..39c1ce51f69 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1276,20 +1276,27 @@ test_expect_success 'todo count' '
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
-	git checkout --force branch2 &&
+	git checkout --force A &&
 	git clean -f &&
+	cat >todo <<-EOF &&
+	exec >file2
+	pick $(git rev-parse B) B
+	pick $(git rev-parse C) C
+	pick $(git rev-parse D) D
+	exec cat .git/rebase-merge/done >actual
+	EOF
 	(
-		set_fake_editor &&
-		FAKE_LINES="edit 1 2" git rebase -i A
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A
 	) &&
-	test_cmp_rev HEAD F &&
-	test_path_is_missing file6 &&
-	>file6 &&
-	test_must_fail git rebase --continue &&
-	test_cmp_rev HEAD F &&
-	rm file6 &&
+	test_cmp_rev HEAD B &&
+	head -n3 todo >expect &&
+	test_cmp expect .git/rebase-merge/done &&
+	rm file2 &&
 	git rebase --continue &&
-	test_cmp_rev HEAD I
+	test_cmp_rev HEAD D &&
+	tail -n3 todo >>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f0..2ad1f9504da 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -128,14 +128,24 @@ test_expect_success 'generate correct todo list' '
 '
 
 test_expect_success '`reset` refuses to overwrite untracked files' '
-	git checkout -b refuse-to-reset &&
+	git checkout B &&
 	test_commit dont-overwrite-untracked &&
-	git checkout @{-1} &&
-	: >dont-overwrite-untracked.t &&
-	echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
+	cat >script-from-scratch <<-EOF &&
+	exec >dont-overwrite-untracked.t
+	pick $(git rev-parse B) B
+	reset refs/tags/dont-overwrite-untracked
+	pick $(git rev-parse C) C
+	exec cat .git/rebase-merge/done >actual
+	EOF
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
-	test_must_fail git rebase -ir HEAD &&
-	git rebase --abort
+	test_must_fail git rebase -ir A &&
+	test_cmp_rev HEAD B &&
+	head -n3 script-from-scratch >expect &&
+	test_cmp expect .git/rebase-merge/done &&
+	rm dont-overwrite-untracked.t &&
+	git rebase --continue &&
+	tail -n3 script-from-scratch >>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '`reset` rejects trees' '

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
