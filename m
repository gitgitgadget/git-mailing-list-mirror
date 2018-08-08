Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EE71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeHIAzQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:55:16 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51916 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeHIAzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:15 -0400
Received: by mail-ua0-f202.google.com with SMTP id m26-v6so2976625uaq.18
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ntFUnr2yUWH7AeEJvDMFqZgCuinRyFvewikwWyaKUHw=;
        b=ZaPuAL1RRu2iqY7zD0CfmlkIgWJ83m/BRCYr3eSo5AJ7qgJcswSiMiGdjAe/H4GePZ
         lt4BxOAguJsemdg8pG9o5KMKWmCalzndd4Fx/NEZY+L+GFUB8N6Ivw3xz1sg6N/omd6J
         +e2Dwt/f9IhTqc3tVivVsRGyhZvSihIyu/hUVs+YMCbvXBpQH3C2QDF6jExh60ers7oW
         9Yp7zXmaazmgaqdesqDkPAT8yth8s+zLJPmOOoZ62jgKt3f6n82NeLmWPsD/SXMQ9v2w
         wTc5IChGfHnlxlGX9roRvIswzpsfInLjvdPCyrgCBByPbL9ElrmKieZ2LVY6S8mU8Hsn
         83Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ntFUnr2yUWH7AeEJvDMFqZgCuinRyFvewikwWyaKUHw=;
        b=MuPC8vV7a6pF38V7VNx4bJerzn/4FfEhlnXTocJ18QBdYMdtpulTaz2D8p+LKa7+Du
         TbHV6ERXD0fpBuZCGd2aLDe9t6J/MH8hUrEglSowdnXbhPF0Rnhx7ucwG3OxLaVvc8/r
         lpTG9ary/2yqvr6dtRCFAL0DgPH9tXJeyNPnLLjMu2MlFwn5vsKjKzcpnkJfFj79WSSx
         LGLHo20kwfMu9PXXbWv2SF/Nq9WIrGC5n6LsGC11/+46lJS+o6mM/j/o1ZukbvRbWaLz
         8PCzh2nTeOD2colU/nN0c5o50JlgjxdxtvLkstYtuJ6CTyEAPNQN+AkkLDi04DZEYuK5
         0RQA==
X-Gm-Message-State: AOUpUlEVO0KonaOOyvlrhkTV0V97wYJlQrcx+qW+HqXnpVJz65qg4wsA
        p9WCUfge8NclVXp/cwwF79fHcGByYTWBFhLw725iTspiPJphlD4Zr2vFB5HJKut28jf5ZJyFUDb
        8UaDlJHe7BDx9RopjddCAvoAHPc3fh++Wnq09G2rdApED5dGZspWUJ9zVaQ==
X-Google-Smtp-Source: AA+uWPybO9eA5Q/Bim3s3aP2uFm2GiEgsbd1gHlX20sUuNHOxBuoPtQ+t0E80rIf4vjFL+X7lbFJtkzCrHs=
X-Received: by 2002:a1f:3de:: with SMTP id f91-v6mr2509623vki.1.1533767609356;
 Wed, 08 Aug 2018 15:33:29 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:33:22 -0700
In-Reply-To: <20180808223323.79989-1-bmwill@google.com>
Message-Id: <20180808223323.79989-2-bmwill@google.com>
Mime-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/2] submodule: create helper to build paths to submodule gitdirs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a helper function "submodule_name_to_gitdir()" (and the
submodule--helper subcommand "gitdir") which constructs a path to a
submodule's gitdir, located in the provided repository's "modules"
directory.

This consolidates the logic needed to build up a path into a
repository's "modules" directory, abstracting away the fact that
submodule git directories are stored in a repository's common gitdir.
This makes it easier to adjust how submodules gitdir are stored in the
"modules" directory in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c      | 28 +++++++++++++++--
 dir.c                            |  2 +-
 git-submodule.sh                 |  7 +++--
 repository.c                     |  3 +-
 submodule.c                      | 53 ++++++++++++++++++++------------
 submodule.h                      |  7 +++++
 t/t7410-submodule-checkout-to.sh |  6 ++--
 7 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3c4564c6c..5bfd2d0be9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -906,6 +906,21 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, the_repository, argv[1]);
+
+	printf("%s\n", gitdir.buf);
+
+	strbuf_release(&gitdir);
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -1268,18 +1283,24 @@ static int add_possible_reference_from_superproject(
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
 	if (ends_with(alt->path, "/objects")) {
+		struct repository alternate;
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
 		strbuf_add(&sb, alt->path, strlen(alt->path) - strlen("objects"));
 
+		repo_init(&alternate, sb.buf, NULL);
+
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
 		 * otherwise a submodule name containing '/' will be broken
 		 * as the last part of a missing submodule reference would
 		 * be taken as a file name.
 		 */
-		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
+		strbuf_reset(&sb);
+		submodule_name_to_gitdir(&sb, &alternate, sas->submodule_name);
+		strbuf_addch(&sb, '/');
+		repo_clear(&alternate);
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
@@ -1392,7 +1413,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
@@ -2018,7 +2039,7 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
 	name = argv[1];
 	path = argv[2];
 
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
 
 	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
@@ -2040,6 +2061,7 @@ struct cmd_struct {
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
+	{"gitdir", module_gitdir, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
 	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
diff --git a/dir.c b/dir.c
index 21e6f2520a..7a9827ea4b 100644
--- a/dir.c
+++ b/dir.c
@@ -3053,7 +3053,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		strbuf_reset(&sub_wt);
 		strbuf_reset(&sub_gd);
 		strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
-		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
+		submodule_name_to_gitdir(&sub_gd, &subrepo, sub->name);
 
 		connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 1);
 	}
diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bde..053747d290 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -252,12 +252,13 @@ Use -f if you really want to add it." >&2
 		fi
 
 	else
-		if test -d ".git/modules/$sm_name"
+		sm_gitdir="$(git submodule--helper gitdir "$sm_name")"
+		if test -d "$sm_gitdir"
 		then
 			if test -z "$force"
 			then
 				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
-				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
+				GIT_DIR="$sm_gitdir" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
 				die "$(eval_gettextln "\
 If you want to reuse this local git directory instead of cloning again from
   \$realrepo
@@ -577,7 +578,7 @@ cmd_update()
 			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
+		if ! $(git config -f "$(git submodule--helper gitdir "$name")/config" core.worktree) 2>/dev/null
 		then
 			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
 		fi
diff --git a/repository.c b/repository.c
index 5dd1486718..9da3c9d4b7 100644
--- a/repository.c
+++ b/repository.c
@@ -198,8 +198,7 @@ int repo_submodule_init(struct repository *submodule,
 		 * submodule would not have a worktree.
 		 */
 		strbuf_reset(&gitdir);
-		strbuf_repo_git_path(&gitdir, superproject,
-				     "modules/%s", sub->name);
+		submodule_name_to_gitdir(&gitdir, superproject, sub->name);
 
 		if (repo_init(submodule, gitdir.buf, NULL)) {
 			ret = -1;
diff --git a/submodule.c b/submodule.c
index 6e14547e9e..24eced34e7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1536,14 +1536,15 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 
 void submodule_unset_core_worktree(const struct submodule *sub)
 {
-	char *config_path = xstrfmt("%s/modules/%s/config",
-				    get_git_common_dir(), sub->name);
+	struct strbuf config_path = STRBUF_INIT;
+	submodule_name_to_gitdir(&config_path, the_repository, sub->name);
+	strbuf_addstr(&config_path, "/config");
 
-	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
+	if (git_config_set_in_file_gently(config_path.buf, "core.worktree", NULL))
 		warning(_("Could not unset core.worktree setting in submodule '%s'"),
 			  sub->path);
 
-	free(config_path);
+	strbuf_release(&config_path);
 }
 
 static const char *get_super_prefix_or_empty(void)
@@ -1639,20 +1640,22 @@ int submodule_move_head(const char *path,
 				absorb_git_dir_into_superproject("", path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 0);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			submodule_name_to_gitdir(&gitdir, the_repository,
+						 sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
+			strbuf_release(&gitdir);
 
 			/* make sure the index is clean as well */
 			submodule_reset_index(path);
 		}
 
 		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 1);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			submodule_name_to_gitdir(&gitdir, the_repository,
+						 sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 1);
+			strbuf_release(&gitdir);
 		}
 	}
 
@@ -1727,7 +1730,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 						      const char *path)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
-	const char *new_git_dir;
+	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
 
 	if (submodule_uses_worktrees(path))
@@ -1745,10 +1748,10 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
-	new_git_dir = git_path("modules/%s", sub->name);
-	if (safe_create_leading_directories_const(new_git_dir) < 0)
-		die(_("could not create directory '%s'"), new_git_dir);
-	real_new_git_dir = real_pathdup(new_git_dir, 1);
+	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
+	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
+		die(_("could not create directory '%s'"), new_gitdir.buf);
+	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
 		get_super_prefix_or_empty(), path,
@@ -1759,6 +1762,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
+	strbuf_release(&new_gitdir);
 }
 
 /*
@@ -1779,6 +1783,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 	/* Not populated? */
 	if (!sub_git_dir) {
 		const struct submodule *sub;
+		struct strbuf sub_gitdir = STRBUF_INIT;
 
 		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
 			/* unpopulated as expected */
@@ -1800,8 +1805,9 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		sub = submodule_from_path(the_repository, &null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
-		connect_work_tree_and_git_dir(path,
-			git_path("modules/%s", sub->name), 0);
+		submodule_name_to_gitdir(&sub_gitdir, the_repository, sub->name);
+		connect_work_tree_and_git_dir(path, sub_gitdir.buf, 0);
+		strbuf_release(&sub_gitdir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
@@ -1949,9 +1955,16 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 			goto cleanup;
 		}
 		strbuf_reset(buf);
-		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
+		submodule_name_to_gitdir(buf, the_repository, sub->name);
 	}
 
 cleanup:
 	return ret;
 }
+
+void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
+			      const char *submodule_name)
+{
+	strbuf_git_common_path(buf, r, "modules/");
+	strbuf_addstr(buf, submodule_name);
+}
diff --git a/submodule.h b/submodule.h
index 4644683e6c..0de9410dda 100644
--- a/submodule.h
+++ b/submodule.h
@@ -114,6 +114,13 @@ extern int push_unpushed_submodules(struct oid_array *commits,
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
+/*
+ * Given a submodule name, create a path to where the submodule's gitdir lives
+ * inside of the provided repository's 'modules' directory.
+ */
+void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
+			      const char *submodule_name);
+
 #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 1acef32647..c408e9010a 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -35,8 +35,10 @@ test_expect_success 'checkout main' \
     (cd clone/main &&
 	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
 
-test_expect_failure 'can see submodule diffs just after checkout' \
-    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_success 'can see submodule diffs just after checkout' '
+	git -C default_checkout/main diff --submodule master"^!" >out &&
+	grep "file1 updated" out
+'
 
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
-- 
2.18.0.597.ga71716f1ad-goog

