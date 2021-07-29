Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BBFC432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4060EBB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhG2OwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbhG2OwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D161C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q3so7356117wrx.0
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KkF6IMbAMZ/rUGP/m1B+r+kVHZeLn8AMYuVyXWvvMuQ=;
        b=BZmim6mFMv5Tm6IAj5awT/TjDmrOmyirXZ4ccEIg5mi3pDnJ+qzjlarws/3FpfRNVi
         2M5kQdscPjRVf9Z+JnIG/uRD5dMxWnhIVK/qC3lpfP/IJ+9OSXhnx8aBX8si5tufKDY1
         SKOxORXVHDdLn+O0Gt0IhqeqaZzvSAQbMPdm4HvMzt6P9mvnJS7QgFnxI3thWeTCdXll
         mA90A+t0DT4ZIm9/zpEyKlQYlQaml6dL9fYItiYuztWIIl68rhiHs+xlvk7wgQHPiIYB
         7yPq9RCK5LHv7NdC9zgt/jDfYOUrOxwm3qoBFDEgA3GVC+NTla0Z2DpZuCru139Nkavy
         w99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KkF6IMbAMZ/rUGP/m1B+r+kVHZeLn8AMYuVyXWvvMuQ=;
        b=GaT/VwmQG6lggsDfandF7rmEXSbB7zD8zdo5rFOU4hPLQ9L2rLF7X6o5uBCUzmQrJk
         iAWYqe3r/3XxTLK4lhDARRWouQBbhv4Jbu6J5HG5+OFs958Wo7ofQ4OuGea8rsVO7wZH
         NZz+wOtAfdPcQFsqkn4DYQOGd126kV+byX5j3T2fED03f/yBNwjVCxpvYbyyyFY2l5Dl
         oLUsbsTcndPpUMEiGObmhZX78dfGLcc9t/bH0NUT9hEN0GTizOsWhxPnuYMg62rCdLqG
         rwKDP5NidnuhF9MBxldeek4tSjn/slH9Ca4ZtUoMqGdj5S3yJTKO7RtOf/w0mhtiK/h6
         FUFQ==
X-Gm-Message-State: AOAM5303g3axM2hBlD1BU3uiHQTtC55JdxcPY6gE5rePXwQwllubir6Y
        /MsLy4Z3ogiWc/WMc+3FKDpE1ssNS54=
X-Google-Smtp-Source: ABdhPJwZ9e8zKQL2ivBHas7eORZiGSAOakkgHd82pbaltnDKM5Mb/zybvW8xeDQF5GQhjFP7+6QtFg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr1201877wrq.201.1627570331770;
        Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm3570476wrp.12.2021.07.29.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
Message-Id: <0ec03ab021da8b8a2278af3e14960c5cf4689646.1627570327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
        <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:06 +0000
Subject: [PATCH v3 4/5] add: ignore outside the sparse-checkout in refresh()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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
index dee20db5bb1..ddc86bb4152 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -339,11 +339,7 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
-
-	test_must_fail git -C sparse-checkout add --refresh folder1/a 2>sparse-checkout-err &&
-	test_must_fail git -C sparse-index add --refresh folder1/a 2>sparse-index-err &&
-	# NEEDSWORK: A sparse index changes the error message.
-	! test_cmp sparse-checkout-err sparse-index-err &&
+	test_sparse_match test_must_fail git add --refresh folder1/a &&
 
 	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
 	test_sparse_match git add folder1/new &&
-- 
gitgitgadget

