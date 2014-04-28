From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/32] read-cache: new API write_locked_index instead of write_index/write_cache
Date: Mon, 28 Apr 2014 17:55:25 +0700
Message-ID: <1398682553-11634-5-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDG-00015S-H3
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbaD1Ky7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:54:59 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:39206 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaD1Kyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:54 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so4766694pdj.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D6O3ZWCxYcScDQ6wbrseluUrWR4tZXR6/n6JW7ErYE8=;
        b=PhnT5vLS/n0T06xu0mQeBz1Csp1mzYuorOOaQCXygouJfwImY4bJwsXkBQcoy1qT4b
         L2wiOXVpzdMYSxOT88arPZjot6WUm1/+LkpGyblJOp+j0X6oXJmPJxI19pZHNmpYcz84
         qLskq0unhKphR2obY4Pjb3Zav0DLwyOiJBeLq/C0iOBCIYnvKRHfqNwbdbZEBUHffoLP
         EdJn9A1cD2Iwx14DMYxJ8W2/n+SE7/LY8RaeR4G7m9q/qcAHzBGl5uEnxXJwICt+Xpj0
         FzUjFN0EufK/aSw+8/FPqMy5c6xfNxHa/CxDQh5K956o0O7yC87/sOIM3657wgjNRT82
         hFuQ==
X-Received: by 10.66.144.102 with SMTP id sl6mr24330967pab.96.1398682494128;
        Mon, 28 Apr 2014 03:54:54 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id pb7sm89649817pac.10.2014.04.28.03.54.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:22 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247271>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c            |  6 ++----
 builtin/apply.c          |  9 ++++-----
 builtin/checkout-index.c |  3 +--
 builtin/checkout.c       | 11 ++++-------
 builtin/clone.c          |  7 +++----
 builtin/commit.c         | 33 ++++++++++++++-------------------
 builtin/merge.c          | 12 ++++--------
 builtin/mv.c             |  7 +++----
 builtin/read-tree.c      |  7 +++----
 builtin/reset.c          |  5 ++---
 builtin/rm.c             |  7 +++----
 builtin/update-index.c   |  3 +--
 cache-tree.c             |  3 +--
 cache.h                  |  6 ++++--
 merge-recursive.c        |  7 +++----
 merge.c                  |  7 +++----
 read-cache.c             | 28 ++++++++++++++++++++++++----
 rerere.c                 |  3 +--
 sequencer.c              | 12 +++++-------
 test-scrap-cache-tree.c  |  5 ++---
 20 files changed, 87 insertions(+), 94 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 459208a..4baf3a5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -299,7 +299,6 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status =3D 0;
-	int newfd;
 	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
@@ -345,7 +344,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	add_new_files =3D !take_worktree_changes && !refresh_only;
 	require_pathspec =3D !take_worktree_changes;
=20
-	newfd =3D hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, 1);
=20
 	flags =3D ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
@@ -443,8 +442,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 finish:
 	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(&lock_file))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
=20
diff --git a/builtin/apply.c b/builtin/apply.c
index 87439fa..5e13444 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3644,7 +3644,7 @@ static void build_fake_ancestor(struct patch *lis=
t, const char *filename)
 {
 	struct patch *patch;
 	struct index_state result =3D { NULL };
-	int fd;
+	static struct lock_file lock;
=20
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
@@ -3682,8 +3682,8 @@ static void build_fake_ancestor(struct patch *lis=
t, const char *filename)
 			die ("Could not add %s to temporary index", name);
 	}
=20
-	fd =3D open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0 || write_index(&result, fd) || close(fd))
+	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (write_locked_index(&result, &lock, COMMIT_LOCK))
 		die ("Could not write temporary index to %s", filename);
=20
 	discard_index(&result);
@@ -4501,8 +4501,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 	}
=20
 	if (update_index) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(&lock_file))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
=20
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 61e75eb..9e49bf2 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -279,8 +279,7 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 		checkout_all(prefix, prefix_length);
=20
 	if (0 <=3D newfd &&
-	    (write_cache(newfd, active_cache, active_nr) ||
-	     commit_locked_index(&lock_file)))
+	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07cf555..944a634 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -225,7 +225,6 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	int flag;
 	struct commit *head;
 	int errs =3D 0;
-	int newfd;
 	struct lock_file *lock_file;
=20
 	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED)
@@ -256,7 +255,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
-	newfd =3D hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("corrupt index file"));
=20
@@ -352,8 +351,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		}
 	}
=20
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock_file))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	read_ref_full("HEAD", rev, 0, &flag);
@@ -444,8 +442,8 @@ static int merge_working_tree(const struct checkout=
_opts *opts,
 {
 	int ret;
 	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
-	int newfd =3D hold_locked_index(lock_file, 1);
=20
+	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("corrupt index file"));
=20
@@ -553,8 +551,7 @@ static int merge_working_tree(const struct checkout=
_opts *opts,
 		}
 	}
=20
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock_file))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	if (!opts->force && !opts->quiet)
diff --git a/builtin/clone.c b/builtin/clone.c
index 9b3c04d..48f91f5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -616,7 +616,7 @@ static int checkout(void)
 	struct unpack_trees_options opts;
 	struct tree *tree;
 	struct tree_desc t;
-	int err =3D 0, fd;
+	int err =3D 0;
=20
 	if (option_no_checkout)
 		return 0;
@@ -640,7 +640,7 @@ static int checkout(void)
 	setup_work_tree();
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
-	fd =3D hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, 1);
=20
 	memset(&opts, 0, sizeof opts);
 	opts.update =3D 1;
@@ -656,8 +656,7 @@ static int checkout(void)
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
=20
-	if (write_cache(fd, active_cache, active_nr) ||
-	    commit_locked_index(lock_file))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	err |=3D run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..243b0c3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -305,7 +305,6 @@ static void refresh_cache_or_die(int refresh_flags)
 static char *prepare_index(int argc, const char **argv, const char *pr=
efix,
 			   const struct commit *current_head, int is_status)
 {
-	int fd;
 	struct string_list partial;
 	struct pathspec pathspec;
 	int refresh_flags =3D REFRESH_QUIET;
@@ -321,12 +320,11 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
=20
 	if (interactive) {
 		char *old_index_env =3D NULL;
-		fd =3D hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, 1);
=20
 		refresh_cache_or_die(refresh_flags);
=20
-		if (write_cache(fd, active_cache, active_nr) ||
-		    close_lock_file(&index_lock))
+		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to create temporary index"));
=20
 		old_index_env =3D getenv(INDEX_ENVIRONMENT);
@@ -360,12 +358,11 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
-		fd =3D hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    close_lock_file(&index_lock))
+		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style =3D COMMIT_NORMAL;
 		return index_lock.filename;
@@ -381,12 +378,12 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		fd =3D hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
 			update_main_cache_tree(WRITE_TREE_SILENT);
-			if (write_cache(fd, active_cache, active_nr) ||
-			    commit_locked_index(&index_lock))
+			if (write_locked_index(&the_index, &index_lock,
+					       COMMIT_LOCK))
 				die(_("unable to write new_index file"));
 		} else {
 			rollback_lock_file(&index_lock);
@@ -432,24 +429,22 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 	if (read_cache() < 0)
 		die(_("cannot read the index"));
=20
-	fd =3D hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
-	if (write_cache(fd, active_cache, active_nr) ||
-	    close_lock_file(&index_lock))
+	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 		die(_("unable to write new_index file"));
=20
-	fd =3D hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%"PRIuMAX,
-						(uintmax_t) getpid()),
-				       LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&false_lock,
+				  git_path("next-index-%"PRIuMAX,
+					   (uintmax_t) getpid()),
+				  LOCK_DIE_ON_ERROR);
=20
 	create_base_index(current_head);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
=20
-	if (write_cache(fd, active_cache, active_nr) ||
-	    close_lock_file(&false_lock))
+	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
 		die(_("unable to write temporary index file"));
=20
 	discard_cache();
diff --git a/builtin/merge.c b/builtin/merge.c
index 66d8843..bf770b6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -657,14 +657,12 @@ static int try_merge_strategy(const char *strateg=
y, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
 {
-	int index_fd;
 	struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
=20
-	index_fd =3D hold_locked_index(lock, 1);
+	hold_locked_index(lock, 1);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
-			(write_cache(index_fd, active_cache, active_nr) ||
-			 commit_locked_index(lock)))
+	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
 	rollback_lock_file(lock);
=20
@@ -672,7 +670,6 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 		int clean, x;
 		struct commit *result;
 		struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
-		int index_fd;
 		struct commit_list *reversed =3D NULL;
 		struct merge_options o;
 		struct commit_list *j;
@@ -700,12 +697,11 @@ static int try_merge_strategy(const char *strateg=
y, struct commit_list *common,
 		for (j =3D common; j; j =3D j->next)
 			commit_list_insert(j->item, &reversed);
=20
-		index_fd =3D hold_locked_index(lock, 1);
+		hold_locked_index(lock, 1);
 		clean =3D merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
-				(write_cache(index_fd, active_cache, active_nr) ||
-				 commit_locked_index(lock)))
+		    write_locked_index(&the_index, lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
 		rollback_lock_file(lock);
 		return clean ? 0 : 1;
diff --git a/builtin/mv.c b/builtin/mv.c
index 2a7243f..db40777 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -63,7 +63,7 @@ static struct lock_file lock_file;
=20
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd, gitmodules_modified =3D 0;
+	int i, gitmodules_modified =3D 0;
 	int verbose =3D 0, show_only =3D 0, force =3D 0, ignore_errors =3D 0;
 	struct option builtin_mv_options[] =3D {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -85,7 +85,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
=20
-	newfd =3D hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
=20
@@ -275,8 +275,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 		stage_updated_gitmodules();
=20
 	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(&lock_file))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
=20
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 0d7ef84..f26d90f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -99,7 +99,7 @@ static struct lock_file lock_file;
=20
 int cmd_read_tree(int argc, const char **argv, const char *unused_pref=
ix)
 {
-	int i, newfd, stage =3D 0;
+	int i, stage =3D 0;
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
@@ -149,7 +149,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	argc =3D parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
=20
-	newfd =3D hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, 1);
=20
 	prefix_set =3D opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
@@ -233,8 +233,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	if (nr_trees =3D=3D 1 && !opts.prefix)
 		prime_cache_tree(&active_cache_tree, trees[0]);
=20
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(&lock_file))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index f4e0875..0c56d28 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -351,7 +351,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (reset_type !=3D SOFT) {
 		struct lock_file *lock =3D xcalloc(1, sizeof(*lock));
-		int newfd =3D hold_locked_index(lock, 1);
+		hold_locked_index(lock, 1);
 		if (reset_type =3D=3D MIXED) {
 			int flags =3D quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, sha1, intent_to_add))
@@ -367,8 +367,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
=20
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(lock))
+		if (write_locked_index(&the_index, lock, COMMIT_LOCK))
 			die(_("Could not write new index file."));
 	}
=20
diff --git a/builtin/rm.c b/builtin/rm.c
index 960634d..bc6490b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ static struct option builtin_rm_options[] =3D {
=20
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd;
+	int i;
 	struct pathspec pathspec;
 	char *seen;
=20
@@ -293,7 +293,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	if (!index_only)
 		setup_work_tree();
=20
-	newfd =3D hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, 1);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
@@ -427,8 +427,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(&lock_file))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba54e19..42cbe4b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -921,8 +921,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 				exit(128);
 			unable_to_lock_index_die(get_index_file(), lock_error);
 		}
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_locked_index(lock_file))
+		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
=20
diff --git a/cache-tree.c b/cache-tree.c
index 7fa524a..52f8692 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -595,8 +595,7 @@ int write_cache_as_tree(unsigned char *sha1, int fl=
ags, const char *prefix)
 				      active_nr, flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <=3D newfd) {
-			if (!write_cache(newfd, active_cache, active_nr) &&
-			    !commit_lock_file(lock_file))
+			if (!write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 				newfd =3D -1;
 		}
 		/* Not being able to write is fine -- we are only interested
diff --git a/cache.h b/cache.h
index 107ac61..9cc2b97 100644
--- a/cache.h
+++ b/cache.h
@@ -301,7 +301,6 @@ extern void free_name_hash(struct index_state *ista=
te);
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (p=
athspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
-#define write_cache(newfd, cache, entries) write_index(&the_index, (ne=
wfd))
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name)=
,(namelen))
@@ -456,12 +455,15 @@ extern int daemonize(void);
 	} while (0)
=20
 /* Initialize and use the cache information */
+struct lock_file;
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
-extern int write_index(struct index_state *, int newfd);
+#define COMMIT_LOCK		(1 << 0)
+#define CLOSE_LOCK		(1 << 1)
+extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
diff --git a/merge-recursive.c b/merge-recursive.c
index 4177092..442c1ec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1986,7 +1986,7 @@ int merge_recursive_generic(struct merge_options =
*o,
 			    const unsigned char **base_list,
 			    struct commit **result)
 {
-	int clean, index_fd;
+	int clean;
 	struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
 	struct commit *head_commit =3D get_ref(head, o->branch1);
 	struct commit *next_commit =3D get_ref(merge, o->branch2);
@@ -2003,12 +2003,11 @@ int merge_recursive_generic(struct merge_option=
s *o,
 		}
 	}
=20
-	index_fd =3D hold_locked_index(lock, 1);
+	hold_locked_index(lock, 1);
 	clean =3D merge_recursive(o, head_commit, next_commit, ca,
 			result);
 	if (active_cache_changed &&
-			(write_cache(index_fd, active_cache, active_nr) ||
-			 commit_locked_index(lock)))
+	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
=20
 	return clean ? 0 : 1;
diff --git a/merge.c b/merge.c
index 70f1000..610725c 100644
--- a/merge.c
+++ b/merge.c
@@ -66,13 +66,13 @@ int checkout_fast_forward(const unsigned char *head=
,
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
-	int i, fd, nr_trees =3D 0;
+	int i, nr_trees =3D 0;
 	struct dir_struct dir;
 	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	refresh_cache(REFRESH_QUIET);
=20
-	fd =3D hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, 1);
=20
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
@@ -105,8 +105,7 @@ int checkout_fast_forward(const unsigned char *head=
,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_cache(fd, active_cache, active_nr) ||
-		commit_locked_index(lock_file))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index ba13353..44d4732 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1779,13 +1779,11 @@ static int has_racy_timestamp(struct index_stat=
e *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file=
 *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    !write_index(istate, lockfile->fd))
-		commit_locked_index(lockfile);
-	else
+	    write_locked_index(istate, lockfile, COMMIT_LOCK))
 		rollback_lock_file(lockfile);
 }
=20
-int write_index(struct index_state *istate, int newfd)
+static int do_write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
@@ -1877,6 +1875,28 @@ int write_index(struct index_state *istate, int =
newfd)
 	return 0;
 }
=20
+static int do_write_locked_index(struct index_state *istate, struct lo=
ck_file *lock,
+				 unsigned flags)
+{
+	int ret =3D do_write_index(istate, lock->fd);
+	if (ret)
+		return ret;
+	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
+	       (COMMIT_LOCK | CLOSE_LOCK));
+	if (flags & COMMIT_LOCK)
+		return commit_locked_index(lock);
+	else if (flags & CLOSE_LOCK)
+		return close_lock_file(lock);
+	else
+		return ret;
+}
+
+int write_locked_index(struct index_state *istate, struct lock_file *l=
ock,
+		       unsigned flags)
+{
+	return do_write_locked_index(istate, lock, flags);
+}
+
 /*
  * Read the index file that is potentially unmerged into given
  * index_state, dropping any unmerged entries.  Returns true if
diff --git a/rerere.c b/rerere.c
index d55aa8a..ffc6a5b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -492,8 +492,7 @@ static int update_paths(struct string_list *update)
 	}
=20
 	if (!status && active_cache_changed) {
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(&index_lock))
+		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("Unable to write new index file");
 	} else if (fd >=3D 0)
 		rollback_lock_file(&index_lock);
diff --git a/sequencer.c b/sequencer.c
index 7b886a6..4fb0774 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -294,11 +294,11 @@ static int do_recursive_merge(struct commit *base=
, struct commit *next,
 {
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
-	int clean, index_fd;
+	int clean;
 	const char **xopt;
 	static struct lock_file index_lock;
=20
-	index_fd =3D hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, 1);
=20
 	read_cache();
=20
@@ -319,8 +319,7 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 			    next_tree, base_tree, &result);
=20
 	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(&index_lock)))
+	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
 		die(_("%s: Unable to write new index file"), action_name(opts));
 	rollback_lock_file(&index_lock);
@@ -675,13 +674,12 @@ static void prepare_revs(struct replay_opts *opts=
)
 static void read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
-	int index_fd =3D hold_locked_index(&index_lock, 0);
+	hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("git %s: failed to read the index"), action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,=
 NULL);
 	if (the_index.cache_changed && index_fd >=3D 0) {
-		if (write_index(&the_index, index_fd) ||
-		    commit_locked_index(&index_lock))
+		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die(_("git %s: failed to refresh the index"), action_name(opts));
 	}
 	rollback_lock_file(&index_lock);
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 4728013..9ebcbca 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -6,12 +6,11 @@ static struct lock_file index_lock;
=20
 int main(int ac, char **av)
 {
-	int fd =3D hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, 1);
 	if (read_cache() < 0)
 		die("unable to read index file");
 	active_cache_tree =3D NULL;
-	if (write_cache(fd, active_cache, active_nr)
-	    || commit_lock_file(&index_lock))
+	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
 	return 0;
 }
--=20
1.9.1.346.ga2b5940
