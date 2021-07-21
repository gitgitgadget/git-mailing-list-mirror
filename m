Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00CC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B5D613CF
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhGUU0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhGUU03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A5C0613CF
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m2so3614369wrq.2
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XsQ49rBsJnlZxaHMiHDwuW+fcg5F8UkoyDC6X7QSgWU=;
        b=ZSubUMQZEXT2omTEE9Iuahtmetp9chFmzAuMK92NgeOdbGWzRqA44zEY2/L/R8jrmO
         fCQyMGISJOTlLAmSStqUJ75k2xLyMNDR/lu8Tdtpw1gokVUCyYXJga3/yNS0wvU8vfWf
         +DJ3zJ8vCvkf8xFYUzFhloVXQ7u2oT9QEJu0m3AU2lzVGmRu6Pmd4erDRWWSJf2p82DI
         o7757715S/mozUNoskRkMl7KSEQX/C4SrBoSUpJjGHxWNESMn9esLFjMrKN3/yKGbh8G
         DP1nuZSdR+R7uecZLRz2QAKCkcapINP1SA+1B+f1SzCnflhunR6YYfKBtSq11J+iPNQE
         0Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XsQ49rBsJnlZxaHMiHDwuW+fcg5F8UkoyDC6X7QSgWU=;
        b=FtBeq+KyQ7NsYf+y47P9t/7p+VUvDHGax2Iv5W9wi+4XqzA1TwUmX3zafz1clW8tTB
         HAqz17Fhs1xJpKcaGg7JowvjIQt9v61CWi0L/a3WO3vznOVtPwlLNqkCeDLrMgPfTuvP
         MFOTA/5XbDv7GFW1ny5vzP78XaeHjEHUZ1FDXhSfgTrydeskB5HXXGEy+Wyx4/WYxwaC
         MFEgl5Z6e93+cVDGk4QtySjQZTVQQ5PEKZFsW0yGosf3t1vu4vnLRd9UnVTl8qPh8mam
         rJO6+9CfTViKGAhbmQK2vL6GNj/YcLIdL6WKYSDnXABJAgy/7pxZIQ/Y+NsZa7+LRAsi
         X6QQ==
X-Gm-Message-State: AOAM530Ol0Y/BmMLeanuN00OOJCFb0OqB6BiXMiWiHDBPyr2wr19D2Nl
        anUPZOcOEtXOkwMfRk6mSh3CsFipuO8=
X-Google-Smtp-Source: ABdhPJzUoOfJHgC1YERgM05lcNLvbv/XZwdaoyqsZHpuHuFG6u1HgExyGdPHPJ39Z2Ljw9r0ppVkwg==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr45237461wrn.204.1626901623090;
        Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm28091688wrm.5.2021.07.21.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:02 -0700 (PDT)
Message-Id: <76066a78ce077add4bc69819b017516e12ac0d45.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:59 +0000
Subject: [PATCH 5/5] add: ignore outside the sparse-checkout in refresh()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Since b243012 (refresh_index(): add flag to ignore SKIP_WORKTREE
entries, 2021-04-08), 'git add --refresh <path>' will output a warning
message when the path is outside the sparse-checkout definition. The
implementation of this warning happened in parallel with the
sparse-index work to add ensure_full_index() calls throughout the
codebase.

Update this loop to have the proper logic that checks to see if the
pathspec is outside the sparse-checkout definition. This avoids the need
to expand the sparse directory entry and determine if the path is
tracked, untracked, or ignored. We simply avoid updating the stat()
information because there isn't even an entry that matches the path!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            | 10 +++++++++-
 t/t1092-sparse-checkout-compatibility.sh |  6 +-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c76e6ddd359..d512ece655b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -192,13 +192,21 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
+	struct pattern_list pl = { 0 };
+	int sparse_checkout_enabled = !get_sparse_checkout_patterns(&pl);
 
 	seen = xcalloc(pathspec->nr, 1);
 	refresh_index(&the_index, flags, pathspec, seen,
 		      _("Unstaged changes after refreshing the index:"));
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
-			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
+			const char *path = pathspec->items[i].original;
+			int dtype = DT_REG;
+
+			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
+			    (sparse_checkout_enabled &&
+			     !path_matches_pattern_list(path, strlen(path), NULL,
+							&dtype, &pl, &the_index))) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec->items[i].original);
 			} else {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 73c48a71d89..c61424e2074 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -347,7 +347,7 @@ test_expect_success 'status/add: outside sparse cone' '
 	test_all_match git commit -m folder1/newer
 '
 
-test_expect_failure 'add: pathspec within sparse directory' '
+test_expect_success 'add: pathspec within sparse directory' '
 	init_repos &&
 
 	run_on_sparse mkdir folder1 &&
@@ -357,10 +357,6 @@ test_expect_failure 'add: pathspec within sparse directory' '
 	# This "git add folder1/a" fails with a warning
 	# in the sparse repos, differing from the full
 	# repo. This is intentional.
-	#
-	# However, in the sparse-index, folder1/a does not
-	# match any cache entry and fails with a different
-	# error message. This needs work.
 	test_sparse_match test_must_fail git add folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
 	test_all_match git status --porcelain=v2
-- 
gitgitgadget
