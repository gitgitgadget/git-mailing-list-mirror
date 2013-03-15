From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 35/45] Remove diff_tree_{setup,release}_paths
Date: Fri, 15 Mar 2013 13:06:50 +0700
Message-ID: <1363327620-29017-36-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO82-0007et-Db
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab3COG2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:07 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:61404 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab3COG2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:05 -0400
Received: by mail-ia0-f175.google.com with SMTP id y26so634577iab.34
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XujokTJB0OBh2LBD8P4tXX6GqV7TI9Muix9BrzdRLF4=;
        b=Qbtcz4EEDTEZkCXeOQje9bT3FgpvX2SfgDYlkpBluD+LmfrF7RjctEkvupe2Eu/beh
         uAvzPvu0aUA+z5I+D9/QvDw+FhIctq5XsCtpqmeNrGhplIEAV3J4XXkCXlsRG73/0TU9
         lAhT5mBD8BOggL2qJ8v/eeLZJ0jq3z8xPcvsPgbgoUFKHoVhl3vLw8LM2RYAE8Ff1a6s
         orZu7w1YitXuem0oKe/An4KTozc/+GtbfTPvxXwmzMZwYex6bQOXN7LvKRuQfGgsl6LJ
         q2JuvGNb/ENk1+N2u+yjbhSQq2WtdQRgmBtl6eTrR8zoROGPgl0sMqE8xfyKD+CKUGt7
         ZBgw==
X-Received: by 10.50.194.129 with SMTP id hw1mr313051igc.8.1363328884788;
        Thu, 14 Mar 2013 23:28:04 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id i10sm609347igz.9.2013.03.14.23.28.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:04 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:06 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218222>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 12 ++++++------
 builtin/reset.c |  9 +++++----
 diff.h          |  2 --
 notes-merge.c   |  4 ++--
 revision.c      |  5 +++--
 tree-diff.c     | 18 ++++--------------
 6 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86100e9..da2dc4c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -407,7 +407,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -457,7 +457,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -493,7 +493,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -515,7 +515,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
=20
@@ -1073,7 +1073,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
=20
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	/* Try "find copies harder" on new path if requested;
@@ -1156,7 +1156,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	}
 	reset_scanned_flag(sb);
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	return retval;
 }
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index 7c6e8b6..ab3917d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -130,12 +130,13 @@ static void update_index_from_diff(struct diff_qu=
eue_struct *q,
 	}
 }
=20
-static int read_from_tree(const char **pathspec, unsigned char *tree_s=
ha1)
+static int read_from_tree(const struct pathspec *pathspec,
+			  unsigned char *tree_sha1)
 {
 	struct diff_options opt;
=20
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(pathspec, &opt);
+	copy_pathspec(&opt.pathspec, pathspec);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
=20
@@ -144,7 +145,7 @@ static int read_from_tree(const char **pathspec, un=
signed char *tree_sha1)
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	free_pathspec(&opt.pathspec);
=20
 	return 0;
 }
@@ -329,7 +330,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
 		int newfd =3D hold_locked_index(lock, 1);
 		if (reset_type =3D=3D MIXED) {
-			if (read_from_tree(pathspec.raw, sha1))
+			if (read_from_tree(&pathspec, sha1))
 				return 1;
 		} else {
 			int err =3D reset_index(sha1, reset_type, quiet);
diff --git a/diff.h b/diff.h
index d1bc914..b8df245 100644
--- a/diff.h
+++ b/diff.h
@@ -180,8 +180,6 @@ const char *diff_line_prefix(struct diff_options *)=
;
=20
 extern const char mime_boundary_leader[];
=20
-extern void diff_tree_setup_paths(const char **paths, struct diff_opti=
ons *);
-extern void diff_tree_release_paths(struct diff_options *);
 extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
diff --git a/notes-merge.c b/notes-merge.c
index 0f67bd3..f1a3b39 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -169,7 +169,7 @@ static struct notes_merge_pair *diff_tree_remote(st=
ruct notes_merge_options *o,
 		       sha1_to_hex(mp->remote));
 	}
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	free_pathspec(&opt.pathspec);
=20
 	*num_changes =3D len;
 	return changes;
@@ -255,7 +255,7 @@ static void diff_tree_local(struct notes_merge_opti=
ons *o,
 		       sha1_to_hex(mp->local));
 	}
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	free_pathspec(&opt.pathspec);
 }
=20
 static void check_notes_merge_worktree(struct notes_merge_options *o)
diff --git a/revision.c b/revision.c
index e257614..c0ced84 100644
--- a/revision.c
+++ b/revision.c
@@ -1886,12 +1886,13 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
 		revs->limited =3D 1;
=20
 	if (revs->prune_data.nr) {
-		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
+		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
 		if (!revs->full_diff)
-			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
+			copy_pathspec(&revs->diffopt.pathspec,
+				      &revs->prune_data);
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
diff --git a/tree-diff.c b/tree-diff.c
index 5a87614..f4c92f6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -229,11 +229,11 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
=20
 	/* Go through the new set of filepairing, and see if we find a more i=
nteresting one */
 	opt->found_follow =3D 0;
@@ -252,9 +252,9 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
-			diff_tree_release_paths(opt);
+			free_pathspec(&opt->pathspec);
 			opt->pathspec.raw[0] =3D xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->pathspec.raw, opt);
+			init_pathspec(&opt->pathspec, opt->pathspec.raw);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
@@ -328,13 +328,3 @@ int diff_root_tree_sha1(const unsigned char *new, =
const char *base, struct diff_
 	free(tree);
 	return retval;
 }
-
-void diff_tree_release_paths(struct diff_options *opt)
-{
-	free_pathspec(&opt->pathspec);
-}
-
-void diff_tree_setup_paths(const char **p, struct diff_options *opt)
-{
-	init_pathspec(&opt->pathspec, p);
-}
--=20
1.8.0.rc0.19.g7bbb31d
