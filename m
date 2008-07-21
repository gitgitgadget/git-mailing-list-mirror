From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Rename .git/rebase to .git/rebase-apply
Date: Mon, 21 Jul 2008 12:51:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807211246370.3305@eeepc-johanness>
References: <7vd4l7wyfl.fsf@gitster.siamese.dyndns.org> <m3k5ffwsma.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsz6-00075u-3b
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbYGUKuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbYGUKuP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:50:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:37931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbYGUKuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:50:13 -0400
Received: (qmail invoked by alias); 21 Jul 2008 10:50:10 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp061) with SMTP; 21 Jul 2008 12:50:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++hQt3qfy+3Y4aAMHYXD/JS92G+4jFUacUzIi2QV
	mGNIxrXvJmp9YS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <m3k5ffwsma.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89338>


With git-am, it sounds awkward to have the patches in ".git/rebase/",
but for technical reasons, we have to keep the same directory name
for git-am and git-rebase. ".git/rebase-apply" seems to be a good
compromise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 21 Jul 2008, Jakub Narebski wrote:

	> Junio C Hamano <gitster@pobox.com> writes:
	> 
	> >  * The ".dotest" temporary area "git am" and "git rebase" use 
	> >    will be moved to $GIT_DIR/rebase.  We might change it to 
	> >    $GIT_DIR/rebase-apply which would be more logical name before
	> >    the final, though.
	> 
	> Very good idea.  $GIT_DIR/rebase looks slightly strange with git-am.

	Since I was responsible for the patch in the first place, here is 
	a follow-up patch to imlement the rebase-apply thing.

 Documentation/SubmittingPatches        |    2 +-
 Documentation/git-am.txt               |    4 +-
 Documentation/git-rebase.txt           |    4 +-
 Documentation/user-manual.txt          |    2 +-
 contrib/completion/git-completion.bash |   10 +++---
 contrib/emacs/git.el                   |    8 ++--
 git-am.sh                              |    2 +-
 git-quiltimport.sh                     |    2 +-
 git-rebase.sh                          |   48 ++++++++++++++++---------------
 t/t3401-rebase-partial.sh              |    2 +-
 t/t3407-rebase-abort.sh                |    2 +-
 t/t4150-am.sh                          |   22 +++++++-------
 t/t9106-git-svn-commit-diff-clobber.sh |    4 ++-
 13 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index fdfa536..841bead 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -301,7 +301,7 @@ If it does not apply correctly, there can be various reasons.
   patch appropriately.
 
 * Your MUA corrupted your patch; "am" would complain that
-  the patch does not apply.  Look at .git/rebase/ subdirectory and
+  the patch does not apply.  Look at .git/rebase-apply/ subdirectory and
   see what 'patch' file contains and check for the common
   corruption patterns mentioned above.
 
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e010a16..ee335ae 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -143,9 +143,9 @@ aborts in the middle,.  You can recover from this in one of two ways:
   the index file to bring it in a state that the patch should
   have produced.  Then run the command with '--resolved' option.
 
-The command refuses to process new mailboxes while `.git/rebase`
+The command refuses to process new mailboxes while `.git/rebase-apply`
 directory exists, so if you decide to start over from scratch,
-run `rm -f -r .git/rebase` before running the command with mailbox
+run `rm -f -r .git/rebase-apply` before running the command with mailbox
 names.
 
 Before any patches are applied, ORIG_HEAD is set to the tip of the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 51afc87..0764b3c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -39,8 +39,8 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run `git rebase --continue`.  Another option is to bypass the commit
 that caused the merge failure with `git rebase --skip`.  To restore the
-original <branch> and remove the .git/rebase working files, use the command
-`git rebase --abort` instead.
+original <branch> and remove the .git/rebase-apply working files, use the
+command `git rebase --abort` instead.
 
 Assume the following history exists and the current branch is "topic":
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8761ee7..c5641af 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2431,7 +2431,7 @@ $ git rebase origin
 -------------------------------------------------
 
 This will remove each of your commits from mywork, temporarily saving
-them as patches (in a directory named ".git/rebase"), update mywork to
+them as patches (in a directory named ".git/rebase-apply"), update mywork to
 point at the latest version of origin, then apply each of the saved
 patches to the new mywork.  The result will look like:
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 29f6cd4..2edb341 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -73,12 +73,12 @@ __git_ps1 ()
 	if [ -n "$g" ]; then
 		local r
 		local b
-		if [ -d "$g/rebase" ]
+		if [ -d "$g/rebase-apply" ]
 		then
-			if test -f "$g/rebase/rebasing"
+			if test -f "$g/rebase-apply/rebasing"
 			then
 				r="|REBASE"
-			elif test -f "$g/rebase/applying"
+			elif test -f "$g/rebase-apply/applying"
 			then
 				r="|AM"
 			else
@@ -488,7 +488,7 @@ __git_whitespacelist="nowarn warn error error-all strip"
 _git_am ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
-	if [ -d "$dir"/rebase ]; then
+	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --resolved"
 		return
 	fi
@@ -915,7 +915,7 @@ _git_push ()
 _git_rebase ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
-	if [ -d "$dir"/rebase ] || [ -d "$dir"/rebase-merge ]; then
+	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 43b059b..c1cf1cb 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1252,8 +1252,8 @@ Return the list of files that haven't been handled."
        "\n")
       (when subject (insert subject "\n\n"))
       (cond (msg (insert msg "\n"))
-            ((file-readable-p ".git/rebase/msg")
-             (insert-file-contents ".git/rebase/msg"))
+            ((file-readable-p ".git/rebase-apply/msg")
+             (insert-file-contents ".git/rebase-apply/msg"))
             ((file-readable-p ".git/MERGE_MSG")
              (insert-file-contents ".git/MERGE_MSG")))
       ; delete empty lines at end
@@ -1272,9 +1272,9 @@ Return the list of files that haven't been handled."
           (coding-system (git-get-commits-coding-system))
           author-name author-email subject date)
       (when (eq 0 (buffer-size buffer))
-        (when (file-readable-p ".git/rebase/info")
+        (when (file-readable-p ".git/rebase-apply/info")
           (with-temp-buffer
-            (insert-file-contents ".git/rebase/info")
+            (insert-file-contents ".git/rebase-apply/info")
             (goto-char (point-min))
             (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
               (setq author-name (match-string 1))
diff --git a/git-am.sh b/git-am.sh
index 60aaa4a..9bf12fe 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest="$GIT_DIR/rebase"
+dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index c9aecfd..cebaee1 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -53,7 +53,7 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 fi
 
 # Temporary directories
-tmp_dir="$GIT_DIR"/rebase
+tmp_dir="$GIT_DIR"/rebase-apply
 tmp_msg="$tmp_dir/msg"
 tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
diff --git a/git-rebase.sh b/git-rebase.sh
index 6ef5754..412e135 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -14,8 +14,8 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run git rebase --continue.  Another option is to bypass the commit
 that caused the merge failure with git rebase --skip.  To restore the
-original <branch> and remove the .git/rebase working files, use the command
-git rebase --abort instead.
+original <branch> and remove the .git/rebase-apply working files, use the
+command git rebase --abort instead.
 
 Note that if <branch> is not specified on the command line, the
 currently checked out branch is used.
@@ -150,7 +150,7 @@ while test $# != 0
 do
 	case "$1" in
 	--continue)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
 
 		git diff-files --quiet --ignore-submodules || {
@@ -173,15 +173,15 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase/orig-head) &&
+		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
+		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
+		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--skip)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
@@ -201,15 +201,15 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase/orig-head) &&
+		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
+		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
+		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--abort)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
 
 		git rerere clear
@@ -217,7 +217,7 @@ do
 		then
 			move_to_original_branch
 		else
-			dotest="$GIT_DIR"/rebase
+			dotest="$GIT_DIR"/rebase-apply
 			move_to_original_branch
 		fi
 		git reset --hard $(cat "$dotest/orig-head")
@@ -265,18 +265,20 @@ do
 	shift
 done
 
-# Make sure we do not have $GIT_DIR/rebase
+# Make sure we do not have $GIT_DIR/rebase-apply
 if test -z "$do_merge"
 then
-	if mkdir "$GIT_DIR"/rebase
+	if mkdir "$GIT_DIR"/rebase-apply
 	then
-		rmdir "$GIT_DIR"/rebase
+		rmdir "$GIT_DIR"/rebase-apply
 	else
 		echo >&2 '
-It seems that I cannot create a '"$GIT_DIR"'/rebase directory, and I wonder if you
-are in the middle of patch application or another rebase.  If that is not
-the case, please rm -fr '"$GIT_DIR"'/rebase and run me again.  I am stopping in case
-you still have something valuable there.'
+It seems that I cannot create a '"$GIT_DIR"'/rebase-apply directory,
+and I wonder if you are in the middle of patch application or another
+rebase.  If that is not the case, please
+	rm -fr '"$GIT_DIR"'/rebase-apply
+ and run me again.  I am stopping in case you still have something
+valuable there.'
 		exit 1
 	fi
 else
@@ -395,10 +397,10 @@ then
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
-	test 0 != $ret -a -d "$GIT_DIR"/rebase &&
-		echo $head_name > "$GIT_DIR"/rebase/head-name &&
-		echo $onto > "$GIT_DIR"/rebase/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase/orig-head
+	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
+		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
+		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
+		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head
 	exit $ret
 fi
 
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 36d9a2a..166ddb1 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -50,7 +50,7 @@ test_debug \
 
 test_expect_success \
     'rebase topic branch against new master and check git-am did not get halted' \
-    'git-rebase master && test ! -d .git/rebase'
+    'git-rebase master && test ! -d .git/rebase-apply'
 
 test_expect_success \
 	'rebase --merge topic branch that was partially merged upstream' \
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 12c8804..4de550a 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -74,7 +74,7 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase
+testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 98ba020..6e6aaf5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -102,7 +102,7 @@ test_expect_success 'am applies patch correctly' '
 	git checkout first &&
 	test_tick &&
 	git am <patch1 &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test -z "$(git diff second)" &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -123,7 +123,7 @@ test_expect_success 'am changes committer and keeps author' '
 	test_tick &&
 	git checkout first &&
 	git am patch2 &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
 	test -z "$(git diff master..HEAD)" &&
 	test -z "$(git diff master^..HEAD^)" &&
@@ -163,7 +163,7 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 test_expect_success 'am --keep really keeps the subject' '
 	git checkout HEAD^ &&
 	git am --keep patch4 &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	git-cat-file commit HEAD |
 		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
 '
@@ -176,19 +176,19 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	test_tick &&
 	git commit -m "copied stuff" &&
 	git am -3 lorem-move.patch &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test -z "$(git diff lorem)"
 '
 
 test_expect_success 'am pauses on conflict' '
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
-	test -d .git/rebase
+	test -d .git/rebase-apply
 '
 
 test_expect_success 'am --skip works' '
 	git am --skip &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test -z "$(git diff lorem2^^ -- file)" &&
 	test goodbye = "$(cat another)"
 '
@@ -196,31 +196,31 @@ test_expect_success 'am --skip works' '
 test_expect_success 'am --resolved works' '
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
-	test -d .git/rebase &&
+	test -d .git/rebase-apply &&
 	echo resolved >>file &&
 	git add file &&
 	git am --resolved &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test goodbye = "$(cat another)"
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
 	git checkout first &&
 	cat pine patch1 | git am &&
-	! test -d .git/rebase &&
+	! test -d .git/rebase-apply &&
 	test -z "$(git diff master^..HEAD)"
 '
 
 test_expect_success 'am fails on mail without patch' '
 	test_must_fail git am <failmail &&
-	rm -r .git/rebase/
+	rm -r .git/rebase-apply/
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
 	test_must_fail git am <failmail &&
 	git am --skip &&
-	! test -d .git/rebase
+	! test -d .git/rebase-apply
 '
 
 test_expect_success 'am works from stdin in subdirectory' '
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 08bf1f0..83896e9 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -87,7 +87,9 @@ test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
 	"
 
 
-test_expect_success 'check that rebase really failed' 'test -d .git/rebase'
+test_expect_success 'check that rebase really failed' '
+	test -d .git/rebase-apply
+'
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
 	echo clobber and I really mean it > file &&
-- 
1.5.6.2.516.g22071
