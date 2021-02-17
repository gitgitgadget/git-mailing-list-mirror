Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB350C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B433364E6C
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhBQVDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhBQVDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:25 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522BC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:45 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c1so10671631qtc.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+OJz8Iv5iYp8p/t2dzMNItfqnDP61/r9KGhG/p85xQ=;
        b=D1Fne5lraj1+ZrCMUMNEaFAMbh15qdn+0s00cAxtM5vGKxpurq/+3Ozgo915I1nHjX
         4pixQh+qkXRmjn3RA4nW6tsaOH8A6lBZATW225MEnR3iGoeO2e+Bw6bxpCa5InnRoYMM
         cOrS2Xtw4m3Bd4a8zEzgYtv/SXyzzs5XfS5e+5yrPPe3UbfRYDkhOVPz1eeC6PVgHH0W
         pe01RVdyX2OGU3M6+HjYP8mxeYONH/qNMfzEjHBXTvjIuDp3OnpoIt6leJdanRblfU3O
         FcXD0CtXVplfiUYvgxvpdpCUaj6Yk5xZmBRDGR4Zr8fRE7Imk85szuBfGi4bpuW/s0Xt
         kcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+OJz8Iv5iYp8p/t2dzMNItfqnDP61/r9KGhG/p85xQ=;
        b=L069neHz54J3Eqd8DCXDwNgU/wM3t4CYs88jZ24Z+b2KQRX3wl5TuIGzqgvmAjebsk
         HxfZdLh7tmOh9V7ALjYnONOpol6MqNLqIBLeDSGPWfybwlYC2lpE3JiCIspPvFV9V3SW
         JgEBI3boo+6jbFTzaI25fFOjem0h2yeQSA+sqVriyymq5KDk4yCtxysBWwy3rQhonWfd
         bYjZ1YPEfzG6wW9oAukesZwtIE9pstXjCAZk3ckNAN7KFHUDH/czi3K23GcOpbBnqVqR
         EXBV6V0JNoIW3TfOSL9ZX1wX8LHADZjqOrwwhkIu4emv2S3XezbWQSa60bEGxi2HkBFd
         5QoA==
X-Gm-Message-State: AOAM533jRhWPMVqhLOsc26RgJ1FKRDXTD2O1KXx913dWg2KOSe8gu95g
        OH/FiEGp+cbpdukyE1li9gwJDqZiXYdRLg==
X-Google-Smtp-Source: ABdhPJxPx43F0RU2rUKUv0QUl1U3b8Y9evBdjJRZond3zeaRb/zA147qRaGQvTQt0dNBP/kFlGe5sQ==
X-Received: by 2002:ac8:110d:: with SMTP id c13mr1116980qtj.361.1613595763317;
        Wed, 17 Feb 2021 13:02:43 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:42 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
Date:   Wed, 17 Feb 2021 18:02:26 -0300
Message-Id: <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have a couple tests for `add` with SKIP_WORKTREE entries in
t7012, but these only cover the most basic scenarios. As we will be
changing how `add` deals with sparse paths in the subsequent commits,
let's move these two tests to their own file and add more test cases
for different `add` options and situations. This also demonstrates two
options that don't currently respect SKIP_WORKTREE entries: `--chmod`
and `--renormalize`.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t3705-add-sparse-checkout.sh   | 92 ++++++++++++++++++++++++++++++++
 t/t7012-skip-worktree-writing.sh | 19 -------
 2 files changed, 92 insertions(+), 19 deletions(-)
 create mode 100755 t/t3705-add-sparse-checkout.sh

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
new file mode 100755
index 0000000000..5530e796b5
--- /dev/null
+++ b/t/t3705-add-sparse-checkout.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='git add in sparse checked out working trees'
+
+. ./test-lib.sh
+
+SPARSE_ENTRY_BLOB=""
+
+# Optionally take a string for the entry's contents
+setup_sparse_entry()
+{
+	if test -f sparse_entry
+	then
+		rm sparse_entry
+	fi &&
+	git update-index --force-remove sparse_entry &&
+
+	if test "$#" -eq 1
+	then
+		printf "$1" >sparse_entry
+	else
+		printf "" >sparse_entry
+	fi &&
+	git add sparse_entry &&
+	git update-index --skip-worktree sparse_entry &&
+	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
+}
+
+test_sparse_entry_unchanged() {
+	echo "100644 $SPARSE_ENTRY_BLOB 0	sparse_entry" >expected &&
+	git ls-files --stage sparse_entry >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success "git add does not remove SKIP_WORKTREE entries" '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	git add sparse_entry &&
+	test_sparse_entry_unchanged
+'
+
+test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	git add -A &&
+	test_sparse_entry_unchanged
+'
+
+for opt in "" -f -u --ignore-removal
+do
+	if test -n "$opt"
+	then
+		opt=" $opt"
+	fi
+
+	test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
+		setup_sparse_entry &&
+		echo modified >sparse_entry &&
+		git add $opt sparse_entry &&
+		test_sparse_entry_unchanged
+	'
+done
+
+test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
+	setup_sparse_entry &&
+	test-tool chmtime -60 sparse_entry &&
+	git add --refresh sparse_entry &&
+
+	# We must unset the SKIP_WORKTREE bit, otherwise
+	# git diff-files would skip examining the file
+	git update-index --no-skip-worktree sparse_entry &&
+
+	echo sparse_entry >expected &&
+	git diff-files --name-only sparse_entry >actual &&
+	test_cmp actual expected
+'
+
+test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
+	setup_sparse_entry &&
+	git add --chmod=+x sparse_entry &&
+	test_sparse_entry_unchanged
+'
+
+test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
+	test_config core.autocrlf false &&
+	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
+	echo "sparse_entry text=auto" >.gitattributes &&
+	git add --renormalize sparse_entry &&
+	test_sparse_entry_unchanged
+'
+
+test_done
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index e5c6a038fb..217207c1ce 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -60,13 +60,6 @@ setup_absent() {
 	git update-index --skip-worktree 1
 }
 
-test_absent() {
-	echo "100644 $EMPTY_BLOB 0	1" > expected &&
-	git ls-files --stage 1 > result &&
-	test_cmp expected result &&
-	test ! -f 1
-}
-
 setup_dirty() {
 	git update-index --force-remove 1 &&
 	echo dirty > 1 &&
@@ -100,18 +93,6 @@ test_expect_success 'index setup' '
 	test_cmp expected result
 '
 
-test_expect_success 'git-add ignores worktree content' '
-	setup_absent &&
-	git add 1 &&
-	test_absent
-'
-
-test_expect_success 'git-add ignores worktree content' '
-	setup_dirty &&
-	git add 1 &&
-	test_dirty
-'
-
 test_expect_success 'git-rm fails if worktree is dirty' '
 	setup_dirty &&
 	test_must_fail git rm 1 &&
-- 
2.29.2

