From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH 3/3] Fix apostrophe quoting in tests
Date: Mon, 15 Oct 2007 14:13:49 +0100
Message-ID: <11924540291922-git-send-email-maillist@steelskies.com>
References: <4711486B.1050301@op5.se>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 15:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhPlw-0005j7-PT
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761037AbXJONN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760235AbXJONNz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:13:55 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:54112 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760298AbXJONNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:13:52 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id CE2DC2A41CC; Mon, 15 Oct 2007 14:13:49 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <4711486B.1050301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60993>

From: Jonathan del Strother <jon.delStrother@bestbefore.tv>

Double-quoting all paths so the tests can be run from inside a directory named "Joe's git"

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 t/t9100-git-svn-basic.sh                 |   54 +++++++++++++++---------------
 t/t9101-git-svn-props.sh                 |    6 ++--
 t/t9102-git-svn-deep-rmdir.sh            |    6 ++--
 t/t9104-git-svn-follow-parent.sh         |   50 ++++++++++++++--------------
 t/t9105-git-svn-commit-diff.sh           |   12 +++---
 t/t9106-git-svn-commit-diff-clobber.sh   |   14 ++++----
 t/t9107-git-svn-migrate.sh               |   28 ++++++++--------
 t/t9108-git-svn-glob.sh                  |    8 ++--
 t/t9110-git-svn-use-svm-props.sh         |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh     |    8 ++--
 t/t9112-git-svn-md5less-file.sh          |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh      |    6 ++--
 t/t9114-git-svn-dcommit-merge.sh         |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh |    4 +-
 t/t9116-git-svn-log.sh                   |    4 +-
 15 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index c3585da..1d802a8 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -31,16 +31,16 @@ test_expect_success \
 	echo 'zzz' > bar/zzz &&
 	echo '#!/bin/sh' > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m 'import for git-svn' . '$svnrepo' >/dev/null &&
+	svn import -m 'import for git-svn' . \"$svnrepo\" >/dev/null &&
 	cd .. &&
 	rm -rf import &&
-	git-svn init '$svnrepo'"
+	git-svn init \"$svnrepo\""
 
 test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
 
-test_expect_success "checkout from svn" "svn co '$svnrepo' '$SVN_TREE'"
+test_expect_success "checkout from svn" "svn co \"$svnrepo\" \"$SVN_TREE\""
 
 name='try a deep --rmdir with a commit'
 test_expect_success "$name" "
@@ -51,8 +51,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch &&
-	svn up '$SVN_TREE' &&
-	test -d '$SVN_TREE'/dir && test ! -d '$SVN_TREE'/dir/a"
+	svn up \"$SVN_TREE\" &&
+	test -d \"$SVN_TREE\"/dir && test ! -d \"$SVN_TREE\"/dir/a"
 
 
 name='detect node change from file to directory #1'
@@ -69,7 +69,7 @@ test_expect_failure "$name" "
 
 name='detect node change from directory to file #1'
 test_expect_failure "$name" "
-	rm -rf dir '$GIT_DIR'/index &&
+	rm -rf dir \"$GIT_DIR\"/index &&
 	git checkout -f -b mybranch2 remotes/git-svn &&
 	mv bar/zzz zzz &&
 	rm -rf bar &&
@@ -83,7 +83,7 @@ test_expect_failure "$name" "
 
 name='detect node change from file to directory #2'
 test_expect_failure "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"$GIT_DIR\"/index &&
 	git checkout -f -b mybranch3 remotes/git-svn &&
 	rm bar/zzz &&
 	git update-index --remove bar/zzz &&
@@ -97,7 +97,7 @@ test_expect_failure "$name" "
 
 name='detect node change from directory to file #2'
 test_expect_failure "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"$GIT_DIR\"/index &&
 	git checkout -f -b mybranch4 remotes/git-svn &&
 	rm -rf dir &&
 	git update-index --remove -- dir/file &&
@@ -111,15 +111,15 @@ test_expect_failure "$name" "
 
 name='remove executable bit from a file'
 test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"$GIT_DIR\"/index &&
 	git checkout -f -b mybranch5 remotes/git-svn &&
 	chmod -x exec.sh &&
 	git update-index exec.sh &&
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test ! -x '$SVN_TREE'/exec.sh"
+	svn up \"$SVN_TREE\" &&
+	test ! -x \"$SVN_TREE\"/exec.sh"
 
 
 name='add executable bit back file'
@@ -129,8 +129,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/exec.sh"
+	svn up \"$SVN_TREE\" &&
+	test -x \"$SVN_TREE\"/exec.sh"
 
 
 name='executable file becomes a symlink to bar/zzz (file)'
@@ -141,8 +141,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -L '$SVN_TREE'/exec.sh"
+	svn up \"$SVN_TREE\" &&
+	test -L \"$SVN_TREE\"/exec.sh"
 
 name='new symlink is added to a file that was also just made executable'
 
@@ -153,9 +153,9 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/bar/zzz &&
-	test -L '$SVN_TREE'/exec-2.sh"
+	svn up \"$SVN_TREE\" &&
+	test -x \"$SVN_TREE\"/bar/zzz &&
+	test -L \"$SVN_TREE\"/exec-2.sh"
 
 name='modify a symlink to become a file'
 test_expect_success "$name" "
@@ -166,10 +166,10 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -f '$SVN_TREE'/exec-2.sh &&
-	test ! -L '$SVN_TREE'/exec-2.sh &&
-	git diff help '$SVN_TREE/exec-2.sh'"
+	svn up \"$SVN_TREE\" &&
+	test -f \"$SVN_TREE\"/exec-2.sh &&
+	test ! -L \"$SVN_TREE\"/exec-2.sh &&
+	git diff help \"$SVN_TREE\"/exec-2.sh"
 
 if test "$have_utf8" = t
 then
@@ -190,7 +190,7 @@ name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init '$svnrepo' && git-svn fetch &&
+    "git-svn init \"$svnrepo\" && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      git diff a b"
@@ -220,16 +220,16 @@ test_expect_failure 'exit if remote refs are ambigious' "
         "
 
 test_expect_failure 'exit if init-ing a would clobber a URL' "
-        svnadmin create '${PWD}/svnrepo2' &&
-        svn mkdir -m 'mkdir bar' '${svnrepo}2/bar' &&
+        svnadmin create \"${PWD}/svnrepo2\" &&
+        svn mkdir -m 'mkdir bar' \"${svnrepo}2/bar\" &&
         git config --unset svn-remote.svn.fetch \
                                 '^bar:refs/remotes/git-svn$' &&
-        git-svn init '${svnrepo}2/bar'
+        git-svn init \"${svnrepo}2/bar\"
         "
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' "
-        git-svn init --minimize-url -i bar '$svnrepo/bar' &&
+        git-svn init --minimize-url -i bar \"$svnrepo/bar\" &&
         git config --get svn-remote.svn.fetch \
                               '^bar:refs/remotes/bar$' &&
         git config --get svn-remote.svn.fetch \
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index a1c85e0..e741bfe 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -52,7 +52,7 @@ EOF
 cd ..
 
 rm -rf import
-test_expect_success 'checkout working copy from svn' "svn co '$svnrepo' test_wc"
+test_expect_success 'checkout working copy from svn' "svn co \"$svnrepo\" test_wc"
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
+test_expect_success 'initialize git-svn' "git-svn init \"$svnrepo\""
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
 name='test svn:keywords ignoring'
@@ -92,7 +92,7 @@ test_expect_success "propset CR on crlf files" \
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	"git-svn fetch &&
 	 git pull . remotes/git-svn &&
-	 svn co '$svnrepo' new_wc"
+	 svn co \"$svnrepo\" new_wc"
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 99c8840..e3af319 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,12 +9,12 @@ test_expect_success 'initialize repo' "
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m 'import for git-svn' . '$svnrepo' &&
+	svn import -m 'import for git-svn' . \"$svnrepo\" &&
 	cd ..
 	"
 
 test_expect_success 'mirror via git-svn' "
-	git-svn init '$svnrepo' &&
+	git-svn init \"$svnrepo\" &&
 	git-svn fetch &&
 	git checkout -f -b test-rmdir remotes/git-svn
 	"
@@ -23,7 +23,7 @@ test_expect_success 'Try a commit on rmdir' "
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m 'remove another' &&
 	git-svn set-tree --rmdir HEAD &&
-	svn ls -R '$svnrepo' | grep ^deeply/nested/directory/number/1
+	svn ls -R \"$svnrepo\" | grep ^deeply/nested/directory/number/1
 	"
 
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index aa2bfe2..a422afa 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -11,9 +11,9 @@ test_expect_success 'initialize repo' "
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m 'initial' . '$svnrepo' &&
+	svn import -m 'initial' . \"$svnrepo\" &&
 	cd .. &&
-	svn co '$svnrepo' wc &&
+	svn co \"$svnrepo\" wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
@@ -27,7 +27,7 @@ test_expect_success 'initialize repo' "
 	"
 
 test_expect_success 'init and fetch a moved directory' "
-	git-svn init --minimize-url -i thunk '$svnrepo/thunk' &&
+	git-svn init --minimize-url -i thunk \"$svnrepo/thunk\" &&
 	git-svn fetch -i thunk &&
 	test \"\`git rev-parse --verify refs/remotes/thunk@2\`\" \
            = \"\`git rev-parse --verify refs/remotes/thunk~1\`\" &&
@@ -38,7 +38,7 @@ test_expect_success 'init and fetch a moved directory' "
 	"
 
 test_expect_success 'init and fetch from one svn-remote' "
-        git config svn-remote.svn.url '$svnrepo' &&
+        git config svn-remote.svn.url \"$svnrepo\" &&
         git config --add svn-remote.svn.fetch \
           trunk:refs/remotes/svn/trunk &&
         git config --add svn-remote.svn.fetch \
@@ -52,9 +52,9 @@ test_expect_success 'init and fetch from one svn-remote' "
 
 test_expect_success 'follow deleted parent' "
         (svn cp -m 'resurrecting trunk as junk' \
-               '$svnrepo/trunk@2' '$svnrepo'/junk ||
+               \"$svnrepo/trunk@2\" \"$svnrepo\"/junk ||
          svn cp -m 'resurrecting trunk as junk' \
-               -r2 '$svnrepo/trunk' '$svnrepo/junk') &&
+               -r2 \"$svnrepo/trunk\" \"$svnrepo/junk\") &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
@@ -67,10 +67,10 @@ test_expect_success 'follow deleted parent' "
 test_expect_success 'follow larger parent' "
         mkdir -p import/trunk/thunk/bump/thud &&
         echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m 'import a larger parent' import '$svnrepo/larger-parent' &&
-        svn cp -m 'hi' '$svnrepo/larger-parent' '$svnrepo/another-larger' &&
+        svn import -m 'import a larger parent' import \"$svnrepo/larger-parent\" &&
+        svn cp -m 'hi' \"$svnrepo/larger-parent\" \"$svnrepo/another-larger\" &&
         git-svn init --minimize-url -i larger \
-          '$svnrepo/another-larger/trunk/thunk/bump/thud' &&
+          \"$svnrepo/another-larger/trunk/thunk/bump/thud\" &&
         git-svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
@@ -83,23 +83,23 @@ test_expect_success 'follow larger parent' "
         "
 
 test_expect_success 'follow higher-level parent' "
-        svn mkdir -m 'follow higher-level parent' '$svnrepo/blob' &&
-        svn co '$svnrepo/blob' blob &&
+        svn mkdir -m 'follow higher-level parent' \"$svnrepo/blob\" &&
+        svn co \"$svnrepo/blob\" blob &&
         cd blob &&
                 echo hi > hi &&
                 svn add hi &&
                 svn commit -m 'hihi' &&
                 cd ..
-        svn mkdir -m 'new glob at top level' '$svnrepo/glob' &&
-        svn mv -m 'move blob down a level' '$svnrepo/blob' '$svnrepo/glob/blob' &&
-        git-svn init --minimize-url -i blob '$svnrepo/glob/blob' &&
+        svn mkdir -m 'new glob at top level' \"$svnrepo/glob\" &&
+        svn mv -m 'move blob down a level' \"$svnrepo/blob\" \"$svnrepo/glob/blob\" &&
+        git-svn init --minimize-url -i blob \"$svnrepo/glob/blob\" &&
         git-svn fetch -i blob
         "
 
 test_expect_success 'follow deleted directory' "
-	svn mv -m 'bye!' '$svnrepo/glob/blob/hi' '$svnrepo/glob/blob/bye' &&
-	svn rm -m 'remove glob' '$svnrepo/glob' &&
-	git-svn init --minimize-url -i glob '$svnrepo/glob' &&
+	svn mv -m 'bye!' \"$svnrepo/glob/blob/hi\" \"$svnrepo/glob/blob/bye\" &&
+	svn rm -m 'remove glob' \"$svnrepo/glob\" &&
+	git-svn init --minimize-url -i glob \"$svnrepo/glob\" &&
 	git-svn fetch -i glob &&
 	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
 	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
@@ -118,9 +118,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  echo 'bad delete test 2' > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
 	cd import &&
-	  svn import -m 'r9270 test' . '$svnrepo/r9270' &&
+	  svn import -m 'r9270 test' . \"$svnrepo/r9270\" &&
 	cd .. &&
-	svn co '$svnrepo/r9270/trunk/subversion/bindings/swig/perl' r9270 &&
+	svn co \"$svnrepo/r9270/trunk/subversion/bindings/swig/perl\" r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
@@ -130,7 +130,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  svn commit -m 'reorg test' &&
 	cd .. &&
 	git-svn init --minimize-url -i r9270-t \
-	  '$svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t' &&
+	  \"$svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t\" &&
 	git-svn fetch -i r9270-t &&
 	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
 	test \"\`git ls-tree --name-only r9270-t~1\`\" = \
@@ -138,9 +138,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	"
 
 test_expect_success "track initial change if it was only made to parent" "
-	svn cp -m 'wheee!' '$svnrepo/r9270/trunk' '$svnrepo/r9270/drunk' &&
+	svn cp -m 'wheee!' \"$svnrepo/r9270/trunk\" \"$svnrepo/r9270/drunk\" &&
 	git-svn init --minimize-url -i r9270-d \
-	  '$svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t' &&
+	  \"$svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t\" &&
 	git-svn fetch -i r9270-d &&
 	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
 	test \"\`git ls-tree --name-only r9270-t\`\" = \
@@ -150,7 +150,7 @@ test_expect_success "track initial change if it was only made to parent" "
 	"
 
 test_expect_success "track multi-parent paths" "
-	svn cp -m 'resurrect /glob' '$svnrepo/r9270' '$svnrepo/glob' &&
+	svn cp -m 'resurrect /glob' \"$svnrepo/r9270\" \"$svnrepo/glob\" &&
 	git-svn multi-fetch &&
 	test \`git cat-file commit refs/remotes/glob | \
 	       grep '^parent ' | wc -l\` -eq 2
@@ -161,8 +161,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" "
-	rm -r '$GIT_DIR/svn' '$GIT_DIR/refs/remotes' '$GIT_DIR/logs' &&
-	mkdir '$GIT_DIR/svn' &&
+	rm -r \"$GIT_DIR/svn\" \"$GIT_DIR/refs/remotes\" \"$GIT_DIR/logs\" &&
+	mkdir \"$GIT_DIR/svn\" &&
 	git-svn multi-fetch
 	"
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 2e1eb75..9cc38d3 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m 'initial' . '$svnrepo' &&
+	svn import -m 'initial' . \"$svnrepo\" &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
@@ -26,17 +26,17 @@ prev=`git rev-parse --verify HEAD^1`
 
 test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
-	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
-	svn co '$svnrepo' wc &&
+	git-svn commit-diff -r1 '$prev' '$head' \"$svnrepo\" &&
+	svn co \"$svnrepo\" wc &&
 	cmp readme wc/readme
 	"
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
-	svn import -m 'sub-directory' import '$svnrepo/subdir' &&
-	git-svn init --minimize-url '$svnrepo/subdir' &&
+	svn import -m 'sub-directory' import \"$svnrepo/subdir\" &&
+	git-svn init --minimize-url \"$svnrepo/subdir\" &&
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
-	svn cat '$svnrepo/subdir/readme' > readme.2 &&
+	svn cat \"$svnrepo/subdir/readme\" > readme.2 &&
 	cmp readme readme.2
 	"
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index bb42339..892ca55 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -8,14 +8,14 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m 'initial' . '$svnrepo' &&
+	svn import -m 'initial' . \"$svnrepo\" &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m 'initial'
 	"
 test_expect_success 'commit change from svn side' "
-	svn co '$svnrepo' t.svn &&
+	svn co \"$svnrepo\" t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
@@ -27,7 +27,7 @@ test_expect_success 'commit change from svn side' "
 test_expect_failure 'commit conflicting change from git' "
 	echo second line from git >> file &&
 	git commit -a -m 'second line from git' &&
-	git-svn commit-diff -r1 HEAD~1 HEAD '$svnrepo'
+	git-svn commit-diff -r1 HEAD~1 HEAD \"$svnrepo\"
 	" || true
 
 test_expect_success 'commit complementing change from git' "
@@ -36,14 +36,14 @@ test_expect_success 'commit complementing change from git' "
 	git commit -a -m 'second line from svn' &&
 	echo third line from git >> file &&
 	git commit -a -m 'third line from git' &&
-	git-svn commit-diff -r2 HEAD~1 HEAD '$svnrepo'
+	git-svn commit-diff -r2 HEAD~1 HEAD \"$svnrepo\"
 	"
 
 test_expect_failure 'dcommit fails to commit because of conflict' "
-	git-svn init '$svnrepo' &&
+	git-svn init \"$svnrepo\" &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
-	svn co '$svnrepo' t.svn &&
+	svn co \"$svnrepo\" t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
@@ -67,7 +67,7 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	"
 
 test_expect_success 'commit another change from svn side' "
-	svn co '$svnrepo' t.svn &&
+	svn co \"$svnrepo\" t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 90bf786..59e8f0d 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -4,7 +4,7 @@ test_description='git-svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup old-looking metadata' "
-	cp '$GIT_DIR/config' '$GIT_DIR/config-old-git-svn' &&
+	cp \"$GIT_DIR/config\" \"$GIT_DIR/config-old-git-svn\" &&
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
@@ -12,13 +12,13 @@ test_expect_success 'setup old-looking metadata' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . '$svnrepo'
+		svn import -m test . \"$svnrepo\"
 		cd .. &&
-	git-svn init '$svnrepo' &&
+	git-svn init \"$svnrepo\" &&
 	git-svn fetch &&
-	mv '$GIT_DIR'/svn/* '$GIT_DIR/' &&
-	mv '$GIT_DIR/svn/.metadata' '$GIT_DIR/' &&
-	rmdir '$GIT_DIR/svn' &&
+	mv \"$GIT_DIR\"/svn/* \"$GIT_DIR/\" &&
+	mv \"$GIT_DIR/svn/.metadata\" \"$GIT_DIR/\" &&
+	rmdir \"$GIT_DIR/svn\" &&
 	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
 	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
@@ -28,11 +28,11 @@ head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
 test_expect_success 'initialize old-style (v0) git-svn layout' "
-	mkdir -p '$GIT_DIR/git-svn/info' '$GIT_DIR/svn/info' &&
-	echo '$svnrepo' > '$GIT_DIR/git-svn/info/url' &&
-	echo '$svnrepo' > '$GIT_DIR/svn/info/url' &&
+	mkdir -p \"$GIT_DIR/git-svn/info\" \"$GIT_DIR/svn/info\" &&
+	echo \"$svnrepo\" > \"$GIT_DIR/git-svn/info/url\" &&
+	echo \"$svnrepo\" > \"$GIT_DIR/svn/info/url\" &&
 	git-svn migrate &&
-	! test -d '$GIT_DIR/git-svn' &&
+	! test -d \"$GIT_DIR/git-svn\" &&
 	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
 	test \"\`git config --get svn-remote.svn.url\`\" = \"$svnrepo\" &&
@@ -41,7 +41,7 @@ test_expect_success 'initialize old-style (v0) git-svn layout' "
 	"
 
 test_expect_success 'initialize a multi-repository repo' "
-	git-svn init '$svnrepo' -T trunk -t tags -b branches &&
+	git-svn init \"$svnrepo\" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep '^trunk:refs/remotes/trunk$' fetch.out &&
 	test -n \"\`git config --get svn-remote.svn.branches \
@@ -76,14 +76,14 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 test_expect_success 'migrate --minimize on old inited layout' "
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
-	rm -rf '$GIT_DIR/svn' &&
+	rm -rf \"$GIT_DIR/svn\" &&
 	for i in \`cat fetch.out\`; do
 		path=\`expr \$i : '\\([^:]*\\):.*$'\`
 		ref=\`expr \$i : '[^:]*:refs/remotes/\\(.*\\)$'\`
 		if test -z \"\$ref\"; then continue; fi
 		if test -n \"\$path\"; then path=\"/\$path\"; fi
-		( mkdir -p '$GIT_DIR'/svn/\$ref/info/ &&
-		echo '$svnrepo'\$path > '$GIT_DIR'/svn/\$ref/info/url ) || exit 1;
+		( mkdir -p \"$GIT_DIR\"/svn/\$ref/info/ &&
+		echo \"$svnrepo\"\$path > \"$GIT_DIR\"/svn/\$ref/info/url ) || exit 1;
 	done &&
 	git-svn migrate --minimize &&
 	test -z \"\`git config -l |grep -v '^svn-remote\.git-svn\.'\`\" &&
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index c6dc0ef..eb039ef 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -14,8 +14,8 @@ test_expect_success 'test refspec globbing' "
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo 'hello world' > trunk/src/a/readme &&
 	echo 'goodbye world' > trunk/src/b/readme &&
-	svn import -m 'initial' trunk '$svnrepo/trunk' &&
-	svn co '$svnrepo' tmp &&
+	svn import -m 'initial' trunk \"$svnrepo/trunk\" &&
+	svn co \"$svnrepo\" tmp &&
 	cd tmp &&
 		mkdir branches tags &&
 		svn add branches tags &&
@@ -38,7 +38,7 @@ test_expect_success 'test refspec globbing' "
 		poke tags/end/src/b/readme &&
 		svn commit -m 'nothing to see here'
 		cd .. &&
-	git config --add svn-remote.svn.url '$svnrepo' &&
+	git config --add svn-remote.svn.url \"$svnrepo\" &&
 	git config --add svn-remote.svn.fetch \
 	                 'trunk/src/a:refs/remotes/trunk' &&
 	git config --add svn-remote.svn.branches \
@@ -60,7 +60,7 @@ echo nothing to see here >> expect.two
 cat expect.end >> expect.two
 
 test_expect_success 'test left-hand-side only globbing' "
-	git config --add svn-remote.two.url '$svnrepo' &&
+	git config --add svn-remote.two.url \"$svnrepo\" &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
 	                 'branches/*:refs/remotes/two/branches/*' &&
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index d4ab01f..9df60ba 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -8,11 +8,11 @@ test_description='git-svn useSvmProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svm repo' "
-	svnadmin load -q '$rawsvnrepo' < ../t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar '$svnrepo/mirror/arr' &&
-	git-svn init --minimize-url -R argh -i dir '$svnrepo/mirror/argh' &&
+	svnadmin load -q \"$rawsvnrepo\" < ../t9110/svm.dump &&
+	git-svn init --minimize-url -R arr -i bar \"$svnrepo/mirror/arr\" &&
+	git-svn init --minimize-url -R argh -i dir \"$svnrepo/mirror/argh\" &&
 	git-svn init --minimize-url -R argh -i e \
-	  '$svnrepo/mirror/argh/a/b/c/d/e' &&
+	  \"$svnrepo/mirror/argh/a/b/c/d/e\" &&
 	git config svn.useSvmProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index 936f023..e3693eb 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -8,10 +8,10 @@ test_description='git-svn useSvnsyncProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svnsync repo' "
-	svnadmin load -q '$rawsvnrepo' < ../t9111/svnsync.dump &&
-	git-svn init --minimize-url -R arr -i bar '$svnrepo/bar' &&
-	git-svn init --minimize-url -R argh -i dir '$svnrepo/dir' &&
-	git-svn init --minimize-url -R argh -i e '$svnrepo/dir/a/b/c/d/e' &&
+	svnadmin load -q \"$rawsvnrepo\" < ../t9111/svnsync.dump &&
+	git-svn init --minimize-url -R arr -i bar \"$svnrepo/bar\" &&
+	git-svn init --minimize-url -R argh -i dir \"$svnrepo/dir\" &&
+	git-svn init --minimize-url -R argh -i e \"$svnrepo/dir/a/b/c/d/e\" &&
 	git config svn.useSvnsyncProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index b095583..124120c 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -38,8 +38,8 @@ PROPS-END
 
 EOF
 
-test_expect_success 'load svn dumpfile' "svnadmin load '$rawsvnrepo' < dumpfile.svn"
+test_expect_success 'load svn dumpfile' "svnadmin load \"$rawsvnrepo\" < dumpfile.svn"
 
-test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
+test_expect_success 'initialize git-svn' "git-svn init \"$svnrepo\""
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 0088c75..150d7f0 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -15,14 +15,14 @@ test_description='git-svn dcommit new files over svn:// test'
 
 start_svnserve () {
 	svnserve --listen-port $SVNSERVE_PORT \
-	         --root '$rawsvnrepo' \
+	         --root "$rawsvnrepo" \
 	         --listen-once \
 	         --listen-host 127.0.0.1 &
 }
 
 test_expect_success 'start tracking an empty repo' "
-	svn mkdir -m 'empty dir' '$svnrepo/empty-dir' &&
-	echo anon-access = write >> '$rawsvnrepo/conf/svnserve.conf' &&
+	svn mkdir -m 'empty dir' \"$svnrepo/empty-dir\" &&
+	echo anon-access = write >> \"$rawsvnrepo/conf/svnserve.conf\" &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
 	git svn fetch
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 64ec7fd..ffe8859 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -35,7 +35,7 @@ EOF
 }
 
 test_expect_success 'setup svn repository' "
-	svn co '$svnrepo' mysvnwork &&
+	svn co \"$svnrepo\" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
@@ -45,7 +45,7 @@ test_expect_success 'setup svn repository' "
 	"
 
 test_expect_success 'setup git mirror and merge' "
-	git svn init '$svnrepo' -t tags -T trunk -b branches &&
+	git svn init \"$svnrepo\" -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
 	git checkout -b merge &&
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 653578d..0681ffa 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -8,12 +8,12 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' "
-	svnadmin load -q '$rawsvnrepo' < ../t9115/funky-names.dump &&
+	svnadmin load -q \"$rawsvnrepo\" < ../t9115/funky-names.dump &&
 	start_httpd
 	"
 
 test_expect_success 'init and fetch repository' "
-	git svn init '$svnrepo' &&
+	git svn init \"$svnrepo\" &&
 	git svn fetch &&
 	git reset --hard git-svn
 	"
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 70c0c5f..890b5f1 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -14,9 +14,9 @@ test_expect_success 'setup repository and import' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . '$svnrepo'
+		svn import -m test . \"$svnrepo\"
 		cd .. &&
-	git-svn init '$svnrepo' -T trunk -b branches -t tags &&
+	git-svn init \"$svnrepo\" -T trunk -b branches -t tags &&
 	git-svn fetch &&
 	git reset --hard trunk &&
 	echo bye >> README &&
-- 
1.5.3.1
