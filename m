From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] commit: remove global variable head_sha1[]
Date: Fri, 19 Aug 2011 21:50:04 +0700
Message-ID: <1313765407-29925-1-git-send-email-pclouds@gmail.com>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 16:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuQOu-0005gd-Ad
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 16:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab1HSOuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 10:50:18 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62750 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1HSOuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 10:50:16 -0400
Received: by pzk37 with SMTP id 37so4952089pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ST1lE9GpLs8tkiJ6T6TAKESzFtgvCRPkyIBCA2i8LPc=;
        b=BWpktmQ3S9GljToPNVl+kxvY1obqXRHXPYJL//SHSp7KBsGg6uPxQDLWy3s4aqsKt6
         /hAKseFjAYek//58qpAMJ/7Mek5TW151ulYkcINcd9ln84hOdSL+TcJWokXG4wmsf7Ip
         guq17N+Zl4KseRXg+CG6NgzQGLO54DqHBN5H0=
Received: by 10.142.134.8 with SMTP id h8mr462157wfd.421.1313765416361;
        Fri, 19 Aug 2011 07:50:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id l15sm1530965wfe.12.2011.08.19.07.50.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 07:50:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Aug 2011 21:50:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179704>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |   52 ++++++++++++++++++++++++++--------------------=
------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cb73857..c9c4ea5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -62,8 +62,6 @@ N_("The previous cherry-pick is now empty, possibly d=
ue to conflict resolution.\
 "\n"
 "Otherwise, please use 'git reset'\n");
=20
-static unsigned char head_sha1[20];
-
 static const char *use_message_buffer;
 static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
 static struct lock_file index_lock; /* real index */
@@ -296,7 +294,7 @@ static void add_remove_files(struct string_list *li=
st)
 	}
 }
=20
-static void create_base_index(void)
+static void create_base_index(const unsigned char *head_sha1)
 {
 	struct tree *tree;
 	struct unpack_trees_options opts;
@@ -334,7 +332,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
=20
-static char *prepare_index(int argc, const char **argv, const char *pr=
efix, int is_status)
+static char *prepare_index(int argc, const char **argv, const char *pr=
efix,
+			   const unsigned char *head_sha1, int is_status)
 {
 	int fd;
 	struct string_list partial;
@@ -469,7 +468,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 						(uintmax_t) getpid()),
 				       LOCK_DIE_ON_ERROR);
=20
-	create_base_index();
+	create_base_index(head_sha1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
=20
@@ -518,11 +517,8 @@ static int run_status(FILE *fp, const char *index_=
file, const char *prefix, int
 	return s->commitable;
 }
=20
-static int is_a_merge(const unsigned char *sha1)
+static int is_a_merge(struct commit *commit)
 {
-	struct commit *commit =3D lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		die(_("could not parse HEAD commit"));
 	return !!(commit->parents && commit->parents->next);
 }
=20
@@ -627,7 +623,7 @@ static char *cut_ident_timestamp_part(char *string)
 }
=20
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
-			     struct wt_status *s,
+			     struct commit *head_commit, struct wt_status *s,
 			     struct strbuf *author_ident)
 {
 	struct stat statbuf;
@@ -848,7 +844,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 * empty due to conflict resolution, which the user should okay.
 	 */
 	if (!commitable && whence !=3D FROM_MERGE && !allow_empty &&
-	    !(amend && is_a_merge(head_sha1))) {
+	    !(amend && is_a_merge(head_commit))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
@@ -1026,9 +1022,6 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	if (!use_editor)
 		setenv("GIT_EDITOR", ":", 1);
=20
-	if (get_sha1("HEAD", head_sha1))
-		initial_commit =3D 1;
-
 	/* Sanity check options */
 	if (amend && initial_commit)
 		die(_("You have nothing to amend."));
@@ -1102,12 +1095,12 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
 }
=20
 static int dry_run_commit(int argc, const char **argv, const char *pre=
fix,
-			  struct wt_status *s)
+			  const unsigned char *head_sha1, struct wt_status *s)
 {
 	int commitable;
 	const char *index_file;
=20
-	index_file =3D prepare_index(argc, argv, prefix, 1);
+	index_file =3D prepare_index(argc, argv, prefix, head_sha1, 1);
 	commitable =3D run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
=20
@@ -1383,11 +1376,13 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
+	unsigned char head_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents =3D NULL, **pptr =3D &parents;
 	struct stat statbuf;
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
+	struct commit *head_commit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1396,6 +1391,14 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
=20
+	if (get_sha1("HEAD", head_sha1))
+		initial_commit =3D 1;
+	else {
+		head_commit =3D lookup_commit(head_sha1);
+		if (!head_commit || parse_commit(head_commit))
+			die(_("could not parse HEAD commit"));
+	}
+
 	if (s.use_color =3D=3D -1)
 		s.use_color =3D git_use_color_default;
 	argc =3D parse_and_validate_options(argc, argv, builtin_commit_usage,
@@ -1403,13 +1406,14 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 	if (dry_run) {
 		if (diff_use_color_default =3D=3D -1)
 			diff_use_color_default =3D git_use_color_default;
-		return dry_run_commit(argc, argv, prefix, &s);
+		return dry_run_commit(argc, argv, prefix, head_sha1, &s);
 	}
-	index_file =3D prepare_index(argc, argv, prefix, 0);
+	index_file =3D prepare_index(argc, argv, prefix, head_sha1, 0);
=20
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  =
*/
-	if (!prepare_to_commit(index_file, prefix, &s, &author_ident)) {
+	if (!prepare_to_commit(index_file, prefix, head_commit,
+			       &s, &author_ident)) {
 		rollback_index_files();
 		return 1;
 	}
@@ -1421,15 +1425,11 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 			reflog_msg =3D "commit (initial)";
 	} else if (amend) {
 		struct commit_list *c;
-		struct commit *commit;
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (amend)";
-		commit =3D lookup_commit(head_sha1);
-		if (!commit || parse_commit(commit))
-			die(_("could not parse HEAD commit"));
=20
-		for (c =3D commit->parents; c; c =3D c->next)
+		for (c =3D head_commit->parents; c; c =3D c->next)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
 	} else if (whence =3D=3D FROM_MERGE) {
 		struct strbuf m =3D STRBUF_INIT;
@@ -1437,7 +1437,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (merge)";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(head_commit, pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1463,7 +1463,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(head_commit, pptr)->next;
 	}
=20
 	/* Finally, get the commit message */
--=20
1.7.4.74.g639db
