From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] t9100,t3419: enclose all test code in single-quotes
Date: Fri, 13 May 2016 16:47:18 -0400
Message-ID: <20160513204717.GB15391@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jzb-0000Qg-Bg
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbcEMUrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:47:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:39365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751501AbcEMUrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:47:21 -0400
Received: (qmail 16712 invoked by uid 102); 13 May 2016 20:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:20 -0400
Received: (qmail 21585 invoked by uid 107); 13 May 2016 20:47:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:47:18 -0400
Content-Disposition: inline
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294578>

A few tests here use double-quotes around the snippets of
shell code to run the tests. None of these tests wants to do
any interpolation at all, and it just leads to an extra
layer of quoting around all double-quotes and dollar signs
inside the snippet.  Let's switch to single quotes, like
most other test scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3419-rebase-patch-id.sh | 12 ++++++------
 t/t9100-git-svn-basic.sh   | 28 ++++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 217dd79..49f548c 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -73,17 +73,17 @@ do_tests () {
 		run git format-patch --stdout --ignore-if-in-upstream master
 	"
 
-	test_expect_success $pr 'detect upstream patch' "
+	test_expect_success $pr 'detect upstream patch' '
 		git checkout -q master &&
 		scramble file &&
 		git add file &&
-		git commit -q -m 'change big file again' &&
+		git commit -q -m "change big file again" &&
 		git checkout -q other^{} &&
 		git rebase master &&
-		test_must_fail test -n \"\$(git rev-list master...HEAD~)\"
-	"
+		test_must_fail test -n "$(git rev-list master...HEAD~)"
+	'
 
-	test_expect_success $pr 'do not drop patch' "
+	test_expect_success $pr 'do not drop patch' '
 		git branch -f squashed master &&
 		git checkout -q -f squashed &&
 		git reset -q --soft HEAD~2 &&
@@ -91,7 +91,7 @@ do_tests () {
 		git checkout -q other^{} &&
 		test_must_fail git rebase squashed &&
 		rm -rf .git/rebase-apply
-	"
+	'
 }
 
 do_tests 500
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 6ec73ee..28082b1 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -217,11 +217,11 @@ EOF
 
 test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
 
-test_expect_success 'exit if remote refs are ambigious' "
+test_expect_success 'exit if remote refs are ambigious' '
         git config --add svn-remote.svn.fetch \
 		bar:refs/remotes/git-svn &&
 	test_must_fail git svn migrate
-"
+'
 
 test_expect_success 'exit if init-ing a would clobber a URL' '
         svnadmin create "${PWD}/svnrepo2" &&
@@ -259,26 +259,26 @@ test_expect_success 'dcommit $rev does not clobber current branch' '
 	git branch -D my-bar
 	'
 
-test_expect_success 'able to dcommit to a subdirectory' "
+test_expect_success 'able to dcommit to a subdirectory' '
 	git svn fetch -i bar &&
 	git checkout -b my-bar refs/remotes/bar &&
 	echo abc > d &&
 	git update-index --add d &&
-	git commit -m '/bar/d should be in the log' &&
+	git commit -m "/bar/d should be in the log" &&
 	git svn dcommit -i bar &&
-	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\" &&
+	test -z "$(git diff refs/heads/my-bar refs/remotes/bar)" &&
 	mkdir newdir &&
 	echo new > newdir/dir &&
 	git update-index --add newdir/dir &&
-	git commit -m 'add a new directory' &&
+	git commit -m "add a new directory" &&
 	git svn dcommit -i bar &&
-	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\" &&
+	test -z "$(git diff refs/heads/my-bar refs/remotes/bar)" &&
 	echo foo >> newdir/dir &&
 	git update-index newdir/dir &&
-	git commit -m 'modify a file in new directory' &&
+	git commit -m "modify a file in new directory" &&
 	git svn dcommit -i bar &&
-	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\"
-	"
+	test -z "$(git diff refs/heads/my-bar refs/remotes/bar)"
+'
 
 test_expect_success 'dcommit should not fail with a touched file' '
 	test_commit "commit-new-file-foo2" foo2 &&
@@ -291,13 +291,13 @@ test_expect_success 'rebase should not fail with a touched file' '
 	git svn rebase
 '
 
-test_expect_success 'able to set-tree to a subdirectory' "
+test_expect_success 'able to set-tree to a subdirectory' '
 	echo cba > d &&
 	git update-index d &&
-	git commit -m 'update /bar/d' &&
+	git commit -m "update /bar/d" &&
 	git svn set-tree -i bar HEAD &&
-	test -z \"\$(git diff refs/heads/my-bar refs/remotes/bar)\"
-	"
+	test -z "$(git diff refs/heads/my-bar refs/remotes/bar)"
+'
 
 test_expect_success 'git-svn works in a bare repository' '
 	mkdir bare-repo &&
-- 
2.8.2.825.gea31738
