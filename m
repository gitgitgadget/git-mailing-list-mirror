Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiADRhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiADRhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035CC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r17so77630395wrc.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3TI+OW+dvOnQ18MHZSF2GtHsiaIDojtYMQWA72iibOQ=;
        b=MiUq/Tt51FUTR49oGEYxa5pyQG/OyuNG8+972g81PVi+1sMBD4Kpg+alGG+igaDciJ
         DjheHs4cfUtdeBheGnenfFxhms6pIBjdv8CeFE+hK3OQjU94UwxktvcJ5FK8H/Ugooqf
         yZez4TqXG4MUXg151072+W12aEtUqfOMiYGZQN94Zf0r8xiL+izexpriTIcsODvDi1sp
         OdfoWUQLlpWXCSRHYBO4lSYGBAN4UNNdqoDpekYAHhlcW41XQUj3Ulo/Tu06+6mkuRO7
         24upqpQCLuZ9qE+Bm0UWXTX05nLnPtr33qdUBl/labA4girQbm7IsnDUEdcYeEBpiaHo
         3q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3TI+OW+dvOnQ18MHZSF2GtHsiaIDojtYMQWA72iibOQ=;
        b=Qp8lYnlYBF0E7HQbDCWTl2e2+M9pF4oDpiSsjWcN+qU4FbrQvnaEdwbPK/bHx4dyaD
         xzarAFNZjvGZFKIISCVnz+3uQ9hWzDu44YntmUyEnk8i/g877cZz5P2MzmxoEyvVesxy
         cZNAsU/fjSNNEQZrdUIxoU4YWxzcG/gs67tPJSS2dsJYUdT03WCkBk2ScHebg0gzFAOu
         RDkx0lZwZK3OIIHnBR8R+tnnmOTuxXvCdPWlr9bAxO3MqVhIQStHvFHzObd1kvhZK4Er
         cS+kQFTuy65KeExf0X9C0sVV7Md2H5SJ7GSqodCAmRvLS9KqBysj31AwmVsBTZcGICYk
         KoOQ==
X-Gm-Message-State: AOAM532PVSx53tDAdqGmIh+sHoNiAcZs/Tq07hXZ/gPIT02MPw8JJrx+
        X3i5IB5O0LMFbVkStokC7WTd+zfnDIw=
X-Google-Smtp-Source: ABdhPJz2S6XYWHOtfCCFtWYxzowbpRZKpXdsgLuFtjHHG/wz6HugyIrryOGzCosyW2IkB0h63e5vkQ==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr43774587wrc.417.1641317826108;
        Tue, 04 Jan 2022 09:37:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm25082wmr.15.2022.01.04.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:05 -0800 (PST)
Message-Id: <18c00fc9dd373bd5cfb527cb7d672a5a1b3b0588.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:57 +0000
Subject: [PATCH 6/9] checkout-index: integrate with sparse index
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

Add repository settings to allow usage of the sparse index.

When using the `--all` option, sparse directories are ignored by default due
to the `skip-worktree` flag, so there is no need to expand the index. If
`--ignore-skip-worktree-bits` is specified, the index is expanded in order
to check out all files.

When checking out individual files, existing behavior in a full index is to
exit with an error if a directory is specified (as the directory name will
not match an index entry). However, it is possible in a sparse index to
match a directory name to a sparse directory index entry, but checking out
that sparse directory still results in an error on checkout. To reduce some
potential confusion for users, `checkout_file(...)` explicitly exits with an
informative error if provided with a sparse directory name. The test
corresponding to this scenario verifies the error message, which now differs
between sparse index and non-sparse index checkouts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/checkout-index.c                 | 28 ++++++++++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 2053a80103a..9c5657ccf22 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -66,6 +66,7 @@ static int checkout_file(const char *name, const char *prefix)
 	int namelen = strlen(name);
 	int pos = cache_name_pos(name, namelen);
 	int has_same_name = 0;
+	int is_file = 0;
 	int did_checkout = 0;
 	int errs = 0;
 
@@ -79,6 +80,9 @@ static int checkout_file(const char *name, const char *prefix)
 			break;
 		has_same_name = 1;
 		pos++;
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			break;
+		is_file = 1;
 		if (ce_stage(ce) != checkout_stage
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
@@ -107,6 +111,8 @@ static int checkout_file(const char *name, const char *prefix)
 		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
+		else if (!is_file)
+			fprintf(stderr, "is a sparse directory");
 		else if (checkout_stage)
 			fprintf(stderr, "does not exist at stage %d",
 				checkout_stage);
@@ -122,10 +128,25 @@ static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_w
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			if (!ce_skip_worktree(ce))
+				BUG("sparse directory '%s' does not have skip-worktree set", ce->name);
+
+			/*
+			 * If the current entry is a sparse directory and skip-worktree
+			 * entries are being checked out, expand the index and continue
+			 * the loop on the current index position (now pointing to the
+			 * first entry inside the expanded sparse directory).
+			 */
+			if (ignore_skip_worktree) {
+				ensure_full_index(&the_index);
+				ce = active_cache[i];
+			}
+		}
+
 		if (!ignore_skip_worktree && ce_skip_worktree(ce))
 			continue;
 		if (ce_stage(ce) != checkout_stage
@@ -218,6 +239,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index fad61d96107..6ecf1f2bf8e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -796,7 +796,14 @@ test_expect_success 'checkout-index with folders' '
 	test_all_match test_must_fail git checkout-index -f -- deep/ &&
 
 	# Outside checkout definition
-	test_all_match test_must_fail git checkout-index -f -- folder1/
+	# Note: although all tests fail (as expected), the messaging differs. For
+	# non-sparse index checkouts, the error is that the "file" does not appear
+	# in the index; for sparse checkouts, the error is explicitly that the
+	# entry is a sparse directory.
+	run_on_all test_must_fail git checkout-index -f -- folder1/ &&
+	test_cmp full-checkout-err sparse-checkout-err &&
+	! test_cmp full-checkout-err sparse-index-err &&
+	grep "is a sparse directory" sparse-index-err
 '
 
 test_expect_success 'checkout-index --all' '
@@ -965,6 +972,8 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	ensure_not_expanded add . &&
 
+	ensure_not_expanded checkout-index -f a &&
+	ensure_not_expanded checkout-index -f --all &&
 	for ref in update-deep update-folder1 update-folder2 update-deep
 	do
 		echo >>sparse-index/README.md &&
-- 
gitgitgadget

