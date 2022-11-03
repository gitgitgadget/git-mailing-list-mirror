Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70378C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiKCRHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCRHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91005B33
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud5so7061755ejc.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++XSRk1Gw/BEUto/AOlmnAUYFWHlRBu5YR9VIHXyRfg=;
        b=XW5Tdd3e6e2tXeTub43TR/0iIfTdFh9TSA+Dgtavp7Q2U5uIclaZ61LDzjitBybxoI
         T+4KHV34HXK4UzFFUMNRH7rEZW5Al82bgsLlARZXmUr24yLnLiuqJDN9KdcnwzQPP1fO
         6d95pp92RG6q0blmr4CVnQ3Aly8vIy/XiAdCjZpZPIyJyq1CZi5Ca1y7FPqFetaosCHG
         RR9q0f2791NfW+B8jsja01j+KeDD/n9DNdpUefGgtyBJwk0N5dtu7qSsTb/ts3pMvv4o
         XvtmJ2oRaWfgYjdZHHVja+qOkkCcxFliR1+/1G1X3F3/Qg/M9flP3tjeajTVCVamRHC7
         AsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++XSRk1Gw/BEUto/AOlmnAUYFWHlRBu5YR9VIHXyRfg=;
        b=EzVnQ9wWzOwDcEig62txP2uPqjDInnEl5aWhRGTkNityJKXMHjkTa6nzNlLXOIX41G
         BuhVHMGMZXRXUW/ws4UGTOjx2x9uEd8Ky6CF6Ob9J2vAhQhLqA8n3jS0QC3xBx6JYpWP
         Crd7XT5Mr+nuKJu6sm+P6ss3UZ0TJ9EQDMh1IV745FaiAW9HiWPf8+Qf6qmIUxrDmuVl
         lC7MAnQ+T1foHDSjjmXelYUeexo1kJdkYkiQBtTPk8LTUndRo/Yfd2WpDMYmWSQj6fQ/
         nBuz5KFoLJORpx7yr1UQj1Sm+W6/4wSvwIrYeOZM4kXUcPPxXhs6GasRgisH38w84nd4
         Yckw==
X-Gm-Message-State: ACrzQf1O36kq3X/lJ1Nqcfkk89HdtXXfZ/QbysQI2vBrEhAjbqerquar
        w9sSMhE0V3p5udk0QrKs1Af5cP7lVp9oYw==
X-Google-Smtp-Source: AMsMyM4xn7YIU4Wt//95/+v1MtN5V6RH06YlxJbwU36rj/k7SuNr3KVZhPZoP04iZzw5JgxXr/5Ppw==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr30490595ejb.438.1667495190812;
        Thu, 03 Nov 2022 10:06:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/17] sequencer.c: fix a pick_commits() leak
Date:   Thu,  3 Nov 2022 18:06:11 +0100
Message-Id: <patch-12.17-7429151b5c4-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak introduced in 1f6965f994f (sequencer: honor
GIT_REFLOG_ACTION, 2020-04-07), we should free() the xstrdup()'d
"prev_reflog_action" string.

We only needed to xstrdup() the previous action if we took this branch
within the "while" statement, and needed to set the GIT_REFLOG_ACTION
for the duration of the do_pick_commit(). Let's just query and restore
it there instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c                              | 9 ++++++---
 t/t2012-checkout-last.sh                 | 1 +
 t/t3409-rebase-environ.sh                | 1 +
 t/t3413-rebase-hook.sh                   | 1 +
 t/t3433-rebase-across-mode-change.sh     | 1 +
 t/t7504-commit-msg-hook.sh               | 1 +
 t/t9115-git-svn-dcommit-funky-renames.sh | 1 -
 t/t9146-git-svn-empty-dirs.sh            | 1 -
 t/t9160-git-svn-preserve-empty-dirs.sh   | 1 -
 9 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 07d7062bfb8..14ca0af2ade 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4567,11 +4567,9 @@ static int pick_commits(struct repository *r,
 			struct replay_opts *opts)
 {
 	int res = 0, reschedule = 0;
-	char *prev_reflog_action;
 
 	/* Note that 0 for 3rd parameter of setenv means set only if not set */
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
@@ -4618,15 +4616,20 @@ static int pick_commits(struct repository *r,
 			}
 		}
 		if (item->command <= TODO_SQUASH) {
-			if (is_rebase_i(opts))
+			char *prev_reflog_action = NULL;
+
+			if (is_rebase_i(opts)) {
+				prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
 				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
+			}
 			res = do_pick_commit(r, item, opts,
 					     is_final_fixup(todo_list),
 					     &check_todo);
 			if (is_rebase_i(opts))
 				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
+			free(prev_reflog_action);
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
 				advise(_(rescheduled_advice),
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 1f6c4ed0428..4b6372f4c3e 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -5,6 +5,7 @@ test_description='checkout can switch to last branch and merge base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
index 83ffb39d9ff..acaf5558dbe 100755
--- a/t/t3409-rebase-environ.sh
+++ b/t/t3409-rebase-environ.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase interactive environment'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 9fab0d779bb..e8456831e8b 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -5,6 +5,7 @@ test_description='git rebase with its hook(s)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
index 05df964670f..c8172b08522 100755
--- a/t/t3433-rebase-across-mode-change.sh
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase across mode change'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index a39de8c1126..07ca46fb0d5 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -5,6 +5,7 @@ test_description='commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'with no hook' '
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 419f055721d..743fbe1fe46 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn dcommit can commit renames of files with ugly names'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' '
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 79c26ed69c1..09606f1b3cf 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -4,7 +4,6 @@
 
 test_description='git svn creates empty directories'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 9cf7a1427ab..36c6b1a12ff 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -9,7 +9,6 @@ This test uses git to clone a Subversion repository that contains empty
 directories, and checks that corresponding directories are created in the
 local Git repository with placeholder files.'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 GIT_REPO=git-svn-repo
-- 
2.38.0.1451.g86b35f4140a

