Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2369BC7EE30
	for <git@archiver.kernel.org>; Tue, 23 May 2023 08:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEWIfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjEWIem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 04:34:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97632E71
        for <git@vger.kernel.org>; Tue, 23 May 2023 01:32:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so1785150f8f.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684830769; x=1687422769;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FO/V+nBeXJvmQyGTWmGM2jpGK/jMDdXvxMEcZ9unhiw=;
        b=VgfbdL68VA3sKf9ts98soAwA+g41Gfc92q5YadllOXIFBHV5hxfYh2CyARU+qrhvxs
         s6nl2XAS55HWesDwMhotSrcy0wphbDdePx+sEYPcXIssd9FmRJ92q66TXj2GMcKeGw5y
         0NzdyOTgB7DzJ3o31gAw/HYNAaODA/c0M/WutSCAFUzGd5+SOFXVaxNORjZPAouoZA5L
         4aqsuKmXPrgcwNRX5iYzy5HMIBQEGnBmKZCfkIU+mXLlE9YVaP6q3p8BXX4EPZpGhUxg
         c6+HE8AIl+4doPcJLXiiPi2Dd9nXqPP0T3htpt3BBQ5unaY5fDZDwvn5zO+HHvf+NgND
         2b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830769; x=1687422769;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO/V+nBeXJvmQyGTWmGM2jpGK/jMDdXvxMEcZ9unhiw=;
        b=dM9hKhSwwNiUF6oojKUA9ajJG0Q/UQksf1rKDKoQE1IbMDtVquVoJ9gBm/6v1m1ueG
         RQ/hqxyy3Riny+U0FHv46NXNvtkqeti59gc9BkQC5dVLdRuNfOmOi8W8XzQuxK0yddEN
         lN8zM2k3nFLtvv6DIerCRKgZcG9Xv0JSwL8g3MJo+rIWd/90agK7EXEtGcVA4PFJ90+1
         /4wkJYc/MolK4OJNngThb5OFuozHLbHrymFqQQl5a9z1R7WJiDQCX3GbIutZhuEQRVJz
         oGKTQQN12pJiKzL8nXuMIcjycDktXJRvLYW9n2LFA7mHm0NSzi/jAE7Ky2C9wPGMHyCu
         wC2A==
X-Gm-Message-State: AC+VfDzfZSzBZtwexuN10hfWD7Qpaiwivb+BMopFZ8W9nQ+zbcJgND1Z
        rVzYGmVYFoXpr6gkgvf2vZ8knltaj9Q=
X-Google-Smtp-Source: ACHHUZ5lZdGhExWJmy53XaOL8CP3Kym4qCRJX1yQDLyeprmX1c331qd57sQo7B6jBarqdEnLmhZTmw==
X-Received: by 2002:a05:6000:1002:b0:307:c0c4:1094 with SMTP id a2-20020a056000100200b00307c0c41094mr9338511wrx.34.1684830768540;
        Tue, 23 May 2023 01:32:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b003062675d4c9sm10192929wrf.39.2023.05.23.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:32:48 -0700 (PDT)
Message-Id: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 May 2023 08:32:47 +0000
Subject: [PATCH] cherry-pick: refuse cherry-pick sequence if index is dirty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Cherry-pick, like merge or rebase, refuses to run when there are changes
in the index. However, if a cherry-pick sequence is requested, this
refusal happens "too late": when the cherry-pick sequence has already
started, and an "--abort" or "--quit" is needed to resume normal
operation.

Normally, when an operation is "in-progress" and you want to go back to
where you were before, "--abort" is the right thing to run. If you run
"git cherry-pick --abort" in this specific situation, however, your
staged changes are destroyed as part of the abort! Generally speaking,
the abort process assumes any changes in the index are part of the
operation to be aborted.

Add an earlier check in the cherry-pick sequence process to ensure that
the index is clean, reusing the already-generalized method used for
rebase. Also add a test.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    cherry-pick: refuse cherry-pick sequence if index is dirty
    
    I encountered this data-loss bug (performing normally-safe operations
    results in loss of local staged changes) while exploring
    largely-unrelated changes as per thread
    CAPMMpogFHnX2YPA4VmffmA0pku=43CQJ8iebCOkFm4ravBVTeg@mail.gmail.com on
    "git checkout --force", and on the possibility of supporting same-commit
    switch while preserving merge metadata.
    
    I believe it is best handled as a standalone issue, it looks like a
    simple bugfix to me, hence this separate patch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1535%2FTaoK%2Ftao-cherry-pick-sequence-safety-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1535/TaoK/tao-cherry-pick-sequence-safety-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1535

 builtin/revert.c                |  2 +-
 sequencer.c                     | 14 +++++++++-----
 sequencer.h                     |  3 ++-
 t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0240ec8593b..91ebba38eaa 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -224,7 +224,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		return sequencer_rollback(the_repository, opts);
 	if (cmd == 's')
 		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	return sequencer_pick_revisions(the_repository, opts, me);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index b553b49fbb6..9abea3b97fc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3162,7 +3162,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(struct repository *r)
+static int create_seq_dir(struct repository *r, const char *requested_action)
 {
 	enum replay_action action;
 	const char *in_progress_error = NULL;
@@ -3194,6 +3194,9 @@ static int create_seq_dir(struct repository *r)
 				advise_skip ? "--skip | " : "");
 		return -1;
 	}
+	if (require_clean_work_tree(r, requested_action,
+				    _("Please commit or stash them."), 1, 1))
+		return -1;
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
@@ -5169,7 +5172,8 @@ static int single_pick(struct repository *r,
 }
 
 int sequencer_pick_revisions(struct repository *r,
-			     struct replay_opts *opts)
+			     struct replay_opts *opts,
+			     const char *action)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id oid;
@@ -5223,12 +5227,12 @@ int sequencer_pick_revisions(struct repository *r,
 
 	/*
 	 * Start a new cherry-pick/ revert sequence; but
-	 * first, make sure that an existing one isn't in
-	 * progress
+	 * first, make sure that the index is clean and that
+	 * an existing one isn't in progress.
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir(r) < 0)
+			create_seq_dir(r, action) < 0)
 		return -1;
 	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
diff --git a/sequencer.h b/sequencer.h
index 913a0f652d9..1b39325c52c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -159,7 +159,8 @@ void todo_list_filter_update_refs(struct repository *r,
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
-			     struct replay_opts *opts);
+			     struct replay_opts *opts,
+			     const char *action);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33d..e8f4138bf89 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -47,6 +47,16 @@ test_expect_success 'cherry-pick persists data on failure' '
 	test_path_is_file .git/sequencer/opts
 '
 
+test_expect_success 'cherry-pick sequence refuses to run on dirty index' '
+	pristine_detach initial &&
+	touch localindexchange &&
+	git add localindexchange &&
+	echo picking &&
+	test_must_fail git cherry-pick initial..picked &&
+	test_path_is_missing .git/sequencer &&
+	test_must_fail git cherry-pick --abort
+'
+
 test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&

base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
-- 
gitgitgadget
