From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] commit: remove global variable head_sha1[]
Date: Fri, 19 Aug 2011 11:57:43 -0700
Message-ID: <7vfwkx2pqw.fsf@alter.siamese.dyndns.org>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuUGP-0007lH-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab1HSS5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 14:57:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab1HSS5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 14:57:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5B846FD;
	Fri, 19 Aug 2011 14:57:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AD5c/giV4Wtj
	nadtgIg87olWJCE=; b=efG2hA6bG9QWTPdMdMr9yFDhVvo3QNNUEbLzog06BWi5
	8f9F6xgabTosUO2pyhvw0si+E5zg5CZ2SuZ7D+sVfxWU3zYuUcD8rFuQf+WcncDu
	WWCsZ45vBZ/um48Zb5WveFPIs/mB8390bqPJcggYVTTC1LPrjRZ2FaLWnxAeJcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DR1nip
	ED5anhCWNWkIX6F0UQXvUXtR9gPtjrvmauIXTKy3qMhlQp2RdtOrIe3F1TW2a3IQ
	BfiEvoXRpZKDCouzmupJ8U/AZA/oQr1ACnMZKYQLG2Ri3/eXYQiahSd5V+ILmNi2
	VdDLFmjmyEvHElDTc27BBKz2cFxxOxSLA5itE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33F2146FC;
	Fri, 19 Aug 2011 14:57:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34B8946FA; Fri, 19 Aug 2011
 14:57:45 -0400 (EDT)
In-Reply-To: <1313765407-29925-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 19 Aug
 2011 21:50:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB8EB7C-CA95-11E0-8161-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179719>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Thanks for a re-roll.

> @@ -1383,11 +1376,13 @@ int cmd_commit(int argc, const char **argv, c=
onst char *prefix)
>  	const char *index_file, *reflog_msg;
>  	char *nl, *p;
>  	unsigned char commit_sha1[20];
> +	unsigned char head_sha1[20];
>  	struct ref_lock *ref_lock;
>  	struct commit_list *parents =3D NULL, **pptr =3D &parents;
>  	struct stat statbuf;
>  	int allow_fast_forward =3D 1;
>  	struct wt_status s;
> +	struct commit *head_commit;

head_sha1[] is not initialized to NULs; neither is head_commit to NULL.

	cmd_commit()
        -> if it is an initial_commit, neither head_sha1[] nor head_com=
mit
           is defined;
        -> prepare_to_commit()
           -> is_a_merge(head_commit) gets called to see if this is an
	      empty non-merge commit if --amend was passed.

Attempting to --amend an initial commit should be an error and
parse_and_validate_options() checks that condition so the above is not
possible, but it still feels wrong.

Also wouldn't these three be equivalents?

	head_commit =3D=3D NULL
        is_null_sha1(head_sha1)
        initial_commit

Perhaps like this instead?

-- >8 --
Subject: commit: reduce use of redundant global variables

The file-scope global variable head_sha1[] was used to hold the object
name of the current HEAD commit (unless we are about to make an initial
commit). Also there is an independent "static int initial_commit".

=46ix all the functions on the call-chain that use these two variables =
to
take a new "(const) struct commit *current_head" argument instead, and
replace their uses, e.g. "if (initial_commit)" becomes "if (!current_he=
ad)"
and a reference to "head_sha1" becomes "current_head->object.sha1".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |   87 ++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..1a65319 100644
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
@@ -102,7 +100,7 @@ static enum {
 static char *cleanup_arg;
=20
 static enum commit_whence whence;
-static int use_editor =3D 1, initial_commit, include_status =3D 1;
+static int use_editor =3D 1, include_status =3D 1;
 static int show_ignored_in_status;
 static const char *only_include_assumed;
 static struct strbuf message;
@@ -294,13 +292,13 @@ static void add_remove_files(struct string_list *=
list)
 	}
 }
=20
-static void create_base_index(void)
+static void create_base_index(const struct commit *current_head)
 {
 	struct tree *tree;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
=20
-	if (initial_commit) {
+	if (!current_head) {
 		discard_cache();
 		return;
 	}
@@ -313,7 +311,7 @@ static void create_base_index(void)
 	opts.dst_index =3D &the_index;
=20
 	opts.fn =3D oneway_merge;
-	tree =3D parse_tree_indirect(head_sha1);
+	tree =3D parse_tree_indirect(current_head->object.sha1);
 	if (!tree)
 		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
@@ -332,7 +330,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
=20
-static char *prepare_index(int argc, const char **argv, const char *pr=
efix, int is_status)
+static char *prepare_index(int argc, const char **argv, const char *pr=
efix,
+			   const struct commit *current_head, int is_status)
 {
 	int fd;
 	struct string_list partial;
@@ -448,7 +447,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
-	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, path=
spec))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec))
 		exit(1);
=20
 	discard_cache();
@@ -467,7 +466,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 						(uintmax_t) getpid()),
 				       LOCK_DIE_ON_ERROR);
=20
-	create_base_index();
+	create_base_index(current_head);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
=20
@@ -516,12 +515,9 @@ static int run_status(FILE *fp, const char *index_=
file, const char *prefix, int
 	return s->commitable;
 }
=20
-static int is_a_merge(const unsigned char *sha1)
+static int is_a_merge(const struct commit *current_head)
 {
-	struct commit *commit =3D lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		die(_("could not parse HEAD commit"));
-	return !!(commit->parents && commit->parents->next);
+	return !!(current_head->parents && current_head->parents->next);
 }
=20
 static const char sign_off_header[] =3D "Signed-off-by: ";
@@ -625,6 +621,7 @@ static char *cut_ident_timestamp_part(char *string)
 }
=20
 static int prepare_to_commit(const char *index_file, const char *prefi=
x,
+			     struct commit *current_head,
 			     struct wt_status *s,
 			     struct strbuf *author_ident)
 {
@@ -846,7 +843,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 * empty due to conflict resolution, which the user should okay.
 	 */
 	if (!commitable && whence !=3D FROM_MERGE && !allow_empty &&
-	    !(amend && is_a_merge(head_sha1))) {
+	    !(amend && is_a_merge(current_head))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
@@ -1004,6 +1001,7 @@ static const char *read_commit_message(const char=
 *name)
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix,
+				      struct commit *current_head,
 				      struct wt_status *s)
 {
 	int f =3D 0;
@@ -1024,11 +1022,8 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
 	if (!use_editor)
 		setenv("GIT_EDITOR", ":", 1);
=20
-	if (get_sha1("HEAD", head_sha1))
-		initial_commit =3D 1;
-
 	/* Sanity check options */
-	if (amend && initial_commit)
+	if (amend && !current_head)
 		die(_("You have nothing to amend."));
 	if (amend && whence !=3D FROM_COMMIT)
 		die(_("You are in the middle of a %s -- cannot amend."), whence_s())=
;
@@ -1100,12 +1095,12 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
 }
=20
 static int dry_run_commit(int argc, const char **argv, const char *pre=
fix,
-			  struct wt_status *s)
+			  const struct commit *current_head, struct wt_status *s)
 {
 	int commitable;
 	const char *index_file;
=20
-	index_file =3D prepare_index(argc, argv, prefix, 1);
+	index_file =3D prepare_index(argc, argv, prefix, current_head, 1);
 	commitable =3D run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
=20
@@ -1258,7 +1253,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	return 0;
 }
=20
-static void print_summary(const char *prefix, const unsigned char *sha=
1)
+static void print_summary(const char *prefix, const unsigned char *sha=
1,
+			  int initial_commit)
 {
 	struct rev_info rev;
 	struct commit *commit;
@@ -1380,12 +1376,13 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 	struct strbuf author_ident =3D STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
-	unsigned char commit_sha1[20];
+	unsigned char sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents =3D NULL, **pptr =3D &parents;
 	struct stat statbuf;
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
+	struct commit *current_head =3D NULL;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1396,38 +1393,41 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
=20
 	if (s.use_color =3D=3D -1)
 		s.use_color =3D git_use_color_default;
+	if (get_sha1("HEAD", sha1))
+		current_head =3D NULL;
+	else {
+		current_head =3D lookup_commit(sha1);
+		if (!current_head || parse_commit(current_head))
+			die(_("could not parse HEAD commit"));
+	}
 	argc =3D parse_and_validate_options(argc, argv, builtin_commit_usage,
-					  prefix, &s);
+					  prefix, current_head, &s);
 	if (dry_run) {
 		if (diff_use_color_default =3D=3D -1)
 			diff_use_color_default =3D git_use_color_default;
-		return dry_run_commit(argc, argv, prefix, &s);
+		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	}
-	index_file =3D prepare_index(argc, argv, prefix, 0);
+	index_file =3D prepare_index(argc, argv, prefix, current_head, 0);
=20
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  =
*/
-	if (!prepare_to_commit(index_file, prefix, &s, &author_ident)) {
+	if (!prepare_to_commit(index_file, prefix,
+			       current_head, &s, &author_ident)) {
 		rollback_index_files();
 		return 1;
 	}
=20
 	/* Determine parents */
 	reflog_msg =3D getenv("GIT_REFLOG_ACTION");
-	if (initial_commit) {
+	if (!current_head) {
 		if (!reflog_msg)
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
-
-		for (c =3D commit->parents; c; c =3D c->next)
+		for (c =3D current_head->parents; c; c =3D c->next)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
 	} else if (whence =3D=3D FROM_MERGE) {
 		struct strbuf m =3D STRBUF_INIT;
@@ -1435,7 +1435,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (merge)";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(current_head, pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1461,7 +1461,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(current_head, pptr)->next;
 	}
=20
 	/* Finally, get the commit message */
@@ -1487,7 +1487,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1=
,
+	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
 			author_ident.buf)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
@@ -1495,7 +1495,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	strbuf_release(&author_ident);
=20
 	ref_lock =3D lock_any_ref_for_update("HEAD",
-					   initial_commit ? NULL : head_sha1,
+					   !current_head
+					   ? NULL
+					   : current_head->object.sha1,
 					   0);
=20
 	nl =3D strchr(sb.buf, '\n');
@@ -1510,7 +1512,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		rollback_index_files();
 		die(_("cannot lock HEAD ref"));
 	}
-	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0) {
+	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
 	}
@@ -1532,13 +1534,14 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 		struct notes_rewrite_cfg *cfg;
 		cfg =3D init_copy_notes_for_rewrite("amend");
 		if (cfg) {
-			copy_note_for_rewrite(cfg, head_sha1, commit_sha1);
+			/* we are amending, so current_head is not NULL */
+			copy_note_for_rewrite(cfg, current_head->object.sha1, sha1);
 			finish_copy_notes_for_rewrite(cfg);
 		}
-		run_rewrite_hook(head_sha1, commit_sha1);
+		run_rewrite_hook(current_head->object.sha1, sha1);
 	}
 	if (!quiet)
-		print_summary(prefix, commit_sha1);
+		print_summary(prefix, sha1, !current_head);
=20
 	return 0;
 }
