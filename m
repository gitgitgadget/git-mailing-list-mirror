From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 05/21] t6030: generalize test to not rely on current implementation
Date: Sun, 10 Apr 2016 15:18:58 +0200
Message-ID: <1460294354-7031-6-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFHi-0008VL-KH
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbcDJNUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:50752 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbcDJNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lx5hl-1brPXE2lYH-016j5n; Sun, 10 Apr 2016 15:20:02
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:ze7fBOdC05Ds54ZJG6JBliofjNp0Oh4rFaJ5zl5Esm3KZjBSVP1
 CoXgZbFaMCSjPRues8d4De2nQoXw9Tn2lYtn10f7VGcXZrzRXBb2QJAPlZB++hXUow8qdrh
 CvGwGVPOoN28kX+2T9TyJa/6+wtujhKMTJoLJjxXrgC0CzMJ5JvjrCrRVgKDlHntL0Qir5J
 KwkndjhMZcNQkfPEq0LRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:26N7hVHD+kg=:lGogSeHEXgZCiemoRuKBJu
 2L/cSAGhNHVwz9hEeyOBk9qo94sa0sE6CpIK+XjgR5eVM6nOWBRxXu36QZbjufvHhIzQcvi2r
 /XysZCqaZH1pT7zPoufTZBWWB4Pr5VbumJyGtZUCyOGRCZ5zZxzFHxXB2YU4pi30tj5wAEwuz
 QYb1HtLAFKQYGjDy0KWxe2Xs8yE+A3wZlB2RREbS3e4zM6XRHqDQMJYF0mP3KHdNiTiweeG/e
 d0Hyko8s7SWbkto69gnsVzCkdA7X0Z7jGtIgfFZJmFAFaYlhb+nYDZW49+iAm53BqXYcZnDg+
 6gCSiFPoSbIEaOx5ZOujG1MjY0hF/KupJMMzT07MXHpyVI2TenmldIif9DFxTp/pdG9PKMf6n
 oJ8sNVSBp+ftV036JOr86Hr3fs4BwcS8PUrKif7/ghncLAsGpEVSwFg1TNcaL72pVoUHzNxEJ
 +PRasYQscT1IGFelXWwmruUXDb+mA6UkyI8flDP61EGxivnigHalXhmpkEC2/oEKCyOvNobMw
 y/UxIYEna2ecYRrj/pWI7iztO7OMuLdRhCskXBLEttMUND6T+OP5n5KAzF94qTMzlVIK7lx0j
 lMcfE5WuDbmlXr1FPwpchFuvldz9T+CfPS+wGdwyrgjL7RwNBetLKzd4UCIirQFJiMmajQqZN
 92CIFjftymtZMeiTs1IRpP0JBvblvy45lTpNDi/AUikUxfvAYLbGweTpdElZUUEuuNfICUZen
 zt9yqyUgFGeXaeg1NfKsTlZ6LbZ8zYNw7hyXZMtN44UAQZfS98ZsuVa5pPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291147>

The bisect algorithm allows different outcomes if, for example,
the number of commits between a good and a bad commit is even.
The current test relies on a specific behavior (for example,
the behavior of the halfway() implementation). By disabling
halfway(), some skip tests fail although the algorithm works.

This commit generalizes the test t6030 such that it works
even if the bisect algorithm uses its degree of freedom to
choose another commit.

While at it, fix some indentation issues: use tabs instead of
4 spaces.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t6030-bisect-porcelain.sh | 167 ++++++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 82 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 05bc639..645ccd9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -10,36 +10,34 @@ exec </dev/null
 
 add_line_into_file()
 {
-    _line=$1
-    _file=$2
+	_line=$1
+	_file=$2
 
-    if [ -f "$_file" ]; then
-        echo "$_line" >> $_file || return $?
-        MSG="Add <$_line> into <$_file>."
-    else
-        echo "$_line" > $_file || return $?
-        git add $_file || return $?
-        MSG="Create file <$_file> with <$_line> inside."
-    fi
+	if [ -f "$_file" ]; then
+		echo "$_line" >> $_file || return $?
+		MSG="Add <$_line> into <$_file>."
+	else
+		echo "$_line" > $_file || return $?
+		git add $_file || return $?
+		MSG="Create file <$_file> with <$_line> inside."
+	fi
 
-    test_tick
-    git commit --quiet -m "$MSG" $_file
+	test_tick
+	git commit --quiet -m "$MSG" $_file
 }
 
-HASH1=
-HASH2=
-HASH3=
-HASH4=
-
 test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
-     add_line_into_file "1: Hello World" hello &&
-     HASH1=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "2: A new day for git" hello &&
-     HASH2=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "3: Another new day for git" hello &&
-     HASH3=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "4: Ciao for now" hello &&
-     HASH4=$(git rev-parse --verify HEAD)
+	add_line_into_file "1: Hello World" hello &&
+	HASH1=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "2: A new day for git" hello &&
+	HASH2=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "3: Another new day for git" hello &&
+	HASH3=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "4: Ciao for now" hello &&
+	HASH4=$(git rev-parse --verify HEAD) &&
+	git checkout -b monday &&
+	add_line_into_file "5: Ok Monday, let us do it" hello &&
+	git checkout master
 '
 
 test_expect_success 'bisect starts with only one bad' '
@@ -84,9 +82,8 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 
 test_expect_success 'bisect reset: back in the master branch' '
 	git bisect reset &&
-	echo "* master" > branch.expect &&
 	git branch > branch.output &&
-	cmp branch.expect branch.output
+	grep "^* master" branch.output
 '
 
 test_expect_success 'bisect reset: back in another branch' '
@@ -95,16 +92,14 @@ test_expect_success 'bisect reset: back in another branch' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH3 &&
 	git bisect reset &&
-	echo "  master" > branch.expect &&
-	echo "* other" >> branch.expect &&
 	git branch > branch.output &&
-	cmp branch.expect branch.output
+	grep "^* other" branch.output
 '
 
 test_expect_success 'bisect reset when not bisecting' '
 	git bisect reset &&
 	git branch > branch.output &&
-	cmp branch.expect branch.output
+	grep "^* other" branch.output
 '
 
 test_expect_success 'bisect reset removes packed refs' '
@@ -180,14 +175,15 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	git checkout HEAD hello
 '
 
-# $HASH1 is good, $HASH4 is bad, we skip $HASH3
+# $HASH1 is good, monday is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
 test_expect_success 'bisect skip: successful result' '
 	test_when_finished git bisect reset &&
 	git bisect reset &&
-	git bisect start $HASH4 $HASH1 &&
+	git bisect start monday $HASH1 &&
 	git bisect skip &&
+	( test_cmp_rev HEAD $HASH2 || git bisect bad ) &&
 	git bisect bad > my_bisect_log.txt &&
 	grep "$HASH2 is the first bad commit" my_bisect_log.txt
 '
@@ -207,18 +203,22 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 	grep $HASH4 my_bisect_log.txt
 '
 
-# $HASH1 is good, $HASH4 is bad, we skip $HASH3
-# but $HASH2 is good,
+# $HASH1 is good, monday is bad, we skip $HASH3
+# but $HASH2 is good and $HASH4 is bad,
 # so we should not be able to tell the first bad commit
 # among $HASH3 and $HASH4
 test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	test_when_finished git bisect reset &&
-	git bisect start $HASH4 $HASH1 &&
+	git bisect start monday $HASH1 &&
 	git bisect skip &&
-	test_expect_code 2 git bisect good >my_bisect_log.txt &&
+	next="$(test_cmp_rev HEAD $HASH4 && echo bad || echo good)" &&
+	git bisect $next &&
+	next2="$(test "$next" = "good" && echo bad || echo good)" &&
+	test_expect_code 2 git bisect $next2 >my_bisect_log.txt &&
 	grep "first bad commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	! grep $HASH2 my_bisect_log.txt &&
+	! grep "$(git rev-parse monday)" my_bisect_log.txt &&
 	grep $HASH3 my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt
 '
@@ -244,36 +244,35 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 
 # We want to automatically find the commit that
 # introduced "Another" into hello.
-test_expect_success \
-    '"git bisect run" simple case' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Another hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start &&
-     git bisect good $HASH1 &&
-     git bisect bad $HASH4 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+test_expect_success '"git bisect run" simple case' '
+	echo "#"\!"/bin/sh" > test_script.sh &&
+	echo "grep Another hello > /dev/null" >> test_script.sh &&
+	echo "test \$? -ne 0" >> test_script.sh &&
+	chmod +x test_script.sh &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # We want to automatically find the commit that
 # introduced "Ciao" into hello.
-test_expect_success \
-    '"git bisect run" with more complex "git bisect start"' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Ciao hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start $HASH4 $HASH1 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+test_expect_success '"git bisect run" with more complex "git bisect start"' '
+	echo "#"\!"/bin/sh" > test_script.sh &&
+	echo "grep Ciao hello > /dev/null" >> test_script.sh &&
+	echo "test \$? -ne 0" >> test_script.sh &&
+	chmod +x test_script.sh &&
+	git bisect start $HASH4 $HASH1 &&
+	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
 # but $HASH4 is good,
 # so we should find $HASH5 as the first bad commit
-HASH5=
 test_expect_success 'bisect skip: add line and then a new test' '
 	add_line_into_file "5: Another new line." hello &&
 	HASH5=$(git rev-parse --verify HEAD) &&
@@ -291,7 +290,6 @@ test_expect_success 'bisect skip and bisect replay' '
 	git bisect reset
 '
 
-HASH6=
 test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&
 	HASH6=$(git rev-parse --verify HEAD) &&
@@ -315,7 +313,6 @@ test_expect_success 'bisect run & skip: cannot tell between 2' '
 	fi
 '
 
-HASH7=
 test_expect_success 'bisect run & skip: find first bad' '
 	git bisect reset &&
 	add_line_into_file "7: Should be the last line." hello &&
@@ -368,17 +365,19 @@ test_expect_success 'bisect errors out if bad and good are mistaken' '
 
 test_expect_success 'bisect does not create a "bisect" branch' '
 	git bisect reset &&
-	git bisect start $HASH7 $HASH1 &&
+	git bisect start $HASH6 $HASH1 &&
 	git branch bisect &&
-	test_cmp_rev HEAD $HASH4 &&
+	next="$(test_cmp_rev HEAD $HASH4 && echo good || echo bad)" &&
+	hash1="$(test "$next" = "good" && echo $HASH5 || echo $HASH2)" &&
+	hash2="$(test "$next" = "good" && echo $HASH6 || echo $HASH2)" &&
 	git branch -D bisect &&
-	git bisect good &&
+	git bisect $next &&
 	git branch bisect &&
-	test_cmp_rev HEAD $HASH6 &&
-	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
+	test_cmp_rev HEAD $hash1 &&
+	git bisect $next > my_bisect_log.txt &&
+	grep "$hash2 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset &&
-	test_cmp_rev bisect $HASH6 &&
+	test_cmp_rev bisect $hash1 &&
 	git branch -D bisect
 '
 
@@ -400,14 +399,15 @@ test_expect_success 'side branch creation' '
 '
 
 test_expect_success 'good merge base when good and bad are siblings' '
-	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
+	git bisect start "$HASH6" "$SIDE_HASH7" > my_bisect_log.txt &&
 	grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH6 my_bisect_log.txt &&
+	grep $HASH5 my_bisect_log.txt &&
 	git bisect reset
 '
+
 test_expect_success 'skipped merge base when good and bad are siblings' '
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
 	grep "merge base must be tested" my_bisect_log.txt &&
@@ -446,6 +446,9 @@ test_expect_success 'many merge bases creation' '
 	git checkout "$SIDE_HASH5" &&
 	git merge -m "merge HASH5 and SIDE_HASH5" "$HASH5" &&
 	A_HASH=$(git rev-parse --verify HEAD) &&
+	git checkout "$SIDE_HASH5" &&
+	git merge -m "merge HASH6 and SIDE_HASH5" "$HASH6" &&
+	A6_HASH=$(git rev-parse --verify HEAD) &&
 	git checkout side &&
 	git merge -m "merge HASH7 and SIDE_HASH7" "$HASH7" &&
 	B_HASH=$(git rev-parse --verify HEAD) &&
@@ -478,9 +481,8 @@ test_expect_success 'optimized merge base checks' '
 	grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
-	test_cmp_rev HEAD $HASH6 &&
-	git bisect bad > my_bisect_log3.txt &&
-	git bisect good "$A_HASH" > my_bisect_log4.txt &&
+	next="$(test_cmp_rev HEAD $HASH5 && echo $A_HASH || echo $A6_HASH)" &&
+	git bisect good "$next" > my_bisect_log4.txt &&
 	grep "merge base must be tested" my_bisect_log4.txt &&
 	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
 '
@@ -529,10 +531,10 @@ test_expect_success 'restricting bisection on one dir' '
 test_expect_success 'restricting bisection on one dir and a file' '
 	git bisect reset &&
 	git bisect start HEAD $HASH1 -- dir1 hello &&
+	( test_cmp_rev HEAD $HASH6 && git bisect skip || : ) &&
 	test_cmp_rev HEAD "$PARA_HASH4" &&
 	git bisect bad &&
-	test_cmp_rev HEAD $HASH3 &&
-	git bisect good &&
+	( test_cmp_rev HEAD $HASH3 && git bisect good || : ) &&
 	test_cmp_rev HEAD $HASH4 &&
 	git bisect good &&
 	test_cmp_rev HEAD "$PARA_HASH1" &&
@@ -542,9 +544,9 @@ test_expect_success 'restricting bisection on one dir and a file' '
 
 test_expect_success 'skipping away from skipped commit' '
 	git bisect start $PARA_HASH7 $HASH1 &&
-	test_cmp_rev HEAD "$PARA_HASH4" &&
+	test_cmp_rev HEAD $PARA_HASH4 $HASH7 &&
 	git bisect skip &&
-	test_cmp_rev HEAD $HASH7 &&
+	test_cmp_rev HEAD $HASH7 $PARA_HASH4 &&
 	git bisect skip &&
 	test_cmp_rev HEAD "$PARA_HASH3"
 '
@@ -621,7 +623,7 @@ EOF
 
 test_expect_success 'bisect fails if tree is broken on start commit' '
 	git bisect reset &&
-	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
+	test_must_fail git bisect start BROKEN_HASH8 BROKEN_HASH4 2>error.txt &&
 	test_cmp expected.missing-tree.default error.txt
 '
 
@@ -635,7 +637,7 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 
 test_expect_success 'bisect: --no-checkout - start commit bad' '
 	git bisect reset &&
-	git bisect start BROKEN_HASH7 BROKEN_HASH4 --no-checkout &&
+	git bisect start BROKEN_HASH8 BROKEN_HASH4 --no-checkout &&
 	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
 	git bisect reset
 '
@@ -672,9 +674,10 @@ test_expect_success 'bisect: --no-checkout - target in breakage' '
 test_expect_success 'bisect: --no-checkout - target after breakage' '
 	git bisect reset &&
 	git bisect start broken BROKEN_HASH4 --no-checkout &&
+	( test_cmp_rev BISECT_HEAD BROKEN_HASH6 || git bisect good BISECT_HEAD ) &&
 	test_cmp_rev BISECT_HEAD BROKEN_HASH6 &&
 	git bisect good BISECT_HEAD &&
-	test_cmp_rev BISECT_HEAD BROKEN_HASH8 &&
+	test_cmp_rev BISECT_HEAD BROKEN_HASH8 BROKEN_HASH7 &&
 	git bisect good BISECT_HEAD &&
 	test_cmp_rev bisect/bad BROKEN_HASH9 &&
 	git bisect reset
@@ -738,7 +741,7 @@ test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
 	git bisect start HEAD $HASH1 &&
 	git bisect good HEAD &&
 	git bisect bad HEAD &&
-	test_cmp_rev HEAD $HASH6 &&
+	test_cmp_rev HEAD $HASH6 $PARA_HASH1 &&
 	git bisect reset
 '
 
-- 
2.8.1.137.g522756c
