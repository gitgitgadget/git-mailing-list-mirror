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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00BBC636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4816100C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGTT7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019EC0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u1so27364134wrs.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f/KiyvI/Q1CXlsOXJtPYGGM2ZxsZJqz3uYZNz5JOQt8=;
        b=KTUfTqvTbkoIT9iYR7z15ScxKMPvMx7sMf1j9jHil//K4Wh/lnKYHC0tKhi5Kkf4ST
         U9xNuzDIuODAzD0uK4QiGt5+nd16flNPcTWVvnYqp6yAy9dizUe4/TfhRLVNN+QF4nIe
         KhigVcW4Yx2nwAuFcEboCCKIwWidqHDENpzFxSoA8ORNG45FFajtP2GS5W3qknS1DPn2
         daKiX4nxFbJE3qGY8hX7VyJB5XOrZNG0DU4Vnh6f5nPX9SsyjJgMEI53Tgvl874BLo/R
         /Lv7W2LMYoBhzEm+uxlj2lF9RcLC2GO2vBmUxX+CPYLUvt3rZLkYFnwsNhHAP5aVb8wG
         Q51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f/KiyvI/Q1CXlsOXJtPYGGM2ZxsZJqz3uYZNz5JOQt8=;
        b=Ac6bLKut8ptCbaNrXNQmfnfLekLP3HQukUQTNSvcGwT9O9289rbPV13TxwVFSauJYI
         oWtywIxXMhrc++ocDjbUrg8LHYe/QguslsfWWuw+OFA5EjZDjOkvyXpahqUrPr01QH9+
         QsFaYtEWKOzSbYar/8uNEqzV1oxsLEEVNCjuIou8PE+k3WDZuMvrWa62WabrK/Cs9OIl
         ZueTIhdVJ1DC1+GkyIHtb6SW+V6uPoW7m1V6cKPInOPtX+m7URNU5hqsUkP6E7XERNpw
         BY9FJfrq6RwS98iU79MGUioUtsHiwd6J5FE9TtWUc/6Fvt5Q1alfisxrH4j7BU3kYEOM
         +3bQ==
X-Gm-Message-State: AOAM530/crWzJ3lZztBUQbrl3OL4Lcn7Z4FgIZ3xuA/3TBoOGeOkas4i
        t1o9pm+gar/XZHcMp7deNKZhq1T9Ji0=
X-Google-Smtp-Source: ABdhPJx4ospaESpkYCvQ8r7euFo1hI3cN7VJ+S4Xypg9lYAg28kY0V7sBWr5cil6kNANK/V1QXQezw==
X-Received: by 2002:adf:facf:: with SMTP id a15mr37969348wrs.39.1626812082711;
        Tue, 20 Jul 2021 13:14:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm3146620wmq.38.2021.07.20.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:42 -0700 (PDT)
Message-Id: <6e74958f5900855cc0c3b6484b2b2a7732293e6c.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:35 +0000
Subject: [PATCH v2 1/7] p2000: add 'git checkout -' test and decrease depth
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

