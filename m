From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] t1501 (rev-parse): clarify
Date: Sat, 24 Jul 2010 06:16:35 -0500
Message-ID: <20100724111634.GA16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Occjh-0003CY-Kb
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab0GXLRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:17:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60964 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab0GXLRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:17:37 -0400
Received: by iwn7 with SMTP id 7so1092539iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OD9dwlaXvrTJfYaawyBWjAqmOLSB2dh15Hobe9bCivk=;
        b=Nmm2owJMcjmTHe2FJRDnI48wkYFBuF1Lg3pA+3k2us+i+9dCQIAJKQ+MeOjlqSSUsS
         NLCME4S/Wa8Jl7vr1e9tdWJ+XeBcj8fwZM3271xGvz1SS543Bem5Aa9UVQV/alVh9PBI
         pDwx6L7U9Lg56cTcaiLnNsXrBsy972356wCI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sdV0ezmWnfcCwwIToA1/7jtPIGlCcv2vlcGg/98lfJ+EQQyt/zOrs1xstnbay3YakS
         gr7hfRu6sQz/rpGX8CZ87C9MDtLRFFOkeLfGno+6DKvgNbf4DefDTX7+cZuggbLaPepW
         PRJwrZxcT2FEeAiy0cQhSDiX51F10RRuKaOSE=
Received: by 10.231.19.3 with SMTP id y3mr4290741iba.156.1279970257274;
        Sat, 24 Jul 2010 04:17:37 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1249315ibh.10.2010.07.24.04.17.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:17:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151612>

Tweak the style of these tests to make them easier to read.

 - Replace test_rev_parse() which produced multiple mini-tests with a
   simple function that can be used with the test body.

 - Combine multiple mini-tests into larger chunks that are easier
   to read.

 - Do not hard-code object IDs.  We may use a different hash some day.

 - Use test_cmp in preference to the test builtin.  The former
   produces useful output when tests are run with the "-v" option.

 - Guard all test code with test_expect_success.  This makes it much
   easier to visually scan through the test and find code of interest.

 - Use subshells to make the current directory easier to track.
   Outside of any subshell, the current directory is always
   $TEST_DIRECTORY now.

Also add a new test demonstrating a possible bug noticed in the
process of cleaning up:  =E2=80=9Cgit rev-parse --show-prefix=E2=80=9D =
leaves out
the trailing newline after an empty prefix when cwd is at the
toplevel of the work tree.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1501-worktree.sh |  467 +++++++++++++++++++++++++++++++++----------=
--------
 1 files changed, 302 insertions(+), 165 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bd8b607..2c8f01f 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -3,183 +3,320 @@
 test_description=3D'test separate work tree'
 . ./test-lib.sh
=20
-test_rev_parse() {
-	name=3D$1
-	shift
-
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' =3D \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' =3D \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' =3D \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: prefix" \
-	"test '$1' =3D \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
-}
-
-EMPTY_TREE=3D$(git write-tree)
-mkdir -p work/sub/dir || exit 1
-mkdir -p work2 || exit 1
-mv .git repo.git || exit 1
-
-say "core.worktree =3D relative path"
-GIT_DIR=3Drepo.git
-GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
-export GIT_DIR GIT_CONFIG
-unset GIT_WORK_TREE
-git config core.worktree ../work
-test_rev_parse 'outside'      false false false
-cd work || exit 1
-GIT_DIR=3D../repo.git
-GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
-GIT_DIR=3D../../../repo.git
-GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
-test_rev_parse 'subdirectory' false false true sub/dir/
-cd ../../.. || exit 1
-
-say "core.worktree =3D absolute path"
-GIT_DIR=3D$(pwd)/repo.git
-GIT_CONFIG=3D$GIT_DIR/config
-git config core.worktree "$(pwd)/work"
-test_rev_parse 'outside'      false false false
-cd work2
-test_rev_parse 'outside2'     false false false
-cd ../work || exit 1
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
-test_rev_parse 'subdirectory' false false true sub/dir/
-cd ../../.. || exit 1
-
-say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
-GIT_DIR=3D$(pwd)/repo.git
-GIT_CONFIG=3D$GIT_DIR/config
-git config core.worktree non-existent
-GIT_WORK_TREE=3Dwork
-export GIT_WORK_TREE
-test_rev_parse 'outside'      false false false
-cd work2
-test_rev_parse 'outside'      false false false
-cd ../work || exit 1
-GIT_WORK_TREE=3D.
-test_rev_parse 'inside'       false false true ''
-cd sub/dir || exit 1
-GIT_WORK_TREE=3D../..
-test_rev_parse 'subdirectory' false false true sub/dir/
-cd ../../.. || exit 1
-
-mv work repo.git/work
-mv work2 repo.git/work2
-
-say "GIT_WORK_TREE=3Dabsolute path, work tree below git dir"
-GIT_DIR=3D$(pwd)/repo.git
-GIT_CONFIG=3D$GIT_DIR/config
-GIT_WORK_TREE=3D$(pwd)/repo.git/work
-test_rev_parse 'outside'              false false false
-cd repo.git || exit 1
-test_rev_parse 'in repo.git'              false true  false
-cd objects || exit 1
-test_rev_parse 'in repo.git/objects'      false true  false
-cd ../work2 || exit 1
-test_rev_parse 'in repo.git/work2'      false true  false
-cd ../work || exit 1
-test_rev_parse 'in repo.git/work'         false true true ''
-cd sub/dir || exit 1
-test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
-cd ../../../.. || exit 1
-
-test_expect_success 'repo finds its work tree' '
-	(cd repo.git &&
-	 : > work/sub/dir/untracked &&
-	 test sub/dir/untracked =3D "$(git ls-files --others)")
-'
-
-test_expect_success 'repo finds its work tree from work tree, too' '
-	(cd repo.git/work/sub/dir &&
-	 : > tracked &&
-	 git --git-dir=3D../../.. add tracked &&
-	 cd ../../.. &&
-	 test sub/dir/tracked =3D "$(git ls-files)")
+test_expect_success 'setup' '
+	EMPTY_TREE=3D$(git write-tree) &&
+	EMPTY_BLOB=3D$(git hash-object -t blob --stdin </dev/null) &&
+	CHANGED_BLOB=3D$(echo changed | git hash-object -t blob --stdin) &&
+	ZEROES=3D0000000000000000000000000000000000000000 &&
+	EMPTY_BLOB7=3D$(echo $EMPTY_BLOB | sed "s/\(.......\).*/\1/") &&
+	CHANGED_BLOB7=3D$(echo $CHANGED_BLOB | sed "s/\(.......\).*/\1/") &&
+
+	mkdir -p work/sub/dir &&
+	mkdir -p work2 &&
+	mv .git repo.git
+'
+
+test_expect_success 'setup: helper for testing rev-parse' '
+	test_rev_parse() {
+		echo $1 >expected.bare &&
+		echo $2 >expected.inside-git &&
+		echo $3 >expected.inside-worktree &&
+		if test $# -ge 4
+		then
+			echo $4 >expected.prefix
+		fi &&
+
+		git rev-parse --is-bare-repository >actual.bare &&
+		git rev-parse --is-inside-git-dir >actual.inside-git &&
+		git rev-parse --is-inside-work-tree >actual.inside-worktree &&
+		if test $# -ge 4
+		then
+			git rev-parse --show-prefix >actual.prefix
+		fi &&
+
+		test_cmp expected.bare actual.bare &&
+		test_cmp expected.inside-git actual.inside-git &&
+		test_cmp expected.inside-worktree actual.inside-worktree &&
+		if test $# -ge 4
+		then
+			# rev-parse --show-prefix should output
+			# a single newline when at the top of the work tree,
+			# but we test for that separately.
+			test -z "$4" && ! test -s actual.prefix ||
+			test_cmp expected.prefix actual.prefix
+		fi
+	}
+'
+
+test_expect_success 'setup: core.worktree =3D relative path' '
+	unset GIT_WORK_TREE;
+	GIT_DIR=3Drepo.git &&
+	GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config &&
+	export GIT_DIR GIT_CONFIG &&
+	git config core.worktree ../work
+'
+
+test_expect_success 'outside' '
+	test_rev_parse false false false
+'
+
+test_expect_success 'inside work tree' '
+	(
+		cd work &&
+		GIT_DIR=3D../repo.git &&
+		GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config &&
+		test_rev_parse false false true ""
+	)
+'
+
+test_expect_failure 'empty prefix is actually written out' '
+	echo >expected &&
+	(
+		cd work &&
+		GIT_DIR=3D../repo.git &&
+		GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config &&
+		git rev-parse --show-prefix >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'subdir of work tree' '
+	(
+		cd work/sub/dir &&
+		GIT_DIR=3D../../../repo.git &&
+		GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config &&
+		test_rev_parse false false true sub/dir/
+	)
+'
+
+test_expect_success 'setup: core.worktree =3D absolute path' '
+	unset GIT_WORK_TREE;
+	GIT_DIR=3D$(pwd)/repo.git &&
+	GIT_CONFIG=3D$GIT_DIR/config &&
+	export GIT_DIR GIT_CONFIG &&
+	git config core.worktree "$(pwd)/work"
+'
+
+test_expect_success 'outside' '
+	test_rev_parse false false false &&
+	(
+		cd work2 &&
+		test_rev_parse false false false
+	)
+'
+
+test_expect_success 'inside work tree' '
+	(
+		cd work &&
+		test_rev_parse false false true ""
+	)
+'
+
+test_expect_success 'subdir of work tree' '
+	(
+		cd work/sub/dir &&
+		test_rev_parse false false true sub/dir/
+	)
+'
+
+test_expect_success 'setup: GIT_WORK_TREE=3Drelative (override core.wo=
rktree)' '
+	GIT_DIR=3D$(pwd)/repo.git &&
+	GIT_CONFIG=3D$GIT_DIR/config &&
+	git config core.worktree non-existent &&
+	GIT_WORK_TREE=3Dwork &&
+	export GIT_DIR GIT_CONFIG GIT_WORK_TREE
+'
+
+test_expect_success 'outside' '
+	test_rev_parse false false false &&
+	(
+		cd work2 &&
+		test_rev_parse false false false
+	)
+'
+
+test_expect_success 'inside work tree' '
+	(
+		cd work &&
+		GIT_WORK_TREE=3D. &&
+		test_rev_parse false false true ""
+	)
+'
+
+test_expect_success 'subdir of work tree' '
+	(
+		cd work/sub/dir &&
+		GIT_WORK_TREE=3D../.. &&
+		test_rev_parse false false true sub/dir/
+	)
+'
+
+test_expect_success 'setup: GIT_WORK_TREE=3Dabsolute, below git dir' '
+	mv work repo.git/work &&
+	mv work2 repo.git/work2 &&
+	GIT_DIR=3D$(pwd)/repo.git &&
+	GIT_CONFIG=3D$GIT_DIR/config &&
+	GIT_WORK_TREE=3D$(pwd)/repo.git/work &&
+	export GIT_DIR GIT_CONFIG GIT_WORK_TREE
+'
+
+test_expect_success 'outside' '
+	echo outside &&
+	test_rev_parse false false false
+'
+
+test_expect_success 'in repo.git' '
+	(
+		cd repo.git &&
+		test_rev_parse false true false
+	) &&
+	(
+		cd repo.git/objects &&
+		test_rev_parse false true false
+	) &&
+	(
+		cd repo.git/work2 &&
+		test_rev_parse false true false
+	)
+'
+
+test_expect_success 'inside work tree' '
+	(
+		cd repo.git/work &&
+		test_rev_parse false true true ""
+	)
+'
+
+test_expect_success 'subdir of work tree' '
+	(
+		cd repo.git/work/sub/dir &&
+		test_rev_parse false true true sub/dir/
+	)
+'
+
+test_expect_success 'find work tree from repo' '
+	echo sub/dir/untracked >expected &&
+	cat <<-\EOF >repo.git/work/.gitignore &&
+	expected.*
+	actual.*
+	.gitignore
+	EOF
+	>repo.git/work/sub/dir/untracked &&
+	(
+		cd repo.git &&
+		git ls-files --others --exclude-standard >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'find work tree from work tree' '
+	echo sub/dir/tracked >expected &&
+	>repo.git/work/sub/dir/tracked &&
+	(
+		cd repo.git/work/sub/dir &&
+		git --git-dir=3D../../.. add tracked
+	) &&
+	(
+		cd repo.git &&
+		git ls-files >../actual
+	) &&
+	test_cmp expected actual
 '
=20
 test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
-	(cd repo.git/work/sub/dir &&
-	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
+	(
+		cd repo.git/work/sub/dir &&
+		GIT_DIR=3D../../.. &&
+		GIT_WORK_TREE=3D../.. &&
+		GIT_PAGER=3D &&
+		export GIT_DIR GIT_WORK_TREE GIT_PAGER &&
+
 		git diff --exit-code tracked &&
-	echo changed > tracked &&
-	! GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
-		git diff --exit-code tracked)
+		echo changed >tracked &&
+		test_must_fail git diff --exit-code tracked
+	)
 '
-cat > diff-index-cached.expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6=
434b8b29ae775ad8c2e48c5391 A	sub/dir/tracked
-EOF
-cat > diff-index.expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 00000000000000=
00000000000000000000000000 A	sub/dir/tracked
-EOF
=20
+test_expect_success 'diff-index respects work tree under .git dir' '
+	cat >diff-index-cached.expected <<-EOF &&
+	:000000 100644 $ZEROES $EMPTY_BLOB A	sub/dir/tracked
+	EOF
+	cat >diff-index.expected <<-EOF &&
+	:000000 100644 $ZEROES $ZEROES A	sub/dir/tracked
+	EOF
=20
-test_expect_success 'git diff-index' '
-	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff-index $EMPT=
Y_TREE > result &&
-	test_cmp diff-index.expected result &&
-	GIT_DIR=3Drepo.git git diff-index --cached $EMPTY_TREE > result &&
-	test_cmp diff-index-cached.expected result
+	(
+		GIT_DIR=3Drepo.git &&
+		GIT_WORK_TREE=3Drepo.git/work &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git diff-index $EMPTY_TREE >diff-index.actual &&
+		git diff-index --cached $EMPTY_TREE >diff-index-cached.actual
+	) &&
+	test_cmp diff-index.expected diff-index.actual &&
+	test_cmp diff-index-cached.expected diff-index-cached.actual
 '
-cat >diff-files.expected <<\EOF
-:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	sub/dir/tracked
-EOF
=20
-test_expect_success 'git diff-files' '
-	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff-files > res=
ult &&
-	test_cmp diff-files.expected result
+test_expect_success 'diff-files respects work tree under .git dir' '
+	cat >diff-files.expected <<-EOF &&
+	:100644 100644 $EMPTY_BLOB $ZEROES M	sub/dir/tracked
+	EOF
+
+	(
+		GIT_DIR=3Drepo.git &&
+		GIT_WORK_TREE=3Drepo.git/work &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git diff-files >diff-files.actual
+	) &&
+	test_cmp diff-files.expected diff-files.actual
 '
=20
-cat >diff-TREE.expected <<\EOF
-diff --git a/sub/dir/tracked b/sub/dir/tracked
-new file mode 100644
-index 0000000..5ea2ed4
---- /dev/null
-+++ b/sub/dir/tracked
-@@ -0,0 +1 @@
-+changed
-EOF
-cat >diff-TREE-cached.expected <<\EOF
-diff --git a/sub/dir/tracked b/sub/dir/tracked
-new file mode 100644
-index 0000000..e69de29
-EOF
-cat >diff-FILES.expected <<\EOF
-diff --git a/sub/dir/tracked b/sub/dir/tracked
-index e69de29..5ea2ed4 100644
---- a/sub/dir/tracked
-+++ b/sub/dir/tracked
-@@ -0,0 +1 @@
-+changed
-EOF
+test_expect_success 'git diff respects work tree under .git dir' '
+	cat >diff-TREE.expected <<-EOF &&
+	diff --git a/sub/dir/tracked b/sub/dir/tracked
+	new file mode 100644
+	index 0000000..$CHANGED_BLOB7
+	--- /dev/null
+	+++ b/sub/dir/tracked
+	@@ -0,0 +1 @@
+	+changed
+	EOF
+	cat >diff-TREE-cached.expected <<-EOF &&
+	diff --git a/sub/dir/tracked b/sub/dir/tracked
+	new file mode 100644
+	index 0000000..$EMPTY_BLOB7
+	EOF
+	cat >diff-FILES.expected <<-EOF &&
+	diff --git a/sub/dir/tracked b/sub/dir/tracked
+	index $EMPTY_BLOB7..$CHANGED_BLOB7 100644
+	--- a/sub/dir/tracked
+	+++ b/sub/dir/tracked
+	@@ -0,0 +1 @@
+	+changed
+	EOF
=20
-test_expect_success 'git diff' '
-	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff $EMPTY_TREE=
 > result &&
-	test_cmp diff-TREE.expected result &&
-	GIT_DIR=3Drepo.git git diff --cached $EMPTY_TREE > result &&
-	test_cmp diff-TREE-cached.expected result &&
-	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work git diff > result &&
-	test_cmp diff-FILES.expected result
+	(
+		GIT_DIR=3Drepo.git &&
+		GIT_WORK_TREE=3Drepo.git/work &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git diff $EMPTY_TREE >diff-TREE.actual &&
+		git diff --cached $EMPTY_TREE >diff-TREE-cached.actual &&
+		git diff >diff-FILES.actual
+	) &&
+	test_cmp diff-TREE.expected diff-TREE.actual &&
+	test_cmp diff-TREE-cached.expected diff-TREE-cached.actual &&
+	test_cmp diff-FILES.expected diff-FILES.actual
 '
=20
 test_expect_success 'git grep' '
-	(cd repo.git/work/sub &&
-	GIT_DIR=3D../.. GIT_WORK_TREE=3D.. git grep -l changed | grep dir/tra=
cked)
+	echo dir/tracked >expected.grep &&
+	(
+		cd repo.git/work/sub &&
+		GIT_DIR=3D../.. &&
+		GIT_WORK_TREE=3D.. &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git grep -l changed >../../../actual.grep
+	) &&
+	test_cmp expected.grep actual.grep
 '
=20
 test_expect_success 'git commit' '
@@ -191,14 +328,14 @@ test_expect_success 'git commit' '
=20
 test_expect_success 'absolute pathspec should fail gracefully' '
 	(
-		cd repo.git || exit 1
-		git config --unset core.worktree
+		cd repo.git &&
+		test_might_fail git config --unset core.worktree &&
 		test_must_fail git log HEAD -- /home
 	)
 '
=20
 test_expect_success 'make_relative_path handles double slashes in GIT_=
DIR' '
-	: > dummy_file
+	>dummy_file
 	echo git --git-dir=3D"$(pwd)//repo.git" --work-tree=3D"$(pwd)" add du=
mmy_file &&
 	git --git-dir=3D"$(pwd)//repo.git" --work-tree=3D"$(pwd)" add dummy_f=
ile
 '
--=20
1.7.2.rc3
