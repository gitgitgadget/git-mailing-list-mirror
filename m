Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E88C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A86109F
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhKBUNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhKBUNW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 16:13:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B7C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 13:10:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso2221833wmc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0B3D0MVt5XUnBVfz1RB+yowAcX4X/EWu1jCZgtEOY7k=;
        b=RjITMyFwqK1a4Ko7rStZBMXA147rnzBvBKow5igKFSpGG0vGXTIS4JpIlnZYA7yrl1
         w5WabqjOB+HyYRiTk/Jk0YWjFPv8wi95qmliv+6+P/9dbuCzomYuhaqRDc3EjyzdGI8n
         O/NRAIjEj5auUit+g7SHaTwDyzrrH7cHWidEpGwDyh6EuwKDjXZKh/Tz39ZaXoCRap8I
         IJjYvWn5QIUU/QEfbYCCUGbRE32oF4BrKgv8IjfO1F7dvnR0zYaBtqtZsPnJ1BekksB8
         9o9eOu0mFay4RwQlGTLoLZmnvLd/o6GhrtyKohVbeS6hc63hrPs6who23MYT5f9AKH5x
         T0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0B3D0MVt5XUnBVfz1RB+yowAcX4X/EWu1jCZgtEOY7k=;
        b=yGmBC+d0IzZ4SoiFN7xtST3V/X+IU12DHaIocUsMgn3nB7dCIW4dvNGOcKIZSlBHq4
         a7Y/jgBEAcKTnfOan9CCly/6iRgwRmxr2lt/xBcGrgfaWDJWWfAn1ZUFUra3LnqAJ9EE
         ScSCHNUMxvPIopchlqWQ/85BsEK/NulDMMIzPS96g5dNtd/gmSrJ7CctMksVSmN8Jx3T
         c8mNT1B3YCNdhel3INtvNGKHp6LQXO9iFx8Ex4dTwIdrPGHETKcGDmGOsU5Ja2KBAcQq
         TCI28MZFKD4gCuRHpz/8PpYK1D2PqBHEfLpdI1jRlgVHjs4Y6Ydt9L/lxGXUdoo8HC1/
         pg5Q==
X-Gm-Message-State: AOAM530bL8H8ZeLXdVHzRcjCFCCcazi555Z15v/UdRYhCJ7oAh8MJZq+
        q/CfkLGgfwM5Nj1s2avjreDFqEOIMXw=
X-Google-Smtp-Source: ABdhPJwWHLAuFQhVx3cfA1G3NhHqIixoXIpbPSXWzf6I1Eszc4+cLvIUTfzGAFUUlJzS1ct9JiBX0Q==
X-Received: by 2002:a1c:a710:: with SMTP id q16mr9971392wme.138.1635883845743;
        Tue, 02 Nov 2021 13:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm11532wmc.29.2021.11.02.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:10:45 -0700 (PDT)
Message-Id: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 20:10:44 +0000
Subject: [PATCH] rebase -i: fix rewording with --committer-date-is-author-date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
fast-forwarding, 2021-08-20) stopped reading the author script in
run_git_commit() when rewording a commit. This is normally safe
because "git commit --amend" preserves the authorship. However if the
user passes "--committer-date-is-author-date" then we need to read the
author date from the author script when rewording. Fix this regression
by tightening the check for when it is safe to skip reading the author
script.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: fix rewording with --committer-date-is-author-date
    
    This regression was introduced in the current cycle and is present in
    v2.34.0-rc0, v2.33.1 and maint
    
    Thanks to Jonas for reporting it and Peff for bisecting

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1123%2Fphillipwood%2Fwip%2Frebase-committer-date-is-author-date-fix-reword-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1123/phillipwood/wip/rebase-committer-date-is-author-date-fix-reword-v1
Pull-Request: https://github.com/git/git/pull/1123

 sequencer.c                    |  4 +++-
 t/t3436-rebase-more-options.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cd2aabf1f76..ea96837cde3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -997,7 +997,9 @@ static int run_git_commit(const char *defmsg,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
+	if (is_rebase_i(opts) &&
+	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
+	     !(!defmsg && (flags & AMEND_MSG))) &&
 	    read_env_script(&cmd.env_array)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 4d106642ba7..94671d3c465 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -82,6 +82,20 @@ test_expect_success '--committer-date-is-author-date works with merge backend' '
 	test_ctime_is_atime -1
 '
 
+test_expect_success '--committer-date-is-author-date works when rewording' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE=edited \
+			FAKE_LINES="reword 1" \
+			git rebase -i --committer-date-is-author-date HEAD^
+	) &&
+	test_write_lines edited "" >expect &&
+	git log --format="%B" -1 >actual &&
+	test_cmp expect actual &&
+	test_ctime_is_atime -1
+'
+
 test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	git checkout side &&
 	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
@@ -155,6 +169,21 @@ test_expect_success '--reset-author-date with --committer-date-is-author-date wo
 	test_atime_is_ignored -2
 '
 
+test_expect_success 'reset-author-date with --committer-date-is-author-date works when rewording' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE=edited \
+			FAKE_LINES="reword 1" \
+			git rebase -i --committer-date-is-author-date \
+				--reset-author-date HEAD^
+	) &&
+	test_write_lines edited "" >expect &&
+	git log --format="%B" -1 >actual &&
+	test_cmp expect actual &&
+	test_atime_is_ignored -1
+'
+
 test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
 		PATH="./test-bin:$PATH" git rebase -i --strategy=test \

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
gitgitgadget
