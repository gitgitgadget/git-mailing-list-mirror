From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: add example to move everything into a
 subdirectory
Date: Thu, 21 Jun 2007 18:05:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211805010.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 21 19:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Q6L-0006QH-Ve
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 19:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbXFURFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbXFURFf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 13:05:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:40481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755531AbXFURFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 13:05:34 -0400
Received: (qmail invoked by alias); 21 Jun 2007 17:05:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 21 Jun 2007 19:05:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RTwdcIMvR85Bg84GgnfUHw+K4+gGbHT5fcIZ9QB
	aMRqeecEQCSiMy
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50645>


This is based on Jeff King's example in

	20070621130137.GB4487@coredump.intra.peff.net

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh     |    8 ++++++++
 t/t7003-filter-branch.sh |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ffb31d6..297e09e 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -181,6 +181,14 @@
 #
 #	git-filter-branch ... new-H C..H --not D
 #	git-filter-branch ... new-H D..H --not C
+#
+# To move the whole tree into a subdirectory, or remove it from there:
+#
+# git-filter-branch --index-filter \
+#	'git-ls-files -s | sed "s-\t-&newsubdir/-" |
+#		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
+#			git-update-index --index-info &&
+#	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' directorymoved
 
 # Testsuite: TODO
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 0fabe49..f00c262 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -99,4 +99,12 @@ test_expect_success 'subdirectory filter result looks okay' '
 	! git show sub:subdir
 '
 
+test_expect_success 'use index-filter to move into a subdirectory' '
+	git-filter-branch --index-filter \
+		 "git-ls-files -s | sed \"s-\\t-&newsubdir/-\" |
+	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+			git-update-index --index-info &&
+		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
+	test -z "$(git diff HEAD directorymoved:newsubdir)"'
+
 test_done
-- 
1.5.2.2.2822.g027a6-dirty
