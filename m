Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B1761139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbhIHJut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348690AbhIHJuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F2C0613C1
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i28so2363595wrb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIIElqaT75bZtC0UsPDOwcoFCgp4lVNvJa3bkYmTH/w=;
        b=nUSLntqp6LFKjy6AJd9AvhZQfQ1k7mTBQpjRPpeedpKZRI/q82gYn/FZohL195xUFR
         MrWYjM/y9/u/RI68IL3TBgxElXckeq5dI1Gwb8c/Lzk7sYNYRlsB6cG2myDVoQp8FcR/
         YqcjoaY0NVzyBnXqsMwXiuGiSe2w/UMsGamglKeaMvVEYxYSmBoIoZcF7tuVBx7nxNwV
         6naU9+3bIdqeRYeh4xEoKRSPZm8DxPM2VlQZ0kUGqoG+i4jHNCwDpC+ih1IrpD+Gc50n
         WkEtJtKocLwP76z0V5bpQA9dOiC5oXEShdowZTrBHDu+Gu+BDrSQJ5hihK08AMGZXD20
         KAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIIElqaT75bZtC0UsPDOwcoFCgp4lVNvJa3bkYmTH/w=;
        b=StFgZhWmbysWHp4A9aO5B7K4BnfSm8ym/7W1vx6qTncnXkbY5hje91j3JlAhMbhxk1
         F5EKH45po/Bkcq82m/vw1vAaudy756G43JOArTGRnzKszDZwf5so5tOaCJvZcnxVoPPo
         s9aPFqabG/8Og8GR5XDB3Y19xZQMGL9YsdxsgL0NbREYjuKRCUEeF8aTbx0ssAVGFkd/
         StnXWESWHjWbADYh1/lxdw7gUMeEIDmB2x+g9Ft/tmSfjp2Sbi9r6BQhGeh8SVMhYWYE
         xZMmUew9LpP0czSqPhbrrQ8t74cCaO+02YrgqbZDgMIjNGe9YBIjPOrCsuCaB6KcYEL1
         Htvw==
X-Gm-Message-State: AOAM532a60QeLJZSoeZMwE5LkbFA3+IgnG8l6KDk5UiObtou9Ndfj8Zt
        FFc7gAWnLfEHBennzPufr9tdLdFz62o=
X-Google-Smtp-Source: ABdhPJwSkYyv67AuxpAhr9NyIIrkIhGXc0Uqg7jrFnglSZ5phpFRPwJMp4ll4RBQ7Fk2o4MsAgK9lQ==
X-Received: by 2002:adf:c785:: with SMTP id l5mr3007103wrg.360.1631094567989;
        Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm1586505wmi.0.2021.09.08.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
Message-Id: <9a4f6ea73c5e9052c7105b0fc63c6d76c0d3e92e.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:18 +0000
Subject: [PATCH 07/11] t3407: rework rebase --quit tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

9512177b68 ("rebase: add --quit to cleanup rebase, leave everything
else untouched", 2016-11-12) seems to have copied the --abort tests
but added two separate tests for the two rebase backends rather than
adding a single test into the existing testrebase() function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 72cf391156d..2f41b06e028 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -86,31 +86,21 @@ testrebase() {
 		test_must_fail git rebase --abort -v &&
 		git rebase --abort
 	'
+
+	test_expect_success 'rebase$type --quit' '
+		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type main &&
+		test_path_is_dir $state_dir &&
+		head_before=$(git rev-parse HEAD) &&
+		git rebase --quit &&
+		test_cmp_rev HEAD $head_before &&
+		test_path_is_missing .git/rebase-apply
+	'
 }
 
 testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --apply --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --apply main &&
-	test_path_is_dir .git/rebase-apply &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-apply
-'
-
-test_expect_success 'rebase --merge --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --merge main &&
-	test_path_is_dir .git/rebase-merge &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-merge
-'
-
 test_done
-- 
gitgitgadget

