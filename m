Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490F3AFD1B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665846; cv=none; b=jh4Y140FiX32pIP7GgG93Juy1zzBJZ9XzsbnqSoDSBLDyPmSnMPL13kX49wYjJCR2GVa+6Zq678sU87LdA/stEOrNryQp91j/JtYaIU/UyUxomHUczIsKc9Y+DUydaWvIfnqfEtEtnGpjxnvPn6B2YWYbSP9BVnWOGlNF9IV99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665846; c=relaxed/simple;
	bh=n7GOD6IGPr8DkW49FJfCjBeFSKjjwgYIQ7Qcm4Ti9Ew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=r9E/ayjFUY1uZw8icu9Dzg/7tyntWBxaXqKLdqDcblkO/ez1Jz05zJ/c/GsVegb8DN3vfeqaMgc2I3SSuIgiSFmyJcWMEFtlIE6X6zd/x20G5DnY8sbnv+Nu4ED38odzOeeIZO3aINuwrXm5VCN13AX0UaiaE+WNV9Ot6t5K2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ60xvtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ60xvtV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC9CFC2BCB9;
	Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783665845;
	bh=n7GOD6IGPr8DkW49FJfCjBeFSKjjwgYIQ7Qcm4Ti9Ew=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:Reply-To:From;
	b=TJ60xvtVLnLxKbgpscz6RXkGnKcGzYNWmadxXp8Re+a4cu2jicAud7dS+UsSx+XyQ
	 2tFMCZXXEXhNgAo7tB7q8XBExLQv83rDGannY+sEkI+2O+vBDBUuAHRVipVV4iOQo3
	 cONIrzLMRC3+AclR1Cwxt093xvRJdvLJkjkJhetzGdsuq4VffldB37hKuh5TnpQCwv
	 1qbnREL09Mu7AWJSM+WhsKKwt2amaQPhWz9oG+0J5SGJpafZ/PbNKj7C26tbtb5MCG
	 pFvZmfdqnh61mSoMAyClYX6a9JtESgCrAMFV7sRGf+3O6Gs6EL3x14FMdD9tXMyWaO
	 8akiRy/YLUCJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C4CC43458;
	Fri, 10 Jul 2026 06:44:05 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v8 0/2] includeIf: add "worktree" condition for matching
 working tree path
Date: Fri, 10 Jul 2026 14:43:28 +0800
Message-Id: <20260710-includeif-worktree-v8-0-04686d8a616c@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCUUGoC/33QzU7DMAwH8FeZciYocZovTrwH4pAPh0WbWpSOA
 pr67ri7rEKB49+Rf7ZzZTO2ijN7OlxZw6XOdRopuIcDS8cwviGvmTIDAUYMQvI6pvNHxlr459R
 Ol4bIS4pm8FrkEgOjxveGpX7d0JdXysc6X6b2fZuxyK36L7dILrgXJkfjCyTrn+M5pBPPOJ8e0
 8g2coE9A10GiFEGlfLReZdtj1F7RnUZRYwUPqG2DqJQPWa4M1r2mYGY4tCAhCzpo3qM3jGgu4z
 etsGC9J4F6C5j7oz94yhDTJDKeRWyD7b0GLtnfJexxKCzaIVGl4v5zazr+gOygD2xYgIAAA==
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11632; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=n7GOD6IGPr8DkW49FJfCjBeFSKjjwgYIQ7Qcm4Ti9Ew=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqUJSf22cPxyS1Rqrd3R4jutE9AK6zKk8YceX+T
 oonNVt7E26JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCalCUnwAKCRB2HuYUOZmu
 i02mEAC7KfkIywKkc5Q/uV0XNeNQJL62oKs04wR5iSYKqhQMRITGnYiOPsr5gdLG41jVjS4zTpy
 deDIZ5Cg/FtCrf0sfQTHWr9+d1Y6IyKE/sjeWgaRX/t1QUuBxGeX5VYzXMxP7EEGxxPWJAuO0Cl
 SBA9GEQIlgcV5bEPx+zJem3XjvZvj6ppokRUlY3UPIn51DYIuyljWg7XOpACXQxYJd7Qom6vIV4
 QrRGXnuEx9OPB5uXuZnVrwlSaSD3OgNhBRIqU/DljxgpHfqJxSX8hfIBIHCA8tLIYNv7VcjgZ4I
 3KteF1nbl0wV6kXUzq1zCwaonRa2W+bYHL/uy2CsXSCGTXhJU8WR9bq09pxyNUCePHN1VTmjqsq
 mybX3uC5dSNFH4TckTcGgqbxmfCJFQ24xWjCwg7EX/r2nLCMt9nn15Z++vxtxDkCGQNCw0IdcVR
 DhJfnh+sKSWVtAkNa0APF9eQAJEpX853CHm1MZD09vjjPVa66QSHxRik5myNa50LBRn5lbtFQPq
 Wejw1/aiRcYQ15pz63rPvOwRjeLY+BpGhP3f8xakYLosPMLfCZt6Hl09QbhZqVUbf7CmGPNuhVq
 WsLk+hxq5E37LevYzqnQ1w4z7ElALsVkEY2zKuumAZjwrgzZ0ry/iW7lQk1Wf+bPRsbChq4q5Pv
 +ZSCYNIwHdocbLA==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

The `includeIf` mechanism already supports matching on the `.git`
directory path (`gitdir`) and the currently checked out branch
(`onbranch`).  But in multi-worktree setups the `.git` directory of a
linked worktree points into the main repository's `.git/worktrees/`
area, which makes `gitdir` patterns cumbersome when one wants to
include config based on the working tree's checkout path instead.

Introduce two new condition keywords:

  - `worktree:<pattern>` matches the working directory of the current
    worktree against a glob pattern.
  - `worktree/i:<pattern>` is the case-insensitive variant.

Supported pattern features: glob wildcards, `**/` and `/**`, `~`
expansion, `./` relative paths, and trailing-`/` prefix matching.
The condition never matches in a bare repository.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
Changes in v8:
- Drop the v7 symlink-preserving worktree path implementation.  Patrick
  pointed out that the setup-side plumbing was too invasive and likely to
  conflict with the ongoing setup discovery work.
- Document the current limitation instead: includeIf "worktree:" matches
  the realpath-resolved worktree location, so symlink spellings may not
  match.
- Return the series to two patches, based on v6 plus the documentation
  update.
- Link to v7: https://lore.kernel.org/r/20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn

Changes in v7:
- Preserve the symlinked spelling of the worktree path and match
  includeIf "worktree:" against it, so the condition now matches both
  the symlinked and the real path, consistent with "gitdir:"
  (Patrick Steinhardt, v6 review).
- Split the work into a preparatory commit that stores a non-realpath
  worktree path and a follow-up that wires it into includeIf.
- Extend symlink test coverage to subdirectories and linked worktrees.
- Link to v6: https://lore.kernel.org/r/20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn

Changes in v6:
- Rebase onto current `master` at Git 2.55.
- Add an in-code comment explaining why the non-repository worktree
  tests use the loose `**.path` pattern (suggested by Junio C Hamano).
- Link to v5: https://lore.kernel.org/r/20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn

Changes in v5:
- Fix Windows CI failure: use `**` glob pattern instead of `/` in the
  "worktree without repository" tests, since `/` as a path pattern is
  Unix-specific and does not match Windows paths.
  Github CI pass: https://github.com/black-desk/git/actions/runs/26380466288
- Add a test verifying case-sensitive matching by default, with the
  `!CASE_INSENSITIVE_FS` prerequisite (suggested by Patrick Steinhardt).
- Link to v4: https://lore.kernel.org/r/20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn

Changes in v4:
- Deduplicate the worktree pattern documentation by referencing the
  gitdir syntax instead of repeating the full pattern description
  (suggested by Patrick Steinhardt).
- Add documentation comparing includeIf "worktree:" with
  extensions.worktreeConfig, including a concrete use case example
  (suggested by Phillip Wood, Junio C Hamano).
- Add a test verifying that the worktree condition does not match
  during early config reading (suggested by Patrick Steinhardt).
- Add tests for the non-repository (nongit) scenario (suggested by
  Patrick Steinhardt).
- Add a test for the case-insensitive "worktree/i" variant
- Link to v3: https://lore.kernel.org/r/20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn

Changes in v3:
- Apply Junio's suggestion.
- Link to v2: https://lore.kernel.org/r/20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn

Changes in v2:

- Add missing signed-off-by lines.
- Link to v1: https://lore.kernel.org/r/20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn

---
Chen Linxuan (2):
      config: refactor include_by_gitdir() into include_by_path()
      config: add "worktree" and "worktree/i" includeIf conditions

 Documentation/config.adoc |  53 +++++++++++++++++++
 config.c                  |  25 +++++----
 t/t1305-config-include.sh | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 11 deletions(-)

Range-diff versus v7:

1:  510f28d207f8 = 1:  731d928b1dfa config: refactor include_by_gitdir() into include_by_path()
2:  0f83ffee0338 < -:  ------------ repository: keep a symlink-preserving copy of the worktree path
3:  18d1abc325fc ! 2:  56c792090625 config: add "worktree" and "worktree/i" includeIf conditions
    @@ Commit message
     
         Introduce two new condition keywords:
     
    -      - worktree:<pattern> matches the working directory of the current
    -        worktree (the path returned by git rev-parse --show-toplevel)
    -        against a glob pattern.
    +      - worktree:<pattern> matches the realpath of the current worktree's
    +        working directory (i.e. repo_get_work_tree()) against a glob
    +        pattern.  This is the path returned by git rev-parse
    +        --show-toplevel.
     
           - worktree/i:<pattern> is the case-insensitive variant.
     
    -    The implementation reuses the include_by_path() helper, passing
    -    repo_get_work_tree_original() (added in the previous commit; it keeps
    -    the symlink-preserving spelling of the worktree path) in place of the
    -    gitdir.  As with gitdir, include_by_path() then matches both the
    -    realpath and the original spelling, so a pattern may use either.  The
    -    condition never matches in bare repositories (where there is no
    -    worktree) or during early config reading (where no repository is
    -    available).
    +    The implementation reuses the include_by_path() helper introduced in
    +    the previous commit, passing the worktree path in place of the
    +    gitdir.  The condition never matches in bare repositories (where
    +    there is no worktree) or during early config reading (where no
    +    repository is available).
     
         Add documentation describing the new conditions, including a comparison
    -    with extensions.worktreeConfig.  Add tests covering bare repositories,
    -    multiple worktrees, symlinked and subdir-of-symlinked worktree paths,
    -    case-sensitive and case-insensitive matching, early config reading,
    +    with extensions.worktreeConfig and a note that worktree matching currently
    +    uses the realpath-resolved worktree location.  Add tests covering bare
    +    repositories, multiple worktrees, realpath-resolved symlinked worktree
    +    paths, case-sensitive and case-insensitive matching, early config reading,
         and non-repository scenarios.
     
         Signed-off-by: Chen Linxuan <me@black-desk.cn>
    @@ Documentation/config.adoc: refer to linkgit:gitignore[5] for details. For conven
     +`**/`, and trailing-`/` prefix matching). This condition will never match
     +in a bare repository (which has no worktree).
     ++
    ++Unlike `gitdir`, the `worktree` condition currently matches only the
    ++realpath-resolved worktree location. If the working tree was entered via a
    ++symbolic link, a pattern that uses the symbolic-link spelling may not match;
    ++use the real path instead.
    +++
     +This is useful when you want to apply configuration based on where the
     +working tree is located on the filesystem. For example, a contributor who
     +works on the same project both personally and as an employee can use
    @@ config.c: static int include_condition_is_true(const struct key_value_info *kvi,
      	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
      		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
     +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
    -+		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
    ++		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
     +				       cond, cond_len, 0);
     +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
    -+		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
    ++		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
     +				       cond, cond_len, 1);
      	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
      		return include_by_branch(inc, cond, cond_len);
    @@ t/t1305-config-include.sh: test_expect_success 'onbranch without repository but
     +	test_must_fail git -C wt-prefix/linked config test.linkedvar
     +'
     +
    -+test_expect_success SYMLINKS 'conditional include, worktree matching symlink' '
    -+	mkdir sym-real &&
    -+	ln -s sym-real sym-link &&
    -+	git init sym-link/repo &&
    -+	(
    -+		cd sym-link/repo &&
    -+		link_path="$(pwd)" &&
    -+		real_path="$(test-tool path-utils real_path "$link_path")" &&
    -+		cat >>.git/config <<-EOF &&
    -+		[includeIf "gitdir:$link_path/.git"]
    -+			path = gitdir-link
    -+		[includeIf "gitdir:$real_path/.git"]
    -+			path = gitdir-real
    -+		[includeIf "worktree:$link_path"]
    -+			path = worktree-link
    -+		[includeIf "worktree:$real_path"]
    -+			path = worktree-real
    -+		EOF
    -+		echo "[test]gitdirlink=1" >.git/gitdir-link &&
    -+		echo "[test]gitdirreal=1" >.git/gitdir-real &&
    -+		echo "[test]worktreelink=1" >.git/worktree-link &&
    -+		echo "[test]worktreereal=1" >.git/worktree-real &&
    -+		git config get test.gitdirlink &&
    -+		git config get test.gitdirreal &&
    -+		git config get test.worktreelink &&
    -+		git config get test.worktreereal &&
    -+		# from a subdirectory, the logical worktree path is recovered by
    -+		# stripping the below-root suffix, so both spellings still match
    -+		mkdir d &&
    -+		cd d &&
    -+		git config get test.worktreelink &&
    -+		git config get test.worktreereal
    -+	)
    -+'
    -+
    -+test_expect_success SYMLINKS 'conditional include, worktree matching symlink of a linked worktree' '
    -+	git init wt-main &&
    -+	( cd wt-main && test_commit initial ) &&
    -+	git -C wt-main worktree add --detach ../wt-real &&
    -+	ln -s wt-real wt-link &&
    -+	wt_main="$(cd wt-main && pwd)" &&
    ++test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
    ++	mkdir real-wt &&
    ++	ln -s real-wt link-wt &&
    ++	git init link-wt/repo &&
     +	(
    -+		cd wt-link &&
    -+		link_path="$(pwd)" &&
    -+		real_path="$(test-tool path-utils real_path "$link_path")" &&
    -+		cat >>"$wt_main/.git/config" <<-EOF &&
    -+		[includeIf "worktree:$link_path"]
    -+			path = wt-link
    -+		[includeIf "worktree:$real_path"]
    -+			path = wt-real
    -+		EOF
    -+		echo "[test]wtlink=1" >"$wt_main/.git/wt-link" &&
    -+		echo "[test]wtreal=1" >"$wt_main/.git/wt-real" &&
    -+		test "$(git config get test.wtlink)" = "1" &&
    -+		test "$(git config get test.wtreal)" = "1"
    ++		cd link-wt/repo &&
    ++		# repo->worktree resolves symlinks, so use real path in pattern
    ++		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
    ++		echo "[test]wtlink=2" >.git/bar-link &&
    ++		echo 2 >expect &&
    ++		git config test.wtlink >actual &&
    ++		test_cmp expect actual
     +	)
     +'
     +

---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47


