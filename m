Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13CC43217
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346168AbiAKSGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbiAKSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:05:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69AC0611FF
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q8so34418107wra.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nYf5xAjH38pG53d5lWxnBkNiDBQQR8OOEeDq2g67RQA=;
        b=nvv0M4dQWJgtowuL5hcGDq9c1stdBTqgoIE0+fW+PCj4farURLs1bVY6ZJ8M2vS/73
         iEBO5y3+sO7KKRnD6FIwvsjQvbpEAGNMXyh6x5CyHmrzEhviUduzSVmewar2ZGk35+g2
         Aj3qMJlEf3YNIBib4Kza6owA0EkpO+w72OZqnSjLEzccX14GXwxyY+ZVJtnM2SsivITy
         lHTbU1CG+b0r6Xmg+wAKY0RunanqOignt0naUBNDYe5DxutC3ctGgiI5jlFF4nrTIWp7
         CuOveK7L7QzBqcaWUdJDfgitKscD8niEzHRxF6DwhkZLph6BXB/BB5fagpydNjKhhsBS
         fclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nYf5xAjH38pG53d5lWxnBkNiDBQQR8OOEeDq2g67RQA=;
        b=wAatfpymuhVDXF4FfDyRnLSX8aXCWPadY5EBoo8/4R1JB5QAWBcAL/jJJp/OB5v1Sx
         POUqXQ2mSN9Ed6s0tCvZTTbJuxmGkssDOxpvHpFPonyS3wnVGlF5SXH/Tf9U0CoDv3DM
         O4RNTVFY1v+jLw+vzwawXNTjPes5EuGwBl8v5UopdNTlXASmHbeYtUqmfbJHHDn6M+jV
         fz0e0MB/BxoR0zatQvHUT/Vv/QaRPbwmPTjZcZpTJm0Wmv/VeJJJLD5BypBBShRuOmkc
         poIm9XPf6k187yblsHPwTx5ELl7CI5wOkh5iij2A1LWe8iId+5zWKDcS9CoWpVyupgzq
         iqXQ==
X-Gm-Message-State: AOAM530VeTbj0xGT8SfMKeqfMggtLi6ydNHS4HpV+XgyhLJTNf5ukk2J
        EJLFZAAslPl8FSw4NACGmFAuxxBEJ3w=
X-Google-Smtp-Source: ABdhPJzkgLnXMAdb+LEgkBQf3PB6PSPDhFu75/piwrAWubofbxx+Y1ys4SFiKIzgz9REkzpjUvbafg==
X-Received: by 2002:a5d:6e8a:: with SMTP id k10mr5054021wrz.113.1641924312221;
        Tue, 11 Jan 2022 10:05:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm10818428wrd.10.2022.01.11.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:11 -0800 (PST)
Message-Id: <52aec13d18e339024e350733ee9d0b5c6b9008e6.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:00 +0000
Subject: [PATCH v2 3/9] clean: integrate with sparse index
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

Remove full index requirement for `git clean` and test to ensure the index
is not expanded in `git clean`. Add to existing test for `git clean` to
verify cleanup of untracked files in sparse directories is consistent
between sparse index and non-sparse index checkouts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/clean.c                          |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..5628fc7103e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -983,6 +983,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		dir.flags |= DIR_KEEP_UNTRACKED_CONTENTS;
 	}
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d5167e7ed69..05587361452 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -764,23 +764,42 @@ test_expect_success 'clean' '
 	test_all_match git commit -m "ignore bogus files" &&
 
 	run_on_sparse mkdir folder1 &&
+	run_on_all mkdir -p deep/untracked-deep &&
 	run_on_all touch folder1/bogus &&
+	run_on_all touch folder1/untracked &&
+	run_on_all touch deep/untracked-deep/bogus &&
+	run_on_all touch deep/untracked-deep/untracked &&
 
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git clean -f &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_exists folder1/bogus &&
+	run_on_all test_path_is_missing folder1/untracked &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/untracked &&
+
+	test_all_match git clean -fd &&
+	test_all_match git status --porcelain=v2 &&
+	test_sparse_match ls &&
+	test_sparse_match ls folder1 &&
+	run_on_all test_path_exists folder1/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
+	run_on_all test_path_is_missing deep/untracked-deep/untracked &&
 
 	test_all_match git clean -xf &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_is_missing folder1/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
 
 	test_all_match git clean -xdf &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_is_missing deep/untracked-deep/bogus &&
 
 	test_sparse_match test_path_is_dir folder1
 '
@@ -920,6 +939,8 @@ test_expect_success 'sparse-index is not expanded' '
 	# Wildcard identifies only full sparse directories, no index expansion
 	ensure_not_expanded reset deepest -- folder\* &&
 
+	ensure_not_expanded clean -fd &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

