From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/4] test-suite: adding a test for fast-export with tag variants
Date: Mon, 30 Mar 2009 11:08:54 +0200
Message-ID: <1238404137-6693-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDVt-0001sG-Mc
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777AbZC3JJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbZC3JJE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:09:04 -0400
Received: from mx.getmail.no ([84.208.15.66]:35517 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754111AbZC3JJB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:09:01 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB00J5UAQZJ440@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:08:59 +0200 (MEST)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB000Q8AQYPG60@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:08:59 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.30.84610
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115114>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 t/t9301-fast-export.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index b860626..763dde5 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -262,4 +262,21 @@ test_expect_success 'cope with tagger-less tags' '
 
 '
 
+test_expect_success 'set-up a few more tags for tag export tests' '
+
+	git checkout -f master &&
+	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
+	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
+	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
+	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
+	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
+
+'
+
+# NEEDSWORK: not just check return status, but validate the output
+test_expect_failure 'tree_tag'        'git fast-export tree_tag'
+test_expect_failure 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
+test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
+
 test_done
-- 
1.6.2.1
