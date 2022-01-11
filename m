Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C8C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbiAKSGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350374AbiAKSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:05:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84642C06118A
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k18so34458823wrg.11
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ig69vFiAXTGsLE38mf/wzKCH3mvuGjiv+0ER5Kqt3+o=;
        b=IeFqTpDSgza7XhLduTJig73GolJ9K5aUnYGTGpTBd6ViULsEhkxWkR7H/pe5uCY4d9
         vnjY+6tTTH0wbLxXOVs9Rlxw7G8bfszENEPUeHhvsjBOaE+9+owpgi9niFGm2TV++K8a
         eq8nFPJ6ellzCRxLTblenVZEO+wPuBhryAowRvWohL5AQQNd+FrWjpMKIwzIWv8DKXqc
         sCsn5b6Z9NAPIRvKKmA6fiaBwiXyuXrUrINXqXI5AKiLjx8LltyqK15XeJvyd6ZG+MEs
         QGPmlNiHEzS/9d2ILYLt8woPEH0FXaJW58/EfpXcynG9D9u5ErokxoMff5ZkA62763Vn
         /rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ig69vFiAXTGsLE38mf/wzKCH3mvuGjiv+0ER5Kqt3+o=;
        b=cZJfgw1TvoVq12yF90bLnLmrF3qDkWxW16IgH7iwVwpgW1sTojX6KyT+lCYOui72E7
         jW4cnYEpDrnYUsPvLQAHKHB0P1q61gVx/sSJp1sk8jE6vcKMRZ423vhzUIO6cSSV3fuX
         LNNpAOTL+Rp2iuhLWn/wAnfgPk32Z9yeP1j6vwQ56Mel32X9phy2MA98wlfGLUU1ubil
         hUYWcUlobxtw0ZPFidxULrfj6FPKxIdnKJ+/+HhEaxVgPqH2Z5JWA10U0AE0I2ucV2sK
         pEv9r59yGxnVb7+2agFgEFC5qsJhI8qoPRl94hOQA7qCC7BnvtTfpWjJtcaw26qHudC5
         wZ6g==
X-Gm-Message-State: AOAM532a/8BASUAbng+6Rh/IPwJrUQ7c/ietA3DxXbEeutDMCupuRwBO
        48RmjF4TQ0aJlycyaGla1swJh+EC0mk=
X-Google-Smtp-Source: ABdhPJzqr+rklmixd7XnZyKRKiaKSL8kTTrF1bI9g/GXRvMLjYuHARXBPYxo5LU5smJ4EItUe65nbA==
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr4848008wrs.141.1641924313034;
        Tue, 11 Jan 2022 10:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm2684193wmp.40.2022.01.11.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:12 -0800 (PST)
Message-Id: <d964507fdcc580042c3f7d1e8e3146edd5f6d0ce.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:01 +0000
Subject: [PATCH v2 4/9] checkout-index: expand sparse checkout compatibility
 tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests to cover `checkout-index`, with a focus on cases interesting in a
sparse checkout (e.g., files specified outside sparse checkout definition).

New tests are intended to serve as a baseline for existing and/or expected
behavior and performance when integrating `checkout-index` with the sparse
index. Note that the test 'checkout-index --all' is marked as
'test_expect_failure', indicating that `update-index --all` will be modified
in a subsequent patch to behave as the test expects.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 54 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index cb777c74a24..54f8602f3c1 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -117,5 +117,6 @@ test_perf_on_all git diff
 test_perf_on_all git diff --cached
 test_perf_on_all git blame $SPARSE_CONE/a
 test_perf_on_all git blame $SPARSE_CONE/f3/a
+test_perf_on_all git checkout-index -f --all
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 05587361452..db7ad41109b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -755,6 +755,60 @@ test_expect_success 'cherry-pick with conflicts' '
 	test_all_match test_must_fail git cherry-pick to-cherry-pick
 '
 
+test_expect_success 'checkout-index inside sparse definition' '
+	init_repos &&
+
+	run_on_all rm -f deep/a &&
+	test_all_match git checkout-index -- deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	echo test >>new-a &&
+	run_on_all cp ../new-a a &&
+	test_all_match test_must_fail git checkout-index -- a &&
+	test_all_match git checkout-index -f -- a &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'checkout-index outside sparse definition' '
+	init_repos &&
+
+	# File does not exist on disk yet for sparse checkouts, so checkout-index
+	# succeeds without -f
+	test_sparse_match git checkout-index -- folder1/a &&
+	test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
+	test_cmp sparse-checkout/folder1/a full-checkout/folder1/a &&
+
+	run_on_sparse rm -rf folder1 &&
+	echo test >new-a &&
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all cp ../new-a folder1/a &&
+
+	test_all_match test_must_fail git checkout-index -- folder1/a &&
+	test_all_match git checkout-index -f -- folder1/a &&
+	test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
+	test_cmp sparse-checkout/folder1/a full-checkout/folder1/a
+'
+
+test_expect_success 'checkout-index with folders' '
+	init_repos &&
+
+	# Inside checkout definition
+	test_all_match test_must_fail git checkout-index -f -- deep/ &&
+
+	# Outside checkout definition
+	test_all_match test_must_fail git checkout-index -f -- folder1/
+'
+
+# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
+# files (even those outside the sparse definition) on disk. However, these files
+# don't appear in the percentage of tracked files in git status.
+test_expect_failure 'checkout-index --all' '
+	init_repos &&
+
+	test_all_match git checkout-index --all &&
+	test_sparse_match test_path_is_missing folder1
+'
+
 test_expect_success 'clean' '
 	init_repos &&
 
-- 
gitgitgadget

