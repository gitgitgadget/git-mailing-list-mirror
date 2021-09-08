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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CCC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DE461157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351467AbhIHLZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbhIHLZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4407C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so2688399wro.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sNOF7IWMV6JpmoxZOXbwz0RZxhecQhnosCn0V8JM6KE=;
        b=i58ca39s9oeUrASli0KTw7SLaLOG9jabMGrF5/snYdvxuDy/hlkZ0WEzgLF69Pw4G4
         l9b3nTIt5Cj8rodLgXddEDpCj++6wJAFIXn+7bQCBU73lnxjWAFHm5kDU7Fps1aFzFT8
         aBFyfcWdPIVpWXs49C4JahHOfomxJO8ka4z59T6JR/4AcZfitoBBM2WWiBk1SqbnEknl
         KD5sLuBDh9Z7dCeJ1HXmwK3mAPS0q8g+wBYKciwa5qZ7Jna8THvBBWtfa0/jBl3egq81
         9LF5L2iljqlIVni13EzjLPWy0xQOnXFWKrBILAgPxQ7w0fGY94C4BKbAkIagZ6Xgu/t8
         4ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sNOF7IWMV6JpmoxZOXbwz0RZxhecQhnosCn0V8JM6KE=;
        b=nuJi6NVFX5Z4WvGm4oUHL6ECf4GrLZ1fLoJZcR/D1IUvxx9E3GIHVLyhdeA8VgtTfR
         ndedokg7lC31VruKHpbFq3HSzGnwk2B1En2H7IQ9RV4PxlLOiNSP5XR6jgA+egyLlhN5
         2f+IWZ2b+g1Kp567jMyhbFQHquU9S8WETzEPFTakHgFPdnWnAafXiQoSL77LBLW/cBqZ
         aL5K+sb2a2EJcAsOdF9SXVP+3ZJ962P5qwIYcICD/XWHxQuY/8atcCJnDKYabET+4Wmo
         DOVf0XHubrP0PE4ZXUQJjyddPyISWk4XUa0ky2HClz8OEPMPtDPLaEUiKnL5bOlP7Fji
         Lqfw==
X-Gm-Message-State: AOAM533ovlzmL2YC1DX3sac485SPv3CGuOChWi5xe527RzmFDFMYr/Yr
        1zD0elcVVJ259PMlsfLEDASDq2yv09Y=
X-Google-Smtp-Source: ABdhPJwQRh8cOkg2G2uHXvkCidLWDzVfCOVCMC/nj1nJqEzGUhVMnwyuIqRYEed9cwU8ZRf2ke2Vtw==
X-Received: by 2002:adf:c501:: with SMTP id q1mr3536309wrf.150.1631100245549;
        Wed, 08 Sep 2021 04:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm2110198wro.81.2021.09.08.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:05 -0700 (PDT)
Message-Id: <7aae5727fb79620ac9e0dac201701fe15fb579ab.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:23:59 +0000
Subject: [PATCH v3 4/6] t1092: add cherry-pick, rebase tests
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
index 36964f52f2f..d9424ed6427 100755
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

