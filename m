From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 8/8] convert remaining users of "cmp" to "git diff"
Date: Sun, 25 Feb 2007 23:38:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252337210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLS0V-0004S3-6Z
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbXBYWiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbXBYWiM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:38:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:39763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965180AbXBYWiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:38:09 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:38:07 -0000
X-Provags-ID: V01U2FsdGVkX1+IV7gyOlmIS9TnwvbwsqO1nBD9JGR9lrmKasAXcz
	CsNw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40589>


This is really

$ perl -pi.bak -e \
  "s/(^\s*|'|\"|^\s*if |&&\s*)cmp /\1git diff /" t/*.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	BTW all tests pass with this series...

 t/t1002-read-tree-m-u-2way.sh    |   32 +++++++++++++-------------
 t/t1003-read-tree-prefix.sh      |    2 +-
 t/t1020-subdirectory.sh          |   16 ++++++------
 t/t1200-tutorial.sh              |   22 +++++++++---------
 t/t1300-repo-config.sh           |   46 +++++++++++++++++++-------------------
 t/t2101-update-index-reupdate.sh |   12 +++++-----
 t/t3300-funny-names.sh           |    2 +-
 t/t4012-diff-binary.sh           |    4 +-
 t/t4109-apply-multifrag.sh       |    6 ++--
 t/t4110-apply-scan.sh            |    2 +-
 t/t5300-pack-object.sh           |   12 +++++-----
 t/t5400-send-pack.sh             |    4 +-
 t/t6021-merge-criss-cross.sh     |    2 +-
 t/t9101-git-svn-props.sh         |    4 +-
 t/t9105-git-svn-commit-diff.sh   |    4 +-
 t/t9107-git-svn-migrate.sh       |    2 +-
 t/t9108-git-svn-glob.sh          |    4 +-
 17 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 87fe993..2a70ee9 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -59,9 +59,9 @@ test_expect_success \
      git-read-tree --reset -u $treeH &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
-     cmp M.out 1-3.out &&
+     git diff M.out 1-3.out &&
      sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     git diff M.sum actual3.sum &&
      check_cache_at bozbar clean &&
      check_cache_at frotz clean &&
      check_cache_at nitfol clean'
@@ -79,7 +79,7 @@ test_expect_success \
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
      sum bozbar frotz nitfol >actual4.sum &&
-     cmp M.sum actual4.sum &&
+     git diff M.sum actual4.sum &&
      echo yomin >yomin1 &&
      diff yomin yomin1 &&
      rm -f yomin1'
@@ -98,7 +98,7 @@ test_expect_success \
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sum bozbar frotz nitfol >actual5.sum &&
-     cmp M.sum actual5.sum &&
+     git diff M.sum actual5.sum &&
      : dirty index should have prevented -u from checking it out. &&
      echo yomin yomin >yomin1 &&
      diff yomin yomin1 &&
@@ -115,7 +115,7 @@ test_expect_success \
      diff -U0 M.out 6.out &&
      check_cache_at frotz clean &&
      sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     git diff M.sum actual3.sum &&
      echo frotz >frotz1 &&
      diff frotz frotz1 &&
      rm -f frotz1'
@@ -132,7 +132,7 @@ test_expect_success \
      diff -U0 M.out 7.out &&
      check_cache_at frotz dirty &&
      sum bozbar frotz nitfol >actual7.sum &&
-     if cmp M.sum actual7.sum; then false; else :; fi &&
+     if git diff M.sum actual7.sum; then false; else :; fi &&
      : dirty index should have prevented -u from checking it out. &&
      echo frotz frotz >frotz1 &&
      diff frotz frotz1 &&
@@ -163,9 +163,9 @@ test_expect_success \
      git-update-index --add rezrov &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >10.out &&
-     cmp M.out 10.out &&
+     git diff M.out 10.out &&
      sum bozbar frotz nitfol >actual10.sum &&
-     cmp M.sum actual10.sum'
+     git diff M.sum actual10.sum'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -210,9 +210,9 @@ test_expect_success \
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
-     cmp expected14.sum actual14.sum &&
+     git diff expected14.sum actual14.sum &&
      sum bozbar frotz nitfol >actual14a.sum &&
-     if cmp M.sum actual14a.sum; then false; else :; fi &&
+     if git diff M.sum actual14a.sum; then false; else :; fi &&
      check_cache_at nitfol clean &&
      echo nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
@@ -232,9 +232,9 @@ test_expect_success \
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
      grep -v nitfol M.sum > expected15.sum &&
-     cmp expected15.sum actual15.sum &&
+     git diff expected15.sum actual15.sum &&
      sum bozbar frotz nitfol >actual15a.sum &&
-     if cmp M.sum actual15a.sum; then false; else :; fi &&
+     if git diff M.sum actual15a.sum; then false; else :; fi &&
      echo nitfol nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
      rm -f nitfol1'
@@ -267,7 +267,7 @@ test_expect_success \
      diff -U0 M.out 18.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual18.sum &&
-     cmp M.sum actual18.sum'
+     git diff M.sum actual18.sum'
 
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
@@ -282,9 +282,9 @@ test_expect_success \
      check_cache_at bozbar dirty &&
      sum frotz nitfol >actual19.sum &&
      grep -v bozbar  M.sum > expected19.sum &&
-     cmp expected19.sum actual19.sum &&
+     git diff expected19.sum actual19.sum &&
      sum bozbar frotz nitfol >actual19a.sum &&
-     if cmp M.sum actual19a.sum; then false; else :; fi &&
+     if git diff M.sum actual19a.sum; then false; else :; fi &&
      echo gnusto gnusto >bozbar1 &&
      diff bozbar bozbar1 &&
      rm -f bozbar1'
@@ -300,7 +300,7 @@ test_expect_success \
      diff -U0 M.out 20.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual20.sum &&
-     cmp M.sum actual20.sum'
+     git diff M.sum actual20.sum'
 
 test_expect_success \
     '21 - no local change, dirty cache.' \
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index 48ab117..4029f57 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -21,7 +21,7 @@ two/one' >expect
 test_expect_success 'read-tree --prefix' '
 	git-read-tree --prefix=two/ $tree &&
 	git-ls-files >actual &&
-	cmp expect actual
+	git diff expect actual
 '
 
 test_done
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 1e8f9e5..22588bb 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -46,10 +46,10 @@ test_expect_success 'cat-file' '
 	two=`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
 	echo "$two" &&
 	git-cat-file -p "$two" >actual &&
-	cmp dir/two actual &&
+	git diff dir/two actual &&
 	cd dir &&
 	git-cat-file -p "$two" >actual &&
-	cmp two actual
+	git diff two actual
 '
 rm -f actual dir/actual
 
@@ -86,10 +86,10 @@ test_expect_success 'write-tree' '
 test_expect_success 'checkout-index' '
 	cd $HERE &&
 	git-checkout-index -f -u one &&
-	cmp one original.one &&
+	git diff one original.one &&
 	cd dir &&
 	git-checkout-index -f -u two &&
-	cmp two ../original.two
+	git diff two ../original.two
 '
 
 test_expect_success 'read-tree' '
@@ -97,13 +97,13 @@ test_expect_success 'read-tree' '
 	rm -f one dir/two &&
 	tree=`git-write-tree` &&
 	git-read-tree --reset -u "$tree" &&
-	cmp one original.one &&
-	cmp dir/two original.two &&
+	git diff one original.one &&
+	git diff dir/two original.two &&
 	cd dir &&
 	rm -f two &&
 	git-read-tree --reset -u "$tree" &&
-	cmp two ../original.two &&
-	cmp ../one ../original.one
+	git diff two ../original.two &&
+	git diff ../one ../original.one
 '
 
 test_expect_success 'no file/rev ambiguity check inside .git' '
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index ca2c30f..a3c2650 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -27,9 +27,9 @@ index 557db03..263414f 100644
 +It's a new day for git
 EOF
 git-diff-files -p > diff.output
-test_expect_success 'git-diff-files -p' 'cmp diff.expect diff.output'
+test_expect_success 'git-diff-files -p' 'git diff diff.expect diff.output'
 git diff > diff.output
-test_expect_success 'git diff' 'cmp diff.expect diff.output'
+test_expect_success 'git diff' 'git diff diff.expect diff.output'
 
 tree=$(git-write-tree 2>/dev/null)
 
@@ -38,10 +38,10 @@ test_expect_success 'tree' "test 8988da15d077d4829fc51d8544c097def6644dbb = $tre
 output="$(echo "Initial commit" | git-commit-tree $(git-write-tree) 2>&1 > .git/refs/heads/master)"
 
 git-diff-index -p HEAD > diff.output
-test_expect_success 'git-diff-index -p HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git-diff-index -p HEAD' 'git diff diff.expect diff.output'
 
 git diff HEAD > diff.output
-test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git diff HEAD' 'git diff diff.expect diff.output'
 
 #rm hello
 #test_expect_success 'git-read-tree --reset HEAD' "git-read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git-update-index --refresh)\""
@@ -73,15 +73,15 @@ git-whatchanged -p --root | \
 	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
 		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
 > whatchanged.output
-test_expect_success 'git-whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
+test_expect_success 'git-whatchanged -p --root' 'git diff whatchanged.expect whatchanged.output'
 
 git tag my-first-tag
-test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
+test_expect_success 'git tag my-first-tag' 'git diff .git/refs/heads/master .git/refs/tags/my-first-tag'
 
 # TODO: test git-clone
 
 git checkout -b mybranch
-test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
+test_expect_success 'git checkout -b mybranch' 'git diff .git/refs/heads/master .git/refs/heads/mybranch'
 
 cat > branch.expect <<EOF
   master
@@ -89,7 +89,7 @@ cat > branch.expect <<EOF
 EOF
 
 git branch > branch.output
-test_expect_success 'git branch' 'cmp branch.expect branch.output'
+test_expect_success 'git branch' 'git diff branch.expect branch.output'
 
 git checkout mybranch
 echo "Work, work, work" >>hello
@@ -125,7 +125,7 @@ cat > show-branch.expect << EOF
 EOF
 
 git show-branch --topo-order master mybranch > show-branch.output
-test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
+test_expect_success 'git show-branch' 'git diff show-branch.expect show-branch.output'
 
 git checkout mybranch
 
@@ -138,7 +138,7 @@ EOF
 
 git merge -s "Merge upstream changes." master | \
 	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" >resolve.output
-test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
+test_expect_success 'git resolve' 'git diff resolve.expect resolve.output'
 
 cat > show-branch2.expect << EOF
 ! [master] Merged "mybranch" changes.
@@ -148,7 +148,7 @@ cat > show-branch2.expect << EOF
 EOF
 
 git show-branch --topo-order master mybranch > show-branch2.output
-test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
+test_expect_success 'git show-branch' 'git diff show-branch2.expect show-branch2.output'
 
 # TODO: test git fetch
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 84a5939..3753e9f 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -16,7 +16,7 @@ cat > expect << EOF
 	penguin = little blue
 EOF
 
-test_expect_success 'initial' 'cmp .git/config expect'
+test_expect_success 'initial' 'git diff .git/config expect'
 
 git-config Core.Movie BadPhysics
 
@@ -26,7 +26,7 @@ cat > expect << EOF
 	Movie = BadPhysics
 EOF
 
-test_expect_success 'mixed case' 'cmp .git/config expect'
+test_expect_success 'mixed case' 'git diff .git/config expect'
 
 git-config Cores.WhatEver Second
 
@@ -38,7 +38,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'similar section' 'cmp .git/config expect'
+test_expect_success 'similar section' 'git diff .git/config expect'
 
 git-config CORE.UPPERCASE true
 
@@ -51,7 +51,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'similar section' 'cmp .git/config expect'
+test_expect_success 'similar section' 'git diff .git/config expect'
 
 test_expect_success 'replace with non-match' \
 	'git-config core.penguin kingpin !blue'
@@ -69,7 +69,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'non-match result' 'cmp .git/config expect'
+test_expect_success 'non-match result' 'git diff .git/config expect'
 
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
@@ -97,7 +97,7 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
+test_expect_success 'multiple unset is correct' 'git diff .git/config expect'
 
 mv .git/config2 .git/config
 
@@ -114,7 +114,7 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'all replaced' 'cmp .git/config expect'
+test_expect_success 'all replaced' 'git diff .git/config expect'
 
 git-config beta.haha alpha
 
@@ -128,7 +128,7 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'really mean test' 'cmp .git/config expect'
+test_expect_success 'really mean test' 'git diff .git/config expect'
 
 git-config nextsection.nonewline wow
 
@@ -143,7 +143,7 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow
 EOF
 
-test_expect_success 'really really mean test' 'cmp .git/config expect'
+test_expect_success 'really really mean test' 'git diff .git/config expect'
 
 test_expect_success 'get value' 'test alpha = $(git-config beta.haha)'
 git-config --unset beta.haha
@@ -158,7 +158,7 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow
 EOF
 
-test_expect_success 'unset' 'cmp .git/config expect'
+test_expect_success 'unset' 'git diff .git/config expect'
 
 git-config nextsection.NoNewLine "wow2 for me" "for me$"
 
@@ -173,7 +173,7 @@ noIndent= sillyValue ; 'nother silly comment
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar' 'cmp .git/config expect'
+test_expect_success 'multivar' 'git diff .git/config expect'
 
 test_expect_success 'non-match' \
 	'git-config --get nextsection.nonewline !for'
@@ -200,7 +200,7 @@ noIndent= sillyValue ; 'nother silly comment
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar replace' 'cmp .git/config expect'
+test_expect_success 'multivar replace' 'git diff .git/config expect'
 
 test_expect_failure 'ambiguous value' 'git-config nextsection.nonewline'
 
@@ -222,7 +222,7 @@ noIndent= sillyValue ; 'nother silly comment
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar unset' 'cmp .git/config expect'
+test_expect_success 'multivar unset' 'git diff .git/config expect'
 
 test_expect_failure 'invalid key' 'git-config inval.2key blabla'
 
@@ -245,7 +245,7 @@ noIndent= sillyValue ; 'nother silly comment
 	Alpha = beta
 EOF
 
-test_expect_success 'hierarchical section value' 'cmp .git/config expect'
+test_expect_success 'hierarchical section value' 'git diff .git/config expect'
 
 cat > expect << EOF
 beta.noindent=sillyValue
@@ -255,7 +255,7 @@ version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' \
-	'git-config --list > output && cmp output expect'
+	'git-config --list > output && git diff output expect'
 
 cat > expect << EOF
 beta.noindent sillyValue
@@ -263,7 +263,7 @@ nextsection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' \
-	'git-config --get-regexp in > output && cmp output expect'
+	'git-config --get-regexp in > output && git diff output expect'
 
 git-config --add nextsection.nonewline "wow4 for you"
 
@@ -273,7 +273,7 @@ wow4 for you
 EOF
 
 test_expect_success '--add' \
-	'git-config --get-all nextsection.nonewline > output && cmp output expect'
+	'git-config --get-all nextsection.nonewline > output && git diff output expect'
 
 cat > .git/config << EOF
 [novalue]
@@ -302,7 +302,7 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new section is partial match of another' 'cmp .git/config expect'
+test_expect_success 'new section is partial match of another' 'git diff .git/config expect'
 
 git-config b.x y
 git-config a.b c
@@ -317,7 +317,7 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
+test_expect_success 'new variable inserts into proper section' 'git diff .git/config expect'
 
 cat > other-config << EOF
 [ein]
@@ -330,7 +330,7 @@ EOF
 
 GIT_CONFIG=other-config git-config -l > output
 
-test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
+test_expect_success 'alternative GIT_CONFIG' 'git diff output expect'
 
 GIT_CONFIG=other-config git-config anwohner.park ausweis
 
@@ -341,7 +341,7 @@ cat > expect << EOF
 	park = ausweis
 EOF
 
-test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-config expect'
+test_expect_success '--set in alternative GIT_CONFIG' 'git diff other-config expect'
 
 cat > .git/config << EOF
 # Hallo
@@ -416,7 +416,7 @@ cat > expect << EOF
 	hash = "test#test"
 EOF
 
-test_expect_success 'quoting' 'cmp .git/config expect'
+test_expect_success 'quoting' 'git diff .git/config expect'
 
 test_expect_failure 'key with newline' 'git config key.with\\\
 newline 123'
@@ -442,7 +442,7 @@ EOF
 
 git config --list > result
 
-test_expect_success 'value continued on next line' 'cmp result expect'
+test_expect_success 'value continued on next line' 'git diff result expect'
 
 test_done
 
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index a78ea7f..723a682 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -17,7 +17,7 @@ test_expect_success 'update-index --add' \
 	 echo goodbye people >file2 &&
 	 git-update-index --add file1 file2 &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 git diff current expected'
 
 test_expect_success 'update-index --again' \
 	'rm -f file1 &&
@@ -30,7 +30,7 @@ test_expect_success 'update-index --again' \
 		echo happy - failed as expected
 	fi &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 git diff current expected'
 
 cat > expected <<\EOF
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
@@ -38,7 +38,7 @@ EOF
 test_expect_success 'update-index --remove --again' \
 	'git-update-index --remove --again &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 git diff current expected'
 
 test_expect_success 'first commit' 'git-commit -m initial'
 
@@ -55,7 +55,7 @@ test_expect_success 'update-index again' \
 	echo happy >dir1/file3 &&
 	git-update-index --again &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	git diff current expected'
 
 cat > expected <<\EOF
 100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
@@ -68,7 +68,7 @@ test_expect_success 'update-index --update from subdir' \
 	git-update-index --again &&
 	cd .. &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	git diff current expected'
 
 cat > expected <<\EOF
 100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
@@ -79,6 +79,6 @@ test_expect_success 'update-index --update with pathspec' \
 	cat file2 >dir1/file3 &&
 	git-update-index --again dir1/ &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	git diff current expected'
 
 test_done
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index b5a1400..5913152 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -24,7 +24,7 @@ EOF
 cat >"$p1" "$p0"
 echo 'Foo Bar Baz' >"$p2"
 
-test -f "$p1" && cmp "$p0" "$p1" || {
+test -f "$p1" && git diff "$p0" "$p1" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
 	say 'Your filesystem does not allow tabs in filenames, test skipped.'
 	test_done
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 323606c..c5f530f 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -25,11 +25,11 @@ cat > expected <<\EOF
 EOF
 test_expect_success 'diff without --binary' \
 	'git-diff | git-apply --stat --summary >current &&
-	 cmp current expected'
+	 git diff current expected'
 
 test_expect_success 'diff with --binary' \
 	'git-diff --binary | git-apply --stat --summary >current &&
-	 cmp current expected'
+	 git diff current expected'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index 5988e1a..180febc 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -146,7 +146,7 @@ test_expect_success "S = patch (1)" \
     'cat patch1.patch patch2.patch | patch -p1'
 
 test_expect_success "S = cmp (1)" \
-    'cmp main.c.git main.c'
+    'git diff main.c.git main.c'
 
 rm -f main.c main.c.git
 
@@ -158,7 +158,7 @@ test_expect_success "S = patch (2)" \
     'cat patch1.patch patch2.patch patch3.patch | patch -p1'
 
 test_expect_success "S = cmp (2)" \
-    'cmp main.c.git main.c'
+    'git diff main.c.git main.c'
 
 rm -f main.c main.c.git
 
@@ -170,7 +170,7 @@ test_expect_success "S = patch (3)" \
     'cat patch1.patch patch4.patch | patch -p1'
 
 test_expect_success "S = cmp (3)" \
-    'cmp main.c.git main.c'
+    'git diff main.c.git main.c'
 
 test_done
 
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index 005f744..ec00ed6 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -95,7 +95,7 @@ test_expect_success "S = patch scan" \
 mv new.txt patch.txt
 
 test_expect_success "S = cmp" \
-    'cmp apply.txt patch.txt'
+    'git diff apply.txt patch.txt'
 
 test_done
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index f511547..522d7b2 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -56,7 +56,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+         git diff $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -86,7 +86,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+         git diff $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -182,17 +182,17 @@ test_expect_success \
     'build pack index for an existing pack' \
     'cp test-1-${packname_1}.pack test-3.pack &&
      git-index-pack -o tmp.idx test-3.pack &&
-     cmp tmp.idx test-1-${packname_1}.idx &&
+     git diff tmp.idx test-1-${packname_1}.idx &&
 
      git-index-pack test-3.pack &&
-     cmp test-3.idx test-1-${packname_1}.idx &&
+     git diff test-3.idx test-1-${packname_1}.idx &&
 
      cp test-2-${packname_2}.pack test-3.pack &&
      git-index-pack -o tmp.idx test-2-${packname_2}.pack &&
-     cmp tmp.idx test-2-${packname_2}.idx &&
+     git diff tmp.idx test-2-${packname_2}.idx &&
 
      git-index-pack test-3.pack &&
-     cmp test-3.idx test-2-${packname_2}.idx &&
+     git diff test-3.idx test-2-${packname_2}.idx &&
 
      :'
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index fc4a126..03c2692 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -77,7 +77,7 @@ test_expect_success \
 		echo >&2 Thanks, it correctly failed.
 		true
 	fi &&
-	if cmp victim/.git/refs/heads/master .git/refs/heads/master
+	if git diff victim/.git/refs/heads/master .git/refs/heads/master
 	then
 		# should have been left as it was!
 		false
@@ -86,7 +86,7 @@ test_expect_success \
 	fi &&
 	# this should update
 	git-send-pack --force ./victim/.git/ master &&
-	cmp victim/.git/refs/heads/master .git/refs/heads/master
+	git diff victim/.git/refs/heads/master .git/refs/heads/master
 '
 
 test_expect_success \
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 499cafb..c9d43dd 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -87,6 +87,6 @@ cat > file-expect <<EOF
 9
 EOF
 
-test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
+test_expect_success 'Criss-cross merge result' 'git diff file file-expect'
 
 test_done
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 622ea1c..28738d7 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -96,7 +96,7 @@ test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
-	test_expect_success "Comparing $i" "cmp $i new_wc/$i"
+	test_expect_success "Comparing $i" "git diff $i new_wc/$i"
 done
 
 
@@ -144,7 +144,7 @@ test_expect_success 'test show-ignore' "
 	svn commit -m 'propset svn:ignore'
 	cd .. &&
 	git-svn show-ignore > show-ignore.got &&
-	cmp show-ignore.expect show-ignore.got
+	git diff show-ignore.expect show-ignore.got
 	"
 
 test_done
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index c668dd1..082785e 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -28,7 +28,7 @@ test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
 	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
 	svn co $svnrepo wc &&
-	cmp readme wc/readme
+	git diff readme wc/readme
 	"
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
@@ -37,7 +37,7 @@ test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
 	svn cat $svnrepo/subdir/readme > readme.2 &&
-	cmp readme readme.2
+	git diff readme readme.2
 	"
 
 test_done
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index dc2afda..37ae559 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -105,7 +105,7 @@ test_expect_success  ".rev_db auto-converted to .rev_db.UUID" "
 	git-svn fetch -i trunk &&
 	test -L $GIT_DIR/svn/trunk/.rev_db &&
 	test -f \$expect &&
-	cmp \$expect $GIT_DIR/svn/trunk/.rev_db
+	git diff \$expect $GIT_DIR/svn/trunk/.rev_db
 	"
 
 test_done
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index db4344c..83b94ed 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -48,7 +48,7 @@ test_expect_success 'test refspec globbing' "
 	git-svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end | \
 	    sed -e 's/^.\{41\}//' > output.end &&
-	cmp expect.end output.end &&
+	git diff expect.end output.end &&
 	test \"\`git rev-parse refs/remotes/tags/end~1\`\" = \
 		\"\`git rev-parse refs/remotes/branches/start\`\" &&
 	test \"\`git rev-parse refs/remotes/branches/start~2\`\" = \
@@ -80,7 +80,7 @@ test_expect_success 'test left-hand-side only globbing' "
 	     \`git rev-parse refs/remotes/two/branches/start\` &&
 	git log --pretty=oneline refs/remotes/two/tags/end | \
 	    sed -e 's/^.\{41\}//' > output.two &&
-	cmp expect.two output.two
+	git diff expect.two output.two
 	"
 
 test_done
-- 
1.5.0.1.788.g8ca52
