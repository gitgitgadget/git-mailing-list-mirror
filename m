Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C6B206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbcLLTEm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:42 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33030 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbcLLTEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:41 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so38235184pgd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=94+vm3ACsfWRFe2ivyD1dzRG+9etVzqk9lQokegLRQs=;
        b=U9wRTbr+6ncq/3okGNL2RvOLnV7jC+gX6HDEzpcExuOWvK8tF6PMx+QVOMEJP2SSff
         30L9kxCM3CscFG3zZgDp4NdvF1jZVSlmuVKt9654B3/Iv+Cy8hWHAjM/u2DzhkHUEbdn
         t3d9jhbwSd5FVISQyd7oMgzUF/2vgoPqxQXAxl9KnUj8XUVnGwFfQz9/mk5NhdU0a+zr
         3keuOlSH8sHYO15nGHYCla+ez8sjcz8lfUpRrxosbvLUoKI+PpDNeEqta+dNuXYxBIq5
         /9NuMKExshGi+Xl4TtBLm9gLqw60VlNQbMTfSOKfrHDcIGmUv3YY+6b7N7OWd40G0uHg
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=94+vm3ACsfWRFe2ivyD1dzRG+9etVzqk9lQokegLRQs=;
        b=a7rc+7fBypgPqB5b/ZaJSFJmO+eNtmflet467IzHMn6Hd/2AYPQLoLhUUFvFk6rFlh
         bd6M5RXBz4xw5xbWUKj+jMqgpjkQlVNQtnsrIVZzAnaWLQ9Ke3hoTnuoOJ9FUPXE5iu+
         L7qvoBnsE4SSjIDnh6T1o4ahTLVVbYAMPusQDI4GkpfI+uKhaaHXVns/FzuS6OLR0e+F
         hwfuvLJ90v5S/ptR8BBr3/JBOh7RyKLXw+VUIf1yPlgOVlrjIKKO4ZfU1YNUufpVkBqw
         Tv7lHyMOlzsJcvb0u+KvUb0eIGGfDlm5EqJ1f4Sc0QXw094eUenjXwU0CuCZa1nSRNfI
         DDrw==
X-Gm-Message-State: AKaTC01vl4Bcc2gY4kFXsScYUddTW6TTxxKZ7eWAOOsAPGyzK0BuEMCNtQLrqjnhI3ohZ5NI
X-Received: by 10.99.226.3 with SMTP id q3mr170607188pgh.37.1481569479605;
        Mon, 12 Dec 2016 11:04:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id 135sm77773338pgc.7.2016.12.12.11.04.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/6] submodule absorbgitdirs
Date:   Mon, 12 Dec 2016 11:04:29 -0800
Message-Id: <20161212190435.10358-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v8:
* Change the worktree implementation: do not have an internal
  submodule_get_worktrees, and count the number of worktrees, instead
  directly look if there is a worktrees dir and check if there are any files
  in there.
* reworded one test title slightly.
* interdiff to v7 (that is queued as origin/sb/submodule-embed-gitdir) below.

v7:
* do not expose submodule_get_worktrees. The values may be wrong internally,
  but for our purpose we do not care about the actual values, only the count.
  Document the wrong values!
* more strings are _(marked up)
* renamed variables in connect_work_tree_and_git_dir
* unsigned instead of int for options in the submodule helper.
* 

v6:
 * renamed embedgitdirs to absorbgitdirs embedding may be interpreted as
   embedding the git dir into the working directory, whereas absorbing sounds
   more like the submodule is absorbed by the superproject, making the
   submodule less independent
 * Worktrees API offer uses_worktrees(void) and submodule_uses_worktree(path).
 * moved the printing to stderr and one layer up (out of the pure
   relocate_git_dir function).
 * connect_... is in dir.h now.

v5:
* Add another layer of abstraction, i.e. the relocate_git_dir is only about
  moving a git dir of one repository. The submodule specific stuff (e.g.
  recursion into nested submodules) is in submodule.{c,h}

  This was motivated by reviews on the series of checkout aware of submodules
  building on top of this series, as we want to directly call the embed-git-dirs
  function without the overhead of spawning a child process.

v4:
* rebuilt on top of nd/worktree-list-fixup
* fix and test behavior for un-init submodules (don't crash, rather do nothing)
* incorporated a "static" as pointed out by Ramsay
* use internal functions instead of duplicating code in worktree.c
  (use get_common_dir_noenv for the submodule to actually get the common dir)
* fixed a memory leak in relocate_gitdir

v3:
* have a slightly more generic function "relocate_gitdir".
  The recursion is strictly related to submodules, though.
* bail out if a submodule is using worktrees.
  This also lays the groundwork for later doing the proper thing,
  as worktree.h offers a function `get_submodule_worktrees(path)`
* nit by duy: use git_path instead of git_common_dir

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
Stefan Beller (6):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: have a function to check if worktrees are in use
  move connect_work_tree_and_git_dir to dir.h
  submodule: add absorb-git-dir function

 Documentation/git-submodule.txt    |  15 +++++
 builtin/submodule--helper.c        |  69 ++++++++++++++++----
 dir.c                              |  37 +++++++++++
 dir.h                              |   4 ++
 git-submodule.sh                   |   7 +-
 git.c                              |   2 +-
 submodule.c                        | 127 ++++++++++++++++++++++++++++++-------
 submodule.h                        |   5 +-
 t/t7412-submodule-absorbgitdirs.sh | 101 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh            |  20 ++++--
 worktree.c                         |  68 +++++++++++++++++---
 worktree.h                         |   7 ++
 12 files changed, 409 insertions(+), 53 deletions(-)
 create mode 100755 t/t7412-submodule-absorbgitdirs.sh

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 7c4e8b8d79..1c47780e2b 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -93,7 +93,7 @@ test_expect_success 'setup a submodule with multiple worktrees' '
 	git -C sub3 worktree add ../sub3_second_work_tree
 '
 
-test_expect_success 'absorb a submodule with multiple worktrees' '
+test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
 	test_must_fail git submodule absorbgitdirs sub3 2>error &&
 	test_i18ngrep "not supported" error
 '
diff --git a/worktree.c b/worktree.c
index 1c46fcf25f..d4606aa8cd 100644
--- a/worktree.c
+++ b/worktree.c
@@ -72,7 +72,7 @@ static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(const char *git_common_dir)
+static struct worktree *get_main_worktree(void)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -81,12 +81,12 @@ static struct worktree *get_main_worktree(const char *git_common_dir)
 	int is_bare = 0;
 	int is_detached = 0;
 
-	strbuf_add_absolute_path(&worktree_path, git_common_dir);
+	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", git_common_dir);
+	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -101,8 +101,7 @@ static struct worktree *get_main_worktree(const char *git_common_dir)
 	return worktree;
 }
 
-static struct worktree *get_linked_worktree(const char *git_common_dir,
-					    const char *id)
+static struct worktree *get_linked_worktree(const char *id)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -113,7 +112,7 @@ static struct worktree *get_linked_worktree(const char *git_common_dir,
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_addf(&path, "%s/worktrees/%s/gitdir", git_common_dir, id);
+	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -126,7 +125,7 @@ static struct worktree *get_linked_worktree(const char *git_common_dir,
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", git_common_dir, id);
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -168,8 +167,7 @@ static int compare_worktree(const void *a_, const void *b_)
 	return fspathcmp((*a)->path, (*b)->path);
 }
 
-static struct worktree **get_worktrees_internal(const char *git_common_dir,
-						unsigned flags)
+struct worktree **get_worktrees(unsigned flags)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -179,10 +177,9 @@ static struct worktree **get_worktrees_internal(const char *git_common_dir,
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if (!(flags & GWT_LINKED_ONLY))
-		list[counter++] = get_main_worktree(git_common_dir);
+	list[counter++] = get_main_worktree();
 
-	strbuf_addf(&path, "%s/worktrees", git_common_dir);
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -191,7 +188,7 @@ static struct worktree **get_worktrees_internal(const char *git_common_dir,
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
+			if ((linked = get_linked_worktree(d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -212,34 +209,6 @@ static struct worktree **get_worktrees_internal(const char *git_common_dir,
 	return list;
 }
 
-struct worktree **get_worktrees(unsigned flags)
-{
-	return get_worktrees_internal(get_git_common_dir(), flags);
-}
-
-/*
- * NEEDSWORK: The values in the returned worktrees are broken, e.g.
- * the refs or path resolution is influenced by the current repository.
- */
-static struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
-{
-	char *submodule_gitdir;
-	struct strbuf sb = STRBUF_INIT;
-	struct worktree **ret;
-
-	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
-	if (!submodule_gitdir)
-		return NULL;
-
-	/* the env would be set for the superproject */
-	get_common_dir_noenv(&sb, submodule_gitdir);
-	ret = get_worktrees_internal(sb.buf, flags);
-
-	strbuf_release(&sb);
-	free(submodule_gitdir);
-	return ret;
-}
-
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
@@ -412,19 +381,52 @@ const struct worktree *find_shared_symref(const char *symref,
 	return existing;
 }
 
-int uses_worktrees(void)
-{
-	struct worktree **worktrees = get_worktrees(GWT_LINKED_ONLY);
-	int retval = (worktrees != NULL && worktrees[0] != NULL);
-	free_worktrees(worktrees);
-	return retval;
-}
-
 int submodule_uses_worktrees(const char *path)
 {
-	struct worktree **worktrees =
-			get_submodule_worktrees(path, GWT_LINKED_ONLY);
-	int retval = (worktrees != NULL && worktrees[0] != NULL);
-	free_worktrees(worktrees);
-	return retval;
+	char *submodule_gitdir;
+	struct strbuf sb = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+	int ret;
+	struct repository_format format;
+
+	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
+	if (!submodule_gitdir)
+		return 0;
+
+	/* The env would be set for the superproject. */
+	get_common_dir_noenv(&sb, submodule_gitdir);
+
+	/*
+	 * The check below is only known to be good for repository format
+	 * version 0 at the time of writing this code.
+	 */
+	strbuf_addstr(&sb, "/config");
+	read_repository_format(&format, sb.buf);
+	if (format.version != 0) {
+		strbuf_release(&sb);
+		return 1;
+	}
+
+	/* Replace config by worktrees. */
+	strbuf_setlen(&sb, sb.len - strlen("config"));
+	strbuf_addstr(&sb, "worktrees");
+
+	/* See if there is any file inside the worktrees directory. */
+	dir = opendir(sb.buf);
+	strbuf_release(&sb);
+	free(submodule_gitdir);
+
+	if (!dir)
+		return 0;
+
+	while ((d = readdir(dir)) != NULL) {
+		if (is_dot_or_dotdot(d->d_name))
+			continue;
+
+		ret = 1;
+		break;
+	}
+	closedir(dir);
+	return ret;
 }
diff --git a/worktree.h b/worktree.h
index ebe0856330..6bfb985203 100644
--- a/worktree.h
+++ b/worktree.h
@@ -16,7 +16,6 @@ struct worktree {
 /* Functions for acting on the information about worktrees. */
 
 #define GWT_SORT_LINKED (1 << 0) /* keeps linked worktrees sorted */
-#define GWT_LINKED_ONLY (1 << 1) /* do not include the main worktree */
 
 /*
  * Get the worktrees.  The primary worktree will always be the first returned,
@@ -31,7 +30,6 @@ extern struct worktree **get_worktrees(unsigned flags);
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-extern int uses_worktrees(void);
 extern int submodule_uses_worktrees(const char *path);
 
 /*


-- 
2.11.0.rc2.29.g7c00390.dirty

