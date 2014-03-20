From: Jeff King <peff@peff.net>
Subject: [PATCH 08/12] t0001: use test_path_is_*
Date: Thu, 20 Mar 2014 19:17:35 -0400
Message-ID: <20140320231735.GH8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:17:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmDW-00034X-EL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760097AbaCTXRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:17:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:43592 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759656AbaCTXRh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:17:37 -0400
Received: (qmail 28007 invoked by uid 102); 20 Mar 2014 23:17:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:17:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:17:35 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244610>

t0001 predates the test_path_is_* helpers, and uses "test
-f" and "test -d" directly. Using the helpers provides
better debugging output, and are a little more robust.
As opposed to "! test -d", test_path_is_missing will
actually makes sure the path does not exist at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0001-init.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5245711..fdcf4b3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -199,13 +199,13 @@ test_expect_success 'init with --template (blank)' '
 		cd template-plain &&
 		git init
 	) &&
-	test -f template-plain/.git/info/exclude &&
+	test_path_is_file template-plain/.git/info/exclude &&
 	(
 		mkdir template-blank &&
 		cd template-blank &&
 		git init --template=
 	) &&
-	! test -f template-blank/.git/info/exclude
+	test_path_is_missing template-blank/.git/info/exclude
 '
 
 test_expect_success 'init with init.templatedir set' '
@@ -263,7 +263,7 @@ test_expect_success 'init creates a new directory' '
 	rm -fr newdir &&
 	(
 		git init newdir &&
-		test -d newdir/.git/refs
+		test_path_is_dir newdir/.git/refs
 	)
 '
 
@@ -271,7 +271,7 @@ test_expect_success 'init creates a new bare directory' '
 	rm -fr newdir &&
 	(
 		git init --bare newdir &&
-		test -d newdir/refs
+		test_path_is_dir newdir/refs
 	)
 '
 
@@ -280,7 +280,7 @@ test_expect_success 'init recreates a directory' '
 	(
 		mkdir newdir &&
 		git init newdir &&
-		test -d newdir/.git/refs
+		test_path_is_dir newdir/.git/refs
 	)
 '
 
@@ -289,14 +289,14 @@ test_expect_success 'init recreates a new bare directory' '
 	(
 		mkdir newdir &&
 		git init --bare newdir &&
-		test -d newdir/refs
+		test_path_is_dir newdir/refs
 	)
 '
 
 test_expect_success 'init creates a new deep directory' '
 	rm -fr newdir &&
 	git init newdir/a/b/c &&
-	test -d newdir/a/b/c/.git/refs
+	test_path_is_dir newdir/a/b/c/.git/refs
 '
 
 test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shared)' '
@@ -306,7 +306,7 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
 		# the repository itself should follow "shared"
 		umask 002 &&
 		git init --bare --shared=0660 newdir/a/b/c &&
-		test -d newdir/a/b/c/refs &&
+		test_path_is_dir newdir/a/b/c/refs &&
 		ls -ld newdir/a newdir/a/b > lsab.out &&
 		! grep -v "^drwxrw[sx]r-x" lsab.out &&
 		ls -ld newdir/a/b/c > lsc.out &&
@@ -319,7 +319,7 @@ test_expect_success 'init notices EEXIST (1)' '
 	(
 		>newdir &&
 		test_must_fail git init newdir &&
-		test -f newdir
+		test_path_is_file newdir
 	)
 '
 
@@ -329,7 +329,7 @@ test_expect_success 'init notices EEXIST (2)' '
 		mkdir newdir &&
 		>newdir/a
 		test_must_fail git init newdir/a/b &&
-		test -f newdir/a
+		test_path_is_file newdir/a
 	)
 '
 
@@ -345,15 +345,15 @@ test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
 test_expect_success 'init creates a new bare directory with global --bare' '
 	rm -rf newdir &&
 	git --bare init newdir &&
-	test -d newdir/refs
+	test_path_is_dir newdir/refs
 '
 
 test_expect_success 'init prefers command line to GIT_DIR' '
 	rm -rf newdir &&
 	mkdir otherdir &&
 	GIT_DIR=otherdir git --bare init newdir &&
-	test -d newdir/refs &&
-	! test -d otherdir/refs
+	test_path_is_dir newdir/refs &&
+	test_path_is_missing otherdir/refs
 '
 
 test_expect_success 'init with separate gitdir' '
@@ -361,7 +361,7 @@ test_expect_success 'init with separate gitdir' '
 	git init --separate-git-dir realgitdir newdir &&
 	echo "gitdir: `pwd`/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
-	test -d realgitdir/refs
+	test_path_is_dir realgitdir/refs
 '
 
 test_expect_success 're-init on .git file' '
@@ -375,8 +375,8 @@ test_expect_success 're-init to update git link' '
 	) &&
 	echo "gitdir: `pwd`/surrealgitdir" >expected &&
 	test_cmp expected newdir/.git &&
-	test -d surrealgitdir/refs &&
-	! test -d realgitdir/refs
+	test_path_is_dir surrealgitdir/refs &&
+	test_path_is_missing realgitdir/refs
 '
 
 test_expect_success 're-init to move gitdir' '
@@ -388,7 +388,7 @@ test_expect_success 're-init to move gitdir' '
 	) &&
 	echo "gitdir: `pwd`/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
-	test -d realgitdir/refs
+	test_path_is_dir realgitdir/refs
 '
 
 test_expect_success SYMLINKS 're-init to move gitdir symlink' '
@@ -403,7 +403,7 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	echo "gitdir: `pwd`/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
 	test_cmp expected newdir/here &&
-	test -d realgitdir/refs
+	test_path_is_dir realgitdir/refs
 '
 
 test_done
-- 
1.9.0.560.g01ceb46
