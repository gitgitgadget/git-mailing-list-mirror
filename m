Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B0C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6584C22B37
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgLDOfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgLDOfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 09:35:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714BC061A51
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 06:34:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k14so5546476wrn.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GNEO+h5BZ7wo4R0xxjFCxWzlgjFWSJ+Ldrg3DBcEEcc=;
        b=JErNU+hN+txSdpWTPndHprAYlsamLUjt1Z8cO5rc2CIsvRCJ9AP5Ow1oLloQ1eqO+i
         /7VuiPIi2TidhsyFsvy2qz/1Kz82PFV8JjMznBWnLJcK9e798y2X2089qVU5excqvKPE
         /SQyzTlKti9Q9sR69pHNP7VMGoGcU2OSTpvQV2gVmXOIO/ldSTTUmrsNFWoQOSIbYIWf
         SH/Pvymp/ngoODgkrD7WsvZ2pVMt0iR7jbtxUI0jLWjr+XqL09HB3nf2i2b4IBhX/gEr
         DygNXm+eqWI9kSb6doP6QYCL2BPaHuCo/26sPHHNSmtPK1yTY6Q7cByQKAsNUD62lAXI
         5ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GNEO+h5BZ7wo4R0xxjFCxWzlgjFWSJ+Ldrg3DBcEEcc=;
        b=jRL3Y0FRuraYXz4wHIMh2eVOSVAi8RE9jIfWS1p10zEXlxP7tSQF5VvnaEZZ9yuOn9
         THiSt/47CKpKgy0UGTLsw4f3BjGp8JTVA5HMwUpXajBLaB9Nijw5xFfll3NxnruuqLms
         KGZB4o00PHJNvligaeffR9UBCyLrmfLXLjrVyTscdd8/chcIADUGmLhNQXdwSJqJyZRu
         cOD3PEZ7SschG2XVOsFrIX1//m4RSylhuAFK5te8idRMoG4Ku9tz1LNaTpRlvM73FRH4
         fzAlxsdnrKUExn23bkdf0XrKp8k7aM7BZVZVT65+UQtKT0i0888eaSrYeAroYKUWaVyg
         HtOA==
X-Gm-Message-State: AOAM531++8+d1wJbw3AagvdRCfdCB6STJf++BuGv+ERhpJNbC9qIflSt
        GXzdDPxMKGEuu/lTuQeCNiz6xej4Fwo=
X-Google-Smtp-Source: ABdhPJx9MOh4EEHsOU3kOPTywVUyWZXzi9fkME9HicwHnI7SElYMy1gmQjSOYVDCx1LpfpLAWi1BpA==
X-Received: by 2002:adf:aa4a:: with SMTP id q10mr5168885wrd.276.1607092465663;
        Fri, 04 Dec 2020 06:34:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm3306509wml.13.2020.12.04.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:34:24 -0800 (PST)
Message-Id: <7348bfdf6539a5bc73e14b475e3463e8ff83ea7a.1607092462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.1607092462.gitgitgadget@gmail.com>
References: <pull.806.git.1607092462.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 14:34:22 +0000
Subject: [PATCH 2/2] t5526: drop the prereq expecting the default branch name
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Initially, we started converting this test script in anticipation for
renaming the default branch name to `main`. To that end, we partially
converted it to accommodate for that default branch name, marking the
now-failing test cases with a prereq that was designed to be fulfilled
once the rename was complete.

However, the effort to move to the branch name `main` needs quite a bit
longer, as it was decided that we need a deprecation phase first.

To avoid keeping t5526 in limbo for such a long time, we just made it
independent of the actual default branch name used by Git. Therefore,
that prereq is no longer necessary, and we can drop it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5526-fetch-submodules.sh | 42 ++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6469120ded..a877dd145e 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -64,7 +64,7 @@ test_expect_success setup '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules recurses into submodules" '
+test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -74,7 +74,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules recurses
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "submodule.recurse option triggers recursive fetch" '
+test_expect_success "submodule.recurse option triggers recursive fetch" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -84,7 +84,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "submodule.recurse option triggers r
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "fetch --recurse-submodules -j2 has the same output behaviour" '
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -114,7 +114,7 @@ test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
+test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
 	(
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
@@ -144,7 +144,7 @@ test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
+test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
@@ -173,7 +173,7 @@ test_expect_success "--quiet propagates to parallel submodules" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--dry-run propagates to submodules" '
+test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -183,7 +183,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "--dry-run propagates to submodules"
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Without --dry-run propagates to submodules" '
+test_expect_success "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
@@ -192,7 +192,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Without --dry-run propagates to sub
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "recurseSubmodules=true propagates into submodules" '
+test_expect_success "recurseSubmodules=true propagates into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -203,7 +203,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "recurseSubmodules=true propagates i
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "--recurse-submodules overrides config in submodule" '
+test_expect_success "--recurse-submodules overrides config in submodule" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
@@ -228,7 +228,7 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when no new commits are fetched in the superproject" '
+test_expect_success "Recursion doesn't happen when no new commits are fetched in the superproject" '
 	(
 		cd downstream &&
 		(
@@ -242,7 +242,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when no ne
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodule commits are fetched" '
+test_expect_success "Recursion stops when no new submodule commits are fetched" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -258,7 +258,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodu
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new superproject commits don't change any submodules" '
+test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
@@ -275,7 +275,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new s
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submodule" '
+test_expect_success "Recursion picks up config in submodule" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules &&
@@ -304,7 +304,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submod
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules when necessary" '
+test_expect_success "Recursion picks up all submodules when necessary" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -337,7 +337,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules w
 	test_must_be_empty actual.out
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -364,7 +364,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' do
 	test_must_be_empty actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -392,7 +392,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' re
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
+test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
@@ -409,7 +409,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' st
 	test_i18ncmp expect.err.file actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' overrides global config" '
+test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -437,7 +437,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand'
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
+test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -465,7 +465,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmod
 	test_i18ncmp expect.err.2 actual.err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly recorded commits are already present" '
+test_expect_success "don't fetch submodule when newly recorded commits are already present" '
 	(
 		cd submodule &&
 		git checkout -q HEAD^^
@@ -488,7 +488,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly re
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
+test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
-- 
gitgitgadget
