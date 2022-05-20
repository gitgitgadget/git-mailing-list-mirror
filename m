Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552EC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353221AbiETT3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353215AbiETT3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:29:16 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B018C052
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:15 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j3so7674466qvn.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drlnBllHln2AiSbEdS6TfrNjTJtAVeeQ4Q2OvULtKzg=;
        b=TIRpuL0Lj20f7N0AS+Gpaep1Fku8Q4MpVgLoqPTnJ72NARqrJ/7Cd00qgby0LavWHn
         tImXlXO76OxObrElxNFVNmPCClZqIJ2fsloNMO3aWkOVdwLtvATywXTAU6uuglv3frHl
         STLqcigAKjj1CK3CHxGr7ZbowIgZE9vCZUSaLgYgOVBaM2/XFrGR7y5ukLxOjIAWrZZ9
         p/lgqAP52PqLuJQaw1kHgDqIxD+YXr6jcwgTTHQWQW2YLGXOYKzwh7ySK6yphZUgGca4
         PPAJ2mXUmIdfdijrcuo2GVK1+bJBPNc8uiCqd8RO6eRBhElhoSANQ6CLECz7QPqA483q
         FZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drlnBllHln2AiSbEdS6TfrNjTJtAVeeQ4Q2OvULtKzg=;
        b=ocRG+o1BDBkOtfYszjWqbf7cLNfXQO4gfOmlbcJgWCqGNBIh/rE+JEPro4XIvQkakI
         lXnHgKwjo5164Ocne1DnjisuGS2hGW4+1UFY4MQGj+eDsraA5zm9UAg0XRbbtKoLHv60
         9xzjSMh+/Gpepw5lASWXXpOO/tN7OG0t1C2guDKbNd01k80RYufeWBRSIjA4f7QL1Pbe
         QJT3EIHvUqZ8rwA2c+BwKnWt1ndj8uLPeadSrEm1ssqZ5R05U5Bp6YASvBJvGjIcVW75
         bc6pxt/waCtOJ0XmbP6yDC/E1AlpNKPeiiQhUZzNr0Hx45cQw8wqX8UpQ7mqkGDmpi82
         MVnw==
X-Gm-Message-State: AOAM532gxx+m5StXbsmme3GC5W5QuERfJpBkWLPCIRdvgbAos0UYki+e
        0xVAZd10hX4OP7dq4fd1D6XbfNrT7/nyEA==
X-Google-Smtp-Source: ABdhPJyIigSJ/Qh0CwDeRanFUpBx30bMoOGHcSljOVSm2O1GpSnOkom9NaBRUIYBYqWLsJ+ZU4+D0A==
X-Received: by 2002:a05:6214:d81:b0:45a:e07e:6bcb with SMTP id e1-20020a0562140d8100b0045ae07e6bcbmr8853630qve.29.1653074954094;
        Fri, 20 May 2022 12:29:14 -0700 (PDT)
Received: from localhost.localdomain ([108.29.205.134])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b006a059f1d8b8sm142379qkf.124.2022.05.20.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:29:13 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 1/3] dir: traverse into repository
Date:   Fri, 20 May 2022 19:28:38 +0000
Message-Id: <20220520192840.8942-2-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520192840.8942-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220520192840.8942-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
2020-04-01) traversing into a repository's directory tree when the
traversal began outside the repository's standard location has failed
because the encountered repository was identified as a nested foreign
repository.

Prior to this commit, the failure to traverse into a repository's
default worktree location was observable from a user's perspective under
either of the following conditions (there may be others):

    1) Set the `core.worktree` location to a parent directory of the
       default worktree; or
    2) Use the `--git_dir` option while the working directory is outside
       the repository's default worktree location

Under either of these conditions, symptoms of the failure to traverse
into the repository's default worktree location include the inability to
add files to the index or get a list of untracked files via ls-files.

This commit adds a check to determine whether a nested repository that
is encountered in recursing a path is actually `the_repository`.  If so,
we simply treat the directory as if it doesn't contain a nested
repository.

The commit includes test-cases to reduce the likelihood of future
regressions.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c                          |  19 +++
 t/t2205-add-worktree-config.sh | 274 +++++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100755 t/t2205-add-worktree-config.sh

diff --git a/dir.c b/dir.c
index 26c4d141ab..e45e117875 100644
--- a/dir.c
+++ b/dir.c
@@ -1893,9 +1893,28 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
+		/*
+		 * Determine if `dirname` is a nested repo by confirming that:
+		 * 1) we are in a nonbare repository, and
+		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
+		 *    which could occur if the git_dir or worktree location was
+		 *    manually configured by the user; see t2205 testcases 1-3 for
+		 *    examples where this matters
+		 */
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
+
+		if (nested_repo) {
+			char *real_dirname, *real_gitdir;
+			strbuf_addstr(&sb, ".git");
+			real_dirname = real_pathdup(sb.buf, 1);
+			real_gitdir = real_pathdup(the_repository->gitdir, 1);
+
+			nested_repo = !!strcmp(real_dirname, real_gitdir);
+			free(real_gitdir);
+			free(real_dirname);
+		}
 		strbuf_release(&sb);
 	}
 	if (nested_repo) {
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
new file mode 100755
index 0000000000..056894eb94
--- /dev/null
+++ b/t/t2205-add-worktree-config.sh
@@ -0,0 +1,274 @@
+#!/bin/sh
+
+test_description='directory traversal respects user config
+
+This test verifies the traversal of the directory tree when the traversal begins
+outside the repository.  Two instances for which this can occur are tested:
+
+	1) The user manually sets the worktree.  For this instance, the test sets
+	   the worktree two levels above the `.git` directory and checks whether we
+	   are able to add to the index those files that are in either (1) the
+	   manually configured worktree directory or (2) the standard worktree
+	   location with respect to the `.git` directory (i.e. ensuring that the
+	   encountered `.git` directory is not treated as belonging to a foreign
+	   nested repository).
+	2) The user manually sets the `git_dir` while the working directory is
+	   outside the repository.  The test checks that files inside the
+	   repository can be added to the index.
+	'
+
+. ./test-lib.sh
+
+test_expect_success '1a: setup--config worktree' '
+	mkdir test1 &&
+	(
+	cd test1 &&
+	test_create_repo repo &&
+	git --git-dir="repo/.git" config core.worktree "$(pwd)" &&
+
+	mkdir -p outside-tracked outside-untracked &&
+	mkdir -p repo/inside-tracked repo/inside-untracked &&
+	>file-tracked &&
+	>file-untracked &&
+	>outside-tracked/file &&
+	>outside-untracked/file &&
+	>repo/file-tracked &&
+	>repo/file-untracked &&
+	>repo/inside-tracked/file &&
+	>repo/inside-untracked/file &&
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	../file-tracked
+	../outside-tracked/file
+	file-tracked
+	inside-tracked/file
+	EOF
+
+	cat >expect-untracked-unsorted <<-EOF &&
+	../file-untracked
+	../outside-untracked/file
+	file-untracked
+	inside-untracked/file
+	EOF
+
+	cat >expect-all-dir-unsorted <<-EOF &&
+	../file-untracked
+	../file-tracked
+	../outside-untracked/
+	../outside-tracked/
+	./
+	EOF
+
+	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
+
+	cat >.gitignore <<-EOF
+	.gitignore
+	actual-*
+	expect-*
+	EOF
+	)
+'
+
+test_expect_success '1b: pre-add all' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	(
+		cd repo &&
+		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
+	) &&
+	sort actual-all-unsorted >actual-all &&
+	sort expect-all-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '1c: pre-add dir all' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	(
+		cd repo &&
+		git ls-files -o --directory --exclude-standard "$parent_dir" >../actual-all-dir-unsorted
+	) &&
+	sort actual-all-dir-unsorted >actual-all &&
+	sort expect-all-dir-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '1d: post-add tracked' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	(
+		cd repo &&
+		git add file-tracked &&
+		git add inside-tracked &&
+		git add ../outside-tracked &&
+		git add "$parent_dir/file-tracked" &&
+		git ls-files "$parent_dir" >../actual-tracked-unsorted
+	) &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_expect_success '1e: post-add untracked' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	(
+		cd repo &&
+		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
+	) &&
+	sort actual-untracked-unsorted >actual-untracked &&
+	sort expect-untracked-unsorted >expect-untracked &&
+	test_cmp expect-untracked actual-untracked
+	)
+'
+
+test_expect_success '2a: setup--set git-dir' '
+	mkdir test2 &&
+	(
+	cd test2 &&
+	test_create_repo repo &&
+	# create two foreign repositories that should remain untracked
+	test_create_repo repo-outside &&
+	test_create_repo repo/repo-inside &&
+
+	mkdir -p repo/inside-tracked repo/inside-untracked &&
+	>repo/file-tracked &&
+	>repo/file-untracked &&
+	>repo/inside-tracked/file &&
+	>repo/inside-untracked/file &&
+	>repo-outside/file &&
+	>repo/repo-inside/file &&
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	repo/file-tracked
+	repo/inside-tracked/file
+	EOF
+
+	cat >expect-untracked-unsorted <<-EOF &&
+	repo/file-untracked
+	repo/inside-untracked/file
+	repo/repo-inside/
+	repo-outside/
+	EOF
+
+	cat >expect-all-dir-unsorted <<-EOF &&
+	repo/
+	repo-outside/
+	EOF
+
+	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
+
+	cat >.gitignore <<-EOF
+	.gitignore
+	actual-*
+	expect-*
+	EOF
+	)
+'
+
+test_expect_success '2b: pre-add all' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-all-unsorted &&
+	sort actual-all-unsorted >actual-all &&
+	sort expect-all-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '2c: pre-add dir all' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --directory --exclude-standard >actual-all-dir-unsorted &&
+	sort actual-all-dir-unsorted >actual-all &&
+	sort expect-all-dir-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '2d: post-add tracked' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git add repo/file-tracked &&
+	git --git-dir=repo/.git add repo/inside-tracked &&
+	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_expect_success '2e: post-add untracked' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-untracked-unsorted &&
+	sort actual-untracked-unsorted >actual-untracked &&
+	sort expect-untracked-unsorted >expect-untracked &&
+	test_cmp expect-untracked actual-untracked
+	)
+'
+
+test_expect_success '3a: setup--add repo dir' '
+	mkdir test3 &&
+	(
+	cd test3 &&
+	test_create_repo repo &&
+
+	mkdir -p repo/inside-tracked repo/inside-ignored &&
+	>repo/file-tracked &&
+	>repo/file-ignored &&
+	>repo/inside-tracked/file &&
+	>repo/inside-ignored/file &&
+
+	cat >.gitignore <<-EOF &&
+	.gitignore
+	actual-*
+	expect-*
+	*ignored
+	EOF
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	repo/file-tracked
+	repo/inside-tracked/file
+	EOF
+
+	cat >expect-ignored-unsorted <<-EOF
+	repo/file-ignored
+	repo/inside-ignored/
+	.gitignore
+	actual-ignored-unsorted
+	expect-ignored-unsorted
+	expect-tracked-unsorted
+	EOF
+	)
+'
+
+test_expect_success '3b: ignored' '
+	(
+	cd test3 &&
+	git --git-dir=repo/.git ls-files -io --directory --exclude-standard >actual-ignored-unsorted &&
+	sort actual-ignored-unsorted >actual-ignored &&
+	sort expect-ignored-unsorted >expect-ignored &&
+	test_cmp expect-ignored actual-ignored
+	)
+'
+
+test_expect_success '3c: add repo' '
+	(
+	cd test3 &&
+	git --git-dir=repo/.git add repo &&
+	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_done
-- 
2.36.0

