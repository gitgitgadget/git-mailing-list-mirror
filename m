From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/21] Convert struct diff_options to use struct pathspec
Date: Wed, 15 Dec 2010 22:02:38 +0700
Message-ID: <1292425376-14550-4-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsty-0000Kl-7T
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab0LOPER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54659 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LOPEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:16 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so1083931yxt.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YlIWAsZvgj1FettbPaMH05W6xabb651cpg3AWb2tWzQ=;
        b=PTqTRDMwts7CGmSKL8DoWM3dEST68suzlfHyojwLyWPiIBas17yGiiqLeMTtiYHiqV
         TACfLVlXcWNWpjAzhY+M8Ft5WGNErUK7EK+/q62wh/GhImF+ShFx24Eu2zJM1DJS7Wpo
         8S72t+qT4+gpfJc7hrm5WIKMF1X31khMEpzkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OxuRKuFYWh7kRTYa8jth3CgsVZvDR5APhMiceotOBzX+8daA9S0aP9B+X6d0MWohs0
         gCutgIeSN9OFQH1o5JkhdOK+GF2Wo3vzIP+Llm+6fFiAqDMHOEpiiC8kdc8Wwb55Oikh
         n66BLjqUZg013T9E49VQ3HPpEm8CN4dmp6yj8=
Received: by 10.42.167.131 with SMTP id s3mr6027666icy.305.1292425455512;
        Wed, 15 Dec 2010 07:04:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id y3sm848992icw.11.2010.12.15.07.04.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:22 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163759>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff-files.c |    2 +-
 builtin/diff.c       |    4 ++--
 builtin/log.c        |    2 +-
 diff-lib.c           |    2 +-
 diff-no-index.c      |    4 ++--
 diff.h               |    4 +---
 revision.c           |    6 +-----
 tree-diff.c          |   48 +++++++++++++-----------------------------=
------
 8 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 951c7c8..46085f8 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -61,7 +61,7 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges =3D rev.dense_combined_merges =3D 1;
=20
-	if (read_cache_preload(rev.diffopt.paths) < 0) {
+	if (read_cache_preload(rev.diffopt.pathspec.raw) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..76c42d8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -135,7 +135,7 @@ static int builtin_diff_index(struct rev_info *revs=
,
 	    revs->max_count !=3D -1 || revs->min_age !=3D -1 ||
 	    revs->max_age !=3D -1)
 		usage(builtin_diff_usage);
-	if (read_cache_preload(revs->diffopt.paths) < 0) {
+	if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
@@ -237,7 +237,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 		revs->combine_merges =3D revs->dense_combined_merges =3D 1;
=20
 	setup_work_tree();
-	if (read_cache_preload(revs->diffopt.paths) < 0) {
+	if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/builtin/log.c b/builtin/log.c
index eaa1ee0..92779a5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -89,7 +89,7 @@ static void cmd_log_init(int argc, const char **argv,=
 const char *prefix,
 		rev->always_show_header =3D 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header =3D 0;
-		if (rev->diffopt.nr_paths !=3D 1)
+		if (rev->diffopt.pathspec.nr !=3D 1)
 			usage("git logs can only follow renames on one pathname at a time")=
;
 	}
 	for (i =3D 1; i < argc; i++) {
diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..3b809f2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	active_nr =3D dst - active_cache;
=20
 	init_revisions(&revs, NULL);
-	revs.prune_data =3D opt->paths;
+	revs.prune_data =3D opt->pathspec.raw;
 	tree =3D parse_tree_indirect(tree_sha1);
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
diff --git a/diff-no-index.c b/diff-no-index.c
index e48ab92..3a36144 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -260,8 +260,8 @@ void diff_no_index(struct rev_info *revs,
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
=20
-	if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
-		       revs->diffopt.paths[1]))
+	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.raw[0],
+		       revs->diffopt.pathspec.raw[1]))
 		exit(1);
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/diff.h b/diff.h
index bf2f44d..6497b71 100644
--- a/diff.h
+++ b/diff.h
@@ -133,9 +133,7 @@ struct diff_options {
 	FILE *file;
 	int close_file;
=20
-	int nr_paths;
-	const char **paths;
-	int *pathlens;
+	struct pathspec pathspec;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
diff --git a/revision.c b/revision.c
index b1c1890..b2a5867 100644
--- a/revision.c
+++ b/revision.c
@@ -553,11 +553,7 @@ static void cherry_pick_list(struct commit_list *l=
ist, struct rev_info *revs)
=20
 	left_first =3D left_count < right_count;
 	init_patch_ids(&ids);
-	if (revs->diffopt.nr_paths) {
-		ids.diffopts.nr_paths =3D revs->diffopt.nr_paths;
-		ids.diffopts.paths =3D revs->diffopt.paths;
-		ids.diffopts.pathlens =3D revs->diffopt.pathlens;
-	}
+	ids.diffopts.pathspec =3D revs->diffopt.pathspec;
=20
 	/* Compute patch-ids for one side */
 	for (p =3D list; p; p =3D p->next) {
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..7a4cc4b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -100,16 +100,17 @@ static int tree_entry_interesting(struct tree_des=
c *desc, const char *base, int
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->nr_paths)
+	if (!opt->pathspec.nr)
 		return 1;
=20
 	sha1 =3D tree_entry_extract(desc, &path, &mode);
=20
 	pathlen =3D tree_entry_len(path, sha1);
=20
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
+	for (i =3D 0; i < opt->pathspec.nr; i++) {
+		const struct pathspec_item *item =3D opt->pathspec.items+i;
+		const char *match =3D item->match;
+		int matchlen =3D item->len;
 		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
@@ -289,7 +290,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2, const char *base, stru
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
-		if (opt->nr_paths) {
+		if (opt->pathspec.nr) {
 			skip_uninteresting(t1, base, baselen, opt);
 			skip_uninteresting(t2, base, baselen, opt);
 		}
@@ -348,7 +349,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow =3D opt->paths[0];
+	diff_opts.single_follow =3D opt->pathspec.raw[0];
 	diff_opts.break_opt =3D opt->break_opt;
 	paths[0] =3D NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
@@ -368,15 +369,16 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 		 * diff_queued_diff, we will also use that as the path in
 		 * the future!
 		 */
-		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') && !strcmp(p->two=
->path, opt->paths[0])) {
+		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
+		    !strcmp(p->two->path, opt->pathspec.raw[0])) {
 			/* Switch the file-pairs around */
 			q->queue[i] =3D choice;
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
 			diff_tree_release_paths(opt);
-			opt->paths[0] =3D xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->paths, opt);
+			opt->pathspec.raw[0] =3D xstrdup(p->one->path);
+			diff_tree_setup_paths(opt->pathspec.raw, opt);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
@@ -451,36 +453,12 @@ int diff_root_tree_sha1(const unsigned char *new,=
 const char *base, struct diff_
 	return retval;
 }
=20
-static int count_paths(const char **paths)
-{
-	int i =3D 0;
-	while (*paths++)
-		i++;
-	return i;
-}
-
 void diff_tree_release_paths(struct diff_options *opt)
 {
-	free(opt->pathlens);
+	free_pathspec(&opt->pathspec);
 }
=20
 void diff_tree_setup_paths(const char **p, struct diff_options *opt)
 {
-	opt->nr_paths =3D 0;
-	opt->pathlens =3D NULL;
-	opt->paths =3D NULL;
-
-	if (p) {
-		int i;
-
-		opt->paths =3D p;
-		opt->nr_paths =3D count_paths(p);
-		if (opt->nr_paths =3D=3D 0) {
-			opt->pathlens =3D NULL;
-			return;
-		}
-		opt->pathlens =3D xmalloc(opt->nr_paths * sizeof(int));
-		for (i=3D0; i < opt->nr_paths; i++)
-			opt->pathlens[i] =3D strlen(p[i]);
-	}
+	init_pathspec(&opt->pathspec, p);
 }
--=20
1.7.3.3.476.g10a82
