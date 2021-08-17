Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC0C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC24761029
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhHQRvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhHQRuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D0C0617AE
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn28so20785447edb.6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVagcLK3plaqfkQ168AonmveUBFEfixeKMA6WCQL6Ic=;
        b=c+MHTEIvvtfgUFZ1TP2+EgolGKwNRx0p5fIu7e35x7vF0QgLMWoithef8pPwKgqV8b
         rGO0qt6jpNXDSpilP41c94XAPs99qFMKUA4jwJVxTzjh8SpLLLHb90w9/YwxWusuTfWr
         DF97aXpJXYlFFbSZwCEVsvUcGqihPiEP26ivFSwlhg2eDrfevBzZVbLsnTeMX2w6h85L
         U+vU1Hp5OSD6ahIWz6n0BpIYySF0d1VRH/On6eO98EXSvslL9vpKiQqQfNYnO94PQD2h
         H4RzT7KCi3ZeGwcxkG1X4sc/Ut8lILNxuSLRLeDbqpKjkaONe1NCz9p8dwGLeT2EMoCI
         Czwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVagcLK3plaqfkQ168AonmveUBFEfixeKMA6WCQL6Ic=;
        b=RiD5rZyA8tOpalwH8hc5+qbFS9xib94cPlBT0UtAIAYxpk9jo+NZ43LNJjhfqHbC80
         TmLBx7miarnkTErfXbwxIWlZrZaXc2hfFGAygrNFvDQSRb7mSAVaksDW33n39dWFaAHp
         mJe2HSXty5uhcqxqIhFUZG62wAFrS22gftgw3ggYbSgEyOomRtxyrYTGEEbZ0SexT2Lc
         H1cqXKAiwI407MTpus7dOFY4050UYFzkczDQaFopb0FzkE8QT4ubfLO9JIP/U3i8E+2e
         Idxr6zXz2xSJzboxs4qOv8473mTu9fktML0vGUbMGw8fj1c45ftsegZDzJATMUCdkBt/
         K/2Q==
X-Gm-Message-State: AOAM532s3ZCLnFM9TMzZFUu/PnrT0ayluTJQY0PTVRJ8LjxXZTe40ibM
        Zz2cppsWSlSBbmT41LV0lOHaHTsJNIo=
X-Google-Smtp-Source: ABdhPJzz1oGizXJ/eWGygDW04uuWeQ98T6VLzTq7zD98xApeZvkbR5aT0YQE2aYS7EQ/0UC/D4959A==
X-Received: by 2002:a05:6402:482:: with SMTP id k2mr5542673edv.188.1629222608285;
        Tue, 17 Aug 2021 10:50:08 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:50:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/6] tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
Date:   Tue, 17 Aug 2021 19:49:37 +0200
Message-Id: <20210817174938.3009923-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sparse index and split index features are said to be currently
incompatible [1], and consequently GIT_TEST_SPLIT_INDEX=1 might
interfere with the test cases exercising the sparse index feature.
Therefore GIT_TEST_SPLIT_INDEX is already explicitly disabled for the
whole of 't1092-sparse-checkout-compatibility.sh'.  There are,
however, two other test cases exercising sparse index, namely
'sparse-index enabled and disabled' in
't1091-sparse-checkout-builtin.sh' and 'status succeeds with sparse
index' in 't7519-status-fsmonitor.sh', and these two could fail with
GIT_TEST_SPLIT_INDEX=1 as well [2].

Unset GIT_TEST_SPLIT_INDEX and disable the split index in these two
test cases to avoid such interference.

Note that this is the minimal change to merely avoid failures when
these test cases are run with GIT_TEST_SPLIT_INDEX=1.  Interestingly,
though, without these changes the 'git sparse-checkout init --cone
--sparse-index' commands still succeed even with split index, and set
all the necessary configuration variables and create the initial
'$GIT_DIR/info/sparse-checkout' file, but the test failures are caused
by later sanity checks finding that the index is not in fact a sparse
index.  This indicates that 'git sparse-checkout init --sparse-index'
lacks some error checking and its tests lack coverage related to split
index, but fixing those issues (let alone making sparse index
comparible with split index) is beyond the scope of this patch series.

[1] https://public-inbox.org/git/48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com/

[2] Neither of these test cases fail at the moment, because
    GIT_TEST_SPLIT_INDEX=1 is broken and never splits the index, and
    it broke long before the sparse index feature was added.
    This patch series is about to fix GIT_TEST_SPLIT_INDEX, and then
    both test cases mentioned above would fail.

(The diff is best viewed with '--ignore-all-space')

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 +++++++++------
 t/t7519-status-fsmonitor.sh        | 51 ++++++++++++++++--------------
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 38fc8340f5..3f94c41241 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -206,16 +206,21 @@ test_expect_success 'sparse-checkout disable' '
 '
 
 test_expect_success 'sparse-index enabled and disabled' '
-	git -C repo sparse-checkout init --cone --sparse-index &&
-	test_cmp_config -C repo true index.sparse &&
-	test-tool -C repo read-cache --table >cache &&
-	grep " tree " cache &&
-
-	git -C repo sparse-checkout disable &&
-	test-tool -C repo read-cache --table >cache &&
-	! grep " tree " cache &&
-	git -C repo config --list >config &&
-	! grep index.sparse config
+	(
+		sane_unset GIT_TEST_SPLIT_INDEX &&
+		git -C repo update-index --no-split-index &&
+
+		git -C repo sparse-checkout init --cone --sparse-index &&
+		test_cmp_config -C repo true index.sparse &&
+		test-tool -C repo read-cache --table >cache &&
+		grep " tree " cache &&
+
+		git -C repo sparse-checkout disable &&
+		test-tool -C repo read-cache --table >cache &&
+		! grep " tree " cache &&
+		git -C repo config --list >config &&
+		! grep index.sparse config
+	)
 '
 
 test_expect_success 'cone mode: init and set' '
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index deea88d443..513e17065f 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -402,34 +402,39 @@ check_sparse_index_behavior () {
 }
 
 test_expect_success 'status succeeds with sparse index' '
-	git reset --hard &&
+	(
+		sane_unset GIT_TEST_SPLIT_INDEX &&
+		git update-index --no-split-index &&
 
-	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
-	check_sparse_index_behavior ! &&
+		git reset --hard &&
 
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-		printf "last_update_token\0"
-	EOF
-	git config core.fsmonitor .git/hooks/fsmonitor-test &&
-	check_sparse_index_behavior ! &&
+		test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+		check_sparse_index_behavior ! &&
 
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-		printf "last_update_token\0"
-		printf "dir1/modified\0"
-	EOF
-	check_sparse_index_behavior ! &&
+		write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			printf "last_update_token\0"
+		EOF
+		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		check_sparse_index_behavior ! &&
 
-	cp -r dir1 dir1a &&
-	git add dir1a &&
-	git commit -m "add dir1a" &&
+		write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			printf "last_update_token\0"
+			printf "dir1/modified\0"
+		EOF
+		check_sparse_index_behavior ! &&
 
-	# This one modifies outside the sparse-checkout definition
-	# and hence we expect to expand the sparse-index.
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-		printf "last_update_token\0"
-		printf "dir1a/modified\0"
-	EOF
-	check_sparse_index_behavior
+		cp -r dir1 dir1a &&
+		git add dir1a &&
+		git commit -m "add dir1a" &&
+
+		# This one modifies outside the sparse-checkout definition
+		# and hence we expect to expand the sparse-index.
+		write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			printf "last_update_token\0"
+			printf "dir1a/modified\0"
+		EOF
+		check_sparse_index_behavior
+	)
 '
 
 test_done
-- 
2.33.0.453.gc5e41af357

