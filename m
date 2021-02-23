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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D372C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647464E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhBWUQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhBWUPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E7C061794
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so2301579wrs.12
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5iigrqOwj76r5bXCKC1LYHTsGQ9spzO+EGwZyXD+2fQ=;
        b=c4+/uhnHgUUmVvw5ksE6RRUpcfb7Tm4wq91x4nsRm17cGjrStWvLG4hE5UjjD97zPf
         7UQR6D+54jxsNe2qFih3j/7CM5HlkxpNqXIyGfkPkQaZisZaIKkG5kDFrXzmCa1qANtk
         8GFIpiyCpBHTkv2SLY8Rubu8XmOJ3j5AAjSRpPKEJFpXrhHucP783Xf9HSEaPyFlK9pF
         iqE8XvQv8vdTRu1KDxGlF7qwct+OCP1GoGQxYjwQk/r77PR63RkW5Qf5aJ0TJmttOzhp
         QWb9QOmdSiepoOBt2/pjSagrLprX4S07leIBgsBKy5uueGyrMGwIQULhaFFQ7UQnnU8w
         VDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5iigrqOwj76r5bXCKC1LYHTsGQ9spzO+EGwZyXD+2fQ=;
        b=rUm5LSdf/aj0YK0ty4VALEchKP93PymQW+4fLhXofk871bQZRo2psOzhtnI9nWS1Po
         oPRRpiSFsqmUVTmM1CZhQ7tNZRj846MCs6TdWsvrBeBqVWvyb6qUycsY0boYMcnS2w0Y
         4lXEneu5Ma6rrMt1Q354+Lz/10Gle13w+Q0+/LRo3D2iJe87WPAwF4nAnzuZOIEZvooN
         3Q/ta31i4ZggQv6Kxu7YcHg50xlLQyDvTb+Mv/9o44hUIzB9QI/ZyX5cgICArJh9xiXa
         Hef2dycUYf9jOrA2M4ILKMRlN85oU0wKVPEi7nghP5mUAGcYpZTW44rr0dApbKN3/qhk
         kIkA==
X-Gm-Message-State: AOAM532lEVve1zO7FvctpMUu8pHCfA9BIJqr6BF0kt6w/zFCA7dO33P+
        UONwWgvRfy2pyVjm55W0D5I6M+kBJdM=
X-Google-Smtp-Source: ABdhPJyaVmS5BXybujv4SUDtsmBWTYJ200INwQWu1qtn2z2k+oXRPc+QP1hqE2bKTdvMQPx2cbl/zA==
X-Received: by 2002:a5d:6403:: with SMTP id z3mr25531148wru.391.1614111274743;
        Tue, 23 Feb 2021 12:14:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm96797wmd.41.2021.02.23.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:34 -0800 (PST)
Message-Id: <c9910a37579c9a26f7721b60d82060e1766d050c.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:15 +0000
Subject: [PATCH 06/20] t1092: compare sparse-checkout to sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new 'sparse-index' repo alongside the 'full-checkout' and
'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
add run_on_sparse and test_sparse_match helpers. These helpers will be
used when the sparse index is implemented.

Add GIT_TEST_SPARSE_INDEX environment variable to enable the
sparse-index by default. This will be intended to use across the entire
test suite, except that it will only affect cases where the
sparse-checkout feature is enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/README                                 |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 593d4a4e270c..b98bc563aab5 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,9 @@ and "sha256".
 GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
 'pack.writeReverseIndex' setting.
 
+GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
+sparse-index format by default.
+
 Naming Tests
 ------------
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3725d3997e70..71d6f9e4c014 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
 test_expect_success 'setup' '
 	git init initial-repo &&
 	(
+		GIT_TEST_SPARSE_INDEX=0 &&
 		cd initial-repo &&
 		echo a >a &&
 		echo "after deep" >e &&
@@ -87,23 +88,32 @@ init_repos () {
 
 	cp -r initial-repo sparse-checkout &&
 	git -C sparse-checkout reset --hard &&
-	git -C sparse-checkout sparse-checkout init --cone &&
+
+	cp -r initial-repo sparse-index &&
+	git -C sparse-index reset --hard &&
 
 	# initialize sparse-checkout definitions
-	git -C sparse-checkout sparse-checkout set deep
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set deep &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
 }
 
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
+	) &&
+	(
+		cd sparse-index &&
+		GIT_TEST_SPARSE_INDEX=1 "$@" >../sparse-index-out 2>../sparse-index-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		"$@" >../full-checkout-out 2>../full-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 "$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse "$@"
 }
@@ -114,6 +124,12 @@ test_all_match () {
 	test_cmp full-checkout-err sparse-checkout-err
 }
 
+test_sparse_match () {
+	run_on_sparse $* &&
+	test_cmp sparse-checkout-out sparse-index-out &&
+	test_cmp sparse-checkout-err sparse-index-err
+}
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_all_match git status --porcelain=v2 &&
-- 
gitgitgadget

