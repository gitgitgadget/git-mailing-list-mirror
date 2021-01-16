Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801AC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D3D22527
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbhAPRGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbhAPQb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42ACC06134B
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so12246644wrn.1
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImXUkZ6o3CFBgFdea1OS0wH2Fcn8MK141oZMsNbmFjc=;
        b=U+hgjS6p9EDD1ZkGk1W6ay/WTPh8HsykufKqob52v8bXI5pQ2uNYl9bMrg9ulatceA
         XZw8boRUgk9jYh6G2a0zfgErBEG2eSxVSGFT80ISq9y/J8eqIspugtHE43nRiWRfda6u
         +4JHfMbYi2QFVuLy55hkuQ2NnH2hopzHQhNc7eGzbrM6VTJGf7GRRqEi9UkbpHlEeGKf
         Ku42dsv1T5ZtsN8Z39G89S/XzEqKgptwnLs42wsm+/aEX5rUJWmRbPmvio2ejCAOs00n
         +u63xILbt5k7roMxCscAVNNA6rDQHCv0J6Od2HuE1EfNnTE+rCUVSIRFiuVyG2+8E1LU
         XCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImXUkZ6o3CFBgFdea1OS0wH2Fcn8MK141oZMsNbmFjc=;
        b=Ai+MNR9kLRzVzS34ns9U+BJ7cG+2TG6IXfk5QiU+bkpkIJr9z8iN7wxU7XN+Zpwxan
         198TmAcqukswPs0s6WJD/2ch/QogHW20YxQp0K9SQTrA9bZ8+0Dg19umKiVMQgKjtdAg
         1JmKO3SC0+i9ENMd4WPI3nTr0f+WFxpC73bpIW9erK16HW8g+BB6bAx8agiFL00Uk4OD
         xFtq9Z4yh2fetFYXEo1qzjxtMtgZVDI+Gy0dRB/iILMsfx3BYwR81Ntmwg2h2r1kGSiQ
         CZnqlmqEnzoT8KCXL+ZdYOUVZErngKH6/TBL6D1nnOq6VkYzDCKGMciPZBqa7ROTR4km
         5L5w==
X-Gm-Message-State: AOAM532AOZMBLTZMJaM3JzxLSp3ZtllbcesFpXnoEpLDo5d3WfTe8TQF
        Y+3SvajN9oCsOj0T+AJHiTIVZdXDAb6IrA==
X-Google-Smtp-Source: ABdhPJzapxgGw/QdqdVcZxV0v30JiK07nDaOq4G7PCCJSWylUlxxGatZU5KlblJKxVn5KCUUoeYQgw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr18436356wru.215.1610811364822;
        Sat, 16 Jan 2021 07:36:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
Date:   Sat, 16 Jan 2021 16:35:48 +0100
Message-Id: <20210116153554.12604-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor some old-style test code to use test_must_be_empty instead of
"test -z". This makes a follow-up commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9151-svn-mergeinfo.sh | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 59c5847c5f..806eff4023 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -17,41 +17,42 @@ test_expect_success 'load svn dump' "
 "
 
 test_expect_success 'all svn merges became git merge commits' '
-	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ") &&
-	[ -z "$unmarked" ]
+	git rev-list --parents --all --grep=Merge |
+		grep -v " .* " | cut -f1 -d" " >unmarked &&
+	test_must_be_empty unmarked
 '
 
+
 test_expect_success 'cherry picks did not become git merge commits' '
-	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_cherries" ]
+	git rev-list --parents --all --grep=Cherry |
+		grep " .* " | cut -f1 -d" " >bad-cherries &&
+	test_must_be_empty bad-cherries
 '
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
-	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_non_merges" ]
+	git rev-list --parents --all --grep=non-merge |
+		grep " .* " | cut -f1 -d" " >bad-non-merges &&
+	test_must_be_empty bad-non-merges
 '
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
 	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&
 	merge_commit=$(git rev-list --all --grep="Merge trunk to b2") &&
-	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit) &&
-	[ -z "$not_reachable" ]
+	git rev-list -1 $before_commit --not $merge_commit >not-reachable &&
+	test_must_be_empty not-reachable
 '
 
 test_expect_success 'merging two branches in one commit is detected correctly' '
 	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk") &&
 	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk") &&
 	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk") &&
-	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit) &&
-	[ -z "$not_reachable" ]
+	git rev-list -1 $f1_commit $f2_commit --not $merge_commit >not-reachable &&
+	test_must_be_empty not-reachable
 '
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master) &&
-	[ -z "$unmerged" ]
+	git rev-list --all --not master >unmerged &&
+	test_must_be_empty unmerged
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

