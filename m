From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/45] Remove diff_tree_{setup,release}_paths
Date: Sun,  9 Jun 2013 13:26:08 +0700
Message-ID: <1370759178-1709-36-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ7G-0001Ys-8P
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab3FIG2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:34 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59796 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3FIG2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:33 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so3485550pbb.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vys9HgZALs+L8UA9IvgL4+4wPQ1O2o+YwPEE9KZqKbs=;
        b=kdpLe69H37XM8ETX7bZIUjrj423Pvy7JfOkW06Ezk//+1/kC+AYkpkyTdWoWx/qoGr
         5iQUECaS7iEwsP94OMKsX7HJlhaz3vF9Uv5LLaWl3ct75rG3+Hhdqf/RDC+qrQc96CEb
         fCLTOpec7WSJE/OqxqeijBZEWgtIqX+VJ2zXFv9UWHktIfxP5Pg+2TdQFKrAGlx00rDn
         O0rao88YFqkv6SUqcJaSey1Dn+Xoayy+lHE65lr1bxqsn4xxefkhK1zVJb4WOycOWpTb
         3wTZBPYT10vY4Gg/kqB0DAJ6axD6igNFFo2jGCtOlsOBFI7O1JTaYqB2S0Ff1hArElaV
         WJ8Q==
X-Received: by 10.68.135.231 with SMTP id pv7mr5070973pbb.108.1370759313064;
        Sat, 08 Jun 2013 23:28:33 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id l4sm5562613pbo.6.2013.06.08.23.28.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226927>


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
index 079dcd3..5bd721d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -408,7 +408,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 	paths[0] =3D origin->path;
 	paths[1] =3D NULL;
=20
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -458,7 +458,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -494,7 +494,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow =3D origin->path;
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_sha1(origin->commit->object.sha1))
@@ -516,7 +516,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
+	free_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
=20
@@ -1079,7 +1079,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
=20
 	paths[0] =3D NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
+	init_pathspec(&diff_opts.pathspec, paths);
 	diff_setup_done(&diff_opts);
=20
 	/* Try "find copies harder" on new path if requested;
@@ -1162,7 +1162,7 @@ static int find_copy_in_parent(struct scoreboard =
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
index 1c8e4a5..b665218 100644
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
index f9185d4..1f98bd7 100644
--- a/revision.c
+++ b/revision.c
@@ -1905,12 +1905,13 @@ int setup_revisions(int argc, const char **argv=
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
1.8.2.83.gc99314b
