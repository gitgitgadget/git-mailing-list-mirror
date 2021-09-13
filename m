Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5830D60F6F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbhIMPqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbhIMPql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F0C0A888E
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so15333196wrb.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=KILqnKFr0k3/kfbHWOUlDkAkmvfpXkodyJap6OXwD0B/6ywIJ0Q4DMKoCGV2gLGbly
         VfU8iXbEPXbkr2C/l4L/bwbmlN929+HxK+3NNljzdjVl3wfpBv61arzJpZxN8jsx80tq
         n+hqKgeasKLQDXx/VaJ8BWXTfV1uKdfYE2U7n72VVUwJtetqicStp6q3V8h55sYLxZqa
         fKTu411BkkLZy7SgAdWlsXpxTafZgcxuL9jg3dJd01eOzhC/3ECaBkQYFoLfqJmm4y4m
         Ei4+qLo0PShNkHJ0olsiFYpdSSRbZ8saYn5rZ7qbkHghUx4kuWzZ2RR5sc60UTMDceyI
         /UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=5s9LEQ5xGMlZw2TfyAX+JZWCoaCUwzL4zUjOtxRLHuzNAxXx3wbNacw/iF7IWI+2VI
         /IlgVxDqTI3f/39g6Jkz1KiosXUXdeipOUc5BSpwLl59Q++CsVqJp1hH57/MdSqhHTqh
         ocUNPLYeNnlqpB0In8DqpENtgpuh1PU859cJ8ClzMax1pJjzObmV6ycncCkfs90FRnQe
         KqSUbo3HN2XeNIQEihNAkZH9yGQTXO8UB4Kw1NRXeuvbZ3m3NVGaJPzYRWLoOfW2joKq
         7aqb9zCu37eHdhsfVZ09g2/7AkgJ1CN04mC9at/KX+9848ojT5e94xLzZjveX4Y6bKnh
         rVGg==
X-Gm-Message-State: AOAM532bem45UeQ81zSkknkTLwBpLBhrj9+KZfa/fcDr5AuKFrBGKZaK
        LiLYwF1RndQ7zJ+ARVkpx9sZBI3/xOM=
X-Google-Smtp-Source: ABdhPJzuDsgo3p1jexZCEuiblC0xO+qfASIc5cEy1M6JIDSMduh4E8DqHlXxSQr7YIg0fz9R395Bhg==
X-Received: by 2002:adf:d084:: with SMTP id y4mr7885529wrh.249.1631546364806;
        Mon, 13 Sep 2021 08:19:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm3788570wms.18.2021.09.13.08.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:24 -0700 (PDT)
Message-Id: <bac009d8543acdd85574c85a3e659dba541c4d0e.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:12 +0000
Subject: [PATCH v2 01/11] t3407: run tests in $TEST_DIRECTORY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 97b88dd58c ("git-rebase.sh: Fix --merge --abort failures when
path contains whitespace", 2008-05-04) started running these tests in
a subdirectory with a space in its name. At that time $TEST_DIRECTORY
did not contain a space but shortly after in 4a7aaccd83 ("Rename the
test trash directory to contain spaces.", 2008-05-04) $TEST_DIRECTORY
was changed to contain a space so we no longer need to run these tests
in a subdirectory.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 7c381fbc89a..c747bd31d76 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -7,13 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-### Test that we handle space characters properly
-work_dir="$(pwd)/test dir"
-
 test_expect_success setup '
-	mkdir -p "$work_dir" &&
-	cd "$work_dir" &&
-	git init &&
 	echo a > a &&
 	git add a &&
 	git commit -m a &&
@@ -37,7 +31,6 @@ testrebase() {
 	dotest=$2
 
 	test_expect_success "rebase$type --abort" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -48,7 +41,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -61,7 +53,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -77,7 +68,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		git reflog show to-rebase > reflog_before &&
@@ -89,7 +79,6 @@ testrebase() {
 	'
 
 	test_expect_success 'rebase --abort can not be used with other options' '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -103,7 +92,6 @@ testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
 test_expect_success 'rebase --apply --quit' '
-	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase --apply main &&
@@ -115,7 +103,6 @@ test_expect_success 'rebase --apply --quit' '
 '
 
 test_expect_success 'rebase --merge --quit' '
-	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase --merge main &&
-- 
gitgitgadget

