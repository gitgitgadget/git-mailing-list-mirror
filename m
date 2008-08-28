From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff*: fix worktree setup
Date: Thu, 28 Aug 2008 20:02:12 +0700
Message-ID: <1219928532-25087-1-git-send-email-pclouds@gmail.com>
References: <7vprnvuy5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, vmiklos@frugalware.org
X-From: git-owner@vger.kernel.org Thu Aug 28 15:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhA3-0002Rn-TY
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYH1NCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 09:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYH1NCf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:02:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:6322 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYH1NCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:02:33 -0400
Received: by yx-out-2324.google.com with SMTP id 8so200033yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mv7O1j3jYEjfkxJgt3Xmw6UVIK7PWmAzGqxMRKezTdI=;
        b=kUZGRaJYLDFrfHGFU8V8LcEEmddJ4A63Jm4QeT7PR6a34975Z/Ay5p4GIxDF4G3z19
         YINzkNzktc/7TkwpT3/hlslzjPZdtzqxvY92hxwIMMFFgYTNgvZS3Se7qGlNi8Fx4EHO
         cthS2jgZf319T/8FChLIdj8vWEIT+ag+Ob4LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i6/zM61NPl733Pc+MagBnpLToRxoa/Aks265CfjGNLV0LMcqHJaqOCwY1/mofC7QJg
         coFM8p7XP0tJhVqQikGiaf5qv+VZvt2ryxLKYAzeK07GE/7JRZCf2p2zxSv46EOnhrRE
         YxENhRmH0nv83V/5AVQ4MbECTjNKVihY0GN5Q=
Received: by 10.142.11.2 with SMTP id 2mr447870wfk.307.1219928552397;
        Thu, 28 Aug 2008 06:02:32 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 30sm1688058wfa.10.2008.08.28.06.02.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 06:02:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 28 Aug 2008 20:02:12 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <7vprnvuy5q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94046>

This fixes "git diff", "git diff-files" and "git diff-index" to work
correctly under worktree setup. Because diff* family works in many mode=
s
and not all of them require worktree, Junio made a nice summary
(with a little modification from me):

 * diff-files is about comparing with work tree, so it obviously needs =
a
  work tree;

 * diff-index also does, except "diff-index --cached" or "diff --cached=
 TREE"

 * no-index is about random files outside git context, so it obviously
  doesn't need any work tree;

 * comparing two (or more) trees doesn't;

 * comparing two blobs doesn't;

 * comparing a blob with a random file doesn't;

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-diff-index.c |    2 +
 builtin-diff.c       |    3 ++
 git.c                |    2 +-
 t/t1501-worktree.sh  |   59 ++++++++++++++++++++++++++++++++++++++++++=
++++++-
 4 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 17d851b..0483749 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -39,6 +39,8 @@ int cmd_diff_index(int argc, const char **argv, const=
 char *prefix)
 	if (rev.pending.nr !=3D 1 ||
 	    rev.max_count !=3D -1 || rev.min_age !=3D -1 || rev.max_age !=3D =
-1)
 		usage(diff_cache_usage);
+	if (!cached)
+		setup_work_tree();
 	if (read_cache() < 0) {
 		perror("read_cache");
 		return -1;
diff --git a/builtin-diff.c b/builtin-diff.c
index 7ffea97..037c303 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -122,6 +122,8 @@ static int builtin_diff_index(struct rev_info *revs=
,
 			usage(builtin_diff_usage);
 		argv++; argc--;
 	}
+	if (!cached)
+		setup_work_tree();
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
@@ -225,6 +227,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges =3D revs->dense_combined_merges =3D 1;
=20
+	setup_work_tree();
 	if (read_cache() < 0) {
 		perror("read_cache");
 		return -1;
diff --git a/git.c b/git.c
index 37b1d76..fdb0f71 100644
--- a/git.c
+++ b/git.c
@@ -286,7 +286,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files, RUN_SETUP },
+		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2ee88d8..e9e352c 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -28,6 +28,7 @@ test_rev_parse() {
 	[ $# -eq 0 ] && return
 }
=20
+EMPTY_TREE=3D$(git write-tree)
 mkdir -p work/sub/dir || exit 1
 mv .git repo.git || exit 1
=20
@@ -106,12 +107,66 @@ test_expect_success 'repo finds its work tree fro=
m work tree, too' '
 '
=20
 test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
-	cd repo.git/work/sub/dir &&
+	(cd repo.git/work/sub/dir &&
 	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
 		git diff --exit-code tracked &&
 	echo changed > tracked &&
 	! GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
-		git diff --exit-code tracked
+		git diff --exit-code tracked)
+'
+cat > diff-index-cached.expected <<\EOF
+:000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6=
434b8b29ae775ad8c2e48c5391 A	sub/dir/tracked
+EOF
+cat > diff-index.expected <<\EOF
+:000000 100644 0000000000000000000000000000000000000000 00000000000000=
00000000000000000000000000 A	sub/dir/tracked
+EOF
+
+
+test_expect_success 'git diff-index' '
+	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff-index $EMPT=
Y_TREE > result &&
+	cmp diff-index.expected result &&
+	GIT_DIR=3Drepo.git git diff-index --cached $EMPTY_TREE > result &&
+	cmp diff-index-cached.expected result
+'
+cat >diff-files.expected <<\EOF
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	sub/dir/tracked
+EOF
+
+test_expect_success 'git diff-files' '
+	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff-files > res=
ult &&
+	cmp diff-files.expected result
+'
+
+cat >diff-TREE.expected <<\EOF
+diff --git a/sub/dir/tracked b/sub/dir/tracked
+new file mode 100644
+index 0000000..5ea2ed4
+--- /dev/null
++++ b/sub/dir/tracked
+@@ -0,0 +1 @@
++changed
+EOF
+cat >diff-TREE-cached.expected <<\EOF
+diff --git a/sub/dir/tracked b/sub/dir/tracked
+new file mode 100644
+index 0000000..e69de29
+EOF
+cat >diff-FILES.expected <<\EOF
+diff --git a/sub/dir/tracked b/sub/dir/tracked
+index e69de29..5ea2ed4 100644
+--- a/sub/dir/tracked
++++ b/sub/dir/tracked
+@@ -0,0 +1 @@
++changed
+EOF
+
+test_expect_success 'git diff' '
+	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff $EMPTY_TREE=
 > result &&
+	cmp diff-TREE.expected result &&
+	GIT_DIR=3Drepo.git git diff --cached $EMPTY_TREE > result &&
+	cmp diff-TREE-cached.expected result &&
+	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff > result &&
+	cmp diff-FILES.expected result
 '
=20
 test_done
--=20
1.6.0.96.g2fad1.dirty
