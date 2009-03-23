From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/4] test-suite: adding a test for fast-export with tag variants
Date: Mon, 23 Mar 2009 12:53:06 +0000
Message-ID: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 13:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lljft-0006Lx-1k
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbZCWMxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755304AbZCWMxH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:53:07 -0400
Received: from mx.getmail.no ([84.208.15.66]:36785 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751913AbZCWMxG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 08:53:06 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY002KTMGDX1B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:01 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY00AGTMGCW510@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.23.123715
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114295>

The first two new tests are crashing, so I'm adding them commented out as they
exit with unpredictable return-codes.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 t/t9301-fast-export.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 86c3760..db4b0b3 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -28,7 +28,12 @@ test_expect_success 'setup' '
 	git commit -m sitzt file2 &&
 	test_tick &&
 	git tag -a -m valentin muss &&
-	git merge -s ours master
+	git merge -s ours master &&
+	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
+	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
+	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
+	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
+	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
 
 '
 
@@ -259,4 +264,11 @@ test_expect_success 'cope with tagger-less tags' '
 
 '
 
+# NEEDSWORK: not just check return status, but validate the output
+# two tests commented out due to crash and thus unreliable return code
+#test_expect_success 'tree_tag'        'git fast-export tree_tag'
+#test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
+test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
+
 test_done
-- 
1.6.2.1.225.g9a4a0.dirty
