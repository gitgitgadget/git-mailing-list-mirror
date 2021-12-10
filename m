Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbhLJPQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbhLJPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:16:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19EEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 137so7064340wma.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XfoLAbru6OVVuU2WQMn25q33O/C0bEdZXzyg2YKjQQc=;
        b=W7+fcQifMeEdb+8n9mRRFRs16iD2BkBPvwfivP19eERlv4WNTbuHBCbVE1PqHqg6z8
         Ph2Wkomo2x6WV6QuduMLnPkcpC6wQbf1yKORQRNdEnsEx+WD8gqJ5rSEr855Dj8NbPOm
         CjrSZKpWyEFBPg0V3M14QbxiwOxb57fBCm9aSeWXth5J7caTH1Xvg79GhYXAEvLTd5yP
         /q4RyL2L6TufwrWnjV/KEb6vjWWhE3BJdIDbPKF3IW7OlrgTwNN71k9RWIrnC8/vjS9Z
         uLV2s29ouy6Dvp9ldOuCprgMZUJwDTr6292RN2gsVzPgWBTMt1BOF+iYtRrBW8YgkF6I
         coBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XfoLAbru6OVVuU2WQMn25q33O/C0bEdZXzyg2YKjQQc=;
        b=rCY8oo36DQn+nZPxPAaTlE3F7r4KqrU4wTVS8lCzMN43fa0QXaSQHMRi2jNbG7yWC/
         XQl1G0qDDtp2MaMFZa0cqPmTi9dEn7xxmkf2WuGpRZvfx/PkX1B4ppumk96bx5FblZ7R
         FJdOWO3wSQvLekwlftRvhddtPVVDM6xKKpRLjfVr4/Y0D2E53A90LeDe9PM2ab5biXFj
         2dq4Cc+SVkOYkjIS9sl0iSnLFrLQGK8lawFNWk0B1xUwYw5RO4w4e+LJ4z6F20g6M1AA
         XprAA1Cu74yAAEGrQo6ZJzzOOnNr2FU4qH3Ze3UDU7Id7l0W6LArzuhVrHUD/r1l3Dy+
         Zmgg==
X-Gm-Message-State: AOAM532lTw1Oe8TxhWLuYvelsk6sCOOH+hNjwNtoENyDRV07/3Ugfowa
        M8pnKWBr/LNi9IZmE/aGAjYRqXSUQ/I=
X-Google-Smtp-Source: ABdhPJzhM5LV0Y09OXtG3SiAONRkFfpknqc0lrx7IG1e55z/OPpoZrszGXbxDUyqZfR2gstoIgu35A==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr17397600wma.45.1639149196206;
        Fri, 10 Dec 2021 07:13:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm2721254wrr.37.2021.12.10.07.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:13:15 -0800 (PST)
Message-Id: <2a6a1c5a39c9f07f4714d0d9916c3e1775836372.1639149192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
        <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:13:10 +0000
Subject: [PATCH v3 3/5] t1092: replace 'read-cache --table' with 'ls-files
 --sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1092-sparse-checkout-compatibility.sh.

The important changes are due to the different output format. We need to
use the '--stage' output to get a file mode and OID, but it also
includes a stage value and drops the object type. This leads to some
differences in how we handle looking for specific entries.

Some places where we previously looked for no 'tree' entries, we can
instead directly compare the output across the repository with a sparse
index and the one without.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 31 +++++++++++-------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 29b97667378..d4a0d8ce825 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -200,45 +200,42 @@ test_sparse_unstaged () {
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set folder1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set deep/deeper1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep/deeper2 folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
-	# Disabling the sparse-index removes tree entries with full ones
+	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
-
-	test-tool -C sparse-index read-cache --table >cache &&
-	! grep "040000 tree" cache &&
-	test_sparse_match test-tool read-cache --table
+	test_sparse_match git ls-files --stage --sparse
 '
 
 test_expect_success 'expanded in-memory index matches full index' '
 	init_repos &&
-	test_sparse_match test-tool read-cache --expand --table
+	test_sparse_match git ls-files --stage
 '
 
 test_expect_success 'status with options' '
@@ -787,9 +784,9 @@ test_expect_success 'submodule handling' '
 
 	# having a submodule prevents "modules" from collapse
 	test_sparse_match git sparse-checkout set deep/deeper1 &&
-	test-tool -C sparse-index read-cache --table >cache &&
-	grep "100644 blob .*	modules/a" cache &&
-	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
+	git -C sparse-index ls-files --sparse --stage >cache &&
+	grep "100644 .*	modules/a" cache &&
+	grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
 '
 
 # When working with a sparse index, some commands will need to expand the
@@ -1085,13 +1082,13 @@ test_expect_success 'reset mixed and checkout orphan' '
 	# the sparse checkouts skip "adding" the other side of
 	# the conflict.
 	test_sparse_match git reset --mixed HEAD~1 &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2 &&
 
 	# At this point, sparse-checkouts behave differently
 	# from the full-checkout.
 	test_sparse_match git checkout --orphan new-branch &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2
 '
 
-- 
gitgitgadget

