From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 28/31] Remove init_pathspec() in favor of parse_pathspec()
Date: Sun, 13 Jan 2013 19:35:36 +0700
Message-ID: <1358080539-17436-29-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMqN-000082-HL
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab3AMMi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:59 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:63449 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab3AMMi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:58 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so1415385dae.31
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=yT/r31gx3df6bz6u0y28mj1j2OWkEzK+I+X+c5bnQdI=;
        b=PPMEMlhvnO3Up5e/t45DgxnkBMEskYJ+Po+Wba8UzC8XWKlWSBKb5MgnX9xGJ5dP3e
         EpG/Fn5puxFbfxZqwiq9GXAx7gDFYfkeaGTOAxV2XIx0zRg4/FukFIsowBigxuHFHnUQ
         e+qFkhLQZnFYjLSUKoE4f1Wegp/Quwr/FfxgH7lFewAjsR7C3omvQTQfY/kq1ew6p9zL
         o+TQJU4G8SeB7BPz7kRtHQOek2XHfR7AdBdEHV33XQ8Ihv/isp4F6r1Gv1Sk6cibu73k
         qHFmKdEgbx3MzgtNihCDypF8S2z8XtfnAWN3VEjtdXZZ1IGVWhcWFMh2fLyjf1qdOJWD
         TT1g==
X-Received: by 10.68.136.73 with SMTP id py9mr70821093pbb.43.1358080737971;
        Sun, 13 Jan 2013 04:38:57 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ou3sm6290145pbb.46.2013.01.13.04.38.53
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:39:11 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213368>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c          |  2 +-
 builtin/blame.c    |  6 +++---
 builtin/log.c      |  2 +-
 builtin/ls-files.c | 10 ++++------
 cache.h            |  1 -
 diff-lib.c         |  2 +-
 dir.c              | 52 ----------------------------------------------=
------
 merge-recursive.c  |  2 +-
 revision.c         |  2 +-
 tree-diff.c        | 10 +++++-----
 10 files changed, 17 insertions(+), 72 deletions(-)

diff --git a/archive.c b/archive.c
index f1a28c9..ef50d49 100644
--- a/archive.c
+++ b/archive.c
@@ -219,7 +219,7 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 	struct pathspec pathspec;
 	int ret;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, 0, 0, "", paths);
 	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
 	free_pathspec(&pathspec);
 	return ret !=3D 0;
diff --git a/builtin/blame.c b/builtin/blame.c
index 5317d23..fdba756 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -406,7 +406,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	init_pathspec(&diff_opts.pathspec, paths);
+	parse_pathspec(&diff_opts.pathspec, 0, 0, "", paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -492,7 +492,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
 	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
+	parse_pathspec(&diff_opts.pathspec, 0, 0, "", paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -1072,7 +1072,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
=20
 	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
+	parse_pathspec(&diff_opts.pathspec, 0, 0, "", paths);
 	diff_setup_done(&diff_opts);
=20
 	/* Try "find copies harder" on new path if requested;
diff --git a/builtin/log.c b/builtin/log.c
index 3899b1d..e8f5514 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -455,7 +455,7 @@ int cmd_show(int argc, const char **argv, const cha=
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
index 6c4ee40..e3ccf50 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -318,13 +318,11 @@ void overlay_tree_on_cache(const char *tree_name,=
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
+		parse_pathspec(&pathspec, 0, 0, prefix, matchbuf);
 	} else
-		init_pathspec(&pathspec, NULL);
+		memset(&pathspec, 0, sizeof(pathspec));
 	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
=20
diff --git a/cache.h b/cache.h
index f7afb19..13cc217 100644
--- a/cache.h
+++ b/cache.h
@@ -511,7 +511,6 @@ struct pathspec {
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<2) /* has_symlink_leading_pa=
th */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<3)
=20
-extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
 			   unsigned flags, const char *prefix,
 			   const char **args);
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..e5236ab 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -500,7 +500,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
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
index 5d257fb..76b267e 100644
--- a/dir.c
+++ b/dir.c
@@ -1515,58 +1515,6 @@ int remove_path(const char *name)
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
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst =3D *src;
diff --git a/merge-recursive.c b/merge-recursive.c
index d882060..cd95bdb 100644
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
diff --git a/revision.c b/revision.c
index 451b223..231f53b 100644
--- a/revision.c
+++ b/revision.c
@@ -1112,7 +1112,7 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 			i++;
 	}
 	free_pathspec(&revs->prune_data);
-	init_pathspec(&revs->prune_data, prune);
+	parse_pathspec(&revs->prune_data, 0, 0, "", prune);
 	revs->limited =3D 1;
 }
=20
diff --git a/tree-diff.c b/tree-diff.c
index e63b787..aba6df7 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -196,7 +196,6 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q =3D &diff_queued_diff;
 	struct diff_filepair *choice;
-	const char *paths[1];
 	int i;
=20
 	/*
@@ -229,8 +228,6 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	diff_opts.single_follow =3D opt->pathspec.raw[0];
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
-	paths[0] =3D NULL;
-	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
@@ -248,14 +245,17 @@ static void try_to_follow_renames(struct tree_des=
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
+			parse_pathspec(&opt->pathspec, 0, 0, "", path);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
--=20
1.8.0.rc2.23.g1fb49df
