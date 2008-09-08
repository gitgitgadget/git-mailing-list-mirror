From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] t/t91XX-svn: start removing use of "git-" from these tests
Date: Mon, 08 Sep 2008 19:02:05 +0900
Message-ID: <20080908190205.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcdb2-0001Wb-RE
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 12:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYIHKCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 06:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYIHKCl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 06:02:41 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35234 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbYIHKCk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 06:02:40 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 10F03C7AC2;
	Mon,  8 Sep 2008 05:02:30 -0500 (CDT)
Received: from 3055.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 2JYGZNGAIMCO; Mon, 08 Sep 2008 05:02:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Md7NriD80yq3fvg2ApduL/4dkPQi7Uvb7rx3h1BnHDLjsDtI5NMg9M4N8E7s1WFfpRN5CXt6OefYTkDsLEVfoxMLTa4PCTwCgcGNLvvpoUQ17Sr0XdsRWJTrcNDU8w3xGnE5zAWNCJukKFWXoYE1LmfNKP+931utLidVaUGWMPc=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95232>

Subversion tests use too many "git-foo" form, so I am converting them
in two steps.

This first step replaces literal strings "remotes/git-svn" and "git-svn-id"
by introducing $remotes_git_svn and $git_svn_id constants defined as shell
variables.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/lib-git-svn.sh                              |    3 ++
 t/t9100-git-svn-basic.sh                      |   38 ++++++++++++------------
 t/t9101-git-svn-props.sh                      |   12 ++++----
 t/t9102-git-svn-deep-rmdir.sh                 |    2 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |    6 ++--
 t/t9107-git-svn-migrate.sh                    |   12 ++++----
 t/t9110-git-svn-use-svm-props.sh              |   18 ++++++------
 t/t9111-git-svn-use-svnsync-props.sh          |   18 ++++++------
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh   |    2 +-
 10 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index a841df2..c33dc2d 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -2,2 +2,5 @@
 
+remotes_git_svn=remotes/git""-svn
+git_svn_id=git""-svn-id
+
 if test -n "$NO_SVN_TESTS"
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 843a501..5f4cfb6 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -46,3 +46,3 @@ name='try a deep --rmdir with a commit'
 test_expect_success "$name" '
-	git checkout -f -b mybranch remotes/git-svn &&
+	git checkout -f -b mybranch ${remotes_git_svn} &&
 	mv dir/a/b/c/d/e/file dir/file &&
@@ -52,3 +52,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch &&
+		${remotes_git_svn}..mybranch &&
 	svn up "$SVN_TREE" &&
@@ -66,3 +66,3 @@ test_expect_success "$name" "
 	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch" || true
+		${remotes_git_svn}..mybranch" || true
 
@@ -72,3 +72,3 @@ test_expect_success "$name" '
 	rm -rf dir "$GIT_DIR"/index &&
-	git checkout -f -b mybranch2 remotes/git-svn &&
+	git checkout -f -b mybranch2 ${remotes_git_svn} &&
 	mv bar/zzz zzz &&
@@ -80,3 +80,3 @@ test_expect_success "$name" '
 	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch2' || true
+		${remotes_git_svn}..mybranch2' || true
 
@@ -86,3 +86,3 @@ test_expect_success "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch3 remotes/git-svn &&
+	git checkout -f -b mybranch3 ${remotes_git_svn} &&
 	rm bar/zzz &&
@@ -94,3 +94,3 @@ test_expect_success "$name" '
 	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch3' || true
+		${remotes_git_svn}..mybranch3' || true
 
@@ -100,3 +100,3 @@ test_expect_success "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch4 remotes/git-svn &&
+	git checkout -f -b mybranch4 ${remotes_git_svn} &&
 	rm -rf dir &&
@@ -108,3 +108,3 @@ test_expect_success "$name" '
 	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch4' || true
+		${remotes_git_svn}..mybranch4' || true
 
@@ -114,3 +114,3 @@ test_expect_success "$name" '
 	rm -f "$GIT_DIR"/index &&
-	git checkout -f -b mybranch5 remotes/git-svn &&
+	git checkout -f -b mybranch5 ${remotes_git_svn} &&
 	chmod -x exec.sh &&
@@ -119,3 +119,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch5 &&
+		${remotes_git_svn}..mybranch5 &&
 	svn up "$SVN_TREE" &&
@@ -130,3 +130,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch5 &&
+		${remotes_git_svn}..mybranch5 &&
 	svn up "$SVN_TREE" &&
@@ -142,3 +142,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch5 &&
+		${remotes_git_svn}..mybranch5 &&
 	svn up "$SVN_TREE" &&
@@ -154,3 +154,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch5 &&
+		${remotes_git_svn}..mybranch5 &&
 	svn up "$SVN_TREE" &&
@@ -167,3 +167,3 @@ test_expect_success "$name" '
 	git-svn set-tree --find-copies-harder --rmdir \
-		remotes/git-svn..mybranch5 &&
+		${remotes_git_svn}..mybranch5 &&
 	svn up "$SVN_TREE" &&
@@ -193,3 +193,3 @@ test_expect_success "$name" \
     'git-svn init "$svnrepo" && git-svn fetch &&
-     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
+     git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
@@ -217,3 +217,3 @@ test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
-                              bar:refs/remotes/git-svn &&
+                              bar:refs/${remotes_git_svn} &&
 	test_must_fail git-svn migrate
@@ -225,3 +225,3 @@ test_expect_success 'exit if init-ing a would clobber a URL' '
         git config --unset svn-remote.svn.fetch \
-                                "^bar:refs/remotes/git-svn$" &&
+                                "^bar:refs/${remotes_git_svn}$" &&
 	test_must_fail git-svn init "${svnrepo}2/bar"
@@ -235,3 +235,3 @@ test_expect_success \
         git config --get svn-remote.svn.fetch \
-                              "^:refs/remotes/git-svn$"
+                              "^:refs/${remotes_git_svn}$"
         '
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index f420796..02eccc9 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -73,7 +73,7 @@ name='test svn:keywords ignoring'
 test_expect_success "$name" \
-	'git checkout -b mybranch remotes/git-svn &&
+	'git checkout -b mybranch ${remotes_git_svn} &&
 	echo Hi again >> kw.c &&
 	git commit -a -m "test keywords ignoring" &&
-	git-svn set-tree remotes/git-svn..mybranch &&
-	git pull . remotes/git-svn'
+	git-svn set-tree ${remotes_git_svn}..mybranch &&
+	git pull . ${remotes_git_svn}'
 
@@ -93,3 +93,3 @@ test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git-svn fetch &&
-	 git pull . remotes/git-svn &&
+	 git pull . ${remotes_git_svn} &&
 	 svn co "$svnrepo" new_wc'
@@ -115,3 +115,3 @@ cd ..
 test_expect_success 'fetch and pull latest from svn' \
-	'git-svn fetch && git pull . remotes/git-svn'
+	'git-svn fetch && git pull . ${remotes_git_svn}'
 
@@ -163,3 +163,3 @@ EOF
 test_expect_success 'test create-ignore' "
-	git-svn fetch && git pull . remotes/git-svn &&
+	git-svn fetch && git pull . ${remotes_git_svn} &&
 	git-svn create-ignore &&
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 0e7ce34..0ad6e24 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -18,3 +18,3 @@ test_expect_success 'mirror via git-svn' '
 	git-svn fetch &&
-	git checkout -f -b test-rmdir remotes/git-svn
+	git checkout -f -b test-rmdir ${remotes_git_svn}
 	'
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 83896e9..da559f8 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -44,3 +44,3 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	git-svn fetch &&
-	git reset --hard refs/remotes/git-svn &&
+	git reset --hard refs/${remotes_git_svn} &&
 	svn co "$svnrepo" t.svn &&
@@ -58,3 +58,3 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 test_expect_success 'dcommit does the svn equivalent of an index merge' "
-	git reset --hard refs/remotes/git-svn &&
+	git reset --hard refs/${remotes_git_svn} &&
 	echo 'index merge' > file2 &&
@@ -79,3 +79,3 @@ test_expect_success 'commit another change from svn side' '
 test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
-	git reset --hard refs/remotes/git-svn &&
+	git reset --hard refs/${remotes_git_svn} &&
 	echo new file >> new-file &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index d9b553a..f3c75fc 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -21,5 +21,5 @@ test_expect_success 'setup old-looking metadata' '
 	rmdir "$GIT_DIR"/svn &&
-	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
-	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
-	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
+	git update-ref refs/heads/git-svn-HEAD refs/${remotes_git_svn} &&
+	git update-ref refs/heads/svn-HEAD refs/${remotes_git_svn} &&
+	git update-ref -d refs/${remotes_git_svn} refs/${remotes_git_svn}
 	'
@@ -35,3 +35,3 @@ test_expect_success 'initialize old-style (v0) git-svn layout' '
 	! test -d "$GIT_DIR"/git-svn &&
-	git rev-parse --verify refs/remotes/git-svn^0 &&
+	git rev-parse --verify refs/${remotes_git_svn}^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
@@ -39,3 +39,3 @@ test_expect_success 'initialize old-style (v0) git-svn layout' '
 	test `git config --get svn-remote.svn.fetch` = \
-             ":refs/remotes/git-svn"
+             ":refs/${remotes_git_svn}"
 	'
@@ -96,3 +96,3 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out
-	grep "^:refs/remotes/git-svn" fetch.out
+	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 83bd1cf..211baf4 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -24,13 +24,13 @@ test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@12 $uuid$' &&
 	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@11 $uuid$' &&
 	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@10 $uuid$' &&
 	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@9 $uuid$' &&
 	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@6 $uuid$' &&
 	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	   grep '^${git_svn_id}: $bar_url@1 $uuid$'
 	"
@@ -40,3 +40,3 @@ test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	   grep '^${git_svn_id}: $e_url@1 $uuid$'
 	"
@@ -46,5 +46,5 @@ test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
+	   grep '^${git_svn_id}: $dir_url@2 $uuid$' &&
 	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	   grep '^${git_svn_id}: $dir_url@1 $uuid$'
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index c5dfd61..aab109c 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -23,13 +23,13 @@ test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@12 $uuid$' &&
 	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@11 $uuid$' &&
 	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@10 $uuid$' &&
 	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@9 $uuid$' &&
 	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
+	   grep '^${git_svn_id}: $bar_url@6 $uuid$' &&
 	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	   grep '^${git_svn_id}: $bar_url@1 $uuid$'
 	"
@@ -39,3 +39,3 @@ test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	   grep '^${git_svn_id}: $e_url@1 $uuid$'
 	"
@@ -45,5 +45,5 @@ test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
+	   grep '^${git_svn_id}: $dir_url@2 $uuid$' &&
 	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	   grep '^${git_svn_id}: $dir_url@1 $uuid$'
 	"
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 5979e13..e5de229 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -23,3 +23,3 @@ else
 		cd clone &&
-			git rev-parse refs/remotes/git-svn &&
+			git rev-parse refs/${remotes_git_svn} &&
 		cd ..
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index c18878f..363c1db 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -19,3 +19,3 @@ test_expect_success 'init, fetch and checkout repository' '
 	git svn fetch
-	git checkout -b mybranch remotes/git-svn
+	git checkout -b mybranch ${remotes_git_svn}
 	'
-- 
1.6.0.1
