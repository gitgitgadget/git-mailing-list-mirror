Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7C4B1468
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751938; cv=none; b=unNCAIIlwxhHBuICewq398/ZaMhD+CARLIsbjB/sV9zRIPsyLZLySC2xAA6u7R7K9r5k+vVm2I5Zjc+lgEBgJ1fF99/hTJh2443HF+6R5fQ4AazMeCBkEguAHzTDHdTpmhviAUoY2VwhShCDYABKEWAywSHnU0copBL4a2kQKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751938; c=relaxed/simple;
	bh=4M9YDPqhrGzv+1fENFZfZnnuweT5zlyPbZOlasgKAXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKV1xvwgh4y4ahKWdAY3zbEI2zzRCjgKqDoorck9z3FKXJGLOr7Pe/crYpHfe4Owwf2yf04IM1+tJiUm+VXj55iXv0O9G5DgKFaFl5GKHx2GS5Y9qUFM51rVoWifnFuYtNI8YIPTIUnB0IT8WphIAi4SvYY+zo8wPcgLcUT/BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TrF/z7UV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MS4fSTxc; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TrF/z7UV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MS4fSTxc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id A5735130027A;
	Fri, 18 Sep 2026 13:18:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 18 Sep 2026 13:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789751934; x=
	1789755534; bh=PXYHuYjM3I0fE2HhcOkMG8GbCfPg0km7uut4dfpTTO0=; b=T
	rF/z7UVy2bFprhPr7GhNW53zDMFd/B0M+Ob8Nj2K0alrBP2RPPfPKqdiRsHnuhE8
	sch/O85yWDbtZhnnO0ZISvbgFxSdvxU4loqY1NkjIMto1MhKsXUWD7F+NYk21Vxo
	XQrioZteYpPhDR+WemSuCXPsaPggksWN734qLSprf3J9Lcy769eD87K404/VG7ye
	NDUnRk2VOpeR2de/89NvE0SKumq1d4E8Y3Rz9bUNiXAYVR+4MLCXD7X1rn74GQuZ
	voHoKVeIbwzrq08LSg5T7bqimF95HN80qu82dTLP52Bd2g8oQ1DVuNKyJYFesm1+
	82//glROBYRX7HZI1/ZlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789751934; x=1789755534; bh=P
	XYHuYjM3I0fE2HhcOkMG8GbCfPg0km7uut4dfpTTO0=; b=MS4fSTxcYCZ1BcBL0
	E/Pd2n1zH7dRNLkWFDgagaMhmUL4QKS2cQFFM/rQPZgYRqSLh3SS7v2GNwWFheFh
	QI1fp6CgOPlkRfmSu9ToR5ez/45GOE0NTWcZgbEKizuGQ4I9XklslX6RcXHmzpIz
	4NvvWcGnJn8D4RJ6WHF0gLnRXfSC2gDHsioD+FESo2+aaGL4w1ddgk0c+bxD3Ykd
	Or5H92QO329lHW0QbccYyQOtFnpjBC6NCLHfQnH+DWYrBuzb0PKTt+6mdG4inrfA
	87/K0NShO/iy+oMS1Hsa0RCgd+yGuSe+rpTz6ctvRY7XdffrW+t3Cj6z5DZQSWkH
	//ZUg==
X-ME-Sender: <xms:fXKtaq5l6am_bdaP_CLDBGxsBQz247sYNRMngF39xnseff97Ecjotg>
    <xme:fXKtap4-toIKrYUSFy75GXtDhrzNkeH7KYOzryoJVN6oYgecI5SZhfMxqWia8u4qS
    CJW3f8EM5lGJ4VMxVxapnf32GxhxPX8NX22XxNRJn7G2Ex0CPWgubQ>
X-ME-Received: <xmr:fXKtanGTy1UxB5Z5iFgZo5jBN4xiWOvcNTEGRiIJNdOR3A_N4or81TQXIQ-4MVtvdHjXPkmDhxOccPu_6YGLsy-YbTLLcTThP_JdRyHntdQqLg>
X-ME-Proxy-Cause: dmFkZTGmPTOGm99l02Hig6CYd3+V4H+UU3rFiUYklZHnfcmDoG4wv30i20PxVboKfblbPN
    ZwgIP0sCDCf84gSs5itRv9GE9Mcf0FatjYZ7fuVPe6IOtO1jLKcxeYyX1IYPBYXxRNUCed
    ySozJV4qlmC6Trzd38rUNy26VdSO0x0GoVINZRXOhizA8zklXQIBqQkh0HmAQKtdNtDXEx
    fK5WnLr8KMWbdhd5+U9kayg4o2SeOjsvH9nCWocQPEhu3bka4G2mgBiYLyw2w/u187dAqw
    lDn2quWrGavE6/YA6OfrcaX+/6jwG32BFkG6cXsw9WDV3v3Z28DMgOTngE6MGk9djFnwcN
    Gz7Yv6n7ZDQ/Rby3MdCUartURB2PxFV7z7tpHGk57OsqOfM6Khj5AKQWLgNyi5R0Vf6WQ1
    rYV07c62goZjQWwH9PC763z+/r7gtXUZ2+rN5NQRN1krmqgdKuOP5zlVFJAZ7cbThSu9Uw
    B/lxAkJ7VTAow9iRUjannsC0tI0bRkdjvw5EassUnPSEqCJ3eMC8XsnTJ1GpMLrTQWSU0u
    QOlSnhZESkrq5WCxGRCTuqpzleFvdYcJgeDSVFHC3scI+oHOW7uYUQ0E+IvEjjbKFQE9TS
    MpEql/UGX7pmWVX5ATvv3BVRxvH1f5CSrIW0AkrQ8rarrZDvN3D5128h7bYQ
X-ME-Proxy: <xmx:fXKtaiSWK4C6kSeluJ-CIM1t4STA8QM5lM6rDSSk0RTayRGo6_V_rQ>
    <xmx:fnKtagvDaUZDEnZfhuyy-6gHNfhW3oqNpmZcAwogkRl-P8RKF4QaGQ>
    <xmx:fnKtahzZ__XHt5SqrA2B71pqySW3e7FuVoZ8m7L5hafNYq4DvzfV9Q>
    <xmx:fnKtaq5LY-Rx0JT3aWvhZsj4565US8iEMMnCMvHZFXeRwUR4-1PsJg>
    <xmx:fnKtanUNuVZf8ANYsN_5WWFvvED6pSxe7gzW7jvpQ5iQSBMEs1UORNuI>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 13:18:53 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 1/3] t4001: modernize
Date: Fri, 18 Sep 2026 13:18:45 -0400
Message-ID: <20260918171847.2670739-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918171847.2670739-1-markchucarroll@fastmail.com>
References: <20260918171847.2670739-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4001 to the modern style.

* run everything inside of a test_expect_success block.
* write title line on the same line as test_expect_success,
  end that line with a single quote that opens the body of the test,
  and end the test with a single quote that closes the body.
* write expected output of a test to a file named "expect",
  and actual output to a file named "actual".
* write here-docs using "<<-" syntax, so that they're indented
  uniformly with the rest of the test.
* make test names more clearly reflect the functionality that
  they test.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4001-diff-rename.sh   | 94 ++++++++++++++++++----------------------
 t/t4009-diff-rename-4.sh | 54 +++++++++++------------
 2 files changed, 69 insertions(+), 79 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ad474100af..15567b52a0 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -8,6 +8,7 @@ test_description='Test rename detection in diff engine.'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
+
 test_expect_success 'setup' '
 	cat >path0 <<-\EOF &&
 	Line 1
@@ -26,7 +27,7 @@ test_expect_success 'setup' '
 	Line 14
 	Line 15
 	EOF
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	diff --git a/path0 b/path1
 	rename from path0
 	rename to path1
@@ -42,7 +43,7 @@ test_expect_success 'setup' '
 	 Line 13
 	 Line 14
 	EOF
-	cat >no-rename <<-\EOF
+	cat >expect-no-rename <<-\EOF &&
 	diff --git a/path0 b/path0
 	deleted file mode 100644
 	index fdbec44..0000000
@@ -86,47 +87,36 @@ test_expect_success 'setup' '
 	+Line 14
 	+Line 15
 	EOF
+    update-index --add a file. &&
+    git update-index --add path0
 '
 
-test_expect_success \
-    'update-index --add a file.' \
-    'git update-index --add path0'
-
-test_expect_success \
-    'write that tree.' \
-    'tree=$(git write-tree) && echo $tree'
-
-sed -e 's/line/Line/' <path0 >path1
-rm -f path0
-test_expect_success \
-    'renamed and edited the file.' \
-    'git update-index --add --remove path0 path1'
-
-test_expect_success \
-    'git diff-index -p -M after rename and editing.' \
-    'git diff-index -p -M $tree >current'
-
-
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'diff shows path0 renamed to path1 with edit.' '
+	initial_setup &&
+	tree=$(git write-tree) &&
+	sed -e "s/line/Line/" <path0 >path1 &&
+	rm -f path0 &&
+	git update-index --add --remove path0 path1 &&
+	git diff-index -p -M $tree >actual &&
+	compare_diff_patch actual expect
+'
 
-test_expect_success 'test diff.renames=true' '
-	git -c diff.renames=true diff --cached $tree >current &&
-	compare_diff_patch current expected
+test_expect_success 'with diff.renames=true, patch includes rename of path0 to path1' '
+	git -c diff.renames=true diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'test diff.renames=false' '
-	git -c diff.renames=false diff --cached $tree >current &&
-	compare_diff_patch current no-rename
+test_expect_success 'with diff.renames=false, patch does not include rename' '
+	git -c diff.renames=false diff --cached $tree >actual &&
+	compare_diff_patch actual expect-no-rename
 '
 
-test_expect_success 'test diff.renames unset' '
-	git diff --cached $tree >current &&
-	compare_diff_patch current expected
+test_expect_success 'with no setting for diff.renames, patch includes rename' '
+	git diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success 'diff rename favours same basenames over different ones' '
 	cp path1 another-path &&
 	git add another-path &&
 	git commit -m 1 &&
@@ -137,25 +127,25 @@ test_expect_success 'favour same basenames over different ones' '
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=true for git status' '
+test_expect_success 'with diff.renames=true, git status includes rename' '
 	git -c diff.renames=true status >out &&
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=false for git status' '
+test_expect_success 'with diff.renames=false, git status shows delete/add' '
 	git -c diff.renames=false status >out &&
 	test_grep ! "renamed: .*path1 -> subdir/path1" out &&
 	test_grep "new file: .*subdir/path1" out &&
 	test_grep "deleted: .*[^/]path1" out
 '
 
-test_expect_success 'favour same basenames even with minor differences' '
+test_expect_success 'rename logic favours same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status >out &&
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'two files with same basename and same content' '
+test_expect_success 'rename logic favors common path segments for files with the same basename and content' '
 	git reset --hard &&
 	mkdir -p dir/A dir/B &&
 	cp path1 dir/A/file &&
@@ -167,7 +157,7 @@ test_expect_success 'two files with same basename and same content' '
 	test_grep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
 
-test_expect_success 'setup for many rename source candidates' '
+test_expect_success 'rename with many candidates' '
 	git reset --hard &&
 	for i in 0 1 2 3 4 5 6 7 8 9;
 	do
@@ -177,14 +167,14 @@ test_expect_success 'setup for many rename source candidates' '
 		done
 	done &&
 	git add "path??" &&
-	test_tick &&
+	test_tick  &&
 	git commit -m "hundred" &&
 	(cat path1 && echo new) >new-path &&
 	echo old >>path1 &&
 	git add new-path path1 &&
 	git diff -l 4 -C -C --cached --name-status >actual 2>actual.err &&
 	sed -e "s/^\([CM]\)[0-9]*	/\1	/" actual >actual.munged &&
-	cat >expect <<-EOF &&
+	cat >expect <<-\EOF &&
 	C	path1	new-path
 	M	path1
 	EOF
@@ -192,7 +182,7 @@ test_expect_success 'setup for many rename source candidates' '
 	test_grep warning actual.err
 '
 
-test_expect_success 'rename pretty print with nothing in common' '
+test_expect_success 'pretty-print paths with nothing in common after rename' '
 	mkdir -p a/b/ &&
 	: >a/b/c &&
 	git add a/b/c &&
@@ -206,7 +196,7 @@ test_expect_success 'rename pretty print with nothing in common' '
 	test_grep " a/b/c => c/b/a " output
 '
 
-test_expect_success 'rename pretty print with common prefix' '
+test_expect_success 'pretty print paths with common prefix after rename' '
 	mkdir -p c/d &&
 	git mv c/b/a c/d/e &&
 	git commit -m "c/b/a -> c/d/e" &&
@@ -216,7 +206,7 @@ test_expect_success 'rename pretty print with common prefix' '
 	test_grep " c/{b/a => d/e} " output
 '
 
-test_expect_success 'rename pretty print with common suffix' '
+test_expect_success 'pretty prints paths with common suffix after rename' '
 	mkdir d &&
 	git mv c/d/e d/e &&
 	git commit -m "c/d/e -> d/e" &&
@@ -226,7 +216,7 @@ test_expect_success 'rename pretty print with common suffix' '
 	test_grep " {c/d => d}/e " output
 '
 
-test_expect_success 'rename pretty print with common prefix and suffix' '
+test_expect_success 'pretty prints paths with common prefix and suffix after rename' '
 	mkdir d/f &&
 	git mv d/e d/f/e &&
 	git commit -m "d/e -> d/f/e" &&
@@ -236,7 +226,7 @@ test_expect_success 'rename pretty print with common prefix and suffix' '
 	test_grep " d/{ => f}/e " output
 '
 
-test_expect_success 'rename pretty print common prefix and suffix overlap' '
+test_expect_success 'pretty prints paths with common prefix and suffix overlap after rename' '
 	mkdir d/f/f &&
 	git mv d/f/e d/f/f/e &&
 	git commit -m "d/f/e d/f/f/e" &&
@@ -261,7 +251,7 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	test_grep "myotherfile.*myfile" actual
 '
 
-test_expect_success 'basename similarity vs best similarity' '
+test_expect_success 'rename prefers basename similarity over best similarity' '
 	mkdir subdir &&
 	test_write_lines line1 line2 line3 line4 line5 \
 			 line6 line7 line8 line9 line10 >subdir/file.txt &&
@@ -278,14 +268,14 @@ test_expect_success 'basename similarity vs best similarity' '
 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
 	# subdir/file.txt is 88% similar to file.md, 78% similar to file.txt,
 	# but since same basenames are checked first...
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	A	file.md
 	R078	subdir/file.txt	file.txt
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
-test_expect_success 'last line matters too' '
+test_expect_success 'file similarity handles missing trailing newline.' '
 	{
 		test_write_lines a 0 1 2 3 4 5 6 7 8 9 &&
 		printf "git ignores final up to 63 characters if not newline terminated"
@@ -303,10 +293,10 @@ test_expect_success 'last line matters too' '
 	git commit -a -m "rename no-final-lf -> still-absent-final-lf" &&
 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
 	sed -e "s/^R[0-9]*	/R	/" actual >actual.munged &&
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	R	no-final-lf	still-absent-final-lf
 	EOF
-	test_cmp expected actual.munged
+	test_cmp expect actual.munged
 '
 
 test_done
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 59e71e3acd..198de5d039 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,23 +10,23 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'COPYING_test_data >COPYING &&
-     echo frotz >rezrov &&
+test_expect_success  'prepare reference tree' '
+    COPYING_test_data >COPYING &&
+    echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     orig=$(git hash-object COPYING) &&
     tree=$(git write-tree) &&
-    echo $tree'
+    echo $tree
+'
 
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+test_expect_success 'prepare work tree' '
+    sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+    sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
     rm -f COPYING &&
     c1=$(git hash-object COPYING.1) &&
     c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?'
+    git update-index --add --remove COPYING COPYING.?
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -44,16 +44,16 @@ COPYING
 COPYING.2
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#1)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
+test_expect_success 'prepare work tree again' '
+    mv COPYING.2 COPYING &&
+    git update-index --add --remove COPYING COPYING.1 COPYING.2
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -69,9 +69,9 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#2)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
@@ -80,10 +80,10 @@ test_expect_success \
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success \
-    'prepare work tree once again' \
-    'COPYING_test_data >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
+test_expect_success 'prepare work tree once again' '
+    COPYING_test_data >COPYING &&
+    git update-index --add --remove COPYING COPYING.1
+'
 
 git diff-index -z -C --find-copies-harder $tree >current
 cat >expected <<EOF
@@ -92,8 +92,8 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#3)' '
+    compare_diff_raw_z current expected
+'
 
 test_done
-- 
2.53.0

