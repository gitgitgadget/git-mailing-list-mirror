From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 27/31] Remove diff_tree_{setup,release}_paths
Date: Sun, 13 Jan 2013 19:35:35 +0700
Message-ID: <1358080539-17436-28-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMqF-0008Ou-Mw
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab3AMMiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:51 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34528 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab3AMMiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:50 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so1691999pbc.14
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=So0RzZD6oZxqeOEtUmpt4msWN62rmWfPyS2ROPBY8u4=;
        b=jhmeFq+pe2vaE9S+tiw0MaQphhsWBS3EKxKu/OJdxIzNIY4D0CQcsbsHF5+x4G0fHi
         B4hgRgdU47uKwQC4sYcDjojfX29ZDXgBUCzssjdjlUj45mBnfobWajErPAo1m08W65Eo
         yE45Eo2D+anItyBvhk/2dBDBDwljtbmupdbqRDeZWphY4dFB7AARW2etZ2HMe62NmGbR
         ZeXBWYMpGp2NQ2rntr/8Aotu7jq94dEePDfVAEky2whfMDvV09H4I+fNIVOnBKaVQowv
         xgzhjikP+YbI0xlWXnwvfZWLNUfCy0VmqPMbNyRndzeOOIiu2mo0xGv1d+uoGS7wjOVz
         tZzg==
X-Received: by 10.66.79.97 with SMTP id i1mr41946702pax.47.1358080730491;
        Sun, 13 Jan 2013 04:38:50 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id pl10sm6287664pbc.60.2013.01.13.04.38.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:39:05 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213366>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 12 ++++++------
 builtin/reset.c |  4 ++--
 diff.h          |  2 --
 notes-merge.c   |  4 ++--
 revision.c      |  5 +++--
 tree-diff.c     | 18 ++++--------------
 6 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cfae569..5317d23 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -406,7 +406,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -456,7 +456,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -492,7 +492,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -514,7 +514,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
=20
@@ -1072,7 +1072,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
=20
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	/* Try "find copies harder" on new path if requested;
@@ -1155,7 +1155,7 @@ static int find_copy_in_parent(struct scoreboard =
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
index 915cc9f..0185bb0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -183,7 +183,7 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
 	struct diff_options opt;
=20
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt=
);
+	parse_pathspec(&opt.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
 	opt.format_callback_data =3D &index_was_discarded;
@@ -195,7 +195,7 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	diff_tree_release_paths(&opt);
+	free_pathspec(&opt.pathspec);
=20
 	if (!index_was_discarded)
 		/* The index is still clobbered from do_diff_cache() */
diff --git a/diff.h b/diff.h
index a47bae4..dd2a022 100644
--- a/diff.h
+++ b/diff.h
@@ -176,8 +176,6 @@ const char *diff_get_color(int diff_use_color, enum=
 color_diff ix);
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
index a044242..451b223 100644
--- a/revision.c
+++ b/revision.c
@@ -1885,12 +1885,13 @@ int setup_revisions(int argc, const char **argv=
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
index 68a9e7c..e63b787 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -230,11 +230,11 @@ static void try_to_follow_renames(struct tree_des=
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
@@ -253,9 +253,9 @@ static void try_to_follow_renames(struct tree_desc =
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
@@ -329,13 +329,3 @@ int diff_root_tree_sha1(const unsigned char *new, =
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
1.8.0.rc2.23.g1fb49df
