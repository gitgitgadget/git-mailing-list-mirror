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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDFAC4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169F161037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbhHZVBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbhHZVBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA5C0613CF
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h9so9159841ejs.4
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzZKFUquloWLkACgCZyMkexVIJp5DtToCFEqde8R7+M=;
        b=YfVTceMDM6WzOOKSrgqb4OY13WClkHRZQLWsLPCatn1anNw+opMK6kyhRrrvePXqSk
         EmYMI7jEWZLT1oLU/ylv9IIND2GhKFu/gBFs6XFyM6ATozFZcDfH6zVGSUME7C17ESeU
         bMkwwT/7geTkIlhDesOJ2SCb39gZ26zY5oEuOyo6dwlpFaDIINXUfG7iCFpPboeATXlO
         7AfeQfsZ/Lv4KdhPeQA2lATCjUDGabOgZzjDDSWQxU0iglDj9Ag3Iqko1gEnXP0hLYRb
         zuBd1NZbq62FXnyaRW+x1aMppP5txgcj2os9uNkrK65gRQHiii7bg+IZ/L5u84U6EX7E
         GRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzZKFUquloWLkACgCZyMkexVIJp5DtToCFEqde8R7+M=;
        b=NTWd0Ym+UOgHf3/UxDHTKtmnXyHERjfsH9UgFzgrcHjeQdEJHsxnamR98TQVfivmpz
         GbTOvrPmMapyF4GzA0JvHA5grzOarlRCrvIaPaIFAjWENkj00YpqARfsgrt+fG/AFKfz
         /pbWm/T6OvaN9PjVW43gsIiSduOcmL67y/L5Ku+V2AosCHPIQAlpCqDx76VoCRfFyRE2
         Q2pYq4MNgOmL9qUuj6LvKvj5+h80upOl6juo1fU4J5lLZRiI82C/0Ip/R1DOak/XPjft
         hXIHLT02HIVIFCX5MX8f84AGZ0uVLOk0SjwKIjm5x2Q5NJNOj3PJdQakAPFHRvFV0wyp
         RMXw==
X-Gm-Message-State: AOAM532oKVhJGtWmIU7XF+GhR6XeFqz8CDVG3qpJtkC+xShUYAHKPFc3
        ZU0NxHV6vLtVITinGnkFdFHP6EYFqmI=
X-Google-Smtp-Source: ABdhPJzSP0o0Kr5ZUmHmqnp3P6O/s6L4aR2JoXWjlW2Z8JYeFEo3AHaOWhRUMg4MtDAhkVWiPOHYDw==
X-Received: by 2002:a17:907:9908:: with SMTP id ka8mr6261557ejc.164.1630011615974;
        Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/6] tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
Date:   Thu, 26 Aug 2021 23:00:03 +0200
Message-Id: <20210826210004.672860-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
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
index, but fixing those issues is beyond the scope of this patch
series.

[1] https://public-inbox.org/git/48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com/

[2] Neither of these test cases fail at the moment, because
    GIT_TEST_SPLIT_INDEX=1 is broken and never splits the index, and
    it broke long before the sparse index feature was added.
    This patch series is about to fix GIT_TEST_SPLIT_INDEX, and then
    both test cases mentioned above would fail.

(The diff is best viewed with '--ignore-all-space')

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 ++++++-----
 t/t7519-status-fsmonitor.sh        | 68 ++++++++++++++++--------------
 2 files changed, 51 insertions(+), 42 deletions(-)

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
index 6f2cf306f6..451734b9c2 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -399,41 +399,45 @@ check_sparse_index_behavior () {
 }
 
 test_expect_success 'status succeeds with sparse index' '
-	git clone . full &&
-	git clone . sparse &&
-	git -C sparse sparse-checkout init --cone --sparse-index &&
-	git -C sparse sparse-checkout set dir1 dir2 &&
+	(
+		sane_unset GIT_TEST_SPLIT_INDEX &&
 
-	write_script .git/hooks/fsmonitor-test <<-\EOF &&
-		printf "last_update_token\0"
-	EOF
-	git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
-	git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
-	check_sparse_index_behavior ! &&
+		git clone . full &&
+		git clone . sparse &&
+		git -C sparse sparse-checkout init --cone --sparse-index &&
+		git -C sparse sparse-checkout set dir1 dir2 &&
 
-	write_script .git/hooks/fsmonitor-test <<-\EOF &&
-		printf "last_update_token\0"
-		printf "dir1/modified\0"
-	EOF
-	check_sparse_index_behavior ! &&
-
-	git -C sparse sparse-checkout add dir1a &&
+		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+			printf "last_update_token\0"
+		EOF
+		git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
+		git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
+		check_sparse_index_behavior ! &&
 
-	for repo in full sparse
-	do
-		cp -r $repo/dir1 $repo/dir1a &&
-		git -C $repo add dir1a &&
-		git -C $repo commit -m "add dir1a" || return 1
-	done &&
-	git -C sparse sparse-checkout set dir1 dir2 &&
-
-	# This one modifies outside the sparse-checkout definition
-	# and hence we expect to expand the sparse-index.
-	write_script .git/hooks/fsmonitor-test <<-\EOF &&
-		printf "last_update_token\0"
-		printf "dir1a/modified\0"
-	EOF
-	check_sparse_index_behavior
+		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+			printf "last_update_token\0"
+			printf "dir1/modified\0"
+		EOF
+		check_sparse_index_behavior ! &&
+
+		git -C sparse sparse-checkout add dir1a &&
+
+		for repo in full sparse
+		do
+			cp -r $repo/dir1 $repo/dir1a &&
+			git -C $repo add dir1a &&
+			git -C $repo commit -m "add dir1a" || return 1
+		done &&
+		git -C sparse sparse-checkout set dir1 dir2 &&
+
+		# This one modifies outside the sparse-checkout definition
+		# and hence we expect to expand the sparse-index.
+		write_script .git/hooks/fsmonitor-test <<-\EOF &&
+			printf "last_update_token\0"
+			printf "dir1a/modified\0"
+		EOF
+		check_sparse_index_behavior
+	)
 '
 
 test_done
-- 
2.33.0.358.g803110d36e

