Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B04C63682
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiAYXg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiAYXgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 18:36:17 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417DC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:36:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s5-20020a635245000000b0034ea48b7094so6929639pgl.12
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yCjauxtByOSZ2UgErvJcIale67Ha/6hVF1NRwbg4b6k=;
        b=khR6gTmnr6B5nmj61xn51QyVB0S8xdSwVgBUtPTe0KgOzq9VhfvFQdfp4JS60XtcIF
         BoVg7PgYweyfVLbqyLjP/qPLRIyy350i9/1W+DkOZUwHlXMGAZXJPcvTrWn4HSKL1TC1
         totsGWUwmpEkwh5zIDn5JQAr4DI5VDCis3/aTpJH00zFfNen61K2tEax0Q/3wTcmDPsE
         SX2NaHjgQ9B1Ep1RoJzqUJBNCeo8cLQUDPPbotm6mU0A8Bta7PcuJZaVp0izwxcP54hx
         0j7yYxv7IXVoQTmF009EFQFsu8deVB00KVtYYaXk7/gyaojcuqxLwfjGq+EFqIqnJyuX
         T+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yCjauxtByOSZ2UgErvJcIale67Ha/6hVF1NRwbg4b6k=;
        b=6HyDEa0bbgeAkyZs2pDoksUgKKuNymKORa+9YSv3mNivwz79nD+iNVdkwt8T+ylKCD
         gpzrFPD8bmVrStqfsfWqxqF1Vy6fhaYsmpkZ+FZimZ/B0kCn3dhAHtQIoG1SHHqKYrB2
         MZrN6cV7TED7JTgxwvUW4jfLYR9uShqytSX+lh26pZ7nFXOHET3HdKUkIilpTG3EMcJi
         91PQD5MhbZzLC/k53ji5CQtEMvIeuRQODwwrcgeiH3Tyx8Arzxc6Hgxj51s2J7wO6WmA
         RESuKp1WwAOCujC/RUy6uKCB7m23MXmgAXjL0+rMX4h5sUHxEyKSjC1031i77OzSUKrs
         rVTg==
X-Gm-Message-State: AOAM531kfy6Mp5XpuLzCBYHGoh/wF9sEFF8dJO+isEs53vEJOhKlBWDX
        sTq7ZvGRiEW8LRBAhz6BgBpOvDeXKomlBgknm6W9JAeqNHnY+xHF+8ThVvh43T74QecKQpf8Iq3
        F4tOviFEYOxDemdpXxuGcp3z8aMyxOX6k1o+caiFnT+1xC9f2X4pqe/xiFkY5iKw=
X-Google-Smtp-Source: ABdhPJwp/3A2z4ixgvPZIZP4MGXZ7GgAsBSgjwcB9FlKf3cND63CdB+W2JTEYQX7X1S9E4KpRrNC2dc6sg9bMg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:300c:: with SMTP id
 hg12mr5919171pjb.118.1643153776915; Tue, 25 Jan 2022 15:36:16 -0800 (PST)
Date:   Tue, 25 Jan 2022 15:36:12 -0800
Message-Id: <20220125233612.46831-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] sequencer.c: set GIT_WORK_TREE in run_git_checkout
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing in a subdirectory of a worktree, Git fails due to a dirty
worktree:

  error: The following untracked working tree files would be overwritten
by merge:
          a/b/c
  Please move or remove them before you merge.

This occurs because "git rebase" invokes a "git checkout" without
propagating the GIT_WORK_TREE environment variable, causing the worktree
to be assumed to be ".". This was not an issue until bc3ae46b42 (rebase:
do not attempt to remove startup_info->original_cwd, 2021-12-09), when
the .dir of the "git checkout" child process was changed such that it no
longer runs at the root of the worktree.

Propagate GIT_WORK_TREE to the "git checkout" child process and test
that rebase in a subdirectory of a worktree succeeds.

Signed-off-by: Glen Choo <chooglen@google.com>
---
Here is a fix for the bug I found in [1]. I didn't look through the rest
of the "preserve cwd" thread for other possible bugs pertaining to
worktrees, but I didn't find any during a cursory glance at sequencer.c.

I'm also not sure if this is the idiomatic way to do it since, I assume,
we'd always want to propagate GIT_WORK_TREE, but this is identical to
how do_exec() sets GIT_WORK_TREE in the same file (perhaps this is
something that should be refactored).

[1] https://lore.kernel.org/git/kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com

 sequencer.c       |  2 ++
 t/t3400-rebase.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 83f257e7fa..e193dcf846 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4233,6 +4233,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+	strvec_pushf(&cmd.env_array, "GIT_WORK_TREE=%s",
+		     absolute_path(get_git_work_tree()));
 
 	if (opts->verbose)
 		ret = run_command(&cmd);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 23dbd3c82e..8b8b66538b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -416,4 +416,33 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
 	mv actual_logs .git/logs
 '
 
+test_expect_success 'rebase when inside worktree subdirectory' '
+	git init main-wt &&
+	(
+		cd main-wt &&
+		git commit --allow-empty -m "initial" &&
+		# create commit with foo/bar/baz
+		mkdir -p foo/bar &&
+		touch foo/bar/baz &&
+		git add foo/bar/baz &&
+		git commit -m "add foo/bar/baz" &&
+		# create commit with a/b/c
+		mkdir -p a/b &&
+		touch a/b/c &&
+		git add a/b/c &&
+		git commit -m "add a/b/c" &&
+		# create another branch for our other worktree
+		git branch other &&
+		git worktree add ../other-wt other &&
+		(
+			cd ../other-wt &&
+			mkdir -p random/dir &&
+			(
+				cd random/dir &&
+				git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
+			)
+		)
+	)
+'
+
 test_done

base-commit: bc3ae46b420f58dfe2bfd87714dca096a043d554
-- 
2.33.GIT

