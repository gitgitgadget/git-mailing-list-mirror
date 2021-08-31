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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B873C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3066861004
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhHaDEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 23:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhHaDEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 23:04:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 20:03:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso1018372wmj.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 20:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZLjkRCJxXo/LBXfInyhOE1tE/HRZAsx9u3j4ZS2WdO8=;
        b=MwRfl82ui6iKtKL3URwFkC2OYLi7JOaqm/QE2Up1Vv07Um2Mx+4PcASX0Dzj9NmNTD
         PIiSFmmYKMD6nUue9xQuCBGEjZtwG/VCZOnHZaGOvzj/gOEVvBgD+MPEk494D5fvPg5H
         sLRdimWwhFIj81KIaV5ztSWhoxyAA4F17PJyp6O70KarnXC4x8AMO/9cGsVpELqzMfQp
         mtjlUfoFAARHOSdajs4QNB9Cj1Upnaeg8m1VAC6ZvxTy5kt33JgbzgFxMMdadCDYMJ9M
         P2aXN1q2oLu4FfLJ2NwL5A2MqxfFQ9OSyMoaKjguxKOk5x9IscAKziRmbfbQKDcM3hJp
         dfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZLjkRCJxXo/LBXfInyhOE1tE/HRZAsx9u3j4ZS2WdO8=;
        b=VBgQWaXsObpzEYU/C91DC5qX3FpeD4JMGEhLNslR9aOAlT1QCGlA0QnFEOeWhQu8jf
         Z5eWBeX0nOX92KHt/U2weWHeh8KY6ofNLvl9pbidDmW84E701fKIFCwUOcmn89+vaBoy
         ODaUIJmD9vh5v+DMG+++AUoHi9hi6mq1F5AaYVZP1u9OHbsBzaHRubMA9owrnG/h4NqV
         /2nVqH+4WwDkEdKdN0Kqo4BC6RHd0XlMrUCNUuXgBfBY/NTYN4ICO7J077oegSfp3lOJ
         TJBAW7FEjsmeb8I3r0Cric/Jb5iJX6Jnp/QSiM+1DBbP5hLA6Xt552pkHjTQ3+RqzQ9Z
         59MQ==
X-Gm-Message-State: AOAM530H+qgkZG6L417UyymPVnWyNdC5q5gde/ajINxGbpXTlaBFhXqg
        ZUZ1OAhFaHSVgCNbXnbWA6sGxX2838w=
X-Google-Smtp-Source: ABdhPJwQaB/RP08/n2+PLrfMT4QxFCwc7Yq+YXUUXHuNa7+fb69QjeJatpV7EOVeEEMBxE8ktkQ/Gw==
X-Received: by 2002:a05:600c:8a4:: with SMTP id l36mr1770075wmp.128.1630379031953;
        Mon, 30 Aug 2021 20:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm1147984wmj.34.2021.08.30.20.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:03:51 -0700 (PDT)
Message-Id: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 03:03:50 +0000
Subject: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Allowing rebase, cherry-pick and revert to run from subdirectories
inevitably leads to eventual user confusion.  For example, if they
are within a directory that was created by one of the patches being
rebased, then the rebase operation could hit a conflict before the
directory is restored leading the user to be running from a directory
that no longer exists.  Similarly with cherry-pick and revert, those
operations could result in the directory being removed.

Similar to bisect, simply require that these commands be run from the
toplevel to avoid such problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    rebase, cherry-pick, revert: only run from toplevel
    
    Allowing rebase, cherry-pick and revert to run from subdirectories
    inevitably leads to eventual user confusion. For example, if they are
    within a directory that was created by one of the patches being rebased,
    then the rebase operation could hit a conflict before the directory is
    restored leading the user to be running from a directory that no longer
    exists. Similarly with cherry-pick and revert, those operations could
    result in the directory being removed.
    
    Similar to bisect, simply require that these commands be run from the
    toplevel to avoid such problems.
    
    Signed-off-by: Elijah Newren newren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1083%2Fnewren%2Ftoplevel-sequencing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1083/newren/toplevel-sequencing-v1
Pull-Request: https://github.com/git/git/pull/1083

 builtin/rebase.c              |  3 +++
 builtin/revert.c              |  6 ++++++
 t/t3404-rebase-interactive.sh | 22 ----------------------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c284a7ace19..7100f0627f6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1430,6 +1430,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (prefix)
+		die(_("You need to run this command from the toplevel of the working tree."));
+
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4c..9a150dcbdaf 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -230,6 +230,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
+	if (prefix)
+		die(_("You need to run this command from the toplevel of the working tree."));
+
 	opts.action = REPLAY_REVERT;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
@@ -243,6 +246,9 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
+	if (prefix)
+		die(_("You need to run this command from the toplevel of the working tree."));
+
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf9528..dd1afb97fca 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -112,28 +112,6 @@ test_expect_success 'rebase -i with the exec command' '
 	rm -f touch-*
 '
 
-test_expect_success 'rebase -i with the exec command runs from tree root' '
-	git checkout primary &&
-	mkdir subdir && (cd subdir &&
-	set_fake_editor &&
-	FAKE_LINES="1 exec_>touch-subdir" \
-		git rebase -i HEAD^
-	) &&
-	test_path_is_file touch-subdir &&
-	rm -fr subdir
-'
-
-test_expect_success 'rebase -i with exec allows git commands in subdirs' '
-	test_when_finished "rm -rf subdir" &&
-	test_when_finished "git rebase --abort ||:" &&
-	git checkout primary &&
-	mkdir subdir && (cd subdir &&
-	set_fake_editor &&
-	FAKE_LINES="1 x_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
-		git rebase -i HEAD^
-	)
-'
-
 test_expect_success 'rebase -i sets work tree properly' '
 	test_when_finished "rm -rf subdir" &&
 	test_when_finished "test_might_fail git rebase --abort" &&

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
gitgitgadget
