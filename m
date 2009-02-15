From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/8] Test that diff can read from stdin
Date: Sun, 15 Feb 2009 23:25:39 +0100
Message-ID: <f5c76146f2c038dcc4f05f0e825b802f5b55fb1a.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSt-0004VH-PH
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZBOW0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbZBOW0B
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:01 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbZBOWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:25:58 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:54.0053 (UTC) FILETIME=[5D689B50:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110072>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Not the best possible place to put this, but t4013-diff-various.sh
doesn't let me do input redirections in its framework.

 t/t4002-diff-basic.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index cc3681f..18695ce 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -258,4 +258,12 @@ test_expect_success \
     git diff-tree -r -R $tree_A $tree_B >.test-b &&
     cmp -s .test-a .test-b'
 
+test_expect_success \
+    'diff can read from stdin' \
+    'test_must_fail git diff --no-index -- MN - < NN |
+        grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
+    test_must_fail git diff --no-index -- MN NN |
+        grep -v "^index" >.test-b &&
+    test_cmp .test-a .test-b'
+
 test_done
-- 
1.6.2.rc0.335.g1a2b
