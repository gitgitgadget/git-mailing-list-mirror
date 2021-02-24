Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE4C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E7F64E57
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhBXEGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhBXEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7DC061786
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:26 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id r24so543293qtt.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJOyh2Z3wqRYU8jB7NJXwqBub8YTYWTgx8QbA+XydF0=;
        b=tzasNKl18eRTBhUs/j0LzwjoYjF8ONYvf9+UxHXhZwvYvNSMKciQEbycd3IZiGfCU7
         9CZMBf8AEXzEHPBgyqAZ0wiT/SnQWAkoWXcErHzaKDMBeFYK5CsbR/B2Z6FUTZQhLmEx
         Gzhf1v4gV0nplVBDVM67j9bmqkXs7XbXxRVF8eXl++0XNL5sh7QxgiDzMpAN7cl/CLly
         XujIsEhCH5kpY/bInKbX/ksbQm8pG2VS77csiXCTd/bwuKoty1uivLMLqzLL5zR+irJn
         wufmZnrVn9F3/6bDRpVN1x2OKZ0PaYB4rpMhpWq1fAJULq7/8cOC91OmaiC/6YCu6Kbf
         B4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJOyh2Z3wqRYU8jB7NJXwqBub8YTYWTgx8QbA+XydF0=;
        b=k83wqJT5pFWShVuJFLYV0ZrUSSA0FpUKpzWGhdPHgIARfZXFB/469JZ5HwFEd7Cc70
         2WPzgJRUtUgtjkrgQHz18a6icTuy7tno9K6cmQ8mI//ZN4GhBzJ0CkzW9UNhG+raQ7/s
         VhCS11g0Wjg8QiCjOUEVhHbyE5+DxHBQ9z2qEOMgPhEwQTThDvnGwtBS2oHgBGzc2/EZ
         99BdY5/n4o7YCr52KOynn0YQ1nkfI4yju8BAzXO95BTSKV7liTPPqcY8mojmp3PTCzvN
         N2hCiQ5RZuEn2PO/BYT6VA/sKSnbxXxeczoGkesLovsxOhq9Bxmf8saZZvxCSWtj2GCZ
         a8ww==
X-Gm-Message-State: AOAM531x8OYtqrFuVfdX6x3q3ZtPeAO5ll6xI6n27eNmzRSJ3XRYzcgQ
        SUtqZETpKLXlSYoffhKF3pMGkgSrausnPQ==
X-Google-Smtp-Source: ABdhPJw2S3j8c4vqO3ZQe1iXkzmTOedrzD5VHyVhFe43X9iiP9i6Li6cE8hES5WaK0fp/ToY0D4t8Q==
X-Received: by 2002:ac8:73d0:: with SMTP id v16mr5710100qtp.252.1614139525726;
        Tue, 23 Feb 2021 20:05:25 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 2/7] t3705: add tests for `git add` in sparse checkouts
Date:   Wed, 24 Feb 2021 01:05:07 -0300
Message-Id: <72b87870181d8bf72ce7bf86b5fae2e485fef9c0.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
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
index 0000000000..9bb5dc2389
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
+	rm -f sparse_entry &&
+	git update-index --force-remove sparse_entry &&
+
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
2.30.1

