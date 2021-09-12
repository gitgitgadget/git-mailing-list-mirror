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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637FE61056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhILNY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhILNYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C622CC061762
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso4696151wmc.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BzJtR2tKaZqh8MfQ9ZcYL3o8pZUvjNp8K0z781ytOeY=;
        b=dd/m2/voYJKUoIDmO8VqbOlZB2civM84ABGg/oCIJs7PJAwVcRWQ9trnNHRxXDu+7K
         WdG2wngYz/vAVh+vyuC1IT1+NgHJZ64IH8FUK4H7Bk1Ol3qA3jYA1pNd8aZR40HX2NF8
         /Yg5qePkDh5+DeDpk5NcvdSsXH1s+0K4Fdt8Q6vLcNi9ga46cNNRDSHkKBoOuQ4pvwA9
         3Ci/bs8xz84WPitMhq/fA4WaHHCXvd9Pl8j8YtkbaNqvRkm1fLx5SI8fwJwFZfbTLoJc
         6Sj4ODC0a1U3FtesLeYL+tFeEJEdaLSgQh+D2YQpKNg4NQsPJ8KkNIdXnsQkWJgqqd2A
         X3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BzJtR2tKaZqh8MfQ9ZcYL3o8pZUvjNp8K0z781ytOeY=;
        b=DdqPWo1dH2sfTBphAxJQselryZjCzhsa1/v/B7YrOHeNfoMY0Tkb52g+qIobhn7n+q
         yUzistw3DCbUXJpkKI7qxQNvLyhLKLo4thAwwYUY0Ti37D+fiaRyav0ahkcxKoGQ/OgD
         OZbTiPti1Q9sjKVWwtUeb3NV6i/Hqzpdi4LGDMyJKysI14F1Hp8CeMd6t/VqKEnA2rCr
         OzbYcz4c5CvxF9tb6CZ+UBujUsKEYutXnB3+wxDMb7D1SMKW4i3boKgoLxxxT+4NU5Nt
         fnUZWeqAFM4iqm20ugIZtxsjM0HhRB/HCZ1bb640jiwrtqz+OajjYo+GLcMwe0+FPbVz
         SrCA==
X-Gm-Message-State: AOAM533ImW2giMdT5NaYwuW67oE+2m3qdFreyLr0wMezIL8i+oMuRoNU
        yQ1fk7Mk3XP7tYmzu17B/eDXIYh+wt8=
X-Google-Smtp-Source: ABdhPJw/6NlX0q/H4q/T99bGdjwHdJ6sGXugK9QP6KDHov2/DIDWMlKKeEyeTvrZLtGk2wKwUnkIBw==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr6929078wmq.194.1631453017493;
        Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm4520744wrs.60.2021.09.12.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
Message-Id: <7ace030c7093f6a0822fe45389d88df39df4d66b.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:25 +0000
Subject: [PATCH v2 09/14] add: update --chmod to skip sparse paths
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
that add warnings and prevent staging a modification, but we skipped the
--chmod mode. Update chmod_pathspec() to ignore cache entries whose path
is outside of the sparse-checkout cone (unless --sparse is provided).
Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 12 ++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f8e3930608d..f87b8134b67 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -47,7 +47,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 0f7e03b5326..6fc49a1845f 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -39,7 +39,7 @@ setup_gitignore () {
 
 test_sparse_entry_unstaged () {
 	git status --porcelain >actual &&
-	! grep "^M  sparse_entry\$" actual
+	! grep "^M[ M] sparse_entry\$" actual
 }
 
 test_expect_success 'setup' "
@@ -169,11 +169,19 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --chmod=+x sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual
+	grep "^100644 blob.*sparse_entry\$" actual &&
+
+	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	test_must_be_empty stderr &&
+	test-tool read-cache --table >actual &&
+	grep "^100755 blob.*sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

