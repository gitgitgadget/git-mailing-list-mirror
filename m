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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74416C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2660D07
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhGZOim (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhGZOiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:38:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB8C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q3so11616224wrx.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gqAHQC4rWZ2nY5de6/Y5DYkEUm2gFg2s3OsnrG2b+/s=;
        b=h9jnvq++mTnZ4g3xkOfR4778EtN/xCJ2PIm3UB6vBs3lBu/E0ADtuPx28hcNB+pZxG
         VAxphcIt20jXZA+YCXFk8u2S3Q+flBPVXUC3Ew5maM+AGaPlrDG18cDHErotkOsLJi+b
         qba1MLk1a/xb208ufsMwCGayF8hpaqrzOTaCmVZBLOrccbM8Iv6Ra78QQMKHxSUzksbn
         1Fr5FvzBVecYcrSoX2dYnI356tT7arjDR6ts6PR9j64gpnTBHF6655p5NH5/guFFEKfr
         T2wcH5R5FW6t6ffx3V13oSFJ7ixavm3T0PEnk+zxcQbXmPgyQ1U7udu8KEfVKdqXlJ6d
         juTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gqAHQC4rWZ2nY5de6/Y5DYkEUm2gFg2s3OsnrG2b+/s=;
        b=mzvtmpPpB5dSInBWdyyHYryDOt8EeQAjU+crizKztezXgSXDae7qbZ5ZBnh+p3XtW3
         7mc/q5gh7+vcjjMfEvTS9OAIqU3gbBdn4XGuYUjPhFWjSZHEtvAzmyTuXd2PrRvkKboX
         ORHp8Pw7IjIfWhoyjN2NrwGIz7VRHpCk8iPHzDKzpHJpwzFdMPJzfTkRU+8ZoTyNjkBf
         YZXENmjSJgjZd8wZJw3k0es5eepo3tTtOKCUEmjXzpatEdkOtA/HZgsVvKgNrfwmLwZb
         DkQrZxPqi6AHh5TjmGmjKzC4gl9oaUxTu6cJmOjGI2Ap7kndJSYRAzte+Xs8I9fm6HLx
         k6Cg==
X-Gm-Message-State: AOAM532f1LT2Su4Fc5CYM//yDEFEeRPyeBNXLKQO50OyzQrqKPJuUVRV
        nGMC2Fl363uiELNCVJEdFlas6+tXDY0=
X-Google-Smtp-Source: ABdhPJyuIWQX84o4zfB5pQkJG77up+k4zNdyEB2NA+9tzBALx/m1y8IL+aEDale96YMj/amHGYMq9g==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr9936272wrr.373.1627312732492;
        Mon, 26 Jul 2021 08:18:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm85301wmr.28.2021.07.26.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:18:52 -0700 (PDT)
Message-Id: <a79728d4c648533468716ea1dcc16b3d4e0673b9.1627312727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:18:46 +0000
Subject: [PATCH v2 4/5] add: ignore outside the sparse-checkout in refresh()
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
index 50dce0e0f99..3e201546577 100755
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

