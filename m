Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF30CC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F31361BD2
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhKQH6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhKQH6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:58:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E8C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:55:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r8so2835076wra.7
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 23:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CbK5g9qoh7HufwZ7J+A2D8lJFGz1WIgd0NiyQqdOjAk=;
        b=XLkPlBTp297EX+xZvHtZjf0NJnbzzP8t/QFE7NN3XnvMAV1/nP4FRA5Pmc2mHvPRdr
         JbGTQmkW/RUnKvCgqE+EczUBUQsW1lrp6lrEo2pQxde62MJ8d5D/LLmXwxrLzDpywJcm
         i2wDui2I1Oynwx17EbRjgUlvpJnQA3Qz265lC0vE3Y5h9GjEG1/b4k0l1XiCFWdxPlis
         TLbleQ6IYFHMqMCoWFyQ8NIHBWaHwgjnnGEbFd5JcmKDGieGWvOIe8QShOiSJGPy5fQm
         +3Wib/z+0nIFNxwX2FMtHw8x3xlz7JQaWXgdP2b4X1b8oPkND+dNYVKKY0Vlt9N+Hp7W
         fu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CbK5g9qoh7HufwZ7J+A2D8lJFGz1WIgd0NiyQqdOjAk=;
        b=GPAhjHMdv/0/8KQq004UANJGDC+sMQhBQPdgnN+kSVj3jVxooElyPbHcDtM6N20XXl
         fIYLB/M8bjNJ9NiDzlvOXeg05+i18p3RldS55przVQ0HrE3yzWkgtZg4Npk2WdzDwEhu
         CsN5dSlRMZPK+YbppqXYzWdglyMq26EWOBR3rv5MRltwe3XO1SlXMTPfENm0PFj16FNW
         Z24Jtzfyrw+VnJFteF88Wez9z3qEceUS90guHv0lS1ydzNX53NhnwsK0ehEG6pphsa4d
         VaosZqS6VWpD0OAENmTxeGvM0XK4r6nc6bjjgxuGWCKP+cOYHgjYWLwfVM/JnQMuH7Uc
         +xjw==
X-Gm-Message-State: AOAM532p84HBikV3C5aTlB1NJMNPwk7eRhT33myxApygKEuI+VjFjtXd
        Jk7hvntvyiqGVlZc3T65eBXX6IseErY=
X-Google-Smtp-Source: ABdhPJzn3HwZBKA3Zbj9yOdiMzcQnmQM+kOzqC6JzrYm9vnxlyiacGfskEW34wij7E54Bms1K90ysA==
X-Received: by 2002:adf:e0d0:: with SMTP id m16mr17429638wri.74.1637135751694;
        Tue, 16 Nov 2021 23:55:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm4542456wme.39.2021.11.16.23.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 23:55:51 -0800 (PST)
Message-Id: <pull.1078.git.1637135750674.gitgitgadget@gmail.com>
From:   "Erwin Villejo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 07:55:50 +0000
Subject: [PATCH] pull: should be noop when already-up-to-date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erwin Villejo <erwinvillejo@gmail.com>,
        Erwin Villejo <erwin.villejo@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Erwin Villejo <erwin.villejo@gmail.com>

The already-up-to-date pull bug was fixed for --ff-only but it did not
include the case where --ff or --ff-only are not specified. This updates
the --ff-only fix to include the case where --ff or --ff-only are not
specified in command line flags or config.

Signed-off-by: Erwin Villejo <erwin.villejo@gmail.com>
---
    pull: should be noop when already-up-to-date
    
    The already-up-to-date pull bug was fixed for --ff-only but it did not
    include the case where --ff or --ff-only are not specified. This updates
    the --ff-only fix to include the case where --ff or --ff-only are not
    specified in command line flags or config.
    
    Signed-off-by: Erwin Villejo erwin.villejo@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1078%2Ferwinv%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1078/erwinv/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1078

 builtin/pull.c               | 6 ++++--
 t/t7601-merge-pull-config.sh | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 127798ba84e..1cfaf9f3436 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -988,6 +988,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int rebase_unspecified = 0;
 	int can_ff;
+	int divergent;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1102,15 +1103,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	}
 
 	can_ff = get_can_ff(&orig_head, &merge_heads);
+	divergent = !can_ff && !already_up_to_date(&orig_head, &merge_heads);
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-		if (!can_ff && !already_up_to_date(&orig_head, &merge_heads))
+		if (divergent)
 			die_ff_impossible();
 		opt_rebase = REBASE_FALSE;
 	}
 	/* If no action specified and we can't fast forward, then warn. */
-	if (!opt_ff && rebase_unspecified && !can_ff) {
+	if (!opt_ff && rebase_unspecified && divergent) {
 		show_advice_pull_non_ff();
 		die(_("Need to specify how to reconcile divergent branches."));
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6275641b9c2..bd238d89b0c 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -387,6 +387,12 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	test_must_fail git pull . c3
 '
 
+test_expect_success 'already-up-to-date pull succeeds with unspecified pull.ff' '
+	git reset --hard c1 &&
+	git pull . c0 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
 test_expect_success 'already-up-to-date pull succeeds with "only" in pull.ff' '
 	git reset --hard c1 &&
 	test_config pull.ff only &&

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
