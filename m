Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE8C2BAEE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4102120719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="DwFZyo9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCXGNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:13:54 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33505 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgCXGNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:13:54 -0400
Received: by mail-qv1-f66.google.com with SMTP id p19so6082268qve.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 23:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1muIyoRBk26lIUFtrujVeNYGHskovTTxo+TfZCz5xeg=;
        b=DwFZyo9DTMW/7j24fu7TOr/vCRZL/m1rAOOTkFTzQDo6KrkABr/JDDkEIYcasLw72k
         1raEAXJI3JQsRmFBcVzhC4OZpLyvmhO2qqbcA9zG9DXn/UgLhXhotRQLF4UYX7jKX9Jg
         vqqUvqOpPwaGFo8/D3uuaGB7/vChN1VygdhnHYvTnmpEW+Kgzs6pMBEPFA5yJpElFXah
         gcVIWeQWAvB1ASlr3wkbNAxjJIFQhPmAbI+Sda6QSqg9Ul556FlyjzWt6m85DorwK25b
         fmPBOv9t8rwIb8JsByT5aR9IortJgg/+uWrMO+SdlWr3IdFhEpZe54iPXDWrZNWwdeEB
         SnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1muIyoRBk26lIUFtrujVeNYGHskovTTxo+TfZCz5xeg=;
        b=fSpUF10yHHMpIzcHBR4/UnBkGQG2cluefoF1ja/VP39iWWJ9H6tN1kgcWWHnSEshYF
         ojBJz+e0Unxwo7NU0OXtMyC0uZ7Na1QkHqc/PaefioKh6ZfeCxcUSyn8HG+tfJdI6/l9
         8N6Xa8zocb3SP9W4ouJCeFcHNwHGiZBsSpRAzqsDa9ZEzekf4TU/Jcn5SfSd1NtP1Wix
         3IwwwPEneFRxr5j1Xs+tCqj44HZZsUh7dDCKu/6M1EOOSgeR/PPVdTkLHZHr4xt/At3V
         TIA1O/2oDqOqs/h4pnc+vlILmW/eEZlQ8H02tzAo+bx7oSSTN36RD26Ait7QIdqSRuwN
         gkpw==
X-Gm-Message-State: ANhLgQ2ZKYGikLd5nKn4nBrRr6jf3e0hpV7jhJjOAGTM4Z3rkqNN+oqj
        mS22r4yN7rni5BkCZWaJoSfACfp3MdE=
X-Google-Smtp-Source: ADFU+vv9OhT1Dt2SzY6d/wycklyEcruEgV/TzauweNPww60Px4NdnpJD6uJMmS4+PyC6PQQnLlDqdw==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr24426387qva.139.1585030432005;
        Mon, 23 Mar 2020 23:13:52 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id o67sm12130871qka.114.2020.03.23.23.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:13:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, newren@gmail.com, pclouds@gmail.com
Subject: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
Date:   Tue, 24 Mar 2020 03:13:44 -0300
Message-Id: <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585027716.git.matheus.bernardino@usp.br>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the last commit, git-grep learned to honor sparsity patterns. For
some use cases, however, it may be desirable to search outside the
sparse checkout. So add the '--ignore-sparsity' option, which restores
the old behavior. Also add the grep.ignoreSparsity configuration, to
allow setting this behavior by default.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: I still have to make --ignore-sparsity be able to work together
with --untracked. Unfortunatelly, this won't be as simple because the
codeflow taken by --untracked goes to grep_directory() which just
iterates the working tree, without looking the index entries. So I will
have to either: make --untracked use grep_cache(), and grep the
untracked files later; or try matching the working tree paths against
the sparsity patterns, without looking for the skip_worktree bit in
the index (as I mentioned in the previous patch's comments). Any
preferences regarding these two approaches? (or other suggestions?)

 Documentation/config/grep.txt   |  3 +++
 Documentation/git-grep.txt      |  5 ++++
 builtin/grep.c                  | 19 +++++++++++----
 t/t7817-grep-sparse-checkout.sh | 42 +++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 76689771aa..c1d49484c8 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -25,3 +25,6 @@ grep.fullName::
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
+
+grep.ignoreSparsity::
+	If set to true, enable `--ignore-sparsity` by default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 97e25d7b1b..5c5c66c056 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -65,6 +65,11 @@ OPTIONS
 	mechanism.  Only useful when searching files in the current directory
 	with `--no-index`.
 
+--ignore-sparsity::
+	In a sparse checked out repository (see linkgit:git-sparse-checkout[1]),
+	also search in files that are outside the sparse checkout. This option
+	cannot be used with --no-index or --untracked.
+
 --recurse-submodules::
 	Recursively search in each submodule that has been initialized and
 	checked out in the repository.  When used in combination with the
diff --git a/builtin/grep.c b/builtin/grep.c
index 52ec72a036..17eae3edd6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -33,6 +33,8 @@ static char const * const grep_usage[] = {
 
 static int recurse_submodules;
 
+static int ignore_sparsity = 0;
+
 static int num_threads;
 
 static pthread_t *threads;
@@ -292,6 +294,9 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "submodule.recurse"))
 		recurse_submodules = git_config_bool(var, value);
 
+	if (!strcmp(var, "grep.ignoresparsity"))
+		ignore_sparsity = git_config_bool(var, value);
+
 	return st;
 }
 
@@ -487,7 +492,7 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (ce_skip_worktree(ce))
+		if (!ignore_sparsity && ce_skip_worktree(ce))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -502,7 +507,8 @@ static int grep_cache(struct grep_opt *opt,
 			 * cache entry are identical, even if worktree file has
 			 * been modified, so use cache version instead
 			 */
-			if (cached || (ce->ce_flags & CE_VALID)) {
+			if (cached || (ce->ce_flags & CE_VALID) ||
+			    ce_skip_worktree(ce)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
 				hit |= grep_oid(opt, &ce->oid, name.buf,
@@ -549,7 +555,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		name_base_len = name.len;
 	}
 
-	if (from_commit && repo_read_index(repo) < 0)
+	if (!ignore_sparsity && from_commit && repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
 	while (tree_entry(tree, &entry)) {
@@ -570,7 +576,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		strbuf_add(base, entry.path, te_len);
 
-		if (from_commit) {
+		if (!ignore_sparsity && from_commit) {
 			int pos = index_name_pos(repo->index,
 						 base->buf + tn_len,
 						 base->len - tn_len);
@@ -932,6 +938,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "ignore-sparsity", &ignore_sparsity,
+			 N_("also search in files outside the sparse checkout")),
 		OPT_END()
 	};
 
@@ -1073,6 +1081,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && untracked)
 		die(_("--untracked not supported with --recurse-submodules"));
 
+	if (ignore_sparsity && (!use_index || untracked))
+		die(_("--no-index or --untracked cannot be used with --ignore-sparsity"));
+
 	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index fccf44e829..1891ddea57 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -85,4 +85,46 @@ test_expect_success 'grep <tree-ish> should search outside sparse checkout' '
 	test_cmp expect_t-tree actual_t-tree
 '
 
+for cmd in 'git grep --ignore-sparsity' 'git -c grep.ignoreSparsity grep' \
+	   'git -c grep.ignoreSparsity=false grep --ignore-sparsity'
+do
+	test_expect_success "$cmd should search outside sparse checkout" '
+		cat >expect <<-EOF &&
+		a:text
+		b:text
+		dir/c:text
+		EOF
+		$cmd "text" >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --cached should search outside sparse checkout" '
+		cat >expect <<-EOF &&
+		a:text
+		b:text
+		dir/c:text
+		EOF
+		$cmd --cached "text" >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd <commit-ish> should search outside sparse checkout" '
+		commit=$(git rev-parse HEAD) &&
+		cat >expect_commit <<-EOF &&
+		$commit:a:text
+		$commit:b:text
+		$commit:dir/c:text
+		EOF
+		cat >expect_t-commit <<-EOF &&
+		t-commit:a:text
+		t-commit:b:text
+		t-commit:dir/c:text
+		EOF
+		$cmd "text" $commit >actual_commit &&
+		test_cmp expect_commit actual_commit &&
+		$cmd "text" t-commit >actual_t-commit &&
+		test_cmp expect_t-commit actual_t-commit
+	'
+done
+
 test_done
-- 
2.25.1

