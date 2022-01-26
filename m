Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469AC3525A
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 01:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiAZBnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiAZBnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 20:43:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940EC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:43:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so3161211wmr.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DLu86u902vAAAzqhPWks1/Vx+46br8NboLn6h05mL3c=;
        b=d5q1UZ5G4qusXMGbEGZuYFQeZQ2emqYC71/m+e9dgRQKZl3pdlkIkanRS2+wGukhxH
         SyHlhHVWpGPiwz0TwRdDBHKTQkMGqOggJYxpuHrr2kmMkmrxFKa+EhIGjNwRCV9yoCUF
         lTTgyeQaZBO7NU0C/C5Q5pJDu51hDkot8ZDtsQroyoq9CuDyftmk3C1y9dYCEMZYBSoo
         w2ziHj2TUm/8lnDhGWYp1IJW5ZSQS5f45VgGBBM0xtEV/KaWOv/GjOiszAgndzIZIwfm
         iZFcMJjOsoxQCKzUHMN/gWJ25KP9Z9kAwfbhZbQbznhhAOPiFDcEltXxZ971MAflXEMc
         MHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DLu86u902vAAAzqhPWks1/Vx+46br8NboLn6h05mL3c=;
        b=ldBbnJ0CTibeUPnvjH22Ey2hAvUQXUb3FMUUIx8swEUUNASzud8Rd8jACi+w3IAy1m
         qA4v9VOZ+mjLtHxAkUu/Xf/1vFItrW17N3heXvDTfPN9bqUTRCg7jfy7f5l212oayXeC
         NLGGV04GrpA02+9Ar8rrP2Dm6kwOS4n1rVBTGERb6vI4bmkUEb72eli0+3T+qcMFflDK
         1nY5FO1/leVAUxmqQ/Ar5xnOtyk8I9gYyPuyOIIqrYOc4Mm3F8FT00a36qBId0lrjQpL
         dJgIeIb4pMHYc19VLfcEqDcjSbERezeAO3l+xCWHR86sixc7NxztHjHg+t2X2/2dqsIg
         gWIA==
X-Gm-Message-State: AOAM533uQ6XNPmri8G936yKfg8J/KE1niM84IPtzKdwgPBFytVtziHUs
        8ppkOqIXVuSH6NYBnDHPrR84Cr6n8Oo=
X-Google-Smtp-Source: ABdhPJxNOubrEKIuqMjgX+fYJDNfBKrw376o9jXJxkCbz+WngKgWemMpccHUIIh5bnW8qHOtKSoPvA==
X-Received: by 2002:a05:600c:1911:: with SMTP id j17mr5051002wmq.143.1643161427082;
        Tue, 25 Jan 2022 17:43:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm8369914wrs.55.2022.01.25.17.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:43:46 -0800 (PST)
Message-Id: <pull.1205.git.git.1643161426138.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 01:43:45 +0000
Subject: [PATCH] sequencer, stash: fix running from worktree subdir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commits bc3ae46b42 ("rebase: do not attempt to remove
startup_info->original_cwd", 2021-12-09) and 0fce211ccc ("stash: do not
attempt to remove startup_info->original_cwd", 2021-12-09), we wanted to
allow the subprocess to know which directory the parent process was
running from, so that the subprocess could protect it.  However...

When run from a non-main worktree, setup_git_directory() will note
that the discovered git directory
(/PATH/TO/.git/worktree/non-main-worktree) does not match
DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
decide to set GIT_DIR in the environment.  This matters because...

Whenever git is run with the GIT_DIR environment variable set, and
GIT_WORK_TREE not set, it presumes that '.' is the working tree.  So...

This combination results in the subcommand being very confused about
the working tree.  Fix it by also setting the GIT_WORK_TREE environment
variable along with setting cmd.dir.

A possibly more involved fix we could consider for later would be to
make setup.c set GIT_WORK_TREE whenever (a) it discovers both the git
directory and the working tree and (b) it decides to set GIT_DIR in the
environment.  I did not attempt that here as such would be too big of a
change for a 2.35.1 release.

Test-case-by: Glen Choo <chooglen@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    [2.35 regression] sequencer, stash: fix running from worktree subdir
    
    Sorry for the regression in Git 2.35; thanks for the report Glen (and
    Eric for feedback on earlier patches we've been bouncing back and forth
    that I've incorporated here)
    
    Previous discussion thread starting over here:
    https://lore.kernel.org/git/kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1205%2Fnewren%2Ffix-rebase-subdir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1205/newren/fix-rebase-subdir-v1
Pull-Request: https://github.com/git/git/pull/1205

 builtin/stash.c   |  6 +++++-
 sequencer.c       |  5 ++++-
 t/t3400-rebase.sh | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1ef2017c595..86cd0b456e7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1539,8 +1539,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			if (startup_info->original_cwd)
+			if (startup_info->original_cwd) {
 				cp.dir = startup_info->original_cwd;
+				strvec_pushf(&cp.env_array, "%s=%s",
+					     GIT_WORK_TREE_ENVIRONMENT,
+					     the_repository->worktree);
+			}
 			strvec_pushl(&cp.args, "clean", "--force",
 				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
diff --git a/sequencer.c b/sequencer.c
index 6abd72160cc..5213d16e971 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4223,8 +4223,11 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
-	if (startup_info->original_cwd)
+	if (startup_info->original_cwd) {
 		cmd.dir = startup_info->original_cwd;
+		strvec_pushf(&cmd.env_array, "%s=%s",
+			     GIT_WORK_TREE_ENVIRONMENT, r->worktree);
+	}
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 23dbd3c82ed..71b1735e1dd 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -416,4 +416,25 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
 	mv actual_logs .git/logs
 '
 
+test_expect_success 'rebase when inside worktree subdirectory' '
+	git init main-wt &&
+	(
+		cd main-wt &&
+		git commit --allow-empty -m "initial" &&
+		mkdir -p foo/bar &&
+		test_commit foo/bar/baz &&
+		mkdir -p a/b &&
+		test_commit a/b/c &&
+		# create another branch for our other worktree
+		git branch other &&
+		git worktree add ../other-wt other &&
+		cd ../other-wt &&
+		# create and cd into a subdirectory
+		mkdir -p random/dir &&
+		cd random/dir &&
+		# now do the rebase
+		git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
+	)
+'
+
 test_done

base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
-- 
gitgitgadget
