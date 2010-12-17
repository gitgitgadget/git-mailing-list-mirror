From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/21] struct rev_info: convert prune_data to struct pathspec
Date: Fri, 17 Dec 2010 19:43:06 +0700
Message-ID: <1292589787-9525-1-git-send-email-pclouds@gmail.com>
References: <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 13:44:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTZfW-0001wP-V0
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 13:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab0LQMoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 07:44:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0LQMoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 07:44:08 -0500
Received: by iyi12 with SMTP id 12so402464iyi.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HkcI5YW69g6XyiVvPRh74d2YIREibsxTw+M/E4bijaY=;
        b=OfBRvE3VaITPxyGrEu7NHlkBaTmqHzr1WKUmwR8S281Iba7iVuD0iHm14RAHxJ/y0c
         MRyQTOZEJt0hA5prL36uSo9IcuBN1pMp18P5QSmuLyeLvS0wr02fdKzESWlsfSaPGMdw
         V5n+tmm1LcRVMJ2ddgEWV7P3DnXbBa9fwUfy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GPXMJ3bBNQ+b+mSV1rI3rMfa0lCtFWLt381MyTWsYEYRAlysCR3NDon+jee5nsxoAy
         f/SGbwDhDQzAShaE4/p2zpXSzbg7uuy64Ec9oSNsrcX+gwDKD2JqPnpb+t2cDayvq0OH
         evvWwYis5awC6S1zo5VGNuG2+wE/sPo2f2XHM=
Received: by 10.42.228.133 with SMTP id je5mr791365icb.333.1292589846630;
        Fri, 17 Dec 2010 04:44:06 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id u5sm954221ics.18.2010.12.17.04.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 04:44:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Dec 2010 19:43:09 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163874>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 New patch. rev_info->pathspec is now struct pathspec.

 builtin/add.c         |    2 +-
 builtin/diff.c        |   12 ++++--------
 builtin/fast-export.c |    2 +-
 diff-lib.c            |    6 +++---
 revision.c            |   15 ++++++++-------
 revision.h            |    2 +-
 wt-status.c           |    4 ++--
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..3fc79a5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -86,7 +86,7 @@ int add_files_to_cache(const char *prefix, const char=
 **pathspec, int flags)
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data =3D pathspec;
+	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	data.flags =3D flags;
diff --git a/builtin/diff.c b/builtin/diff.c
index 76c42d8..4ebb1b6 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -371,14 +371,10 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
 		}
 		die("unhandled object '%s' given.", name);
 	}
-	if (rev.prune_data) {
-		const char **pathspec =3D rev.prune_data;
-		while (*pathspec) {
-			if (!path)
-				path =3D *pathspec;
-			paths++;
-			pathspec++;
-		}
+	if (rev.prune_data.nr) {
+		if (!path)
+			path =3D rev.prune_data.items[0].match;
+		paths +=3D rev.prune_data.nr;
 	}
=20
 	/*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c8fd46b..ba57457 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -651,7 +651,7 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
 	if (import_filename)
 		import_marks(import_filename);
=20
-	if (import_filename && revs.prune_data)
+	if (import_filename && revs.prune_data.nr)
 		full_tree =3D 1;
=20
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
diff --git a/diff-lib.c b/diff-lib.c
index 3b809f2..2251f3d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -106,7 +106,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
=20
-		if (!ce_path_match(ce, revs->prune_data))
+		if (!ce_path_match(ce, revs->prune_data.raw))
 			continue;
=20
 		if (ce_stage(ce)) {
@@ -427,7 +427,7 @@ static int oneway_diff(struct cache_entry **src, st=
ruct unpack_trees_options *o)
 	if (tree =3D=3D o->df_conflict_entry)
 		tree =3D NULL;
=20
-	if (ce_path_match(idx ? idx : tree, revs->prune_data))
+	if (ce_path_match(idx ? idx : tree, revs->prune_data.raw))
 		do_oneway_diff(o, idx, tree);
=20
 	return 0;
@@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	active_nr =3D dst - active_cache;
=20
 	init_revisions(&revs, NULL);
-	revs.prune_data =3D opt->pathspec.raw;
+	init_pathspec(&revs.prune_data, opt->pathspec.raw);
 	tree =3D parse_tree_indirect(tree_sha1);
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
diff --git a/revision.c b/revision.c
index b2a5867..515e2dd 100644
--- a/revision.c
+++ b/revision.c
@@ -323,7 +323,7 @@ static int rev_compare_tree(struct rev_info *revs, =
struct commit *parent, struct
 		 * tagged commit by specifying both --simplify-by-decoration
 		 * and pathspec.
 		 */
-		if (!revs->prune_data)
+		if (!revs->prune_data.nr)
 			return REV_TREE_SAME;
 	}
=20
@@ -969,7 +969,7 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, revs->prune_data)) {
+		if (ce_path_match(ce, revs->prune_data.raw)) {
 			prune_num++;
 			prune =3D xrealloc(prune, sizeof(*prune) * prune_num);
 			prune[prune_num-2] =3D ce->name;
@@ -979,7 +979,8 @@ static void prepare_show_merge(struct rev_info *rev=
s)
 		       ce_same_name(ce, active_cache[i+1]))
 			i++;
 	}
-	revs->prune_data =3D prune;
+	free_pathspec(&revs->prune_data);
+	init_pathspec(&revs->prune_data, prune);
 	revs->limited =3D 1;
 }
=20
@@ -1616,7 +1617,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	}
=20
 	if (prune_data)
-		revs->prune_data =3D get_pathspec(revs->prefix, prune_data);
+		init_pathspec(&revs->prune_data, get_pathspec(revs->prefix, prune_da=
ta));
=20
 	if (revs->def =3D=3D NULL)
 		revs->def =3D opt ? opt->def : NULL;
@@ -1647,13 +1648,13 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
 	if (revs->topo_order)
 		revs->limited =3D 1;
=20
-	if (revs->prune_data) {
-		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
+	if (revs->prune_data.nr) {
+		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
 		if (!revs->full_diff)
-			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
+			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
diff --git a/revision.h b/revision.h
index 05659c6..82509dd 100644
--- a/revision.h
+++ b/revision.h
@@ -34,7 +34,7 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
-	void *prune_data;
+	struct pathspec prune_data;
 	unsigned int early_output;
=20
 	/* Traversal flags */
diff --git a/wt-status.c b/wt-status.c
index 54b6b03..5c6b118 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -319,7 +319,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
     }
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	rev.prune_data =3D s->pathspec;
+	init_pathspec(&rev.prune_data, s->pathspec);
 	run_diff_files(&rev, 0);
 }
=20
@@ -344,7 +344,7 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	rev.diffopt.detect_rename =3D 1;
 	rev.diffopt.rename_limit =3D 200;
 	rev.diffopt.break_opt =3D 0;
-	rev.prune_data =3D s->pathspec;
+	init_pathspec(&rev.prune_data, s->pathspec);
 	run_diff_index(&rev, 1);
 }
=20
--=20
1.7.3.3.476.g10a82
