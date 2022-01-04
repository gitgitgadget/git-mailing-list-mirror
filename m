Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C1CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiADRhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiADRhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60426C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so77630302wrc.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r+HDwPBBJOFCam6auFZ9MSDne2TvgbgGFhd94QCrogs=;
        b=f4hAtTrb/hN11XliGhtyk9mxbmdgbhOi93AusdHUeXo0Ze0agN/ae8LUmpgspPb2m6
         IC1zXGUiWpj7aFriTnIyJSxpWtU3+81KvuYULTxkMdKpgAZB0n/8Xu5oGih3GXt2fFvq
         CpQydEF64qQZvlgE+uxOXxFKBnZscokxHjPg5QxFPoo0edW3oWdhwCjolFJAS06oax/q
         9vOqb9SuvZqHgKfjHut6/+jQsCLsGT+CR4lVmEQK1AwOJBb3L0AeVejMo1p4dljroVGA
         rP8FT2ydTDABz1+oqo6e06cBG7rpwWbSIDgiIkLgjYKMOPOLt1o9N/tkN698tNcGGDGc
         AEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r+HDwPBBJOFCam6auFZ9MSDne2TvgbgGFhd94QCrogs=;
        b=Nqqz+PEHAW9qoUZXR7g2/OUAVPb9R250dt8BkVPxFDfzGlCC4nw/fhg3WrlrupgV8R
         QtxsbUoV1oQ0AsiEbXvU7pNGpS21tq/UbGHOInXzNbTrcSnnUMQjMx9p5mCAvX0hlWnK
         ex68XZPfNlwGOelugTr8CufcM/jBc5jXUkWILXYa7Qwi3avWwvs7a7MtyeT30Tfz2FWn
         Oh+t0+niGlmbq15o7dxvFrSoR9wPDnCNKP9MzBECEtcR2LenZrm392vozCeHVbhL77dg
         OQVwBOTTwNN5v0aUSHrQ4IaheoCX32MI1N1L0ZOX/XzXDQKo17eEMLn7IZcWdJl9AWc/
         kxkw==
X-Gm-Message-State: AOAM530dj5EuVfCs+M4ZO9jEZ8leWHM/ibcGANbhSJcKFxTCOuMrPxeL
        8iz5g+/HQyIqx4afY+x3nXpxgXaLPhI=
X-Google-Smtp-Source: ABdhPJyj6GL1H+ODYwLNnnur5Jbgv6zJ3M8RzdKSck92eD5IAxScYtL3yjybp6VetuAVZrE8NjqHSw==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr44375295wrs.365.1641317824829;
        Tue, 04 Jan 2022 09:37:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13sm27898wmq.10.2022.01.04.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:04 -0800 (PST)
Message-Id: <e6a8671f6be5afad9a495be66c0735f6b741c844.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:55 +0000
Subject: [PATCH 4/9] checkout-index: expand sparse checkout compatibility
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
New tests are intended to serve as a baseline for expected behavior and
performance when integrating `checkout-index` with the sparse index.

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

