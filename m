From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] checkout: move more parameters to struct checkout_opts
Date: Wed, 29 Aug 2012 20:55:23 +0700
Message-ID: <1346248524-11616-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
 <1346248524-11616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:02:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6iqc-0007Hv-16
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 16:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab2H2OCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 10:02:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45785 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2H2OCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 10:02:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1274461pbb.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RooAat5NZCpxnMBlavMmFoKMt1JM9H7hBFW9fST2Bv0=;
        b=h1IAZg2bo+3SY0FOT7lJCe3Sa2EqWv8IeiPAbQZSYUv0k7zQHxGs3xnCLtriJkzsrE
         J9blUr6AsFQPcmkQWLwy88QqtUwRW1+qFf9gLnAdN9UjGbLXU55VXmDiyt4YJs2DR4c/
         m5mjYRBlcn0UWec1hTay3ARMO4UpvizK8mXK7iyz4lwwnB10IgVSUSxItYZ0sX8qSeov
         Uq9toH5edahxBoTDHweNdGVn8pQG12MFRtMhVXx/RKkmjHUr+9FrFo3u8LhclnTS4BFq
         HpKeW9Edb/yWdRAj9wedmEQaygR3qdarr+I+hXeaLg7MPFHAvUE3JvwYb9PEwrfked0Z
         Hk0g==
Received: by 10.68.134.228 with SMTP id pn4mr5014928pbb.147.1346248934455;
        Wed, 29 Aug 2012 07:02:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id pn4sm19399650pbb.50.2012.08.29.07.02.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2012 07:02:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 29 Aug 2012 20:55:47 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1346248524-11616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204479>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 68 ++++++++++++++++++++++++++++------------------=
--------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e3f086..78abaeb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -28,6 +28,7 @@ static const char * const checkout_usage[] =3D {
 };
=20
 struct checkout_opts {
+	int patch_mode;
 	int quiet;
 	int merge;
 	int force;
@@ -35,15 +36,17 @@ struct checkout_opts {
 	int writeout_stage;
 	int overwrite_ignore;
=20
-	/* not set by parse_options */
-	int branch_exists;
-
 	const char *new_branch;
 	const char *new_branch_force;
 	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+
+	int branch_exists;
+	const char *prefix;
+	const char **pathspec;
+	struct tree *source_tree;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -214,8 +217,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	return status;
 }
=20
-static int checkout_paths(struct tree *source_tree, const char **paths=
pec,
-			  const char *prefix, const struct checkout_opts *opts)
+static int checkout_paths(const struct checkout_opts *opts)
 {
 	int pos;
 	struct checkout state;
@@ -230,34 +232,34 @@ static int checkout_paths(struct tree *source_tre=
e, const char **pathspec,
 	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	newfd =3D hold_locked_index(lock_file, 1);
-	if (read_cache_preload(pathspec) < 0)
+	if (read_cache_preload(opts->pathspec) < 0)
 		return error(_("corrupt index file"));
=20
-	if (source_tree)
-		read_tree_some(source_tree, pathspec);
+	if (opts->source_tree)
+		read_tree_some(opts->source_tree, opts->pathspec);
=20
-	for (pos =3D 0; pathspec[pos]; pos++)
+	for (pos =3D 0; opts->pathspec[pos]; pos++)
 		;
 	ps_matched =3D xcalloc(1, pos);
=20
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (source_tree && !(ce->ce_flags & CE_UPDATE))
+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
+		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
 	}
=20
-	if (report_path_error(ps_matched, pathspec, prefix))
+	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
 		return 1;
=20
 	/* "checkout -m path" to recreate conflicted state */
 	if (opts->merge)
-		unmerge_cache(pathspec);
+		unmerge_cache(opts->pathspec);
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -282,9 +284,9 @@ static int checkout_paths(struct tree *source_tree,=
 const char **pathspec,
 	state.refresh_cache =3D 1;
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (source_tree && !(ce->ce_flags & CE_UPDATE))
+		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
 				continue;
@@ -706,7 +708,8 @@ static void orphaned_commit_warning(struct commit *=
old, struct commit *new)
 	free(refs.objects);
 }
=20
-static int switch_branches(const struct checkout_opts *opts, struct br=
anch_info *new)
+static int switch_branches(const struct checkout_opts *opts,
+			   struct branch_info *new)
 {
 	int ret =3D 0;
 	struct branch_info old;
@@ -760,8 +763,7 @@ static int git_checkout_config(const char *var, con=
st char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
=20
-static int interactive_checkout(const char *revision, const char **pat=
hspec,
-				struct checkout_opts *opts)
+static int interactive_checkout(const char *revision, const char **pat=
hspec)
 {
 	return run_add_interactive(revision, "--patch=3Dcheckout", pathspec);
 }
@@ -931,11 +933,8 @@ static int switch_unborn_to_new_branch(const struc=
t checkout_opts *opts)
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	unsigned char rev[20];
 	struct branch_info new;
-	struct tree *source_tree =3D NULL;
 	char *conflict_style =3D NULL;
-	int patch_mode =3D 0;
 	int dwim_new_local_branch =3D 1;
 	struct option options[] =3D {
 		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
@@ -957,7 +956,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN(0, "overwrite-ignore", &opts.overwrite_ignore, "update i=
gnored files (default)"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
-		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
+		OPT_BOOLEAN('p', "patch", &opts.patch_mode, "select hunks interactiv=
ely"),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
@@ -967,6 +966,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore =3D 1;
+	opts.prefix =3D prefix;
=20
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
@@ -984,7 +984,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	if (opts.new_branch_force)
 		opts.new_branch =3D opts.new_branch_force;
=20
-	if (patch_mode && (opts.track > 0 || opts.new_branch
+	if (opts.patch_mode && (opts.track > 0 || opts.new_branch
 			   || opts.new_branch_log || opts.merge || opts.force
 			   || opts.force_detach))
 		die (_("--patch is incompatible with all other options"));
@@ -1039,13 +1039,15 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
 	if (argc) {
+		unsigned char rev[20];
 		int dwim_ok =3D
-			!patch_mode &&
+			!opts.patch_mode &&
 			dwim_new_local_branch &&
 			opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
-				&new, &source_tree, rev, &opts.new_branch);
+					     &new, &opts.source_tree,
+					     rev, &opts.new_branch);
 		argv +=3D n;
 		argc -=3D n;
 	}
@@ -1054,13 +1056,13 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 		opts.track =3D git_branch_track;
=20
 	if (argc) {
-		const char **pathspec =3D get_pathspec(prefix, argv);
+		opts.pathspec =3D get_pathspec(prefix, argv);
=20
-		if (!pathspec)
+		if (!opts.pathspec)
 			die(_("invalid path specification"));
=20
-		if (patch_mode)
-			return interactive_checkout(new.name, pathspec, &opts);
+		if (opts.patch_mode)
+			return interactive_checkout(new.name, opts.pathspec);
=20
 		/* Checkout paths */
 		if (opts.new_branch) {
@@ -1077,11 +1079,11 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\nchecking out of the index."));
=20
-		return checkout_paths(source_tree, pathspec, prefix, &opts);
+		return checkout_paths(&opts);
 	}
=20
-	if (patch_mode)
-		return interactive_checkout(new.name, NULL, &opts);
+	if (opts.patch_mode)
+		return interactive_checkout(new.name, NULL);
=20
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
--=20
1.7.12.rc2.18.g61b472e
