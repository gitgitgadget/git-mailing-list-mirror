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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D1C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E26F60E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhIUKZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhIUKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E3C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q26so37544168wrc.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=K395Tg/ZzaGuw9r2vvuaohqZ3l8QH7NNV7zrKCc93e2zgeP7/xu91Vfh1riU5Y1aaC
         LwGgeX9x+KYAuQCUOgP3v44uXfdB3DEhwqY8NOxLL/AzHI3CuWzl1gD69+s3d8HKmFM4
         YMdu7t4LbFBd4QCCn+Xhmpt1J9SQmYlLp1gNfT85JN6xgtX4sTNFmlAXRRqeG58MUyJC
         cAwaHySZBasLq41vHN0NGbUmg6+7icIqKpbaMUHD/RF2kXO7QTGUWFoCArv1iiUUzW2J
         u0KMLCXlrZ2TwkOQET8pvS6wgfMHPtgX00KuvoNZUGFJXo0ddFM0yxp9iFQFLBerFQBe
         QRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=hpzZsUB1BMB6VkC9EY14u3ZjwiG2dZm4Y7U2cbbUnqG7mYaG60rHHdXy2s44R5m++9
         1QPunW5sAq92Bcl+2wZ6zxO8FcdqGmEy8iKIej4YvsJiEhMBvOFANpcdlU22SMZbT2Tn
         QqnYVKAkBALDpn+jCr3iDm6JwSGtSm2N6mE6BhTwMGgnUv5Tm8LDe463+8G4R0oA1hrB
         zLPuLMApzBx2gZhLeruilC34/Xo6t3flf8YJtxux7Sanfod+0txXXEX35bxRaA9Lz3di
         RIhlhoTwy8Smsf38645yZYmA/4GrE/xXcd049fH1LOJQPzoWZQIDddMjb4ri9rT7wV0T
         yw6Q==
X-Gm-Message-State: AOAM533pH36RUZz+RyTFe3Arxmga0YeVVGWpBTQ+jjuiFVAqio+9wKFo
        VVwhEIx/CcIo83OrNfTPrKMusSCTDew=
X-Google-Smtp-Source: ABdhPJw6ti7bQSG88/AN752mjWbYSyfEmU8rAzY7GsBa4VWcDnKoUSxWIkI+9GwcxIObbMY392h/LQ==
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr3703002wmc.101.1632219850110;
        Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm2221670wmc.46.2021.09.21.03.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:09 -0700 (PDT)
Message-Id: <bac009d8543acdd85574c85a3e659dba541c4d0e.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:23:58 +0000
Subject: [PATCH v3 01/10] t3407: run tests in $TEST_DIRECTORY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
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

