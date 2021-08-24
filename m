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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B55C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD21613CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhHXVyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbhHXVxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08CC0617A8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h4so3170317wro.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nr451am8hUX80HW6CptFuPbQfrGQFS6G9xt954TY6Qk=;
        b=dtlD4XCHa1YddpqJqvLRDhZ04L18MHTL55GzYqkIlYq5/+/BOd7WHXMBjsVA3AV38r
         YH1XR7xNXytHOjGjVEr4ae0hkpmNMaJ58GK5q7ArqSTfK//qlSvNnGJPl7gIN1rTrp6s
         APG6aCtTVyYhcpJicHsGMc2MyUNB8Jox6m+7153lrfhNX9oquOhtcubqU/69GBqvDbw6
         VEJ5/gh5MnnfqD3kSy65hXrBhjLlNoyCVSCuUKYIDHebX8wIqyKP+BIfTbUVHIJWLBF9
         J1DLjnG+SVhO4zz4zd/A1PoJUM+WojuqS5CZXMOUNkUzsF+VOBiadY/FH3ibCMS2SdAF
         VQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nr451am8hUX80HW6CptFuPbQfrGQFS6G9xt954TY6Qk=;
        b=EBFSesSF4r7yTaE+1idBdcJRa1vKjXQT62Htxsm5ZnTl1GjVzwTDPabdfM77fQEdso
         MYiXKPsnhjDvcamLsnDw9rKwSHszqUlPUzpONxMH0BzsmZXiTlOahypcwolFvm4FMgii
         VU/DvIb1ocW1zsmavSJyIXQPchFQhp+lLR9wgAC1aX13nwUVRMs2IVYnzU+l0dbXKE2+
         zDxXHIH/DgOIB3tHhajo1kxnxszG+PREh6ybTMx2cYlDiWc8JOhGuXoCKQPUs4A8Ah8i
         fYHm5uv9Rrvn/aCGsR4sAVHrnXfd4EYoQfF9qbQsruAXSsZ9rIUQrhSnpQLMgTiPOXXD
         pqTg==
X-Gm-Message-State: AOAM533NxiJABUY/wdAPVtJPacTGUAcLubyAr6GKdKup8rGxELZe4aL9
        JiZmb1VL4C+6uw5jjJqSfd7SjncqRnc=
X-Google-Smtp-Source: ABdhPJwsPxXPlkbYrfVvCF+TMGoFzof+byyNwll9vwPOYc2lO8qkMMcNhwul3sjUFNZU1tkNpniT6g==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr21381396wrs.328.1629841969403;
        Tue, 24 Aug 2021 14:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm3998582wmq.5.2021.08.24.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:49 -0700 (PDT)
Message-Id: <8032154bc8a1da17e6793ba0322d892760a11c8e.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:43 +0000
Subject: [PATCH v2 4/6] t1092: add cherry-pick, rebase tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add tests to check that cherry-pick and rebase behave the same in the
sparse-index case as in the full index cases. These tests are agnostic
to GIT_TEST_MERGE_ALGORITHM, so a full CI test suite will check both the
'ort' and 'recursive' strategies on this test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 38afdf689a2..60d7400d014 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -481,14 +481,17 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 	test_sparse_match git reset update-folder2
 '
 
-test_expect_success 'merge' '
+test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	test_all_match git checkout -b merge update-deep &&
-	test_all_match git merge -m "folder1" update-folder1 &&
-	test_all_match git rev-parse HEAD^{tree} &&
-	test_all_match git merge -m "folder2" update-folder2 &&
-	test_all_match git rev-parse HEAD^{tree}
+	for OPERATION in "merge -m merge" cherry-pick rebase
+	do
+		test_all_match git checkout -B temp update-deep &&
+		test_all_match git $OPERATION update-folder1 &&
+		test_all_match git rev-parse HEAD^{tree} &&
+		test_all_match git $OPERATION update-folder2 &&
+		test_all_match git rev-parse HEAD^{tree} || return 1
+	done
 '
 
 # NEEDSWORK: This test is documenting current behavior, but that
-- 
gitgitgadget

