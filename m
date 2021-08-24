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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6353C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80638611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhHXVwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhHXVwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88518C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x12so33316353wrr.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2790nSllAGE+Jryr1ZNUmiwSlcYNs/tn/3C9+QWeo8U=;
        b=bHoC/cFeawuCurYakzmgnfS9Z+WYf9JT0lZSKLSTu7c2S6t4fSfdergCSiPSanWlsj
         +GXH+Mq4ecVgKLbveBiFwa7RamELYmNt5Q+SA+DHhNuoVsnV2OQ5E66ozSGl0Ndj2O/l
         yP9dTPCPWZNHcDyoEkHygT9P1cStYzxf8hYCMRjauAuvVKCX81bzLaocCx8TTscXCERB
         h/gc2HzA8fNvu5CDj2lUaLBgKi7BWlH6Iqxp9WSWTd0+nFehKRV8zHBwmzNn+jbSZGSA
         5IN/UvRfrjud0s+frNMc+O3HKlfIXAP9awXFqjI4j/4j1qq6CaJivNqfVM0TTBEWDDDm
         1Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2790nSllAGE+Jryr1ZNUmiwSlcYNs/tn/3C9+QWeo8U=;
        b=gMLwW38K+pAb/5zv434IMaKM7yIGVUHrhh6cWg4NlDRUCgrnCFZJ2gEbah8oVF09NW
         TAd3iJf4W4HqS5dUG/y8C4sBForbiEXixHEThVOQapuxiHSE6l1md62XmExsLXDuRR9+
         wkg0il3KjekewUuQYQ3iGrgqFQevuut7qK9B3dZAxSBXKqibZjs4Dj5xr+fXsXxmokxG
         MD3rCS4yRVTOne10NBA6nyAAN4GS5qtxQAKnIZAqMNC8QnqUj+rxPMjZnKM3Km5raUsM
         kEX1LcGTpMnMnwPo/kOllTstbv3ziHpEvll7MVxcYSBAp9HscBMkebtMAxyHXrxKsmv8
         3CWA==
X-Gm-Message-State: AOAM530oJImvvZwypDbmbdq6VxzzHHDOsQ1FePJWuiizG34YJ8oJ88HY
        xTxeALOlXtGuH4Yplb8r2vcJpI7EabI=
X-Google-Smtp-Source: ABdhPJxDvfWgvOda4S8iVjsFfKSV93nGauN2Vo6f0RdisFVmCXvvnJyyaldKg/OJJBKlYoDSVChOwQ==
X-Received: by 2002:adf:f188:: with SMTP id h8mr5482705wro.218.1629841906148;
        Tue, 24 Aug 2021 14:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm3134802wmq.7.2021.08.24.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:45 -0700 (PDT)
Message-Id: <c407b2cb346b32cdf95c6017d16b93dd1483c627.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:35 +0000
Subject: [PATCH v4 01/10] t7519: rewrite sparse index test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse index is tested with the FS Monitor hook and extension since
f8fe49e (fsmonitor: integrate with sparse index, 2021-07-14). This test
was very fragile because it shared an index across sparse and non-sparse
behavior. Since that expansion and contraction could cause the index to
lose its FS Monitor bitmap and token, behavior is fragile to changes in
'git sparse-checkout set'.

Rewrite the test to use two clones of the original repo: full and
sparse. This allows us to also keep the test files (actual, expect,
trace2.txt) out of the repos we are testing with 'git status'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index deea88d4431..f1463197b99 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -389,43 +389,47 @@ test_expect_success 'status succeeds after staging/unstaging' '
 # If "!" is supplied, then we verify that we do not call ensure_full_index
 # during a call to 'git status'. Otherwise, we verify that we _do_ call it.
 check_sparse_index_behavior () {
-	git status --porcelain=v2 >expect &&
-	git sparse-checkout init --cone --sparse-index &&
-	git sparse-checkout set dir1 dir2 &&
+	git -C full status --porcelain=v2 >expect &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git status --porcelain=v2 >actual &&
+		git -C sparse status --porcelain=v2 >actual &&
 	test_region $1 index ensure_full_index trace2.txt &&
 	test_region fsm_hook query trace2.txt &&
 	test_cmp expect actual &&
-	rm trace2.txt &&
-	git sparse-checkout disable
+	rm trace2.txt
 }
 
 test_expect_success 'status succeeds with sparse index' '
-	git reset --hard &&
+	git clone . full &&
+	git clone --sparse . sparse &&
+	git -C sparse sparse-checkout init --cone --sparse-index &&
+	git -C sparse sparse-checkout set dir1 dir2 &&
 
-	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
-	check_sparse_index_behavior ! &&
-
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 	EOF
-	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
+	git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
 	check_sparse_index_behavior ! &&
 
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 		printf "dir1/modified\0"
 	EOF
 	check_sparse_index_behavior ! &&
 
-	cp -r dir1 dir1a &&
-	git add dir1a &&
-	git commit -m "add dir1a" &&
+	git -C sparse sparse-checkout add dir1a &&
+
+	for repo in full sparse
+	do
+		cp -r $repo/dir1 $repo/dir1a &&
+		git -C $repo add dir1a &&
+		git -C $repo commit -m "add dir1a" || return 1
+	done &&
+	git -C sparse sparse-checkout set dir1 dir2 &&
 
 	# This one modifies outside the sparse-checkout definition
 	# and hence we expect to expand the sparse-index.
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 		printf "dir1a/modified\0"
 	EOF
-- 
gitgitgadget

