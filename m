Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880833BBBA
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564932; cv=none; b=Wi6fN0z6/VyoKtA14ZeY+CNLnVQ6OvO+TUybwXTQa8q9XrWoePxSh610zUHGvAzeNRJYLvcfx5LW0usqw965q4zI6I+dTC8z1Otl7wAsAi4sBxW4Lee9BmHUxptHf+4ck8as7mAUOR0ES6FI7i1rVwkbQkm+euZp1yxkcXcLgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564932; c=relaxed/simple;
	bh=5kgN33gKFt+2wzzmsuQphXzpLP+GKtkOaoNeTSCGxQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkfHBf/ieCqnR8CAIuJ3Kp9Lje/m0Rfuw0M0jOP09vDNt0jnjbmwuuMM0+8edto1jCsYcw1bK9mIy2JXAjF/oV9sW7OkL3zjOLPSKvHixgCrMtei2JOAsItS46vCnATcb0bb0Taq0anGGgybe6OmzNe6RFwUrL4ZJaJXWx/DrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgQ44qUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgQ44qUo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D2CC2BCF4;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783564932;
	bh=5kgN33gKFt+2wzzmsuQphXzpLP+GKtkOaoNeTSCGxQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RgQ44qUom9g/tI3S4E2yhz+hGc9YWqK8WJAmp7EvaWUTzygN+FttPcukRWGSBEeHG
	 lFaTXeJVrugchbtYZR1qiBJh9/k1903Vb4Ng/LcAlKOrBrfAVNMjy4//7IRdDVTVf3
	 cCPEhU8bxyrtYdpx9Hjz6Rgkd9CjsC58Hpx1E4c/QO3YvxA8zQ2ad1Q1Ce8AJo6ruL
	 A9nx0+W4KgCz9lYKNn/LIu7C5UQxY6UG0GepvV6NS+FYb68As9QsC/IQmFhy6DGCh4
	 xqjO7412xyKOqKpXeWo0IUIepjW0ywQLWYWGEI+1Iaex65QeHWdAji+qnoPM9kUH/o
	 jg7Cc9bfwC6AA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64FC44507;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 09 Jul 2026 10:41:43 +0800
Subject: [PATCH v7 3/3] config: add "worktree" and "worktree/i" includeIf
 conditions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-includeif-worktree-v7-3-e87e705e8df6@black-desk.cn>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12223; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=1Pz6jIfNpd/T+JXGU7TiDXG/yR3XwI7xdKYSw7+5aBs=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqTwqBX8rpcyJH7nXkH55I+4UcWMi5UhoRRB3zo
 E+6WrKwjh+JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCak8KgQAKCRB2HuYUOZmu
 i4hmD/9SyQpY8VBnzzcIEDQawmRMXqVXcznT+fUPgw92uvGi6lRRRRTagy/be6+MSEx5HsUsMAu
 reO4V1cxIcJWStyNiIP5qnOBL4f8NBGIDtlxeBh0E0M/DznGUVRU6egytSpYeM8D7M8frEiBVkg
 TgQepqoUpHpU/HSeIfYphOh55mOi9Jogu8z/GrDZPNzQx0MwW8PElCIYb4jK92yciItcHHRqFhm
 27S3kQQA68V3R+5ZlhbpsARAYtUxivze+a8kiuRGTKJnnuE+DO1K8HXHq84u0JAIvOz0HZsAMVh
 vprkfbGp/u8ExksSojaL4IOWDcTRyyStTnVypG8s0d+nE5frDx0wtxmY33tQaUaU3ZbjwZdUKpo
 F/ZCV2FkzZqYzBFt3edAFTNIvv42ag4taUbXaF5rxuHqskHYi5yl5yh6r0dy5zmrGXcXr004r2H
 18IbELwDIZY7HG3bQgGaXPtsmr569z9bOjKNLkwylDlN3cKySPMsQjNVmsb9F1lBYgi+zXd6g0r
 ByZJsmGs/UsSLyjIALQPBQ2JMe3yQLDRSEoe8pQDfo+8EL8rNE/IXKzIQUneECxD+93dsopqIfk
 DA74V61LvkH2pgkQlf5oUaKMQHJc03IWY+fBwQc0yuG/T1o4uEqkTA/hNrgX5F7N0pNKP6MymEb
 FhE+T0f3MnygTxQ==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

The includeIf mechanism already supports matching on the .git
directory path (gitdir) and the currently checked out branch
(onbranch).  But in multi-worktree setups the .git directory of a
linked worktree points into the main repository's .git/worktrees/
area, which makes gitdir patterns cumbersome when one wants to
include config based on the working tree's checkout path instead.

Introduce two new condition keywords:

  - worktree:<pattern> matches the working directory of the current
    worktree (the path returned by git rev-parse --show-toplevel)
    against a glob pattern.

  - worktree/i:<pattern> is the case-insensitive variant.

The implementation reuses the include_by_path() helper, passing
repo_get_work_tree_original() (added in the previous commit; it keeps
the symlink-preserving spelling of the worktree path) in place of the
gitdir.  As with gitdir, include_by_path() then matches both the
realpath and the original spelling, so a pattern may use either.  The
condition never matches in bare repositories (where there is no
worktree) or during early config reading (where no repository is
available).

Add documentation describing the new conditions, including a comparison
with extensions.worktreeConfig.  Add tests covering bare repositories,
multiple worktrees, symlinked and subdir-of-symlinked worktree paths,
case-sensitive and case-insensitive matching, early config reading,
and non-repository scenarios.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 Documentation/config.adoc |  48 +++++++++++++
 config.c                  |   6 ++
 t/t1305-config-include.sh | 171 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 15b1a4d59347..c153da986e4a 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -146,6 +146,46 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file systems)
 
+`worktree`::
+	The data that follows the keyword `worktree` and a colon is used as a
+	glob pattern. If the working directory of the current worktree matches
+	the pattern, the include condition is met.
++
+The worktree location is the path where files are checked out (as returned
+by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
+matches the `.git` directory path. In a linked worktree, the worktree path
+is the directory where that worktree's files are located, not the main
+repository's `.git` directory.
++
+The pattern uses the same glob syntax as `gitdir` (including `~/`, `./`,
+`**/`, and trailing-`/` prefix matching). This condition will never match
+in a bare repository (which has no worktree).
++
+This is useful when you want to apply configuration based on where the
+working tree is located on the filesystem. For example, a contributor who
+works on the same project both personally and as an employee can use
+different `user.name` and `user.email` values depending on which directory
+the worktree is checked out under:
++
+----
+[includeIf "worktree:/home/user/work/"]
+    path = ~/.config/git/work.inc
+[includeIf "worktree:/home/user/personal/"]
+    path = ~/.config/git/personal.inc
+----
++
+While `extensions.worktreeConfig` (see linkgit:git-worktree[1]) also supports
+per-worktree configuration, it stores the config inside each repository's
+`.git/config.worktree` file and requires running `git config --worktree`
+inside each worktree individually. In contrast, `includeIf "worktree:..."`
+can be set once in a global or system-level configuration file (e.g.
+`~/.config/git/config`) and applies to all repositories at once based on
+their worktree location.
+
+`worktree/i`::
+	This is the same as `worktree` except that matching is done
+	case-insensitively (e.g. on case-insensitive file systems)
+
 `onbranch`::
 	The data that follows the keyword `onbranch` and a colon is taken to be a
 	pattern with standard globbing wildcards and two additional
@@ -244,6 +284,14 @@ Example
 [includeIf "gitdir:~/to/group/"]
 	path = /path/to/foo.inc
 
+; include if the worktree is at /path/to/project-build
+[includeIf "worktree:/path/to/project-build"]
+	path = build-config.inc
+
+; include for all worktrees inside /path/to/group
+[includeIf "worktree:/path/to/group/"]
+	path = group-config.inc
+
 ; relative paths are always relative to the including
 ; file (if the condition is true); their location is not
 ; affected by the condition
diff --git a/config.c b/config.c
index 00eeeea370c9..652711ec5e0b 100644
--- a/config.c
+++ b/config.c
@@ -400,6 +400,12 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
+		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
+				       cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
+		return include_by_path(kvi, inc->repo ? repo_get_work_tree_original(inc->repo) : NULL,
+				       cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f3892578e4ff..99eae656a3f7 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -396,4 +396,175 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+# worktree: conditional include tests
+
+test_expect_success 'conditional include, worktree bare repo' '
+	git init --bare wt-bare &&
+	(
+		cd wt-bare &&
+		echo "[includeIf \"worktree:/\"]path=bar-bare" >>config &&
+		echo "[test]wtbare=1" >bar-bare &&
+		test_must_fail git config test.wtbare
+	)
+'
+
+test_expect_success 'conditional include, worktree multiple worktrees' '
+	git init wt-multi &&
+	(
+		cd wt-multi &&
+		test_commit initial &&
+		git worktree add -b linked-branch ../wt-linked HEAD &&
+		git worktree add -b prefix-branch ../wt-prefix/linked HEAD
+	) &&
+	wt_main="$(cd wt-multi && pwd)" &&
+	wt_linked="$(cd wt-linked && pwd)" &&
+	wt_prefix_parent="$(cd wt-prefix && pwd)" &&
+	cat >>wt-multi/.git/config <<-EOF &&
+	[includeIf "worktree:$wt_main"]
+		path = main-config
+	[includeIf "worktree:$wt_linked"]
+		path = linked-config
+	[includeIf "worktree:$wt_prefix_parent/"]
+		path = prefix-config
+	EOF
+	echo "[test]mainvar=main" >wt-multi/.git/main-config &&
+	echo "[test]linkedvar=linked" >wt-multi/.git/linked-config &&
+	echo "[test]prefixvar=prefix" >wt-multi/.git/prefix-config &&
+	echo main >expect &&
+	git -C wt-multi config test.mainvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-multi config test.linkedvar &&
+	test_must_fail git -C wt-multi config test.prefixvar &&
+	echo linked >expect &&
+	git -C wt-linked config test.linkedvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-linked config test.mainvar &&
+	test_must_fail git -C wt-linked config test.prefixvar &&
+	echo prefix >expect &&
+	git -C wt-prefix/linked config test.prefixvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-prefix/linked config test.mainvar &&
+	test_must_fail git -C wt-prefix/linked config test.linkedvar
+'
+
+test_expect_success SYMLINKS 'conditional include, worktree matching symlink' '
+	mkdir sym-real &&
+	ln -s sym-real sym-link &&
+	git init sym-link/repo &&
+	(
+		cd sym-link/repo &&
+		link_path="$(pwd)" &&
+		real_path="$(test-tool path-utils real_path "$link_path")" &&
+		cat >>.git/config <<-EOF &&
+		[includeIf "gitdir:$link_path/.git"]
+			path = gitdir-link
+		[includeIf "gitdir:$real_path/.git"]
+			path = gitdir-real
+		[includeIf "worktree:$link_path"]
+			path = worktree-link
+		[includeIf "worktree:$real_path"]
+			path = worktree-real
+		EOF
+		echo "[test]gitdirlink=1" >.git/gitdir-link &&
+		echo "[test]gitdirreal=1" >.git/gitdir-real &&
+		echo "[test]worktreelink=1" >.git/worktree-link &&
+		echo "[test]worktreereal=1" >.git/worktree-real &&
+		git config get test.gitdirlink &&
+		git config get test.gitdirreal &&
+		git config get test.worktreelink &&
+		git config get test.worktreereal &&
+		# from a subdirectory, the logical worktree path is recovered by
+		# stripping the below-root suffix, so both spellings still match
+		mkdir d &&
+		cd d &&
+		git config get test.worktreelink &&
+		git config get test.worktreereal
+	)
+'
+
+test_expect_success SYMLINKS 'conditional include, worktree matching symlink of a linked worktree' '
+	git init wt-main &&
+	( cd wt-main && test_commit initial ) &&
+	git -C wt-main worktree add --detach ../wt-real &&
+	ln -s wt-real wt-link &&
+	wt_main="$(cd wt-main && pwd)" &&
+	(
+		cd wt-link &&
+		link_path="$(pwd)" &&
+		real_path="$(test-tool path-utils real_path "$link_path")" &&
+		cat >>"$wt_main/.git/config" <<-EOF &&
+		[includeIf "worktree:$link_path"]
+			path = wt-link
+		[includeIf "worktree:$real_path"]
+			path = wt-real
+		EOF
+		echo "[test]wtlink=1" >"$wt_main/.git/wt-link" &&
+		echo "[test]wtreal=1" >"$wt_main/.git/wt-real" &&
+		test "$(git config get test.wtlink)" = "1" &&
+		test "$(git config get test.wtreal)" = "1"
+	)
+'
+
+test_expect_success !CASE_INSENSITIVE_FS 'conditional include, worktree, case sensitive' '
+	git init wt-case &&
+	(
+		cd wt-case &&
+		test_commit initial &&
+		wt_path="$(pwd)" &&
+		wt_upper=$(echo "$wt_path" | tr a-z A-Z) &&
+		echo "[includeIf \"worktree:$wt_upper\"]path=case-inc" >>.git/config &&
+		echo "[test]wtcase=1" >.git/case-inc &&
+		test_must_fail git config test.wtcase
+	)
+'
+
+test_expect_success 'conditional include, worktree, icase' '
+	git init wt-icase &&
+	(
+		cd wt-icase &&
+		test_commit initial &&
+		wt_path="$(pwd)" &&
+		wt_upper=$(echo "$wt_path" | tr a-z A-Z) &&
+		echo "[includeIf \"worktree/i:$wt_upper\"]path=icase-inc" >>.git/config &&
+		echo "[test]wticase=1" >.git/icase-inc &&
+		echo 1 >expect &&
+		git config test.wticase >actual &&
+		test_cmp expect actual
+	)
+'
+
+# The "worktree" condition cannot match during early config reading
+# because the repository object is not yet fully initialized and
+# repo_get_work_tree() returns NULL.
+test_expect_success 'conditional include, worktree does not match in early config' '
+	git init wt-early &&
+	(
+		cd wt-early &&
+		test_commit initial &&
+		wt_path="$(pwd)" &&
+		echo "[includeIf \"worktree:$wt_path\"]path=early-inc" >>.git/config &&
+		echo "[test]wtearly=1" >.git/early-inc &&
+		test-tool config read_early_config test.wtearly >actual &&
+		test_must_be_empty actual
+	)
+'
+
+# Use a loose pattern so the "present in non-worktree cases" check works
+# for Unix-style absolute paths and Windows paths like D:/a/git/...
+test_expect_success 'conditional include, worktree without repository' '
+	test_when_finished "rm -f .gitconfig config.inc" &&
+	git config set -f .gitconfig "includeIf.worktree:**.path" config.inc &&
+	git config set -f config.inc foo.bar baz &&
+	git config get foo.bar &&
+	test_must_fail nongit git config get foo.bar
+'
+
+test_expect_success 'conditional include, worktree without repository but explicit nonexistent Git directory' '
+	test_when_finished "rm -f .gitconfig config.inc" &&
+	git config set -f .gitconfig "includeIf.worktree:**.path" config.inc &&
+	git config set -f config.inc foo.bar baz &&
+	git config get foo.bar &&
+	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
+'
+
 test_done

-- 
2.53.0


