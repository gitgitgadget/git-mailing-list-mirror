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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C239AC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9222F61CD4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhF2CPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2CPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7ACC061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n33so1136446wms.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f/KiyvI/Q1CXlsOXJtPYGGM2ZxsZJqz3uYZNz5JOQt8=;
        b=TNO7ORVqcPaRlD48f7df0RlmilDjwYykGVNJ96b+BgzEm6nDk4VFO1npAVx1J91g7V
         q+u4yqR/iEoj6yvWVMBK7vvPFTrkgrzg8Z/qKn94fTuv4ZgnqSuJsaTvgoGdiGAZMKmP
         Ld5RLHWfmkgx8SPvtJUG+rx99w3Z3DCw0j7jsuWltWZ5mCIONFE/5XfivuuCJidsuYZP
         th2VadblkreHAmt+I/manmeEcR73bNTN0r+OcZWY14uS3taUZq5jQ+xauseVy5lBDgNC
         3OYgNqZq0/a0+q8Hx8qeIopxWnwFIuS/Vn9oM52UFTcERzdRb/XZOp64duTu4zuVoAsG
         PGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f/KiyvI/Q1CXlsOXJtPYGGM2ZxsZJqz3uYZNz5JOQt8=;
        b=HadQ+m8ugQCYyu6E/OH4ZjF9cdb1o+quiq2bVUjBH9XtG14PJyXNJI44W10rQ04snX
         XamM8G3eVKrkqpOPiasCg+dhv2a0v9n5CzPUnNa6S18WlwJ0ZzkOvWx8t9XvME61i7ZI
         M/ORCnlDEcZAvQAH0sqwaFGB04Ds13iX1uhqixCfr7+zZ4EDEz+odeFglJ4i1IuR8vA+
         zn5CfOngo+sUf86TxXbNcUpq3in4CFp7xG4jiosQtvNPfFSrtAMl9KDetE2Sha+JTLSm
         eZD9WfX1gHWCFfhugRnFnqiHGcfaoTw9pLP8+ZyKzq2e05ZtxKX17Imxk2lKhacSPywK
         Na8Q==
X-Gm-Message-State: AOAM531xBfTjcnkJLzlIEyE8wQIdSUko5mDB+LoqK9nH9ULox2pIIrLh
        y/d8gdCx952sHmymGRFQQHkatqZIJDA=
X-Google-Smtp-Source: ABdhPJxSzPv8tnVSQHTkVzjbOQEiBmGs8UX/dk6tbAkqflNzDq4aUGiahnok+4erenJls7KlGX63iA==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr11824102wme.175.1624932788470;
        Mon, 28 Jun 2021 19:13:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm14724155wms.8.2021.06.28.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:08 -0700 (PDT)
Message-Id: <bb3dd1fdd4891f660b0721fd9e42252a86062fff.1624932786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:02 +0000
Subject: [PATCH 1/5] p2000: add 'git checkout -' test and decrease depth
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

As we increase our list of commands to test in
p2000-sparse-operations.sh, we will want to have a slightly smaller test
repository. Reduce the size by a factor of four by reducing the depth of
the step that creates a big index around a moderately-sized repository.

Also add a step to run 'git checkout -' on repeat. This requires having
a previous location in the reflog, so add that to the initialization
steps.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p2000-sparse-operations.sh | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 94513c97748..f7f8c012103 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -6,7 +6,7 @@ test_description="test performance of Git operations using the index"
 
 test_perf_default_repo
 
-SPARSE_CONE=f2/f4/f1
+SPARSE_CONE=f2/f4
 
 test_expect_success 'setup repo and indexes' '
 	git reset --hard HEAD &&
@@ -27,7 +27,7 @@ test_expect_success 'setup repo and indexes' '
 	OLD_COMMIT=$(git rev-parse HEAD) &&
 	OLD_TREE=$(git rev-parse HEAD^{tree}) &&
 
-	for i in $(test_seq 1 4)
+	for i in $(test_seq 1 3)
 	do
 		cat >in <<-EOF &&
 			100755 blob $BLOB	a
@@ -43,14 +43,23 @@ test_expect_success 'setup repo and indexes' '
 	done &&
 
 	git sparse-checkout init --cone &&
-	git branch -f wide $OLD_COMMIT &&
+	git sparse-checkout set $SPARSE_CONE &&
+	git checkout -b wide $OLD_COMMIT &&
+
+	for l2 in f1 f2 f3 f4
+	do
+		echo more bogus >>$SPARSE_CONE/$l2/a &&
+		git commit -a -m "edit $SPARSE_CONE/$l2/a" || return 1
+	done &&
+
 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
 	(
 		cd full-index-v3 &&
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
-		git update-index --index-version=3
+		git update-index --index-version=3 &&
+		git checkout HEAD~4
 	) &&
 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
 	(
@@ -58,7 +67,8 @@ test_expect_success 'setup repo and indexes' '
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
-		git update-index --index-version=4
+		git update-index --index-version=4 &&
+		git checkout HEAD~4
 	) &&
 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v3 &&
 	(
@@ -66,7 +76,8 @@ test_expect_success 'setup repo and indexes' '
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
-		git update-index --index-version=3
+		git update-index --index-version=3 &&
+		git checkout HEAD~4
 	) &&
 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v4 &&
 	(
@@ -74,7 +85,8 @@ test_expect_success 'setup repo and indexes' '
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
-		git update-index --index-version=4
+		git update-index --index-version=4 &&
+		git checkout HEAD~4
 	)
 '
 
@@ -97,5 +109,6 @@ test_perf_on_all git status
 test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
+test_perf_on_all git checkout -f -
 
 test_done
-- 
gitgitgadget

