From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] t9300 (fast-import): style tweaks
Date: Sat, 4 Sep 2010 22:22:53 -0500
Message-ID: <20100905032253.GB2344@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:25:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5qp-0002b0-Vl
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab0IEDYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 23:24:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59128 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab0IEDYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 23:24:47 -0400
Received: by gwj17 with SMTP id 17so1234409gwj.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=r5SIzkRQinPY1gXSD2aD/ilhGuMx4rgQJ4+guqFf33g=;
        b=mCQm1JWOoUNakoFC+Ew1rbjupRIIij4SboDhvlnjdMO+AXIWVabFIvVH8bjnUoTiCT
         tXoPvTiMWqBktWD5RI120NQdfAiFP+C1OOEcUtWTTkmdXnAfIKr0ndqmRtaaV0sU3gHK
         EI3UBkggxS6dff+bK/fBGnLSP7xXd/YBLKWMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fF9n9u2MgCUJyujTeWr/dmtPUx3SUh+O1KswLp2nNjsIbXXx9Vupb900C3DugIGy/L
         czgz5KTFzQDqk517r7jKLpRWQMvtaz/4WNmG13e1Ct9reW4Hb5dzxEoIk4vxtaLVd2B8
         oreSUy4pICzoCqGtTsen19nUSt3EcGVNiXK24=
Received: by 10.101.195.37 with SMTP id x37mr1607285anp.38.1283657086150;
        Sat, 04 Sep 2010 20:24:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm6082784ann.0.2010.09.04.20.24.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 20:24:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155418>

Clarify dependencies between tests to make the fast-import test
script more approachable.  In particular:

 - guard setup commands with test assertions (for robustness and to
   make it easier to identify where each test starts and ends);

 - mention "setup" in the descriptions of tests that are used to
   prepare for later ones;

 - avoid hard-coded object names.  Although compare_diff_raw means
   most of them do not affect the test result, the reader can
   benefit more from other object descriptions;

 - tweak whitespace style: each test now starts with a test assertion,
   description, and opening quote on a single line, followed by test
   code that checks a single claim;

While at it:

 - introduce a verify_packs() helper, avoiding some repetition;

 - use test_cmp instead of test $foo = $bar for nicer output with -v;

 - use multiple separate commands instead of pipelines when that
   helps debugability;

 - use $(...) command substitutions in preference to ``; the former
   are less error-prone with respect to quoting and easier to notice
   when looking for $variable interpolations.

 - do not let tests exit the entire test script when they fail.

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh | 3207 ++++++++++++++++++++++++------------------------
 1 files changed, 1629 insertions(+), 1578 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 96d07f1..5c274e7 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,860 +7,890 @@ test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
-file2_data='file2
-second line of EOF'
-
-file3_data='EOF
-in 3rd file
- END'
-
-file4_data=abcd
-file4_len=4
-
-file5_data='an inline file.
-  we should see it later.'
-
-file6_data='#!/bin/sh
-echo "$@"'
-
-###
-### series A
-###
-
-test_tick
-cat >input <<INPUT_END
-blob
-mark :2
-data <<EOF
-$file2_data
-EOF
-
-blob
-mark :3
-data <<END
-$file3_data
-END
-
-blob
-mark :4
-data $file4_len
-$file4_data
-commit refs/heads/master
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-initial
-COMMIT
-
-M 644 :2 file2
-M 644 :3 file3
-M 755 :4 file4
-
-tag series-A
-from :5
-data <<EOF
-An annotated tag without a tagger
-EOF
-
-INPUT_END
-test_expect_success \
-    'A: create pack from stdin' \
-    'git fast-import --export-marks=marks.out <input &&
-	 git whatchanged master'
-test_expect_success \
-	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-cat >expect <<EOF
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-initial
-EOF
-test_expect_success \
-	'A: verify commit' \
-	'git cat-file commit master | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect <<EOF
-100644 blob file2
-100644 blob file3
-100755 blob file4
-EOF
-test_expect_success \
-	'A: verify tree' \
-	'git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
-
-echo "$file2_data" >expect
-test_expect_success \
-	'A: verify file2' \
-	'git cat-file blob master:file2 >actual && test_cmp expect actual'
-
-echo "$file3_data" >expect
-test_expect_success \
-	'A: verify file3' \
-	'git cat-file blob master:file3 >actual && test_cmp expect actual'
-
-printf "$file4_data" >expect
-test_expect_success \
-	'A: verify file4' \
-	'git cat-file blob master:file4 >actual && test_cmp expect actual'
-
-cat >expect <<EOF
-object $(git rev-parse refs/heads/master)
-type commit
-tag series-A
-
-An annotated tag without a tagger
-EOF
+test_expect_success 'setup: verify_packs helper' '
+	verify_packs () {
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack $p ||
+			return
+		done
+	}
+'
+
+test_expect_success 'setup' '
+	zeroes=0000000000000000000000000000000000000000 &&
+
+	# Use command substitution to strip off final newlines.
+	file2_data=$(cat <<-\END_FILE2_DATA
+		file2
+		second line of EOF
+		END_FILE2_DATA
+	) &&
+	file2_id=$(echo "$file2_data" | git hash-object --stdin) &&
+	file3_data=$(cat <<-\END_FILE3_DATA
+		EOF
+		in 3rd file
+		 END
+		END_FILE3_DATA
+	) &&
+	file3_id=$(echo "$file3_data" | git hash-object --stdin) &&
+	file4_data=abcd &&
+	file4_len=4 &&
+	file4_id=$(printf "%s" "$file4_data" | git hash-object --stdin) &&
+	file5_data=$(cat <<-\END_FILE5_DATA
+		an inline file.
+		  we should see it later.
+		END_FILE5_DATA
+	) &&
+	file5_id=$(echo "$file5_data" | git hash-object --stdin) &&
+	file6_data=$(cat <<-\END_FILE6_DATA
+		#!/bin/sh
+		echo "$@"
+		END_FILE6_DATA
+	) &&
+	file6_id=$(echo "$file6_data" | git hash-object --stdin)
+'
+
+test_expect_success 'setup: series A' '
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :2
+	data <<EOF
+	$file2_data
+	EOF
+
+	blob
+	mark :3
+	data <<END
+	$file3_data
+	END
+
+	blob
+	mark :4
+	data $file4_len
+	$file4_data
+	commit refs/heads/master
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	initial
+	COMMIT
+
+	M 644 :2 file2
+	M 644 :3 file3
+	M 755 :4 file4
+
+	tag series-A
+	from :5
+	data <<EOF
+	An annotated tag without a tagger
+	EOF
+
+	INPUT_END
+
+	git fast-import --export-marks=marks.out <input &&
+	git whatchanged master
+'
+
+test_expect_success 'fast-import writes valid packs' '
+	verify_packs
+'
+
+test_expect_success 'A: verify commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	initial
+	EOF
+	git cat-file commit master >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'A: verify tree' '
+	cat >expect <<-\EOF &&
+	100644 blob file2
+	100644 blob file3
+	100755 blob file4
+	EOF
+	git cat-file -p master^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'A: verify file2' '
+	echo "$file2_data" >expect &&
+	git cat-file blob master:file2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'A: verify file3' '
+	echo "$file3_data" >expect &&
+	git cat-file blob master:file3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'A: verify file4' '
+	printf "$file4_data" >expect &&
+	git cat-file blob master:file4 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'A: verify tag/series-A' '
+	master=$(git rev-parse refs/heads/master) &&
+	cat >expect <<-EOF &&
+	object $master
+	type commit
+	tag series-A
+
+	An annotated tag without a tagger
+	EOF
 	git cat-file tag tags/series-A >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-:2 `git rev-parse --verify master:file2`
-:3 `git rev-parse --verify master:file3`
-:4 `git rev-parse --verify master:file4`
-:5 `git rev-parse --verify master^0`
-EOF
-test_expect_success \
-	'A: verify marks output' \
-	'test_cmp expect marks.out'
+test_expect_success 'A: verify marks output' '
+	cat >expect <<-EOF &&
+	:2 $(git rev-parse --verify master:file2)
+	:3 $(git rev-parse --verify master:file3)
+	:4 $(git rev-parse --verify master:file4)
+	:5 $(git rev-parse --verify master^0)
+	EOF
+	test_cmp expect marks.out
+'
 
-test_expect_success \
-	'A: verify marks import' \
-	'git fast-import \
+test_expect_success 'A: import marks' '
+	cat >expect <<-EOF &&
+	:2 $(git rev-parse --verify master:file2)
+	:3 $(git rev-parse --verify master:file3)
+	:4 $(git rev-parse --verify master:file4)
+	:5 $(git rev-parse --verify master^0)
+	EOF
+	git fast-import \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
-	test_cmp expect marks.new'
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/verify--import-marks
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-recreate from :5
-COMMIT
-
-from :5
-M 755 :2 copy-of-file2
-
-INPUT_END
-test_expect_success \
-	'A: verify marks import does not crash' \
-	'git fast-import --import-marks=marks.out <input &&
-	 git whatchanged verify--import-marks'
-test_expect_success \
-	'A: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
-EOF
-git diff-tree -M -r master verify--import-marks >actual
-test_expect_success \
-	'A: verify diff' \
-	'compare_diff_raw expect actual &&
-	 test `git rev-parse --verify master:file2` \
-	    = `git rev-parse --verify verify--import-marks:copy-of-file2`'
-
-test_tick
-mt=$(git hash-object --stdin < /dev/null)
-: >input.blob
-: >marks.exp
-: >tree.exp
-
-cat >input.commit <<EOF
-commit refs/heads/verify--dump-marks
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-test the sparse array dumping routines with exponentially growing marks
-COMMIT
-EOF
-
-i=0
-l=4
-m=6
-n=7
-while test "$i" -lt 27; do
-    cat >>input.blob <<EOF
-blob
-mark :$l
-data 0
-blob
-mark :$m
-data 0
-blob
-mark :$n
-data 0
-EOF
-    echo "M 100644 :$l l$i" >>input.commit
-    echo "M 100644 :$m m$i" >>input.commit
-    echo "M 100644 :$n n$i" >>input.commit
-
-    echo ":$l $mt" >>marks.exp
-    echo ":$m $mt" >>marks.exp
-    echo ":$n $mt" >>marks.exp
-
-    printf "100644 blob $mt\tl$i\n" >>tree.exp
-    printf "100644 blob $mt\tm$i\n" >>tree.exp
-    printf "100644 blob $mt\tn$i\n" >>tree.exp
-
-    l=$(($l + $l))
-    m=$(($m + $m))
-    n=$(($l + $n))
-
-    i=$((1 + $i))
-done
-
-sort tree.exp > tree.exp_s
+	test_cmp expect marks.new
+'
+
+test_expect_success 'setup: A: verify marks import' '
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/verify--import-marks
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	recreate from :5
+	COMMIT
+
+	from :5
+	M 755 :2 copy-of-file2
+
+	INPUT_END
+
+	git fast-import --import-marks=marks.out <input &&
+	verify_packs &&
+	git whatchanged verify--import-marks
+'
+
+test_expect_success 'A: verify diff' '
+	echo ":000000 100755 $zeroes $file2_id A	copy-of-file2" >expect &&
+	echo $file2_id >expect.copy &&
+	git diff-tree -M -r master verify--import-marks >actual &&
+	git rev-parse --verify verify--import-marks:copy-of-file2 >actual.copy &&
+	compare_diff_raw expect actual &&
+	test_cmp expect.copy actual.copy
+'
 
 test_expect_success 'A: export marks with large values' '
-	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
+	test_tick &&
+	mt=$(git hash-object --stdin </dev/null) &&
+	>input.blob &&
+	>marks.exp &&
+	>tree.exp &&
+
+	cat >input.commit <<-EOF &&
+	commit refs/heads/verify--dump-marks
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	test the sparse array dumping routines with exponentially growing marks
+	COMMIT
+	EOF
+
+	(
+		i=0 &&
+		l=4 &&
+		m=6 &&
+		n=7 &&
+		while test "$i" -lt 27
+		do
+			cat >>input.blob <<-EOF &&
+			blob
+			mark :$l
+			data 0
+			blob
+			mark :$m
+			data 0
+			blob
+			mark :$n
+			data 0
+			EOF
+			{
+				echo "M 100644 :$l l$i" &&
+				echo "M 100644 :$m m$i" &&
+				echo "M 100644 :$n n$i"
+			} >>input.commit &&
+			{
+				echo ":$l $mt" &&
+				echo ":$m $mt" &&
+				echo ":$n $mt"
+			} >>marks.exp &&
+			{
+				printf "100644 blob $mt\tl$i\n" &&
+				printf "100644 blob $mt\tm$i\n" &&
+				printf "100644 blob $mt\tn$i\n"
+			} >>tree.exp &&
+
+			l=$(($l + $l)) &&
+			m=$(($m + $m)) &&
+			n=$(($l + $n)) &&
+			i=$((1 + $i)) ||
+			exit
+		done
+	) &&
+	sort tree.exp >tree.exp_s &&
+	cat input.blob input.commit |
+	git fast-import --export-marks=marks.large &&
 	git ls-tree refs/heads/verify--dump-marks >tree.out &&
 	test_cmp tree.exp_s tree.out &&
-	test_cmp marks.exp marks.large'
+	test_cmp marks.exp marks.large
+'
 
-###
-### series B
-###
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/branch
-mark :1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-M 755 0000000000000000000000000000000000000001 zero1
-
-INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
-    test_must_fail git fast-import <input
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/master
+	M 755 0000000000000000000000000000000000000001 zero1
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
 '
-rm -f .git/objects/pack_* .git/objects/index_*
 
-cat >input <<INPUT_END
-commit .badbranchname
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
 test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git fast-import <input
+	rm -f .git/objects/pack_* .git/objects/index_* &&
+
+	cat >input <<-INPUT_END &&
+	commit .badbranchname
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/master
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
 '
-rm -f .git/objects/pack_* .git/objects/index_*
 
-cat >input <<INPUT_END
-commit bad[branch]name
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
 test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git fast-import <input
+	rm -f .git/objects/pack_* .git/objects/index_* &&
+
+	cat >input <<-INPUT_END &&
+	commit bad[branch]name
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/master
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: accept branch name "TEMP_TAG"' '
+	git rev-parse master >expect &&
+	rm -f .git/objects/pack_* .git/objects/index_* &&
+
+	cat >input <<-INPUT_END &&
+	commit TEMP_TAG
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	tag base
+	COMMIT
+
+	from refs/heads/master
+
+	INPUT_END
+
+	test_when_finished "rm -f .git/TEMP_TAG" &&
+	git fast-import <input &&
+	test -f .git/TEMP_TAG &&
+	git rev-parse TEMP_TAG^ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: series C' '
+	newf=$(echo hi newf | git hash-object -w --stdin) &&
+	oldf=$(git rev-parse --verify master:file2) &&
+	echo $newf >expect.new &&
+	echo $oldf >expect.old &&
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	second
+	COMMIT
+
+	from refs/heads/master
+	M 644 $oldf file2/oldf
+	M 755 $newf file2/newf
+	D file3
+
+	INPUT_END
+
+	git fast-import <input &&
+	verify_packs &&
+	git whatchanged branch
+'
+
+test_expect_success 'C: reuse of existing blob' '
+	git rev-parse --verify branch:file2/newf >actual.new &&
+	git rev-parse --verify branch:file2/oldf >actual.old &&
+	test_cmp expect.new actual.new &&
+	test_cmp expect.old actual.old
+'
+
+test_expect_success 'C: verify commit' '
+	cat >expect <<-EOF &&
+	parent `git rev-parse --verify master^0`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	second
+	EOF
+	git cat-file commit branch >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
 '
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
-commit TEMP_TAG
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-tag base
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success \
-    'B: accept branch name "TEMP_TAG"' \
-    'git fast-import <input &&
-	 test -f .git/TEMP_TAG &&
-	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
-rm -f .git/TEMP_TAG
-
-###
-### series C
-###
-
-newf=`echo hi newf | git hash-object -w --stdin`
-oldf=`git rev-parse --verify master:file2`
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-second
-COMMIT
-
-from refs/heads/master
-M 644 $oldf file2/oldf
-M 755 $newf file2/newf
-D file3
-
-INPUT_END
-test_expect_success \
-    'C: incremental import create pack from stdin' \
-    'git fast-import <input &&
-	 git whatchanged branch'
-test_expect_success \
-	'C: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-test_expect_success \
-	'C: validate reuse existing blob' \
-	'test $newf = `git rev-parse --verify branch:file2/newf`
-	 test $oldf = `git rev-parse --verify branch:file2/oldf`'
-
-cat >expect <<EOF
-parent `git rev-parse --verify master^0`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-second
-EOF
-test_expect_success \
-	'C: verify commit' \
-	'git cat-file commit branch | sed 1d >actual &&
-	 test_cmp expect actual'
-
-cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
-:100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
-EOF
-git diff-tree -M -r master branch >actual
-test_expect_success \
-	'C: validate rename result' \
-	'compare_diff_raw expect actual'
-
-###
-### series D
-###
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third
-COMMIT
-
-from refs/heads/branch^0
-M 644 inline newdir/interesting
-data <<EOF
-$file5_data
-EOF
-
-M 755 inline newdir/exec.sh
-data <<EOF
-$file6_data
-EOF
-
-INPUT_END
-test_expect_success \
-    'D: inline data in commit' \
-    'git fast-import <input &&
-	 git whatchanged branch'
-test_expect_success \
-	'D: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 35a59026a33beac1569b1c7f66f3090ce9c09afc A	newdir/exec.sh
-:000000 100644 0000000000000000000000000000000000000000 046d0371e9220107917db0d0e030628de8a1de9b A	newdir/interesting
-EOF
-git diff-tree -M -r branch^ branch >actual
-test_expect_success \
-	'D: validate new files added' \
-	'compare_diff_raw expect actual'
-
-echo "$file5_data" >expect
-test_expect_success \
-	'D: verify file5' \
-	'git cat-file blob branch:newdir/interesting >actual &&
-	 test_cmp expect actual'
-
-echo "$file6_data" >expect
-test_expect_success \
-	'D: verify file6' \
-	'git cat-file blob branch:newdir/exec.sh >actual &&
-	 test_cmp expect actual'
-
-###
-### series E
-###
-
-cat >input <<INPUT_END
-commit refs/heads/branch
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
-data <<COMMIT
-RFC 2822 type date
-COMMIT
-
-from refs/heads/branch^0
-
-INPUT_END
+
+test_expect_success 'C: validate rename result' '
+	cat >expect <<-EOF &&
+	:000000 100755 $zeroes $newf A	file2/newf
+	:100644 100644 $file2_id $file2_id R100	file2	file2/oldf
+	:100644 000000 $file3_id 0000000000000000000000000000000000000000 D	file3
+	EOF
+	git diff-tree -M -r master branch >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'setup: D: inline data in commit' '
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline newdir/interesting
+	data <<EOF
+	$file5_data
+	EOF
+
+	M 755 inline newdir/exec.sh
+	data <<EOF
+	$file6_data
+	EOF
+
+	INPUT_END
+
+	git fast-import <input &&
+	verify_packs &&
+	git whatchanged branch
+'
+
+test_expect_success 'D: validate new files added' '
+	cat >expect <<-EOF &&
+	:000000 100755 $zeroes $file6_id A	newdir/exec.sh
+	:000000 100644 $zeroes $file5_id A	newdir/interesting
+	EOF
+	git diff-tree -M -r branch^ branch >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'D: verify file5' '
+	echo "$file5_data" >expect &&
+	git cat-file blob branch:newdir/interesting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'D: verify file6' '
+	echo "$file6_data" >expect &&
+	git cat-file blob branch:newdir/exec.sh >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-    test_must_fail git fast-import --date-format=raw <input
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
+	data <<COMMIT
+	RFC 2822 type date
+	COMMIT
+
+	from refs/heads/branch^0
+
+	INPUT_END
+	test_must_fail git fast-import --date-format=raw <input
 '
-test_expect_success \
-    'E: rfc2822 date, --date-format=rfc2822' \
-    'git fast-import --date-format=rfc2822 <input'
-test_expect_success \
-	'E: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-cat >expect <<EOF
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
-
-RFC 2822 type date
-EOF
-test_expect_success \
-	'E: verify commit' \
-	'git cat-file commit branch | sed 1,2d >actual &&
-	test_cmp expect actual'
-
-###
-### series F
-###
-
-old_branch=`git rev-parse --verify branch^0`
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-losing things already?
-COMMIT
-
-from refs/heads/branch~1
-
-reset refs/heads/other
-from refs/heads/branch
-
-INPUT_END
-test_expect_success \
-    'F: non-fast-forward update skips' \
-    'if git fast-import <input
-	 then
-		echo BAD gfi did not fail
-		return 1
-	 else
-		if test $old_branch = `git rev-parse --verify branch^0`
-		then
-			: branch unaffected and failure returned
-			return 0
-		else
-			echo BAD gfi changed branch $old_branch
-			return 1
-		fi
-	 fi
-	'
-test_expect_success \
-	'F: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-cat >expect <<EOF
-tree `git rev-parse branch~1^{tree}`
-parent `git rev-parse branch~1`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-losing things already?
-EOF
-test_expect_success \
-	'F: verify other commit' \
-	'git cat-file commit other >actual &&
-	test_cmp expect actual'
-
-###
-### series G
-###
-
-old_branch=`git rev-parse --verify branch^0`
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/branch
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-losing things already?
-COMMIT
-
-from refs/heads/branch~1
-
-INPUT_END
-test_expect_success \
-    'G: non-fast-forward update forced' \
-    'git fast-import --force <input'
-test_expect_success \
-	'G: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-test_expect_success \
-	'G: branch changed, but logged' \
-	'test $old_branch != `git rev-parse --verify branch^0` &&
-	 test $old_branch = `git rev-parse --verify branch@{1}`'
-
-###
-### series H
-###
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/H
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third
-COMMIT
-
-from refs/heads/branch^0
-M 644 inline i-will-die
-data <<EOF
-this file will never exist.
-EOF
-
-deleteall
-M 644 inline h/e/l/lo
-data <<EOF
-$file5_data
-EOF
-
-INPUT_END
-test_expect_success \
-    'H: deletall, add 1' \
-    'git fast-import <input &&
-	 git whatchanged H'
-test_expect_success \
-	'H: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-cat >expect <<EOF
-:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
-:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
-:100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	h/e/l/lo
-:100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
-EOF
-git diff-tree -M -r H^ H >actual
-test_expect_success \
-	'H: validate old files removed, new files added' \
-	'compare_diff_raw expect actual'
-
-echo "$file5_data" >expect
-test_expect_success \
-	'H: verify file' \
-	'git cat-file blob H:h/e/l/lo >actual &&
-	 test_cmp expect actual'
-
-###
-### series I
-###
-
-cat >input <<INPUT_END
-commit refs/heads/export-boundary
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-we have a border.  its only 40 characters wide.
-COMMIT
-
-from refs/heads/branch
-
-INPUT_END
-test_expect_success \
-    'I: export-pack-edges' \
-    'git fast-import --export-pack-edges=edges.list <input'
-
-cat >expect <<EOF
-.git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
-EOF
-test_expect_success \
-	'I: verify edge list' \
-	'sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	 test_cmp expect actual'
-
-###
-### series J
-###
-
-cat >input <<INPUT_END
-commit refs/heads/J
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create J
-COMMIT
-
-from refs/heads/branch
-
-reset refs/heads/J
-
-commit refs/heads/J
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-initialize J
-COMMIT
-
-INPUT_END
-test_expect_success \
-    'J: reset existing branch creates empty commit' \
-    'git fast-import <input'
-test_expect_success \
-	'J: branch has 1 commit, empty tree' \
-	'test 1 = `git rev-list J | wc -l` &&
-	 test 0 = `git ls-tree J | wc -l`'
-
-###
-### series K
-###
-
-cat >input <<INPUT_END
-commit refs/heads/K
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create K
-COMMIT
-
-from refs/heads/branch
-
-commit refs/heads/K
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-redo K
-COMMIT
-
-from refs/heads/branch^1
-
-INPUT_END
-test_expect_success \
-    'K: reinit branch with from' \
-    'git fast-import <input'
-test_expect_success \
-    'K: verify K^1 = branch^1' \
-    'test `git rev-parse --verify branch^1` \
-		= `git rev-parse --verify K^1`'
-
-###
-### series L
-###
-
-cat >input <<INPUT_END
-blob
-mark :1
-data <<EOF
-some data
-EOF
-
-blob
-mark :2
-data <<EOF
-other data
-EOF
-
-commit refs/heads/L
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-create L
-COMMIT
-
-M 644 :1 b.
-M 644 :1 b/other
-M 644 :1 ba
-
-commit refs/heads/L
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-update L
-COMMIT
-
-M 644 :2 b.
-M 644 :2 b/other
-M 644 :2 ba
-INPUT_END
-
-cat >expect <<EXPECT_END
-:100644 100644 4268632... 55d3a52... M	b.
-:040000 040000 0ae5cac... 443c768... M	b
-:100644 100644 4268632... 55d3a52... M	ba
-EXPECT_END
-
-test_expect_success \
-    'L: verify internal tree sorting' \
-	'git fast-import <input &&
-	 git diff-tree --abbrev --raw L^ L >output &&
-	 test_cmp expect output'
-
-###
-### series M
-###
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/M1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
-
-from refs/heads/branch^0
-R file2/newf file2/n.e.w.f
-
-INPUT_END
-
-cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
-EOF
-test_expect_success \
-	'M: rename file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M1^ M1 >actual &&
-	 compare_diff_raw expect actual'
-
-cat >input <<INPUT_END
-commit refs/heads/M2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
-
-from refs/heads/branch^0
-R file2/newf i/am/new/to/you
-
-INPUT_END
-
-cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
-EOF
-test_expect_success \
-	'M: rename file to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M2^ M2 >actual &&
-	 compare_diff_raw expect actual'
-
-cat >input <<INPUT_END
-commit refs/heads/M3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file rename
-COMMIT
-
-from refs/heads/M2^0
-R i other/sub
-
-INPUT_END
-
-cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
-EOF
-test_expect_success \
-	'M: rename subdirectory to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M3^ M3 >actual &&
-	 compare_diff_raw expect actual'
-
-###
-### series N
-###
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/N1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-file copy
-COMMIT
-
-from refs/heads/branch^0
-C file2/newf file2/n.e.w.f
-
-INPUT_END
-
-cat >expect <<EOF
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
-EOF
-test_expect_success \
-	'N: copy file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
-	 compare_diff_raw expect actual'
-
-cat >input <<INPUT_END
-commit refs/heads/N2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-clean directory copy
-COMMIT
-
-from refs/heads/branch^0
-C file2 file3
-
-commit refs/heads/N2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-modify directory copy
-COMMIT
-
-M 644 inline file3/file5
-data <<EOF
-$file5_data
-EOF
-
-INPUT_END
-
-cat >expect <<EOF
-:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
-EOF
-test_expect_success \
-	'N: copy then modify subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
-	 compare_diff_raw expect actual'
-
-cat >input <<INPUT_END
-commit refs/heads/N3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-dirty directory copy
-COMMIT
-
-from refs/heads/branch^0
-M 644 inline file2/file5
-data <<EOF
-$file5_data
-EOF
-
-C file2 file3
-D file2/file5
-
-INPUT_END
-
-test_expect_success \
-	'N: copy dirty subdirectory' \
-	'git fast-import <input &&
-	 test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`'
-
-test_expect_success \
-	'N: copy directory by id' \
-	'cat >expect <<-\EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+
+test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
+	cat >expect <<-EOF &&
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
+
+	RFC 2822 type date
+	EOF
+	git fast-import --date-format=rfc2822 <input &&
+	verify_packs &&
+	git cat-file commit branch >commit &&
+	sed 1,2d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: F: non-fast-forward update' '
+	test_tick &&
+
+	cat >input <<-INPUT_END
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	losing things already?
+	COMMIT
+
+	from refs/heads/branch~1
+
+	reset refs/heads/other
+	from refs/heads/branch
+
+	INPUT_END
+
+	old_branch=$(git rev-parse --verify branch^0) &&
+	test_must_fail git fast-import <input &&
+	verify_packs
+'
+
+test_expect_success 'F: non-fast-forward update skips' '
+	echo $old_branch >expect &&
+	git rev-parse --verify branch^0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'F: verify other commit' '
+	cat >expect <<-EOF &&
+	tree $(git rev-parse branch~1^{tree})
+	parent $(git rev-parse branch~1)
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	losing things already?
+	EOF
+	git cat-file commit other >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: G: forced non-fast-forward update' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/branch
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	losing things already?
+	COMMIT
+
+	from refs/heads/branch~1
+
+	INPUT_END
+
+	git rev-parse --verify branch^0 >old_branch &&
+	git fast-import --force <input &&
+	verify_packs
+'
+
+test_expect_success 'G: branch changed, but logged' '
+	git rev-parse --verify branch^0 >branch &&
+	git rev-parse --verify branch@{1} >prev &&
+	! test_cmp old_branch branch &&
+	test_cmp old_branch prev
+'
+
+test_expect_success 'setup: H: deleteall, add one' '
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/H
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline i-will-die
+	data <<EOF
+	this file will never exist.
+	EOF
+
+	deleteall
+	M 644 inline h/e/l/lo
+	data <<EOF
+	$file5_data
+	EOF
+
+	INPUT_END
+
+	git fast-import <input &&
+	verify_packs &&
+	git whatchanged H
+'
+
+test_expect_success 'H: validate old files removed, new files added' '
+	cat >expect <<-EOF &&
+	:100755 000000 $newf $zeroes D	file2/newf
+	:100644 000000 $oldf $zeroes D	file2/oldf
+	:100755 000000 $file4_id $zeroes D	file4
+	:100644 100644 $file5_id $file5_id R100	newdir/interesting	h/e/l/lo
+	:100755 000000 $file6_id $zeroes D	newdir/exec.sh
+	EOF
+	git diff-tree -M -r H^ H >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'H: verify file' '
+	echo "$file5_data" >expect &&
+	git cat-file blob H:h/e/l/lo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'I: --export-pack-edges' '
+	echo ".git/objects/pack/pack-.pack: EDGE" >expect &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/export-boundary
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	we have a border.  its only 40 characters wide.
+	COMMIT
+
+	from refs/heads/branch
+
+	INPUT_END
+
+	git fast-import --export-pack-edges=edges.list <input &&
+	tip=$(git rev-parse --verify export-boundary) &&
+	sed -e "
+			s/pack-.*pack/pack-.pack/
+			s/$tip/EDGE/
+		" edges.list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'J: reset existing branch creates empty commit' '
+	echo SHA >one &&
+	>empty &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/J
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create J
+	COMMIT
+
+	from refs/heads/branch
+
+	reset refs/heads/J
+
+	commit refs/heads/J
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	initialize J
+	COMMIT
+
+	INPUT_END
+
+	git fast-import <input &&
+	git rev-list J >commitlist &&
+	git ls-tree J >listing &&
+
+	sed -e "s/$_x40/SHA/" commitlist >num-commits &&
+	test_cmp one num-commits &&
+	test_cmp empty listing
+'
+
+test_expect_success 'K: reinit branch with from' '
+	git rev-parse --verify branch^1 >expect &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/K
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create K
+	COMMIT
+
+	from refs/heads/branch
+
+	commit refs/heads/K
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	redo K
+	COMMIT
+
+	from refs/heads/branch^1
+
+	INPUT_END
+
+	git fast-import <input &&
+	git rev-parse --verify K^1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'L: trees sort correctly' '
+	some_data=$(echo some data | git hash-object -w --stdin) &&
+	other_data=$(echo other data | git hash-object -w --stdin) &&
+	some_tree=$(
+		rm -f tmp_index &&
+		echo "100644 blob $some_data	other" |
+		GIT_INDEX_FILE=tmp_index git update-index --index-info &&
+		GIT_INDEX_FILE=tmp_index git write-tree
+	) &&
+	other_tree=$(
+		rm -f tmp_index &&
+		echo "100644 blob $other_data	other" |
+		GIT_INDEX_FILE=tmp_index git update-index --index-info &&
+		GIT_INDEX_FILE=tmp_index git write-tree
+	) &&
+	cat >expect <<-EXPECT_END &&
+	:100644 100644 $some_data $other_data M	b.
+	:040000 040000 $some_tree $other_tree M	b
+	:100644 100644 $some_data $other_data M	ba
+	EXPECT_END
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	some data
+	EOF
+
+	blob
+	mark :2
+	data <<EOF
+	other data
+	EOF
+
+	commit refs/heads/L
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create L
+	COMMIT
+
+	M 644 :1 b.
+	M 644 :1 b/other
+	M 644 :1 ba
+
+	commit refs/heads/L
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	update L
+	COMMIT
+
+	M 644 :2 b.
+	M 644 :2 b/other
+	M 644 :2 ba
+	INPUT_END
+	git fast-import <input &&
+	git diff-tree L^ L >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'M: rename file within subdirectory' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf R100	file2/newf	file2/n.e.w.f
+	EOF
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
+
+	from refs/heads/branch^0
+	R file2/newf file2/n.e.w.f
+
+	INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -M -r M1^ M1 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'M: rename file to new subdirectory (and set up M2)' '
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf R100	file2/newf	i/am/new/to/you
+	EOF
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
+
+	from refs/heads/branch^0
+	R file2/newf i/am/new/to/you
+
+	INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -M -r M2^ M2 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'M: rename subdirectory to new subdirectory' '
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf R100	i/am/new/to/you	other/sub/am/new/to/you
+	EOF
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/M3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file rename
+	COMMIT
+
+	from refs/heads/M2^0
+	R i other/sub
+
+	INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -M -r M3^ M3 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'N: copy file in same subdirectory' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	file2/n.e.w.f
+	EOF
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	file copy
+	COMMIT
+
+	from refs/heads/branch^0
+	C file2/newf file2/n.e.w.f
+
+	INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'N: copy then modify subdirectory (and set up N2)' '
+	cat >expect <<-EOF &&
+	:100644 100644 $file5_id $file5_id C100	newdir/interesting	file3/file5
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
+	EOF
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	clean directory copy
+	COMMIT
+
+	from refs/heads/branch^0
+	C file2 file3
+
+	commit refs/heads/N2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	modify directory copy
+	COMMIT
+
+	M 644 inline file3/file5
+	data <<EOF
+	$file5_data
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+
+	INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'N: copy dirty subdirectory (and set up N3)' '
+	git rev-parse N2^{tree} >expect &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/N3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline file2/file5
+	data <<EOF
+	$file5_data
+	EOF
+
+	C file2 file3
+	D file2/file5
+
+	INPUT_END
+
+	git fast-import <input &&
+	git rev-parse N3^{tree} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'N: copy directory by id' '
+	subdir=$(git rev-parse --verify refs/heads/branch^0:file2) &&
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
+	EOF
+
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N4
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -870,19 +900,21 @@ test_expect_success \
 	from refs/heads/branch^0
 	M 040000 $subdir file3
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
-	 compare_diff_raw expect actual'
 
-test_expect_success \
-	'N: modify copied tree' \
-	'cat >expect <<-\EOF &&
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'N: modify copied tree' '
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	cat >expect <<-EOF &&
+	:100644 100644 $file5_id $file5_id C100	newdir/interesting	file3/file5
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N5
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -903,794 +935,813 @@ test_expect_success \
 	$file5_data
 	EOF
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
-	 compare_diff_raw expect actual'
-
-###
-### series O
-###
-
-cat >input <<INPUT_END
-#we will
-commit refs/heads/O1
-# -- ignore all of this text
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-# $GIT_COMMITTER_NAME has inserted here for his benefit.
-data <<COMMIT
-dirty directory copy
-COMMIT
-
-# don't forget the import blank line!
-#
-# yes, we started from our usual base of branch^0.
-# i like branch^0.
-from refs/heads/branch^0
-# and we need to reuse file2/file5 from N3 above.
-M 644 inline file2/file5
-# otherwise the tree will be different
-data <<EOF
-$file5_data
-EOF
-
-# don't forget to copy file2 to file3
-C file2 file3
-#
-# or to delete file5 from file2.
-D file2/file5
-# are we done yet?
-
-INPUT_END
-
-test_expect_success \
-	'O: comments are all skipped' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O1`'
-
-cat >input <<INPUT_END
-commit refs/heads/O2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-dirty directory copy
-COMMIT
-from refs/heads/branch^0
-M 644 inline file2/file5
-data <<EOF
-$file5_data
-EOF
-C file2 file3
-D file2/file5
-
-INPUT_END
-
-test_expect_success \
-	'O: blank lines not necessary after data commands' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O2`'
-
-test_expect_success \
-	'O: repack before next test' \
-	'git repack -a -d'
-
-cat >input <<INPUT_END
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zstring
-COMMIT
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zof
-COMMIT
-checkpoint
-commit refs/heads/O3
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zempty
-COMMIT
-checkpoint
-commit refs/heads/O3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zcommits
-COMMIT
-reset refs/tags/O3-2nd
-from :5
-reset refs/tags/O3-3rd
-from :5
-INPUT_END
-
-cat >expect <<INPUT_END
-string
-of
-empty
-commits
-INPUT_END
-test_expect_success \
-	'O: blank lines not necessary after other commands' \
-	'git fast-import <input &&
-	 test 8 = `find .git/objects/pack -type f | wc -l` &&
-	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
-	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
-	 test_cmp expect actual'
-
-cat >input <<INPUT_END
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zstring
-COMMIT
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zof
-COMMIT
-progress Two commits down, 2 to go!
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zempty
-COMMIT
-progress Three commits down, 1 to go!
-commit refs/heads/O4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-zcommits
-COMMIT
-progress I'm done!
-INPUT_END
-test_expect_success \
-	'O: progress outputs as requested by input' \
-	'git fast-import <input >actual &&
-	 grep "progress " <input >expect &&
-	 test_cmp expect actual'
-
-###
-### series P (gitlinks)
-###
-
-cat >input <<INPUT_END
-blob
-mark :1
-data 10
-test file
-
-reset refs/heads/sub
-commit refs/heads/sub
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 12
-sub_initial
-M 100644 :1 file
-
-blob
-mark :3
-data <<DATAEND
-[submodule "sub"]
-	path = sub
-	url = "`pwd`/sub"
-DATAEND
-
-commit refs/heads/subuse1
-mark :4
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 8
-initial
-from refs/heads/master
-M 100644 :3 .gitmodules
-M 160000 :2 sub
-
-blob
-mark :5
-data 20
-test file
-more data
-
-commit refs/heads/sub
-mark :6
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 11
-sub_second
-from :2
-M 100644 :5 file
-
-commit refs/heads/subuse1
-mark :7
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 7
-second
-from :4
-M 160000 :6 sub
-
-INPUT_END
-
-test_expect_success \
-	'P: supermodule & submodule mix' \
-	'git fast-import <input &&
-	 git checkout subuse1 &&
-	 rm -rf sub && mkdir sub && cd sub &&
-	 git init &&
-	 git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-	 git checkout master &&
-	 cd .. &&
-	 git submodule init &&
-	 git submodule update'
-
-SUBLAST=$(git rev-parse --verify sub)
-SUBPREV=$(git rev-parse --verify sub^)
-
-cat >input <<INPUT_END
-blob
-mark :1
-data <<DATAEND
-[submodule "sub"]
-	path = sub
-	url = "`pwd`/sub"
-DATAEND
-
-commit refs/heads/subuse2
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 8
-initial
-from refs/heads/master
-M 100644 :1 .gitmodules
-M 160000 $SUBPREV sub
-
-commit refs/heads/subuse2
-mark :3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data 7
-second
-from :2
-M 160000 $SUBLAST sub
-
-INPUT_END
-
-test_expect_success \
-	'P: verbatim SHA gitlinks' \
-	'git branch -D sub &&
-	 git gc && git prune &&
-	 git fast-import <input &&
-	 test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)'
-
-test_tick
-cat >input <<INPUT_END
-commit refs/heads/subuse3
-mark :1
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/subuse2
-M 160000 inline sub
-data <<DATA
-$SUBPREV
-DATA
-
-INPUT_END
+
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'O: comments are all skipped' '
+	git rev-parse N3 >expect &&
+
+	cat >input <<-INPUT_END &&
+	#we will
+	commit refs/heads/O1
+	# -- ignore all of this text
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	# $GIT_COMMITTER_NAME has inserted here for his benefit.
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
+
+	# don'\''t forget the import blank line!
+	#
+	# yes, we started from our usual base of branch^0.
+	# i like branch^0.
+	from refs/heads/branch^0
+	# and we need to reuse file2/file5 from N3 above.
+	M 644 inline file2/file5
+	# otherwise the tree will be different
+	data <<EOF
+	$file5_data
+	EOF
+
+	# don'\''t forget to copy file2 to file3
+	C file2 file3
+	#
+	# or to delete file5 from file2.
+	D file2/file5
+	# are we done yet?
+
+	INPUT_END
+
+	git fast-import <input &&
+	git rev-parse O1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'O: blank lines not necessary after data commands' '
+	git rev-parse N3 >expect &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	dirty directory copy
+	COMMIT
+	from refs/heads/branch^0
+	M 644 inline file2/file5
+	data <<EOF
+	$file5_data
+	EOF
+	C file2 file3
+	D file2/file5
+
+	INPUT_END
+
+	git fast-import <input &&
+	git rev-parse O2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'O: blank lines not necessary after other commands' '
+	cat >expect <<-\INPUT_END &&
+	string
+	of
+	empty
+	commits
+	INPUT_END
+
+	git repack -a -d &&
+
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zstring
+	COMMIT
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zof
+	COMMIT
+	checkpoint
+	commit refs/heads/O3
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zempty
+	COMMIT
+	checkpoint
+	commit refs/heads/O3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zcommits
+	COMMIT
+	reset refs/tags/O3-2nd
+	from :5
+	reset refs/tags/O3-3rd
+	from :5
+	INPUT_END
+
+	git fast-import <input &&
+	git log --reverse --pretty=oneline O3 >log &&
+	git rev-parse O3^ >o3-parent &&
+	git rev-parse refs/tags/O3-2nd >o3-2nd &&
+
+	sed s/^.*z// log >actual &&
+	test_cmp expect actual &&
+	test 8 = `find .git/objects/pack -type f | wc -l` &&
+	test_cmp o3-2nd o3-parent
+'
+
+test_expect_success 'O: progress outputs as requested by input' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zstring
+	COMMIT
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zof
+	COMMIT
+	progress Two commits down, 2 to go!
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zempty
+	COMMIT
+	progress Three commits down, 1 to go!
+	commit refs/heads/O4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	zcommits
+	COMMIT
+	progress I'\''m done!
+	INPUT_END
+	grep "progress " <input >expect &&
+
+	git fast-import <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: P: supermodule & submodule mix' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data 10
+	test file
+
+	reset refs/heads/sub
+	commit refs/heads/sub
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 12
+	sub_initial
+	M 100644 :1 file
+
+	blob
+	mark :3
+	data <<DATAEND
+	[submodule "sub"]
+		path = sub
+		url = "$(pwd)/sub"
+	DATAEND
+
+	commit refs/heads/subuse1
+	mark :4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 8
+	initial
+	from refs/heads/master
+	M 100644 :3 .gitmodules
+	M 160000 :2 sub
+
+	blob
+	mark :5
+	data 20
+	test file
+	more data
+
+	commit refs/heads/sub
+	mark :6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 11
+	sub_second
+	from :2
+	M 100644 :5 file
+
+	commit refs/heads/subuse1
+	mark :7
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	second
+	from :4
+	M 160000 :6 sub
+
+	INPUT_END
+
+	git fast-import <input &&
+	git checkout subuse1 &&
+	rm -rf sub &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
+		git checkout master
+	) &&
+	git submodule init &&
+	git submodule update
+'
+
+test_expect_success 'P: verbatim SHA gitlinks (and set up subuse2)' '
+	SUBLAST=$(git rev-parse --verify sub) &&
+	SUBPREV=$(git rev-parse --verify sub^) &&
+	git rev-parse --verify subuse1 >expect &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<DATAEND
+	[submodule "sub"]
+		path = sub
+		url = "$(pwd)/sub"
+	DATAEND
+
+	commit refs/heads/subuse2
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 8
+	initial
+	from refs/heads/master
+	M 100644 :1 .gitmodules
+	M 160000 $SUBPREV sub
+
+	commit refs/heads/subuse2
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 7
+	second
+	from :2
+	M 160000 $SUBLAST sub
+
+	INPUT_END
+
+	git branch -D sub &&
+	git gc && git prune &&
+	git fast-import <input &&
+	git rev-parse --verify subuse2 >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'P: fail on inline gitlink' '
-    test_must_fail git fast-import <input'
+	test_tick &&
 
-test_tick
-cat >input <<INPUT_END
-blob
-mark :1
-data <<DATA
-$SUBPREV
-DATA
+	cat >input <<-INPUT_END &&
+	commit refs/heads/subuse3
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
 
-commit refs/heads/subuse3
-mark :2
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
+	from refs/heads/subuse2
+	M 160000 inline sub
+	data <<DATA
+	$SUBPREV
+	DATA
 
-from refs/heads/subuse2
-M 160000 :1 sub
+	INPUT_END
 
-INPUT_END
+	test_must_fail git fast-import <input
+'
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-    test_must_fail git fast-import <input'
-
-###
-### series Q (notes)
-###
-
-note1_data="The first note for the first commit"
-note2_data="The first note for the second commit"
-note3_data="The first note for the third commit"
-note1b_data="The second note for the first commit"
-note1c_data="The third note for the first commit"
-note2b_data="The second note for the second commit"
-
-test_tick
-cat >input <<INPUT_END
-blob
-mark :2
-data <<EOF
-$file2_data
-EOF
-
-commit refs/heads/notes-test
-mark :3
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-first (:3)
-COMMIT
-
-M 644 :2 file2
-
-blob
-mark :4
-data $file4_len
-$file4_data
-commit refs/heads/notes-test
-mark :5
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-second (:5)
-COMMIT
-
-M 644 :4 file4
-
-commit refs/heads/notes-test
-mark :6
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-third (:6)
-COMMIT
-
-M 644 inline file5
-data <<EOF
-$file5_data
-EOF
-
-M 755 inline file6
-data <<EOF
-$file6_data
-EOF
-
-blob
-mark :7
-data <<EOF
-$note1_data
-EOF
-
-blob
-mark :8
-data <<EOF
-$note2_data
-EOF
-
-commit refs/notes/foobar
-mark :9
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:9)
-COMMIT
-
-N :7 :3
-N :8 :5
-N inline :6
-data <<EOF
-$note3_data
-EOF
-
-commit refs/notes/foobar
-mark :10
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:10)
-COMMIT
-
-N inline :3
-data <<EOF
-$note1b_data
-EOF
-
-commit refs/notes/foobar2
-mark :11
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:11)
-COMMIT
-
-N inline :3
-data <<EOF
-$note1c_data
-EOF
-
-commit refs/notes/foobar
-mark :12
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes (:12)
-COMMIT
-
-deleteall
-N inline :5
-data <<EOF
-$note2b_data
-EOF
-
-INPUT_END
-
-test_expect_success \
-	'Q: commit notes' \
-	'git fast-import <input &&
-	 git whatchanged notes-test'
-test_expect_success \
-	'Q: verify pack' \
-	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
-
-commit1=$(git rev-parse notes-test~2)
-commit2=$(git rev-parse notes-test^)
-commit3=$(git rev-parse notes-test)
-
-cat >expect <<EOF
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-first (:3)
-EOF
-test_expect_success \
-	'Q: verify first commit' \
-	'git cat-file commit notes-test~2 | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect <<EOF
-parent $commit1
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-second (:5)
-EOF
-test_expect_success \
-	'Q: verify second commit' \
-	'git cat-file commit notes-test^ | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect <<EOF
-parent $commit2
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-third (:6)
-EOF
-test_expect_success \
-	'Q: verify third commit' \
-	'git cat-file commit notes-test | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect <<EOF
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:9)
-EOF
-test_expect_success \
-	'Q: verify first notes commit' \
-	'git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect.unsorted <<EOF
-100644 blob $commit1
-100644 blob $commit2
-100644 blob $commit3
-EOF
-cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify first notes tree' \
-	'git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
-
-echo "$note1_data" >expect
-test_expect_success \
-	'Q: verify first note for first commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual'
-
-echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual'
-
-echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual'
-
-cat >expect <<EOF
-parent `git rev-parse --verify refs/notes/foobar~2`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:10)
-EOF
-test_expect_success \
-	'Q: verify second notes commit' \
-	'git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect.unsorted <<EOF
-100644 blob $commit1
-100644 blob $commit2
-100644 blob $commit3
-EOF
-cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify second notes tree' \
-	'git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
-
-echo "$note1b_data" >expect
-test_expect_success \
-	'Q: verify second note for first commit' \
-	'git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual'
-
-echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual'
-
-echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual'
-
-cat >expect <<EOF
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:11)
-EOF
-test_expect_success \
-	'Q: verify third notes commit' \
-	'git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect.unsorted <<EOF
-100644 blob $commit1
-EOF
-cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify third notes tree' \
-	'git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
-
-echo "$note1c_data" >expect
-test_expect_success \
-	'Q: verify third note for first commit' \
-	'git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual'
-
-cat >expect <<EOF
-parent `git rev-parse --verify refs/notes/foobar^`
-author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-notes (:12)
-EOF
-test_expect_success \
-	'Q: verify fourth notes commit' \
-	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
-	test_cmp expect actual'
-
-cat >expect.unsorted <<EOF
-100644 blob $commit2
-EOF
-cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify fourth notes tree' \
-	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
-
-echo "$note2b_data" >expect
-test_expect_success \
-	'Q: verify second note for second commit' \
-	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
-
-###
-### series R (feature and option)
-###
-
-cat >input <<EOF
-feature no-such-feature-exists
-EOF
+	test_tick &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<DATA
+	$SUBPREV
+	DATA
+
+	commit refs/heads/subuse3
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	corrupt
+	COMMIT
+
+	from refs/heads/subuse2
+	M 160000 :1 sub
+
+	INPUT_END
+
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'setup: series Q (notes)' '
+	test_tick &&
+
+	note1_data="The first note for the first commit" &&
+	note2_data="The first note for the second commit" &&
+	note3_data="The first note for the third commit" &&
+	note1b_data="The second note for the first commit" &&
+	note1c_data="The third note for the first commit" &&
+	note2b_data="The second note for the second commit" &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :2
+	data <<EOF
+	$file2_data
+	EOF
+
+	commit refs/heads/notes-test
+	mark :3
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	first (:3)
+	COMMIT
+
+	M 644 :2 file2
+
+	blob
+	mark :4
+	data $file4_len
+	$file4_data
+	commit refs/heads/notes-test
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	second (:5)
+	COMMIT
+
+	M 644 :4 file4
+
+	commit refs/heads/notes-test
+	mark :6
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	third (:6)
+	COMMIT
+
+	M 644 inline file5
+	data <<EOF
+	$file5_data
+	EOF
+
+	M 755 inline file6
+	data <<EOF
+	$file6_data
+	EOF
+
+	blob
+	mark :7
+	data <<EOF
+	$note1_data
+	EOF
+
+	blob
+	mark :8
+	data <<EOF
+	$note2_data
+	EOF
+
+	commit refs/notes/foobar
+	mark :9
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:9)
+	COMMIT
+
+	N :7 :3
+	N :8 :5
+	N inline :6
+	data <<EOF
+	$note3_data
+	EOF
+
+	commit refs/notes/foobar
+	mark :10
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:10)
+	COMMIT
+
+	N inline :3
+	data <<EOF
+	$note1b_data
+	EOF
+
+	commit refs/notes/foobar2
+	mark :11
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:11)
+	COMMIT
+
+	N inline :3
+	data <<EOF
+	$note1c_data
+	EOF
+
+	commit refs/notes/foobar
+	mark :12
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	notes (:12)
+	COMMIT
+
+	deleteall
+	N inline :5
+	data <<EOF
+	$note2b_data
+	EOF
+
+	INPUT_END
+
+	git fast-import <input &&
+	verify_packs &&
+	git whatchanged notes-test
+'
+
+test_expect_success 'Q: verify first commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	first (:3)
+	EOF
+
+	git cat-file commit notes-test~2 >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify second commit' '
+	commit1=$(git rev-parse notes-test~2) &&
+	cat >expect <<-EOF
+	parent $commit1
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	second (:5)
+	EOF
+	git cat-file commit notes-test^ >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify third commit' '
+	commit2=$(git rev-parse notes-test^) &&
+	cat >expect <<-EOF &&
+	parent $commit2
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	third (:6)
+	EOF
+	git cat-file commit notes-test >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first notes commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:9)
+	EOF
+	git cat-file commit refs/notes/foobar~2 >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first notes tree' '
+	commit1=$(git rev-parse notes-test~2) &&
+	commit2=$(git rev-parse notes-test^) &&
+	commit3=$(git rev-parse notes-test) &&
+	sort >expect <<-EOF &&
+	100644 blob $commit1
+	100644 blob $commit2
+	100644 blob $commit3
+	EOF
+
+	git cat-file -p refs/notes/foobar~2^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first note for first commit' '
+	echo "$note1_data" >expect &&
+	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first note for second commit' '
+	echo "$note2_data" >expect &&
+	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first note for third commit' '
+	echo "$note3_data" >expect &&
+	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify second notes commit' '
+	cat >expect <<-EOF &&
+	parent `git rev-parse --verify refs/notes/foobar~2`
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:10)
+	EOF
+	git cat-file commit refs/notes/foobar^ >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify second notes tree' '
+	sort >expect <<-EOF
+	100644 blob $commit1
+	100644 blob $commit2
+	100644 blob $commit3
+	EOF
+	git cat-file -p refs/notes/foobar^^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify second note for first commit' '
+	echo "$note1b_data" >expect &&
+	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first note for second commit' '
+	echo "$note2_data" >expect &&
+	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify first note for third commit' '
+	echo "$note3_data" >expect &&
+	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify third notes commit' '
+	cat >expect <<-EOF &&
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:11)
+	EOF
+	git cat-file commit refs/notes/foobar2 >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify third notes tree' '
+	echo "100644 blob $commit1" >expect &&
+	git cat-file -p refs/notes/foobar2^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify third note for first commit' '
+	echo "$note1c_data" >expect
+	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify fourth notes commit' '
+	parent=$(git rev-parse --verify refs/notes/foobar^) &&
+	cat >expect <<-EOF &&
+	parent $parent
+	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+	notes (:12)
+	EOF
+	git cat-file commit refs/notes/foobar >commit &&
+	sed 1d <commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify fourth notes tree' '
+	echo "100644 blob $commit2" >expect &&
+	git cat-file -p refs/notes/foobar^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Q: verify second note for second commit' '
+	echo "$note2b_data" >expect
+	git cat-file blob refs/notes/foobar:$commit2 >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'R: abort on unsupported feature' '
+	cat >input <<-EOF &&
+	feature no-such-feature-exists
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input <<EOF
-feature date-format=now
-EOF
-
 test_expect_success 'R: supported feature is accepted' '
+	cat >input <<-EOF &&
+	feature date-format=now
+	EOF
+
 	git fast-import <input
 '
 
-cat >input << EOF
-blob
-data 3
-hi
-feature date-format=now
-EOF
-
 test_expect_success 'R: abort on receiving feature after data command' '
+	cat >input <<-EOF &&
+	blob
+	data 3
+	hi
+	feature date-format=now
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input << EOF
-feature import-marks=git.marks
-feature import-marks=git2.marks
-EOF
-
 test_expect_success 'R: only one import-marks feature allowed per stream' '
+	cat >input <<-\EOF &&
+	feature import-marks=git.marks
+	feature import-marks=git2.marks
+	EOF
+
 	test_must_fail git fast-import <input
 '
 
-cat >input << EOF
-feature export-marks=git.marks
-blob
-mark :1
-data 3
-hi
-
-EOF
-
-test_expect_success \
-    'R: export-marks feature results in a marks file being created' \
-    'cat input | git fast-import &&
-    grep :1 git.marks'
-
-test_expect_success \
-    'R: export-marks options can be overriden by commandline options' \
-    'cat input | git fast-import --export-marks=other.marks &&
-    grep :1 other.marks'
-
-cat >input << EOF
-feature import-marks=marks.out
-feature export-marks=marks.new
-EOF
-
-test_expect_success \
-    'R: import to output marks works without any content' \
-    'cat input | git fast-import &&
-    test_cmp marks.out marks.new'
-
-cat >input <<EOF
-feature import-marks=nonexistant.marks
-feature export-marks=marks.new
-EOF
+test_expect_success 'setup: R: stream using export-marks feature' '
+	cat >input <<-\EOF
+	feature export-marks=git.marks
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+'
 
-test_expect_success \
-    'R: import marks prefers commandline marks file over the stream' \
-    'cat input | git fast-import --import-marks=marks.out &&
-    test_cmp marks.out marks.new'
+test_expect_success 'R: export-marks feature results in a marks file being created' '
+	git fast-import <input &&
+	grep :1 git.marks
+'
 
+test_expect_success 'R: export-marks options can be overriden by commandline options' '
+	git fast-import --export-marks=other.marks <input &&
+	grep :1 other.marks
+'
 
-cat >input <<EOF
-feature import-marks=nonexistant.marks
-feature export-marks=combined.marks
-EOF
+test_expect_success 'R: import to output marks works without any content' '
+	cat >input <<-\EOF &&
+	feature import-marks=marks.out
+	feature export-marks=marks.new
+	EOF
 
-test_expect_success 'R: multiple --import-marks= should be honoured' '
-    head -n2 marks.out > one.marks &&
-    tail -n +3 marks.out > two.marks &&
-    git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
-    test_cmp marks.out combined.marks
+	git fast-import <input &&
+	test_cmp marks.out marks.new
 '
 
-cat >input <<EOF
-feature relative-marks
-feature import-marks=relative.in
-feature export-marks=relative.out
-EOF
-
-test_expect_success 'R: feature relative-marks should be honoured' '
-    mkdir -p .git/info/fast-import/ &&
-    cp marks.new .git/info/fast-import/relative.in &&
-    git fast-import <input &&
-    test_cmp marks.new .git/info/fast-import/relative.out
+test_expect_success 'R: import marks prefers commandline marks file over the stream' '
+	cat >input <<-EOF &&
+	feature import-marks=nonexistant.marks
+	feature export-marks=marks.new
+	EOF
+	git fast-import --import-marks=marks.out <input &&
+	test_cmp marks.out marks.new
 '
 
-cat >input <<EOF
-feature relative-marks
-feature import-marks=relative.in
-feature no-relative-marks
-feature export-marks=non-relative.out
-EOF
+test_expect_success 'R: multiple --import-marks= are honoured' '
+	cat >input <<-EOF &&
+	feature import-marks=nonexistant.marks
+	feature export-marks=combined.marks
+	EOF
 
-test_expect_success 'R: feature no-relative-marks should be honoured' '
-    git fast-import <input &&
-    test_cmp marks.new non-relative.out
+	head -n2 marks.out >one.marks &&
+	tail -n +3 marks.out >two.marks &&
+	git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
+	test_cmp marks.out combined.marks
 '
 
-cat >input << EOF
-option git quiet
-blob
-data 3
-hi
+test_expect_success 'R: feature relative-marks is honoured' '
+	cat >input <<-\EOF &&
+	feature relative-marks
+	feature import-marks=relative.in
+	feature export-marks=relative.out
+	EOF
+
+	mkdir -p .git/info/fast-import/ &&
+	cp marks.out .git/info/fast-import/relative.in &&
+	git fast-import <input &&
+	test_cmp marks.out .git/info/fast-import/relative.out
+'
 
-EOF
+test_expect_success 'R: feature no-relative-marks is honoured' '
+	cat >input <<-\EOF &&
+	feature relative-marks
+	feature import-marks=relative.in
+	feature no-relative-marks
+	feature export-marks=non-relative.out
+	EOF
 
-touch empty
+	git fast-import <input &&
+	test_cmp marks.out non-relative.out
+'
 
 test_expect_success 'R: quiet option results in no stats being output' '
-    cat input | git fast-import 2> output &&
-    test_cmp empty output
+	>empty &&
+	cat >input <<-\EOF &&
+	option git quiet
+	blob
+	data 3
+	hi
+
+	EOF
+
+	git fast-import <input 2>output &&
+	test_cmp empty output
 '
 
-cat >input <<EOF
-option git non-existing-option
-EOF
-
 test_expect_success 'R: die on unknown option' '
-    test_must_fail git fast-import <input
+	cat >input <<-\EOF &&
+	option git non-existing-option
+	EOF
+
+	test_must_fail git fast-import <input
 '
 
 test_expect_success 'R: unknown commandline options are rejected' '\
-    test_must_fail git fast-import --non-existing-option < /dev/null
+	test_must_fail git fast-import --non-existing-option </dev/null
 '
 
-cat >input <<EOF
-option non-existing-vcs non-existing-option
-EOF
-
 test_expect_success 'R: ignore non-git options' '
-    git fast-import <input
+	cat >input <<-\EOF &&
+	option non-existing-vcs non-existing-option
+	EOF
+
+	git fast-import <input
 '
 
-##
-## R: very large blobs
-##
-blobsize=$((2*1024*1024 + 53))
-test-genrandom bar $blobsize >expect
-cat >input <<INPUT_END
-commit refs/heads/big-file
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-R - big file
-COMMIT
-
-M 644 inline big1
-data $blobsize
-INPUT_END
-cat expect >>input
-cat >>input <<INPUT_END
-M 644 inline big2
-data $blobsize
-INPUT_END
-cat expect >>input
-echo >>input
-
-test_expect_success \
-	'R: blob bigger than threshold' \
-	'test_create_repo R &&
-	 git --git-dir=R/.git fast-import --big-file-threshold=1 <input'
-test_expect_success \
-	'R: verify created pack' \
-	': >verify &&
-	 for p in R/.git/objects/pack/*.pack;
-	 do
-	   git verify-pack -v $p >>verify || exit;
-	 done'
-test_expect_success \
-	'R: verify written objects' \
-	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	 test_cmp expect actual &&
-	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
-	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
-	 test $a = $b'
-test_expect_success \
-	'R: blob appears only once' \
-	'n=$(grep $a verify | wc -l) &&
-	 test 1 = $n'
+test_expect_success 'R: blob bigger than threshold' '
+	blobsize=$((2*1024*1024 + 53)) &&
+	test-genrandom bar $blobsize >expect &&
+	echo ONE | wc -l >expect.count &&
+
+	{
+		cat <<-INPUT_END &&
+		commit refs/heads/big-file
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		R - big file
+		COMMIT
+
+		M 644 inline big1
+		data $blobsize
+		INPUT_END
+
+		cat expect &&
+		cat <<-INPUT_END &&
+		M 644 inline big2
+		data $blobsize
+		INPUT_END
+
+		cat expect &&
+		echo
+	} >input &&
+
+	test_create_repo R &&
+	git --git-dir=R/.git fast-import --big-file-threshold=1 <input &&
+	(
+		for p in R/.git/objects/pack/*.pack
+		do
+			git verify-pack -v $p ||
+			exit
+		done
+	) >verify &&
+	git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
+	git --git-dir=R/.git rev-parse big-file:big1 >a &&
+	git --git-dir=R/.git rev-parse big-file:big2 >b &&
+	grep $(cat a) verify | wc -l >count &&
+
+	test_cmp expect actual &&
+	test_cmp a b &&
+	# blob only appears once
+	test_cmp expect.count count
+'
 
 test_done
-- 
1.7.2.3
