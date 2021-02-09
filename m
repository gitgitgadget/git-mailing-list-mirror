Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0862C4332E
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C431F64E50
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhBIW6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhBIWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:26 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB46C0698DB
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:33:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d85so19623889qkg.5
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18yutF5Ajl9ZMH8Z4XoZdyDMnK+A/D/G8gmQuWupRnQ=;
        b=xDb4hz2n9vYw2CEQV9Mj6Ka1Jq/GqDKkjmI/Xau1CUv/ZGaHakr06mR9VefgFdnr3h
         jnlu+U1F1DUEARUwfEm2yFlgqChzK6ldrMsSXs0o63EAMuz2hy3M88JJU0pJBt++bmMc
         xzcRN1Ou/0d25NG930Wcn7z+iL7uaY62sZnhU0AMS0DwHMprDxWnPGoeqnY3UKiTdtsP
         S2R+YRxCvpEQ+/pJINUsZvUu+KdaarH04YMTEHO0skkyqS+gpQ0tQZACxPGQCu9pBL/j
         XcLTYu9V3v+iqvNn10OUdWlWLq5B4cdae87/TLdeBqd4GUBq7ANatcjQPthyMj4lEQAQ
         hGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18yutF5Ajl9ZMH8Z4XoZdyDMnK+A/D/G8gmQuWupRnQ=;
        b=Gvvg7Dcmq7+S02pXcapGP/cHO5WyZD/CNOZt2tN9bDQUNqWU2p2/jtSCWF5tNWyZe/
         AYizoG/E0y7ZMro0UxOl44lrUTOgjSU1vBizku3UylDHswL/whC/7fpOFCqsHWb+rGfE
         USmElvl7PfCmXHLun8A58Ji9icuL5tzKZXEowboRHvKmrhXL6EAve1AMKIcNcUgszwRO
         mKx3LE/muvVA0q6goxDx+QcTNoJAPPgOPGH9+KFmt5Q0wj24rV3pLi7GNDCFMwtL/ExM
         yxmYmM4RmuFGTWjZSXOml8ar8wo9oVzAN1PnD26m0aJ/4PLTDTXymzX2W23vKsx36Ypm
         FVGw==
X-Gm-Message-State: AOAM533DzWQAbWbDN3RG6H3Mfnq7hIS9ymQ+C++Ctk2VeNjXWb6HnKeJ
        gyyt5nZFhG0TJRGGS5QEZxFXw02npDXvmw==
X-Google-Smtp-Source: ABdhPJxKNMqWSiiwx1jyAITwXg+WmrCBlCdB22OpGAjn5kXflgmoYJeRN6rhkdd2vgDp0rpBFY0tZQ==
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr130795qkj.347.1612906423871;
        Tue, 09 Feb 2021 13:33:43 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c127sm20562265qkd.87.2021.02.09.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:33:43 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com
Subject: [PATCH v7] grep: honor sparse-checkout on working tree searches
Date:   Tue,  9 Feb 2021 18:33:30 -0300
Message-Id: <5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a sparse checked out repository, `git grep` (without --cached) ends
up searching the cache when an entry matches the search pathspec and has
the SKIP_WORKTREE bit set. This is confusing both because the sparse
paths are not expected to be in a working tree search (as they are not
checked out), and because the output mixes working tree and cache
results without distinguishing them. (Note that grep also resorts to the
cache on working tree searches that include --assume-unchanged paths.
But the whole point in that case is to assume that the contents of the
index entry and the file are the same. This does not apply to the case
of sparse paths, where the file isn't even expected to be present.)

Fix that by teaching grep to honor the sparse-checkout rules for working
tree searches. If the user wants to grep paths outside the current
sparse-checkout definition, they may either update the sparsity rules to
materialize the files, or use --cached to search all blobs registered in
the index.

Note: it might also be interesting to add a configuration option that
allow users to search paths that are present despite having the
SKIP_WORKTREE bit set, and/or to restrict searches in the index and past
revisions too. These ideas are left as future improvements to avoid
conflicting with other sparse-checkout topics currently in flight.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

This new version includes only the bug fix for the working tree grep, as
discussed in [1]. I think there are a couple other patches that could be
extracted from the previous v6 [2] and sent as standalone topics,
without the risk of conflicting with the sparse-index work. E.g. the
unification of the git-grep.txt and config/grep.txt doc files. I'll look
into that tomorrow.

[1]: https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/
[2]: https://lore.kernel.org/git/cover.1599758167.git.matheus.bernardino@usp.br/

 builtin/grep.c                   |   7 +-
 t/t7011-skip-worktree-reading.sh |   9 --
 t/t7817-grep-sparse-checkout.sh  | 174 +++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 11 deletions(-)
 create mode 100755 t/t7817-grep-sparse-checkout.sh

diff --git a/builtin/grep.c b/builtin/grep.c
index ca259af441..bff214c755 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
+
+		if (!cached && ce_skip_worktree(ce))
+			continue;
+
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
 
@@ -520,8 +524,7 @@ static int grep_cache(struct grep_opt *opt,
 			 * cache entry are identical, even if worktree file has
 			 * been modified, so use cache version instead
 			 */
-			if (cached || (ce->ce_flags & CE_VALID) ||
-			    ce_skip_worktree(ce)) {
+			if (cached || (ce->ce_flags & CE_VALID)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
 				hit |= grep_oid(opt, &ce->oid, name.buf,
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 37525cae3a..26852586ac 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -109,15 +109,6 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
 
-test_expect_success 'grep with skip-worktree file' '
-	git update-index --no-skip-worktree 1 &&
-	echo test > 1 &&
-	git update-index 1 &&
-	git update-index --skip-worktree 1 &&
-	rm 1 &&
-	test "$(git grep --no-ext-grep test)" = "1:test"
-'
-
 echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
new file mode 100755
index 0000000000..590b99bbb6
--- /dev/null
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+
+test_description='grep in sparse checkout
+
+This test creates a repo with the following structure:
+
+.
+|-- a
+|-- b
+|-- dir
+|   `-- c
+|-- sub
+|   |-- A
+|   |   `-- a
+|   `-- B
+|       `-- b
+`-- sub2
+    `-- a
+
+Where the outer repository has non-cone mode sparsity patterns, sub is a
+submodule with cone mode sparsity patterns and sub2 is a submodule that is
+excluded by the superproject sparsity patterns. The resulting sparse checkout
+should leave the following structure in the working tree:
+
+.
+|-- a
+|-- sub
+|   `-- B
+|       `-- b
+`-- sub2
+    `-- a
+
+But note that sub2 should have the SKIP_WORKTREE bit set.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "text" >a &&
+	echo "text" >b &&
+	mkdir dir &&
+	echo "text" >dir/c &&
+
+	git init sub &&
+	(
+		cd sub &&
+		mkdir A B &&
+		echo "text" >A/a &&
+		echo "text" >B/b &&
+		git add A B &&
+		git commit -m sub &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set B
+	) &&
+
+	git init sub2 &&
+	(
+		cd sub2 &&
+		echo "text" >a &&
+		git add a &&
+		git commit -m sub2
+	) &&
+
+	git submodule add ./sub &&
+	git submodule add ./sub2 &&
+	git add a b dir &&
+	git commit -m super &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set "/*" "!b" "!/*/" "sub" &&
+
+	git tag -am tag-to-commit tag-to-commit HEAD &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	git tag -am tag-to-tree tag-to-tree $tree &&
+
+	test_path_is_missing b &&
+	test_path_is_missing dir &&
+	test_path_is_missing sub/A &&
+	test_path_is_file a &&
+	test_path_is_file sub/B/b &&
+	test_path_is_file sub2/a &&
+	git branch -m main
+'
+
+# The test below covers a special case: the sparsity patterns exclude '/b' and
+# sparse checkout is enabled, but the path exists in the working tree (e.g.
+# manually created after `git sparse-checkout init`). git grep should skip it.
+test_expect_success 'working tree grep honors sparse checkout' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	test_when_finished "rm -f b" &&
+	echo "new-text" >b &&
+	git grep "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep searches unmerged file despite not matching sparsity patterns' '
+	cat >expect <<-EOF &&
+	b:modified-b-in-branchX
+	b:modified-b-in-branchY
+	EOF
+	test_when_finished "test_might_fail git merge --abort && \
+			    git checkout main && git sparse-checkout init" &&
+
+	git sparse-checkout disable &&
+	git checkout -b branchY main &&
+	test_commit modified-b-in-branchY b &&
+	git checkout -b branchX main &&
+	test_commit modified-b-in-branchX b &&
+
+	git sparse-checkout init &&
+	test_path_is_missing b &&
+	test_must_fail git merge branchY &&
+	git grep "modified-b" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	EOF
+	git grep --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+# Note that sub2/ is present in the worktree but it is excluded by the sparsity
+# patterns, so grep should not recurse into it.
+test_expect_success 'grep --recurse-submodules honors sparse checkout in submodule' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	EOF
+	git grep --recurse-submodules "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	sub/A/a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	git grep --recurse-submodules --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'working tree grep does not search the index with CE_VALID and SKIP_WORKTREE' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	test_when_finished "git update-index --no-assume-unchanged b" &&
+	git update-index --assume-unchanged b &&
+	git grep text >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	EOF
+	test_when_finished "git update-index --no-assume-unchanged b" &&
+	git update-index --assume-unchanged b &&
+	git grep --cached text >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.29.2

