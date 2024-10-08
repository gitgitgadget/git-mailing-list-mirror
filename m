Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EE339A1
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357164; cv=none; b=THGDLutHB9bo4lc2/wqgqMyyN9BERpL6vbE5lZMa4VSwp8FeDsfSMv8hgFuoVo9nVuHVLbvJJimDGmEATB8Nf5jDMpt8CCXw04TznGkMIN+4Frq1pK9LfaaxpBRZIpMWIljzKBgY4pMQ+miQuMZikKl+GO2XNPB9tNjK6tB4DM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357164; c=relaxed/simple;
	bh=3x5LhvRCoj8l4WH/LO13or1Ab9ps3fnnJAy43iJXpzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HH+OVSkt7RGxaIAw4lvyYnsJ3CRcp4+0kOQNuTpsZ4jcnBn+p2EXe+ngBHNQguQ7zadwKFLjDmitlB2VUDqsGHRqxR/NvVKYvT4rF0Iw3AQ+CUbt/RwBFdEhVSxSrClPB1CYRG76fV3AhdOC947shxFJhgLAolU0tLCHXGopsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxTzgdyL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxTzgdyL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E443CC4CEC6;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357163;
	bh=3x5LhvRCoj8l4WH/LO13or1Ab9ps3fnnJAy43iJXpzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JxTzgdyLBxs/yGp5VZ9GBs/v+yTQFAjXhVYC2unHtpcw6OvSUjuSq1USaFeQrKysI
	 y1LbHOr10HSyxS2zPs3ZyijhPsnuBP21QMUgVaO3wbtcrJq33wLzBBI9VFIDpjxAbP
	 hS+p3G+dUgMNil1W0f4ivTEzsLGniglMulM3n2PddAzBLotrRPuDOQK1rxx5euGjx2
	 467XJdUq7laNdwuMjPSe9M7okuzCpK0gbjHTaXyfch5e+WNq4aGV5nuPOliuyRG0pa
	 1DbtGmQTOpZ2nq+uqBcI6vlvLtk7xzgRG9ptt2fFSUhAeIb5We5HqE6JpRZf+BPa1F
	 K+HkK9w5htihw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D489CCED260;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
From: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Date: Mon, 07 Oct 2024 22:12:31 -0500
Subject: [PATCH v3 2/3] worktree: link worktrees with relative paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
In-Reply-To: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18366; i=cdwhite3@pm.me;
 h=from:subject:message-id;
 bh=tMOBmEFiprE/90ruABRAlvbNBuy+NRwM+1Cxn111E2A=;
 b=owGbwMvMwCVmxF73kO8jewrjabUkhnSWxVrCAUer1MPrl/BI1M6d+mmFQfLXOsblnRHik2fGH
 Xxc+39nRykLgxgXg6yYIsubrd8L1FMfZ3B/KJ8NM4eVCWQIAxenAEzk+URGhhlsmft9HW8qm9iv
 MV150iLvu8v5q3IzFryfeOOnjXKlujYjw6Opl0XuP/+rziD/Jn7iUrXFYZMXXmS4OEEtY1MQo93
 xxVwA
X-Developer-Key: i=cdwhite3@pm.me; a=openpgp;
 fpr=99981A649E1CA829A335E77493EDE5A0C788BC38
X-Endpoint-Received: by B4 Relay for cdwhite3@pm.me/default with
 auth_id=237
X-Original-From: Caleb White <cdwhite3@pm.me>
Reply-To: cdwhite3@pm.me

From: Caleb White <cdwhite3@pm.me>

Git currently stores absolute paths to both the main repository and
linked worktrees. However, this causes problems when moving repositories
or working in containerized environments where absolute paths differ
between systems. The worktree links break, and users are required to
manually execute `worktree repair` to repair them, leading to workflow
disruptions. Additionally, mapping repositories inside of containerized
environments renders the repository unusable inside the containers, and
this is not repairable as repairing the worktrees inside the containers
will result in them being broken outside the containers.

To address this, this patch makes Git always write relative paths when
linking worktrees. Relative paths increase the resilience of the
worktree links across various systems and environments, particularly
when the worktrees are self-contained inside the main repository (such
as when using a bare repository with worktrees). This improves
portability, workflow efficiency, and reduces overall breakages.

Although Git now writes relative paths, existing repositories with
absolute paths are still supported. There are no breaking changes
to workflows based on absolute paths, ensuring backward compatibility.

At a low level, the changes involve modifying functions in `worktree.c`
and `builtin/worktree.c` to use `relative_path()` when writing the
worktree’s `.git` file and the main repository’s `gitdir` reference.
Instead of hardcoding absolute paths, Git now computes the relative path
between the worktree and the repository, ensuring that these links are
portable. Locations where these respective file are read have also been
updated to properly handle both absolute and relative paths. Generally,
relative paths are always resolved into absolute paths before any
operations or comparisons are performed.

Additionally, `repair_worktrees_after_gitdir_move()` has been introduced
to address the case where both the `<worktree>/.git` and
`<repo>/worktrees/<id>/gitdir` links are broken after the gitdir is
moved (such as during a re-initialization). This function repairs both
sides of the worktree link using the old gitdir path to reestablish the
correct paths after a move.

The `worktree.path` struct member has also been updated to always store
the absolute path of a worktree. This ensures that worktree consumers
never have to worry about trying to resolve the absolute path themselves.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 builtin/worktree.c           |  16 ++--
 setup.c                      |   2 +-
 t/t2408-worktree-relative.sh |  39 ++++++++
 worktree.c                   | 207 ++++++++++++++++++++++++++++++++++---------
 worktree.h                   |  10 +++
 5 files changed, 223 insertions(+), 51 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index fc31d072a620d7b455d7f150bd3a9e773ee9d4ed..dae63dedf4cac2621f51f95a39aa456b33acd894 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -414,7 +414,8 @@ static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT, realpath = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT, sb_tmp = STRBUF_INIT;
+	struct strbuf sb_path_realpath = STRBUF_INIT, sb_repo_realpath = STRBUF_INIT;
 	const char *name;
 	struct strvec child_env = STRVEC_INIT;
 	unsigned int counter = 0;
@@ -490,11 +491,10 @@ static int add_worktree(const char *path, const char *refname,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	strbuf_realpath(&realpath, sb_git.buf, 1);
-	write_file(sb.buf, "%s", realpath.buf);
-	strbuf_realpath(&realpath, repo_get_common_dir(the_repository), 1);
-	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
-		   realpath.buf, name);
+	strbuf_realpath(&sb_path_realpath, path, 1);
+	strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
+	write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb_repo_realpath.buf, &sb_tmp));
+	write_file(sb_git.buf, "gitdir: %s", relative_path(sb_repo_realpath.buf, sb_path_realpath.buf, &sb_tmp));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
@@ -578,11 +578,13 @@ static int add_worktree(const char *path, const char *refname,
 
 	strvec_clear(&child_env);
 	strbuf_release(&sb);
+	strbuf_release(&sb_tmp);
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
+	strbuf_release(&sb_repo_realpath);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_path_realpath);
 	strbuf_release(&sb_name);
-	strbuf_release(&realpath);
 	free_worktree(wt);
 	return ret;
 }
diff --git a/setup.c b/setup.c
index 94e79b2e487f3faa537547e190acf9b7ea0be3b5..7b648de0279116b381eea46800ad130606926103 100644
--- a/setup.c
+++ b/setup.c
@@ -2420,7 +2420,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
-		repair_worktrees(NULL, NULL);
+		repair_worktrees_after_gitdir_move(src);
 	}
 
 	write_file(git_link, "gitdir: %s", git_dir);
diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
new file mode 100755
index 0000000000000000000000000000000000000000..a3136db7e28cb20926ff44211e246ce625a6e51a
--- /dev/null
+++ b/t/t2408-worktree-relative.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='test worktrees linked with relative paths'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'links worktrees with relative paths' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git worktree add wt1 &&
+		echo "../../../wt1/.git" >expected_gitdir &&
+		cat .git/worktrees/wt1/gitdir >actual_gitdir &&
+		echo "gitdir: ../.git/worktrees/wt1" >expected_git &&
+		cat wt1/.git >actual_git &&
+		test_cmp expected_gitdir actual_gitdir &&
+		test_cmp expected_git actual_git
+	)
+'
+
+test_expect_success 'move repo without breaking relative internal links' '
+	test_when_finished rm -rf repo moved &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git worktree add wt1 &&
+		cd .. &&
+		mv repo moved &&
+		cd moved/wt1 &&
+		git status >out 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_done
diff --git a/worktree.c b/worktree.c
index 0cba0d6e6e9ad02ace04a0301104a04a07cbef65..77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -110,6 +110,12 @@ struct worktree *get_linked_worktree(const char *id,
 	strbuf_rtrim(&worktree_path);
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
+	if (!is_absolute_path(worktree_path.buf)) {
+	    strbuf_strip_suffix(&path, "gitdir");
+	    strbuf_addbuf(&path, &worktree_path);
+	    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
+	}
+
 	CALLOC_ARRAY(worktree, 1);
 	worktree->repo = the_repository;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -373,18 +379,29 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 void update_worktree_location(struct worktree *wt, const char *path_)
 {
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
+	struct strbuf file = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 
 	if (is_main_worktree(wt))
 		BUG("can't relocate main worktree");
 
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 	strbuf_realpath(&path, path_, 1);
 	if (fspathcmp(wt->path, path.buf)) {
-		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
-			   "%s/.git", path.buf);
+		strbuf_addf(&file, "%s/gitdir", repo.buf);
+		write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
+		strbuf_reset(&file);
+		strbuf_addf(&file, "%s/.git", path.buf);
+		write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
+
 		free(wt->path);
 		wt->path = strbuf_detach(&path, NULL);
 	}
 	strbuf_release(&path);
+	strbuf_release(&repo);
+	strbuf_release(&file);
+	strbuf_release(&tmp);
 }
 
 int is_worktree_being_rebased(const struct worktree *wt,
@@ -564,38 +581,52 @@ static void repair_gitfile(struct worktree *wt,
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
-	char *backlink;
+	struct strbuf backlink = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	int err;
 
 	/* missing worktree can't be repaired */
 	if (!file_exists(wt->path))
-		return;
+		goto done;
 
 	if (!is_directory(wt->path)) {
 		fn(1, wt->path, _("not a directory"), cb_data);
-		return;
+		goto done;
 	}
 
 	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
-	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+
+	if (dotgit_contents) {
+		if (is_absolute_path(dotgit_contents)) {
+			strbuf_addstr(&backlink, dotgit_contents);
+		} else {
+			strbuf_addf(&backlink, "%s/%s", wt->path, dotgit_contents);
+			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+		}
+	}
 
 	if (err == READ_GITFILE_ERR_NOT_A_FILE)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
 	else if (err)
 		repair = _(".git file broken");
-	else if (fspathcmp(backlink, repo.buf))
+	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
 
 	if (repair) {
 		fn(0, wt->path, repair, cb_data);
-		write_file(dotgit.buf, "gitdir: %s", repo.buf);
+		write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->path, &tmp));
 	}
 
-	free(backlink);
+done:
+	free(dotgit_contents);
 	strbuf_release(&repo);
 	strbuf_release(&dotgit);
+	strbuf_release(&backlink);
+	strbuf_release(&tmp);
 }
 
 static void repair_noop(int iserr UNUSED,
@@ -618,6 +649,59 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 }
 
+void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf olddotgit = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (is_main_worktree(wt))
+		goto done;
+
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
+
+	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
+		goto done;
+
+	strbuf_rtrim(&olddotgit);
+	if (is_absolute_path(olddotgit.buf)) {
+		strbuf_addbuf(&dotgit, &olddotgit);
+	} else {
+		strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, olddotgit.buf);
+		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
+	}
+
+	if (!file_exists(dotgit.buf))
+		goto done;
+
+	strbuf_addbuf(&path, &dotgit);
+	strbuf_strip_suffix(&path, "/.git");
+
+	write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
+	write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tmp));
+done:
+	strbuf_release(&path);
+	strbuf_release(&repo);
+	strbuf_release(&gitdir);
+	strbuf_release(&dotgit);
+	strbuf_release(&olddotgit);
+	strbuf_release(&tmp);
+}
+
+void repair_worktrees_after_gitdir_move(const char *old_path)
+{
+	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
+
+	for (; *wt; wt++)
+		repair_worktree_after_gitdir_move(*wt, old_path);
+	free_worktrees(worktrees);
+}
+
 static int is_main_worktree_path(const char *path)
 {
 	struct strbuf target = STRBUF_INIT;
@@ -684,6 +768,8 @@ void repair_worktree_at_path(const char *path,
 	struct strbuf inferred_backlink = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
+	struct strbuf realolddotgit = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	int err;
@@ -701,9 +787,17 @@ void repair_worktree_at_path(const char *path,
 	}
 
 	infer_backlink(realdotgit.buf, &inferred_backlink);
+	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
 	if (dotgit_contents) {
-		strbuf_addstr(&backlink, dotgit_contents);
+		if (is_absolute_path(dotgit_contents)) {
+			strbuf_addstr(&backlink, dotgit_contents);
+		} else {
+			strbuf_addbuf(&backlink, &realdotgit);
+			strbuf_strip_suffix(&backlink, ".git");
+			strbuf_addstr(&backlink, dotgit_contents);
+			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+		}
 	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
@@ -721,7 +815,7 @@ void repair_worktree_at_path(const char *path,
 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 			goto done;
 		}
-	} else if (err) {
+	} else {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
 		goto done;
 	}
@@ -753,90 +847,117 @@ void repair_worktree_at_path(const char *path,
 		repair = _("gitdir unreadable");
 	else {
 		strbuf_rtrim(&olddotgit);
-		if (fspathcmp(olddotgit.buf, realdotgit.buf))
+		if (is_absolute_path(olddotgit.buf)) {
+			strbuf_addbuf(&realolddotgit, &olddotgit);
+		} else {
+			strbuf_addf(&realolddotgit, "%s/%s", backlink.buf, olddotgit.buf);
+			strbuf_realpath_forgiving(&realolddotgit, realolddotgit.buf, 0);
+		}
+		if (fspathcmp(realolddotgit.buf, realdotgit.buf))
 			repair = _("gitdir incorrect");
 	}
 
 	if (repair) {
 		fn(0, gitdir.buf, repair, cb_data);
-		write_file(gitdir.buf, "%s", realdotgit.buf);
+		write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backlink.buf, &tmp));
 	}
 done:
 	free(dotgit_contents);
 	strbuf_release(&olddotgit);
+	strbuf_release(&realolddotgit);
 	strbuf_release(&backlink);
 	strbuf_release(&inferred_backlink);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);
 	strbuf_release(&dotgit);
+	strbuf_release(&tmp);
 }
 
 int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
 {
 	struct stat st;
-	char *path;
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
+	struct strbuf file = STRBUF_INIT;
+	char *path = NULL;
+	int rc = 0;
 	int fd;
 	size_t len;
 	ssize_t read_result;
 
 	*wtpath = NULL;
-	if (!is_directory(git_path("worktrees/%s", id))) {
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", id), 1);
+	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
+	if (!is_directory(repo.buf)) {
 		strbuf_addstr(reason, _("not a valid directory"));
-		return 1;
+		rc = 1;
+		goto done;
 	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
-	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+	strbuf_addf(&file, "%s/locked", repo.buf);
+	if (file_exists(file.buf)) {
+		goto done;
+	}
+	if (stat(gitdir.buf, &st)) {
 		strbuf_addstr(reason, _("gitdir file does not exist"));
-		return 1;
+		rc = 1;
+		goto done;
 	}
-	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	fd = open(gitdir.buf, O_RDONLY);
 	if (fd < 0) {
 		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 			    strerror(errno));
-		return 1;
+		rc = 1;
+		goto done;
 	}
 	len = xsize_t(st.st_size);
 	path = xmallocz(len);
 
 	read_result = read_in_full(fd, path, len);
+	close(fd);
 	if (read_result < 0) {
 		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
 			    strerror(errno));
-		close(fd);
-		free(path);
-		return 1;
-	}
-	close(fd);
-
-	if (read_result != len) {
+		rc = 1;
+		goto done;
+	} else if (read_result != len) {
 		strbuf_addf(reason,
 			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
 			    (uintmax_t)len, (uintmax_t)read_result);
-		free(path);
-		return 1;
+		rc = 1;
+		goto done;
 	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
 		strbuf_addstr(reason, _("invalid gitdir file"));
-		free(path);
-		return 1;
+		rc = 1;
+		goto done;
 	}
 	path[len] = '\0';
-	if (!file_exists(path)) {
-		if (stat(git_path("worktrees/%s/index", id), &st) ||
-		    st.st_mtime <= expire) {
+	if (is_absolute_path(path)) {
+		strbuf_addstr(&dotgit, path);
+	} else {
+		strbuf_addf(&dotgit, "%s/%s", repo.buf, path);
+		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
+	}
+	if (!file_exists(dotgit.buf)) {
+		strbuf_reset(&file);
+		strbuf_addf(&file, "%s/index", repo.buf);
+		if (stat(file.buf, &st) || st.st_mtime <= expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
-			free(path);
-			return 1;
-		} else {
-			*wtpath = path;
-			return 0;
+			rc = 1;
+			goto done;
 		}
 	}
-	*wtpath = path;
-	return 0;
+	*wtpath = strbuf_detach(&dotgit, NULL);
+done:
+	free(path);
+	strbuf_release(&dotgit);
+	strbuf_release(&gitdir);
+	strbuf_release(&repo);
+	strbuf_release(&file);
+	return rc;
 }
 
 static int move_config_setting(const char *key, const char *value,
diff --git a/worktree.h b/worktree.h
index 11279d0c8fe249bb30642563bf221a8de7f3b0a3..e96118621638667d87c5d7e0452ed10bd1ddf606 100644
--- a/worktree.h
+++ b/worktree.h
@@ -131,6 +131,16 @@ typedef void (* worktree_repair_fn)(int iserr, const char *path,
  */
 void repair_worktrees(worktree_repair_fn, void *cb_data);
 
+/*
+ * Repair the linked worktrees after the gitdir has been moved.
+ */
+void repair_worktrees_after_gitdir_move(const char *old_path);
+
+/*
+ * Repair the linked worktree after the gitdir has been moved.
+ */
+void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path);
+
 /*
  * Repair administrative files corresponding to the worktree at the given path.
  * The worktree's .git file pointing at the repository must be intact for the

-- 
2.46.2


