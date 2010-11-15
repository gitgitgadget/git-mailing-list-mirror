From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] clean: support cleaning sparse checkout with -S
Date: Mon, 15 Nov 2010 17:36:50 +0700
Message-ID: <1289817410-32470-11-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwV1-00032l-DV
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0KOKku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:40:50 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45300 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab0KOKks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:40:48 -0500
Received: by pva4 with SMTP id 4so923074pva.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=d6jE+uyozJDpa7xDcxA0Yern7psE89yBHOzarizPp9U=;
        b=TqO/nem/rBSmf2vGe1BBlqdkgZ11IEGTn3b8o5C0sRL4PIbXcX+b12XPt3wLMbAQgc
         mjEVJZT1gm6UZmAebGsKul2lGgEC3HUmnZr55859gV6z7CH/FueL2nibYSFB4kEIWXQz
         /BTFaHhWqXFgRulYKTgs2utxc2L/ANmf8qyFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oj0kROk6STcy+4oqnWj2A4+4r4wwdUyKda08E+W/RKG3T4MR6UEO4VdlkQDuP1AJx6
         n1SmZCl67ip2UAmR+Pbqvs9P1lGIlOOaLGddXGWwb2A3Zr5vzGDPblaWkXLJ/Kr3Y759
         EUqayelcelfUQwrqX3dmuLh/tQuh2dMPC9cz8=
Received: by 10.142.242.21 with SMTP id p21mr4786394wfh.183.1289817648097;
        Mon, 15 Nov 2010 02:40:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id y42sm8581255wfd.22.2010.11.15.02.40.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:40:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:39:30 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161487>

Those files that are managed by git, but out of working directory due
to sparse-checkout file are subjected to be cleaned by "-S". Files
that match the index exactly will be cleaned without "-f". Otherwise
'-f' is needed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clean.txt |    6 ++-
 builtin/clean.c             |   70 ++++++++++++++++++++++++++++++++
 t/t7301-clean-sparse.sh     |   92 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 167 insertions(+), 1 deletions(-)
 create mode 100755 t/t7301-clean-sparse.sh

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 60e38e6..e0c95b1 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tre=
e
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>..=
=2E
+'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X | -S] [--] <pa=
th>...
=20
 DESCRIPTION
 -----------
@@ -61,6 +61,10 @@ OPTIONS
 	Remove only files ignored by git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
=20
+-S::
+	Remove files tracked by git but are outside of sparse checkout.
+	Files that match the index exactly will be removed even when
+	'-f' is not given and clean.requireForce is no.
=20
 Author
 ------
diff --git a/builtin/clean.c b/builtin/clean.c
index c8798f5..5827993 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -34,11 +34,71 @@ static int exclude_cb(const struct option *opt, con=
st char *arg, int unset)
 	return 0;
 }
=20
+static int clean_sparse_checkout(const char *prefix, const char **path=
spec,
+				 int show_only, int quiet, int force)
+{
+	struct stat st;
+	int i, errors =3D 0;
+	unsigned char sha1[20];
+	const char *qname;
+	struct strbuf buf =3D STRBUF_INIT;
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+	for (i =3D 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce =3D the_index.cache[i];
+
+		if (!ce_skip_worktree(ce))
+			continue;
+		if (pathspec && !match_pathspec(pathspec, ce->name, ce_namelen(ce), =
0, NULL))
+			continue;
+
+		if (stat(ce->name, &st) < 0)
+			continue;
+		qname =3D quote_path_relative(ce->name, ce_namelen(ce), &buf, prefix=
);
+		if (index_path(sha1, ce->name, &st, 0) < 0) {
+			warning("failed to hash %s", qname);
+			errors++;
+			continue;
+		}
+		if (!hashcmp(sha1, ce->sha1)) {
+			if (show_only) {
+				printf("Would remove %s\n", qname);
+				continue;
+			}
+			if (!quiet)
+				printf("Removing %s\n", qname);
+			if (unlink(ce->name) !=3D 0) {
+				warning("failed to remove %s", qname);
+				errors++;
+			}
+			continue;
+		}
+		if (force) {
+			if (show_only) {
+				printf("Would remove %s\n", qname);
+				continue;
+			}
+			if (!quiet)
+				printf("Removing %s\n", qname);
+			if (unlink(ce->name) !=3D 0) {
+				warning("failed to remove %s", qname);
+				errors++;
+			}
+			continue;
+		}
+		if (show_only)
+			printf("Would not remove %s\n", qname);
+	}
+	return errors !=3D 0;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int show_only =3D 0, remove_directories =3D 0, quiet =3D 0, ignored =3D=
 0;
 	int ignored_only =3D 0, baselen =3D 0, config_set =3D 0, errors =3D 0=
;
+	int sparse =3D 0;
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
@@ -55,6 +115,7 @@ int cmd_clean(int argc, const char **argv, const cha=
r *prefix)
 				"remove whole directories"),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
 		  "exclude <pattern>", PARSE_OPT_NONEG, exclude_cb },
+		OPT_BOOLEAN('S', NULL, &sparse, "remove tracked files outside sparse=
 checkout"),
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),
@@ -70,6 +131,15 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_clean_usa=
ge,
 			     0);
=20
+	if (sparse) {
+		if (ignored || ignored_only)
+			die("-S, -x and -X cannot be used together");
+		if (exclude_list.nr)
+			die("-S and -e cannot be used together (yet)");
+		pathspec =3D get_pathspec(prefix, argv);
+		return clean_sparse_checkout(prefix, pathspec, show_only, quiet, for=
ce);
+	}
+
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.flags |=3D DIR_SHOW_IGNORED;
diff --git a/t/t7301-clean-sparse.sh b/t/t7301-clean-sparse.sh
new file mode 100755
index 0000000..3ac0b0a
--- /dev/null
+++ b/t/t7301-clean-sparse.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description=3D'git clean -S basic tests'
+
+. ./test-lib.sh
+
+git config clean.requireForce yes
+
+test_expect_success 'setup' '
+	mkdir src &&
+	touch file1 file2 &&
+	touch src/file1 src/file2 &&
+	git add . &&
+	git update-index --skip-worktree file1 src/file1
+'
+
+test_expect_success 'clean -x -S does not work' '
+	test_must_fail git clean -x -S &&
+	test_must_fail git clean -X -S
+'
+
+test_expect_success 'clean -n -S' '
+	cat >expected <<\EOF
+Would remove file1
+Would remove src/file1
+EOF
+	git clean -n -S >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'clean -n -S src' '
+	cat >expected <<\EOF
+Would remove src/file1
+EOF
+	git clean -n -S src >result &&
+	test_cmp expected result
+'
+
+test_expect_success '[src] clean -n -S .' '
+	(
+	cd src
+	cat >expected <<\EOF
+Would remove file1
+EOF
+	git clean -n -S . >result &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success '[src] clean -n -S ../file1' '
+	(
+	cd src
+	cat >expected <<\EOF
+Would remove ../file1
+EOF
+	git clean -n -S ../file1 >result &&
+	test_cmp expected result
+	)
+'
+
+test_expect_success 'clean -n -S with dirty worktree' '
+	echo dirty >file1 &&
+	cat >expected <<\EOF
+Would not remove file1
+Would remove src/file1
+EOF
+	git clean -n -S >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'clean -f -n -S with dirty worktree' '
+	echo dirty >file1 &&
+	cat >expected <<\EOF
+Would remove file1
+Would remove src/file1
+EOF
+	git clean -f -n -S >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'clean -S with dirty worktree' '
+	git clean -S &&
+	grep dirty file1 &&
+	test ! -f src/file1
+'
+
+test_expect_success 'clean -f -S with dirty worktree' '
+	git clean -f -S &&
+	test ! -f file1
+'
+
+test_done
--=20
1.7.3.2.210.g045198
