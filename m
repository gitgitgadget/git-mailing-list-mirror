From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 09/10] Fix tests breaking when checkout path contains shell metacharacters
Date: Sun,  4 May 2008 01:37:59 -0400
Message-ID: <1209879480-16910-10-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-7-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-8-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-9-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWwd-0004V4-Um
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYEDFiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYEDFiR
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:17 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37789 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYEDFiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:13 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mk-Ue; Sun, 04 May 2008 05:38:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvB-0004PN-GC; Sun, 04 May 2008 01:38:01 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-9-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81140>

This fixes the remainder of the issues where the test script itself is at
fault for failing when the git checkout path contains whitespace or other
shell metacharacters.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/t0000-basic.sh                              |    4 +-
 t/t1020-subdirectory.sh                       |   22 ++--
 t/t3050-subprojects-fetch.sh                  |    2 +-
 t/t3404-rebase-interactive.sh                 |    3 +-
 t/t5500-fetch-pack.sh                         |    2 +-
 t/t5512-ls-remote.sh                          |    2 +-
 t/t5516-fetch-push.sh                         |    6 +-
 t/t5700-clone-reference.sh                    |    2 +-
 t/t5710-info-alternate.sh                     |    4 +-
 t/t7003-filter-branch.sh                      |    2 +-
 t/t7010-setup.sh                              |    2 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7501-commit.sh                             |    8 +-
 t/t7504-commit-msg-hook.sh                    |   23 ++--
 t/t7505-prepare-commit-msg-hook.sh            |   17 ++-
 t/t9100-git-svn-basic.sh                      |  120 +++++++++---------
 t/t9101-git-svn-props.sh                      |    8 +-
 t/t9102-git-svn-deep-rmdir.sh                 |   20 ++--
 t/t9103-git-svn-tracked-directory-removed.sh  |   20 ++--
 t/t9104-git-svn-follow-parent.sh              |  172 ++++++++++++------------
 t/t9105-git-svn-commit-diff.sh                |   32 +++---
 t/t9106-git-svn-commit-diff-clobber.sh        |   56 ++++----
 t/t9106-git-svn-dcommit-clobber-series.sh     |   30 ++--
 t/t9107-git-svn-migrate.sh                    |  124 +++++++++---------
 t/t9108-git-svn-glob.sh                       |   76 ++++++------
 t/t9110-git-svn-use-svm-props.sh              |   12 +-
 t/t9111-git-svn-use-svnsync-props.sh          |   12 +-
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |   10 +-
 t/t9114-git-svn-dcommit-merge.sh              |   22 ++--
 t/t9115-git-svn-dcommit-funky-renames.sh      |   12 +-
 t/t9116-git-svn-log.sh                        |   12 +-
 t/t9117-git-svn-init-clone.sh                 |   30 ++--
 t/t9118-git-svn-funky-branch-names.sh         |   24 ++--
 t/t9120-git-svn-clone-with-percent-escapes.sh |    6 +-
 t/t9500-gitweb-standalone-no-errors.sh        |   11 +-
 36 files changed, 460 insertions(+), 454 deletions(-)

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
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index b9cef34..fc386ba 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -21,7 +21,7 @@ LF='
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
index 1700d07..140e874 100755
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
index 0a757d5..3af03d4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -105,7 +105,7 @@ test_expect_success 'fetch with insteadOf' '
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
-		git config url.$TRASH.insteadOf trash/
+		git config "url.$TRASH.insteadOf" trash/ &&
 		git config remote.up.url trash/. &&
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
@@ -145,8 +145,8 @@ test_expect_success 'push with wildcard' '
 
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
-	TRASH=$(pwd)/ &&
-	git config url.$TRASH.insteadOf trash/ &&
+	TRASH="$(pwd)/" &&
+	git config "url./$TRASH/.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index b6a5486..e5619a9 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -51,7 +51,7 @@ diff expected current'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'git clone --reference B file://`pwd`/A D'
+'git clone --reference B "file://$(pwd)/A" D'
 
 cd "$base_dir"
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 910ccb4..ef7127c 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -81,9 +81,9 @@ test_valid_repo'
 cd "$base_dir"
 
 test_expect_success 'breaking of loops' \
-"echo '$base_dir/B/.git/objects' >> '$base_dir'/A/.git/objects/info/alternates&&
+'echo "$base_dir"/B/.git/objects >> "$base_dir"/A/.git/objects/info/alternates&&
 cd C &&
-test_valid_repo"
+test_valid_repo'
 
 cd "$base_dir"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index efd658a..fd09030 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -125,7 +125,7 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
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
index a50492f..bd77239 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -112,7 +112,7 @@ test_expect_success 'git-clean with absolute path' '
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
index eff36aa..88577af 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -19,6 +19,9 @@ cp FAKE_MSG "$1"
 exit 0
 EOF
 chmod +x fake-editor
+
+## Not using test_set_editor here so we can easily ensure the editor variable
+## is only set for the editor tests
 FAKE_EDITOR="$(pwd)/fake-editor"
 export FAKE_EDITOR
 
@@ -27,7 +30,7 @@ test_expect_success 'with no hook (editor)' '
 	echo "more foo" >> file &&
 	git add file &&
 	echo "more foo" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit
 
 '
 
@@ -44,7 +47,7 @@ test_expect_success '--no-verify with no hook (editor)' '
 	echo "more bar" > file &&
 	git add file &&
 	echo "more bar" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -71,7 +74,7 @@ test_expect_success 'with succeeding hook (editor)' '
 	echo "more more" >> file &&
 	git add file &&
 	echo "more more" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit
 
 '
 
@@ -88,7 +91,7 @@ test_expect_success '--no-verify with succeeding hook (editor)' '
 	echo "even more more" >> file &&
 	git add file &&
 	echo "even more more" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -111,7 +114,7 @@ test_expect_success 'with failing hook (editor)' '
 	echo "more another" >> file &&
 	git add file &&
 	echo "more another" > FAKE_MSG &&
-	! (GIT_EDITOR="$FAKE_EDITOR" git commit)
+	! (GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit)
 
 '
 
@@ -128,7 +131,7 @@ test_expect_success '--no-verify with failing hook (editor)' '
 	echo "more stuff" >> file &&
 	git add file &&
 	echo "more stuff" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -146,7 +149,7 @@ test_expect_success 'with non-executable hook (editor)' '
 	echo "content again" >> file &&
 	git add file &&
 	echo "content again" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -m "content again"
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -m "content again"
 
 '
 
@@ -163,7 +166,7 @@ test_expect_success '--no-verify with non-executable hook (editor)' '
 	echo "even more content" >> file &&
 	git add file &&
 	echo "even more content" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
 
 '
 
@@ -193,7 +196,7 @@ test_expect_success 'hook edits commit message (editor)' '
 	echo "additional content" >> file &&
 	git add file &&
 	echo "additional content" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
 	commit_msg_is "new message"
 
 '
@@ -212,7 +215,7 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 	echo "more plus" >> file &&
 	git add file &&
 	echo "more plus" > FAKE_MSG &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify &&
 	commit_msg_is "more plus"
 
 '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 802aa62..cd6c7c8 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -18,6 +18,9 @@ cat > fake-editor <<'EOF'
 exit 0
 EOF
 chmod +x fake-editor
+
+## Not using test_set_editor here so we can easily ensure the editor variable
+## is only set for the editor tests
 FAKE_EDITOR="$(pwd)/fake-editor"
 export FAKE_EDITOR
 
@@ -58,7 +61,7 @@ test_expect_success 'with hook (-m editor)' '
 
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -e -m "more more" &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -e -m "more more" &&
 	test "`git log -1 --pretty=format:%s`" = message
 
 '
@@ -85,7 +88,7 @@ test_expect_success 'with hook (-F editor)' '
 
 	echo "more" >> file &&
 	git add file &&
-	(echo more more | GIT_EDITOR="$FAKE_EDITOR" git commit -e -F -) &&
+	(echo more more | GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -e -F -) &&
 	test "`git log -1 --pretty=format:%s`" = message
 
 '
@@ -104,7 +107,7 @@ test_expect_success 'with hook (editor)' '
 
 	echo "more more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit &&
 	test "`git log -1 --pretty=format:%s`" = default
 
 '
@@ -114,7 +117,7 @@ test_expect_success 'with hook (--amend)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit --amend &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --amend &&
 	test "`git log -1 --pretty=format:%s`" = "$head"
 
 '
@@ -124,7 +127,7 @@ test_expect_success 'with hook (-c)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	GIT_EDITOR="$FAKE_EDITOR" git commit -c $head &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head &&
 	test "`git log -1 --pretty=format:%s`" = "$head"
 
 '
@@ -139,7 +142,7 @@ test_expect_success 'with failing hook' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="$FAKE_EDITOR" git commit -c $head
+	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
 
 '
 
@@ -148,7 +151,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify -c $head
+	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
 
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4e24ab3..bdf29c1 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -20,39 +20,39 @@ esac
 echo 'define NO_SVN_TESTS to skip git-svn tests'
 
 test_expect_success \
-    'initialize git-svn' "
+    'initialize git-svn' '
 	mkdir import &&
 	cd import &&
 	echo foo > foo &&
 	ln -s foo foo.link
 	mkdir -p dir/a/b/c/d/e &&
-	echo 'deep dir' > dir/a/b/c/d/e/file &&
+	echo "deep dir" > dir/a/b/c/d/e/file &&
 	mkdir bar &&
-	echo 'zzz' > bar/zzz &&
-	echo '#!/bin/sh' > exec.sh &&
+	echo "zzz" > bar/zzz &&
+	echo "#!/bin/sh" > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
+	svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
 	cd .. &&
 	rm -rf import &&
-	git-svn init $svnrepo"
+	git-svn init "$svnrepo"'
 
 test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
 
-test_expect_success "checkout from svn" "svn co $svnrepo '$SVN_TREE'"
+test_expect_success "checkout from svn" 'svn co "$svnrepo" "$SVN_TREE"'
 
 name='try a deep --rmdir with a commit'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	git checkout -f -b mybranch remotes/git-svn &&
 	mv dir/a/b/c/d/e/file dir/file &&
 	cp dir/file file &&
 	git update-index --add --remove dir/a/b/c/d/e/file dir/file file &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch &&
-	svn up '$SVN_TREE' &&
-	test -d '$SVN_TREE'/dir && test ! -d '$SVN_TREE'/dir/a"
+	svn up "$SVN_TREE" &&
+	test -d "$SVN_TREE"/dir && test ! -d "$SVN_TREE"/dir/a'
 
 
 name='detect node change from file to directory #1'
@@ -68,108 +68,108 @@ test_expect_success "$name" "
 
 
 name='detect node change from directory to file #1'
-test_expect_success "$name" "
-	rm -rf dir '$GIT_DIR'/index &&
+test_expect_success "$name" '
+	rm -rf dir "$GIT_DIR"/index &&
 	git checkout -f -b mybranch2 remotes/git-svn &&
 	mv bar/zzz zzz &&
 	rm -rf bar &&
 	mv zzz bar &&
 	git update-index --remove -- bar/zzz &&
 	git update-index --add -- bar &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	! git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch2" || true
+		remotes/git-svn..mybranch2' || true
 
 
 name='detect node change from file to directory #2'
-test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+test_expect_success "$name" '
+	rm -f "$GIT_DIR"/index &&
 	git checkout -f -b mybranch3 remotes/git-svn &&
 	rm bar/zzz &&
 	git update-index --remove bar/zzz &&
 	mkdir bar/zzz &&
 	echo yyy > bar/zzz/yyy &&
 	git update-index --add bar/zzz/yyy &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	! git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch3" || true
+		remotes/git-svn..mybranch3' || true
 
 
 name='detect node change from directory to file #2'
-test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+test_expect_success "$name" '
+	rm -f "$GIT_DIR"/index &&
 	git checkout -f -b mybranch4 remotes/git-svn &&
 	rm -rf dir &&
 	git update-index --remove -- dir/file &&
 	touch dir &&
 	echo asdf > dir &&
 	git update-index --add -- dir &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	! git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch4" || true
+		remotes/git-svn..mybranch4' || true
 
 
 name='remove executable bit from a file'
-test_expect_success "$name" "
-	rm -f '$GIT_DIR'/index &&
+test_expect_success "$name" '
+	rm -f "$GIT_DIR"/index &&
 	git checkout -f -b mybranch5 remotes/git-svn &&
 	chmod -x exec.sh &&
 	git update-index exec.sh &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test ! -x '$SVN_TREE'/exec.sh"
+	svn up "$SVN_TREE" &&
+	test ! -x "$SVN_TREE"/exec.sh'
 
 
 name='add executable bit back file'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	chmod +x exec.sh &&
 	git update-index exec.sh &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/exec.sh"
+	svn up "$SVN_TREE" &&
+	test -x "$SVN_TREE"/exec.sh'
 
 
 name='executable file becomes a symlink to bar/zzz (file)'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	rm exec.sh &&
 	ln -s bar/zzz exec.sh &&
 	git update-index exec.sh &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -L '$SVN_TREE'/exec.sh"
+	svn up "$SVN_TREE" &&
+	test -L "$SVN_TREE"/exec.sh'
 
 name='new symlink is added to a file that was also just made executable'
 
-test_expect_success "$name" "
+test_expect_success "$name" '
 	chmod +x bar/zzz &&
 	ln -s bar/zzz exec-2.sh &&
 	git update-index --add bar/zzz exec-2.sh &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -x '$SVN_TREE'/bar/zzz &&
-	test -L '$SVN_TREE'/exec-2.sh"
+	svn up "$SVN_TREE" &&
+	test -x "$SVN_TREE"/bar/zzz &&
+	test -L "$SVN_TREE"/exec-2.sh'
 
 name='modify a symlink to become a file'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	echo git help > help || true &&
 	rm exec-2.sh &&
 	cp help exec-2.sh &&
 	git update-index exec-2.sh &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch5 &&
-	svn up '$SVN_TREE' &&
-	test -f '$SVN_TREE'/exec-2.sh &&
-	test ! -L '$SVN_TREE'/exec-2.sh &&
-	git diff help $SVN_TREE/exec-2.sh"
+	svn up "$SVN_TREE" &&
+	test -f "$SVN_TREE"/exec-2.sh &&
+	test ! -L "$SVN_TREE"/exec-2.sh &&
+	git diff help "$SVN_TREE"/exec-2.sh'
 
 if test "$have_utf8" = t
 then
@@ -190,10 +190,10 @@ name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init $svnrepo && git-svn fetch &&
+    'git-svn init "$svnrepo" && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
-     git diff a b"
+     git diff a b'
 
 name='check imported tree checksums expected tree checksums'
 rm -f expected
@@ -219,22 +219,22 @@ test_expect_success 'exit if remote refs are ambigious' "
 	! git-svn migrate
 "
 
-test_expect_success 'exit if init-ing a would clobber a URL' "
-        svnadmin create ${PWD}/svnrepo2 &&
-        svn mkdir -m 'mkdir bar' ${svnrepo}2/bar &&
+test_expect_success 'exit if init-ing a would clobber a URL' '
+        svnadmin create "${PWD}/svnrepo2" &&
+        svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
         git config --unset svn-remote.svn.fetch \
-                                '^bar:refs/remotes/git-svn$' &&
-	! git-svn init ${svnrepo}2/bar
-        "
+                                "^bar:refs/remotes/git-svn$" &&
+	! git-svn init "${svnrepo}2/bar"
+        '
 
 test_expect_success \
-  'init allows us to connect to another directory in the same repo' "
-        git-svn init --minimize-url -i bar $svnrepo/bar &&
+  'init allows us to connect to another directory in the same repo' '
+        git-svn init --minimize-url -i bar "$svnrepo/bar" &&
         git config --get svn-remote.svn.fetch \
-                              '^bar:refs/remotes/bar$' &&
+                              "^bar:refs/remotes/bar$" &&
         git config --get svn-remote.svn.fetch \
-                              '^:refs/remotes/git-svn$'
-        "
+                              "^:refs/remotes/git-svn$"
+        '
 
 test_expect_success 'able to dcommit to a subdirectory' "
 	git-svn fetch -i bar &&
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index d7a7047..f420796 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -52,7 +52,7 @@ EOF
 cd ..
 
 rm -rf import
-test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
+test_expect_success 'checkout working copy from svn' 'svn co "$svnrepo" test_wc'
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' 'git-svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
 name='test svn:keywords ignoring'
@@ -90,9 +90,9 @@ test_expect_success "propset CR on crlf files" \
 	 cd ..'
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
-	"git-svn fetch &&
+	'git-svn fetch &&
 	 git pull . remotes/git-svn &&
-	 svn co $svnrepo new_wc"
+	 svn co "$svnrepo" new_wc'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 4e08083..0e7ce34 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -2,29 +2,29 @@
 test_description='git-svn rmdir'
 . ./lib-git-svn.sh
 
-test_expect_success 'initialize repo' "
+test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	mkdir -p deeply/nested/directory/number/1 &&
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m 'import for git-svn' . $svnrepo &&
+	svn import -m "import for git-svn" . "$svnrepo" &&
 	cd ..
-	"
+	'
 
-test_expect_success 'mirror via git-svn' "
-	git-svn init $svnrepo &&
+test_expect_success 'mirror via git-svn' '
+	git-svn init "$svnrepo" &&
 	git-svn fetch &&
 	git checkout -f -b test-rmdir remotes/git-svn
-	"
+	'
 
-test_expect_success 'Try a commit on rmdir' "
+test_expect_success 'Try a commit on rmdir' '
 	git rm -f deeply/nested/directory/number/2/another &&
-	git commit -a -m 'remove another' &&
+	git commit -a -m "remove another" &&
 	git-svn set-tree --rmdir HEAD &&
-	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
-	"
+	svn ls -R "$svnrepo" | grep ^deeply/nested/directory/number/1
+	'
 
 
 test_done
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index 0f0b0fd..9ffd845 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -10,30 +10,30 @@ test_expect_success 'make history for tracking' '
 	mkdir import &&
 	mkdir import/trunk &&
 	echo hello >> import/trunk/README &&
-	svn import -m initial import $svnrepo &&
+	svn import -m initial import "$svnrepo" &&
 	rm -rf import &&
-	svn co $svnrepo/trunk trunk &&
+	svn co "$svnrepo"/trunk trunk &&
 	echo bye bye >> trunk/README &&
-	svn rm -m "gone" $svnrepo/trunk &&
+	svn rm -m "gone" "$svnrepo"/trunk &&
 	rm -rf trunk &&
 	mkdir trunk &&
 	echo "new" > trunk/FOLLOWME &&
-	svn import -m "new trunk" trunk $svnrepo/trunk
+	svn import -m "new trunk" trunk "$svnrepo"/trunk
 '
 
 test_expect_success 'clone repo with git' '
-	git svn clone -s $svnrepo x &&
+	git svn clone -s "$svnrepo" x &&
 	test -f x/FOLLOWME &&
 	test ! -f x/README
 '
 
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
index 7ba7630..4d964e2 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -6,165 +6,165 @@
 test_description='git-svn fetching'
 . ./lib-git-svn.sh
 
-test_expect_success 'initialize repo' "
+test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
-	svn co $svnrepo wc &&
+	svn co "$svnrepo" wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
-	svn commit -m 'another commit' &&
+	svn commit -m "another commit" &&
 	svn up &&
 	svn mv trunk thunk &&
 	echo goodbye >> thunk/readme &&
 	poke thunk/readme &&
-	svn commit -m 'bye now' &&
+	svn commit -m "bye now" &&
 	cd ..
-	"
+	'
 
-test_expect_success 'init and fetch a moved directory' "
-	git-svn init --minimize-url -i thunk $svnrepo/thunk &&
+test_expect_success 'init and fetch a moved directory' '
+	git-svn init --minimize-url -i thunk "$svnrepo"/thunk &&
 	git-svn fetch -i thunk &&
-	test \"\`git rev-parse --verify refs/remotes/thunk@2\`\" \
-           = \"\`git rev-parse --verify refs/remotes/thunk~1\`\" &&
-        test \"\`git cat-file blob refs/remotes/thunk:readme |\
-                 sed -n -e '3p'\`\" = goodbye &&
-	test -z \"\`git config --get svn-remote.svn.fetch \
-	         '^trunk:refs/remotes/thunk@2$'\`\"
-	"
+	test "`git rev-parse --verify refs/remotes/thunk@2`" \
+           = "`git rev-parse --verify refs/remotes/thunk~1`" &&
+        test "`git cat-file blob refs/remotes/thunk:readme |\
+                 sed -n -e "3p"`" = goodbye &&
+	test -z "`git config --get svn-remote.svn.fetch \
+	         "^trunk:refs/remotes/thunk@2$"`"
+	'
 
-test_expect_success 'init and fetch from one svn-remote' "
-        git config svn-remote.svn.url $svnrepo &&
+test_expect_success 'init and fetch from one svn-remote' '
+        git config svn-remote.svn.url "$svnrepo" &&
         git config --add svn-remote.svn.fetch \
           trunk:refs/remotes/svn/trunk &&
         git config --add svn-remote.svn.fetch \
           thunk:refs/remotes/svn/thunk &&
         git-svn fetch -i svn/thunk &&
-	test \"\`git rev-parse --verify refs/remotes/svn/trunk\`\" \
-           = \"\`git rev-parse --verify refs/remotes/svn/thunk~1\`\" &&
-        test \"\`git cat-file blob refs/remotes/svn/thunk:readme |\
-                 sed -n -e '3p'\`\" = goodbye
-        "
+	test "`git rev-parse --verify refs/remotes/svn/trunk`" \
+           = "`git rev-parse --verify refs/remotes/svn/thunk~1`" &&
+        test "`git cat-file blob refs/remotes/svn/thunk:readme |\
+                 sed -n -e "3p"`" = goodbye
+        '
 
-test_expect_success 'follow deleted parent' "
-        (svn cp -m 'resurrecting trunk as junk' \
-               $svnrepo/trunk@2 $svnrepo/junk ||
-         svn cp -m 'resurrecting trunk as junk' \
-               -r2 $svnrepo/trunk $svnrepo/junk) &&
+test_expect_success 'follow deleted parent' '
+        (svn cp -m "resurrecting trunk as junk" \
+               "$svnrepo"/trunk@2 "$svnrepo"/junk ||
+         svn cp -m "resurrecting trunk as junk" \
+               -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
         git-svn fetch -i svn/junk &&
-        test -z \"\`git diff svn/junk svn/trunk\`\" &&
-        test \"\`git merge-base svn/junk svn/trunk\`\" \
-           = \"\`git rev-parse svn/trunk\`\"
-        "
+        test -z "`git diff svn/junk svn/trunk`" &&
+        test "`git merge-base svn/junk svn/trunk`" \
+           = "`git rev-parse svn/trunk`"
+        '
 
-test_expect_success 'follow larger parent' "
+test_expect_success 'follow larger parent' '
         mkdir -p import/trunk/thunk/bump/thud &&
         echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m 'import a larger parent' import $svnrepo/larger-parent &&
-        svn cp -m 'hi' $svnrepo/larger-parent $svnrepo/another-larger &&
+        svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
+        svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
         git-svn init --minimize-url -i larger \
-          $svnrepo/another-larger/trunk/thunk/bump/thud &&
+          "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
         git-svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
            refs/remotes/larger-parent/trunk/thunk/bump/thud &&
-        test \"\`git merge-base \
+        test "`git merge-base \
                  refs/remotes/larger-parent/trunk/thunk/bump/thud \
-                 refs/remotes/larger\`\" = \
-             \"\`git rev-parse refs/remotes/larger\`\"
+                 refs/remotes/larger`" = \
+             "`git rev-parse refs/remotes/larger`"
         true
-        "
+        '
 
-test_expect_success 'follow higher-level parent' "
-        svn mkdir -m 'follow higher-level parent' $svnrepo/blob &&
-        svn co $svnrepo/blob blob &&
+test_expect_success 'follow higher-level parent' '
+        svn mkdir -m "follow higher-level parent" "$svnrepo"/blob &&
+        svn co "$svnrepo"/blob blob &&
         cd blob &&
                 echo hi > hi &&
                 svn add hi &&
-                svn commit -m 'hihi' &&
+                svn commit -m "hihi" &&
                 cd ..
-        svn mkdir -m 'new glob at top level' $svnrepo/glob &&
-        svn mv -m 'move blob down a level' $svnrepo/blob $svnrepo/glob/blob &&
-        git-svn init --minimize-url -i blob $svnrepo/glob/blob &&
+        svn mkdir -m "new glob at top level" "$svnrepo"/glob &&
+        svn mv -m "move blob down a level" "$svnrepo"/blob "$svnrepo"/glob/blob &&
+        git-svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
         git-svn fetch -i blob
-        "
+        '
 
-test_expect_success 'follow deleted directory' "
-	svn mv -m 'bye!' $svnrepo/glob/blob/hi $svnrepo/glob/blob/bye &&
-	svn rm -m 'remove glob' $svnrepo/glob &&
-	git-svn init --minimize-url -i glob $svnrepo/glob &&
+test_expect_success 'follow deleted directory' '
+	svn mv -m "bye!" "$svnrepo"/glob/blob/hi "$svnrepo"/glob/blob/bye &&
+	svn rm -m "remove glob" "$svnrepo"/glob &&
+	git-svn init --minimize-url -i glob "$svnrepo"/glob &&
 	git-svn fetch -i glob &&
-	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
-	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
-	"
+	test "`git cat-file blob refs/remotes/glob:blob/bye`" = hi &&
+	test "`git ls-tree refs/remotes/glob | wc -l `" -eq 1
+	'
 
 # ref: r9270 of the Subversion repository: (http://svn.collab.net/repos/svn)
 # in trunk/subversion/bindings/swig/perl
-test_expect_success 'follow-parent avoids deleting relevant info' "
+test_expect_success 'follow-parent avoids deleting relevant info' '
 	mkdir -p import/trunk/subversion/bindings/swig/perl/t &&
 	for i in a b c ; do \
-	  echo \$i > import/trunk/subversion/bindings/swig/perl/\$i.pm &&
-	  echo _\$i > import/trunk/subversion/bindings/swig/perl/t/\$i.t; \
+	  echo $i > import/trunk/subversion/bindings/swig/perl/$i.pm &&
+	  echo _$i > import/trunk/subversion/bindings/swig/perl/t/$i.t; \
 	done &&
-	  echo 'bad delete test' > \
+	  echo "bad delete test" > \
 	   import/trunk/subversion/bindings/swig/perl/t/larger-parent &&
-	  echo 'bad delete test 2' > \
+	  echo "bad delete test 2" > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
 	cd import &&
-	  svn import -m 'r9270 test' . $svnrepo/r9270 &&
+	  svn import -m "r9270 test" . "$svnrepo"/r9270 &&
 	cd .. &&
-	svn co $svnrepo/r9270/trunk/subversion/bindings/swig/perl r9270 &&
+	svn co "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
-	  for i in a b c; do svn mv \$i.pm native/\$i.pm; done &&
+	  for i in a b c; do svn mv $i.pm native/$i.pm; done &&
 	  echo z >> native/t/c.t &&
 	  poke native/t/c.t &&
-	  svn commit -m 'reorg test' &&
+	  svn commit -m "reorg test" &&
 	cd .. &&
 	git-svn init --minimize-url -i r9270-t \
-	  $svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t &&
+	  "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-t &&
-	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
-	test \"\`git ls-tree --name-only r9270-t~1\`\" = \
-	     \"\`git ls-tree --name-only r9270-t\`\"
-	"
+	test `git rev-list r9270-t | wc -l` -eq 2 &&
+	test "`git ls-tree --name-only r9270-t~1`" = \
+	     "`git ls-tree --name-only r9270-t`"
+	'
 
-test_expect_success "track initial change if it was only made to parent" "
-	svn cp -m 'wheee!' $svnrepo/r9270/trunk $svnrepo/r9270/drunk &&
+test_expect_success "track initial change if it was only made to parent" '
+	svn cp -m "wheee!" "$svnrepo"/r9270/trunk "$svnrepo"/r9270/drunk &&
 	git-svn init --minimize-url -i r9270-d \
-	  $svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t &&
+	  "$svnrepo"/r9270/drunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-d &&
-	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
-	test \"\`git ls-tree --name-only r9270-t\`\" = \
-	     \"\`git ls-tree --name-only r9270-d\`\" &&
-	test \"\`git rev-parse r9270-t\`\" = \
-	     \"\`git rev-parse r9270-d~1\`\"
-	"
+	test `git rev-list r9270-d | wc -l` -eq 3 &&
+	test "`git ls-tree --name-only r9270-t`" = \
+	     "`git ls-tree --name-only r9270-d`" &&
+	test "`git rev-parse r9270-t`" = \
+	     "`git rev-parse r9270-d~1`"
+	'
 
-test_expect_success "track multi-parent paths" "
-	svn cp -m 'resurrect /glob' $svnrepo/r9270 $svnrepo/glob &&
+test_expect_success "track multi-parent paths" '
+	svn cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git-svn multi-fetch &&
-	test \`git cat-file commit refs/remotes/glob | \
-	       grep '^parent ' | wc -l\` -eq 2
-	"
+	test `git cat-file commit refs/remotes/glob | \
+	       grep "^parent " | wc -l` -eq 2
+	'
 
 test_expect_success "multi-fetch continues to work" "
 	git-svn multi-fetch
 	"
 
-test_expect_success "multi-fetch works off a 'clean' repository" "
-	rm -r $GIT_DIR/svn $GIT_DIR/refs/remotes $GIT_DIR/logs &&
-	mkdir $GIT_DIR/svn &&
+test_expect_success "multi-fetch works off a 'clean' repository" '
+	rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
+	mkdir "$GIT_DIR/svn" &&
 	git-svn multi-fetch
-	"
+	'
 
 test_debug 'gitk --all &'
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 318e172..6323036 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -4,18 +4,18 @@
 test_description='git-svn commit-diff'
 . ./lib-git-svn.sh
 
-test_expect_success 'initialize repo' "
+test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
-	git commit -a -m 'initial' &&
+	git commit -a -m "initial" &&
 	echo world >> readme &&
-	git commit -a -m 'another'
-	"
+	git commit -a -m "another"
+	'
 
 head=`git rev-parse --verify HEAD^0`
 prev=`git rev-parse --verify HEAD^1`
@@ -24,20 +24,20 @@ prev=`git rev-parse --verify HEAD^1`
 # commit, so only a basic test of functionality is needed since we've
 # already tested commit extensively elsewhere
 
-test_expect_success 'test the commit-diff command' "
-	test -n '$prev' && test -n '$head' &&
-	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
-	svn co $svnrepo wc &&
+test_expect_success 'test the commit-diff command' '
+	test -n "$prev" && test -n "$head" &&
+	git-svn commit-diff -r1 "$prev" "$head" "$svnrepo" &&
+	svn co "$svnrepo" wc &&
 	cmp readme wc/readme
-	"
+	'
 
-test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
-	svn import -m 'sub-directory' import $svnrepo/subdir &&
-	git-svn init --minimize-url $svnrepo/subdir &&
+test_expect_success 'commit-diff to a sub-directory (with git-svn config)' '
+	svn import -m "sub-directory" import "$svnrepo"/subdir &&
+	git-svn init --minimize-url "$svnrepo"/subdir &&
 	git-svn fetch &&
-	git-svn commit-diff -r3 '$prev' '$head' &&
-	svn cat $svnrepo/subdir/readme > readme.2 &&
+	git-svn commit-diff -r3 "$prev" "$head" &&
+	svn cat "$svnrepo"/subdir/readme > readme.2 &&
 	cmp readme readme.2
-	"
+	'
 
 test_done
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f74ab12..58a3a7b 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -4,56 +4,56 @@
 test_description='git-svn commit-diff clobber'
 . ./lib-git-svn.sh
 
-test_expect_success 'initialize repo' "
+test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
-	git commit -a -m 'initial'
-	"
-test_expect_success 'commit change from svn side' "
-	svn co $svnrepo t.svn &&
+	git commit -a -m "initial"
+	'
+test_expect_success 'commit change from svn side' '
+	svn co "$svnrepo" t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
-	svn commit -m 'second line from svn' &&
+	svn commit -m "second line from svn" &&
 	cd .. &&
 	rm -rf t.svn
-	"
+	'
 
-test_expect_success 'commit conflicting change from git' "
+test_expect_success 'commit conflicting change from git' '
 	echo second line from git >> file &&
-	git commit -a -m 'second line from git' &&
-	! git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
-"
+	git commit -a -m "second line from git" &&
+	! git-svn commit-diff -r1 HEAD~1 HEAD "$svnrepo"
+'
 
-test_expect_success 'commit complementing change from git' "
+test_expect_success 'commit complementing change from git' '
 	git reset --hard HEAD~1 &&
 	echo second line from svn >> file &&
-	git commit -a -m 'second line from svn' &&
+	git commit -a -m "second line from svn" &&
 	echo third line from git >> file &&
-	git commit -a -m 'third line from git' &&
-	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
-	"
+	git commit -a -m "third line from git" &&
+	git-svn commit-diff -r2 HEAD~1 HEAD "$svnrepo"
+	'
 
-test_expect_success 'dcommit fails to commit because of conflict' "
-	git-svn init $svnrepo &&
+test_expect_success 'dcommit fails to commit because of conflict' '
+	git-svn init "$svnrepo" &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
-	svn co $svnrepo t.svn &&
+	svn co "$svnrepo" t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
-	svn commit -m 'fourth line from svn' &&
+	svn commit -m "fourth line from svn" &&
 	cd .. &&
 	rm -rf t.svn &&
-	echo 'fourth line from git' >> file &&
-	git commit -a -m 'fourth line from git' &&
+	echo "fourth line from git" >> file &&
+	git commit -a -m "fourth line from git" &&
 	! git-svn dcommit
-	"
+	'
 
 test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	git reset --hard refs/remotes/git-svn &&
@@ -66,15 +66,15 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	git-svn dcommit
 	"
 
-test_expect_success 'commit another change from svn side' "
-	svn co $svnrepo t.svn &&
+test_expect_success 'commit another change from svn side' '
+	svn co "$svnrepo" t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
-		svn commit -m 'third line from svn' &&
+		svn commit -m "third line from svn" &&
 	cd .. &&
 	rm -rf t.svn
-	"
+	'
 
 test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
 	git reset --hard refs/remotes/git-svn &&
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index ca8a00e..a400dc7 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -4,30 +4,30 @@
 test_description='git-svn dcommit clobber series'
 . ./lib-git-svn.sh
 
-test_expect_success 'initialize repo' "
+test_expect_success 'initialize repo' '
 	mkdir import &&
 	cd import &&
-	awk 'BEGIN { for (i = 1; i < 64; i++) { print i } }' > file
-	svn import -m 'initial' . $svnrepo &&
+	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file
+	svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
-	git svn init $svnrepo &&
+	git svn init "$svnrepo" &&
 	git svn fetch &&
 	test -e file
-	"
+	'
 
-test_expect_success '(supposedly) non-conflicting change from SVN' "
-	test x\"\`sed -n -e 58p < file\`\" = x58 &&
-	test x\"\`sed -n -e 61p < file\`\" = x61 &&
-	svn co $svnrepo tmp &&
+test_expect_success '(supposedly) non-conflicting change from SVN' '
+	test x"`sed -n -e 58p < file`" = x58 &&
+	test x"`sed -n -e 61p < file`" = x61 &&
+	svn co "$svnrepo" tmp &&
 	cd tmp &&
-		perl -i -p -e 's/^58\$/5588/' file &&
-		perl -i -p -e 's/^61\$/6611/' file &&
+		perl -i -p -e "s/^58$/5588/" file &&
+		perl -i -p -e "s/^61$/6611/" file &&
 		poke file &&
-		test x\"\`sed -n -e 58p < file\`\" = x5588 &&
-		test x\"\`sed -n -e 61p < file\`\" = x6611 &&
-		svn commit -m '58 => 5588, 61 => 6611' &&
+		test x"`sed -n -e 58p < file`" = x5588 &&
+		test x"`sed -n -e 61p < file`" = x6611 &&
+		svn commit -m "58 => 5588, 61 => 6611" &&
 		cd ..
-	"
+	'
 
 test_expect_success 'some unrelated changes to git' "
 	echo hi > life &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 0a41d52..d9b553a 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -3,61 +3,61 @@
 test_description='git-svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
-test_expect_success 'setup old-looking metadata' "
-	cp $GIT_DIR/config $GIT_DIR/config-old-git-svn &&
+test_expect_success 'setup old-looking metadata' '
+	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
 		         tags/0.1 tags/0.2 tags/0.3; do
-			mkdir -p \$i && \
-			echo hello >> \$i/README || exit 1
+			mkdir -p $i && \
+			echo hello >> $i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . "$svnrepo"
 		cd .. &&
-	git-svn init $svnrepo &&
+	git-svn init "$svnrepo" &&
 	git-svn fetch &&
-	mv $GIT_DIR/svn/* $GIT_DIR/ &&
-	mv $GIT_DIR/svn/.metadata $GIT_DIR/ &&
-	rmdir $GIT_DIR/svn &&
+	mv "$GIT_DIR"/svn/* "$GIT_DIR"/ &&
+	mv "$GIT_DIR"/svn/.metadata "$GIT_DIR"/ &&
+	rmdir "$GIT_DIR"/svn &&
 	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
 	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
-	"
+	'
 
 head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
-test_expect_success 'initialize old-style (v0) git-svn layout' "
-	mkdir -p $GIT_DIR/git-svn/info $GIT_DIR/svn/info &&
-	echo $svnrepo > $GIT_DIR/git-svn/info/url &&
-	echo $svnrepo > $GIT_DIR/svn/info/url &&
+test_expect_success 'initialize old-style (v0) git-svn layout' '
+	mkdir -p "$GIT_DIR"/git-svn/info "$GIT_DIR"/svn/info &&
+	echo "$svnrepo" > "$GIT_DIR"/git-svn/info/url &&
+	echo "$svnrepo" > "$GIT_DIR"/svn/info/url &&
 	git-svn migrate &&
-	! test -d $GIT_DIR/git-svn &&
+	! test -d "$GIT_DIR"/git-svn &&
 	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
-	test \`git config --get svn-remote.svn.url\` = '$svnrepo' &&
-	test \`git config --get svn-remote.svn.fetch\` = \
-             ':refs/remotes/git-svn'
-	"
+	test "$(git config --get svn-remote.svn.url)" = "$svnrepo" &&
+	test `git config --get svn-remote.svn.fetch` = \
+             ":refs/remotes/git-svn"
+	'
 
-test_expect_success 'initialize a multi-repository repo' "
-	git-svn init $svnrepo -T trunk -t tags -b branches &&
+test_expect_success 'initialize a multi-repository repo' '
+	git-svn init "$svnrepo" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep '^trunk:refs/remotes/trunk$' fetch.out &&
-	test -n \"\`git config --get svn-remote.svn.branches \
-	            '^branches/\*:refs/remotes/\*$'\`\" &&
-	test -n \"\`git config --get svn-remote.svn.tags \
-	            '^tags/\*:refs/remotes/tags/\*$'\`\" &&
+	grep "^trunk:refs/remotes/trunk$" fetch.out &&
+	test -n "`git config --get svn-remote.svn.branches \
+	            "^branches/\*:refs/remotes/\*$"`" &&
+	test -n "`git config --get svn-remote.svn.tags \
+	            "^tags/\*:refs/remotes/tags/\*$"`" &&
 	git config --unset svn-remote.svn.branches \
-	                        '^branches/\*:refs/remotes/\*$' &&
+	                        "^branches/\*:refs/remotes/\*$" &&
 	git config --unset svn-remote.svn.tags \
-	                        '^tags/\*:refs/remotes/tags/\*$' &&
-	git config --add svn-remote.svn.fetch 'branches/a:refs/remotes/a' &&
-	git config --add svn-remote.svn.fetch 'branches/b:refs/remotes/b' &&
+	                        "^tags/\*:refs/remotes/tags/\*$" &&
+	git config --add svn-remote.svn.fetch "branches/a:refs/remotes/a" &&
+	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/b" &&
 	for i in tags/0.1 tags/0.2 tags/0.3; do
 		git config --add svn-remote.svn.fetch \
-		                 \$i:refs/remotes/\$i || exit 1; done
-	"
+		                 $i:refs/remotes/$i || exit 1; done
+	'
 
 # refs should all be different, but the trees should all be the same:
 test_expect_success 'multi-fetch works on partial urls + paths' "
@@ -73,43 +73,43 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 	                         refs/remotes/\$j\`\" ||exit 1; done; done
 	"
 
-test_expect_success 'migrate --minimize on old inited layout' "
+test_expect_success 'migrate --minimize on old inited layout' '
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
-	rm -rf $GIT_DIR/svn &&
-	for i in \`cat fetch.out\`; do
-		path=\`expr \$i : '\\([^:]*\\):.*$'\`
-		ref=\`expr \$i : '[^:]*:refs/remotes/\\(.*\\)$'\`
-		if test -z \"\$ref\"; then continue; fi
-		if test -n \"\$path\"; then path=\"/\$path\"; fi
-		( mkdir -p $GIT_DIR/svn/\$ref/info/ &&
-		echo $svnrepo\$path > $GIT_DIR/svn/\$ref/info/url ) || exit 1;
+	rm -rf "$GIT_DIR"/svn &&
+	for i in `cat fetch.out`; do
+		path=`expr $i : "\([^:]*\):.*$"`
+		ref=`expr $i : "[^:]*:refs/remotes/\(.*\)$"`
+		if test -z "$ref"; then continue; fi
+		if test -n "$path"; then path="/$path"; fi
+		( mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
+		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
 	done &&
 	git-svn migrate --minimize &&
-	test -z \"\`git config -l |grep -v '^svn-remote\.git-svn\.'\`\" &&
+	test -z "`git config -l |grep -v "^svn-remote\.git-svn\."`" &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep '^trunk:refs/remotes/trunk$' fetch.out &&
-	grep '^branches/a:refs/remotes/a$' fetch.out &&
-	grep '^branches/b:refs/remotes/b$' fetch.out &&
-	grep '^tags/0\.1:refs/remotes/tags/0\.1$' fetch.out &&
-	grep '^tags/0\.2:refs/remotes/tags/0\.2$' fetch.out &&
-	grep '^tags/0\.3:refs/remotes/tags/0\.3$' fetch.out
-	grep '^:refs/remotes/git-svn' fetch.out
-	"
+	grep "^trunk:refs/remotes/trunk$" fetch.out &&
+	grep "^branches/a:refs/remotes/a$" fetch.out &&
+	grep "^branches/b:refs/remotes/b$" fetch.out &&
+	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
+	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
+	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out
+	grep "^:refs/remotes/git-svn" fetch.out
+	'
 
-test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
+test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	expect=\"\$(ls $GIT_DIR/svn/trunk/.rev_map.*)\" &&
-	test -n \"\$expect\" &&
-	rev_db=\$(echo \$expect | sed -e 's,_map,_db,') &&
-	convert_to_rev_db \$expect \$rev_db &&
-	rm -f \$expect &&
-	test -f \$rev_db &&
+	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
+	expect="$(ls "$GIT_DIR"/svn/trunk/.rev_map.*)" &&
+	test -n "$expect" &&
+	rev_db="$(echo $expect | sed -e "s,_map,_db,")" &&
+	convert_to_rev_db "$expect" "$rev_db" &&
+	rm -f "$expect" &&
+	test -f "$rev_db" &&
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	test ! -e $GIT_DIR/svn/trunk/.rev_db &&
-	test -f \$expect
-	"
+	test -z "$(ls "$GIT_DIR"/svn/trunk/.rev_db.* 2>/dev/null)" &&
+	test ! -e "$GIT_DIR"/svn/trunk/.rev_db &&
+	test -f "$expect"
+	'
 
 test_done
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index db4344c..f6f71d0 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -10,77 +10,77 @@ start a new branch
 initial
 EOF
 
-test_expect_success 'test refspec globbing' "
+test_expect_success 'test refspec globbing' '
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
-	echo 'hello world' > trunk/src/a/readme &&
-	echo 'goodbye world' > trunk/src/b/readme &&
-	svn import -m 'initial' trunk $svnrepo/trunk &&
-	svn co $svnrepo tmp &&
+	echo "hello world" > trunk/src/a/readme &&
+	echo "goodbye world" > trunk/src/b/readme &&
+	svn import -m "initial" trunk "$svnrepo"/trunk &&
+	svn co "$svnrepo" tmp &&
 	cd tmp &&
 		mkdir branches tags &&
 		svn add branches tags &&
 		svn cp trunk branches/start &&
-		svn commit -m 'start a new branch' &&
+		svn commit -m "start a new branch" &&
 		svn up &&
-		echo 'hi' >> branches/start/src/b/readme &&
+		echo "hi" >> branches/start/src/b/readme &&
 		poke branches/start/src/b/readme &&
-		echo 'hey' >> branches/start/src/a/readme &&
+		echo "hey" >> branches/start/src/a/readme &&
 		poke branches/start/src/a/readme &&
-		svn commit -m 'hi' &&
+		svn commit -m "hi" &&
 		svn up &&
 		svn cp branches/start tags/end &&
-		echo 'bye' >> tags/end/src/b/readme &&
+		echo "bye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		echo 'aye' >> tags/end/src/a/readme &&
+		echo "aye" >> tags/end/src/a/readme &&
 		poke tags/end/src/a/readme &&
-		svn commit -m 'the end' &&
-		echo 'byebye' >> tags/end/src/b/readme &&
+		svn commit -m "the end" &&
+		echo "byebye" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m 'nothing to see here'
+		svn commit -m "nothing to see here"
 		cd .. &&
-	git config --add svn-remote.svn.url $svnrepo &&
+	git config --add svn-remote.svn.url "$svnrepo" &&
 	git config --add svn-remote.svn.fetch \
-	                 'trunk/src/a:refs/remotes/trunk' &&
+	                 "trunk/src/a:refs/remotes/trunk" &&
 	git config --add svn-remote.svn.branches \
-	                 'branches/*/src/a:refs/remotes/branches/*' &&
+	                 "branches/*/src/a:refs/remotes/branches/*" &&
 	git config --add svn-remote.svn.tags\
-	                 'tags/*/src/a:refs/remotes/tags/*' &&
+	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git-svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end | \
-	    sed -e 's/^.\{41\}//' > output.end &&
+	    sed -e "s/^.\{41\}//" > output.end &&
 	cmp expect.end output.end &&
-	test \"\`git rev-parse refs/remotes/tags/end~1\`\" = \
-		\"\`git rev-parse refs/remotes/branches/start\`\" &&
-	test \"\`git rev-parse refs/remotes/branches/start~2\`\" = \
-		\"\`git rev-parse refs/remotes/trunk\`\"
-	"
+	test "`git rev-parse refs/remotes/tags/end~1`" = \
+		"`git rev-parse refs/remotes/branches/start`" &&
+	test "`git rev-parse refs/remotes/branches/start~2`" = \
+		"`git rev-parse refs/remotes/trunk`"
+	'
 
 echo try to try > expect.two
 echo nothing to see here >> expect.two
 cat expect.end >> expect.two
 
-test_expect_success 'test left-hand-side only globbing' "
-	git config --add svn-remote.two.url $svnrepo &&
+test_expect_success 'test left-hand-side only globbing' '
+	git config --add svn-remote.two.url "$svnrepo" &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
-	                 'branches/*:refs/remotes/two/branches/*' &&
+	                 "branches/*:refs/remotes/two/branches/*" &&
 	git config --add svn-remote.two.tags \
-	                 'tags/*:refs/remotes/two/tags/*' &&
+	                 "tags/*:refs/remotes/two/tags/*" &&
 	cd tmp &&
-		echo 'try try' >> tags/end/src/b/readme &&
+		echo "try try" >> tags/end/src/b/readme &&
 		poke tags/end/src/b/readme &&
-		svn commit -m 'try to try'
+		svn commit -m "try to try"
 		cd .. &&
 	git-svn fetch two &&
-	test \`git rev-list refs/remotes/two/tags/end | wc -l\` -eq 6 &&
-	test \`git rev-list refs/remotes/two/branches/start | wc -l\` -eq 3 &&
-	test \`git rev-parse refs/remotes/two/branches/start~2\` = \
-	     \`git rev-parse refs/remotes/two/trunk\` &&
-	test \`git rev-parse refs/remotes/two/tags/end~3\` = \
-	     \`git rev-parse refs/remotes/two/branches/start\` &&
+	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
+	test `git rev-list refs/remotes/two/branches/start | wc -l` -eq 3 &&
+	test `git rev-parse refs/remotes/two/branches/start~2` = \
+	     `git rev-parse refs/remotes/two/trunk` &&
+	test `git rev-parse refs/remotes/two/tags/end~3` = \
+	     `git rev-parse refs/remotes/two/branches/start` &&
 	git log --pretty=oneline refs/remotes/two/tags/end | \
-	    sed -e 's/^.\{41\}//' > output.two &&
+	    sed -e "s/^.\{41\}//" > output.two &&
 	cmp expect.two output.two
-	"
+	'
 
 test_done
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 6235af4..047659f 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -7,15 +7,15 @@ test_description='git-svn useSvmProps test'
 
 . ./lib-git-svn.sh
 
-test_expect_success 'load svm repo' "
-	svnadmin load -q $rawsvnrepo < ../t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/mirror/arr &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/mirror/argh &&
+test_expect_success 'load svm repo' '
+	svnadmin load -q "$rawsvnrepo" < ../t9110/svm.dump &&
+	git-svn init --minimize-url -R arr -i bar "$svnrepo"/mirror/arr &&
+	git-svn init --minimize-url -R argh -i dir "$svnrepo"/mirror/argh &&
 	git-svn init --minimize-url -R argh -i e \
-	  $svnrepo/mirror/argh/a/b/c/d/e &&
+	  "$svnrepo"/mirror/argh/a/b/c/d/e &&
 	git config svn.useSvmProps true &&
 	git-svn fetch --all
-	"
+	'
 
 uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index ec7dedd..a8d74dc 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -7,14 +7,14 @@ test_description='git-svn useSvnsyncProps test'
 
 . ./lib-git-svn.sh
 
-test_expect_success 'load svnsync repo' "
-	svnadmin load -q $rawsvnrepo < ../t9111/svnsync.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/bar &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/dir &&
-	git-svn init --minimize-url -R argh -i e $svnrepo/dir/a/b/c/d/e &&
+test_expect_success 'load svnsync repo' '
+	svnadmin load -q "$rawsvnrepo" < ../t9111/svnsync.dump &&
+	git-svn init --minimize-url -R arr -i bar "$svnrepo"/bar &&
+	git-svn init --minimize-url -R argh -i dir "$svnrepo"/dir &&
+	git-svn init --minimize-url -R argh -i e "$svnrepo"/dir/a/b/c/d/e &&
 	git config svn.useSvnsyncProps true &&
 	git-svn fetch --all
-	"
+	'
 
 uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 646a5f0..d470a92 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -40,8 +40,8 @@ PROPS-END
 
 EOF
 
-test_expect_success 'load svn dumpfile' "svnadmin load $rawsvnrepo < dumpfile.svn"
+test_expect_success 'load svn dumpfile' 'svnadmin load "$rawsvnrepo" < dumpfile.svn'
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' 'git-svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 9ef0db9..31c929b 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -15,18 +15,18 @@ test_description='git-svn dcommit new files over svn:// test'
 
 start_svnserve () {
 	svnserve --listen-port $SVNSERVE_PORT \
-	         --root $rawsvnrepo \
+	         --root "$rawsvnrepo" \
 	         --listen-once \
 	         --listen-host 127.0.0.1 &
 }
 
-test_expect_success 'start tracking an empty repo' "
-	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
-	echo anon-access = write >> $rawsvnrepo/conf/svnserve.conf &&
+test_expect_success 'start tracking an empty repo' '
+	svn mkdir -m "empty dir" "$svnrepo"/empty-dir &&
+	echo anon-access = write >> "$rawsvnrepo"/conf/svnserve.conf &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
 	git svn fetch
-	"
+	'
 
 test_expect_success 'create files in new directory with dcommit' "
 	mkdir git-new-dir &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 225060b..61d7781 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -34,35 +34,35 @@ cat << EOF
 EOF
 }
 
-test_expect_success 'setup svn repository' "
-	svn co $svnrepo mysvnwork &&
+test_expect_success 'setup svn repository' '
+	svn co "$svnrepo" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
 		svn add trunk &&
-		svn ci -m 'first commit' trunk &&
+		svn ci -m "first commit" trunk &&
 		cd ..
-	"
+	'
 
-test_expect_success 'setup git mirror and merge' "
-	git svn init $svnrepo -t tags -T trunk -b branches &&
+test_expect_success 'setup git mirror and merge' '
+	git svn init "$svnrepo" -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
 	git checkout -b merge &&
 	echo new file > new_file &&
 	git add new_file &&
-	git commit -a -m 'New file' &&
+	git commit -a -m "New file" &&
 	echo hello >> README &&
-	git commit -a -m 'hello' &&
+	git commit -a -m "hello" &&
 	echo add some stuff >> new_file &&
-	git commit -a -m 'add some stuff' &&
+	git commit -a -m "add some stuff" &&
 	git checkout svn &&
 	mv -f README tmp &&
 	echo friend > README &&
 	cat tmp >> README &&
-	git commit -a -m 'friend' &&
+	git commit -a -m "friend" &&
 	git pull . merge
-	"
+	'
 
 test_debug 'gitk --all & sleep 1'
 
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..298445f 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -7,16 +7,16 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 
 . ./lib-git-svn.sh
 
-test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+test_expect_success 'load repository with strange names' '
+	svnadmin load -q "$rawsvnrepo" < ../t9115/funky-names.dump &&
 	start_httpd
-	"
+	'
 
-test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo &&
+test_expect_success 'init and fetch repository' '
+	git svn init "$svnrepo" &&
 	git svn fetch &&
 	git reset --hard git-svn
-	"
+	'
 
 test_expect_success 'create file in existing ugly and empty dir' '
 	mkdir "#{bad_directory_name}" &&
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index e1e8bdf..4b2cc87 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -6,17 +6,17 @@
 test_description='git-svn log tests'
 . ./lib-git-svn.sh
 
-test_expect_success 'setup repository and import' "
+test_expect_success 'setup repository and import' '
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
 		         tags/0.1 tags/0.2 tags/0.3; do
-			mkdir -p \$i && \
-			echo hello >> \$i/README || exit 1
+			mkdir -p $i && \
+			echo hello >> $i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . "$svnrepo"
 		cd .. &&
-	git-svn init $svnrepo -T trunk -b branches -t tags &&
+	git-svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git-svn fetch &&
 	git reset --hard trunk &&
 	echo bye >> README &&
@@ -37,7 +37,7 @@ test_expect_success 'setup repository and import' "
 	echo try >> README &&
 	git commit -a -m try &&
 	git svn dcommit
-	"
+	'
 
 test_expect_success 'run log' "
 	git reset --hard a &&
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index d482b40..7a689bb 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -13,43 +13,43 @@ rm -r .git
 mkdir tmp
 cd tmp
 
-test_expect_success 'setup svnrepo' "
+test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project $svnrepo/project &&
+	svn import -m "$test_description" project "$svnrepo"/project &&
 	rm -rf project
-	"
+	'
 
-test_expect_success 'basic clone' "
+test_expect_success 'basic clone' '
 	test ! -d trunk &&
-	git svn clone $svnrepo/project/trunk &&
+	git svn clone "$svnrepo"/project/trunk &&
 	test -d trunk/.git/svn &&
 	test -e trunk/foo &&
 	rm -rf trunk
-	"
+	'
 
-test_expect_success 'clone to target directory' "
+test_expect_success 'clone to target directory' '
 	test ! -d target &&
-	git svn clone $svnrepo/project/trunk target &&
+	git svn clone "$svnrepo"/project/trunk target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
-	"
+	'
 
-test_expect_success 'clone with --stdlayout' "
+test_expect_success 'clone with --stdlayout' '
 	test ! -d project &&
-	git svn clone -s $svnrepo/project &&
+	git svn clone -s "$svnrepo"/project &&
 	test -d project/.git/svn &&
 	test -e project/foo &&
 	rm -rf project
-	"
+	'
 
-test_expect_success 'clone to target directory with --stdlayout' "
+test_expect_success 'clone to target directory with --stdlayout' '
 	test ! -d target &&
-	git svn clone -s $svnrepo/project target &&
+	git svn clone -s "$svnrepo"/project target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
-	"
+	'
 
 test_done
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 640bb06..3281cbd 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -6,25 +6,25 @@
 test_description='git-svn funky branch names'
 . ./lib-git-svn.sh
 
-test_expect_success 'setup svnrepo' "
+test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project \"$svnrepo/pr ject\" &&
+	svn import -m "$test_description" project "$svnrepo/pr ject" &&
 	rm -rf project &&
-	svn cp -m 'fun' \"$svnrepo/pr ject/trunk\" \
-	                \"$svnrepo/pr ject/branches/fun plugin\" &&
-	svn cp -m 'more fun!' \"$svnrepo/pr ject/branches/fun plugin\" \
-	                      \"$svnrepo/pr ject/branches/more fun plugin!\" &&
+	svn cp -m "fun" "$svnrepo/pr ject/trunk" \
+	                "$svnrepo/pr ject/branches/fun plugin" &&
+	svn cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
+	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
 	start_httpd
-	"
+	'
 
-test_expect_success 'test clone with funky branch names' "
-	git svn clone -s \"$svnrepo/pr ject\" project &&
+test_expect_success 'test clone with funky branch names' '
+	git svn clone -s "$svnrepo/pr ject" project &&
 	cd project &&
-		git rev-parse 'refs/remotes/fun%20plugin' &&
-		git rev-parse 'refs/remotes/more%20fun%20plugin!' &&
+		git rev-parse "refs/remotes/fun%20plugin" &&
+		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
 	cd ..
-	"
+	'
 
 test_expect_success 'test dcommit to funky branch' "
 	cd project &&
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 9a4eabe..5979e13 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -6,13 +6,13 @@
 test_description='git-svn clone with percent escapes'
 . ./lib-git-svn.sh
 
-test_expect_success 'setup svnrepo' "
+test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project '$svnrepo/pr ject' &&
+	svn import -m "$test_description" project "$svnrepo/pr ject" &&
 	rm -rf project &&
 	start_httpd
-"
+'
 
 if test "$SVN_HTTPD_PORT" = ""
 then
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 3dc261d..ae7082b 100755
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
@@ -53,7 +54,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- $(pwd)/../../gitweb/gitweb.perl \
+	perl -- "$(pwd)/../../gitweb/gitweb.perl" \
 		>/dev/null 2>gitweb.log &&
 	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
 
-- 
1.5.5.1.128.g03a943
