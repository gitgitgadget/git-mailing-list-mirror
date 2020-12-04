Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88539C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBFA22CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLDVHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDVHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:07:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F4CC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 13:06:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so6594017wrb.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+LIaoTMJngvZmhJCdyjRrq4zBFcNx59+U+1V7AxFMHs=;
        b=SCVzYzLe5Egkxsa5V3N8DMu2tDLxg+d6EO4fMqqc3Vnx18BeJb9gfTybdzT0kbq9/8
         sg+HcgHk4AE7VCDUpRGsGvKYzDVw6mqvdnzwZMk6LhQXIaGoEhKskmvm/vjXw9D38yc1
         IF6NQnjltDlwG735Deyj9W9yr/z5mnFWmcTOZNHTBPDqTZ3xI05y6tW1nqQlsoytxbok
         QLP0WwUepIWZYdJH6Uqpk8UGb7fn68BYoJ6KXd7ALoyxfW/C7x1IU+ePZEj5gR+9knw7
         sgPtstHL2X4KVb9J+XkTziFBDehuNIlDSmctaulM3hV4gWc55eXUlCfR4DbdSnw9XKqu
         CLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+LIaoTMJngvZmhJCdyjRrq4zBFcNx59+U+1V7AxFMHs=;
        b=qlmOpbdAtA6zi3qCebZvj4Bws8qLniUJB+tzX7+Hv7xU0zbBysFsbVh9FTbuAKT4n9
         d499RxmXqj6DA4jfy/p6ZyeJQzzFgJUdCH7Qgzj9lUw3KXOgZD8EoDHI32YF6QCInCSY
         Bc7FDEyf6tqSBKE07BFWepaHQdx7mi+z1Oi5HAT+0Fc+jl28WpCZhEl/dH+30JQt5Ukn
         XSiZVugE9feUOtnv/WOvoOCYET6BaJJjmTRM0cTHf90tfwfRwU52H0PASIT+nFZG4B9Z
         aj0HkJr2U9Io8vsSYd005DJdg8HR8cYXnmArsVNlsnwcE8d6/KglCWHdlP0hYAC7Y963
         3p+A==
X-Gm-Message-State: AOAM532JDSIkNXqTQG26iArRZZthT8NZonuYmYnVkxTKvtPKQ/vZBL/i
        Jbrfixby0DOca2OM7dYvexLUr7UfAPc=
X-Google-Smtp-Source: ABdhPJwd5XQZjnNMIHTjtkfhZ//KXdtTQVFqxsxZhweSUe2ncRn1VI5ab+MEmC8kb0xagp4SUd/y9Q==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr7112263wro.19.1607115982497;
        Fri, 04 Dec 2020 13:06:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm4216631wmj.42.2020.12.04.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 13:06:21 -0800 (PST)
Message-Id: <pull.808.git.1607115981367.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 21:06:21 +0000
Subject: [PATCH] t7817: do not depend on any specific default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Elsewhere, we introduced support to override the default branch name in
the tests via `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`. Therefore, we
should avoid expecting a particular hard-coded name in test scripts.

So let's rename the initial branch immediately to `main` and work with
that.

This avoids breakages in t7817 when the default branch name is changed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t7817: do not depend on any specific default branch name
    
    This should fix the CI build of seen with regard to t7817. The patch is
    designed to be applied on top of mt/grep-sparse-checkout.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-808%2Fdscho%2Ft7817-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-808/dscho/t7817-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/808

 t/t7817-grep-sparse-checkout.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index f93a4f71d1..d9d32c6435 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -77,7 +77,8 @@ test_expect_success 'setup' '
 	test_path_is_missing sub/A &&
 	test_path_is_file a &&
 	test_path_is_file sub/B/b &&
-	test_path_is_file sub2/a
+	test_path_is_file sub2/a &&
+	git branch -m main
 '
 
 # The two tests below check a special case: the sparsity patterns exclude '/b'
@@ -110,12 +111,12 @@ test_expect_success 'grep unmerged file despite not matching sparsity patterns'
 	b:modified-b-in-branchY
 	EOF
 	test_when_finished "test_might_fail git merge --abort && \
-			    git checkout master" &&
+			    git checkout main" &&
 
 	git sparse-checkout disable &&
-	git checkout -b branchY master &&
+	git checkout -b branchY main &&
 	test_commit modified-b-in-branchY b &&
-	git checkout -b branchX master &&
+	git checkout -b branchX main &&
 	test_commit modified-b-in-branchX b &&
 
 	git sparse-checkout init &&

base-commit: aaff72b8c3e3d95917f3432396073a7708b16a90
-- 
gitgitgadget
