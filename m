From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 19:41:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 19:41:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5nNh-00062x-AW
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWGZRlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWGZRlI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:41:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:53733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030354AbWGZRlG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 13:41:06 -0400
Received: (qmail invoked by alias); 26 Jul 2006 17:41:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 26 Jul 2006 19:41:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24226>


If dir2 already exists, git-mv should move dir1 _into_dir2/.
Noticed by Jon Smirl.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Jon, this was your problem, right?

 t/t7001-mv.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d78c56a..322eaad 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -59,4 +59,19 @@ test_expect_success \
      git-diff-tree -r -M --name-status  HEAD^ HEAD | \
      grep -E "^R100.+path0/README.+path2/README"'
 
+test_expect_success \
+    'moving whole subdirectory into subdirectory' \
+    'git-mv path2 path1'
+
+test_expect_success \
+    'commiting the change' \
+    'git-commit -m dir-move -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
+     grep -E "^R100.+path2/COPYING.+path1/path2/COPYING" &&
+     git-diff-tree -r -M --name-status  HEAD^ HEAD | \
+     grep -E "^R100.+path2/README.+path1/path2/README"'
+
 test_done
-- 
1.4.2.rc2.g96f2-dirty
