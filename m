Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF23C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A9264F4D
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhCLWsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbhCLWsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA730C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:14 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f12so5117020qtq.4
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZCd0WVEbH2uS861P4ByTl4b94GgCLorVppX8wqpgI0=;
        b=SFwPGSOmCKIkqVLFjHNVvH6W3iPVb2Nfdc53G6ELyQgRZW0mAWQEHg7GKNvTZyv5UO
         t4qu2EyK5uLjzRoDNkbsW+DoLv+3qjMYN4a87+GyK0hGIjERf7DCRbOukPZPTr3wmtlC
         /h3YwsYRgnV7Btjo+iJTk3sFaplvOE+L3xtmPVFjZc30lzNGT8IBFiiJXKoiUD2t0GF4
         Ifq0UNTbm9cOvIzdhvrFd15rd6nJk00+MvVyVyBDIjcARP65BSZFPj9LADi55RTw1MZl
         gOP/G1gmjM7Eb8UCwV920xXchBjx9TGvx0wKkKiGbn3NOxJkr7lrOcYoXAIJq2nM1Lqj
         /ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZCd0WVEbH2uS861P4ByTl4b94GgCLorVppX8wqpgI0=;
        b=RGpuPDsLzyi490ceKLtqh/o+447/vCOV/QA1qkjzigM4uwU1F7mD4SRKTDitoJcoZw
         mzqtnmMMCeTgEC/kp1f0WtQEMt8WIJyJ3IU+uupzmxyrmJYVV47MoRHoUXn12IrgV8iO
         i8IeQ5h2r5Rj9FDmQ5QHL0BONF1PXdc9w6q0lbSB78/BF4gLLutZZ6vdqeINLBCTRePP
         s8oKPWaFQp5a9qH8n2GsMe5rju/3egAS6T+V9gOJsjo9q1V9YXR7mx8ZYkB+m2yM4YFv
         aG8osh1xaqpj0Ui8aydDHq2UqqHT7XoHcbJ3DxxRerUR8xUPG5nQf0fOhfeCjMk7LXc7
         FJhw==
X-Gm-Message-State: AOAM533GuX9s6vBakPBJj6uJP+XDf/RyB5RcJa+xVXmfxOqmrwXaYbgW
        zPeyZiOC/8S3S3VI3BDlEgus71chVz/9/Q==
X-Google-Smtp-Source: ABdhPJzP72jMzazALFamqo8dGkB6SY4pLSxHwR7z9WVF5fxV6dt5CEgIvlOPGmUKzpkMpGL2Wm2zGg==
X-Received: by 2002:ac8:4314:: with SMTP id z20mr14147925qtm.127.1615589293478;
        Fri, 12 Mar 2021 14:48:13 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:13 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 2/7] t3705: add tests for `git add` in sparse checkouts
Date:   Fri, 12 Mar 2021 19:47:57 -0300
Message-Id: <d93c3f51465a3e409819db63bd81802e7ef20ea9.1615588108.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
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

