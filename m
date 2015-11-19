From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 6/7] modernize t9300: mark here-doc words to ignore tab indentation
Date: Thu, 19 Nov 2015 20:09:48 +0100
Message-ID: <9d4bc5a63e49d7f04f5fa3b9aef8a0af916736a0.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:10:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbX-0007IV-2p
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbbKSTKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:31 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:7434 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161164AbbKSTK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:27 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDw2sGYz5tlM;
	Thu, 19 Nov 2015 20:10:24 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 0B4165365;
	Thu, 19 Nov 2015 20:10:24 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281487>

In the next commit, we will indent test case preparations. This will
require that here-documents ignore the tab indentation. Prepare for
this change by marking the here-doc words accordingly. This does not
have an effect now, but will remove some noise from the git diff -b
output of the next commit.

The change here is entirely automated with this perl command:

  perl -i -lpe 's/(cat.*<<) *((EOF|(EXPECT|INPUT)_END).*$)/$1-$2 &&/' t/t9300-fast-import.sh

i.e., inserts a dash between << and the EOF word (and removes blanks
that our style guide abhors) and appends the && that will become
necessary.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 200 ++++++++++++++++++++++++-------------------------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index adabd68..7586f41 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -57,7 +57,7 @@ test_expect_success 'empty stream succeeds' '
 	git fast-import </dev/null
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :2
 data <<EOF
@@ -107,7 +107,7 @@ test_expect_success 'A: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -118,7 +118,7 @@ test_expect_success 'A: verify commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 100644 blob file2
 100644 blob file3
 100755 blob file4
@@ -146,7 +146,7 @@ test_expect_success 'A: verify file4' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 object $(git rev-parse refs/heads/master)
 type commit
 tag series-A
@@ -158,7 +158,7 @@ test_expect_success 'A: verify tag/series-A' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 object $(git rev-parse refs/heads/master:file3)
 type blob
 tag series-A-blob
@@ -170,7 +170,7 @@ test_expect_success 'A: verify tag/series-A-blob' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :2 `git rev-parse --verify master:file2`
 :3 `git rev-parse --verify master:file3`
 :4 `git rev-parse --verify master:file4`
@@ -190,7 +190,7 @@ test_expect_success 'A: verify marks import' '
 
 test_tick
 new_blob=$(echo testing | git hash-object --stdin)
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 tag series-A-blob-2
 from $(git rev-parse refs/heads/master:file3)
 data <<EOF
@@ -217,7 +217,7 @@ Tag new_blob.
 EOF
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 object $(git rev-parse refs/heads/master:file3)
 type blob
 tag series-A-blob-2
@@ -238,7 +238,7 @@ test_expect_success 'A: tag blob by sha1' '
 '
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/verify--import-marks
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -258,7 +258,7 @@ test_expect_success 'A: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
 EOF
 git diff-tree -M -r master verify--import-marks >actual
@@ -274,7 +274,7 @@ mt=$(git hash-object --stdin < /dev/null)
 : >marks.exp
 : >tree.exp
 
-cat >input.commit <<EOF
+cat >input.commit <<-EOF &&
 commit refs/heads/verify--dump-marks
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -287,7 +287,7 @@ l=4
 m=6
 n=7
 while test "$i" -lt 27; do
-    cat >>input.blob <<EOF
+    cat >>input.blob <<-EOF &&
 blob
 mark :$l
 data 0
@@ -331,7 +331,7 @@ test_expect_success 'A: export marks with large values' '
 ###
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 mark :1
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -348,7 +348,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit TEMP_TAG
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -367,7 +367,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	test `git rev-parse master` = `git rev-parse TEMP_TAG^`
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/empty-committer-1
 committer  <> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -384,7 +384,7 @@ test_expect_success 'B: accept empty committer' '
 	test -z "$out"
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/empty-committer-2
 committer <a@b.com> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -401,7 +401,7 @@ test_expect_success 'B: accept and fixup committer with no name' '
 	test -z "$out"
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/invalid-committer
 committer Name email> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -413,7 +413,7 @@ test_expect_success 'B: fail on invalid committer (1)' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/invalid-committer
 committer Name <e<mail> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -425,7 +425,7 @@ test_expect_success 'B: fail on invalid committer (2)' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/invalid-committer
 committer Name <email>> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -437,7 +437,7 @@ test_expect_success 'B: fail on invalid committer (3)' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/invalid-committer
 committer Name <email $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -449,7 +449,7 @@ test_expect_success 'B: fail on invalid committer (4)' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/invalid-committer
 committer Name<email> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -468,7 +468,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 newf=`echo hi newf | git hash-object -w --stdin`
 oldf=`git rev-parse --verify master:file2`
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -495,7 +495,7 @@ test_expect_success 'C: validate reuse existing blob' '
 	test $oldf = `git rev-parse --verify branch:file2/oldf`
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 parent `git rev-parse --verify master^0`
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -507,7 +507,7 @@ test_expect_success 'C: verify commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
 :100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
 :100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
@@ -522,7 +522,7 @@ test_expect_success 'C: validate rename result' '
 ###
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -550,7 +550,7 @@ test_expect_success 'D: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :000000 100755 0000000000000000000000000000000000000000 e74b7d465e52746be2b4bae983670711e6e66657 A	newdir/exec.sh
 :000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
 EOF
@@ -575,7 +575,7 @@ test_expect_success 'D: verify file6' '
 ### series E
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
@@ -597,7 +597,7 @@ test_expect_success 'E: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
 
@@ -614,7 +614,7 @@ test_expect_success 'E: verify commit' '
 
 old_branch=`git rev-parse --verify branch^0`
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -637,7 +637,7 @@ test_expect_success 'F: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 tree `git rev-parse branch~1^{tree}`
 parent `git rev-parse branch~1`
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -656,7 +656,7 @@ test_expect_success 'F: verify other commit' '
 
 old_branch=`git rev-parse --verify branch^0`
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/branch
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -684,7 +684,7 @@ test_expect_success 'G: branch changed, but logged' '
 ###
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/H
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -713,7 +713,7 @@ test_expect_success 'H: verify pack' '
 	verify_packs
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
 :100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
 :100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
@@ -735,7 +735,7 @@ test_expect_success 'H: verify file' '
 ### series I
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/export-boundary
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -749,7 +749,7 @@ test_expect_success 'I: export-pack-edges' '
 	git fast-import --export-pack-edges=edges.list <input
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 .git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
 EOF
 test_expect_success 'I: verify edge list' '
@@ -761,7 +761,7 @@ test_expect_success 'I: verify edge list' '
 ### series J
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/J
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -787,7 +787,7 @@ test_expect_success 'J: branch has 1 commit, empty tree' '
 	test 0 = `git ls-tree J | wc -l`
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 reset refs/heads/J2
 
 tag wrong_tag
@@ -803,7 +803,7 @@ test_expect_success 'J: tag must fail on empty branch' '
 ### series K
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/K
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -833,7 +833,7 @@ test_expect_success 'K: verify K^1 = branch^1' '
 ### series L
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :1
 data <<EOF
@@ -867,7 +867,7 @@ M 644 :2 b/other
 M 644 :2 ba
 INPUT_END
 
-cat >expect <<EXPECT_END
+cat >expect <<-EXPECT_END &&
 :100644 100644 4268632... 55d3a52... M	b.
 :040000 040000 0ae5cac... 443c768... M	b
 :100644 100644 4268632... 55d3a52... M	ba
@@ -879,7 +879,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	test_cmp expect output
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :1
 data <<EOF
@@ -905,7 +905,7 @@ C a/e g/b
 M 644 :1 g/b/h
 INPUT_END
 
-cat <<EOF >expect
+cat <<-EOF >expect &&
 g/b/f
 g/b/h
 EOF
@@ -924,7 +924,7 @@ test_expect_success 'L: nested tree copy does not corrupt deltas' '
 ###
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/M1
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -936,7 +936,7 @@ R file2/newf file2/n.e.w.f
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
 EOF
 test_expect_success 'M: rename file in same subdirectory' '
@@ -945,7 +945,7 @@ test_expect_success 'M: rename file in same subdirectory' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/M2
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -957,7 +957,7 @@ R file2/newf i/am/new/to/you
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
 EOF
 test_expect_success 'M: rename file to new subdirectory' '
@@ -966,7 +966,7 @@ test_expect_success 'M: rename file to new subdirectory' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/M3
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -978,7 +978,7 @@ R i other/sub
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
 EOF
 test_expect_success 'M: rename subdirectory to new subdirectory' '
@@ -987,7 +987,7 @@ test_expect_success 'M: rename subdirectory to new subdirectory' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/M4
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -999,7 +999,7 @@ R "" sub
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2/oldf	sub/file2/oldf
 :100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 R100	file4	sub/file4
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	sub/i/am/new/to/you
@@ -1018,7 +1018,7 @@ test_expect_success 'M: rename root to subdirectory' '
 ###
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/N1
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1030,7 +1030,7 @@ C file2/newf file2/n.e.w.f
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
 EOF
 test_expect_success 'N: copy file in same subdirectory' '
@@ -1039,7 +1039,7 @@ test_expect_success 'N: copy file in same subdirectory' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/N2
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1062,7 +1062,7 @@ EOF
 
 INPUT_END
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
 :100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
@@ -1073,7 +1073,7 @@ test_expect_success 'N: copy then modify subdirectory' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/N3
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1457,7 +1457,7 @@ test_expect_success 'N: modify subtree, extract it, and modify again' '
 ### series O
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 #we will
 commit refs/heads/O1
 # -- ignore all of this text
@@ -1493,7 +1493,7 @@ test_expect_success 'O: comments are all skipped' '
 	test `git rev-parse N3` = `git rev-parse O1`
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/O2
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1518,7 +1518,7 @@ test_expect_success 'O: repack before next test' '
 	git repack -a -d
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/O3
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1548,7 +1548,7 @@ reset refs/tags/O3-3rd
 from :5
 INPUT_END
 
-cat >expect <<INPUT_END
+cat >expect <<-INPUT_END &&
 string
 of
 empty
@@ -1562,7 +1562,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	test_cmp expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/O4
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -1597,7 +1597,7 @@ test_expect_success 'O: progress outputs as requested by input' '
 ### series P (gitlinks)
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :1
 data 10
@@ -1670,7 +1670,7 @@ test_expect_success 'P: superproject & submodule mix' '
 SUBLAST=$(git rev-parse --verify sub)
 SUBPREV=$(git rev-parse --verify sub^)
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :1
 data <<DATAEND
@@ -1707,7 +1707,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 '
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/subuse3
 mark :1
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1728,7 +1728,7 @@ test_expect_success 'P: fail on inline gitlink' '
 '
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :1
 data <<DATA
@@ -1763,7 +1763,7 @@ note1c_data="The third note for the first commit"
 note2b_data="The second note for the second commit"
 
 test_tick
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 blob
 mark :2
 data <<EOF
@@ -1887,7 +1887,7 @@ commit1=$(git rev-parse notes-test~2)
 commit2=$(git rev-parse notes-test^)
 commit3=$(git rev-parse notes-test)
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -1898,7 +1898,7 @@ test_expect_success 'Q: verify first commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 parent $commit1
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1910,7 +1910,7 @@ test_expect_success 'Q: verify second commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 parent $commit2
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1922,7 +1922,7 @@ test_expect_success 'Q: verify third commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -1933,7 +1933,7 @@ test_expect_success 'Q: verify first notes commit' '
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<EOF
+cat >expect.unsorted <<-EOF &&
 100644 blob $commit1
 100644 blob $commit2
 100644 blob $commit3
@@ -1962,7 +1962,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 parent `git rev-parse --verify refs/notes/foobar~2`
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1974,7 +1974,7 @@ test_expect_success 'Q: verify second notes commit' '
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<EOF
+cat >expect.unsorted <<-EOF &&
 100644 blob $commit1
 100644 blob $commit2
 100644 blob $commit3
@@ -2003,7 +2003,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
@@ -2014,7 +2014,7 @@ test_expect_success 'Q: verify third notes commit' '
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<EOF
+cat >expect.unsorted <<-EOF &&
 100644 blob $commit1
 EOF
 cat expect.unsorted | sort >expect
@@ -2029,7 +2029,7 @@ test_expect_success 'Q: verify third note for first commit' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 parent `git rev-parse --verify refs/notes/foobar^`
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2041,7 +2041,7 @@ test_expect_success 'Q: verify fourth notes commit' '
 	test_cmp expect actual
 '
 
-cat >expect.unsorted <<EOF
+cat >expect.unsorted <<-EOF &&
 100644 blob $commit2
 EOF
 cat expect.unsorted | sort >expect
@@ -2056,7 +2056,7 @@ test_expect_success 'Q: verify second note for second commit' '
 	test_cmp expect actual
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 reset refs/heads/Q0
 
 commit refs/heads/note-Q0
@@ -2077,7 +2077,7 @@ test_expect_success 'Q: deny note on empty branch' '
 ### series R (feature and option)
 ###
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature no-such-feature-exists
 EOF
 
@@ -2085,7 +2085,7 @@ test_expect_success 'R: abort on unsupported feature' '
 	test_must_fail git fast-import <input
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature date-format=now
 EOF
 
@@ -2093,7 +2093,7 @@ test_expect_success 'R: supported feature is accepted' '
 	git fast-import <input
 '
 
-cat >input << EOF
+cat >input <<-EOF &&
 blob
 data 3
 hi
@@ -2104,7 +2104,7 @@ test_expect_success 'R: abort on receiving feature after data command' '
 	test_must_fail git fast-import <input
 '
 
-cat >input << EOF
+cat >input <<-EOF &&
 feature import-marks=git.marks
 feature import-marks=git2.marks
 EOF
@@ -2113,7 +2113,7 @@ test_expect_success 'R: only one import-marks feature allowed per stream' '
 	test_must_fail git fast-import <input
 '
 
-cat >input << EOF
+cat >input <<-EOF &&
 feature export-marks=git.marks
 blob
 mark :1
@@ -2234,7 +2234,7 @@ test_expect_success 'R: feature import-marks-if-exists' '
 	test_cmp expect io.marks
 '
 
-cat >input << EOF
+cat >input <<-EOF &&
 feature import-marks=marks.out
 feature export-marks=marks.new
 EOF
@@ -2244,7 +2244,7 @@ test_expect_success 'R: import to output marks works without any content' '
 	test_cmp marks.out marks.new
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature import-marks=nonexistent.marks
 feature export-marks=marks.new
 EOF
@@ -2255,7 +2255,7 @@ test_expect_success 'R: import marks prefers commandline marks file over the str
 '
 
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature import-marks=nonexistent.marks
 feature export-marks=combined.marks
 EOF
@@ -2267,7 +2267,7 @@ test_expect_success 'R: multiple --import-marks= should be honoured' '
 	test_cmp marks.out combined.marks
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature relative-marks
 feature import-marks=relative.in
 feature export-marks=relative.out
@@ -2280,7 +2280,7 @@ test_expect_success 'R: feature relative-marks should be honoured' '
 	test_cmp marks.new .git/info/fast-import/relative.out
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 feature relative-marks
 feature import-marks=relative.in
 feature no-relative-marks
@@ -2549,7 +2549,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 	test_cmp expect actual
 '
 
-cat >input << EOF
+cat >input <<-EOF &&
 option git quiet
 blob
 data 3
@@ -2604,7 +2604,7 @@ test_expect_success 'R: terminating "done" within commit' '
 	test_cmp expect actual
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 option git non-existing-option
 EOF
 
@@ -2624,7 +2624,7 @@ test_expect_success 'R: die on invalid option argument' '
 	test_must_fail git fast-import --depth="5 elephants" </dev/null
 '
 
-cat >input <<EOF
+cat >input <<-EOF &&
 option non-existing-vcs non-existing-option
 EOF
 
@@ -2637,7 +2637,7 @@ test_expect_success 'R: ignore non-git options' '
 ##
 blobsize=$((2*1024*1024 + 53))
 test-genrandom bar $blobsize >expect
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/big-file
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -2648,7 +2648,7 @@ M 644 inline big1
 data $blobsize
 INPUT_END
 cat expect >>input
-cat >>input <<INPUT_END
+cat >>input <<-INPUT_END &&
 M 644 inline big2
 data $blobsize
 INPUT_END
@@ -2713,7 +2713,7 @@ test_expect_success 'R: blob appears only once' '
 #
 test_tick
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/S
 mark :301
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -3002,7 +3002,7 @@ test_expect_success 'T: empty reset doesnt delete branch' '
 ### series U (filedelete)
 ###
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/U
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -3027,7 +3027,7 @@ test_expect_success 'U: initialize for U tests' '
 	git fast-import <input
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/U
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -3042,7 +3042,7 @@ test_expect_success 'U: filedelete file succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
 EOF
 
@@ -3052,7 +3052,7 @@ test_expect_success 'U: validate file delete result' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/U
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -3067,7 +3067,7 @@ test_expect_success 'U: filedelete directory succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
 EOF
 
@@ -3077,7 +3077,7 @@ test_expect_success 'U: validate directory delete result' '
 	compare_diff_raw expect actual
 '
 
-cat >input <<INPUT_END
+cat >input <<-INPUT_END &&
 commit refs/heads/U
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -3092,7 +3092,7 @@ test_expect_success 'U: filedelete root succeeds' '
 	git fast-import <input
 '
 
-cat >expect <<EOF
+cat >expect <<-EOF &&
 :100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
 EOF
 
-- 
2.6.2.337.ga235d84
