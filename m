Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888B342501
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564932; cv=none; b=DyWttuNGjWMaOW3lfocWdsinaMEEeRMLmix96jgmxXWuUn7EjJqkiqDg8yzbSOLc1Ytzg970POpTOXtWh2dWQK0hPAbMwZ+ayLQ8a4rLc8IvNHBkBQDctvhuCzmAF6WmRGrG4pgHeD5d31GmjOY+iIEpYtwmjmCggX2qSajMdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564932; c=relaxed/simple;
	bh=5sgSRrDu2RkXFUHQbQi4PwXOsIzpLwG2336F9k/scSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vDZo1VuntqyeqXUjKk8lsfPwnShpOpasqU9zpaNy1XEOcZdV2kAUdCDHPbrlwrA5BsGg4EGl6/hTRpKjBGTor4hGPQy18cBAqxzm0SOtFoL9mu+rb7gqv/TIW7H3l44dGfDKnAuAva38UTiRenrWkBFFRsryWqbjEgyH+IYRYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqhL3/Xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqhL3/Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06234C2BCB7;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783564932;
	bh=5sgSRrDu2RkXFUHQbQi4PwXOsIzpLwG2336F9k/scSU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MqhL3/XcFEdvM0MvUooKm4ETItxhY2U7Y8KvyCcu2nFYXf6RhZOngZM+LwVz/I4VF
	 GIz0zs59sMSpIH/FL9D0mjUmfP5lL7TVBUhmIIeApnu1CqK0ecpC/m/6wH9/7z77Dw
	 gHQYQ4Cywb8RRpB629AAexZcQTn6L7CIZLVZPQGRfXK5R3WBqJezZ7lMzCU6bEcQfD
	 HmjB3Nzm9XGQmI3Md8TfB37y4s5AsWbFreHx2AKSIP1BVK74HZcJX8zOEGWgOgJ/A+
	 ezaP6k6XvJhesaKKuKGPVXzeczknIC5ZesTY5pofOWd1TMNAKGq40avfOfySiapxrM
	 RyeywSIdFDSzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA539C43458;
	Thu,  9 Jul 2026 02:42:11 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v7 0/3] includeIf: add "worktree" condition for matching
 working tree path
Date: Thu, 09 Jul 2026 10:41:40 +0800
Message-Id: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQKT2oC/33QS27DIBAG4KtErEsFg3l11XtEXfAYGuTIriB1W
 kW+e3E2sSra5T9ovpnhRiqWjJW8HG6k4JJrnqcW9NOBhJOb3pHm2DIBBooNjNM8hfNnxJzodS7
 jpSDSFLwarGQxeUda40fBlL/u6PGt5VOul7l832csfKv+yy2cMmqZil7ZBEHbV392YaQR6/gcJ
 rKRC+wZ6DLQGKFQCOuNNVH3GLFnRJcRjeHMBpTagGeixwwPRvI+MzQmGVTAIfL2UT1G7hiQXUZ
 u22DC9h4ZyC6jHoz+4yjVGMeFscJF63T6zazr+gMGHj47GwIAAA==
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10372; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=5sgSRrDu2RkXFUHQbQi4PwXOsIzpLwG2336F9k/scSU=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqTwprnsFAp8sNfVZ4shK+bVV5PWkULjFknc6qX
 ZB8fwZjqyWJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCak8KawAKCRB2HuYUOZmu
 iyfID/4/dka5ucg25zlYi1a0TuXFgzPGPi53H1QO0eofR7nVf2neOzIvgS+xEz4MC4hH86nn7rI
 6cWX3OwB6VWq6TJkqVPatAt4swBEupbAeFiCoJU+f+WZvbRIYDlzT+BR4zd+Uf58/RG42lr1jAL
 rLXvuC+GWOG4pT8MCyHMmwcmQ+oks9+5Go65H8095yj8k9xFL8+zXy6nJaD89C5msa8sfVQptY6
 TJn6txdKtmV7wujsq6PgHf4vwigky8Y1dzhG5j/tV6pxL96BYPncwI1NQJ9NNYlMUf0hw3x0X6e
 zRkpZU7ZI18JmiL5vQNcH08W4NSQYAd9SfnBRhNgUlvL4btD/PYyqHPCq1d2BVIMjYhpe4hfmH/
 Qqx4AsZDWhA6ykSYwy2DaoOco2rggH95oqLQW4LLoDEU2TGHzcfekFitVvLaQ/8Hfn/US44ewMZ
 sJDgJNANiZqV7DXMbNPA9cf4A6x6MW8AA2rQdfRbLO54rQixUxIDePAUNdusclWkV/hlsKkpxCf
 aovr9dqry0XvuLGoLst0zCk5VNhE6EOUjtUDjKF/0UiY7VIZH6SpJ7okEmJiiERXQd4nl0jLak6
 8Hi4u2KWxvWfK6ah5cx2DiiTBufQz0tPAnfoHqARLEttTiLcEwR4kC4aGIxZhL/kyqEtPWxa4h6
 IEoizvFNL4/2mAA==
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
Chen Linxuan (3):
      config: refactor include_by_gitdir() into include_by_path()
      repository: keep a symlink-preserving copy of the worktree path
      config: add "worktree" and "worktree/i" includeIf conditions

 Documentation/config.adoc |  48 +++++++++++++
 config.c                  |  25 ++++---
 repository.c              |  26 +++++++
 repository.h              |  10 +++
 setup.c                   |  86 ++++++++++++++++++++++-
 t/t1305-config-include.sh | 171 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 354 insertions(+), 12 deletions(-)

Range-diff versus v6:

1:  faa10baf8deb = 1:  47ee82d6a5bd config: refactor include_by_gitdir() into include_by_path()
-:  ------------ > 2:  367d61f9b55f repository: keep a symlink-preserving copy of the worktree path
2:  ee81d7aeee56 ! 3:  67d9c31d3817 config: add "worktree" and "worktree/i" includeIf conditions
    @@ Commit message
     
         Introduce two new condition keywords:
     
    -      - worktree:<pattern> matches the realpath of the current worktree's
    -        working directory (i.e. repo_get_work_tree()) against a glob
    -        pattern.  This is the path returned by git rev-parse
    -        --show-toplevel.
    +      - worktree:<pattern> matches the working directory of the current
    +        worktree (the path returned by git rev-parse --show-toplevel)
    +        against a glob pattern.
     
           - worktree/i:<pattern> is the case-insensitive variant.
     
    -    The implementation reuses the include_by_path() helper introduced in
    -    the previous commit, passing the worktree path in place of the
    -    gitdir.  The condition never matches in bare repositories (where
    -    there is no worktree) or during early config reading (where no
    -    repository is available).
    +    The implementation reuses the include_by_path() helper, passing
    +    repo_get_work_tree_original() (added in the previous commit; it keeps
    +    the symlink-preserving spelling of the worktree path) in place of the
    +    gitdir.  As with gitdir, include_by_path() then matches both the
    +    realpath and the original spelling, so a pattern may use either.  The
    +    condition never matches in bare repositories (where there is no
    +    worktree) or during early config reading (where no repository is
    +    available).
     
         Add documentation describing the new conditions, including a comparison
         with extensions.worktreeConfig.  Add tests covering bare repositories,
    -    multiple worktrees, symlinked worktree paths, case-sensitive and
    -    case-insensitive matching, early config reading, and non-repository
    -    scenarios.
    +    multiple worktrees, symlinked and subdir-of-symlinked worktree paths,
    +    case-sensitive and case-insensitive matching, early config reading,
    +    and non-repository scenarios.
     
         Signed-off-by: Chen Linxuan <me@black-desk.cn>
     
    @@ config.c: static int include_condition_is_true(const struct key_value_info *kvi,
      	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
      		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
     +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
    -+		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
    ++		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
     +				       cond, cond_len, 0);
     +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
    -+		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
    ++		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
     +				       cond, cond_len, 1);
      	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
      		return include_by_branch(inc, cond, cond_len);
    @@ t/t1305-config-include.sh: test_expect_success 'onbranch without repository but
     +	test_must_fail git -C wt-prefix/linked config test.linkedvar
     +'
     +
    -+test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
    -+	mkdir real-wt &&
    -+	ln -s real-wt link-wt &&
    -+	git init link-wt/repo &&
    ++test_expect_success SYMLINKS 'conditional include, worktree matching symlink' '
    ++	mkdir sym-real &&
    ++	ln -s sym-real sym-link &&
    ++	git init sym-link/repo &&
     +	(
    -+		cd link-wt/repo &&
    -+		# repo->worktree resolves symlinks, so use real path in pattern
    -+		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
    -+		echo "[test]wtlink=2" >.git/bar-link &&
    -+		echo 2 >expect &&
    -+		git config test.wtlink >actual &&
    -+		test_cmp expect actual
    ++		cd sym-link/repo &&
    ++		link_path="$(pwd)" &&
    ++		real_path="$(test-tool path-utils real_path "$link_path")" &&
    ++		cat >>.git/config <<-EOF &&
    ++		[includeIf "gitdir:$link_path/.git"]
    ++			path = gitdir-link
    ++		[includeIf "gitdir:$real_path/.git"]
    ++			path = gitdir-real
    ++		[includeIf "worktree:$link_path"]
    ++			path = worktree-link
    ++		[includeIf "worktree:$real_path"]
    ++			path = worktree-real
    ++		EOF
    ++		echo "[test]gitdirlink=1" >.git/gitdir-link &&
    ++		echo "[test]gitdirreal=1" >.git/gitdir-real &&
    ++		echo "[test]worktreelink=1" >.git/worktree-link &&
    ++		echo "[test]worktreereal=1" >.git/worktree-real &&
    ++		git config get test.gitdirlink &&
    ++		git config get test.gitdirreal &&
    ++		git config get test.worktreelink &&
    ++		git config get test.worktreereal &&
    ++		# from a subdirectory, the logical worktree path is recovered by
    ++		# stripping the below-root suffix, so both spellings still match
    ++		mkdir d &&
    ++		cd d &&
    ++		git config get test.worktreelink &&
    ++		git config get test.worktreereal
    ++	)
    ++'
    ++
    ++test_expect_success SYMLINKS 'conditional include, worktree matching symlink of a linked worktree' '
    ++	git init wt-main &&
    ++	( cd wt-main && test_commit initial ) &&
    ++	git -C wt-main worktree add --detach ../wt-real &&
    ++	ln -s wt-real wt-link &&
    ++	wt_main="$(cd wt-main && pwd)" &&
    ++	(
    ++		cd wt-link &&
    ++		link_path="$(pwd)" &&
    ++		real_path="$(test-tool path-utils real_path "$link_path")" &&
    ++		cat >>"$wt_main/.git/config" <<-EOF &&
    ++		[includeIf "worktree:$link_path"]
    ++			path = wt-link
    ++		[includeIf "worktree:$real_path"]
    ++			path = wt-real
    ++		EOF
    ++		echo "[test]wtlink=1" >"$wt_main/.git/wt-link" &&
    ++		echo "[test]wtreal=1" >"$wt_main/.git/wt-real" &&
    ++		test "$(git config get test.wtlink)" = "1" &&
    ++		test "$(git config get test.wtreal)" = "1"
     +	)
     +'
     +

---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47


