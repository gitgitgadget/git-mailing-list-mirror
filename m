From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/21] checkout: support checking out into a new working directory
Date: Sat, 14 Dec 2013 17:55:00 +0700
Message-ID: <1387018507-21999-15-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmpt-0001EJ-2E
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab3LNKwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:37 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59844 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:36 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so3482892pdi.19
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vbW8F5PkkeDqoZdceCs7I7E8LjtUAnqTudoRfm4/Ku8=;
        b=I7gmw8FDMluc7epcqUK8FVnTU0tfNl2CpEMhf/88r16iUy6SLXsdNLPtemRKdtHk5x
         ws5aHnl0kPa448I+WOkCWNJGWQykNDc49Y7bYhFHbyYqWbNf0LjFLP4oogkFKq3SYtOw
         tU0QzfWE2xqGOxtbr3/pAL+tXZgrGaOLS5suf7JymiNMgSn8DhaLZrg+CCJ9S2BuoN0L
         oJDJhev1Wx3kTyVzGvqgIlbq6+p73dp8uy+sOtB4ATEU2HaqCSTbe+8A5YoSYMI20ykt
         wMOOVVBfLCE+9YBsS4caubmhoT2+uBWLkbQsbox3GsDiCCK53JCsIVn6vJg2NXbM4mUQ
         qPAA==
X-Received: by 10.66.197.135 with SMTP id iu7mr8573458pac.149.1387018355594;
        Sat, 14 Dec 2013 02:52:35 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id qv8sm11414816pbc.31.2013.12.14.02.52.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:28 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239296>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt         |  6 +++
 Documentation/gitrepository-layout.txt |  3 +-
 builtin/checkout.c                     | 94 ++++++++++++++++++++++++++=
++++++++
 path.c                                 |  3 +-
 4 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 91294f8..06076c8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,6 +225,12 @@ This means that you can use `git checkout -p` to s=
electively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mo=
de.
=20
+--to=3D<path>::
+	Check out a new branch in a separate working directory at
+	`<path>`. A new repository is initialized at `<path>` that
+	shares everything with the current repository except working
+	directory specific files.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 7ce31d4..3c6149e 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -222,7 +222,8 @@ repos/<id>::
 	If a repository's .git is a file contains two lines `gitsuper:
 	<path>` and `repo: <id>`. The directory `<path>/repos/<id>`
 	contains the real non-shared part of .git directory of the
-	repository in question (e.g. HEAD or index).
+	repository in question (e.g. HEAD or index). Such .git files
+	are created by `git checkout --to`.
=20
 SEE ALSO
 --------
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 904fd71..95a1a61 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -48,6 +48,9 @@ struct checkout_opts {
 	const char *prefix;
 	struct pathspec pathspec;
 	struct tree *source_tree;
+
+	const char *new_worktree;
+	const char **saved_argv;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -250,6 +253,9 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same tim=
e."),
 		    opts->new_branch);
=20
+	if (opts->new_worktree)
+		die(_("'%s' cannot be used with updating paths"), "--to");
+
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
 					   &opts->pathspec);
@@ -808,6 +814,82 @@ static int switch_branches(const struct checkout_o=
pts *opts,
 	return ret || writeout_error;
 }
=20
+static void write_to_file(const char *path, const char *fmt, ...)
+{
+	va_list params;
+	FILE *fp =3D fopen(path, "w");
+	if (!fp)
+		die_errno(_("could not create file '%s'"), path);
+	va_start(params, fmt);
+	vfprintf(fp, fmt, params);
+	va_end(params);
+	fclose(fp);
+}
+
+static int checkout_new_worktree(const struct checkout_opts *opts,
+				 struct branch_info *new)
+{
+	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *path =3D opts->new_worktree;
+	struct stat st;
+	const char *name;
+	struct child_process cp;
+	int counter =3D 0, len;
+
+	if (!new->commit)
+		die(_("no branch specified"));
+
+	len =3D strlen(path);
+	if (!len || is_dir_sep(path[len - 1]))
+		die(_("'--to' argument '%s' cannot end with a slash"), path);
+
+	for (name =3D path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+	strbuf_addstr(&sb_repo, git_path("repos/%s", name));
+	len =3D sb_repo.len;
+	if (safe_create_leading_directories_const(sb_repo.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_repo.buf);
+	while (!stat(sb_repo.buf, &st)) {
+		counter++;
+		strbuf_setlen(&sb_repo, len);
+		strbuf_addf(&sb_repo, "%d", counter);
+	}
+	name =3D sb_repo.buf + len - strlen(name);
+	if (mkdir(sb_repo.buf, 0777))
+		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
+
+	strbuf_addf(&sb_git, "%s/.git", path);
+	if (safe_create_leading_directories_const(sb_git.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_git.buf);
+
+	write_to_file(sb_git.buf, "gitsuper: %s\ngitdir: %s\n",
+		      real_path(get_git_dir()), name);
+	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+	write_to_file(sb.buf, "%s\n", sha1_to_hex(new->commit->object.sha1));
+
+	if (!opts->quiet)
+		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+
+	/*
+	 * Rerun checkout in the new worktree. This way is safer than
+	 * set_git_dir() because a path relative to cwd could have
+	 * been cached somewhere undetected.
+	 */
+	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
+	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D opts->saved_argv;
+	return run_command(&cp);
+}
+
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
 {
 	if (!strcmp(var, "diff.ignoresubmodules")) {
@@ -1069,6 +1151,9 @@ static int checkout_branch(struct checkout_opts *=
opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
=20
+	if (opts->new_worktree)
+		return checkout_new_worktree(opts, new);
+
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
 		int flag;
@@ -1111,6 +1196,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
+		OPT_STRING(0, "to", &opts.new_worktree, N_("path"),
+			   N_("check a branch out in a separate working directory")),
 		OPT_END(),
 	};
=20
@@ -1119,6 +1206,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	opts.overwrite_ignore =3D 1;
 	opts.prefix =3D prefix;
=20
+	opts.saved_argv =3D xmalloc(sizeof(const char *) * (argc + 2));
+	memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
+
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
=20
@@ -1127,6 +1217,10 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
+	if (getenv("GIT_CHECKOUT_NEW_WORKTREE"))
+		/* recursive execution from checkout_new_worktree() */
+		opts.new_worktree =3D NULL;
+
 	if (conflict_style) {
 		opts.merge =3D 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/path.c b/path.c
index e51fc35..1a2478a 100644
--- a/path.c
+++ b/path.c
@@ -93,7 +93,8 @@ static void update_super_dir(char *buf, size_t n, int=
 git_dir_len)
 {
 	const char *super_dir_list[] =3D {
 		"branches", "hooks", "info", "logs", "modules",
-		"objects", "refs", "remotes", "rr-cache", "svn", NULL
+		"objects", "refs", "remotes", "repos", "rr-cache",
+		"svn", NULL
 	};
 	const char *super_top_file_list[] =3D {
 		"config", "packed-refs", "shallow", NULL
--=20
1.8.5.1.77.g42c48fa
