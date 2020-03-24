Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDBC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3720719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="epw03nl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCXGM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:12:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35489 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgCXGM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:12:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so6451671qki.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXCt8BpbiW5JV9p7EczOAeemxkBcbNe4+H4R3AYAdU4=;
        b=epw03nl9id5En/hG3HK2r7YJdsC5kVT3FpDPbzkx3AWREsR0e+fsBCqaRKctKVw4Q/
         o7jScFR3VkeXwaybTQ3qkd3677urob3/g2KMPfkJqbMKODn8k0dodlmTCfeVS958N7Mf
         8zNXbODuOt65xhhaaGcoQ0v/Jp56v+g9Wia0paoYoCrvInmo/fHx1CB3/yR4sDt+q/vW
         Q+P4lQlvFUFptBulWqpkiJs+NXE/yYg+S3ED4f3s8EzAu+bfRoVMDUOgnjnAyRRFnyDh
         4It8hv7jQ09CcDfhwtd4sI1vlF1dZL6I8Xs2EV0XyLweGOMkipkqYlRaSDVsd5DJyUzZ
         4h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXCt8BpbiW5JV9p7EczOAeemxkBcbNe4+H4R3AYAdU4=;
        b=mfgHwE2c4GB+LPBUUhDXVsucXMr4qUC8ij5G3MFybJ+lY6FCXIXI/bxEaFAQj5aapF
         tCgZMPwdsaF5diw+fZxhAn7KiPaCtz+N25ajSfrdogwXYhgdyakITgZWsd58nmYruHG0
         0iNDCsnAAZauVuYqaqzK5u9Ei+Z6pvVU+3UIe2m3gOUhj6pElP8oYpGp5Xb6LykQQMhu
         MUEZdREcAYBLU0GlLw60J7ZROydPnH2vJgoVNf8ykT/xB/9gtpbnU0SOG1xtgI6Ule7q
         /NWjuGX97ZqOyYTop+s9NGm7OzP59QaTawx9BRcwkd3fVA0YdSpG9B3xP3I/B8hN7Rgx
         SefA==
X-Gm-Message-State: ANhLgQ2O1Z31jV8wiqzXa5baO/lWZ0rnQJ759QZqvukXJe570bWd1ldi
        Ga8uy7LNpWkjarvcY+Plg/hCvEYyVn4=
X-Google-Smtp-Source: ADFU+vtSza3usmUTxyf+Q6cI+Vlpqz6TNsp80yQShqB9KUH1XEC6td9+Mz/6+SzyiQd9m8uCNDlbSQ==
X-Received: by 2002:ae9:f007:: with SMTP id l7mr24942191qkg.11.1585030377685;
        Mon, 23 Mar 2020 23:12:57 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id g49sm13913719qtk.1.2020.03.23.23.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:12:57 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, newren@gmail.com,
        sandals@crustytoothpaste.net, stefanbeller@gmail.com
Subject: [RFC PATCH 2/3] grep: honor sparse checkout patterns
Date:   Tue, 24 Mar 2020 03:12:46 -0300
Message-Id: <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585027716.git.matheus.bernardino@usp.br>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the main uses for a sparse checkout is to allow users to focus on
the subset of files in a repository in which they are interested. But
git-grep currently ignores the sparsity patterns and report all matches
found outside this subset, which kind of goes in the oposity direction.
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

Finally, the old behavior is still desirable for some use cases. So the
next patch will add an option to allow restoring it when needed.

[1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Something I'm not entirely sure in this patch is how we implement the
mechanism to honor sparsity for the `git grep <commit-ish>` case (which
is treated in the grep_tree() function). Currently, the patch looks for
an index entry that matches the path, and then checks its skip_worktree
bit. But this operation is perfomed in O(log(N)); N being the number of
index entries. If there are many entries (and no so many sparsity
patterns), maybe a better approach would be to try matching the path
directly against the sparsity patterns. This would be O(M) in the number
of patterns, and it could be done, in builtin/grep.c, with a function
like the following:

static struct pattern_list sparsity_patterns;
static int sparsity_patterns_initialized = 0;
static enum pattern_match_result path_matches_sparsity_patterns(
					const char *path, int pathlen,
					const char *basename,
					struct repository *repo)
{
	int dtype = DT_UNKNOWN;

	if (!sparsity_patterns_initialized) {
		char *sparse_file = git_pathdup("info/sparse-checkout");
		int ret;

		memset(&sparsity_patterns, 0, sizeof(sparsity_patterns));
		sparsity_patterns.use_cone_patterns = core_sparse_checkout_cone;
		ret = add_patterns_from_file_to_list(sparse_file, "", 0,
						     &sparsity_patterns, NULL);
		free(sparse_file);

		if (ret < 0)
			die(_("failed to load sparse-checkout patterns"));
		sparsity_patterns_initialized = 1;
	}

	return path_matches_pattern_list(path, pathlen, basename, &dtype,
					 &sparsity_patterns, repo->index);
}

Also, if I understand correctly, the index doesn't hold paths to dirs,
right? So even if a complete dir is excluded from sparse checkout, we
still have to check all its subentries, only to discover that they
should all be skipped from the search. However, if we were to check
against the sparsity patterns directly (e.g. with the function above),
we could skip such directories together with all their entries.

Oh, and there is also the case of a commit whose tree paths are not in
the index (maybe manually created objects?). For such commits, with the
index lookup approach, we would have to fall back on ignoring the
sparsity rules. I'm not sure if that would be OK, though.

Any thoughts on these two approaches (looking up the skip_worktree bit
in the index or directly matching against sparsity patterns), will be
highly appreciated. (Note that it only concerns the `git grep
<commit-ish>` case. The other cases already iterate thought the index, so
there is no O(log(N)) extra complexity).

 builtin/grep.c                   | 29 ++++++++---
 t/t7011-skip-worktree-reading.sh |  9 ----
 t/t7817-grep-sparse-checkout.sh  | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 15 deletions(-)
 create mode 100755 t/t7817-grep-sparse-checkout.sh

diff --git a/builtin/grep.c b/builtin/grep.c
index 99e2685090..52ec72a036 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -388,7 +388,7 @@ static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached);
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr);
+		     int from_commit);
 
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
@@ -486,6 +486,10 @@ static int grep_cache(struct grep_opt *opt,
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
+
+		if (ce_skip_worktree(ce))
+			continue;
+
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
 
@@ -498,8 +502,7 @@ static int grep_cache(struct grep_opt *opt,
 			 * cache entry are identical, even if worktree file has
 			 * been modified, so use cache version instead
 			 */
-			if (cached || (ce->ce_flags & CE_VALID) ||
-			    ce_skip_worktree(ce)) {
+			if (cached || (ce->ce_flags & CE_VALID)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
 				hit |= grep_oid(opt, &ce->oid, name.buf,
@@ -532,7 +535,7 @@ static int grep_cache(struct grep_opt *opt,
 
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr)
+		     int from_commit)
 {
 	struct repository *repo = opt->repo;
 	int hit = 0;
@@ -546,6 +549,9 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		name_base_len = name.len;
 	}
 
+	if (from_commit && repo_read_index(repo) < 0)
+		die(_("index file corrupt"));
+
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
@@ -564,9 +570,20 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		strbuf_add(base, entry.path, te_len);
 
+		if (from_commit) {
+			int pos = index_name_pos(repo->index,
+						 base->buf + tn_len,
+						 base->len - tn_len);
+			if (pos >= 0 &&
+			    ce_skip_worktree(repo->index->cache[pos])) {
+				strbuf_setlen(base, old_baselen);
+				continue;
+			}
+		}
+
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
-					 check_attr ? base->buf + tn_len : NULL);
+					from_commit ? base->buf + tn_len : NULL);
 		} else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
@@ -581,7 +598,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr);
+					 from_commit);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
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
index 0000000000..fccf44e829
--- /dev/null
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='grep in sparse checkout
+
+This test creates the following dir structure:
+.
+| - a
+| - b
+| - dir
+    | - c
+
+Only "a" should be present due to the sparse checkout patterns:
+"/*", "!/b" and "!/dir".
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "text" >a &&
+	echo "text" >b &&
+	mkdir dir &&
+	echo "text" >dir/c &&
+	git add a b dir &&
+	git commit -m "initial commit" &&
+	git tag -am t-commit t-commit HEAD &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	git tag -am t-tree t-tree $tree &&
+	cat >.git/info/sparse-checkout <<-EOF &&
+	/*
+	!/b
+	!/dir
+	EOF
+	git sparse-checkout init &&
+	test_path_is_missing b &&
+	test_path_is_missing dir &&
+	test_path_is_file a
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
+test_expect_success 'grep <tree-ish> should search outside sparse checkout' '
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
+test_done
-- 
2.25.1

