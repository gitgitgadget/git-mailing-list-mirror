Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBBC433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiCaJWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiCaJWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439A14CD17
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z16so21412082pfh.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhJB/k98NqSAG90wW6/14pz75cm0BLY12sePI0HIllg=;
        b=kRkAKU6deKz0KRVRPDcDzDT2ldibsZCpCzpwBAbwer6VzokYm06/Y9oeIwjV9D6GYm
         IRd2AuuRsnkWDTtOvH3mk8iLtm1JORvVi4kZcsUieR/fOupmDZy/HA2Q+PG5y5nM3qT4
         6dNilEnMAeiH6tAQcBTc/z/Lu8i9wIk5ytfeHmyoXCX5Q7azLps4tAkvAs9Wxk/nrw4s
         8VoF/RPBw4Jrg1oO4bhZFXYXu7JBnXUaRadI8HjFKLyCUeS4pKjjHsO8mVELjdqPPXj4
         Fj64aqlhb4WhajNJibdeN4m3R9ZIxPiL4MFgBH4m+uBIPj7AsGMJhXjvnJNHxN2YZJCL
         kLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhJB/k98NqSAG90wW6/14pz75cm0BLY12sePI0HIllg=;
        b=e0iNfJ5vg3j/OomYK2osX1qXRBT11vjppVDw8/wO7fzsObr5MlM4hZRV8XIkWMxUoA
         HMsI5IbRy4yL+oVLjHJhcvFwboWW47pWoxAK4d2yZUtkpi2Cp1c6ue4+Rq8W2ceZxWGj
         R6K0NLbmno0L7ya/U9NiiBKP88lFaemjU0P3IBnTAQX3dOsnr/oEae69HQ5ak1hSrxUM
         zbJFj2yVd5AOCjqqn2/3vGiISH4b7IJ7+Z8Ifn4jsbHIWH35iw7LVg7r1qJECL5R8PgV
         YJJd5sxYBAaLwwRLTPPxYcdCxeW1rnYfrtvnlys129XuB52xBW4vsJjwZB6U2MHE4j0u
         4JPg==
X-Gm-Message-State: AOAM531jyjJHv34EiABbmGd2GKT9YKcyJK2SGkouTvgdzGXPA9t/ZCRH
        SBn9UOk2ClbfnmoOl0ya5B9PhVTVlK0=
X-Google-Smtp-Source: ABdhPJxR6uf661nvhoAcP4GjVqdmACV5Crop3r8XBM/1IdQacCPbwTSgU3aUqSLpN2hnKiP8SPhz0g==
X-Received: by 2002:a05:6a00:1252:b0:4fa:afcc:7d24 with SMTP id u18-20020a056a00125200b004faafcc7d24mr4387839pfi.85.1648718424976;
        Thu, 31 Mar 2022 02:20:24 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.75])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm27225931pfk.88.2022.03.31.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:20:24 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v1 4/4] t7002: add tests for moving out-of-cone file/directory
Date:   Thu, 31 Mar 2022 17:17:55 +0800
Message-Id: <20220331091755.385961-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add corresponding tests to test following situations:

* 'refuse to move out-of-cone directory without --sparse'
* 'can move out-of-cone directory with --sparse'
* 'refuse to move out-of-cone file without --sparse'
* 'can move out-of-cone file with --sparse'

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1d3d2aca21..efb260d015 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -206,4 +206,76 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
+test_expect_success 'refuse to move out-of-cone directory without --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	test_must_fail git mv folder1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'can move out-of-cone directory with --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	git mv --sparse folder1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
+	>expect &&
+	test_cmp actual expect &&
+
+	git sparse-checkout reapply &&
+	test_path_is_dir sub/folder1 &&
+	test_path_is_file sub/folder1/file1
+'
+
+test_expect_success 'refuse to move out-of-cone file without --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	test_must_fail git mv folder1/file1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'can move out-of-cone file with --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
+	>expect &&
+	test_cmp actual expect &&
+
+	git sparse-checkout reapply &&
+	! test_path_is_dir sub/folder1 &&
+	test_path_is_file sub/file1
+'
+
 test_done
-- 
2.35.1

