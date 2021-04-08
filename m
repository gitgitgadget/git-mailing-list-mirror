Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB64C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08056113C
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhDHUlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhDHUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:41:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA079C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f12so2534628qtq.4
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZCd0WVEbH2uS861P4ByTl4b94GgCLorVppX8wqpgI0=;
        b=V8udL/fWGZFvgkcrw7KQ+8n1knIXAcw+/5rK1YYRA7mG7I5d+RaY/IOjBLIRZLsA2f
         mWGKfjHnVS/JFzVoMW7SBVo2hKuvLKvjS5xUNOVl+oqnQiYEXwpZJxT7HZr1zY7c9t3o
         hkAAlIjX31zWdlzM7bwzVVi+V51v6vL/jAe0L7GeuExfWjC9peR+1vtszRyFHg6vThrb
         aFJ/kqvHeXpTTee1o6ilHQ9lWTB0A7VhWFNVtq+HSsx6/PEyTMf03ejQ+GjOXPpdXRpj
         m+40kL5w6j0GYRuDHctiXiowZHrhx9x0ddIO2oeGj4PZDGR0YRYpAJxOkBRl66Hiy67f
         /1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZCd0WVEbH2uS861P4ByTl4b94GgCLorVppX8wqpgI0=;
        b=quNCIdZernbAs/DE6OLZXTSgQWqkbJGRdmroRcnM/5xHNF6ouafkIVJ5zzaYsRF/Mx
         +Ao41HnAnX/FShPwWw8brNRkaMs83fOEUbiERaDDPvdGQ4Rqy3wGq/hW0bIE7Ksd5mIA
         0f2FK6NwEmPVNhBD6mXyil/lXeRri4S1zOVFtlVh9l/YjzC43Mr5SKNYp47IGzHdujsx
         neerDFWS6Gphhw5es3qV/vRupo/VCox8yBUfuQbLGLrOorEHNE99Unz+BLcucKPSQBo7
         g2mIkIrMTdFM5XmSH29J4it96EWC5kX7//bfYKWoHuP7gtSgVYtbBlcMUnbUsVi1bx5R
         Q5Ww==
X-Gm-Message-State: AOAM530dYNqkCejk3XV6LHK9YtD8U/ah3iaLAu6j6GOSw8YIMQsP0g/P
        ady/U6fISUuHgkBei3SncXw20ky3fKohmA==
X-Google-Smtp-Source: ABdhPJzrO48z9vcvvosEgN18O3IlYfFrKuvbATtKqPJX6U+WKZKWv4O/Ps9I2RSHz2E/lzrs2Dd52w==
X-Received: by 2002:a05:622a:d0:: with SMTP id p16mr9102292qtw.219.1617914498685;
        Thu, 08 Apr 2021 13:41:38 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:38 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 2/7] t3705: add tests for `git add` in sparse checkouts
Date:   Thu,  8 Apr 2021 17:41:23 -0300
Message-Id: <5d0cdb3718ec0230fe199441b6a4089ce828a3e9.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
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
 t/t3705-add-sparse-checkout.sh   | 96 ++++++++++++++++++++++++++++++++
 t/t7012-skip-worktree-writing.sh | 19 -------
 2 files changed, 96 insertions(+), 19 deletions(-)
 create mode 100755 t/t3705-add-sparse-checkout.sh

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
new file mode 100755
index 0000000000..6c5b8be863
--- /dev/null
+++ b/t/t3705-add-sparse-checkout.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='git add in sparse checked out working trees'
+
+. ./test-lib.sh
+
+SPARSE_ENTRY_BLOB=""
+
+# Optionally take a printf format string to write to the sparse_entry file
+setup_sparse_entry () {
+	# 'sparse_entry' might already be in the index with the skip-worktree
+	# bit set. Remove it so that the subsequent git add can update it.
+	git update-index --force-remove sparse_entry &&
+	if test $# -eq 1
+	then
+		printf "$1" >sparse_entry
+	else
+		>sparse_entry
+	fi &&
+	git add sparse_entry &&
+	git update-index --skip-worktree sparse_entry &&
+	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
+}
+
+test_sparse_entry_unchanged () {
+	echo "100644 $SPARSE_ENTRY_BLOB 0	sparse_entry" >expected &&
+	git ls-files --stage sparse_entry >actual &&
+	test_cmp expected actual
+}
+
+setup_gitignore () {
+	test_when_finished rm -f .gitignore &&
+	cat >.gitignore <<-EOF
+	*
+	!/sparse_entry
+	EOF
+}
+
+test_expect_success 'git add does not remove sparse entries' '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	git add sparse_entry &&
+	test_sparse_entry_unchanged
+'
+
+test_expect_success 'git add -A does not remove sparse entries' '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	setup_gitignore &&
+	git add -A &&
+	test_sparse_entry_unchanged
+'
+
+test_expect_success 'git add . does not remove sparse entries' '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	setup_gitignore &&
+	git add . &&
+	test_sparse_entry_unchanged
+'
+
+for opt in "" -f -u --ignore-removal --dry-run
+do
+	test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
+		setup_sparse_entry &&
+		echo modified >sparse_entry &&
+		git add $opt sparse_entry &&
+		test_sparse_entry_unchanged
+	'
+done
+
+test_expect_success 'git add --refresh does not update sparse entries' '
+	setup_sparse_entry &&
+	git ls-files --debug sparse_entry | grep mtime >before &&
+	test-tool chmtime -60 sparse_entry &&
+	git add --refresh sparse_entry &&
+	git ls-files --debug sparse_entry | grep mtime >after &&
+	test_cmp before after
+'
+
+test_expect_failure 'git add --chmod does not update sparse entries' '
+	setup_sparse_entry &&
+	git add --chmod=+x sparse_entry &&
+	test_sparse_entry_unchanged &&
+	! test -x sparse_entry
+'
+
+test_expect_failure 'git add --renormalize does not update sparse entries' '
+	test_config core.autocrlf false &&
+	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
+	echo "sparse_entry text=auto" >.gitattributes &&
+	git add --renormalize sparse_entry &&
+	test_sparse_entry_unchanged
+'
+
+test_done
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index f2a8e76511..a1080b94e3 100755
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
2.30.1

