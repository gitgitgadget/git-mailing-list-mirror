From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] test-lib: factor out $GIT_UNZIP setup
Date: Sun, 10 Mar 2013 21:31:47 -0400
Message-ID: <20130311013147.GA11778@sigill.intra.peff.net>
References: <20130311013123.GA11692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 02:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UErb6-0008Cb-P3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 02:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab3CKBbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 21:31:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45563 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab3CKBbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 21:31:50 -0400
Received: (qmail 9594 invoked by uid 107); 11 Mar 2013 01:33:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Mar 2013 21:33:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2013 21:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20130311013123.GA11692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217846>

We set up the $GIT_UNZIP variable and lazy prereq in
multiple places (and the next patch is about to add another
one). Let's factor it out to avoid repeating ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0024-crlf-archive.sh | 6 ------
 t/t5003-archive-zip.sh  | 6 ------
 t/test-lib.sh           | 6 ++++++
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 5378787..4e9fa3c 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -3,12 +3,6 @@ test_description='respect crlf in git archive'
 test_description='respect crlf in git archive'
 
 . ./test-lib.sh
-GIT_UNZIP=${GIT_UNZIP:-unzip}
-
-test_lazy_prereq UNZIP '
-	"$GIT_UNZIP" -v
-	test $? -ne 127
-'
 
 test_expect_success setup '
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 7cfe9ca..0f5b42b 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -3,15 +3,9 @@ SUBSTFORMAT=%H%n
 test_description='git archive --format=zip test'
 
 . ./test-lib.sh
-GIT_UNZIP=${GIT_UNZIP:-unzip}
 
 SUBSTFORMAT=%H%n
 
-test_lazy_prereq UNZIP '
-	"$GIT_UNZIP" -v
-	test $? -ne 127
-'
-
 test_lazy_prereq UNZIP_SYMLINKS '
 	(
 		mkdir unzip-symlinks &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e7f6b4..1f51025 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -760,3 +760,9 @@ test -w / || test_set_prereq SANITY
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
+
+GIT_UNZIP=${GIT_UNZIP:-unzip}
+test_lazy_prereq UNZIP '
+	"$GIT_UNZIP" -v
+	test $? -ne 127
+'
-- 
1.8.2.rc3.4.gc6ed371
