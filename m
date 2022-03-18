Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C17C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiCRAfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCRAfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F012467EE
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so4066896wmq.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+t/ALlpusUnbj2JHTYacqqGaRYeM+B10Cv4w8YZOn4=;
        b=cmpPjEWy95fkNLOp/bgrxDR7oPR/8f2x7AUWOKxodVT32qcEindHTjoLc6scA8pqwD
         gThDJbzvwD+wcuKALBOdLP2Q5J8dgKaf43ZhOmPfKBLcHS7we96xCtuZQwyLDCb8CMfq
         vjQXtJjIR4YZ5gv/uNzZX0W0W/JgJwlExNAL3QzzIsEE/cO1mL5GJAnHz6UOFfwbO2lZ
         kPVKeCxrIRqn9KfHkQENeLE0+RIe0OMJaIr8QHF1UKqehMz5l4GwiNUrdZjQG81BFr12
         jfS11PoUtPaGfynJ+axU+ajF51lA6KTg8nKKsUsnXytcihGZqKfQOHLx+32AyAZ8b0TN
         J/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+t/ALlpusUnbj2JHTYacqqGaRYeM+B10Cv4w8YZOn4=;
        b=Gn4bby6Q20MfCF+TypNZ8nKqu8VUM5Rlrd9VKnwZ7agZF7p6fqdNGxruKyB3OzeinN
         WJf1kthr+voPHNKipk1e+XzVPnmAfQKWZd28Bvgg3t3b8OAZFSNLLZrMvKuqAV58TApn
         MPQJIh1d97Cd3kFpI0X/GEGaVPQOZqaabSTRFaVZCkWr/YnEWh2j716sHfQXUBt1xNjo
         fSZvmyvtJaYv/XLRVTU912pZMSqTQ3WshyIYe6obleY7iAjioHAzqAd6EXdw73lwfjg+
         S22djxQc8RcRmR7e0y+OoxXAvEkoau0fTFlMxUuPRtfX+h1jzOuSx1aCEwpe19xHEjQG
         tJnw==
X-Gm-Message-State: AOAM533ZdQ0O1H2S2oGRAa+aox7fa+2k58LZOguDWMAr9KBrZt+hucfE
        LZV57GZ2xgd1c/mGd0mDMbq5BD9rkGL18g==
X-Google-Smtp-Source: ABdhPJyq2xLEC5A2s4f9RwykXlwXc3AQ+NFGQWHnnEE5MYJ0QUiYBq6CAbJ+N7C5nKsHqAy2CGjTbA==
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id o24-20020a1c7518000000b0037c07ebf255mr13536861wmc.29.1647563655602;
        Thu, 17 Mar 2022 17:34:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] sparse tests: convert a TODO test to use "test_expect_todo"
Date:   Fri, 18 Mar 2022 01:34:02 +0100
Message-Id: <patch-7.7-10677b32b78-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test that used "test_expect_success" before 49fdd51a235 (add:
skip tracked paths outside sparse-checkout cone, 2021-09-24) to use
"test_expect_todo" instead.

Now we'll test for the exact current behavior, while documenting what
behavior we'd like to get instead.

This test is a good example of the sort of cases where we benefit most
from "test_expect_todo". In 49fdd51a235 the only change here (aside
from the "NEEDSWORK" comment) was changing "test_expect_success" to
"test_expect_failure".

We thus lost test coverage, and would not have noticed if we failed in
some unexpected place in this rather large test (it's 30 lines of
setup before getting to the "NEEDSWORK" comment). Now we can get the
test coverage back, while documenting what is and isn't desired
behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9a900310186..23973bc186b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -467,7 +467,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
 
-test_expect_failure 'sparse-checkout reapply' '
+test_expect_todo 'sparse-checkout reapply' '
 	git clone repo tweak &&
 
 	echo dirty >tweak/deep/deeper2/a &&
@@ -501,11 +501,18 @@ test_expect_failure 'sparse-checkout reapply' '
 
 	# NEEDSWORK: We are asking to update a file outside of the
 	# sparse-checkout cone, but this is no longer allowed.
-	git -C tweak add folder1/a &&
+	test_todo test_expect_code \
+		--want 0 \
+		--expect 1 \
+		-- \
+		git -C tweak add folder1/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_must_be_empty err &&
-	test_path_is_missing tweak/deep/deeper2/a &&
-	test_path_is_missing tweak/folder1/a &&
+	test_todo \
+		--want test_must_be_empty \
+		--expect "grep warning:.*paths.*unmerged" \
+		-- err &&
+	todo_test_path is_file is_missing tweak/deep/deeper2/a &&
+	todo_test_path is_missing is_file tweak/folder1/a &&
 
 	git -C tweak sparse-checkout disable
 '
-- 
2.35.1.1436.g756b814e59f

