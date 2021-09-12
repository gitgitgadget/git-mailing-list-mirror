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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D6C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103FE61056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhILNZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhILNYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E64C061767
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so3648675wmh.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OD0DF47tv0H5WlRb1hRZ7B8WyzsT+wEwZ+5J6dglwUE=;
        b=qcw1LEJT/r2LrvDN4XwJGKTqpHAL/2LjcxbMj83BDM/MoMy9BKVEp0IrGdvyorljZV
         Qq2n+0kkjtWe5G7I3RwU3Uq1uJdKWywaY0YrtSuQlaOPj1KxhQOq9BCn8Jp+rdRubacR
         evB7vVMnooLUjH6c9EgTGzhC3MOYbTr5Si89kbYPOq+b/fWlnt3YqWhwumAe3BRl7jT+
         dNpoSaL1gL+CPryrjYh4gptyDYZpq7IDkVNl7E4bfNV7ZFeKc8tEYyjMrNIkcjcXrVwU
         onFTmvWYY+SZZ99ZgXiJplEi+Jryze6WnPzrCACkfRXk4BABOTEISvT6obWDZQNqezyu
         fPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OD0DF47tv0H5WlRb1hRZ7B8WyzsT+wEwZ+5J6dglwUE=;
        b=ZiD1/70MJF8gfsQYftMauVJSahjx8Uk7rYSc9AS7CCEFuMC0dVn7RLmIAqAQXxXPYP
         YEROPdzeamR7gmXsGScqrbLy2uQG9XgVTEx0wHZevUf6DwFwr91U+xNlsYW86Hfw3Nrs
         jMjEtkkeJa1h+skiTnQLEcJDnSTy/xi1FyCBZPaa8mrMkVNJ4vO0wJhWkboesG3wVyZl
         uj/vjq7NyjuuGWgJ2KmY5B4vL34mq4gvCK3EM8pCY+unaKrnzgfgOCe0YhU7e6I+RSc3
         B2Ba4y+o4/KmJIJaciqI+Wypuup3Z9zJjNujl/C5aKxdsfsVVJxvmD3fa88uQhk+2VL0
         dvIA==
X-Gm-Message-State: AOAM533Hdn7ZoNjNPGFyzCKZBnRuWDf75iWNk4RXENZ24TeHCmov/MFQ
        N5V3cquCuYGHlApToL9l/M/RkBLK8EE=
X-Google-Smtp-Source: ABdhPJysnWCdfzd/siSuoK9rgH5J4lLt2j8ZjXtUUxDn2V490nCEk8+GgB4Uc44VDoLPJi4wrSeZOw==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr6582056wme.26.1631453018070;
        Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm4534562wra.76.2021.09.12.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
Message-Id: <f34be1660978ead503db13b81f55cac744230ec8.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:26 +0000
Subject: [PATCH v2 10/14] add: update --renormalize to skip sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We added checks for path_in_sparse_checkout() to portions of 'git add'
that add warnings and prevent stagins a modification, but we skipped the
--renormalize mode. Update renormalize_tracked_files() to ignore cache
entries whose path is outside of the sparse-checkout cone (unless
--sparse is provided). Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f87b8134b67..f8f0dfa4046 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -154,7 +154,9 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-		if (ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6fc49a1845f..cf2ccb87cf2 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -172,6 +172,9 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --renormalize sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
@@ -181,7 +184,14 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual
+	grep "^100755 blob.*sparse_entry\$" actual &&
+
+	git reset &&
+
+	# This will print a message over stderr on Windows.
+	git add --sparse --renormalize sparse_entry &&
+	git status --porcelain >actual &&
+	grep "^M  sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

