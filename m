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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A660FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhHQRJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQRJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7FC0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q10so29725844wro.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EFox4U+F6W40H0/eDGnPhGlIzsTg6u9PPbEaj/R3UH0=;
        b=gYHusIUOgNXb8QBFipQT3twQUto7q/PUOY7+WRSMYIW/C5ilXvYpY/cp/mN8vVJVtc
         1JpbN0dRwZJQv1LkRy4LdqKcH6eD31gkaQ8EPzFsq73IidwO7+sz6ylGG5Z7W0j+dWce
         QW57zcbGIng5E0Q9ItK+yrbO6mR2vaxUwb4kGrODU4iKGZ28oOOoBxq/DZeucKKAW5el
         LzJn+HZ45Jj9ZNOFiFRZcoZtudcq8lNCk8ceKCSLaJQWc/EETRtBXptNKPpWJF//vC5+
         1UXx98Epn5tkXLMpNjbnACPf4m4W8Mrpqr4X9QOEuPQ/DnFdoHAASQMP1ya8Jo3ekUW8
         sK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EFox4U+F6W40H0/eDGnPhGlIzsTg6u9PPbEaj/R3UH0=;
        b=Awi1Zx6GsNk1FWo3f2laRAHxi8x6+QWtZNdxSps/L0WYPYceBFaWnAIJlyGM7MJF5h
         +oS2M8AjnYrrYRc0UmpkZ9wgdg8jicjBAImQUmok/C4kXxPIF4Fz6zl3Azctq6+n5YQ3
         tu9AdN+aDkYtQvXVvXGIblN3lvPC0IQutQ8Nd7jcGoW2aFcPjhfw7polWsmxyudJh9cU
         YQl8l+tea6zWpYX0a16P1o8AkrCVLQLcndyoKFfVdHWmTbbAyBsTSg7Q/QJPPZS62Xon
         CnpcTHUhf99dVfxamTYcjvfuPWQmBundnYYICkeEGreUnJ42D7yNR/l6svR52pc5DocB
         T0Ww==
X-Gm-Message-State: AOAM530tchMSbYMQSZ9yByNj89LEmODUBkb5aZeui1x4APgez/pW51XN
        YL3fknx71rPs8dmhXVds+6qlhe+LmCE=
X-Google-Smtp-Source: ABdhPJxQIw9q7eSqsFEnXHChPQ7NcYBBLSAwoo0iwdvsIbVlkv6EV3y4iIrk2otqkCaWsQZIdlCjaQ==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr5460357wro.69.1629220126277;
        Tue, 17 Aug 2021 10:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm3214745wrx.87.2021.08.17.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:46 -0700 (PDT)
Message-Id: <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:39 +0000
Subject: [PATCH 1/6] t1092: use ORT merge strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse index will be compatible with the ORT merge strategy, so
let's use it explicitly in our tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ddc86bb4152..3e01e70fa0b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -7,6 +7,11 @@ GIT_TEST_SPARSE_INDEX=
 
 . ./test-lib.sh
 
+# Force the use of the ORT merge algorithm until testing with the
+# recursive strategy. We expect ORT to be used with sparse-index.
+GIT_TEST_MERGE_ALGORITHM=ort
+export GIT_TEST_MERGE_ALGORITHM
+
 test_expect_success 'setup' '
 	git init initial-repo &&
 	(
@@ -501,7 +506,7 @@ test_expect_success 'merge with conflict outside cone' '
 
 	test_all_match git checkout -b merge-tip merge-left &&
 	test_all_match git status --porcelain=v2 &&
-	test_all_match test_must_fail git merge -m merge merge-right &&
+	test_all_match test_must_fail git merge -sort -m merge merge-right &&
 	test_all_match git status --porcelain=v2 &&
 
 	# Resolve the conflict in different ways:
@@ -531,7 +536,7 @@ test_expect_success 'merge with outside renames' '
 	do
 		test_all_match git reset --hard &&
 		test_all_match git checkout -f -b merge-$type update-deep &&
-		test_all_match git merge -m "$type" rename-$type &&
+		test_all_match git merge -sort -m "$type" rename-$type &&
 		test_all_match git rev-parse HEAD^{tree} || return 1
 	done
 '
-- 
gitgitgadget

