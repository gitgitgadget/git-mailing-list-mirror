From: arjen@yaph.org (Arjen Laarhoven)
Subject: [PATCH] Have tests and programs understand paths containing spaces
Date: Tue, 22 Apr 2008 23:28:01 +0200
Message-ID: <20080422212801.GB20417@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:52:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoQPC-0001zo-2k
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbYDVVvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 17:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756154AbYDVVvM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 17:51:12 -0400
Received: from regex.yaph.org ([193.202.115.201]:42834 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638AbYDVVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 17:51:08 -0400
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 17:51:07 EDT
Received: by regex.yaph.org (Postfix, from userid 1000)
	id C72DB5B7D2; Tue, 22 Apr 2008 23:28:01 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80167>

A lot of tests and some core programs didn't work when used in a path
containing whitespace.  Correct the quoting of all affected programs to
fix this.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 builtin-tag.c                                |    2 +-
 git-rebase.sh                                |    2 +-
 git-send-email.perl                          |    2 +-
 git-sh-setup.sh                              |    2 +-
 t/lib-git-svn.sh                             |    8 ++--
 t/t0000-basic.sh                             |    2 +-
 t/t1020-subdirectory.sh                      |   22 ++++++------
 t/t3050-subprojects-fetch.sh                 |    2 +-
 t/t3404-rebase-interactive.sh                |    2 +-
 t/t5500-fetch-pack.sh                        |    2 +-
 t/t5512-ls-remote.sh                         |    2 +-
 t/t5516-fetch-push.sh                        |   10 +++---
 t/t5700-clone-reference.sh                   |    4 +-
 t/t7003-filter-branch.sh                     |    4 +-
 t/t7005-editor.sh                            |    4 +-
 t/t7010-setup.sh                             |    2 +-
 t/t7300-clean.sh                             |    2 +-
 t/t7501-commit.sh                            |    8 ++--
 t/t9001-send-email.sh                        |    4 +-
 t/t9100-git-svn-basic.sh                     |   26 +++++++-------
 t/t9101-git-svn-props.sh                     |    6 ++--
 t/t9102-git-svn-deep-rmdir.sh                |    6 ++--
 t/t9103-git-svn-tracked-directory-removed.sh |   10 +++---
 t/t9104-git-svn-follow-parent.sh             |   50 +++++++++++++-------------
 t/t9105-git-svn-commit-diff.sh               |   10 +++---
 t/t9106-git-svn-commit-diff-clobber.sh       |   14 ++++----
 t/t9106-git-svn-dcommit-clobber-series.sh    |    6 ++--
 t/t9107-git-svn-migrate.sh                   |   48 ++++++++++++------------
 t/t9108-git-svn-glob.sh                      |    8 ++--
 t/t9110-git-svn-use-svm-props.sh             |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh         |    8 ++--
 t/t9112-git-svn-md5less-file.sh              |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh          |    6 ++--
 t/t9114-git-svn-dcommit-merge.sh             |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh     |    4 +-
 t/t9116-git-svn-log.sh                       |    4 +-
 t/t9117-git-svn-init-clone.sh                |   10 +++---
 t/t9121-git-svn-fetch-renamed-dir.sh         |    4 +-
 t/t9400-git-cvsserver-server.sh              |   20 +++++-----
 t/t9500-gitweb-standalone-no-errors.sh       |    4 +-
 t/t9600-cvsimport.sh                         |    6 ++--
 t/test-lib.sh                                |   10 +++---
 42 files changed, 181 insertions(+), 181 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 129ff57..2d04d4f 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -55,7 +55,7 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		strbuf_init(&arg0, 0);
 		if (strcspn(editor, "$ \t'") != len) {
 			/* there are specials */
-			strbuf_addf(&arg0, "%s \"$@\"", editor);
+			strbuf_addf(&arg0, "'%s' \"$@\"", editor);
 			args[i++] = "sh";
 			args[i++] = "-c";
 			args[i++] = arg0.buf;
diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..c43afe5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -214,7 +214,7 @@ do
 		else
 			die "No rebase in progress?"
 		fi
-		git reset --hard $(cat $dotest/orig-head)
+		git reset --hard $(cat "$dotest/orig-head")
 		rm -r "$dotest"
 		exit
 		;;
diff --git a/git-send-email.perl b/git-send-email.perl
index 9e568bf..40a521a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -512,7 +512,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system('sh', '-c', '$0 $@', $editor, $compose_filename);
+	system('sh', '-c', '"$0" $@', $editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index a44b1c7..a8a024b 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -73,7 +73,7 @@ git_editor() {
 		exit 1
 		;;
 	esac
-	eval "${GIT_EDITOR:=vi}" '"$@"'
+	eval '"${GIT_EDITOR:=vi}"' '"$@"'
 }
 
 is_bare_repository () {
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9decd2e..f6645f9 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,9 +7,9 @@ then
 	exit
 fi
 
-GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/svn/git-svn
-SVN_TREE=$GIT_SVN_DIR/svn-tree
+GIT_DIR="$PWD/.git"
+GIT_SVN_DIR="$GIT_DIR/svn/git-svn"
+SVN_TREE="$GIT_SVN_DIR/svn-tree"
 
 svn >/dev/null 2>&1
 if test $? -ne 1
@@ -19,7 +19,7 @@ then
     exit
 fi
 
-svnrepo=$PWD/svnrepo
+svnrepo="$PWD/svnrepo"
 
 perl -w -e "
 use SVN::Core;
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 27b54cb..e6fa7de 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -305,7 +305,7 @@ test_expect_success 'absolute path works as expected' '
 	file="$dir"/index &&
 	test "$file" = "$(test-absolute-path $dir2/index)" &&
 	basename=blub &&
-	test "$dir/$basename" = $(cd .git && test-absolute-path $basename) &&
+	test "$dir/$basename" = "$(cd .git && test-absolute-path $basename)" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
 	test "$sym" = "$(test-absolute-path $dir2/syml)"
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index b9cef34..5ed7fa4 100755
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
+	cd "$HERE/.git" &&
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
index 9cf873f..e619a29 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -174,7 +174,7 @@ test_expect_success 'squash' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
-	FAKE_LINES="1 squash 2" git rebase -i --onto master HEAD~2 &&
+	FAKE_LINES="1 squash 2" git rebase -v -i --onto master HEAD~2 &&
 	test B = $(cat file7) &&
 	test $(git rev-parse HEAD^) = $(git rev-parse master)
 '
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
index c0dc949..e3df3ed 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 		git show-ref -d	| sed -e "s/ /	/"
 	) >expected.all &&
 
-	git remote add self $(pwd)/.git
+	git remote add self "$(pwd)"/.git
 
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6d7e738..a86042e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -4,7 +4,7 @@ test_description='fetching and pushing, with or without wildcard'
 
 . ./test-lib.sh
 
-D=`pwd`
+D=$(pwd)
 
 mk_empty () {
 	rm -fr testrepo &&
@@ -103,9 +103,9 @@ test_expect_success 'fetch with wildcard' '
 test_expect_success 'fetch with insteadOf' '
 	mk_empty &&
 	(
-		TRASH=$(pwd)/ &&
+		TRASH="$(pwd)"/ &&
 		cd testrepo &&
-		git config url.$TRASH.insteadOf trash/
+		git config url."$TRASH".insteadOf trash/
 		git config remote.up.url trash/. &&
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
@@ -145,8 +145,8 @@ test_expect_success 'push with wildcard' '
 
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
-	TRASH=$(pwd)/ &&
-	git config url.$TRASH.insteadOf trash/ &&
+	TRASH="$(pwd)"/ &&
+	git config url."$TRASH".insteadOf trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index b6a5486..b6905c1 100755
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
+'git clone --reference B file://"$(pwd)"/A D'
 
 cd "$base_dir"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index efd658a..5863cc2 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -123,9 +123,9 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
 	git-filter-branch -f --index-filter \
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
-	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+	          GIT_INDEX_FILE=\"\$GIT_INDEX_FILE\".new \
 			git update-index --index-info &&
-		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
+		  mv \"\$GIT_INDEX_FILE\".new \"\$GIT_INDEX_FILE\"" directorymoved &&
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
 test_expect_success 'stops when msg filter fails' '
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 2d919d6..2bf6a55 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -92,7 +92,7 @@ test_expect_success 'editor with a space' '
 	if echo "echo space > \"\$1\"" > "e space.sh"
 	then
 		chmod a+x "e space.sh" &&
-		GIT_EDITOR="./e\ space.sh" git commit --amend &&
+		GIT_EDITOR="./e space.sh" git commit --amend &&
 		test space = "$(git show -s --pretty=format:%s)"
 	else
 		say "Skipping; FS does not support spaces in filenames"
@@ -105,7 +105,7 @@ test_expect_success 'core.editor with a space' '
 
 	if test -f "e space.sh"
 	then
-		git config core.editor \"./e\ space.sh\" &&
+		git config core.editor "./e space.sh" &&
 		git commit --amend &&
 		test space = "$(git show -s --pretty=format:%s)"
 	else
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
index a50492f..4c9701f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -112,7 +112,7 @@ test_expect_success 'git-clean with absolute path' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	would_clean=$(
 		cd docs &&
-		git clean -n $(pwd)/../src |
+		git clean -n "$(pwd)"/../src |
 		sed -n -e "s|^Would remove ||p"
 	) &&
 	test "$would_clean" = ../src/part3.c || {
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index c0288f3..4e5418a 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -79,8 +79,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -e "s/a file/an amend commit/g" < $1 > $1-
-mv $1- $1
+sed -e "s/a file/an amend commit/g" < "$1" > "$1"-
+mv "$1"- "$1"
 EOF
 chmod 755 editor
 
@@ -99,8 +99,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -e "s/amend/older/g"  < $1 > $1-
-mv $1- $1
+sed -e "s/amend/older/g"  < "$1" > "$1"-
+mv "$1"- "$1"
 EOF
 chmod 755 editor
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c0973b4..5047708 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -32,7 +32,7 @@ clean_fake_sendmail() {
 }
 
 test_expect_success 'Extract patches' '
-    patches=`git format-patch -n HEAD^1`
+    patches=$(git format-patch -n HEAD^1)
 '
 
 test_expect_success 'Send patches' '
@@ -147,7 +147,7 @@ test_expect_success 'setup fake editor' '
 test_expect_success '--compose works' '
 	clean_fake_sendmail &&
 	echo y | \
-		GIT_EDITOR=$(pwd)/fake-editor \
+		GIT_EDITOR="$(pwd)/fake-editor" \
 		GIT_SEND_EMAIL_NOTTY=1 \
 		git send-email \
 		--compose --subject foo \
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4e24ab3..8f93821 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -20,27 +20,27 @@ esac
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
+test_expect_success "checkout from svn" "svn co '$svnrepo' '$SVN_TREE'"
 
 name='try a deep --rmdir with a commit'
 test_expect_success "$name" "
@@ -169,7 +169,7 @@ test_expect_success "$name" "
 	svn up '$SVN_TREE' &&
 	test -f '$SVN_TREE'/exec-2.sh &&
 	test ! -L '$SVN_TREE'/exec-2.sh &&
-	git diff help $SVN_TREE/exec-2.sh"
+	git diff help '$SVN_TREE'/exec-2.sh"
 
 if test "$have_utf8" = t
 then
@@ -190,7 +190,7 @@ name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init $svnrepo && git-svn fetch &&
+    "git-svn init '$svnrepo' && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      git diff a b"
@@ -220,16 +220,16 @@ test_expect_success 'exit if remote refs are ambigious' "
 "
 
 test_expect_success 'exit if init-ing a would clobber a URL' "
-        svnadmin create ${PWD}/svnrepo2 &&
-        svn mkdir -m 'mkdir bar' ${svnrepo}2/bar &&
+        svnadmin create '${PWD}/svnrepo2' &&
+        svn mkdir -m 'mkdir bar' '${svnrepo}2/bar' &&
         git config --unset svn-remote.svn.fetch \
                                 '^bar:refs/remotes/git-svn$' &&
-	! git-svn init ${svnrepo}2/bar
+	! git-svn init '${svnrepo}2/bar'
         "
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' "
-        git-svn init --minimize-url -i bar $svnrepo/bar &&
+        git-svn init --minimize-url -i bar '$svnrepo/bar' &&
         git config --get svn-remote.svn.fetch \
                               '^bar:refs/remotes/bar$' &&
         git config --get svn-remote.svn.fetch \
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index d7a7047..2616df6 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -52,7 +52,7 @@ EOF
 cd ..
 
 rm -rf import
-test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
+test_expect_success 'checkout working copy from svn' "svn co '$svnrepo' test_wc"
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
 name='test svn:keywords ignoring'
@@ -92,7 +92,7 @@ test_expect_success "propset CR on crlf files" \
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	"git-svn fetch &&
 	 git pull . remotes/git-svn &&
-	 svn co $svnrepo new_wc"
+	 svn co '$svnrepo' new_wc"
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 4e08083..99c8840 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,12 +9,12 @@ test_expect_success 'initialize repo' "
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m 'import for git-svn' . $svnrepo &&
+	svn import -m 'import for git-svn' . '$svnrepo' &&
 	cd ..
 	"
 
 test_expect_success 'mirror via git-svn' "
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
 	git checkout -f -b test-rmdir remotes/git-svn
 	"
@@ -23,7 +23,7 @@ test_expect_success 'Try a commit on rmdir' "
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m 'remove another' &&
 	git-svn set-tree --rmdir HEAD &&
-	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
+	svn ls -R '$svnrepo' | grep ^deeply/nested/directory/number/1
 	"
 
 
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index 0f0b0fd..a85050a 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -10,19 +10,19 @@ test_expect_success 'make history for tracking' '
 	mkdir import &&
 	mkdir import/trunk &&
 	echo hello >> import/trunk/README &&
-	svn import -m initial import $svnrepo &&
+	svn import -m initial import "$svnrepo" &&
 	rm -rf import &&
-	svn co $svnrepo/trunk trunk &&
+	svn co "$svnrepo/trunk" trunk &&
 	echo bye bye >> trunk/README &&
-	svn rm -m "gone" $svnrepo/trunk &&
+	svn rm -m "gone" "$svnrepo/trunk" &&
 	rm -rf trunk &&
 	mkdir trunk &&
 	echo "new" > trunk/FOLLOWME &&
-	svn import -m "new trunk" trunk $svnrepo/trunk
+	svn import -m "new trunk" trunk "$svnrepo/trunk"
 '
 
 test_expect_success 'clone repo with git' '
-	git svn clone -s $svnrepo x &&
+	git svn clone -s "$svnrepo" x &&
 	test -f x/FOLLOWME &&
 	test ! -f x/README
 '
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 7ba7630..499d9e6 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -11,9 +11,9 @@ test_expect_success 'initialize repo' "
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
-	svn co $svnrepo wc &&
+	svn co '$svnrepo' wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
@@ -27,7 +27,7 @@ test_expect_success 'initialize repo' "
 	"
 
 test_expect_success 'init and fetch a moved directory' "
-	git-svn init --minimize-url -i thunk $svnrepo/thunk &&
+	git-svn init --minimize-url -i thunk '$svnrepo/thunk' &&
 	git-svn fetch -i thunk &&
 	test \"\`git rev-parse --verify refs/remotes/thunk@2\`\" \
            = \"\`git rev-parse --verify refs/remotes/thunk~1\`\" &&
@@ -38,7 +38,7 @@ test_expect_success 'init and fetch a moved directory' "
 	"
 
 test_expect_success 'init and fetch from one svn-remote' "
-        git config svn-remote.svn.url $svnrepo &&
+        git config svn-remote.svn.url '$svnrepo' &&
         git config --add svn-remote.svn.fetch \
           trunk:refs/remotes/svn/trunk &&
         git config --add svn-remote.svn.fetch \
@@ -52,9 +52,9 @@ test_expect_success 'init and fetch from one svn-remote' "
 
 test_expect_success 'follow deleted parent' "
         (svn cp -m 'resurrecting trunk as junk' \
-               $svnrepo/trunk@2 $svnrepo/junk ||
+               '$svnrepo/trunk@2' '$svnrepo/junk' ||
          svn cp -m 'resurrecting trunk as junk' \
-               -r2 $svnrepo/trunk $svnrepo/junk) &&
+               -r2 '$svnrepo/trunk' '$svnrepo/junk') &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
@@ -67,10 +67,10 @@ test_expect_success 'follow deleted parent' "
 test_expect_success 'follow larger parent' "
         mkdir -p import/trunk/thunk/bump/thud &&
         echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m 'import a larger parent' import $svnrepo/larger-parent &&
-        svn cp -m 'hi' $svnrepo/larger-parent $svnrepo/another-larger &&
+        svn import -m 'import a larger parent' import '$svnrepo/larger-parent' &&
+        svn cp -m 'hi' '$svnrepo/larger-parent' '$svnrepo/another-larger' &&
         git-svn init --minimize-url -i larger \
-          $svnrepo/another-larger/trunk/thunk/bump/thud &&
+          '$svnrepo/another-larger/trunk/thunk/bump/thud' &&
         git-svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
@@ -83,23 +83,23 @@ test_expect_success 'follow larger parent' "
         "
 
 test_expect_success 'follow higher-level parent' "
-        svn mkdir -m 'follow higher-level parent' $svnrepo/blob &&
-        svn co $svnrepo/blob blob &&
+        svn mkdir -m 'follow higher-level parent' '$svnrepo/blob' &&
+        svn co '$svnrepo/blob' blob &&
         cd blob &&
                 echo hi > hi &&
                 svn add hi &&
                 svn commit -m 'hihi' &&
                 cd ..
-        svn mkdir -m 'new glob at top level' $svnrepo/glob &&
-        svn mv -m 'move blob down a level' $svnrepo/blob $svnrepo/glob/blob &&
-        git-svn init --minimize-url -i blob $svnrepo/glob/blob &&
+        svn mkdir -m 'new glob at top level' '$svnrepo/glob' &&
+        svn mv -m 'move blob down a level' '$svnrepo/blob' '$svnrepo/glob/blob' &&
+        git-svn init --minimize-url -i blob '$svnrepo/glob/blob' &&
         git-svn fetch -i blob
         "
 
 test_expect_success 'follow deleted directory' "
-	svn mv -m 'bye!' $svnrepo/glob/blob/hi $svnrepo/glob/blob/bye &&
-	svn rm -m 'remove glob' $svnrepo/glob &&
-	git-svn init --minimize-url -i glob $svnrepo/glob &&
+	svn mv -m 'bye!' '$svnrepo/glob/blob/hi' '$svnrepo/glob/blob/bye' &&
+	svn rm -m 'remove glob' '$svnrepo/glob' &&
+	git-svn init --minimize-url -i glob '$svnrepo/glob' &&
 	git-svn fetch -i glob &&
 	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
 	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
@@ -118,9 +118,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  echo 'bad delete test 2' > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
 	cd import &&
-	  svn import -m 'r9270 test' . $svnrepo/r9270 &&
+	  svn import -m 'r9270 test' . '$svnrepo/r9270' &&
 	cd .. &&
-	svn co $svnrepo/r9270/trunk/subversion/bindings/swig/perl r9270 &&
+	svn co '$svnrepo/r9270/trunk/subversion/bindings/swig/perl' r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
@@ -130,7 +130,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  svn commit -m 'reorg test' &&
 	cd .. &&
 	git-svn init --minimize-url -i r9270-t \
-	  $svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t &&
+	  '$svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t' &&
 	git-svn fetch -i r9270-t &&
 	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
 	test \"\`git ls-tree --name-only r9270-t~1\`\" = \
@@ -138,9 +138,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	"
 
 test_expect_success "track initial change if it was only made to parent" "
-	svn cp -m 'wheee!' $svnrepo/r9270/trunk $svnrepo/r9270/drunk &&
+	svn cp -m 'wheee!' '$svnrepo/r9270/trunk' '$svnrepo/r9270/drunk' &&
 	git-svn init --minimize-url -i r9270-d \
-	  $svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t &&
+	  '$svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t' &&
 	git-svn fetch -i r9270-d &&
 	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
 	test \"\`git ls-tree --name-only r9270-t\`\" = \
@@ -150,7 +150,7 @@ test_expect_success "track initial change if it was only made to parent" "
 	"
 
 test_expect_success "track multi-parent paths" "
-	svn cp -m 'resurrect /glob' $svnrepo/r9270 $svnrepo/glob &&
+	svn cp -m 'resurrect /glob' '$svnrepo/r9270' '$svnrepo/glob' &&
 	git-svn multi-fetch &&
 	test \`git cat-file commit refs/remotes/glob | \
 	       grep '^parent ' | wc -l\` -eq 2
@@ -161,8 +161,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" "
-	rm -r $GIT_DIR/svn $GIT_DIR/refs/remotes $GIT_DIR/logs &&
-	mkdir $GIT_DIR/svn &&
+	rm -r '$GIT_DIR/svn' '$GIT_DIR/refs/remotes' '$GIT_DIR/logs' &&
+	mkdir '$GIT_DIR/svn' &&
 	git-svn multi-fetch
 	"
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 318e172..2e1eb75 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
@@ -27,16 +27,16 @@ prev=`git rev-parse --verify HEAD^1`
 test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
 	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
-	svn co $svnrepo wc &&
+	svn co '$svnrepo' wc &&
 	cmp readme wc/readme
 	"
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
-	svn import -m 'sub-directory' import $svnrepo/subdir &&
-	git-svn init --minimize-url $svnrepo/subdir &&
+	svn import -m 'sub-directory' import '$svnrepo/subdir' &&
+	git-svn init --minimize-url '$svnrepo/subdir' &&
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
-	svn cat $svnrepo/subdir/readme > readme.2 &&
+	svn cat '$svnrepo/subdir/readme' > readme.2 &&
 	cmp readme readme.2
 	"
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f74ab12..5125ed0 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -8,14 +8,14 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m 'initial'
 	"
 test_expect_success 'commit change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
@@ -27,7 +27,7 @@ test_expect_success 'commit change from svn side' "
 test_expect_success 'commit conflicting change from git' "
 	echo second line from git >> file &&
 	git commit -a -m 'second line from git' &&
-	! git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
+	! git-svn commit-diff -r1 HEAD~1 HEAD '$svnrepo'
 "
 
 test_expect_success 'commit complementing change from git' "
@@ -36,14 +36,14 @@ test_expect_success 'commit complementing change from git' "
 	git commit -a -m 'second line from svn' &&
 	echo third line from git >> file &&
 	git commit -a -m 'third line from git' &&
-	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
+	git-svn commit-diff -r2 HEAD~1 HEAD '$svnrepo'
 	"
 
 test_expect_success 'dcommit fails to commit because of conflict' "
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
@@ -67,7 +67,7 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	"
 
 test_expect_success 'commit another change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index ca8a00e..fb4b67a 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -8,9 +8,9 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	awk 'BEGIN { for (i = 1; i < 64; i++) { print i } }' > file
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
-	git svn init $svnrepo &&
+	git svn init '$svnrepo' &&
 	git svn fetch &&
 	test -e file
 	"
@@ -18,7 +18,7 @@ test_expect_success 'initialize repo' "
 test_expect_success '(supposedly) non-conflicting change from SVN' "
 	test x\"\`sed -n -e 58p < file\`\" = x58 &&
 	test x\"\`sed -n -e 61p < file\`\" = x61 &&
-	svn co $svnrepo tmp &&
+	svn co '$svnrepo' tmp &&
 	cd tmp &&
 		perl -i -p -e 's/^58\$/5588/' file &&
 		perl -i -p -e 's/^61\$/6611/' file &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 0a41d52..545a08a 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -4,7 +4,7 @@ test_description='git-svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup old-looking metadata' "
-	cp $GIT_DIR/config $GIT_DIR/config-old-git-svn &&
+	cp '$GIT_DIR/config' '$GIT_DIR/config-old-git-svn' &&
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
@@ -12,13 +12,13 @@ test_expect_success 'setup old-looking metadata' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . '$svnrepo'
 		cd .. &&
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
-	mv $GIT_DIR/svn/* $GIT_DIR/ &&
-	mv $GIT_DIR/svn/.metadata $GIT_DIR/ &&
-	rmdir $GIT_DIR/svn &&
+	mv '$GIT_DIR/svn/'* '$GIT_DIR/' &&
+	mv '$GIT_DIR/svn/.metadata' '$GIT_DIR/' &&
+	rmdir '$GIT_DIR/svn' &&
 	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
 	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
@@ -28,20 +28,20 @@ head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
 test_expect_success 'initialize old-style (v0) git-svn layout' "
-	mkdir -p $GIT_DIR/git-svn/info $GIT_DIR/svn/info &&
-	echo $svnrepo > $GIT_DIR/git-svn/info/url &&
-	echo $svnrepo > $GIT_DIR/svn/info/url &&
+	mkdir -p '$GIT_DIR/git-svn/info' '$GIT_DIR/svn/info' &&
+	echo '$svnrepo' > '$GIT_DIR/git-svn/info/url' &&
+	echo '$svnrepo' > '$GIT_DIR/svn/info/url' &&
 	git-svn migrate &&
-	! test -d $GIT_DIR/git-svn &&
+	! test -d '$GIT_DIR/git-svn' &&
 	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
-	test \`git config --get svn-remote.svn.url\` = '$svnrepo' &&
-	test \`git config --get svn-remote.svn.fetch\` = \
+	test '$(git config --get svn-remote.svn.url)' = '$svnrepo' &&
+	test '$(git config --get svn-remote.svn.fetch)' = \
              ':refs/remotes/git-svn'
 	"
 
 test_expect_success 'initialize a multi-repository repo' "
-	git-svn init $svnrepo -T trunk -t tags -b branches &&
+	git-svn init '$svnrepo' -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep '^trunk:refs/remotes/trunk$' fetch.out &&
 	test -n \"\`git config --get svn-remote.svn.branches \
@@ -76,14 +76,14 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 test_expect_success 'migrate --minimize on old inited layout' "
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
-	rm -rf $GIT_DIR/svn &&
+	rm -rf '$GIT_DIR/svn' &&
 	for i in \`cat fetch.out\`; do
 		path=\`expr \$i : '\\([^:]*\\):.*$'\`
 		ref=\`expr \$i : '[^:]*:refs/remotes/\\(.*\\)$'\`
 		if test -z \"\$ref\"; then continue; fi
 		if test -n \"\$path\"; then path=\"/\$path\"; fi
-		( mkdir -p $GIT_DIR/svn/\$ref/info/ &&
-		echo $svnrepo\$path > $GIT_DIR/svn/\$ref/info/url ) || exit 1;
+		( mkdir -p '$GIT_DIR'/svn/\$ref/info/ &&
+		echo '$svnrepo'\$path > '$GIT_DIR'/svn/\$ref/info/url ) || exit 1;
 	done &&
 	git-svn migrate --minimize &&
 	test -z \"\`git config -l |grep -v '^svn-remote\.git-svn\.'\`\" &&
@@ -99,17 +99,17 @@ test_expect_success 'migrate --minimize on old inited layout' "
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	expect=\"\$(ls $GIT_DIR/svn/trunk/.rev_map.*)\" &&
+	test -z \"\$(ls '$GIT_DIR'/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	expect=\"\$(ls '$GIT_DIR'/svn/trunk/.rev_map.*)\" &&
 	test -n \"\$expect\" &&
 	rev_db=\$(echo \$expect | sed -e 's,_map,_db,') &&
-	convert_to_rev_db \$expect \$rev_db &&
-	rm -f \$expect &&
-	test -f \$rev_db &&
+	convert_to_rev_db \"\$expect\" \"\$rev_db\" &&j
+	rm -f \"\$expect\" &&
+	test -f \"\$rev_db\" &&
 	git-svn fetch -i trunk &&
-	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
-	test ! -e $GIT_DIR/svn/trunk/.rev_db &&
-	test -f \$expect
+	test -z \"\$(ls '$GIT_DIR'/svn/trunk/.rev_db.* 2>/dev/null)\" &&
+	test ! -e '$GIT_DIR'/svn/trunk/.rev_db &&
+	test -f \"\$expect\"
 	"
 
 test_done
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index db4344c..c6dc0ef 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -14,8 +14,8 @@ test_expect_success 'test refspec globbing' "
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo 'hello world' > trunk/src/a/readme &&
 	echo 'goodbye world' > trunk/src/b/readme &&
-	svn import -m 'initial' trunk $svnrepo/trunk &&
-	svn co $svnrepo tmp &&
+	svn import -m 'initial' trunk '$svnrepo/trunk' &&
+	svn co '$svnrepo' tmp &&
 	cd tmp &&
 		mkdir branches tags &&
 		svn add branches tags &&
@@ -38,7 +38,7 @@ test_expect_success 'test refspec globbing' "
 		poke tags/end/src/b/readme &&
 		svn commit -m 'nothing to see here'
 		cd .. &&
-	git config --add svn-remote.svn.url $svnrepo &&
+	git config --add svn-remote.svn.url '$svnrepo' &&
 	git config --add svn-remote.svn.fetch \
 	                 'trunk/src/a:refs/remotes/trunk' &&
 	git config --add svn-remote.svn.branches \
@@ -60,7 +60,7 @@ echo nothing to see here >> expect.two
 cat expect.end >> expect.two
 
 test_expect_success 'test left-hand-side only globbing' "
-	git config --add svn-remote.two.url $svnrepo &&
+	git config --add svn-remote.two.url '$svnrepo' &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
 	                 'branches/*:refs/remotes/two/branches/*' &&
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 6235af4..d4ab01f 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -8,11 +8,11 @@ test_description='git-svn useSvmProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svm repo' "
-	svnadmin load -q $rawsvnrepo < ../t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/mirror/arr &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/mirror/argh &&
+	svnadmin load -q '$rawsvnrepo' < ../t9110/svm.dump &&
+	git-svn init --minimize-url -R arr -i bar '$svnrepo/mirror/arr' &&
+	git-svn init --minimize-url -R argh -i dir '$svnrepo/mirror/argh' &&
 	git-svn init --minimize-url -R argh -i e \
-	  $svnrepo/mirror/argh/a/b/c/d/e &&
+	  '$svnrepo/mirror/argh/a/b/c/d/e' &&
 	git config svn.useSvmProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index ec7dedd..936f023 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -8,10 +8,10 @@ test_description='git-svn useSvnsyncProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svnsync repo' "
-	svnadmin load -q $rawsvnrepo < ../t9111/svnsync.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/bar &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/dir &&
-	git-svn init --minimize-url -R argh -i e $svnrepo/dir/a/b/c/d/e &&
+	svnadmin load -q '$rawsvnrepo' < ../t9111/svnsync.dump &&
+	git-svn init --minimize-url -R arr -i bar '$svnrepo/bar' &&
+	git-svn init --minimize-url -R argh -i dir '$svnrepo/dir' &&
+	git-svn init --minimize-url -R argh -i e '$svnrepo/dir/a/b/c/d/e' &&
 	git config svn.useSvnsyncProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 646a5f0..d6a5a5b 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -40,8 +40,8 @@ PROPS-END
 
 EOF
 
-test_expect_success 'load svn dumpfile' "svnadmin load $rawsvnrepo < dumpfile.svn"
+test_expect_success 'load svn dumpfile' "svnadmin load '$rawsvnrepo' < dumpfile.svn"
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 9ef0db9..b84a21e 100755
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
+	svn mkdir -m 'empty dir' '$svnrepo/empty-dir' &&
+	echo 'anon-access = write' >> '$rawsvnrepo/conf/svnserve.conf' &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
 	git svn fetch
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 225060b..9d9e34c 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -35,7 +35,7 @@ EOF
 }
 
 test_expect_success 'setup svn repository' "
-	svn co $svnrepo mysvnwork &&
+	svn co '$svnrepo' mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
@@ -45,7 +45,7 @@ test_expect_success 'setup svn repository' "
 	"
 
 test_expect_success 'setup git mirror and merge' "
-	git svn init $svnrepo -t tags -T trunk -b branches &&
+	git svn init '$svnrepo' -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
 	git checkout -b merge &&
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..653578d 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -8,12 +8,12 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	svnadmin load -q '$rawsvnrepo' < ../t9115/funky-names.dump &&
 	start_httpd
 	"
 
 test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo &&
+	git svn init '$svnrepo' &&
 	git svn fetch &&
 	git reset --hard git-svn
 	"
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index e1e8bdf..ab46903 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -14,9 +14,9 @@ test_expect_success 'setup repository and import' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . '$svnrepo'
 		cd .. &&
-	git-svn init $svnrepo -T trunk -b branches -t tags &&
+	git-svn init '$svnrepo' -T trunk -b branches -t tags &&
 	git-svn fetch &&
 	git reset --hard trunk &&
 	echo bye >> README &&
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index d482b40..aa1b167 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -16,13 +16,13 @@ cd tmp
 test_expect_success 'setup svnrepo' "
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-	svn import -m '$test_description' project $svnrepo/project &&
+	svn import -m '$test_description' project '$svnrepo/project' &&
 	rm -rf project
 	"
 
 test_expect_success 'basic clone' "
 	test ! -d trunk &&
-	git svn clone $svnrepo/project/trunk &&
+	git svn clone '$svnrepo/project/trunk' &&
 	test -d trunk/.git/svn &&
 	test -e trunk/foo &&
 	rm -rf trunk
@@ -30,7 +30,7 @@ test_expect_success 'basic clone' "
 
 test_expect_success 'clone to target directory' "
 	test ! -d target &&
-	git svn clone $svnrepo/project/trunk target &&
+	git svn clone '$svnrepo/project/trunk' target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
@@ -38,7 +38,7 @@ test_expect_success 'clone to target directory' "
 
 test_expect_success 'clone with --stdlayout' "
 	test ! -d project &&
-	git svn clone -s $svnrepo/project &&
+	git svn clone -s '$svnrepo/project' &&
 	test -d project/.git/svn &&
 	test -e project/foo &&
 	rm -rf project
@@ -46,7 +46,7 @@ test_expect_success 'clone with --stdlayout' "
 
 test_expect_success 'clone to target directory with --stdlayout' "
 	test ! -d target &&
-	git svn clone -s $svnrepo/project target &&
+	git svn clone -s '$svnrepo/project' target &&
 	test -d target/.git/svn &&
 	test -e target/foo &&
 	rm -rf target
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fetch-renamed-dir.sh
index 5143ed6..f6a5d64 100755
--- a/t/t9121-git-svn-fetch-renamed-dir.sh
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -8,11 +8,11 @@ test_description='git-svn can fetch renamed directories'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with renamed directory' "
-	svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump
+	svnadmin load -q '$rawsvnrepo' < ../t9121/renamed-dir.dump
 	"
 
 test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo/newname &&
+	git svn init '$svnrepo/newname' &&
 	git svn fetch
 	"
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 166b43f..57cba8b 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -24,8 +24,8 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 }
 
 unset GIT_DIR GIT_CONFIG
-WORKDIR=$(pwd)
-SERVERDIR=$(pwd)/gitcvs.git
+WORKDIR="$(pwd)"
+SERVERDIR="$(pwd)/gitcvs.git"
 git_config="$SERVERDIR/config"
 CVSROOT=":fork:$SERVERDIR"
 CVSWORK="$(pwd)/cvswork"
@@ -153,21 +153,21 @@ test_expect_success 'req_Root failure (conflicting roots)' \
    tail log | grep "^error 1 Conflicting roots specified$"'
 
 test_expect_success 'req_Root (strict paths)' \
-  'cat request-anonymous | git-cvsserver --strict-paths pserver $SERVERDIR >log 2>&1 &&
+  'cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (strict-paths)' '
     ! cat request-anonymous |
-    git-cvsserver --strict-paths pserver $WORKDIR >log 2>&1
+    git-cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
 '
 
 test_expect_success 'req_Root (w/o strict-paths)' \
-  'cat request-anonymous | git-cvsserver pserver $WORKDIR/ >log 2>&1 &&
+  'cat request-anonymous | git-cvsserver pserver "$WORKDIR"/ >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
     ! cat request-anonymous |
-    git-cvsserver pserver $WORKDIR/gitcvs >log 2>&1
+    git-cvsserver pserver "$WORKDIR"/gitcvs >log 2>&1
 '
 
 cat >request-base  <<EOF
@@ -180,25 +180,25 @@ Root /gitcvs.git
 EOF
 
 test_expect_success 'req_Root (base-path)' \
-  'cat request-base | git-cvsserver --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
+  'cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR"/ pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (base-path)' '
     ! cat request-anonymous |
-    git-cvsserver --strict-paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1
+    git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
 '
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' \
-  'cat request-anonymous | git-cvsserver --export-all pserver $WORKDIR >log 2>&1 &&
+  'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 test_expect_success 'req_Root failure (export-all w/o whitelist)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
-  'cat request-base | git-cvsserver --export-all --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
+  'cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR"/ pserver "$SERVERDIR" >log 2>&1 &&
    sed -ne \$p log | grep "^I LOVE YOU$"'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 061a259..5e486c7 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -45,13 +45,13 @@ gitweb_run () {
 	export QUERY_STRING=""$1""
 	export PATH_INFO=""$2""
 
-	export GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+	export GITWEB_CONFIG="$(pwd)"/gitweb_config.perl
 
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- $(pwd)/../../gitweb/gitweb.perl \
+	perl -- "$(pwd)"/../../gitweb/gitweb.perl \
 		>/dev/null 2>gitweb.log &&
 	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
 
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 00a74ee..a65147b 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,10 +3,10 @@
 test_description='git-cvsimport basic tests'
 . ./test-lib.sh
 
-CVSROOT=$(pwd)/cvsroot
+CVSROOT="$(pwd)"/cvsroot
 export CVSROOT
 # for clean cvsps cache
-HOME=$(pwd)
+HOME="$(pwd)"
 export HOME
 
 if ! type cvs >/dev/null 2>&1
@@ -36,7 +36,7 @@ test_expect_success 'setup cvsroot' 'cvs init'
 
 test_expect_success 'setup a cvs module' '
 
-	mkdir $CVSROOT/module &&
+	mkdir "$CVSROOT"/module &&
 	cvs co -d module-cvs module &&
 	cd module-cvs &&
 	cat <<EOF >o_fortuna &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..8065776 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -329,7 +329,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
+	"$GIT_EXEC_PATH"/git init --template="$GIT_EXEC_PATH"/templates/blt/ >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
@@ -371,16 +371,16 @@ test_done () {
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
-PATH=$(pwd)/..:$PATH
-GIT_EXEC_PATH=$(pwd)/..
-GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
+PATH="$(pwd)"/..:$PATH
+GIT_EXEC_PATH="$(pwd)"/..
+GIT_TEMPLATE_DIR="$(pwd)"/../templates/blt
 unset GIT_CONFIG
 unset GIT_CONFIG_LOCAL
 GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
-GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+GITPERLLIB="$(pwd)"/../perl/blib/lib:"$(pwd)"/../perl/blib/arch/auto/Git
 export GITPERLLIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
-- 
1.5.5.67.g9a49
