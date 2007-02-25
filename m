From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/8] Get rid of the dependency to GNU diff in the tests
Date: Sun, 25 Feb 2007 23:36:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252336390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRzI-0003s6-3e
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbXBYWg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXBYWg5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:36:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:42195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965178AbXBYWgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:36:55 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:36:53 -0000
X-Provags-ID: V01U2FsdGVkX18vU5x96MwvJzPKqs3gYRhXaod0+qL+BSVY1X6L+q
	jItA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40588>


Now that "git diff" handles stdin and relative paths outside the
working tree correctly, we can convert all instances of "diff -u"
to "git diff".

This commit is really the result of

$ perl -pi.bak -e 's/diff -u/git diff/' $(git grep -l "diff -u" t/)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/diff-lib.sh                      |    6 +++---
 t/t1000-read-tree-m-3way.sh        |    2 +-
 t/t1001-read-tree-m-2way.sh        |   26 +++++++++++++-------------
 t/t1002-read-tree-m-u-2way.sh      |    2 +-
 t/t1300-repo-config.sh             |    6 +++---
 t/t3001-ls-files-others-exclude.sh |    4 ++--
 t/t3002-ls-files-dashpath.sh       |   10 +++++-----
 t/t3100-ls-tree-restrict.sh        |    2 +-
 t/t3101-ls-tree-dirname.sh         |    2 +-
 t/t3300-funny-names.sh             |   30 +++++++++++++++---------------
 t/t3900-i18n-commit.sh             |    2 +-
 t/t4006-diff-mode.sh               |    2 +-
 t/t4013-diff-various.sh            |    2 +-
 t/t4015-diff-whitespace.sh         |   12 ++++++------
 t/t4016-diff-quote.sh              |    4 ++--
 t/t4100-apply-stat.sh              |   14 +++++++-------
 t/t4104-apply-boundary.sh          |    4 ++--
 t/t4115-apply-symlink.sh           |    4 ++--
 t/t4116-apply-reverse.sh           |    2 +-
 t/t4117-apply-reject.sh            |   12 ++++++------
 t/t4118-apply-empty-context.sh     |    6 +++---
 t/t4200-rerere.sh                  |    6 +++---
 t/t5400-send-pack.sh               |    2 +-
 t/t5401-update-hooks.sh            |    4 ++--
 t/t6023-merge-file.sh              |    8 ++++----
 t/t6024-recursive-merge.sh         |    4 ++--
 t/t6200-fmt-merge-msg.sh           |   10 +++++-----
 t/t9100-git-svn-basic.sh           |    6 +++---
 t/t9300-fast-import.sh             |   26 +++++++++++++-------------
 29 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index 745a1b0..4624fe6 100755
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -11,7 +11,7 @@ compare_diff_raw () {
 
     sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
     sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
 sanitize_diff_raw_z='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
@@ -23,7 +23,7 @@ compare_diff_raw_z () {
 
     tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
     tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
 compare_diff_patch () {
@@ -37,5 +37,5 @@ compare_diff_patch () {
 	/^[dis]*imilarity index [0-9]*%$/d
 	/^index [0-9a-f]*\.\.[0-9a-f]/d
     ' <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index d0af8c3..e26a36c 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -131,7 +131,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 check_result () {
     git-ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
-    diff -u expected current
+    git diff expected current
 }
 
 # This is done on an empty work directory, which is the normal
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 75e4c9a..030226b 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -33,7 +33,7 @@ compare_change () {
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
 	    "$1"
-	diff -u expected current
+	git diff expected current
 }
 
 check_cache_at () {
@@ -86,7 +86,7 @@ test_expect_success \
     'rm -f .git/index &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
-     diff -u M.out 1-3.out &&
+     git diff M.out 1-3.out &&
      check_cache_at bozbar dirty &&
      check_cache_at frotz dirty &&
      check_cache_at nitfol dirty'
@@ -101,7 +101,7 @@ test_expect_success \
      git-update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >4.out || return 1
-     diff -u M.out 4.out >4diff.out
+     git diff M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
@@ -115,7 +115,7 @@ test_expect_success \
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >5.out || return 1
-     diff -u M.out 5.out >5diff.out
+     git diff M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
@@ -127,7 +127,7 @@ test_expect_success \
      git-update-index --add frotz &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >6.out &&
-     diff -u M.out 6.out &&
+     git diff M.out 6.out &&
      check_cache_at frotz clean'
 
 test_expect_success \
@@ -140,7 +140,7 @@ test_expect_success \
      echo frotz frotz >frotz &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >7.out &&
-     diff -u M.out 7.out &&
+     git diff M.out 7.out &&
      check_cache_at frotz dirty'
 
 test_expect_success \
@@ -171,7 +171,7 @@ test_expect_success \
      git-update-index --add rezrov &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >10.out &&
-     diff -u M.out 10.out'
+     git diff M.out 10.out'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -216,7 +216,7 @@ test_expect_success \
      git-update-index --add nitfol &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >14.out || return 1
-     diff -u M.out 14.out >14diff.out
+     git diff M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
 
@@ -230,7 +230,7 @@ test_expect_success \
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >15.out || return 1
-     diff -u M.out 15.out >15diff.out
+     git diff M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
@@ -262,7 +262,7 @@ test_expect_success \
      git-update-index --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >18.out &&
-     diff -u M.out 18.out &&
+     git diff M.out 18.out &&
      check_cache_at bozbar clean'
 
 test_expect_success \
@@ -275,7 +275,7 @@ test_expect_success \
      echo gnusto gnusto >bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >19.out &&
-     diff -u M.out 19.out &&
+     git diff M.out 19.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -287,7 +287,7 @@ test_expect_success \
      git-update-index --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >20.out &&
-     diff -u M.out 20.out &&
+     git diff M.out 20.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -337,7 +337,7 @@ test_expect_success \
      git-update-index --add DF &&
      read_tree_twoway $treeDF $treeDFDF &&
      git-ls-files --stage >DFDFcheck.out &&
-     diff -u DFDF.out DFDFcheck.out &&
+     git diff DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF dirty &&
      :'
 
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index da3c813..87fe993 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -16,7 +16,7 @@ compare_change () {
 	sed >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
-	diff -u expected current
+	git diff expected current
 }
 
 check_cache_at () {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 49b5666..84a5939 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -368,12 +368,12 @@ cat > expect << EOF
 weird
 EOF
 
-test_expect_success "rename succeeded" "diff -u expect .git/config"
+test_expect_success "rename succeeded" "git diff expect .git/config"
 
 test_expect_failure "rename non-existing section" \
 	'git-config --rename-section branch."world domination" branch.drei'
 
-test_expect_success "rename succeeded" "diff -u expect .git/config"
+test_expect_success "rename succeeded" "git diff expect .git/config"
 
 test_expect_success "rename another section" \
 	'git-config --rename-section branch."1 234 blabl/a" branch.drei'
@@ -389,7 +389,7 @@ cat > expect << EOF
 weird
 EOF
 
-test_expect_success "rename succeeded" "diff -u expect .git/config"
+test_expect_success "rename succeeded" "git diff expect .git/config"
 
 test_expect_success numbers '
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 6979b7c..db7a847 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -65,7 +65,7 @@ test_expect_success \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     diff -u expect output'
+     git diff expect output'
 
 # Test \r\n (MSDOS-like systems)
 printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
@@ -77,6 +77,6 @@ test_expect_success \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     diff -u expect output'
+     git diff expect output'
 
 test_done
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index b42f138..cc8967d 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -23,7 +23,7 @@ test_expect_success \
 test_expect_success \
     'git-ls-files without path restriction.' \
     'git-ls-files --others >output &&
-     diff -u output - <<EOF
+     git diff output - <<EOF
 --
 -foo
 output
@@ -34,7 +34,7 @@ EOF
 test_expect_success \
     'git-ls-files with path restriction.' \
     'git-ls-files --others path0 >output &&
-	diff -u output - <<EOF
+	git diff output - <<EOF
 path0
 EOF
 '
@@ -42,7 +42,7 @@ EOF
 test_expect_success \
     'git-ls-files with path restriction with --.' \
     'git-ls-files --others -- path0 >output &&
-	diff -u output - <<EOF
+	git diff output - <<EOF
 path0
 EOF
 '
@@ -50,7 +50,7 @@ EOF
 test_expect_success \
     'git-ls-files with path restriction with -- --.' \
     'git-ls-files --others -- -- >output &&
-	diff -u output - <<EOF
+	git diff output - <<EOF
 --
 EOF
 '
@@ -58,7 +58,7 @@ EOF
 test_expect_success \
     'git-ls-files with no path restriction.' \
     'git-ls-files --others -- >output &&
-	diff -u output - <<EOF
+	git diff output - <<EOF
 --
 -foo
 output
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 2ec06d3..e107492 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -35,7 +35,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
-    diff -u expected check
+    git diff expected check
 }
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index d78deb1..087929a 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -43,7 +43,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
-    diff -u expected check
+    git diff expected check
 }
 
 test_expect_success \
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index c12270e..b5a1400 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -35,7 +35,7 @@ no-funny' >expected
 test_expect_success 'git-ls-files no-funny' \
 	'git-update-index --add "$p0" "$p2" &&
 	git-ls-files >current &&
-	diff -u expected current'
+	git diff expected current'
 
 t0=`git-write-tree`
 echo "$t0" >t0
@@ -48,14 +48,14 @@ EOF
 test_expect_success 'git-ls-files with-funny' \
 	'git-update-index --add "$p1" &&
 	git-ls-files >current &&
-	diff -u expected current'
+	git diff expected current'
 
 echo 'just space
 no-funny
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git-ls-files -z with-funny' \
 	'git-ls-files -z | tr \\0 \\012 >current &&
-	diff -u expected current'
+	git diff expected current'
 
 t1=`git-write-tree`
 echo "$t1" >t1
@@ -67,28 +67,28 @@ no-funny
 EOF
 test_expect_success 'git-ls-tree with funny' \
 	'git-ls-tree -r $t1 | sed -e "s/^[^	]*	//" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 cat > expected <<\EOF
 A	"tabs\t,\" (dq) and spaces"
 EOF
 test_expect_success 'git-diff-index with-funny' \
 	'git-diff-index --name-status $t0 >current &&
-	diff -u expected current'
+	git diff expected current'
 
 test_expect_success 'git-diff-tree with-funny' \
 	'git-diff-tree --name-status $t0 $t1 >current &&
-	diff -u expected current'
+	git diff expected current'
 
 echo 'A
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git-diff-index -z with-funny' \
 	'git-diff-index -z --name-status $t0 | tr \\0 \\012 >current &&
-	diff -u expected current'
+	git diff expected current'
 
 test_expect_success 'git-diff-tree -z with-funny' \
 	'git-diff-tree -z --name-status $t0 $t1 | tr \\0 \\012 >current &&
-	diff -u expected current'
+	git diff expected current'
 
 cat > expected <<\EOF
 CNUM	no-funny	"tabs\t,\" (dq) and spaces"
@@ -96,7 +96,7 @@ EOF
 test_expect_success 'git-diff-tree -C with-funny' \
 	'git-diff-tree -C --find-copies-harder --name-status \
 		$t0 $t1 | sed -e 's/^C[0-9]*/CNUM/' >current &&
-	diff -u expected current'
+	git diff expected current'
 
 cat > expected <<\EOF
 RNUM	no-funny	"tabs\t,\" (dq) and spaces"
@@ -105,7 +105,7 @@ test_expect_success 'git-diff-tree delete with-funny' \
 	'git-update-index --force-remove "$p0" &&
 	git-diff-index -M --name-status \
 		$t0 | sed -e 's/^R[0-9]*/RNUM/' >current &&
-	diff -u expected current'
+	git diff expected current'
 
 cat > expected <<\EOF
 diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
@@ -116,7 +116,7 @@ EOF
 test_expect_success 'git-diff-tree delete with-funny' \
 	'git-diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 chmod +x "$p1"
 cat > expected <<\EOF
@@ -130,7 +130,7 @@ EOF
 test_expect_success 'git-diff-tree delete with-funny' \
 	'git-diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 cat >expected <<\EOF
  "tabs\t,\" (dq) and spaces"
@@ -139,7 +139,7 @@ EOF
 test_expect_success 'git-diff-tree rename with-funny applied' \
 	'git-diff-index -M -p $t0 |
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 cat > expected <<\EOF
  no-funny
@@ -149,12 +149,12 @@ EOF
 test_expect_success 'git-diff-tree delete with-funny applied' \
 	'git-diff-index -p $t0 |
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 test_expect_success 'git-apply non-git diff' \
 	'git-diff-index -p $t0 |
 	 sed -ne "/^[-+@]/p" |
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 diff -u expected current'
+	 git diff expected current'
 
 test_done
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index e54fe0f..ffddb68 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -9,7 +9,7 @@ test_description='commit and log output encodings'
 
 compare_with () {
 	git-show -s $1 | sed -e '1,/^$/d' -e 's/^    //' -e '$d' >current &&
-	diff -u current "$2"
+	git diff current "$2"
 }
 
 test_expect_success setup '
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index ca342f4..e72c6fd 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -38,7 +38,7 @@ echo ":100644 100755 X X M	rezrov" >expected
 
 test_expect_success \
     'verify' \
-    'diff -u expected check'
+    'git diff expected check'
 
 test_done
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3d85cea..9f54af5 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -111,7 +111,7 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
-			diff -u "$expect" "$actual" &&
+			git diff "$expect" "$actual" &&
 			rm -f "$actual"
 		else
 			# this is to help developing new tests.
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index adf4993..930e209 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -43,13 +43,13 @@ index adf3937..6edc172 100644
 EOF
 
 git-diff > out
-test_expect_success "Ray's example without options" 'diff -u expect out'
+test_expect_success "Ray's example without options" 'git diff expect out'
 
 git-diff -w > out
-test_expect_success "Ray's example with -w" 'diff -u expect out'
+test_expect_success "Ray's example with -w" 'git diff expect out'
 
 git-diff -b > out
-test_expect_success "Ray's example with -b" 'diff -u expect out'
+test_expect_success "Ray's example with -b" 'git diff expect out'
 
 tr 'Q' '\015' << EOF > x
 whitespace at beginning
@@ -90,14 +90,14 @@ index d99af23..8b32fb5 100644
 +CR at end
 EOF
 git-diff > out
-test_expect_success 'another test, without options' 'diff -u expect out'
+test_expect_success 'another test, without options' 'git diff expect out'
 
 cat << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 EOF
 git-diff -w > out
-test_expect_success 'another test, with -w' 'diff -u expect out'
+test_expect_success 'another test, with -w' 'git diff expect out'
 
 tr 'Q' '\015' << EOF > expect
 diff --git a/x b/x
@@ -115,6 +115,6 @@ index d99af23..8b32fb5 100644
  CR at endQ
 EOF
 git-diff -b > out
-test_expect_success 'another test, with -b' 'diff -u expect out'
+test_expect_success 'another test, with -b' 'git diff expect out'
 
 test_done
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 2e7cd5f..5dbdc0c 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -49,7 +49,7 @@ cat >expect <<\EOF
 EOF
 test_expect_success 'git diff --summary -M HEAD' '
 	git diff --summary -M HEAD >actual &&
-	diff -u expect actual
+	git diff expect actual
 '
 
 cat >expect <<\EOF
@@ -64,7 +64,7 @@ cat >expect <<\EOF
 EOF
 test_expect_success 'git diff --stat -M HEAD' '
 	git diff --stat -M HEAD >actual &&
-	diff -u expect actual
+	git diff expect actual
 '
 
 test_done
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 6579f06..7b81c32 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -11,37 +11,37 @@ test_description='git-apply --stat --summary test.
 test_expect_success \
     'rename' \
     'git-apply --stat --summary <../t4100/t-apply-1.patch >current &&
-    diff -u ../t4100/t-apply-1.expect current'
+    git diff ../t4100/t-apply-1.expect current'
 
 test_expect_success \
     'copy' \
     'git-apply --stat --summary <../t4100/t-apply-2.patch >current &&
-    diff -u ../t4100/t-apply-2.expect current'
+    git diff ../t4100/t-apply-2.expect current'
 
 test_expect_success \
     'rewrite' \
     'git-apply --stat --summary <../t4100/t-apply-3.patch >current &&
-    diff -u ../t4100/t-apply-3.expect current'
+    git diff ../t4100/t-apply-3.expect current'
 
 test_expect_success \
     'mode' \
     'git-apply --stat --summary <../t4100/t-apply-4.patch >current &&
-    diff -u ../t4100/t-apply-4.expect current'
+    git diff ../t4100/t-apply-4.expect current'
 
 test_expect_success \
     'non git' \
     'git-apply --stat --summary <../t4100/t-apply-5.patch >current &&
-    diff -u ../t4100/t-apply-5.expect current'
+    git diff ../t4100/t-apply-5.expect current'
 
 test_expect_success \
     'non git' \
     'git-apply --stat --summary <../t4100/t-apply-6.patch >current &&
-    diff -u ../t4100/t-apply-6.expect current'
+    git diff ../t4100/t-apply-6.expect current'
 
 test_expect_success \
     'non git' \
     'git-apply --stat --summary <../t4100/t-apply-7.patch >current &&
-    diff -u ../t4100/t-apply-7.expect current'
+    git diff ../t4100/t-apply-7.expect current'
 
 test_done
 
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 2ff800c..a5fb3ea 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -90,7 +90,7 @@ do
 				cat '"$kind-patch.$with"'
 				(exit 1)
 			} &&
-			diff -u '"$kind"'-expect victim
+			git diff '"$kind"'-expect victim
 		'
 	done
 done
@@ -108,7 +108,7 @@ do
 			cat '"$kind-ng.without"'
 			(exit 1)
 		} &&
-		diff -u '"$kind"'-expect victim
+		git diff '"$kind"'-expect victim
 	'
 done
 
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index d5f2cfb..b947ed8 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -33,7 +33,7 @@ test_expect_success 'apply symlink patch' '
 	git checkout side &&
 	git apply patch &&
 	git diff-files -p >patched &&
-	diff -u patch patched
+	git diff patch patched
 
 '
 
@@ -42,7 +42,7 @@ test_expect_success 'apply --index symlink patch' '
 	git checkout -f side &&
 	git apply --index patch &&
 	git diff-index --cached -p HEAD >patched &&
-	diff -u patch patched
+	git diff patch patched
 
 '
 
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index aa2c869..2685b22 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -42,7 +42,7 @@ test_expect_success 'apply in reverse' '
 	git reset --hard second &&
 	git apply --reverse --binary --index patch &&
 	git diff >diff &&
-	diff -u /dev/null diff
+	git diff /dev/null diff
 
 '
 
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index b4de075..91931f0 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -54,7 +54,7 @@ test_expect_success 'apply without --reject should fail' '
 		exit 1
 	fi
 
-	diff -u file1 saved.file1
+	git diff file1 saved.file1
 '
 
 test_expect_success 'apply without --reject should fail' '
@@ -65,7 +65,7 @@ test_expect_success 'apply without --reject should fail' '
 		exit 1
 	fi
 
-	diff -u file1 saved.file1
+	git diff file1 saved.file1
 '
 
 test_expect_success 'apply with --reject should fail but update the file' '
@@ -79,7 +79,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 		exit 1
 	fi
 
-	diff -u file1 expected &&
+	git diff file1 expected &&
 
 	cat file1.rej &&
 
@@ -105,7 +105,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 		echo "file1 still exists?"
 		exit 1
 	}
-	diff -u file2 expected &&
+	git diff file2 expected &&
 
 	cat file2.rej &&
 
@@ -132,7 +132,7 @@ test_expect_success 'the same test with --verbose' '
 		echo "file1 still exists?"
 		exit 1
 	}
-	diff -u file2 expected &&
+	git diff file2 expected &&
 
 	cat file2.rej &&
 
@@ -151,7 +151,7 @@ test_expect_success 'apply cleanly with --verbose' '
 
 	git apply --verbose patch.1 &&
 
-	diff -u file1 clean
+	git diff file1 clean
 '
 
 test_done
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 7309422..690a182 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -37,7 +37,7 @@ test_expect_success 'apply --numstat' '
 		echo "0	1	file1" &&
 		echo "0	1	file2"
 	} >expect &&
-	diff -u expect actual
+	git diff expect actual
 
 '
 
@@ -47,8 +47,8 @@ test_expect_success 'apply --apply' '
 	cat file2.orig >file2 &&
 	git update-index file1 file2 &&
 	git apply --index diff.output &&
-	diff -u file1.mods file1 &&
-	diff -u file2.mods file2
+	git diff file1.mods file1 &&
+	git diff file2.mods file2
 '
 
 test_done
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index c571a1b..dc802f6 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -70,7 +70,7 @@ EOF
 
 git rerere diff > out
 
-test_expect_success 'rerere diff' 'diff -u expect out'
+test_expect_success 'rerere diff' 'git diff expect out'
 
 cat > expect << EOF
 a1
@@ -78,7 +78,7 @@ EOF
 
 git rerere status > out
 
-test_expect_success 'rerere status' 'diff -u expect out'
+test_expect_success 'rerere status' 'git diff expect out'
 
 test_expect_success 'commit succeeds' \
 	"git commit -q -a -m 'prefer first over second'"
@@ -94,7 +94,7 @@ test_expect_failure 'another conflicting merge' 'git pull . first'
 git show first:a1 | sed 's/To die: t/To die! T/' > expect
 test_expect_success 'rerere kicked in' "! grep ======= a1"
 
-test_expect_success 'rerere prefers first change' 'diff -u a1 expect'
+test_expect_success 'rerere prefers first change' 'git diff a1 expect'
 
 rm $rr/postimage
 echo "$sha1	a1" | tr '\012' '\0' > .git/rr-cache/MERGE_RR
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 7d93d0d..fc4a126 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -110,7 +110,7 @@ test_expect_success \
 	cd .. &&
 	git-update-ref refs/heads/master master^ &&
 	git-send-pack --force ./victim/.git/ master &&
-	! diff -u .git/refs/heads/master victim/.git/refs/heads/master
+	! git diff .git/refs/heads/master victim/.git/refs/heads/master
 '
 
 test_done
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 0514056..460c9fd 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -51,12 +51,12 @@ test_expect_success 'hooks ran' '
 
 test_expect_success 'update hook arguments' '
 	echo refs/heads/master $commit0 $commit1 |
-	diff -u - victim/.git/update.args
+	git diff - victim/.git/update.args
 '
 
 test_expect_success 'post-update hook arguments' '
 	echo refs/heads/master |
-	diff -u - victim/.git/post-update.args
+	git diff - victim/.git/post-update.args
 '
 
 test_expect_failure 'update hook stdin is /dev/null' '
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index f3cd3db..c76fccf 100644
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -63,7 +63,7 @@ test_expect_success "merge without conflict (missing LF at EOF)" \
 	"git-merge-file test2.txt orig.txt new2.txt"
 
 test_expect_success "merge result added missing LF" \
-	"diff -u test.txt test2.txt"
+	"git diff test.txt test2.txt"
 
 cp test.txt backup.txt
 test_expect_failure "merge with conflicts" \
@@ -86,7 +86,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
-test_expect_success "expected conflict markers" "diff -u test.txt expect.txt"
+test_expect_success "expected conflict markers" "git diff test.txt expect.txt"
 
 cp backup.txt test.txt
 test_expect_failure "merge with conflicts, using -L" \
@@ -110,7 +110,7 @@ virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
 test_expect_success "expected conflict markers, with -L" \
-	"diff -u test.txt expect.txt"
+	"git diff test.txt expect.txt"
 
 sed "s/ tu / TU /" < new1.txt > new5.txt
 test_expect_failure "conflict in removed tail" \
@@ -132,7 +132,7 @@ virga tua et baculus tuus ipsa me consolata sunt.
 >>>>>>> new5.txt
 EOF
 
-test_expect_success "expected conflict markers" "diff -u expect out"
+test_expect_success "expected conflict markers" "git diff expect out"
 
 test_done
 
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 31b9625..a398556 100644
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -70,7 +70,7 @@ G
 >>>>>>> G:a1
 EOF
 
-test_expect_success "result contains a conflict" "diff -u expect a1"
+test_expect_success "result contains a conflict" "git diff expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
@@ -79,6 +79,6 @@ cat > expect << EOF
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
 
-test_expect_success "virtual trees were processed" "diff -u expect out"
+test_expect_success "virtual trees were processed" "git diff expect out"
 
 test_done
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index ea14023..526d7d1 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -79,7 +79,7 @@ test_expect_success 'merge-msg test #1' '
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	diff -u actual expected
+	git diff actual expected
 '
 
 cat >expected <<\EOF
@@ -92,7 +92,7 @@ test_expect_success 'merge-msg test #2' '
 	git fetch ../trash left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	diff -u actual expected
+	git diff actual expected
 '
 
 cat >expected <<\EOF
@@ -115,7 +115,7 @@ test_expect_success 'merge-msg test #3' '
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	diff -u actual expected
+	git diff actual expected
 '
 
 cat >expected <<\EOF
@@ -145,7 +145,7 @@ test_expect_success 'merge-msg test #4' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	diff -u actual expected
+	git diff actual expected
 '
 
 test_expect_success 'merge-msg test #5' '
@@ -157,7 +157,7 @@ test_expect_success 'merge-msg test #5' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	diff -u actual expected
+	git diff actual expected
 '
 
 test_done
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 7dcfc7e..eb628fe 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -169,7 +169,7 @@ test_expect_success "$name" "
 	svn up '$SVN_TREE' &&
 	test -f '$SVN_TREE'/exec-2.sh &&
 	test ! -L '$SVN_TREE'/exec-2.sh &&
-	diff -u help $SVN_TREE/exec-2.sh"
+	git diff help $SVN_TREE/exec-2.sh"
 
 if test "$have_utf8" = t
 then
@@ -193,7 +193,7 @@ test_expect_success "$name" \
     "git-svn init $svnrepo && git-svn fetch &&
      git-rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git-rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
-     diff -u a b"
+     git diff a b"
 
 name='check imported tree checksums expected tree checksums'
 rm -f expected
@@ -211,7 +211,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-test_expect_success "$name" "diff -u a expected"
+test_expect_success "$name" "git diff a expected"
 
 test_expect_failure 'exit if remote refs are ambigious' "
         git-config --add svn-remote.svn.fetch \
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 970d683..2337d83 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -74,7 +74,7 @@ EOF
 test_expect_success \
 	'A: verify commit' \
 	'git-cat-file commit master | sed 1d >actual &&
-	diff -u expect actual'
+	git diff expect actual'
 
 cat >expect <<EOF
 100644 blob file2
@@ -84,22 +84,22 @@ EOF
 test_expect_success \
 	'A: verify tree' \
 	'git-cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 echo "$file2_data" >expect
 test_expect_success \
 	'A: verify file2' \
-	'git-cat-file blob master:file2 >actual && diff -u expect actual'
+	'git-cat-file blob master:file2 >actual && git diff expect actual'
 
 echo "$file3_data" >expect
 test_expect_success \
 	'A: verify file3' \
-	'git-cat-file blob master:file3 >actual && diff -u expect actual'
+	'git-cat-file blob master:file3 >actual && git diff expect actual'
 
 printf "$file4_data" >expect
 test_expect_success \
 	'A: verify file4' \
-	'git-cat-file blob master:file4 >actual && diff -u expect actual'
+	'git-cat-file blob master:file4 >actual && git diff expect actual'
 
 cat >expect <<EOF
 :2 `git-rev-parse --verify master:file2`
@@ -109,7 +109,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'A: verify marks output' \
-	'diff -u expect marks.out'
+	'git diff expect marks.out'
 
 ###
 ### series B
@@ -175,7 +175,7 @@ EOF
 test_expect_success \
 	'C: verify commit' \
 	'git-cat-file commit branch | sed 1d >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
@@ -232,13 +232,13 @@ echo "$file5_data" >expect
 test_expect_success \
 	'D: verify file5' \
 	'git-cat-file blob branch:newdir/interesting >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 echo "$file6_data" >expect
 test_expect_success \
 	'D: verify file6' \
 	'git-cat-file blob branch:newdir/exec.sh >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 ###
 ### series E
@@ -274,7 +274,7 @@ EOF
 test_expect_success \
 	'E: verify commit' \
 	'git-cat-file commit branch | sed 1,2d >actual &&
-	diff -u expect actual'
+	git diff expect actual'
 
 ###
 ### series F
@@ -327,7 +327,7 @@ EOF
 test_expect_success \
 	'F: verify other commit' \
 	'git-cat-file commit other >actual &&
-	diff -u expect actual'
+	git diff expect actual'
 
 ###
 ### series G
@@ -405,7 +405,7 @@ echo "$file5_data" >expect
 test_expect_success \
 	'H: verify file' \
 	'git-cat-file blob H:h/e/l/lo >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 ###
 ### series I
@@ -431,7 +431,7 @@ EOF
 test_expect_success \
 	'I: verify edge list' \
 	'sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	 diff -u expect actual'
+	 git diff expect actual'
 
 ###
 ### series J
-- 
1.5.0.1.788.g8ca52
