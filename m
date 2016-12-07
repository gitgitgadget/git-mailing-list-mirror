Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF0E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbcLGVCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:02:03 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36839 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbcLGVCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:02:01 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so165244379pgc.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yzQUr+mSN4ZFdzw0p7kSZ+1BjPThwPw+ulDiBg618no=;
        b=QXkqB87y85UbRA8g8ANa1GTi5vIz/aeiGD9y2amiNv+MBIEAhLM7fd+PteMqa72wNg
         Th8l/sD61FzaVWVYGlyDznHP64vIYrY1oFwQiF9lKDdIUrTrkfuyP/XWqYE9stvNH/U0
         ZT9Zqs4R4wLdBxcbr9qXAu8F3UiJOMiJIQ247UlwMALTIZ1sq1IpZcwS4Y7EB4Ql1wHs
         dLxMutkkkKD6rly6Uaz8tKZJZRBGU35bW3lTGk8NlTjToLlxfL6ZJqwvGBdQTUUgC7mN
         XqC70/HP0dbDwkudxMO9IwcSkx5q667xJad209Z9v4knwV5YFRSFMfeak/p1IHyqxADS
         vniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yzQUr+mSN4ZFdzw0p7kSZ+1BjPThwPw+ulDiBg618no=;
        b=Ve3boew+v2He17zGAFTRZcLBI09Y0BoU9V29d+5sVjwKzla/X6XVuuZdV1JYDTLidB
         Jew3MhhIH2ZMA5Vb0WcfTgV6S0nYalq3rlKcndfLz4uRb9oG2VuNFutWpUSlXhU8RMqo
         Kf/hffCeT9ZMN3/+QRmk1mrUPeE8fOVPlHwHs3SXFj5uZNf46npEGy4oVR8ZFzosPafE
         3gPcFRDjpRpAeqp/oC4o0NoBam3IuM1mRnkkJQhuiHXX4PjbfCfc7UKUlWMBEfg6+v52
         TG9Z8PLgRLce5Tfp4zuxm1kfjjQZVNz+UvDHo0g5rdUt7WaLBl0pips+88uXhoetWNoe
         0R/g==
X-Gm-Message-State: AKaTC007ewAfF3c47tK6FZehrl7QiyMJGPsZ48BvMbgSLswQYT70gf2s6sTugF07JWzwe3J5
X-Received: by 10.98.220.75 with SMTP id t72mr70049623pfg.164.1481144519934;
        Wed, 07 Dec 2016 13:01:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id f132sm44651804pfa.72.2016.12.07.13.01.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 13:01:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/5] submodule embedgitdirs
Date:   Wed,  7 Dec 2016 13:01:52 -0800
Message-Id: <20161207210157.18932-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2af45f1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5:
* Add another layer of abstraction, i.e. the relocate_git_dir is only about 
  moving a git dir of one repository. The submodule specific stuff (e.g.
  recursion into nested submodules) is in submodule.{c,h}
  
  This was motivated by reviews on the series of checkout aware of submodules
  building on top of this series, as we want to directly call the embed-git-dirs
  function without the overhead of spawning a child process.
  
Thanks,
Stefan
 
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

Stefan Beller (5):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: get worktrees from submodules
  submodule: add embed-git-dir function

 Documentation/git-submodule.txt   |  14 +++++
 builtin/submodule--helper.c       |  68 ++++++++++++++++----
 dir.c                             |  27 ++++++++
 dir.h                             |   3 +
 git-submodule.sh                  |   7 ++-
 git.c                             |   2 +-
 submodule.c                       | 127 ++++++++++++++++++++++++++++++++++++--
 submodule.h                       |   7 +++
 t/t7412-submodule-embedgitdirs.sh | 101 ++++++++++++++++++++++++++++++
 t/test-lib-functions.sh           |  20 ++++--
 worktree.c                        |  47 +++++++++++---
 worktree.h                        |   6 ++
 12 files changed, 396 insertions(+), 33 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh
 
diff to v4:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 10df69c86a..321c9e250a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1106,31 +1106,8 @@ static int embed_git_dir(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
-	for (i = 0; i < list.nr; i++) {
-		const char *path = list.entries[i]->name, *sub_git_dir, *v;
-		char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
-		struct strbuf gitdir = STRBUF_INIT;
-
-		strbuf_addf(&gitdir, "%s/.git", path);
-		sub_git_dir = resolve_gitdir(gitdir.buf);
-
-		/* not populated? */
-		if (!sub_git_dir)
-			goto free_and_continue;
-
-		/* Is it already embedded? */
-		real_sub_git_dir = xstrdup(real_path(sub_git_dir));
-		real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
-		if (skip_prefix(real_sub_git_dir, real_common_git_dir, &v), NULL)
-			goto free_and_continue;
-
-		relocate_gitdir(prefix, path, flags);
-
-free_and_continue:
-		strbuf_release(&gitdir);
-		free(real_sub_git_dir);
-		free(real_common_git_dir);
-	}
+	for (i = 0; i < list.nr; i++)
+		submodule_embed_git_dir(prefix, list.entries[i]->name, flags);
 
 	return 0;
 }
diff --git a/dir.c b/dir.c
index d2f60b5abf..e023b04407 100644
--- a/dir.c
+++ b/dir.c
@@ -15,9 +15,6 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
-#include "submodule-config.h"
-#include "run-command.h"
-#include "worktree.h"
 
 struct path_simplify {
 	int len;
@@ -2753,79 +2750,28 @@ void untracked_cache_add_to_index(struct index_state *istate,
 }
 
 /*
- * Migrate the given submodule (and all its submodules recursively) from
- * having its git directory within the working tree to the git dir nested
- * in its superprojects git dir under modules/.
+ * Migrate the git directory of the given `path` from `old_git_dir` to
+ * `new_git_dir`. If an error occurs, append it to `err` and return the
+ * error code.
  */
-void relocate_gitdir(const char *prefix, const char *path, unsigned flags)
+int relocate_gitdir(const char *path, const char *old_git_dir,
+		    const char *new_git_dir, const char *displaypath,
+		    struct strbuf *err)
 {
-	char *old_git_dir;
-	const char *new_git_dir;
-	const struct submodule *sub;
-	struct worktree **worktrees;
-	int i;
-
-	worktrees = get_submodule_worktrees(path, 0);
-	if (worktrees) {
-		for (i = 0; worktrees[i]; i++)
-			;
-		free_worktrees(worktrees);
-		if (i > 1)
-			die(_("relocate_gitdir for submodule with more than one worktree not supported"));
-	}
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
+	int ret = 0;
 
-	new_git_dir = git_path("modules/%s", sub->name);
-	if (safe_create_leading_directories_const(new_git_dir) < 0)
-		die(_("could not create directory '%s'"), new_git_dir);
+	printf("Migrating git directory of '%s' from\n'%s' to\n'%s'\n",
+		displaypath, old_git_dir, new_git_dir);
 
-	if (!prefix)
-		prefix = get_super_prefix();
-	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
-		prefix ? prefix : "", path,
-		real_path(old_git_dir), new_git_dir);
-
-	if (rename(old_git_dir, new_git_dir) < 0)
-		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
+	if (rename(old_git_dir, new_git_dir) < 0) {
+		ret = errno;
+		strbuf_addf(err,
+			_("could not migrate git directory from '%s' to '%s'"),
 			old_git_dir, new_git_dir);
+		return ret;
+	}
 
 	connect_work_tree_and_git_dir(path, new_git_dir);
 
-out:
-	if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-		struct strbuf sb = STRBUF_INIT;
-
-		if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
-			die("BUG: we don't know how to pass the flags down?");
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
+	return ret;
 }
diff --git a/dir.h b/dir.h
index 0b5e99b21d..bf06729a86 100644
--- a/dir.h
+++ b/dir.h
@@ -335,8 +335,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
-
-#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
-extern void relocate_gitdir(const char *prefix, const char *path, unsigned flags);
-
+extern int relocate_gitdir(const char *path, const char *old_git_dir,
+			   const char *new_git_dir, const char *displaypath,
+			   struct strbuf *err);
 #endif
diff --git a/submodule.c b/submodule.c
index 66c5ce5a24..67a91275b8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,7 @@
 #include "blob.h"
 #include "thread-utils.h"
 #include "quote.h"
+#include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
@@ -1263,3 +1264,117 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+/* Embeds a single submodule, non recursively. */
+static void submodule_embed_git_dir_for_path(const char *prefix, const char *path)
+{
+	struct worktree **worktrees;
+	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf errbuf = STRBUF_INIT;
+	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	int code;
+
+	worktrees = get_submodule_worktrees(path, 0);
+	if (worktrees) {
+		int i;
+		for (i = 0; worktrees[i]; i++)
+			;
+		free_worktrees(worktrees);
+		if (i > 1)
+			die(_("relocate_gitdir for submodule '%s' with "
+			    "more than one worktree not supported"), path);
+	}
+
+	old_git_dir = xstrfmt("%s/.git", path);
+	if (read_gitfile(old_git_dir))
+		/* If it is an actual gitfile, it doesn't need migration. */
+		return;
+
+	real_old_git_dir = xstrdup(real_path(old_git_dir));
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		die(_("could not lookup name for submodule '%s'"), path);
+
+	new_git_dir = git_path("modules/%s", sub->name);
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+	real_new_git_dir = xstrdup(real_path(new_git_dir));
+
+	if (!prefix)
+		prefix = get_super_prefix();
+	strbuf_addf(&pathbuf, "%s%s", prefix ? prefix : "", path);
+
+	code = relocate_gitdir(path, real_old_git_dir, real_new_git_dir,
+			       pathbuf.buf, &errbuf);
+	if (code) {
+		errno = code;
+		die_errno("%s\n", errbuf.buf);
+	}
+
+	free(old_git_dir);
+	free(real_old_git_dir);
+	free(real_new_git_dir);
+	strbuf_release(&pathbuf);
+}
+
+/*
+ * Migrate the git directory of the submodule given by path from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+int submodule_embed_git_dir(const char *prefix,
+			    const char *path,
+			    unsigned flags)
+{
+	const char *sub_git_dir, *v;
+	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+	struct strbuf gitdir = STRBUF_INIT;
+
+
+	strbuf_addf(&gitdir, "%s/.git", path);
+	sub_git_dir = resolve_gitdir(gitdir.buf);
+
+	/* Not populated? */
+	if (!sub_git_dir)
+		goto out;
+
+	/* Is it already embedded? */
+	real_sub_git_dir = xstrdup(real_path(sub_git_dir));
+	real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
+	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
+		submodule_embed_git_dir_for_path(prefix, path);
+
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
+			die(_("could not recurse into submodule '%s'"), path);
+
+		strbuf_release(&sb);
+	}
+
+out:
+	strbuf_release(&gitdir);
+	free(real_sub_git_dir);
+	free(real_common_git_dir);
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index d9e197a948..922cfd258f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -75,4 +75,11 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
+/*
+ * Embed a git dir of the submodule given by path.
+ */
+#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern int submodule_embed_git_dir(const char *prefix,
+				   const char *path,
+				   unsigned flags);
 #endif

 
-- 
2.11.0.rc2.28.g2af45f1.dirty

