From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2 nd/init-gitdir] init, clone: support --separate-git-dir for .git file
Date: Sat, 19 Mar 2011 22:16:56 +0700
Message-ID: <1300547816-4768-2-git-send-email-pclouds@gmail.com>
References: <1300547816-4768-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xwI-0006pN-OJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab1CSPT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 11:19:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1CSPTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:19:25 -0400
Received: by iwn34 with SMTP id 34so4986771iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NdpbNfw4kR/0RlqGMX8NrJ5/bDq+rJzLgx/ci8ZfxAo=;
        b=rbOCO9tOJyN9zlkHQj7vlvLvCI1yeFxpHnREOvWBe8EKaKpEeF2c5F/mqGNQP1QIZS
         T0H6SDRkiQYmbRzWhzOJJlwJq1uPpVilUo21FjmyzfNwPSsbnvErq6V/HmYJtgE2Z5CY
         KEICVMw5uzeXKQCGZfhCRYz9OlRp3Ud+8JoGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m5uMMMItu8abFx7uC82dxJLiGE9mZfiOxHxvUuLAobDVpjfTbfDwIBI/TBWmDd+LK7
         m19I8vPrsgAysxaPvTmVjx5/7rHv17OPsV/1DomKejSTTXbqQqX2TFrcC+FuqUW7wqqG
         G02QaS4Pyqcu/EzgCPZqyG0KR05CNSmDeRJA4=
Received: by 10.43.65.7 with SMTP id xk7mr3595282icb.146.1300547964810;
        Sat, 19 Mar 2011 08:19:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id jv9sm2634393icb.1.2011.03.19.08.19.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 08:19:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 19 Mar 2011 22:17:07 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300547816-4768-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169439>

--separate-git-dir tells git to create git dir at the specified
location, instead of where it is supposed to be. A .git file that
points to that location will be put in place so that it appears normal
to repo discovery process.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  - rebased on top of master because it uses real_path().
  - implemented repo move if "git init --separate-git-dir" is run on
    an existing repo.
  - docs
  - tests

 Documentation/git-clone.txt |   10 ++++++
 Documentation/git-init.txt  |   17 +++++++++-
 builtin/clone.c             |    8 ++++-
 builtin/init-db.c           |   68 +++++++++++++++++++++++++++++++++++=
++++++--
 cache.h                     |    1 +
 t/t0001-init.sh             |   46 +++++++++++++++++++++++++++++
 t/t5601-clone.sh            |   13 ++++++++
 7 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8577480..86eb4c9 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
+	  [--separate-git-dir|-L <git dir>]
 	  [--depth <depth>] [--recursive|--recurse-submodules] [--] <reposito=
ry>
 	  [<directory>]
=20
@@ -176,6 +177,15 @@ objects from the source repository into a pack in =
the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
=20
+-L=3D<git dir>::
+--separate-git-dir=3D<git dir>::
+	Instead of placing the cloned repository where it is supposed
+	to be, place the cloned repository at the specified directory,
+	then make a filesytem-agnostic git symbolic link to there.
+	The result is git repository can be separated from working
+	tree.
+
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,URLS>> section below for more information on specifying
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 0a4a20e..58cd011 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,9 @@ git-init - Create an empty git repository or reinitiali=
ze an existing one
=20
 SYNOPSIS
 --------
-'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]=
 [--shared[=3D<permissions>]] [directory]
+'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]
+	  [--separate-git-dir|-L <git dir>]
+	  [--shared[=3D<permissions>]] [directory]
=20
=20
 DESCRIPTION
@@ -29,7 +31,8 @@ directory is used.
=20
 Running 'git init' in an existing repository is safe. It will not
 overwrite things that are already there. The primary reason for
-rerunning 'git init' is to pick up newly added templates.
+rerunning 'git init' is to pick up newly added templates (or to move
+the repository to another place if --separate-git-dir is given).
=20
 OPTIONS
 -------
@@ -51,6 +54,16 @@ current working directory.
 Specify the directory from which templates will be used.  (See the "TE=
MPLATE
 DIRECTORY" section below.)
=20
+-L=3D<git dir>::
+--separate-git-dir=3D<git dir>::
+
+Instead of initializing the repository where it is supposed to be,
+place a filesytem-agnostic git symbolic link there, pointing to the
+specified git path, and initialize a git repository at the path. The
+result is git repository can be separated from working tree. If this
+is reinitialization, the repository will be moved to the specified
+path.
+
 --shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
=20
 Specify that the git repository is to be shared amongst several users.=
  This
diff --git a/builtin/clone.c b/builtin/clone.c
index 404f589..097beca 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,6 +42,7 @@ static int option_local, option_no_hardlinks, option_=
shared, option_recursive;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
+static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
@@ -80,6 +81,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('L', "separate-git-dir", &real_git_dir, "gitdir",
+		   "separate git dir from working tree"),
=20
 	OPT_END()
 };
@@ -466,7 +469,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
-	set_git_dir(real_path(git_dir));
+
+	set_git_dir_init(git_dir, real_git_dir, 0);
+	if (real_git_dir)
+		git_dir =3D real_git_dir;
=20
 	if (0 <=3D option_verbosity)
 		printf("Cloning into %s%s...\n",
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8f5cfd7..8879399 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -21,6 +21,7 @@
 static int init_is_bare_repository =3D 0;
 static int init_shared_repository =3D -1;
 static const char *init_db_template_dir;
+static const char *git_link;
=20
 static void safe_create_dir(const char *dir, int share)
 {
@@ -311,11 +312,67 @@ static void create_object_directory(void)
 	free(path);
 }
=20
+int set_git_dir_init(const char *git_dir, const char *real_git_dir,
+		     int exist_ok)
+{
+	if (real_git_dir) {
+		struct stat st;
+
+		if (!exist_ok && !stat(git_dir, &st))
+			die("%s already exists", git_dir);
+
+		if (!exist_ok && !stat(real_git_dir, &st))
+			die("%s already exists", real_git_dir);
+
+		/*
+		 * make sure symlinks are resolved because we'll be
+		 * moving the target repo later on in separate_git_dir()
+		 */
+		git_link =3D xstrdup(real_path(git_dir));
+	}
+	else {
+		real_git_dir =3D real_path(git_dir);
+		git_link =3D NULL;
+	}
+	set_git_dir(real_path(real_git_dir));
+	return 0;
+}
+
+static void separate_git_dir(const char *git_dir)
+{
+	struct stat st;
+	FILE *fp;
+
+	if (!stat(git_link, &st)) {
+		const char *src;
+
+		if (S_ISREG(st.st_mode))
+			src =3D read_gitfile_gently(git_link);
+		else if (S_ISDIR(st.st_mode))
+			src =3D git_link;
+		else
+			die("unable to handle file type %d", st.st_mode);
+
+		if (rename(src, git_dir))
+			die_errno("unable to move %s to %s", src, git_dir);
+	}
+
+	fp =3D fopen(git_link, "w");
+	if (!fp)
+		die("Could not create git link %s", git_link);
+	fprintf(fp, "gitdir: %s\n", git_dir);
+	fclose(fp);
+}
+
 int init_db(const char *template_dir, unsigned int flags)
 {
 	int reinit;
+	const char *git_dir =3D get_git_dir();
=20
-	safe_create_dir(get_git_dir(), 0);
+	if (git_link)
+		separate_git_dir(git_dir);
+
+	safe_create_dir(git_dir, 0);
=20
 	init_is_bare_repository =3D is_bare_repository();
=20
@@ -352,7 +409,6 @@ int init_db(const char *template_dir, unsigned int =
flags)
 	}
=20
 	if (!(flags & INIT_DB_QUIET)) {
-		const char *git_dir =3D get_git_dir();
 		int len =3D strlen(git_dir);
 		printf("%s%s Git repository in %s%s\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
@@ -414,6 +470,7 @@ static const char *const init_db_usage[] =3D {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *real_git_dir =3D NULL;
 	const char *work_tree;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
@@ -427,11 +484,16 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 			"specify that the git repository is to be shared amongst several us=
ers",
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
 		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
+		OPT_STRING('L', "separate-git-dir", &real_git_dir, "gitdir",
+			   "separate git dir from working tree"),
 		OPT_END()
 	};
=20
 	argc =3D parse_options(argc, argv, prefix, init_db_options, init_db_u=
sage, 0);
=20
+	if (real_git_dir && !is_absolute_path(real_git_dir))
+		real_git_dir =3D xstrdup(real_path(real_git_dir));
+
 	if (argc =3D=3D 1) {
 		int mkdir_tried =3D 0;
 	retry:
@@ -522,7 +584,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 			set_git_work_tree(real_path(work_tree));
 	}
=20
-	set_git_dir(real_path(git_dir));
+	set_git_dir_init(git_dir, real_git_dir, 1);
=20
 	return init_db(template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index a99fd56..0b99487 100644
--- a/cache.h
+++ b/cache.h
@@ -436,6 +436,7 @@ extern void verify_non_filename(const char *prefix,=
 const char *name);
=20
 #define INIT_DB_QUIET 0x0001
=20
+extern int set_git_dir_init(const char *git_dir, const char *real_git_=
dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f684993..b2e6919 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -374,4 +374,50 @@ test_expect_success 'init prefers command line to =
GIT_DIR' '
 	! test -d otherdir/refs
 '
=20
+test_expect_success 'init with separate gitdir' '
+	rm -rf newdir &&
+	git init --separate-git-dir realgitdir newdir &&
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git &&
+	test -d realgitdir/refs
+'
+
+test_expect_success 're-init to update git link' '
+	(
+	cd newdir &&
+	git init --separate-git-dir ../surrealgitdir
+	) &&
+	echo "gitdir: `pwd`/surrealgitdir" >expected &&
+	test_cmp expected newdir/.git &&
+	test -d surrealgitdir/refs &&
+	! test -d realgitdir/refs
+'
+
+test_expect_success 're-init to move gitdir' '
+	rm -rf newdir realgitdir surrealgitdir &&
+	git init newdir &&
+	(
+	cd newdir &&
+	git init --separate-git-dir ../realgitdir
+	) &&
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git &&
+	test -d realgitdir/refs
+'
+
+test_expect_success 're-init to move gitdir symlink' '
+	rm -rf newdir realgitdir &&
+	git init newdir &&
+	(
+	cd newdir &&
+	mv .git here &&
+	ln -s here .git &&
+	git init -L ../realgitdir
+	) &&
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected newdir/.git &&
+	test -d realgitdir/refs &&
+	! test -d newdir/here
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..c467b67 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -192,4 +192,17 @@ test_expect_success 'do not respect url-encoding o=
f non-url path' '
 	git clone x+y xy-regular
 '
=20
+test_expect_success 'clone separate gitdir' '
+	rm -rf dst &&
+	git clone --separate-git-dir realgitdir src dst &&
+	echo "gitdir: `pwd`/realgitdir" >expected &&
+	test_cmp expected dst/.git &&
+	test -d realgitdir/refs
+'
+
+test_expect_success 'clone separate gitdir where target already exists=
' '
+	rm -rf dst &&
+	test_must_fail git clone --separate-git-dir realgitdir src dst
+'
+
 test_done
--=20
1.7.4.74.g639db
