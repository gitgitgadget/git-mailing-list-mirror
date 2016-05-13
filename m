From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] t/lib-git-svn: drop $remote_git_svn and $git_svn_id
Date: Fri, 13 May 2016 16:47:14 -0400
Message-ID: <20160513204714.GA15391@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JzV-0000Ln-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbcEMUrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:47:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:39361 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751501AbcEMUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:47:17 -0400
Received: (qmail 16703 invoked by uid 102); 13 May 2016 20:47:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:17 -0400
Received: (qmail 21580 invoked by uid 107); 13 May 2016 20:47:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:47:14 -0400
Content-Disposition: inline
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294580>

These variables were added in 16805d3 (t/t91XX-svn: start
removing use of "git-" from these tests, 2008-09-08) so that
running:

  git grep git-

would return fewer hits. At the time, we were transitioning
away from the use of the "dashed" git-foo form.

That transition has been over for years, and grepping for
"git-" in the test suite yields thousands of hits anyway
(all presumably false positives).

With their original purpose gone, these variables serve only
to obfuscate the tests. Let's get rid of them.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-git-svn.sh                              |  3 ---
 t/t9100-git-svn-basic.sh                      | 38 +++++++++++++--------------
 t/t9101-git-svn-props.sh                      | 12 ++++-----
 t/t9102-git-svn-deep-rmdir.sh                 |  2 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |  6 ++---
 t/t9107-git-svn-migrate.sh                    | 14 +++++-----
 t/t9110-git-svn-use-svm-props.sh              | 18 ++++++-------
 t/t9111-git-svn-use-svnsync-props.sh          | 18 ++++++-------
 t/t9120-git-svn-clone-with-percent-escapes.sh |  6 ++---
 t/t9123-git-svn-rebuild-with-rewriteroot.sh   |  2 +-
 t/t9153-git-svn-rewrite-uuid.sh               |  4 +--
 11 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 6a50b87..fb88232 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -1,8 +1,5 @@
 . ./test-lib.sh
 
-remotes_git_svn=remotes/git""-svn
-git_svn_id=git""-svn-id
-
 if test -n "$NO_SVN_TESTS"
 then
 	skip_all='skipping git svn tests, NO_SVN_TESTS defined'
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 22d8367..6ec73ee 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -45,13 +45,13 @@ test_expect_success "checkout from svn" 'svn co "$svnrepo" "$SVN_TREE"'
 
 name='try a deep --rmdir with a commit'
 test_expect_success "$name" '
-	git checkout -f -b mybranch ${remotes_git_svn} &&
+	git checkout -f -b mybranch remotes/git-svn &&
 	mv dir/a/b/c/d/e/file dir/file &&
 	cp dir/file file &&
 	git update-index --add --remove dir/a/b/c/d/e/file dir/file file &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch &&
+		remotes/git-svn..mybranch &&
 	svn_cmd up "$SVN_TREE" &&
 	test -d "$SVN_TREE"/dir && test ! -d "$SVN_TREE"/dir/a'
 
@@ -65,14 +65,14 @@ test_expect_success "$name" "
 	git update-index --add dir/file/file &&
 	git commit -m '$name' &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch
+		remotes/git-svn..mybranch
 "
 
 
 name='detect node change from directory to file #1'
 test_expect_success "$name" '
 	rm -rf dir "$GIT_DIR"/index &&
-	git checkout -f -b mybranch2 ${remotes_git_svn} &&
+	git checkout -f -b mybranch2 remotes/git-svn &&
 	mv bar/zzz zzz &&
 	rm -rf bar &&
 	mv zzz bar &&
@@ -80,14 +80,14 @@ test_expect_success "$name" '
 	git update-index --add -- bar &&
 	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch2
+		remotes/git-svn..mybranch2
 '
 
 
 name='detect node change from file to directory #2'
 test_expect_success "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch3 ${remotes_git_svn} &&
+	git checkout -f -b mybranch3 remotes/git-svn &&
 	rm bar/zzz &&
 	git update-index --remove bar/zzz &&
 	mkdir bar/zzz &&
@@ -95,7 +95,7 @@ test_expect_success "$name" '
 	git update-index --add bar/zzz/yyy &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch3 &&
+		remotes/git-svn..mybranch3 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -d "$SVN_TREE"/bar/zzz &&
 	test -e "$SVN_TREE"/bar/zzz/yyy
@@ -104,7 +104,7 @@ test_expect_success "$name" '
 name='detect node change from directory to file #2'
 test_expect_success "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch4 ${remotes_git_svn} &&
+	git checkout -f -b mybranch4 remotes/git-svn &&
 	rm -rf dir &&
 	git update-index --remove -- dir/file &&
 	touch dir &&
@@ -112,19 +112,19 @@ test_expect_success "$name" '
 	git update-index --add -- dir &&
 	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch4
+		remotes/git-svn..mybranch4
 '
 
 
 name='remove executable bit from a file'
 test_expect_success POSIXPERM "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch5 ${remotes_git_svn} &&
+	git checkout -f -b mybranch5 remotes/git-svn &&
 	chmod -x exec.sh &&
 	git update-index exec.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch5 &&
+		remotes/git-svn..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test ! -x "$SVN_TREE"/exec.sh'
 
@@ -135,7 +135,7 @@ test_expect_success POSIXPERM "$name" '
 	git update-index exec.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch5 &&
+		remotes/git-svn..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -x "$SVN_TREE"/exec.sh'
 
@@ -147,7 +147,7 @@ test_expect_success SYMLINKS "$name" '
 	git update-index exec.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch5 &&
+		remotes/git-svn..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -h "$SVN_TREE"/exec.sh'
 
@@ -159,7 +159,7 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 	git update-index --add file exec-2.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch5 &&
+		remotes/git-svn..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -x "$SVN_TREE"/file &&
 	test -h "$SVN_TREE"/exec-2.sh'
@@ -172,7 +172,7 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 	git update-index exec-2.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch5 &&
+		remotes/git-svn..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -f "$SVN_TREE"/exec-2.sh &&
 	test ! -h "$SVN_TREE"/exec-2.sh &&
@@ -194,7 +194,7 @@ GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
     'git svn init "$svnrepo" && git svn fetch &&
-     git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
+     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      test_cmp a b'
 
@@ -219,7 +219,7 @@ test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
 
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
-                              bar:refs/${remotes_git_svn} &&
+		bar:refs/remotes/git-svn &&
 	test_must_fail git svn migrate
 "
 
@@ -227,7 +227,7 @@ test_expect_success 'exit if init-ing a would clobber a URL' '
         svnadmin create "${PWD}/svnrepo2" &&
         svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
         git config --unset svn-remote.svn.fetch \
-                                "^bar:refs/${remotes_git_svn}$" &&
+		"^bar:refs/remotes/git-svn$" &&
 	test_must_fail git svn init "${svnrepo}2/bar"
         '
 
@@ -237,7 +237,7 @@ test_expect_success \
         git config --get svn-remote.svn.fetch \
                               "^bar:refs/remotes/bar$" &&
         git config --get svn-remote.svn.fetch \
-                              "^:refs/${remotes_git_svn}$"
+			      "^:refs/remotes/git-svn$"
         '
 
 test_expect_success 'dcommit $rev does not clobber current branch' '
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index e8173d5..07bfb63 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -73,11 +73,11 @@ test_expect_success 'fetch revisions from svn' 'git svn fetch'
 
 name='test svn:keywords ignoring'
 test_expect_success "$name" \
-	'git checkout -b mybranch ${remotes_git_svn} &&
+	'git checkout -b mybranch remotes/git-svn &&
 	echo Hi again >> kw.c &&
 	git commit -a -m "test keywords ignoring" &&
-	git svn set-tree ${remotes_git_svn}..mybranch &&
-	git pull . ${remotes_git_svn}'
+	git svn set-tree remotes/git-svn..mybranch &&
+	git pull . remotes/git-svn'
 
 expect='/* $Id$ */'
 got="$(sed -ne 2p kw.c)"
@@ -95,7 +95,7 @@ test_expect_success "propset CR on crlf files" '
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git svn fetch &&
-	 git pull . ${remotes_git_svn} &&
+	 git pull . remotes/git-svn &&
 	 svn_cmd co "$svnrepo" new_wc'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
@@ -117,7 +117,7 @@ cd test_wc
 	 svn_cmd commit -m "propset CRLF on cr files"'
 cd ..
 test_expect_success 'fetch and pull latest from svn' \
-	'git svn fetch && git pull . ${remotes_git_svn}'
+	'git svn fetch && git pull . remotes/git-svn'
 
 b_cr="$(git hash-object cr)"
 b_ne_cr="$(git hash-object ne_cr)"
@@ -168,7 +168,7 @@ cat >create-ignore-index.expect <<\EOF
 EOF
 
 test_expect_success 'test create-ignore' "
-	git svn fetch && git pull . ${remotes_git_svn} &&
+	git svn fetch && git pull . remotes/git-svn &&
 	git svn create-ignore &&
 	cmp ./.gitignore create-ignore.expect &&
 	cmp ./deeply/.gitignore create-ignore.expect &&
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index eb70f48..66cd511 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -17,7 +17,7 @@ test_expect_success 'initialize repo' '
 test_expect_success 'mirror via git svn' '
 	git svn init "$svnrepo" &&
 	git svn fetch &&
-	git checkout -f -b test-rmdir ${remotes_git_svn}
+	git checkout -f -b test-rmdir remotes/git-svn
 	'
 
 test_expect_success 'Try a commit on rmdir' '
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f6d7ac7..dbe8dea 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -44,7 +44,7 @@ test_expect_success 'commit complementing change from git' '
 test_expect_success 'dcommit fails to commit because of conflict' '
 	git svn init "$svnrepo" &&
 	git svn fetch &&
-	git reset --hard refs/${remotes_git_svn} &&
+	git reset --hard refs/remotes/git-svn &&
 	svn_cmd co "$svnrepo" t.svn &&
 	(
 		cd t.svn &&
@@ -59,7 +59,7 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	'
 
 test_expect_success 'dcommit does the svn equivalent of an index merge' "
-	git reset --hard refs/${remotes_git_svn} &&
+	git reset --hard refs/remotes/git-svn &&
 	echo 'index merge' > file2 &&
 	git update-index --add file2 &&
 	git commit -a -m 'index merge' &&
@@ -81,7 +81,7 @@ test_expect_success 'commit another change from svn side' '
 	'
 
 test_expect_success 'multiple dcommit from git svn will not clobber svn' "
-	git reset --hard refs/${remotes_git_svn} &&
+	git reset --hard refs/remotes/git-svn &&
 	echo new file >> new-file &&
 	git update-index --add new-file &&
 	git commit -a -m 'new file' &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 9060198..6efc2ab 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -19,9 +19,9 @@ test_expect_success 'setup old-looking metadata' '
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	rm -rf "$GIT_DIR"/svn &&
-	git update-ref refs/heads/git-svn-HEAD refs/${remotes_git_svn} &&
-	git update-ref refs/heads/svn-HEAD refs/${remotes_git_svn} &&
-	git update-ref -d refs/${remotes_git_svn} refs/${remotes_git_svn}
+	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
+	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
+	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
 	'
 
 head=$(git rev-parse --verify refs/heads/git-svn-HEAD^0)
@@ -35,11 +35,11 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 	echo "$svnrepo" > "$GIT_DIR"/svn/info/url &&
 	git svn migrate &&
 	! test -d "$GIT_DIR"/git-svn &&
-	git rev-parse --verify refs/${remotes_git_svn}^0 &&
+	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
 	test "$(git config --get svn-remote.svn.url)" = "$svnrepo_escaped" &&
 	test $(git config --get svn-remote.svn.fetch) = \
-             ":refs/${remotes_git_svn}"
+		":refs/remotes/git-svn"
 	'
 
 test_expect_success 'initialize a multi-repository repo' '
@@ -66,7 +66,7 @@ test_expect_success 'initialize a multi-repository repo' '
 	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
 	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
 	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
-	grep "^:refs/${remotes_git_svn}" fetch.out
+	grep "^:refs/remotes/git-svn" fetch.out
 	'
 
 # refs should all be different, but the trees should all be the same:
@@ -104,7 +104,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
 	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
 	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
-	grep "^:refs/${remotes_git_svn}" fetch.out
+	grep "^:refs/remotes/git-svn" fetch.out
 	'
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 29fbdfd..dde0a3c 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -22,31 +22,31 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar | \
-	   grep '^${git_svn_id}: $bar_url@12 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
 	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^${git_svn_id}: $bar_url@11 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
 	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^${git_svn_id}: $bar_url@10 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
 	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^${git_svn_id}: $bar_url@9 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
 	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^${git_svn_id}: $bar_url@6 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
 	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^${git_svn_id}: $bar_url@1 $uuid$'
+	   grep '^git-svn-id: $bar_url@1 $uuid$'
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e | \
-	   grep '^${git_svn_id}: $e_url@1 $uuid$'
+	   grep '^git-svn-id: $e_url@1 $uuid$'
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir | \
-	   grep '^${git_svn_id}: $dir_url@2 $uuid$' &&
+	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
 	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^${git_svn_id}: $dir_url@1 $uuid$'
+	   grep '^git-svn-id: $dir_url@1 $uuid$'
 	"
 
 test_expect_success 'find commit based on SVN revision number' "
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index bd081c2..22b6e5e 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -21,31 +21,31 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar | \
-	   grep '^${git_svn_id}: $bar_url@12 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
 	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^${git_svn_id}: $bar_url@11 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
 	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^${git_svn_id}: $bar_url@10 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
 	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^${git_svn_id}: $bar_url@9 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
 	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^${git_svn_id}: $bar_url@6 $uuid$' &&
+	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
 	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^${git_svn_id}: $bar_url@1 $uuid$'
+	   grep '^git-svn-id: $bar_url@1 $uuid$'
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e | \
-	   grep '^${git_svn_id}: $e_url@1 $uuid$'
+	   grep '^git-svn-id: $e_url@1 $uuid$'
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir | \
-	   grep '^${git_svn_id}: $dir_url@2 $uuid$' &&
+	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
 	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^${git_svn_id}: $dir_url@1 $uuid$'
+	   grep '^git-svn-id: $dir_url@1 $uuid$'
 	"
 
 test_done
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 1c84ce1..59465b1 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -22,7 +22,7 @@ test_expect_success 'test clone with percent escapes' '
 	git svn clone "$svnrepo/pr%20ject" clone &&
 	(
 		cd clone &&
-		git rev-parse refs/${remotes_git_svn}
+		git rev-parse refs/remotes/git-svn
 	)
 '
 
@@ -42,7 +42,7 @@ test_expect_success 'test clone trunk with percent escapes and minimize-url' '
 	git svn clone --minimize-url "$svnrepo/pr%20ject/trunk" minimize &&
 	(
 		cd minimize &&
-		git rev-parse refs/${remotes_git_svn}
+		git rev-parse refs/remotes/git-svn
 	)
 '
 
@@ -50,7 +50,7 @@ test_expect_success 'test clone trunk with percent escapes' '
 	git svn clone "$svnrepo/pr%20ject/trunk" trunk &&
 	(
 		cd trunk &&
-		git rev-parse refs/${remotes_git_svn}
+		git rev-parse refs/remotes/git-svn
 	)
 '
 
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index fd81847..ead4045 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -17,7 +17,7 @@ rm -rf import
 test_expect_success 'init, fetch and checkout repository' '
 	git svn init --rewrite-root=http://invalid.invalid/ "$svnrepo" &&
 	git svn fetch &&
-	git checkout -b mybranch ${remotes_git_svn}
+	git checkout -b mybranch remotes/git-svn
 	'
 
 test_expect_success 'remove rev_map' '
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
index 88a2cfa..372ef15 100755
--- a/t/t9153-git-svn-rewrite-uuid.sh
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -17,9 +17,9 @@ test_expect_success 'load svn repo' "
 
 test_expect_success 'verify uuid' "
 	git cat-file commit refs/remotes/git-svn~0 | \
-	   grep '^${git_svn_id}: .*@2 $uuid$' &&
+	   grep '^git-svn-id: .*@2 $uuid$' &&
 	git cat-file commit refs/remotes/git-svn~1 | \
-	   grep '^${git_svn_id}: .*@1 $uuid$'
+	   grep '^git-svn-id: .*@1 $uuid$'
 	"
 
 test_done
-- 
2.8.2.825.gea31738
