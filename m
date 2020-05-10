Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E8C47255
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888FD20746
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Sosri7c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgEJAl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgEJAl7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 20:41:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67200C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 17:41:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so4161338qtt.1
        for <git@vger.kernel.org>; Sat, 09 May 2020 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6roW1I7jJXJ7O9+bLa2VhPQ6zBaIEv8wAtmcq9H6us=;
        b=Sosri7c4vKLZTPrl9i2D3UHy2/hzvlpJu5FKIPc5i5A6rPdqqj92+DuZuwHoYy2vzR
         GwjDRW+r0eajkLDAqhtFHkFQYJblopruZItDzqWfoxCM0lVbDb4WOGDro84JWP7izFA5
         4vM1GsRrbFQUz+FLhw6pkxO8Ob0lERj3Fv9nJILhx/t/iTITOVNVpRLCyU8UiaI8G8bo
         DqsDhrlXA5glKP5efi73Zby1ytE/vrCp9qj2PeGvnddxX7WxtiS8LWjEqBnZYhaJKmZD
         OsybPFPLD9jM2+wgY/+phLn9L+CEgfrI9A5XM42I8Ao4KL/85AMqnbD8KHv4kEUD8dzD
         TbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6roW1I7jJXJ7O9+bLa2VhPQ6zBaIEv8wAtmcq9H6us=;
        b=U/pCTNA0OdA/26JI5gyGNnPKk8piUIJKQl3kpSZbBfGvkvbBPx+yv1D+NELFiLzTQS
         WhqqgNiIVKWZhufKT1VVgW9880GMud/aUj7xULG4hznnN8k63BIDYbMgKqikP31Fmq/7
         wb6F7rqn7jH1HLaDzZt5ygQtllE8fIEmvVuWhsUgRA50cu5sNBmK0FIrrZ9Hb8jkefel
         j3W05ejhE74fjMTSE7mUNF8cwz37eou/seiGIAEwsd0pw3gNn7Kg5Ith9R5sw5i/JTAL
         vloeJ2Ew9cyuptxL5Md3drfohW07pR6NyvhWcpsc58F1AdqmeKeEk5pOraa1D+92uU39
         OUkg==
X-Gm-Message-State: AGi0PuYbIQj7aKhHwJt91GSuEwcLU31PnZlHwlcYdWb1CwjTyYdWhAcj
        DApw9ipPSldLZdr8639YslPdQ+baE/M=
X-Google-Smtp-Source: APiQypLcaadyRKotgT8kUsdZpUYlSSKhFJ4FV37wYFb81hXOB7Tga9ZzVfbEGskzlhVmiWRFc1fw9w==
X-Received: by 2002:ac8:458f:: with SMTP id l15mr9985501qtn.221.1589071316785;
        Sat, 09 May 2020 17:41:56 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id s8sm5615974qtb.0.2020.05.09.17.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:41:55 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [RFC PATCH v2 0/4] grep: honor sparse checkout and add option to ignore it
Date:   Sat,  9 May 2020 21:41:26 -0300
Message-Id: <cover.1589058209.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1585027716.git.matheus.bernardino@usp.br>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on the discussions in [1]. The idea is to make
git-grep (and other commands, in the future) be able to restrict their
output to the sparsity patterns, when requested by the user.

Main changes since v1:

In patch 1:
- Remove two unnecessary references in git-grep.txt, as they are in the
  same document.

Added patch 2.

In patch 3:
- Match paths directly against the sparsity patterns, when grepping a
  given tree, instead of checking the index.
- Better handle searches with --recurse-submodules when the superproject
  and/or the submodule have sparse checkout enabled. And add tests for
  cases like these.
- In tests, use the builtin git-sparse-checkout instead of manually
  writting to the sparse-checkout file.
- Add tests for grepping in cone mode.
- Rename the previous 'from_commit' parameter and a test name, to be
  more meaningful.

  Note: it was suggested to change some of the tests in this patch to
  use cone mode. I ended up using both cone mode and full patterns, so
  that we could check that grep behaves correctly when submodules have
  different pattern rules than the superproject. I tried to leave the
  testing repo's structure simple, though, so that the tests remain well
  readable.

In patch 4:
- Move the configuration that restrict cmds' behavior based on the
  sparse checkout from the 'grep' namespace to 'sparse', as the idea is
  to have the same setting affecting multiple cmds.
- Add the --[no]-restrict-to-sparse-paths global option
- Add more tests for the setting and CLI option in grep.
- Add tests to ensure the submodules' values for the setting are
  respected when running grep with --recurse-submodules.

  Note: in this patch, I used the 'sparse' namespace, instead of 'core',
  following the idea we discussed in [2], to have the sparse checkout
  settings in their own namespace. We also talked about moving
  core.sparseCheckout and core.sparseCheckoutCone to the new
  namespace.  I tried implementing this change in this same patchset
  (although, on second thought, it is probably better to do it in
  another one), but I still haven't managed to come up with a rename
  implementation that keeps good compatibility. The problems are the
  ones Elijah listed in [3]. So, for now, sparse.restrictCmds is the
  only setting in the 'sparse' namespace. But it won't be the only one
  for too long, as Stolee is already implementing other ones [4].

[1]: https://lore.kernel.org/git/CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com/t/#u
[2]: https://lore.kernel.org/git/49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com/
[3]: https://lore.kernel.org/git/CABPp-BGytfCugK0S99nLPH4_VXmcYPHWdVyLO59BZc4__4CT9w@mail.gmail.com/
[4]: https://lore.kernel.org/git/2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com/

Matheus Tavares (4):
  doc: grep: unify info on configuration variables
  config: load the correct config.worktree file
  grep: honor sparse checkout patterns
  config: add setting to ignore sparsity patterns in some cmds

 Documentation/config.txt               |   2 +
 Documentation/config/grep.txt          |  10 +-
 Documentation/config/sparse.txt        |  22 +++
 Documentation/git-grep.txt             |  37 +----
 Documentation/git.txt                  |   4 +
 Makefile                               |   1 +
 builtin/grep.c                         | 137 +++++++++++++++-
 config.c                               |   5 +-
 contrib/completion/git-completion.bash |   2 +
 git.c                                  |   6 +
 sparse-checkout.c                      |  16 ++
 sparse-checkout.h                      |  11 ++
 t/t7011-skip-worktree-reading.sh       |   9 --
 t/t7817-grep-sparse-checkout.sh        | 216 +++++++++++++++++++++++++
 t/t9902-completion.sh                  |   4 +-
 15 files changed, 431 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h
 create mode 100755 t/t7817-grep-sparse-checkout.sh

Range-diff against v1:
1:  7ba5caf10d ! 1:  c344d22313 doc: grep: unify info on configuration variables
    @@ Commit message
     
         Explanations about the configuration variables for git-grep are
         duplicated in "Documentation/git-grep.txt" and
    -    "Documentation/config/grep.txt". Let's unify the information in the
    -    second file and include it in the first.
    +    "Documentation/config/grep.txt", which can make maintenance difficult.
    +    The first also contains a definition not present in the latter
    +    (grep.fullName). To avoid problems like this, let's unify the
    +    information in the second file and include it in the first.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ Documentation/config/grep.txt: grep.extendedRegexp::
      grep.threads::
     -	Number of grep worker threads to use.
     -	See `grep.threads` in linkgit:git-grep[1] for more information.
    -+	Number of grep worker threads to use. See `--threads` in
    -+	linkgit:git-grep[1] for more information.
    ++	Number of grep worker threads to use. See `--threads`
    ++ifndef::git-grep[]
    ++	in linkgit:git-grep[1]
    ++endif::git-grep[]
    ++	for more information.
     +
     +grep.fullName::
     +	If set to true, enable `--full-name` option by default.
    @@ Documentation/git-grep.txt: characters.  An empty string as search expression ma
     -	If set to true, fall back to git grep --no-index if git grep
     -	is executed outside of a git repository.  Defaults to false.
     -
    ++:git-grep: 1
     +include::config/grep.txt[]
      
      OPTIONS
    @@ Documentation/git-grep.txt: providing this option will cause it to die.
     +	Number of grep worker threads to use. If not provided (or set to
     +	0), Git will use as many worker threads as the number of logical
     +	cores available. The default value can also be set with the
    -+	`grep.threads` configuration (see linkgit:git-config[1]).
    ++	`grep.threads` configuration.
      
      -f <file>::
      	Read patterns from <file>, one per line.
-:  ---------- > 2:  882310b69f config: load the correct config.worktree file
2:  0b9b4c4b41 ! 3:  e00674c727 grep: honor sparse checkout patterns
    @@ Commit message
         One of the main uses for a sparse checkout is to allow users to focus on
         the subset of files in a repository in which they are interested. But
         git-grep currently ignores the sparsity patterns and report all matches
    -    found outside this subset, which kind of goes in the oposity direction.
    +    found outside this subset, which kind of goes in the opposite direction.
         Let's fix that, making it honor the sparsity boundaries for every
         grepping case:
     
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
      		     struct tree_desc *tree, struct strbuf *base, int tn_len,
     -		     int check_attr);
    -+		     int from_commit);
    ++		     int is_root_tree);
      
      static int grep_submodule(struct grep_opt *opt,
      			  const struct pathspec *pathspec,
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	for (nr = 0; nr < repo->index->cache_nr; nr++) {
      		const struct cache_entry *ce = repo->index->cache[nr];
     +
    -+		if (ce_skip_worktree(ce))
    ++		if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
     +			continue;
     +
      		strbuf_setlen(&name, name_base_len);
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      					continue;
      				hit |= grep_oid(opt, &ce->oid, name.buf,
     @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
    + 	return hit;
    + }
      
    - static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    - 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
    +-static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    +-		     struct tree_desc *tree, struct strbuf *base, int tn_len,
     -		     int check_attr)
    -+		     int from_commit)
    ++static struct pattern_list *get_sparsity_patterns(struct repository *repo)
    ++{
    ++	struct pattern_list *patterns;
    ++	char *sparse_file;
    ++	int sparse_config, cone_config;
    ++
    ++	if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
    ++	    !sparse_config) {
    ++		return NULL;
    ++	}
    ++
    ++	sparse_file = repo_git_path(repo, "info/sparse-checkout");
    ++	patterns = xcalloc(1, sizeof(*patterns));
    ++
    ++	if (repo_config_get_bool(repo, "core.sparsecheckoutcone", &cone_config))
    ++		cone_config = 0;
    ++	patterns->use_cone_patterns = cone_config;
    ++
    ++	if (add_patterns_from_file_to_list(sparse_file, "", 0, patterns, NULL)) {
    ++		if (file_exists(sparse_file)) {
    ++			warning(_("failed to load sparse-checkout file: '%s'"),
    ++				sparse_file);
    ++		}
    ++		free(sparse_file);
    ++		free(patterns);
    ++		return NULL;
    ++	}
    ++
    ++	free(sparse_file);
    ++	return patterns;
    ++}
    ++
    ++static int in_sparse_checkout(struct strbuf *path, int prefix_len,
    ++			      unsigned int entry_mode,
    ++			      struct index_state *istate,
    ++			      struct pattern_list *sparsity,
    ++			      enum pattern_match_result parent_match,
    ++			      enum pattern_match_result *match)
    ++{
    ++	int dtype = DT_UNKNOWN;
    ++
    ++	if (S_ISGITLINK(entry_mode))
    ++		return 1;
    ++
    ++	if (parent_match == MATCHED_RECURSIVE) {
    ++		*match = parent_match;
    ++		return 1;
    ++	}
    ++
    ++	if (S_ISDIR(entry_mode) && !is_dir_sep(path->buf[path->len - 1]))
    ++		strbuf_addch(path, '/');
    ++
    ++	*match = path_matches_pattern_list(path->buf, path->len,
    ++					   path->buf + prefix_len, &dtype,
    ++					   sparsity, istate);
    ++	if (*match == UNDECIDED)
    ++		*match = parent_match;
    ++
    ++	if (S_ISDIR(entry_mode))
    ++		strbuf_trim_trailing_dir_sep(path);
    ++
    ++	if (*match == NOT_MATCHED && (S_ISREG(entry_mode) ||
    ++	    (S_ISDIR(entry_mode) && sparsity->use_cone_patterns)))
    ++		return 0;
    ++
    ++	return 1;
    ++}
    ++
    ++static int do_grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    ++			struct tree_desc *tree, struct strbuf *base, int tn_len,
    ++			int check_attr, struct pattern_list *sparsity,
    ++			enum pattern_match_result default_sparsity_match)
      {
      	struct repository *repo = opt->repo;
      	int hit = 0;
     @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    - 		name_base_len = name.len;
    - 	}
      
    -+	if (from_commit && repo_read_index(repo) < 0)
    -+		die(_("index file corrupt"));
    -+
      	while (tree_entry(tree, &entry)) {
      		int te_len = tree_entry_len(&entry);
    ++		enum pattern_match_result sparsity_match = 0;
      
    + 		if (match != all_entries_interesting) {
    + 			strbuf_addstr(&name, base->buf + tn_len);
     @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
      
      		strbuf_add(base, entry.path, te_len);
      
    -+		if (from_commit) {
    -+			int pos = index_name_pos(repo->index,
    -+						 base->buf + tn_len,
    -+						 base->len - tn_len);
    -+			if (pos >= 0 &&
    -+			    ce_skip_worktree(repo->index->cache[pos])) {
    ++		if (sparsity) {
    ++			struct strbuf path = STRBUF_INIT;
    ++			strbuf_addstr(&path, base->buf + tn_len);
    ++
    ++			if (!in_sparse_checkout(&path, old_baselen - tn_len,
    ++						entry.mode, repo->index,
    ++						sparsity, default_sparsity_match,
    ++						&sparsity_match)) {
     +				strbuf_setlen(base, old_baselen);
     +				continue;
     +			}
    @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec
     +
      		if (S_ISREG(entry.mode)) {
      			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
    --					 check_attr ? base->buf + tn_len : NULL);
    -+					from_commit ? base->buf + tn_len : NULL);
    - 		} else if (S_ISDIR(entry.mode)) {
    - 			enum object_type type;
    - 			struct tree_desc sub;
    + 					 check_attr ? base->buf + tn_len : NULL);
     @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    + 
      			strbuf_addch(base, '/');
      			init_tree_desc(&sub, data, size);
    - 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
    +-			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
     -					 check_attr);
    -+					 from_commit);
    ++			hit |= do_grep_tree(opt, pathspec, &sub, base, tn_len,
    ++					    check_attr, sparsity, sparsity_match);
      			free(data);
      		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
      			hit |= grep_submodule(opt, pathspec, &entry.oid,
    +@@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    + 	return hit;
    + }
    + 
    ++/*
    ++ * Note: sparsity patterns and paths' attributes will only be considered if
    ++ * is_root_tree has true value. (Otherwise, we cannot properly perform pattern
    ++ * matching on paths.)
    ++ */
    ++static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
    ++		     struct tree_desc *tree, struct strbuf *base, int tn_len,
    ++		     int is_root_tree)
    ++{
    ++	struct pattern_list *patterns = NULL;
    ++	int ret;
    ++
    ++	if (is_root_tree)
    ++		patterns = get_sparsity_patterns(opt->repo);
    ++
    ++	ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
    ++			   patterns, 0);
    ++
    ++	if (patterns) {
    ++		clear_pattern_list(patterns);
    ++		free(patterns);
    ++	}
    ++	return ret;
    ++}
    ++
    + static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
    + 		       struct object *obj, const char *name, const char *path)
    + {
     
      ## t/t7011-skip-worktree-reading.sh ##
     @@ t/t7011-skip-worktree-reading.sh: test_expect_success 'ls-files --modified' '
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +
     +test_description='grep in sparse checkout
     +
    -+This test creates the following dir structure:
    ++This test creates a repo with the following structure:
    ++
     +.
    -+| - a
    -+| - b
    -+| - dir
    -+    | - c
    ++|-- a
    ++|-- b
    ++|-- dir
    ++|   `-- c
    ++`-- sub
    ++    |-- A
    ++    |   `-- a
    ++    `-- B
    ++	`-- b
     +
    -+Only "a" should be present due to the sparse checkout patterns:
    -+"/*", "!/b" and "!/dir".
    ++Where . has non-cone mode sparsity patterns and sub is a submodule with cone
    ++mode sparsity patterns. The resulting sparse-checkout should leave the following
    ++structure:
    ++
    ++.
    ++|-- a
    ++`-- sub
    ++    `-- B
    ++	`-- b
     +'
     +
     +. ./test-lib.sh
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	echo "text" >b &&
     +	mkdir dir &&
     +	echo "text" >dir/c &&
    ++
    ++	git init sub &&
    ++	(
    ++		cd sub &&
    ++		mkdir A B &&
    ++		echo "text" >A/a &&
    ++		echo "text" >B/b &&
    ++		git add A B &&
    ++		git commit -m sub &&
    ++		git sparse-checkout init --cone &&
    ++		git sparse-checkout set B
    ++	) &&
    ++
    ++	git submodule add ./sub &&
     +	git add a b dir &&
    -+	git commit -m "initial commit" &&
    ++	git commit -m super &&
    ++	git sparse-checkout init --no-cone &&
    ++	git sparse-checkout set "/*" "!b" "!/*/" &&
    ++
     +	git tag -am t-commit t-commit HEAD &&
     +	tree=$(git rev-parse HEAD^{tree}) &&
     +	git tag -am t-tree t-tree $tree &&
    -+	cat >.git/info/sparse-checkout <<-EOF &&
    -+	/*
    -+	!/b
    -+	!/dir
    -+	EOF
    -+	git sparse-checkout init &&
    ++
     +	test_path_is_missing b &&
     +	test_path_is_missing dir &&
    -+	test_path_is_file a
    ++	test_path_is_missing sub/A &&
    ++	test_path_is_file a &&
    ++	test_path_is_file sub/B/b
     +'
     +
     +test_expect_success 'grep in working tree should honor sparse checkout' '
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	test_cmp expect_t-commit actual_t-commit
     +'
     +
    -+test_expect_success 'grep <tree-ish> should search outside sparse checkout' '
    ++test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
     +	commit=$(git rev-parse HEAD) &&
     +	tree=$(git rev-parse HEAD^{tree}) &&
     +	cat >expect_tree <<-EOF &&
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	test_cmp expect_t-tree actual_t-tree
     +'
     +
    ++test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	sub/B/b:text
    ++	EOF
    ++	git grep --recurse-submodules --cached "text" >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse checkout in submodule' '
    ++	commit=$(git rev-parse HEAD) &&
    ++	cat >expect_commit <<-EOF &&
    ++	$commit:a:text
    ++	$commit:sub/B/b:text
    ++	EOF
    ++	cat >expect_t-commit <<-EOF &&
    ++	t-commit:a:text
    ++	t-commit:sub/B/b:text
    ++	EOF
    ++	git grep --recurse-submodules "text" $commit >actual_commit &&
    ++	test_cmp expect_commit actual_commit &&
    ++	git grep --recurse-submodules "text" t-commit >actual_t-commit &&
    ++	test_cmp expect_t-commit actual_t-commit
    ++'
    ++
     +test_done
3:  a76242ecfa < -:  ---------- grep: add option to ignore sparsity patterns
-:  ---------- > 4:  3e9e906249 config: add setting to ignore sparsity patterns in some cmds
-- 
2.26.2

