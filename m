Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E92E1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbcLAU0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:11 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35974 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLAU0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:09 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so98193349pgc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=c2bsPij2784b70tlJdn/l9Dw86mlja+HOBc5iDqXt6k=;
        b=n1unYY5xXFH58h5lKmviKsIc5AuBB17YfD10Ep2gbQFYjgUP+7zS48MDop22P1k5JO
         F+MpmyXZZ04f3tr19JfNW0wrojztHcVUNHtkD2DoCbL/MUKH7xp6Kku8Ysmgn2qQPSmZ
         +3cgpvyGu14XfjFsx1R2xSOoTzDy2KyozPH47hGLbB7CZkDRrmP6ph7N6dCKS0ANr3yK
         N5FczEcLioWk/5rfVW1LOQxEafi7rCGH57dxX17HUCj0x6PTCCS4U8mevxZuXQKFfvy9
         npQXj9EwEucz9vFrOswdqZJTlkNu3tJU2CuefIiYIaLCz1qzs0oSibll9RcyzzlRc/Iq
         ETSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c2bsPij2784b70tlJdn/l9Dw86mlja+HOBc5iDqXt6k=;
        b=mLBp8+PnWTzjxk/ccxQNIoaaoA4ECJ1IR4+XcTTrtL6xCoVUEFb9shOhpPSkcPkSQ5
         BLcY+idrHU1b2wAH3j6NTsmPVjdVCgVwlYVHcg/ViqbzZkqsvdxy+qTw5wHEZnfhnD/t
         SHS3F3rplgmUTMlm++5GLWs07s5c6d5zjk8PM3gVlKv0GL2aZLiI4rDdN4KJB1KLe8sQ
         s81cN/4VEeXFne5AKNJLN8LOLi11+XHo0ULes3J8rJnmIATTkv9XXZZ3ahCv/R0Uy9RJ
         xoZyd+EG2KnJdCx9tbjS6vnsYFTRz4gjsROqn2JMCGb1IBVxCKFUH9hQ9uK19O8CCJWp
         vimw==
X-Gm-Message-State: AKaTC01f0oIN+XhtC2YrpguoSkcBxPoaXpXIs4gXLp+lpPSqDeYJ8m7A3NFV+Wq8sZXBbWhX
X-Received: by 10.84.141.129 with SMTP id 1mr88244303plv.102.1480623968603;
        Thu, 01 Dec 2016 12:26:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id c2sm2034518pfl.66.2016.12.01.12.26.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/5] submodule embedgitdirs
Date:   Thu,  1 Dec 2016 12:25:49 -0800
Message-Id: <20161201202554.19944-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* have a slightly more generic function "relocate_gitdir".
  The recursion is strictly related to submodules, though.
* bail out if a submodule is using worktrees.
  This also lays the groundwork for later doing the proper thing,
  as worktree.h offers a function `get_submodule_worktrees(path)`
* nit by duy: use git_path instead of git_common_dir

* diff to v2 (as queued by Junio) below.

Stefan Beller (5):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: get worktrees from submodules
  submodule: add embed-git-dir function

 Documentation/git-submodule.txt   | 14 ++++++
 builtin/submodule--helper.c       | 68 ++++++++++++++++++++++++-----
 dir.c                             | 78 +++++++++++++++++++++++++++++++++
 dir.h                             |  4 ++
 git-submodule.sh                  |  7 ++-
 git.c                             |  2 +-
 submodule.c                       | 12 ++---
 submodule.h                       |  1 -
 t/t7412-submodule-embedgitdirs.sh | 92 +++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh           | 20 ++++++---
 worktree.c                        | 40 ++++++++++++-----
 worktree.h                        |  5 +++
 12 files changed, 309 insertions(+), 34 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh

v2:
* fixed commit message for patch:
 "submodule: use absolute path for computing relative path connecting"
* a new patch "submodule helper: support super prefix"
* redid the final patch with more tests and fixing bugs along the way
* "test-lib-functions.sh: teach test_commit -C <dir>" unchanged

v1:
The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory.

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 75cdbf45b8..f2df166d15 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1081,11 +1081,14 @@ static int embed_git_dir(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
+	unsigned flags = RELOCATE_GITDIR_RECURSE_SUBMODULES;
 
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
+		OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
+			RELOCATE_GITDIR_RECURSE_SUBMODULES),
 		OPT_END()
 	};
 
@@ -1104,7 +1107,7 @@ static int embed_git_dir(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	for (i = 0; i < list.nr; i++)
-		migrate_submodule_gitdir(prefix, list.entries[i]->name, 1);
+		relocate_gitdir(prefix, list.entries[i]->name, flags);
 
 	return 0;
 }
diff --git a/dir.c b/dir.c
index bfa8c8a9a5..7b3abc1340 100644
--- a/dir.c
+++ b/dir.c
@@ -15,6 +15,9 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
+#include "submodule-config.h"
+#include "run-command.h"
+#include "worktree.h"
 
 struct path_simplify {
 	int len;
@@ -2748,3 +2751,78 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void relocate_gitdir(const char *prefix, const char *path, unsigned flags)
+{
+	char *old_git_dir;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	struct worktree **worktrees;
+	int i;
+
+	worktrees = get_submodule_worktrees(path);
+	for (i = 0; worktrees[i]; i++)
+		;
+	if (i > 1)
+		die(_("relocate_gitdir for submodule with more than one worktree not supported"));
+
+	old_git_dir = xstrfmt("%s/.git", path);
+	if (read_gitfile(old_git_dir))
+		/* If it is an actual gitfile, it doesn't need migration. */
+		goto out;
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		die(_("Could not lookup name for submodule '%s'"),
+		      path);
+
+	new_git_dir = git_path("modules/%s", sub->name);
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+
+	if (!prefix)
+		prefix = get_super_prefix();
+	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
+		prefix ? prefix : "", path,
+		real_path(old_git_dir), new_git_dir);
+
+	if (rename(old_git_dir, new_git_dir) < 0)
+		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+
+out:
+	if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
+			die("BUG: we don't know how to pass the flags down?");
+
+		if (get_super_prefix())
+			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, path);
+		strbuf_addch(&sb, '/');
+
+		cp.dir = path;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
+					    "submodule--helper",
+					   "embed-git-dirs", NULL);
+		prepare_submodule_repo_env(&cp.env_array);
+		if (run_command(&cp))
+			die(_("Could not migrate git directory in submodule '%s'"),
+			    path);
+
+		strbuf_release(&sb);
+	}
+
+	free(old_git_dir);
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..0b5e99b21d 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+
+#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern void relocate_gitdir(const char *prefix, const char *path, unsigned flags);
+
 #endif
diff --git a/submodule.c b/submodule.c
index d330b567a3..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1263,68 +1263,3 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
-
-/*
- * Migrate the given submodule (and all its submodules recursively) from
- * having its git directory within the working tree to the git dir nested
- * in its superprojects git dir under modules/.
- */
-void migrate_submodule_gitdir(const char *prefix, const char *path,
-			      int recursive)
-{
-	char *old_git_dir;
-	const char *new_git_dir;
-	const struct submodule *sub;
-
-	old_git_dir = xstrfmt("%s/.git", path);
-	if (read_gitfile(old_git_dir))
-		/* If it is an actual gitfile, it doesn't need migration. */
-		goto out;
-
-	sub = submodule_from_path(null_sha1, path);
-	if (!sub)
-		die(_("Could not lookup name for submodule '%s'"),
-		      path);
-
-	new_git_dir = git_common_path("modules/%s", sub->name);
-	if (safe_create_leading_directories_const(new_git_dir) < 0)
-		die(_("could not create directory '%s'"), new_git_dir);
-
-	if (!prefix)
-		prefix = get_super_prefix();
-	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
-		prefix ? prefix : "", path,
-		real_path(old_git_dir), new_git_dir);
-
-	if (rename(old_git_dir, new_git_dir) < 0)
-		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
-			old_git_dir, new_git_dir);
-
-	connect_work_tree_and_git_dir(path, new_git_dir);
-
-out:
-	if (recursive) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-		struct strbuf sb = STRBUF_INIT;
-
-		if (get_super_prefix())
-			strbuf_addstr(&sb, get_super_prefix());
-		strbuf_addstr(&sb, path);
-		strbuf_addch(&sb, '/');
-
-		cp.dir = path;
-		cp.git_cmd = 1;
-		cp.no_stdin = 1;
-		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
-					    "submodule--helper",
-					   "embed-git-dirs", NULL);
-		prepare_submodule_repo_env(&cp.env_array);
-		if (run_command(&cp))
-			die(_("Could not migrate git directory in submodule '%s'"),
-			    path);
-
-		strbuf_release(&sb);
-	}
-
-	free(old_git_dir);
-}
diff --git a/submodule.h b/submodule.h
index e5975d1f3d..1e42222cff 100644
--- a/submodule.h
+++ b/submodule.h
@@ -74,7 +74,4 @@ int parallel_submodules(void);
  * retaining any config in the environment.
  */
 void prepare_submodule_repo_env(struct argv_array *out);
-
-extern void migrate_submodule_gitdir(const char *prefix,
-				     const char *path, int recursive);
 #endif
diff --git a/t/t7412-submodule-embedgitdirs.sh b/t/t7412-submodule-embedgitdirs.sh
index 1cf5d4b4af..e3443b88cd 100755
--- a/t/t7412-submodule-embedgitdirs.sh
+++ b/t/t7412-submodule-embedgitdirs.sh
@@ -74,4 +74,19 @@ test_expect_success 'embedding the git dir fails for incomplete submodules' '
 	test_cmp expect.2 actual.2
 '
 
+test_expect_success 'setup a submodule with multiple worktrees' '
+	# first create another unembedded git dir in a new submodule
+	git init sub3 &&
+	test_commit -C sub3 first &&
+	git submodule add ./sub3 &&
+	test_tick &&
+	git commit -m "add another submodule" &&
+	git -C sub3 worktree add ../sub3_second_work_tree
+'
+
+test_expect_success 'embed a submodule with multiple worktrees' '
+	test_must_fail git submodule embedgitdirs sub3 2>error &&
+	test_i18ngrep "not supported" error
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index f7869f8d60..fb1f72bbf3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -72,7 +72,7 @@ static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(void)
+static struct worktree *get_main_worktree(const char *git_common_dir)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -81,12 +81,12 @@ static struct worktree *get_main_worktree(void)
 	int is_bare = 0;
 	int is_detached = 0;
 
-	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
+	strbuf_add_absolute_path(&worktree_path, git_common_dir);
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	strbuf_addf(&path, "%s/HEAD", git_common_dir);
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -109,7 +109,8 @@ static struct worktree *get_main_worktree(void)
 	return worktree;
 }
 
-static struct worktree *get_linked_worktree(const char *id)
+static struct worktree *get_linked_worktree(const char *git_common_dir,
+					    const char *id)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -120,7 +121,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
+	strbuf_addf(&path, "%s/worktrees/%s/gitdir", git_common_dir, id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -133,7 +134,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", git_common_dir, id);
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -173,7 +174,7 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
-struct worktree **get_worktrees(void)
+struct worktree **get_worktrees_internal(const char *git_common_dir)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -183,10 +184,10 @@ struct worktree **get_worktrees(void)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if ((list[counter] = get_main_worktree()))
+	if ((list[counter] = get_main_worktree(git_common_dir)))
 		counter++;
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", git_common_dir);
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -195,7 +196,7 @@ struct worktree **get_worktrees(void)
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(d->d_name))) {
+			if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -209,6 +210,25 @@ struct worktree **get_worktrees(void)
 	return list;
 }
 
+struct worktree **get_worktrees(void)
+{
+	return get_worktrees_internal(get_git_common_dir());
+}
+
+struct worktree **get_submodule_worktrees(const char *path)
+{
+	const char *submodule_common_dir;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree **ret;
+	strbuf_addf(&sb, "%s/.git", path);
+	submodule_common_dir = resolve_gitdir(sb.buf);
+
+	ret = get_worktrees_internal(submodule_common_dir);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index 90e1311fa7..c93845516c 100644
--- a/worktree.h
+++ b/worktree.h
@@ -25,6 +25,11 @@ struct worktree {
  */
 extern struct worktree **get_worktrees(void);
 
+/*
+ * Get the worktrees of a submodule named by `path`.
+ */
+extern struct worktree **get_submodule_worktrees(const char *path);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.


-- 
2.10.2.613.g22f2156

