Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCFC47255
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A3720746
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="bBU9PU67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgEJAmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 20:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbgEJAmG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 20:42:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4040C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 17:42:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l1so1423620qtp.6
        for <git@vger.kernel.org>; Sat, 09 May 2020 17:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+hzfjvL+iL2EzVuTRYQ0o3m0a05TU6kj0w2O8hl6Fw=;
        b=bBU9PU67yujvLo8waqgH0mdiV1Yt6B7kM1vwJR2AXf7h4asoifBmsufnFB+PdwVoCh
         /mFrY4TI3Zc0qY9ufunzE0pdnSc7tqDTI7udGMHMsYUj5zMgiHFu2c0L7NvCHPKlXO+5
         SO2kOpCc2jGJNUu0jykx1F11QVMfKHf5GV5E3i6I9V4e1RFPcjZB2MKnCf82DVBc7hD2
         JyU1wydW/UynxOwFBdnEe/NQbK0BaWP9Jk6LutDbrWAcFTKm8UoTf0VV7WhuzZW+BWyL
         +KHR1cXqlzipaZ6deIEaQBO9IbsznPli2UMO2m+avbvIu5zG6HNDhLtwC/I25QprNDNY
         szTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+hzfjvL+iL2EzVuTRYQ0o3m0a05TU6kj0w2O8hl6Fw=;
        b=qIWS9YJKgnuN+cdfuO2cmiJLhxsHiY1HchckqDNZB7F4Ub8Bxuz9RK/VA1xpLzeSm9
         7j0BJi8plpLJSBNzYzmQsQrnXkdrEmsYcg7fz38yQwLMq74Ya8N4UgLfi67Xj3vHkKs2
         nAr7zPvitmoeUzIw1PcujN3XjCPxkaKaQxRTIWAEKPHEzvX5sVKLhEEZMzBA7qzVAi8d
         fe3Bj9u13uwEFhVE0bGX2Xl28MPfLDsG9d1LLqYwr+cAyZ47UDWecui0TvuV8uKTINMQ
         XNLaJm0qZaJnwhn0SEChTCGxy7F1HesHSEu8AHwxbOhRxFy0fvIZRm4ZTPZOdfGkWPqc
         mj4A==
X-Gm-Message-State: AGi0PuYL7QYxWOF/lKrJJFKiaY3DVo/oxDG+FvPUDMSJjSMMNiF1PtzS
        RId1max6YXvcHQJSnGnV9dP55Uv0EzQ=
X-Google-Smtp-Source: APiQypITp6BBWgAEVjEbnFEvMIsiye6NtzQHrtr3YcgIdd4eQwmYwUYN4xRCXpZL0ohcEEqqSDmiXw==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr8254701qtk.192.1589071324319;
        Sat, 09 May 2020 17:42:04 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id s8sm5615974qtb.0.2020.05.09.17.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:42:03 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
Date:   Sat,  9 May 2020 21:41:29 -0300
Message-Id: <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589058209.git.matheus.bernardino@usp.br>
References: <cover.1589058209.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the main uses for a sparse checkout is to allow users to focus on
the subset of files in a repository in which they are interested. But
git-grep currently ignores the sparsity patterns and report all matches
found outside this subset, which kind of goes in the opposite direction.
Let's fix that, making it honor the sparsity boundaries for every
grepping case:

- git grep in worktree
- git grep --cached
- git grep $REVISION
- git grep --untracked and git grep --no-index (which already respect
  sparse checkout boundaries)

This is also what some users reported[1] they would want as the default
behavior.

Note: for `git grep $REVISION`, we will choose to honor the sparsity
patterns only when $REVISION is a commit-ish object. The reason is that,
for a tree, we don't know whether it represents the root of a
repository or a subtree. So we wouldn't be able to correctly match it
against the sparsity patterns. E.g. suppose we have a repository with
these two sparsity rules: "/*" and "!/a"; and the following structure:

/
| - a (file)
| - d (dir)
    | - a (file)

If `git grep $REVISION` were to honor the sparsity patterns for every
object type, when grepping the /d tree, we would wrongly ignore the /d/a
file. This happens because we wouldn't know it resides in /d and
therefore it would wrongly match the pattern "!/a". Furthermore, for a
search in a blob object, we wouldn't even have a path to check the
patterns against. So, let's ignore the sparsity patterns when grepping
non-commit-ish objects (tags to commits should be fine).

Finally, the old behavior may still be desirable for some use cases. So
the next patch will add an option to allow restoring it when needed.

[1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: as I mentioned in the cover letter, the tests in this patch now
contain both cone mode and full pattern sparse checkouts. This was done
for two reasons: To test grep's behavior when searching with
--recurse-submodules and having submodules with different pattern sets
than the superproject (which was incorrect in my first implementation).
And to test the direct pattern matching in grep_tree(), using both
modes.

 builtin/grep.c                   | 127 ++++++++++++++++++++++++++--
 t/t7011-skip-worktree-reading.sh |   9 --
 t/t7817-grep-sparse-checkout.sh  | 140 +++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+), 17 deletions(-)
 create mode 100755 t/t7817-grep-sparse-checkout.sh

diff --git a/builtin/grep.c b/builtin/grep.c
index a5056f395a..91ee0b2734 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -410,7 +410,7 @@ static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached);
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr);
+		     int is_root_tree);
 
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
@@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
+
+		if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
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
@@ -552,9 +555,78 @@ static int grep_cache(struct grep_opt *opt,
 	return hit;
 }
 
-static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
-		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr)
+static struct pattern_list *get_sparsity_patterns(struct repository *repo)
+{
+	struct pattern_list *patterns;
+	char *sparse_file;
+	int sparse_config, cone_config;
+
+	if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
+	    !sparse_config) {
+		return NULL;
+	}
+
+	sparse_file = repo_git_path(repo, "info/sparse-checkout");
+	patterns = xcalloc(1, sizeof(*patterns));
+
+	if (repo_config_get_bool(repo, "core.sparsecheckoutcone", &cone_config))
+		cone_config = 0;
+	patterns->use_cone_patterns = cone_config;
+
+	if (add_patterns_from_file_to_list(sparse_file, "", 0, patterns, NULL)) {
+		if (file_exists(sparse_file)) {
+			warning(_("failed to load sparse-checkout file: '%s'"),
+				sparse_file);
+		}
+		free(sparse_file);
+		free(patterns);
+		return NULL;
+	}
+
+	free(sparse_file);
+	return patterns;
+}
+
+static int in_sparse_checkout(struct strbuf *path, int prefix_len,
+			      unsigned int entry_mode,
+			      struct index_state *istate,
+			      struct pattern_list *sparsity,
+			      enum pattern_match_result parent_match,
+			      enum pattern_match_result *match)
+{
+	int dtype = DT_UNKNOWN;
+
+	if (S_ISGITLINK(entry_mode))
+		return 1;
+
+	if (parent_match == MATCHED_RECURSIVE) {
+		*match = parent_match;
+		return 1;
+	}
+
+	if (S_ISDIR(entry_mode) && !is_dir_sep(path->buf[path->len - 1]))
+		strbuf_addch(path, '/');
+
+	*match = path_matches_pattern_list(path->buf, path->len,
+					   path->buf + prefix_len, &dtype,
+					   sparsity, istate);
+	if (*match == UNDECIDED)
+		*match = parent_match;
+
+	if (S_ISDIR(entry_mode))
+		strbuf_trim_trailing_dir_sep(path);
+
+	if (*match == NOT_MATCHED && (S_ISREG(entry_mode) ||
+	    (S_ISDIR(entry_mode) && sparsity->use_cone_patterns)))
+		return 0;
+
+	return 1;
+}
+
+static int do_grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
+			struct tree_desc *tree, struct strbuf *base, int tn_len,
+			int check_attr, struct pattern_list *sparsity,
+			enum pattern_match_result default_sparsity_match)
 {
 	struct repository *repo = opt->repo;
 	int hit = 0;
@@ -570,6 +642,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
+		enum pattern_match_result sparsity_match = 0;
 
 		if (match != all_entries_interesting) {
 			strbuf_addstr(&name, base->buf + tn_len);
@@ -586,6 +659,19 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		strbuf_add(base, entry.path, te_len);
 
+		if (sparsity) {
+			struct strbuf path = STRBUF_INIT;
+			strbuf_addstr(&path, base->buf + tn_len);
+
+			if (!in_sparse_checkout(&path, old_baselen - tn_len,
+						entry.mode, repo->index,
+						sparsity, default_sparsity_match,
+						&sparsity_match)) {
+				strbuf_setlen(base, old_baselen);
+				continue;
+			}
+		}
+
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
@@ -602,8 +688,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
-			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr);
+			hit |= do_grep_tree(opt, pathspec, &sub, base, tn_len,
+					    check_attr, sparsity, sparsity_match);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
@@ -621,6 +707,31 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	return hit;
 }
 
+/*
+ * Note: sparsity patterns and paths' attributes will only be considered if
+ * is_root_tree has true value. (Otherwise, we cannot properly perform pattern
+ * matching on paths.)
+ */
+static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
+		     struct tree_desc *tree, struct strbuf *base, int tn_len,
+		     int is_root_tree)
+{
+	struct pattern_list *patterns = NULL;
+	int ret;
+
+	if (is_root_tree)
+		patterns = get_sparsity_patterns(opt->repo);
+
+	ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
+			   patterns, 0);
+
+	if (patterns) {
+		clear_pattern_list(patterns);
+		free(patterns);
+	}
+	return ret;
+}
+
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
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
index 0000000000..3bd67082eb
--- /dev/null
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -0,0 +1,140 @@
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
+`-- sub
+    |-- A
+    |   `-- a
+    `-- B
+	`-- b
+
+Where . has non-cone mode sparsity patterns and sub is a submodule with cone
+mode sparsity patterns. The resulting sparse-checkout should leave the following
+structure:
+
+.
+|-- a
+`-- sub
+    `-- B
+	`-- b
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
+	git submodule add ./sub &&
+	git add a b dir &&
+	git commit -m super &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set "/*" "!b" "!/*/" &&
+
+	git tag -am t-commit t-commit HEAD &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	git tag -am t-tree t-tree $tree &&
+
+	test_path_is_missing b &&
+	test_path_is_missing dir &&
+	test_path_is_missing sub/A &&
+	test_path_is_file a &&
+	test_path_is_file sub/B/b
+'
+
+test_expect_success 'grep in working tree should honor sparse checkout' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	git grep "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --cached should honor sparse checkout' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	git grep --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep <commit-ish> should honor sparse checkout' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect_commit <<-EOF &&
+	$commit:a:text
+	EOF
+	cat >expect_t-commit <<-EOF &&
+	t-commit:a:text
+	EOF
+	git grep "text" $commit >actual_commit &&
+	test_cmp expect_commit actual_commit &&
+	git grep "text" t-commit >actual_t-commit &&
+	test_cmp expect_t-commit actual_t-commit
+'
+
+test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
+	commit=$(git rev-parse HEAD) &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	cat >expect_tree <<-EOF &&
+	$tree:a:text
+	$tree:b:text
+	$tree:dir/c:text
+	EOF
+	cat >expect_t-tree <<-EOF &&
+	t-tree:a:text
+	t-tree:b:text
+	t-tree:dir/c:text
+	EOF
+	git grep "text" $tree >actual_tree &&
+	test_cmp expect_tree actual_tree &&
+	git grep "text" t-tree >actual_t-tree &&
+	test_cmp expect_t-tree actual_t-tree
+'
+
+test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	EOF
+	git grep --recurse-submodules --cached "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse checkout in submodule' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect_commit <<-EOF &&
+	$commit:a:text
+	$commit:sub/B/b:text
+	EOF
+	cat >expect_t-commit <<-EOF &&
+	t-commit:a:text
+	t-commit:sub/B/b:text
+	EOF
+	git grep --recurse-submodules "text" $commit >actual_commit &&
+	test_cmp expect_commit actual_commit &&
+	git grep --recurse-submodules "text" t-commit >actual_t-commit &&
+	test_cmp expect_t-commit actual_t-commit
+'
+
+test_done
-- 
2.26.2

