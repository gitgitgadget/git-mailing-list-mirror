From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] clone: support sparse checkout with --sparse-checkout option
Date: Sun, 30 Nov 2008 17:54:35 +0700
Message-ID: <1228042478-1886-6-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
 <1228042478-1886-4-git-send-email-pclouds@gmail.com>
 <1228042478-1886-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyx-0005ev-Bo
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbYK3Kzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYK3Kzl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45771 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbYK3Kzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so952230wah.21
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WBSgNiCcXjPx0a5tOI4qUy+BKk+I7PJnwCcbVwRAUas=;
        b=aBRjOtjd3uo43qRyyY6Roa38A1IdjlEfe6Gxse8YIvggp2wttyWrgRX4c49oxYYDDP
         nKC2eUcEaJRCAfNfHzdgD/FxAXIsD4Nq2Isj6AhkoLxP83VlLgxLNcE27lE99CGzmoS3
         ANblgUUMb82Yh5opj/egM251rPKDxQUba75Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xpNK21u9pG+QT2QCzr8n3pYNTVMwx12kEeEtXw7T4kdusgnfxPXGpHsZ1vIGzcbD8A
         kMBNNS93viDuNg8Y6FsGjs4LW+YLaXsl7NRZ9mMmlbpn7JIYOh1qtACJEZz3ErfU/o0y
         CLPCyRb5Ql/CQXKbVoqX9XlnMHHaySsZjxd1E=
Received: by 10.114.125.18 with SMTP id x18mr5685597wac.220.1228042537581;
        Sun, 30 Nov 2008 02:55:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id q20sm3180355pog.21.2008.11.30.02.55.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:21 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101966>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |   10 +++++++++-
 builtin-clone.c             |   14 ++++++++++++++
 t/t5703-clone-narrow.sh     |   41 +++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100755 t/t5703-clone-narrow.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..acdced2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--] <repository> [<directory>]
+	  [--depth <depth>] [-S|--sparse-checkout=3D<sparse patterns>] [--]
+	  <repository> [<directory>]
=20
 DESCRIPTION
 -----------
@@ -99,6 +100,13 @@ then the cloned repository will become corrupt.
 -n::
 	No checkout of HEAD is performed after the clone is complete.
=20
+-S=3D<sparse patterns>::
+--sparse-checkout=3D<sparse patterns>::
+	Make a sparse checkout instead of a full one.
+	This option will not work with either --no-checkout or --bare.
+	Please refer to linkgit:git-checkout[1] for more detail on
+	sparse checkout and sparse patterns.
+
 --bare::
 	Make a 'bare' GIT repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin-clone.c b/builtin-clone.c
index 2feac9c..ea341a1 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,6 +36,7 @@ static const char * const builtin_clone_usage[] =3D {
 static int option_quiet, option_no_checkout, option_bare, option_mirro=
r;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_narrow_path;
 static char *option_origin =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbose;
@@ -45,6 +46,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSE(&option_verbose),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
+	OPT_STRING('S', "sparse-checkout", &option_narrow_path, "sparse patte=
rns",
+		   "only checkout certain files based on patterns"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
@@ -383,10 +386,15 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
+		if (option_narrow_path)
+			die("--bare and --sparse-checkout options are incompatible.");
 		option_no_checkout =3D 1;
 		use_separate_remote =3D 0;
 	}
=20
+	if (option_no_checkout && option_narrow_path)
+		die("--no-checkout and --sparse-checkout options are incompatible.")=
;
+
 	if (!option_origin)
 		option_origin =3D "origin";
=20
@@ -597,10 +605,16 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		opts.src_index =3D &the_index;
 		opts.dst_index =3D &the_index;
=20
+		if (option_narrow_path) {
+			opts.new_narrow_path =3D 1;
+			opts.narrow_spec =3D parse_narrow_spec(option_narrow_path, NULL);
+		}
+
 		tree =3D parse_tree_indirect(remote_head->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
 		unpack_trees(1, &t, &opts);
+		free_narrow_spec(opts.narrow_spec);
=20
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
diff --git a/t/t5703-clone-narrow.sh b/t/t5703-clone-narrow.sh
new file mode 100755
index 0000000..e34246d
--- /dev/null
+++ b/t/t5703-clone-narrow.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description=3D'narrow clone'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src
+		mkdir -p work/sub/dir
+		touch untracked tracked modified added
+		touch work/untracked work/tracked work/modified work/added
+		git add tracked work/tracked
+		git add modified work/modified
+		git commit -m initial
+	)
+
+'
+
+test_expect_success 'narrow clone incompatible with --bare' '
+	rm -fr dst &&
+	test_must_fail git clone --sparse-checkout=3Dwork/ --bare src dst
+'
+
+test_expect_success 'narrow clone incompatible with --no-checkout' '
+	rm -fr dst &&
+	test_must_fail git clone --sparse-checkout=3Dwork/ -n src dst
+'
+
+test_expect_success 'clone with --sparse-checkout' '
+	(
+	rm -fr dst &&
+	git clone --sparse-checkout=3Dwork/ src dst &&
+	cd dst &&
+	test -z "$(git ls-files --sparse | grep -v ^work/)"
+	)
+'
+
+test_done
--=20
1.6.0.3.890.g95457
