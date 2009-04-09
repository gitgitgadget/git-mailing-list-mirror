From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] archive: do not read .gitattributes in working directory
Date: Thu,  9 Apr 2009 17:01:30 +1000
Message-ID: <1239260490-6318-4-git-send-email-pclouds@gmail.com>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
 <1239260490-6318-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 09 09:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LroIe-0004of-Np
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 09:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbZDIHCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 03:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbZDIHCA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 03:02:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:63269 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbZDIHB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 03:01:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so490645rvb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kabXbuBWztqUu6v2A0aamrNQY/EY6SO3U70TCI9VbAY=;
        b=s8I9spQ5lKn+NzEGS0PP2sKzZiviFntcwy3Xu0Zm/jgkbPXOUR5uu36V5pChfRS2nK
         7P9rSk2rczKGHKRE78YqQcA/o5Pxzr6oQLQR5Agh353Sb/b+TWJ4o0qwmvuZzjmrWhby
         vm0h5LEmbTqkmBGAWws95CDv2xyMI8QVHy7Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lqkUQ6ov1o4pMCCpbf5suB+qlepuSBvF88jDKmE+tZFNiuw44/8sArY43c5Sojops9
         OMLIrbKPCLUzYN/3sk7ywhfbx0C6u/UjToLhj+2Xq4n4pusCmzsC0Uyn7jZcugJ9MbqW
         TbOkrKJxD2rzE91cRQocsRSoZIhRrAni4ttdo=
Received: by 10.143.8.10 with SMTP id l10mr767659wfi.175.1239260517661;
        Thu, 09 Apr 2009 00:01:57 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 30sm7790508wfg.34.2009.04.09.00.01.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 00:01:57 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Apr 2009 17:01:51 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239260490-6318-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116144>

The old behaviour still remains with --fix-attributes.
Also fix tests in t5000-tar-tree.sh to use --fix-attributes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  2009/4/9 Junio C Hamano <gitster@pobox.com>:
  > Hmmm, if you read_tree() into the_index upfront and do not change a=
nything
  > else to the archive.c code, shouldn't it work without such a regres=
sion at
  > all?  Am I missing something?
  >
  > It would allow you to export the index into an archive, but I doubt=
 it is
  > worth the amount of code churn.
  > Hmmm, if you read_tree() into the_index upfront and do not change a=
nything
  > else to the archive.c code, shouldn't it work without such a regres=
sion at
  > all?  Am I missing something?
  >
  > It would allow you to export the index into an archive, but I doubt=
 it is
  > worth the amount of code churn.
 =20
  I skipped the idea originally because of data duplication. But given
  the amount of code change in my approach, just loading index is bette=
r.
 =20
  2009/4/9 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
  > I don't like the need to prepare an index of all paths up front, bu=
t
  > that's just a gut feeling.  I haven't looked into implementing in-t=
ree
  > attribute support in attr.c; is it really that hard?  Other command=
s
  > would benefit from this, too, right (e.g. any command using attribu=
tes
  > in a bare repo)?
 =20
  You could try. At least with index, I only need a couple lines of
  modification in attr.c :) If it traverses directory upward for
  .gitattributes, then you may have problem. I'm not sure though.


 Documentation/git-archive.txt |    5 ++++-
 archive.c                     |   22 ++++++++++++++++++++++
 archive.h                     |    1 +
 builtin-tar-tree.c            |    5 +++++
 t/t5000-tar-tree.sh           |   28 ++++++++++++++++------------
 5 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 2e31142..f468523 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' [-f <fmt>|--format=3D<fmt>] [--list] [-p <prefix>/|--pre=
fix=3D<prefix>/] [<extra>]
-	      [--output=3D<file>]
+	      [--output=3D<file>] [--fix-attributes]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
=20
@@ -53,6 +53,9 @@ OPTIONS
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.
=20
+--fix-attributes::
+	Look for attributes in .gitattributes in working directory too.
+
 <extra>::
 	This can be any options that the archiver backend understands.
 	See next section.
diff --git a/archive.c b/archive.c
index e87fed7..c1c5c3c 100644
--- a/archive.c
+++ b/archive.c
@@ -4,6 +4,7 @@
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
=20
 static char const * const archive_usage[] =3D {
 	"git archive [options] <tree-ish> [path...]",
@@ -150,6 +151,8 @@ int write_archive_entries(struct archiver_args *arg=
s,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -168,6 +171,22 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
+	/*
+	 * Setup index and instruct attr to read index only
+	 */
+	if (!args->worktree_attributes) {
+		memset(&opts, 0, sizeof(opts));
+		opts.index_only =3D 1;
+		opts.head_idx =3D -1;
+		opts.src_index =3D &the_index;
+		opts.dst_index =3D &the_index;
+		opts.fn =3D oneway_merge;
+		init_tree_desc(&t, args->tree->buffer, args->tree->size);
+		if (unpack_trees(1, &t, &opts))
+			return -1;
+		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+	}
+
 	err =3D  read_tree_recursive(args->tree, args->base, args->baselen, 0=
,
 			args->pathspec, write_archive_entry, &context);
 	if (err =3D=3D READ_TREE_RECURSIVE)
@@ -258,6 +277,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	int verbose =3D 0;
 	int i;
 	int list =3D 0;
+	int worktree_attributes =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING('f', "format", &format, "fmt", "archive format"),
@@ -265,6 +285,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
+		OPT_BOOLEAN(0, "fix-attributes", &worktree_attributes, "read .gitatt=
ributes in working directory"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -324,6 +345,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	args->verbose =3D verbose;
 	args->base =3D base;
 	args->baselen =3D strlen(base);
+	args->worktree_attributes =3D worktree_attributes;
=20
 	return argc;
 }
diff --git a/archive.h b/archive.h
index 0b15b35..038ac35 100644
--- a/archive.h
+++ b/archive.h
@@ -10,6 +10,7 @@ struct archiver_args {
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
+	unsigned int worktree_attributes : 1;
 	int compression_level;
 };
=20
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 0713bca..69a93fc 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -36,6 +36,11 @@ int cmd_tar_tree(int argc, const char **argv, const =
char *prefix)
 		argv++;
 		argc--;
 	}
+	if (2 <=3D argc && !strcmp(argv[1], "--fix-attributes")) {
+		nargv[nargc++] =3D argv[1];
+		argv++;
+		argc--;
+	}
 	switch (argc) {
 	default:
 		usage(tar_tree_usage);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7641e0d..7ff600b 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -71,12 +71,16 @@ test_expect_success \
     'rm a/ignored'
=20
 test_expect_success \
-    'git archive' \
-    'git archive HEAD >b.tar'
+    'git archive without --fix-attributes' \
+    'git archive HEAD | tar t | grep -q ignored'
+
+test_expect_success \
+    'git archive --fix-attributes' \
+    'git archive --fix-attributes HEAD >b.tar'
=20
 test_expect_success \
     'git tar-tree' \
-    'git tar-tree HEAD >b2.tar'
+    'git tar-tree --fix-attributes HEAD >b2.tar'
=20
 test_expect_success \
     'git archive vs. git tar-tree' \
@@ -84,14 +88,14 @@ test_expect_success \
=20
 test_expect_success \
     'git archive in a bare repo' \
-    '(cd bare.git && git archive HEAD) >b3.tar'
+    '(cd bare.git && git archive --fix-attributes HEAD) >b3.tar'
=20
 test_expect_success \
     'git archive vs. the same in a bare repo' \
     'test_cmp b.tar b3.tar'
=20
 test_expect_success 'git archive with --output' \
-    'git archive --output=3Db4.tar HEAD &&
+    'git archive --fix-attributes --output=3Db4.tar HEAD &&
     test_cmp b.tar b4.tar'
=20
 test_expect_success \
@@ -122,7 +126,7 @@ test_expect_success \
=20
 test_expect_success \
     'git tar-tree with prefix' \
-    'git tar-tree HEAD prefix >c.tar'
+    'git tar-tree --fix-attributes HEAD prefix >c.tar'
=20
 test_expect_success \
     'extract tar archive with prefix' \
@@ -140,8 +144,8 @@ test_expect_success \
 test_expect_success \
     'create archives with substfiles' \
     'echo "substfile?" export-subst >a/.gitattributes &&
-     git archive HEAD >f.tar &&
-     git archive --prefix=3Dprefix/ HEAD >g.tar &&
+     git archive --fix-attributes HEAD >f.tar &&
+     git archive --fix-attributes --prefix=3Dprefix/ HEAD >g.tar &&
      rm a/.gitattributes'
=20
 test_expect_success \
@@ -170,18 +174,18 @@ test_expect_success \
=20
 test_expect_success \
     'git archive --format=3Dzip' \
-    'git archive --format=3Dzip HEAD >d.zip'
+    'git archive --fix-attributes --format=3Dzip HEAD >d.zip'
=20
 test_expect_success \
     'git archive --format=3Dzip in a bare repo' \
-    '(cd bare.git && git archive --format=3Dzip HEAD) >d1.zip'
+    '(cd bare.git && git archive --fix-attributes --format=3Dzip HEAD)=
 >d1.zip'
=20
 test_expect_success \
     'git archive --format=3Dzip vs. the same in a bare repo' \
     'test_cmp d.zip d1.zip'
=20
 test_expect_success 'git archive --format=3Dzip with --output' \
-    'git archive --format=3Dzip --output=3Dd2.zip HEAD &&
+    'git archive --fix-attributes --format=3Dzip --output=3Dd2.zip HEA=
D &&
     test_cmp d.zip d2.zip'
=20
 $UNZIP -v >/dev/null 2>&1
@@ -206,7 +210,7 @@ test_expect_success UNZIP \
=20
 test_expect_success \
     'git archive --format=3Dzip with prefix' \
-    'git archive --format=3Dzip --prefix=3Dprefix/ HEAD >e.zip'
+    'git archive --fix-attributes --format=3Dzip --prefix=3Dprefix/ HE=
AD >e.zip'
=20
 test_expect_success UNZIP \
     'extract ZIP archive with prefix' \
--=20
1.6.2.2.602.g83ee9f
