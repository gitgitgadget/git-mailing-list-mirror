From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 8/8] Fix tests breaking when checkout path contains shell metacharacters
Date: Tue,  8 Apr 2008 21:30:04 -0400
Message-ID: <1207704604-30393-8-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjP9h-0007g2-PF
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbYDIBag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYDIBaf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:30:35 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49007 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYDIBaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:30:21 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dP-Fb; Wed, 09 Apr 2008 01:30:10 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007vJ-O2; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79059>

This fixes the remainder of the issues where the test script itself is at
fault for failing when the git checkout path contains whitespace or other
shell metacharacters.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/t0000-basic.sh                              |    4 +-
 t/t0001-init.sh                               |    2 +-
 t/t1020-subdirectory.sh                       |   24 +++++-----
 t/t1501-worktree.sh                           |   14 +++---
 t/t3050-subprojects-fetch.sh                  |    2 +-
 t/t3404-rebase-interactive.sh                 |    3 +-
 t/t5500-fetch-pack.sh                         |    2 +-
 t/t5512-ls-remote.sh                          |    2 +-
 t/t5516-fetch-push.sh                         |    8 ++--
 t/t5700-clone-reference.sh                    |    4 +-
 t/t5710-info-alternate.sh                     |    4 +-
 t/t7003-filter-branch.sh                      |    4 +-
 t/t7010-setup.sh                              |    2 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7501-commit.sh                             |    8 ++--
 t/t7504-commit-msg-hook.sh                    |   20 +++++-----
 t/t7505-prepare-commit-msg-hook.sh            |   14 +++---
 t/t9100-git-svn-basic.sh                      |   54 ++++++++++++------------
 t/t9101-git-svn-props.sh                      |    6 +-
 t/t9102-git-svn-deep-rmdir.sh                 |    6 +-
 t/t9103-git-svn-tracked-directory-removed.sh  |   30 +++++++-------
 t/t9104-git-svn-follow-parent.sh              |   50 +++++++++++-----------
 t/t9105-git-svn-commit-diff.sh                |   12 +++---
 t/t9106-git-svn-commit-diff-clobber.sh        |   14 +++---
 t/t9106-git-svn-dcommit-clobber-series.sh     |    6 +-
 t/t9107-git-svn-migrate.sh                    |   48 +++++++++++-----------
 t/t9108-git-svn-glob.sh                       |    8 ++--
 t/t9110-git-svn-use-svm-props.sh              |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh          |    8 ++--
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |    6 +-
 t/t9114-git-svn-dcommit-merge.sh              |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    4 +-
 t/t9116-git-svn-log.sh                        |    4 +-
 t/t9117-git-svn-init-clone.sh                 |   10 ++--
 t/t9118-git-svn-funky-branch-names.sh         |   12 +++---
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh        |   13 +++---
 38 files changed, 214 insertions(+), 214 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 27b54cb..690f80a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -305,10 +305,10 @@ test_expect_success 'absolute path works as expected' '
 	file="$dir"/index &&
 	test "$file" = "$(test-absolute-path $dir2/index)" &&
 	basename=blub &&
-	test "$dir/$basename" = $(cd .git && test-absolute-path $basename) &&
+	test "$dir/$basename" = "$(cd .git && test-absolute-path "$basename")" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
-	test "$sym" = "$(test-absolute-path $dir2/syml)"
+	test "$sym" = "$(test-absolute-path "$dir2/syml")"
 '
 
 test_expect_success 'very long name in the index handled sanely' '
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b0289e3..22eb735 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -95,7 +95,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 	(
 		unset GIT_CONFIG
 		mkdir git-dir-wt-1.git &&
-		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
+		GIT_WORK_TREE="$(pwd)" GIT_DIR=git-dir-wt-1.git git init
 	) &&
 	check_config git-dir-wt-1.git false "$(pwd)"
 '
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index b9cef34..20a1e82 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -16,12 +16,12 @@ test_expect_success setup '
 	cp one original.one &&
 	cp dir/two original.two
 '
-HERE=`pwd`
+HERE="$(pwd)"
 LF='
 '
 
 test_expect_success 'update-index and ls-files' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git update-index --add one &&
 	case "`git ls-files`" in
 	one) echo ok one ;;
@@ -41,7 +41,7 @@ test_expect_success 'update-index and ls-files' '
 '
 
 test_expect_success 'cat-file' '
-	cd $HERE &&
+	cd "$HERE" &&
 	two=`git ls-files -s dir/two` &&
 	two=`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
 	echo "$two" &&
@@ -54,7 +54,7 @@ test_expect_success 'cat-file' '
 rm -f actual dir/actual
 
 test_expect_success 'diff-files' '
-	cd $HERE &&
+	cd "$HERE" &&
 	echo a >>one &&
 	echo d >>dir/two &&
 	case "`git diff-files --name-only`" in
@@ -74,7 +74,7 @@ test_expect_success 'diff-files' '
 '
 
 test_expect_success 'write-tree' '
-	cd $HERE &&
+	cd "$HERE" &&
 	top=`git write-tree` &&
 	echo $top &&
 	cd dir &&
@@ -84,7 +84,7 @@ test_expect_success 'write-tree' '
 '
 
 test_expect_success 'checkout-index' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git checkout-index -f -u one &&
 	cmp one original.one &&
 	cd dir &&
@@ -93,7 +93,7 @@ test_expect_success 'checkout-index' '
 '
 
 test_expect_success 'read-tree' '
-	cd $HERE &&
+	cd "$HERE" &&
 	rm -f one dir/two &&
 	tree=`git write-tree` &&
 	git read-tree --reset -u "$tree" &&
@@ -107,27 +107,27 @@ test_expect_success 'read-tree' '
 '
 
 test_expect_success 'no file/rev ambiguity check inside .git' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git commit -a -m 1 &&
-	cd $HERE/.git &&
+	cd "$HERE"/.git &&
 	git show -s HEAD
 '
 
 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && GIT_DIR=. git show -s HEAD
 '
 
 # This still does not work as it should...
 : test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && git show -s HEAD
 '
 
 test_expect_success 'detection should not be fooled by a symlink' '
-	cd $HERE &&
+	cd "$HERE" &&
 	rm -fr foo.git &&
 	git clone -s .git another &&
 	ln -s another yetanother &&
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..ffb77b6 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -48,8 +48,8 @@ test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 say "core.worktree = absolute path"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_DIR="$(pwd)/repo.git"
+export GIT_CONFIG="$GIT_DIR/config"
 git config core.worktree "$(pwd)/work"
 test_rev_parse 'outside'      false false false
 cd work || exit 1
@@ -59,8 +59,8 @@ test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 say "GIT_WORK_TREE=relative path (override core.worktree)"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_DIR="$(pwd)/repo.git"
+export GIT_CONFIG="$GIT_DIR/config"
 git config core.worktree non-existent
 export GIT_WORK_TREE=work
 test_rev_parse 'outside'      false false false
@@ -75,9 +75,9 @@ cd ../../.. || exit 1
 mv work repo.git/work
 
 say "GIT_WORK_TREE=absolute path, work tree below git dir"
-export GIT_DIR=$(pwd)/repo.git
-export GIT_CONFIG=$GIT_DIR/config
-export GIT_WORK_TREE=$(pwd)/repo.git/work
+export GIT_DIR="$(pwd)/repo.git"
+export GIT_CONFIG="$GIT_DIR/config"
+export GIT_WORK_TREE="$(pwd)/repo.git/work"
 test_rev_parse 'outside'              false false false
 cd repo.git || exit 1
 test_rev_parse 'in repo.git'              false true  false
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 2b21b10..4261e96 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 '
 
 test_expect_success clone '
-	git clone file://`pwd`/.git cloned &&
+	git clone "file://$(pwd)/.git" cloned &&
 	(git rev-parse HEAD; git ls-files -s) >expected &&
 	(
 		cd cloned &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9cf873f..b9e3dbd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -91,9 +91,8 @@ for line in $FAKE_LINES; do
 done
 EOF
 
+test_set_editor "$(pwd)/fake-editor.sh"
 chmod a+x fake-editor.sh
-VISUAL="$(pwd)/fake-editor.sh"
-export VISUAL
 
 test_expect_success 'no changes are a nop' '
 	git rebase -i F &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 788b4a5..c52707b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -129,7 +129,7 @@ pull_to_client 2nd "B" $((64*3))
 
 pull_to_client 3rd "A" $((1*3)) # old fails
 
-test_expect_success "clone shallow" "git-clone --depth 2 file://`pwd`/. shallow"
+test_expect_success "clone shallow" 'git-clone --depth 2 "file://$(pwd)/." shallow'
 
 (cd shallow; git count-objects -v) > count.shallow
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index c0dc949..1dd8eed 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 		git show-ref -d	| sed -e "s/ /	/"
 	) >expected.all &&
 
-	git remote add self $(pwd)/.git
+	git remote add self "$(pwd)/.git"
 
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 793ffc6..6e8cb9e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -103,9 +103,9 @@ test_expect_success 'fetch with wildcard' '
 test_expect_success 'fetch with insteadOf' '
 	mk_empty &&
 	(
-		TRASH=$(pwd) &&
+		TRASH="$(pwd)" &&
 		cd testrepo &&
-		git config url./$TRASH/.insteadOf trash/
+		git config "url./$TRASH/.insteadOf" trash/ &&
 		git config remote.up.url trash/. &&
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
@@ -145,8 +145,8 @@ test_expect_success 'push with wildcard' '
 
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
-	TRASH=$(pwd) &&
-	git config url./$TRASH/.insteadOf trash/ &&
+	TRASH="$(pwd)" &&
+	git config "url./$TRASH/.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index b6a5486..82ef023 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -6,7 +6,7 @@
 test_description='test clone --reference'
 . ./test-lib.sh
 
-base_dir=`pwd`
+base_dir="$(pwd)"
 
 test_expect_success 'preparing first repository' \
 'test_create_repo A && cd A &&
@@ -51,7 +51,7 @@ diff expected current'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'git clone --reference B file://`pwd`/A D'
+'git clone --reference B "file://$(pwd)/A" D'
 
 cd "$base_dir"
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 910ccb4..8f26999 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -21,7 +21,7 @@ test_valid_repo() {
 	test `wc -l < fsck.log` = 0
 }
 
-base_dir=`pwd`
+base_dir="$(pwd)"
 
 test_expect_success 'preparing first repository' \
 'test_create_repo A && cd A &&
@@ -81,7 +81,7 @@ test_valid_repo'
 cd "$base_dir"
 
 test_expect_success 'breaking of loops' \
-"echo '$base_dir/B/.git/objects' >> '$base_dir'/A/.git/objects/info/alternates&&
+"echo \"\$base_dir\"/B/.git/objects >> \"\$base_dir\"/A/.git/objects/info/alternates&&
 cd C &&
 test_valid_repo"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index efd658a..abe3d83 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -123,9 +123,9 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
 	git-filter-branch -f --index-filter \
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
-	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+	          GIT_INDEX_FILE=\"\$GIT_INDEX_FILE.new\" \
 			git update-index --index-info &&
-		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
+		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
 test_expect_success 'stops when msg filter fails' '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 02cf7c5..d8a7c79 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -122,7 +122,7 @@ test_expect_success 'commit using absolute path names' '
 
 test_expect_success 'log using absolute path names' '
 	echo bb >>a/b/c/d &&
-	git commit -m "bb" $(pwd)/a/b/c/d &&
+	git commit -m "bb" "$(pwd)/a/b/c/d" &&
 
 	git log a/b/c/d >f1.txt &&
 	git log "$(pwd)/a/b/c/d" >f2.txt &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index afccfc9..54b1352 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -111,7 +111,7 @@ test_expect_success 'git-clean with absolute path' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	would_clean=$(
 		cd docs &&
-		git clean -n $(pwd)/../src |
+		git clean -n "$(pwd)/../src" |
 		sed -n -e "s|^Would remove ||p"
 	) &&
 	test "$would_clean" = ../src/part3.c || {
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index c0288f3..e5fdb63 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -79,8 +79,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -e "s/a file/an amend commit/g" < $1 > $1-
-mv $1- $1
+sed -e "s/a file/an amend commit/g" < "$1" > "$1-"
+mv "$1-" "$1"
 EOF
 chmod 755 editor
 
@@ -99,8 +99,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -e "s/amend/older/g"  < $1 > $1-
-mv $1- $1
+sed -e "s/amend/older/g"  < "$1" > "$1-"
+mv "$1-" "$1"
 EOF
 chmod 755 editor
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index eff36aa..24f6b2e 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -27,7 +27,7 @@ test_expect_success 'with no hook (editor)' '
 	echo "more foo" >> file &&
 	git add file &&
 	echo "more foo" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit
 
 '
 
@@ -44,7 +44,7 @@ test_expect_success '--no-verify with no hook (editor)' '
 	echo "more bar" > file &&
 	git add file &&
 	echo "more bar" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -71,7 +71,7 @@ test_expect_success 'with succeeding hook (editor)' '
 	echo "more more" >> file &&
 	git add file &&
 	echo "more more" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit
 
 '
 
@@ -88,7 +88,7 @@ test_expect_success '--no-verify with succeeding hook (editor)' '
 	echo "even more more" >> file &&
 	git add file &&
 	echo "even more more" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -111,7 +111,7 @@ test_expect_success 'with failing hook (editor)' '
 	echo "more another" >> file &&
 	git add file &&
 	echo "more another" > FAKE_MSG &&
-	! (GIT_EDITOR="$FAKE_EDITOR" git commit)
+	! (GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit)
 
 '
 
@@ -128,7 +128,7 @@ test_expect_success '--no-verify with failing hook (editor)' '
 	echo "more stuff" >> file &&
 	git add file &&
 	echo "more stuff" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -146,7 +146,7 @@ test_expect_success 'with non-executable hook (editor)' '
 	echo "content again" >> file &&
 	git add file &&
 	echo "content again" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -m "content again"
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -m "content again"
 
 '
 
@@ -163,7 +163,7 @@ test_expect_success '--no-verify with non-executable hook (editor)' '
 	echo "even more content" >> file &&
 	git add file &&
 	echo "even more content" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'hook edits commit message (editor)' '
 	echo "additional content" >> file &&
 	git add file &&
 	echo "additional content" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
 	commit_msg_is "new message"
 
 '
@@ -212,7 +212,7 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 	echo "more plus" >> file &&
 	git add file &&
 	echo "more plus" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify &&
 	commit_msg_is "more plus"
 
 '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 802aa62..bc2bad9 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -58,7 +58,7 @@ test_expect_success 'with hook (-m editor)' '
 
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -e -m "more more" &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -e -m "more more" &&
 	test "`git log -1 --pretty=format:%s`" = message
 
 '
@@ -85,7 +85,7 @@ test_expect_success 'with hook (-F editor)' '
 
 	echo "more" >> file &&
 	git add file &&
-	(echo more more | GIT_EDITOR="$FAKE_EDITOR" git commit -e -F -) &&
+	(echo more more | GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -e -F -) &&
 	test "`git log -1 --pretty=format:%s`" = message
 
 '
@@ -104,7 +104,7 @@ test_expect_success 'with hook (editor)' '
 
 	echo "more more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
 	test "`git log -1 --pretty=format:%s`" = default
 
 '
@@ -114,7 +114,7 @@ test_expect_success 'with hook (--amend)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --amend &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --amend &&
 	test "`git log -1 --pretty=format:%s`" = "$head"
 
 '
@@ -124,7 +124,7 @@ test_expect_success 'with hook (-c)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -c $head &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head &&
 	test "`git log -1 --pretty=format:%s`" = "$head"
 
 '
@@ -139,7 +139,7 @@ test_expect_success 'with failing hook' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="$FAKE_EDITOR" git commit -c $head
+	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
 
 '
 
@@ -148,7 +148,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify -c $head
+	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
 
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4e24ab3..528c0a9 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -31,16 +31,16 @@ test_expect_success \
 	echo 'zzz' > bar/zzz &&
 	echo '#!/bin/sh' > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
+	svn import -m 'import for git-svn' . \"\$svnrepo\" >/dev/null &&
 	cd .. &&
 	rm -rf import &&
-	git-svn init $svnrepo"
+	git-svn init \"\$svnrepo\""
 
 test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
 
-test_expect_success "checkout from svn" "svn co $svnrepo '$SVN_TREE'"
+test_expect_success "checkout from svn" "svn co \"\$svnrepo\" \"\$SVN_TREE\""
 
 name='try a deep --rmdir with a commit'
 test_expect_success "$name" "
@@ -51,8 +51,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch &&
-	svn up '$SVN_TREE' &&
-	test -d '$SVN_TREE'/dir && test ! -d '$SVN_TREE'/dir/a"
+	svn up \"\$SVN_TREE\" &&
+	test -d \"\$SVN_TREE\"/dir && test ! -d \"\$SVN_TREE\"/dir/a"
 
 
 name='detect node change from file to directory #1'
@@ -69,7 +69,7 @@ test_expect_success "$name" "
 
 name='detect node change from directory to file #1'
 test_expect_success "$name" "
-	rm -rf dir '$GIT_DIR'/index &&
+	rm -rf dir \"\$GIT_DIR\"/index &&
 	git checkout -f -b mybranch2 remotes/git-svn &&
 	mv bar/zzz zzz &&
 	rm -rf bar &&
@@ -83,7 +83,7 @@ test_expect_success "$name" "
 
 name='detect node change from file to directory #2'
 test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"\$GIT_DIR\"/index &&
 	git checkout -f -b mybranch3 remotes/git-svn &&
 	rm bar/zzz &&
 	git update-index --remove bar/zzz &&
@@ -97,7 +97,7 @@ test_expect_success "$name" "
 
 name='detect node change from directory to file #2'
 test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"\$GIT_DIR\"/index &&
 	git checkout -f -b mybranch4 remotes/git-svn &&
 	rm -rf dir &&
 	git update-index --remove -- dir/file &&
@@ -111,15 +111,15 @@ test_expect_success "$name" "
 
 name='remove executable bit from a file'
 test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+	rm -f \"\$GIT_DIR\"/index &&
 	git checkout -f -b mybranch5 remotes/git-svn &&
 	chmod -x exec.sh &&
 	git update-index exec.sh &&
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test ! -x '$SVN_TREE'/exec.sh"
+	svn up \"\$SVN_TREE\" &&
+	test ! -x \"\$SVN_TREE\"/exec.sh"
 
 
 name='add executable bit back file'
@@ -129,8 +129,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/exec.sh"
+	svn up \"\$SVN_TREE\" &&
+	test -x \"\$SVN_TREE\"/exec.sh"
 
 
 name='executable file becomes a symlink to bar/zzz (file)'
@@ -141,8 +141,8 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -L '$SVN_TREE'/exec.sh"
+	svn up \"\$SVN_TREE\" &&
+	test -L \"\$SVN_TREE\"/exec.sh"
 
 name='new symlink is added to a file that was also just made executable'
 
@@ -153,9 +153,9 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/bar/zzz &&
-	test -L '$SVN_TREE'/exec-2.sh"
+	svn up \"\$SVN_TREE\" &&
+	test -x \"\$SVN_TREE\"/bar/zzz &&
+	test -L \"\$SVN_TREE\"/exec-2.sh"
 
 name='modify a symlink to become a file'
 test_expect_success "$name" "
@@ -166,10 +166,10 @@ test_expect_success "$name" "
 	git commit -m '$name' &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -f '$SVN_TREE'/exec-2.sh &&
-	test ! -L '$SVN_TREE'/exec-2.sh &&
-	git diff help $SVN_TREE/exec-2.sh"
+	svn up \"\$SVN_TREE\" &&
+	test -f \"\$SVN_TREE\"/exec-2.sh &&
+	test ! -L \"\$SVN_TREE\"/exec-2.sh &&
+	git diff help \"\$SVN_TREE\"/exec-2.sh"
 
 if test "$have_utf8" = t
 then
@@ -190,7 +190,7 @@ name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init $svnrepo && git-svn fetch &&
+    "git-svn init \"\$svnrepo\" && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      git diff a b"
@@ -220,16 +220,16 @@ test_expect_success 'exit if remote refs are ambigious' "
 "
 
 test_expect_success 'exit if init-ing a would clobber a URL' "
-        svnadmin create ${PWD}/svnrepo2 &&
-        svn mkdir -m 'mkdir bar' ${svnrepo}2/bar &&
+        svnadmin create \"\${PWD}/svnrepo2\" &&
+        svn mkdir -m 'mkdir bar' \"\${svnrepo}2/bar\" &&
         git config --unset svn-remote.svn.fetch \
                                 '^bar:refs/remotes/git-svn$' &&
-	! git-svn init ${svnrepo}2/bar
+	! git-svn init \"\${svnrepo}2/bar\"
         "
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' "
-        git-svn init --minimize-url -i bar $svnrepo/bar &&
+        git-svn init --minimize-url -i bar \"\$svnrepo/bar\" &&
         git config --get svn-remote.svn.fetch \
                               '^bar:refs/remotes/bar$' &&
         git config --get svn-remote.svn.fetch \
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index d7a7047..fa8b7ee 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -52,7 +52,7 @@ EOF
 cd ..
 
 rm -rf import
-test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
+test_expect_success 'checkout working copy from svn' "svn co \"\$svnrepo\" test_wc"
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init \"\$svnrepo\""
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
 name='test svn:keywords ignoring'
@@ -92,7 +92,7 @@ test_expect_success "propset CR on crlf files" \
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	"git-svn fetch &&
 	 git pull . remotes/git-svn &&
-	 svn co $svnrepo new_wc"
+	 svn co \"\$svnrepo\" new_wc"
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 4e08083..8eaf7d3 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,12 +9,12 @@ test_expect_success 'initialize repo' "
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m 'import for git-svn' . $svnrepo &&
+	svn import -m 'import for git-svn' . \"\$svnrepo\" &&
 	cd ..
 	"
 
 test_expect_success 'mirror via git-svn' "
-	git-svn init $svnrepo &&
+	git-svn init \"\$svnrepo\" &&
 	git-svn fetch &&
 	git checkout -f -b test-rmdir remotes/git-svn
 	"
@@ -23,7 +23,7 @@ test_expect_success 'Try a commit on rmdir' "
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m 'remove another' &&
 	git-svn set-tree --rmdir HEAD &&
-	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
+	svn ls -R \"\$svnrepo\" | grep ^deeply/nested/directory/number/1
 	"
 
 
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index 0f0b0fd..c7734e6 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -6,34 +6,34 @@
 test_description='git-svn tracking removed top-level path'
 . ./lib-git-svn.sh
 
-test_expect_success 'make history for tracking' '
+test_expect_success 'make history for tracking' "
 	mkdir import &&
 	mkdir import/trunk &&
 	echo hello >> import/trunk/README &&
-	svn import -m initial import $svnrepo &&
+	svn import -m initial import \"\$svnrepo\" &&
 	rm -rf import &&
-	svn co $svnrepo/trunk trunk &&
+	svn co \"\$svnrepo\"/trunk trunk &&
 	echo bye bye >> trunk/README &&
-	svn rm -m "gone" $svnrepo/trunk &&
+	svn rm -m 'gone' \"\$svnrepo\"/trunk &&
 	rm -rf trunk &&
 	mkdir trunk &&
-	echo "new" > trunk/FOLLOWME &&
-	svn import -m "new trunk" trunk $svnrepo/trunk
-'
+	echo 'new' > trunk/FOLLOWME &&
+	svn import -m 'new trunk' trunk \"\$svnrepo\"/trunk
+"
 
-test_expect_success 'clone repo with git' '
-	git svn clone -s $svnrepo x &&
+test_expect_success 'clone repo with git' "
+	git svn clone -s \"\$svnrepo\" x &&
 	test -f x/FOLLOWME &&
 	test ! -f x/README
-'
+"
 
-test_expect_success 'make sure r2 still has old file' '
+test_expect_success 'make sure r2 still has old file' "
 	cd x &&
-		test -n "$(git svn find-rev r1)" &&
-		git reset --hard $(git svn find-rev r1) &&
+		test -n \"\$(git svn find-rev r1)\" &&
+		git reset --hard \$(git svn find-rev r1) &&
 		test -f README &&
 		test ! -f FOLLOWME &&
-		test x$(git svn find-rev r2) = x
-'
+		test x\$(git svn find-rev r2) = x
+"
 
 test_done
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 7ba7630..56b1704 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -11,9 +11,9 @@ test_expect_success 'initialize repo' "
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . \"\$svnrepo\" &&
 	cd .. &&
-	svn co $svnrepo wc &&
+	svn co \"\$svnrepo\" wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
@@ -27,7 +27,7 @@ test_expect_success 'initialize repo' "
 	"
 
 test_expect_success 'init and fetch a moved directory' "
-	git-svn init --minimize-url -i thunk $svnrepo/thunk &&
+	git-svn init --minimize-url -i thunk \"\$svnrepo\"/thunk &&
 	git-svn fetch -i thunk &&
 	test \"\`git rev-parse --verify refs/remotes/thunk@2\`\" \
            = \"\`git rev-parse --verify refs/remotes/thunk~1\`\" &&
@@ -38,7 +38,7 @@ test_expect_success 'init and fetch a moved directory' "
 	"
 
 test_expect_success 'init and fetch from one svn-remote' "
-        git config svn-remote.svn.url $svnrepo &&
+        git config svn-remote.svn.url \"\$svnrepo\" &&
         git config --add svn-remote.svn.fetch \
           trunk:refs/remotes/svn/trunk &&
         git config --add svn-remote.svn.fetch \
@@ -52,9 +52,9 @@ test_expect_success 'init and fetch from one svn-remote' "
 
 test_expect_success 'follow deleted parent' "
         (svn cp -m 'resurrecting trunk as junk' \
-               $svnrepo/trunk@2 $svnrepo/junk ||
+               \"\$svnrepo\"/trunk@2 \"\$svnrepo\"/junk ||
          svn cp -m 'resurrecting trunk as junk' \
-               -r2 $svnrepo/trunk $svnrepo/junk) &&
+               -r2 \"\$svnrepo\"/trunk \"\$svnrepo\"/junk) &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
@@ -67,10 +67,10 @@ test_expect_success 'follow deleted parent' "
 test_expect_success 'follow larger parent' "
         mkdir -p import/trunk/thunk/bump/thud &&
         echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m 'import a larger parent' import $svnrepo/larger-parent &&
-        svn cp -m 'hi' $svnrepo/larger-parent $svnrepo/another-larger &&
+        svn import -m 'import a larger parent' import \"\$svnrepo\"/larger-parent &&
+        svn cp -m 'hi' \"\$svnrepo\"/larger-parent \"\$svnrepo\"/another-larger &&
         git-svn init --minimize-url -i larger \
-          $svnrepo/another-larger/trunk/thunk/bump/thud &&
+          \"\$svnrepo\"/another-larger/trunk/thunk/bump/thud &&
         git-svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
@@ -83,23 +83,23 @@ test_expect_success 'follow larger parent' "
         "
 
 test_expect_success 'follow higher-level parent' "
-        svn mkdir -m 'follow higher-level parent' $svnrepo/blob &&
-        svn co $svnrepo/blob blob &&
+        svn mkdir -m 'follow higher-level parent' \"\$svnrepo\"/blob &&
+        svn co \"\$svnrepo\"/blob blob &&
         cd blob &&
                 echo hi > hi &&
                 svn add hi &&
                 svn commit -m 'hihi' &&
                 cd ..
-        svn mkdir -m 'new glob at top level' $svnrepo/glob &&
-        svn mv -m 'move blob down a level' $svnrepo/blob $svnrepo/glob/blob &&
-        git-svn init --minimize-url -i blob $svnrepo/glob/blob &&
+        svn mkdir -m 'new glob at top level' \"\$svnrepo\"/glob &&
+        svn mv -m 'move blob down a level' \"\$svnrepo\"/blob \"\$svnrepo\"/glob/blob &&
+        git-svn init --minimize-url -i blob \"\$svnrepo\"/glob/blob &&
         git-svn fetch -i blob
         "
 
 test_expect_success 'follow deleted directory' "
-	svn mv -m 'bye!' $svnrepo/glob/blob/hi $svnrepo/glob/blob/bye &&
-	svn rm -m 'remove glob' $svnrepo/glob &&
-	git-svn init --minimize-url -i glob $svnrepo/glob &&
+	svn mv -m 'bye!' \"\$svnrepo\"/glob/blob/hi \"\$svnrepo\"/glob/blob/bye &&
+	svn rm -m 'remove glob' \"\$svnrepo\"/glob &&
+	git-svn init --minimize-url -i glob \"\$svnrepo\"/glob &&
 	git-svn fetch -i glob &&
 	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
 	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
@@ -118,9 +118,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  echo 'bad delete test 2' > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
 	cd import &&
-	  svn import -m 'r9270 test' . $svnrepo/r9270 &&
+	  svn import -m 'r9270 test' . \"\$svnrepo\"/r9270 &&
 	cd .. &&
-	svn co $svnrepo/r9270/trunk/subversion/bindings/swig/perl r9270 &&
+	svn co \"\$svnrepo\"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
@@ -130,7 +130,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  svn commit -m 'reorg test' &&
 	cd .. &&
 	git-svn init --minimize-url -i r9270-t \
-	  $svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t &&
+	  \"\$svnrepo\"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-t &&
 	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
 	test \"\`git ls-tree --name-only r9270-t~1\`\" = \
@@ -138,9 +138,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	"
 
 test_expect_success "track initial change if it was only made to parent" "
-	svn cp -m 'wheee!' $svnrepo/r9270/trunk $svnrepo/r9270/drunk &&
+	svn cp -m 'wheee!' \"\$svnrepo\"/r9270/trunk \"\$svnrepo\"/r9270/drunk &&
 	git-svn init --minimize-url -i r9270-d \
-	  $svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t &&
+	  \"\$svnrepo\"/r9270/drunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-d &&
 	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
 	test \"\`git ls-tree --name-only r9270-t\`\" = \
@@ -150,7 +150,7 @@ test_expect_success "track initial change if it was only made to parent" "
 	"
 
 test_expect_success "track multi-parent paths" "
-	svn cp -m 'resurrect /glob' $svnrepo/r9270 $svnrepo/glob &&
+	svn cp -m 'resurrect /glob' \"\$svnrepo\"/r9270 \"\$svnrepo\"/glob &&
 	git-svn multi-fetch &&
 	test \`git cat-file commit refs/remotes/glob | \
 	       grep '^parent ' | wc -l\` -eq 2
@@ -161,8 +161,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" "
-	rm -r $GIT_DIR/svn $GIT_DIR/refs/remotes $GIT_DIR/logs &&
-	mkdir $GIT_DIR/svn &&
+	rm -r \"\$GIT_DIR/svn\" \"\$GIT_DIR/refs/remotes\" \"\$GIT_DIR/logs\" &&
+	mkdir \"\$GIT_DIR/svn\" &&
 	git-svn multi-fetch
 	"
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 318e172..4f7f9cc 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . \"\$svnrepo\" &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
@@ -26,17 +26,17 @@ prev=`git rev-parse --verify HEAD^1`
 
 test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
-	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
-	svn co $svnrepo wc &&
+	git-svn commit-diff -r1 '$prev' '$head' \"\$svnrepo\" &&
+	svn co \"\$svnrepo\" wc &&
 	cmp readme wc/readme
 	"
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
-	svn import -m 'sub-directory' import $svnrepo/subdir &&
-	git-svn init --minimize-url $svnrepo/subdir &&
+	svn import -m 'sub-directory' import \"\$svnrepo\"/subdir &&
+	git-svn init --minimize-url \"\$svnrepo\"/subdir &&
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
-	svn cat $svnrepo/subdir/readme > readme.2 &&
+	svn cat \"\$svnrepo\"/subdir/readme > readme.2 &&
 	cmp readme readme.2
 	"
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f74ab12..bb544f6 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -8,14 +8,14 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . \"\$svnrepo\" &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m 'initial'
 	"
 test_expect_success 'commit change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co \"\$svnrepo\" t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
@@ -27,7 +27,7 @@ test_expect_success 'commit change from svn side' "
 test_expect_success 'commit conflicting change from git' "
 	echo second line from git >> file &&
 	git commit -a -m 'second line from git' &&
-	! git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
+	! git-svn commit-diff -r1 HEAD~1 HEAD \"\$svnrepo\"
 "
 
 test_expect_success 'commit complementing change from git' "
@@ -36,14 +36,14 @@ test_expect_success 'commit complementing change from git' "
 	git commit -a -m 'second line from svn' &&
 	echo third line from git >> file &&
 	git commit -a -m 'third line from git' &&
-	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
+	git-svn commit-diff -r2 HEAD~1 HEAD \"\$svnrepo\"
 	"
 
 test_expect_success 'dcommit fails to commit because of conflict' "
-	git-svn init $svnrepo &&
+	git-svn init \"\$svnrepo\" &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
-	svn co $svnrepo t.svn &&
+	svn co \"\$svnrepo\" t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
@@ -67,7 +67,7 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	"
 
 test_expect_success 'commit another change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co \"\$svnrepo\" t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index ca8a00e..477755a 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -8,9 +8,9 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	awk 'BEGIN { for (i = 1; i < 64; i++) { print i } }' > file
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . \"\$svnrepo\" &&
 	cd .. &&
-	git svn init $svnrepo &&
+	git svn init \"\$svnrepo\" &&
 	git svn fetch &&
 	test -e file
 	"
@@ -18,7 +18,7 @@ test_expect_success 'initialize repo' "
 test_expect_success '(supposedly) non-conflicting change from SVN' "
 	test x\"\`sed -n -e 58p < file\`\" = x58 &&
 	test x\"\`sed -n -e 61p < file\`\" = x61 &&
-	svn co $svnrepo tmp &&
+	svn co \"\$svnrepo\" tmp &&
 	cd tmp &&
 		perl -i -p -e 's/^58\$/5588/' file &&
 		perl -i -p -e 's/^61\$/6611/' file &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 0a41d52..9ab7074 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -4,7 +4,7 @@ test_description='git-svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup old-looking metadata' "
-	cp $GIT_DIR/config $GIT_DIR/config-old-git-svn &&
+	cp \"\$GIT_DIR\"/config \"\$GIT_DIR\"/config-old-git-svn &&
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
@@ -12,13 +12,13 @@ test_expect_success 'setup old-looking metadata' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . \"\$svnrepo\"
 		cd .. &&
-	git-svn init $svnrepo &&
+	git-svn init \"\$svnrepo\" &&
 	git-svn fetch &&
-	mv $GIT_DIR/svn/* $GIT_DIR/ &&
-	mv $GIT_DIR/svn/.metadata $GIT_DIR/ &&
-	rmdir $GIT_DIR/svn &&
+	mv \"\$GIT_DIR\"/svn/* \"\$GIT_DIR\"/ &&
+	mv \"\$GIT_DIR\"/svn/.metadata \"\$GIT_DIR\"/ &&
+	rmdir \"\$GIT_DIR\"/svn &&
 	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
 	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
@@ -28,20 +28,20 @@ head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
 test_expect_success 'initialize old-style (v0) git-svn layout' "
-	mkdir -p $GIT_DIR/git-svn/info $GIT_DIR/svn/info &&
-	echo $svnrepo > $GIT_DIR/git-svn/info/url &&
-	echo $svnrepo > $GIT_DIR/svn/info/url &&
+	mkdir -p \"\$GIT_DIR\"/git-svn/info \"\$GIT_DIR\"/svn/info &&
+	echo \"\$svnrepo\" > \"\$GIT_DIR\"/git-svn/info/url &&
+	echo \"\$svnrepo\" > \"\$GIT_DIR\"/svn/info/url &&
 	git-svn migrate &&
-	! test -d $GIT_DIR/git-svn &&
+	! test -d \"\$GIT_DIR\"/git-svn &&
 	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
-	test \`git config --get svn-remote.svn.url\` = '$svnrepo' &&
+	test \"\$(git config --get svn-remote.svn.url)\" = \"\$svnrepo\" &&
 	test \`git config --get svn-remote.svn.fetch\` = \
              ':refs/remotes/git-svn'
 	"
 
 test_expect_success 'initialize a multi-repository repo' "
-	git-svn init $svnrepo -T trunk -t tags -b branches &&
+	git-svn init \"\$svnrepo\" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep '^trunk:refs/remotes/trunk$' fetch.out &&
 	test -n \"\`git config --get svn-remote.svn.branches \
@@ -76,14 +76,14 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 test_expect_success 'migrate --minimize on old inited layout' "
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
-	rm -rf $GIT_DIR/svn &&
+	rm -rf \"\$GIT_DIR\"/svn &&
 	for i in \`cat fetch.out\`; do
 		path=\`expr \$i : '\\([^:]*\\):.*$'\`
 		ref=\`expr \$i : '[^:]*:refs/remotes/\\(.*\\)$'\`
 		if test -z \"\$ref\"; then continue; fi
 		if test -n \"\$path\"; then path=\"/\$path\"; fi
-		( mkdir -p $GIT_DIR/svn/\$ref/info/ &&
-		echo $svnrepo\$path > $GIT_DIR/svn/\$ref/info/url ) || exit 1;
+		( mkdir -p \"\$GIT_DIR\"/svn/\$ref/info/ &&
+		echo \"\$svnrepo\"\$path > \"\$GIT_DIR\"/svn/\$ref/info/url ) || exit 1;
 	done &&
 	git-svn migrate --minimize &&
 	test -z \"\`git config -l |grep -v '^svn-remote\.git-svn\.'\`\" &&
@@ -99,17 +99,17 @@ test_expect_success 'migrate --minimize on old inited layout' "
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	expect=\"\$(ls $GIT_DIR/svn/trunk/.rev_map.*)\" &&
+	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	expect=\"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_map.*)\" &&
 	test -n \"\$expect\" &&
-	rev_db=\$(echo \$expect | sed -e 's,_map,_db,') &&
-	convert_to_rev_db \$expect \$rev_db &&
-	rm -f \$expect &&
-	test -f \$rev_db &&
+	rev_db=\"\$(echo \$expect | sed -e 's,_map,_db,')\" &&
+	convert_to_rev_db \"\$expect\" \"\$rev_db\" &&
+	rm -f \"\$expect\" &&
+	test -f \"\$rev_db\" &&
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	test ! -e $GIT_DIR/svn/trunk/.rev_db &&
-	test -f \$expect
+	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	test ! -e \"\$GIT_DIR\"/svn/trunk/.rev_db &&
+	test -f \"\$expect\"
 	"
 
 test_done
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index db4344c..8f03f2d 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -14,8 +14,8 @@ test_expect_success 'test refspec globbing' "
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo 'hello world' > trunk/src/a/readme &&
 	echo 'goodbye world' > trunk/src/b/readme &&
-	svn import -m 'initial' trunk $svnrepo/trunk &&
-	svn co $svnrepo tmp &&
+	svn import -m 'initial' trunk \"\$svnrepo\"/trunk &&
+	svn co \"\$svnrepo\" tmp &&
 	cd tmp &&
 		mkdir branches tags &&
 		svn add branches tags &&
@@ -38,7 +38,7 @@ test_expect_success 'test refspec globbing' "
 		poke tags/end/src/b/readme &&
 		svn commit -m 'nothing to see here'
 		cd .. &&
-	git config --add svn-remote.svn.url $svnrepo &&
+	git config --add svn-remote.svn.url \"\$svnrepo\" &&
 	git config --add svn-remote.svn.fetch \
 	                 'trunk/src/a:refs/remotes/trunk' &&
 	git config --add svn-remote.svn.branches \
@@ -60,7 +60,7 @@ echo nothing to see here >> expect.two
 cat expect.end >> expect.two
 
 test_expect_success 'test left-hand-side only globbing' "
-	git config --add svn-remote.two.url $svnrepo &&
+	git config --add svn-remote.two.url \"\$svnrepo\" &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
 	                 'branches/*:refs/remotes/two/branches/*' &&
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 6235af4..d9ac558 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -8,11 +8,11 @@ test_description='git-svn useSvmProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svm repo' "
-	svnadmin load -q $rawsvnrepo < ../t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/mirror/arr &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/mirror/argh &&
+	svnadmin load -q \"\$rawsvnrepo\" < ../t9110/svm.dump &&
+	git-svn init --minimize-url -R arr -i bar \"\$svnrepo\"/mirror/arr &&
+	git-svn init --minimize-url -R argh -i dir \"\$svnrepo\"/mirror/argh &&
 	git-svn init --minimize-url -R argh -i e \
-	  $svnrepo/mirror/argh/a/b/c/d/e &&
+	  \"\$svnrepo\"/mirror/argh/a/b/c/d/e &&
 	git config svn.useSvmProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index ec7dedd..77185bc 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -8,10 +8,10 @@ test_description='git-svn useSvnsyncProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svnsync repo' "
-	svnadmin load -q $rawsvnrepo < ../t9111/svnsync.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/bar &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/dir &&
-	git-svn init --minimize-url -R argh -i e $svnrepo/dir/a/b/c/d/e &&
+	svnadmin load -q \"\$rawsvnrepo\" < ../t9111/svnsync.dump &&
+	git-svn init --minimize-url -R arr -i bar \"\$svnrepo\"/bar &&
+	git-svn init --minimize-url -R argh -i dir \"\$svnrepo\"/dir &&
+	git-svn init --minimize-url -R argh -i e \"\$svnrepo\"/dir/a/b/c/d/e &&
 	git config svn.useSvnsyncProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 646a5f0..fb1491d 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -40,8 +40,8 @@ PROPS-END
 
 EOF
 
-test_expect_success 'load svn dumpfile' "svnadmin load $rawsvnrepo < dumpfile.svn"
+test_expect_success 'load svn dumpfile' "svnadmin load \"\$rawsvnrepo\" < dumpfile.svn"
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init \"\$svnrepo\""
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 9ef0db9..b92a64e 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -15,14 +15,14 @@ test_description='git-svn dcommit new files over svn:// test'
 
 start_svnserve () {
 	svnserve --listen-port $SVNSERVE_PORT \
-	         --root $rawsvnrepo \
+	         --root "$rawsvnrepo" \
 	         --listen-once \
 	         --listen-host 127.0.0.1 &
 }
 
 test_expect_success 'start tracking an empty repo' "
-	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
-	echo anon-access = write >> $rawsvnrepo/conf/svnserve.conf &&
+	svn mkdir -m 'empty dir' \"\$svnrepo\"/empty-dir &&
+	echo anon-access = write >> \"\$rawsvnrepo\"/conf/svnserve.conf &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
 	git svn fetch
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 225060b..74b971c 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -35,7 +35,7 @@ EOF
 }
 
 test_expect_success 'setup svn repository' "
-	svn co $svnrepo mysvnwork &&
+	svn co \"\$svnrepo\" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
@@ -45,7 +45,7 @@ test_expect_success 'setup svn repository' "
 	"
 
 test_expect_success 'setup git mirror and merge' "
-	git svn init $svnrepo -t tags -T trunk -b branches &&
+	git svn init \"\$svnrepo\" -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
 	git checkout -b merge &&
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..f83f4f9 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -8,12 +8,12 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	svnadmin load -q \"\$rawsvnrepo\" < ../t9115/funky-names.dump &&
 	start_httpd
 	"
 
 test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo &&
+	git svn init \"\$svnrepo\" &&
 	git svn fetch &&
 	git reset --hard git-svn
 	"
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index e1e8bdf..13081b8 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -14,9 +14,9 @@ test_expect_success 'setup repository and import' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . \"\$svnrepo\"
 		cd .. &&
-	git-svn init $svnrepo -T trunk -b branches -t tags &&
+	git-svn init \"\$svnrepo\" -T trunk -b branches -t tags &&
 	git-svn fetch &&
 	git reset --hard trunk &&
 	echo bye >> README &&
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index d482b40..c924915 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -16,13 +16,13 @@ cd tmp
 test_expect_success 'setup svnrepo' "
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project $svnrepo/project &&
+	svn import -m '$test_description' project \"\$svnrepo\"/project &&
 	rm -rf project
 	"
 
 test_expect_success 'basic clone' "
 	test ! -d trunk &&
-	git svn clone $svnrepo/project/trunk &&
+	git svn clone \"\$svnrepo\"/project/trunk &&
 	test -d trunk/.git/svn &&
 	test -e trunk/foo &&
 	rm -rf trunk
@@ -30,7 +30,7 @@ test_expect_success 'basic clone' "
 
 test_expect_success 'clone to target directory' "
 	test ! -d target &&
-	git svn clone $svnrepo/project/trunk target &&
+	git svn clone \"\$svnrepo\"/project/trunk target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
@@ -38,7 +38,7 @@ test_expect_success 'clone to target directory' "
 
 test_expect_success 'clone with --stdlayout' "
 	test ! -d project &&
-	git svn clone -s $svnrepo/project &&
+	git svn clone -s \"\$svnrepo\"/project &&
 	test -d project/.git/svn &&
 	test -e project/foo &&
 	rm -rf project
@@ -46,7 +46,7 @@ test_expect_success 'clone with --stdlayout' "
 
 test_expect_success 'clone to target directory with --stdlayout' "
 	test ! -d target &&
-	git svn clone -s $svnrepo/project target &&
+	git svn clone -s \"\$svnrepo\"/project target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 640bb06..0f107fc 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -9,17 +9,17 @@ test_description='git-svn funky branch names'
 test_expect_success 'setup svnrepo' "
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project \"$svnrepo/pr ject\" &&
+	svn import -m '\$test_description' project \"\$svnrepo/pr ject\" &&
 	rm -rf project &&
-	svn cp -m 'fun' \"$svnrepo/pr ject/trunk\" \
-	                \"$svnrepo/pr ject/branches/fun plugin\" &&
-	svn cp -m 'more fun!' \"$svnrepo/pr ject/branches/fun plugin\" \
-	                      \"$svnrepo/pr ject/branches/more fun plugin!\" &&
+	svn cp -m 'fun' \"\$svnrepo/pr ject/trunk\" \
+	                \"\$svnrepo/pr ject/branches/fun plugin\" &&
+	svn cp -m 'more fun!' \"\$svnrepo/pr ject/branches/fun plugin\" \
+	                      \"\$svnrepo/pr ject/branches/more fun plugin!\" &&
 	start_httpd
 	"
 
 test_expect_success 'test clone with funky branch names' "
-	git svn clone -s \"$svnrepo/pr ject\" project &&
+	git svn clone -s \"\$svnrepo/pr ject\" project &&
 	cd project &&
 		git rev-parse 'refs/remotes/fun%20plugin' &&
 		git rev-parse 'refs/remotes/more%20fun%20plugin!' &&
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 9a4eabe..1414c0f 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -9,7 +9,7 @@ test_description='git-svn clone with percent escapes'
 test_expect_success 'setup svnrepo' "
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project '$svnrepo/pr ject' &&
+	svn import -m \"\$test_description\" project \"\$svnrepo/pr ject\" &&
 	rm -rf project &&
 	start_httpd
 "
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 796cd7d..0f36e6c 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -10,6 +10,7 @@ commandline, and checks that it would not write any errors
 or warnings to log.'
 
 gitweb_init () {
+	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
 	cat >gitweb_config.perl <<EOF
 #!/usr/bin/perl
 
@@ -17,16 +18,16 @@ gitweb_init () {
 
 our \$version = "current";
 our \$GIT = "git";
-our \$projectroot = "$(pwd)";
+our \$projectroot = "$safe_pwd";
 our \$project_maxdepth = 8;
 our \$home_link_str = "projects";
 our \$site_name = "[localhost]";
 our \$site_header = "";
 our \$site_footer = "";
 our \$home_text = "indextext.html";
-our @stylesheets = ("file:///$(pwd)/../../gitweb/gitweb.css");
-our \$logo = "file:///$(pwd)/../../gitweb/git-logo.png";
-our \$favicon = "file:///$(pwd)/../../gitweb/git-favicon.png";
+our @stylesheets = ("file:///$safe_pwd/../../gitweb/gitweb.css");
+our \$logo = "file:///$safe_pwd/../../gitweb/git-logo.png";
+our \$favicon = "file:///$safe_pwd/../../gitweb/git-favicon.png";
 our \$projects_list = "";
 our \$export_ok = "";
 our \$strict_export = "";
@@ -45,13 +46,13 @@ gitweb_run () {
 	export QUERY_STRING=""$1""
 	export PATH_INFO=""$2""
 
-	export GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+	export GITWEB_CONFIG="$(pwd)/gitweb_config.perl"
 
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- $(pwd)/../../gitweb/gitweb.perl \
+	perl -- "$(pwd)/../../gitweb/gitweb.perl" \
 		>/dev/null 2>gitweb.log &&
 	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
 
-- 
1.5.5.8.gbbd98
