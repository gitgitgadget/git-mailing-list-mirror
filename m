From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 36/46] Remove init_pathspec() in favor of parse_pathspec()
Date: Sun, 14 Jul 2013 15:35:59 +0700
Message-ID: <1373790969-13000-37-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHqU-0003HM-10
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab3GNIju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:50 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:54994 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab3GNIjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:49 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so10312514pbb.6
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2HD93AFIbRWXo0gfiexPxcdtu2JAUXtjfJ53Q5Wf1Y8=;
        b=ViRZBYDpA9U4lYaSf+aviE5Q2YMQ2w8h+zf9vVVXXrcjT2PtH17qJ5pu1uZVvL2zQ+
         5lpSTwEzqtyd6UPPiwHhWJr/hqx2ioweemdV92Ov+/svna3gGrbzHTGIDaj354a3Cd2B
         /VxniUefJlkUdg6DXh8k7M6moG0ZGFuMlxFhU6XRq+SK3C+TwSfHPEFrktWgVXzWfdcP
         aM/TpxfSvSJs66zXWj9toD8hGNqYrWuUL/Vm9D6s4bx1MBHhwukpid5qsuYKL4wf400S
         oyRuNzHs9zVNeZGzVabcLXP09M+V5k0nDIkqjGMJttgvoryugPtvtYXLZnytzn7ZvTcS
         uanA==
X-Received: by 10.68.253.227 with SMTP id ad3mr49637636pbd.63.1373791188753;
        Sun, 14 Jul 2013 01:39:48 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id vo8sm16612652pbc.5.2013.07.14.01.39.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230348>

While at there, move free_pathspec() to pathspec.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c    |  8 +-------
 builtin/log.c      |  2 +-
 builtin/ls-files.c | 11 +++++------
 diff-lib.c         |  2 +-
 dir.c              | 58 ----------------------------------------------=
--------
 merge-recursive.c  |  2 +-
 pathspec.c         |  6 ++++++
 pathspec.h         |  1 -
 revision.c         |  2 +-
 tree-diff.c        | 10 +++++-----
 10 files changed, 21 insertions(+), 81 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5bd721d..56e3d6b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -408,7 +408,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	init_pathspec(&diff_opts.pathspec, paths);
+	parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC, 0, "", paths)=
;
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -486,15 +486,12 @@ static struct origin *find_rename(struct scoreboa=
rd *sb,
 	struct origin *porigin =3D NULL;
 	struct diff_options diff_opts;
 	int i;
-	const char *paths[2];
=20
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename =3D DIFF_DETECT_RENAME;
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
-	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -1064,7 +1061,6 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 			       int opt)
 {
 	struct diff_options diff_opts;
-	const char *paths[1];
 	int i, j;
 	int retval;
 	struct blame_list *blame_list;
@@ -1078,8 +1074,6 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
=20
-	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	/* Try "find copies harder" on new path if requested;
diff --git a/builtin/log.c b/builtin/log.c
index e3222ed..873af69 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -503,7 +503,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	init_grep_defaults();
 	git_config(git_log_config, NULL);
=20
-	init_pathspec(&match_all, NULL);
+	memset(&match_all, 0, sizeof(match_all));
 	init_revisions(&rev, prefix);
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c074e6f..d3a0495 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -315,13 +315,12 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
 	}
=20
 	if (prefix) {
-		static const char *(matchbuf[2]);
-		matchbuf[0] =3D prefix;
-		matchbuf[1] =3D NULL;
-		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].nowildcard_len =3D pathspec.items[0].len;
+		static const char *(matchbuf[1]);
+		matchbuf[0] =3D NULL;
+		parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC,
+			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
-		init_pathspec(&pathspec, NULL);
+		memset(&pathspec, 0, sizeof(pathspec));
 	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
=20
diff --git a/diff-lib.c b/diff-lib.c
index d4e17f7..0a95763 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	struct rev_info revs;
=20
 	init_revisions(&revs, NULL);
-	init_pathspec(&revs.prune_data, opt->pathspec.raw);
+	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt =3D *opt;
=20
 	if (diff_cache(&revs, tree_sha1, NULL, 1))
diff --git a/dir.c b/dir.c
index 019ad09..959e694 100644
--- a/dir.c
+++ b/dir.c
@@ -1580,64 +1580,6 @@ int remove_path(const char *name)
 	return 0;
 }
=20
-static int pathspec_item_cmp(const void *a_, const void *b_)
-{
-	struct pathspec_item *a, *b;
-
-	a =3D (struct pathspec_item *)a_;
-	b =3D (struct pathspec_item *)b_;
-	return strcmp(a->match, b->match);
-}
-
-int init_pathspec(struct pathspec *pathspec, const char **paths)
-{
-	const char **p =3D paths;
-	int i;
-
-	memset(pathspec, 0, sizeof(*pathspec));
-	if (!p)
-		return 0;
-	while (*p)
-		p++;
-	pathspec->raw =3D paths;
-	pathspec->nr =3D p - paths;
-	if (!pathspec->nr)
-		return 0;
-
-	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
-	for (i =3D 0; i < pathspec->nr; i++) {
-		struct pathspec_item *item =3D pathspec->items+i;
-		const char *path =3D paths[i];
-
-		item->match =3D path;
-		item->original =3D path;
-		item->len =3D strlen(path);
-		item->flags =3D 0;
-		if (limit_pathspec_to_literal()) {
-			item->nowildcard_len =3D item->len;
-		} else {
-			item->nowildcard_len =3D simple_length(path);
-			if (item->nowildcard_len < item->len) {
-				pathspec->has_wildcard =3D 1;
-				if (path[item->nowildcard_len] =3D=3D '*' &&
-				    no_wildcard(path + item->nowildcard_len + 1))
-					item->flags |=3D PATHSPEC_ONESTAR;
-			}
-		}
-	}
-
-	qsort(pathspec->items, pathspec->nr,
-	      sizeof(struct pathspec_item), pathspec_item_cmp);
-
-	return 0;
-}
-
-void free_pathspec(struct pathspec *pathspec)
-{
-	free(pathspec->items);
-	pathspec->items =3D NULL;
-}
-
 int limit_pathspec_to_literal(void)
 {
 	static int flag =3D -1;
diff --git a/merge-recursive.c b/merge-recursive.c
index ea9dbd3..8395b9b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -297,7 +297,7 @@ static int get_files_dirs(struct merge_options *o, =
struct tree *tree)
 {
 	int n;
 	struct pathspec match_all;
-	init_pathspec(&match_all, NULL);
+	memset(&match_all, 0, sizeof(match_all));
 	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, =
o))
 		return 0;
 	n =3D o->current_file_set.nr + o->current_directory_set.nr;
diff --git a/pathspec.c b/pathspec.c
index 2774bda..74f0203 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -372,3 +372,9 @@ void copy_pathspec(struct pathspec *dst, const stru=
ct pathspec *src)
 	memcpy(dst->items, src->items,
 	       sizeof(struct pathspec_item) * dst->nr);
 }
+
+void free_pathspec(struct pathspec *pathspec)
+{
+	free(pathspec->items);
+	pathspec->items =3D NULL;
+}
diff --git a/pathspec.h b/pathspec.h
index 02dded3..cadd46c 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -53,7 +53,6 @@ struct pathspec {
 #define PATHSPEC_PREFIX_ORIGIN (1<<6)
 #define PATHSPEC_KEEP_ORDER (1<<7)
=20
-extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
 			   unsigned flags,
diff --git a/revision.c b/revision.c
index c2d44b7..001623a 100644
--- a/revision.c
+++ b/revision.c
@@ -1372,7 +1372,7 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 			i++;
 	}
 	free_pathspec(&revs->prune_data);
-	init_pathspec(&revs->prune_data, prune);
+	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC, 0, "", prune);
 	revs->limited =3D 1;
 }
=20
diff --git a/tree-diff.c b/tree-diff.c
index f4c92f6..e1145c6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -195,7 +195,6 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
 	struct diff_filepair *choice;
-	const char *paths[1];
 	int i;
=20
 	/*
@@ -228,8 +227,6 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	diff_opts.single_follow =3D opt->pathspec.raw[0];
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
-	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
@@ -247,14 +244,17 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 		 */
 		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
 		    !strcmp(p->two->path, opt->pathspec.raw[0])) {
+			const char *path[2];
+
 			/* Switch the file-pairs around */
 			q->queue[i] =3D choice;
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
+			path[0] =3D p->one->path;
+			path[1] =3D NULL;
 			free_pathspec(&opt->pathspec);
-			opt->pathspec.raw[0] =3D xstrdup(p->one->path);
-			init_pathspec(&opt->pathspec, opt->pathspec.raw);
+			parse_pathspec(&opt->pathspec, PATHSPEC_ALL_MAGIC, 0, "", path);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
--=20
1.8.2.83.gc99314b
