From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/4] test-suite: adding a test for fast-export with tag variants
Date: Sun, 22 Mar 2009 21:50:17 +0000
Message-ID: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 22:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVaC-0008Cj-Nx
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 22:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbZCVVuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbZCVVuV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:50:21 -0400
Received: from mx.getmail.no ([84.208.15.66]:41961 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756478AbZCVVuT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 17:50:19 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX004A9GNSTME0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:16 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX00MUHGNPLL60@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:16 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.22.213422
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114173>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 t/t9302-fast-export-tags.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 t/t9302-fast-export-tags.sh

diff --git a/t/t9302-fast-export-tags.sh b/t/t9302-fast-export-tags.sh
new file mode 100644
index 0000000..2ecac32
--- /dev/null
+++ b/t/t9302-fast-export-tags.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Erik Faye-Lund
+#
+
+test_description='git fast-export tag variants'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	touch dummy &&
+	git add dummy &&
+	git commit -m "initial commit" &&
+	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
+	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
+	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
+	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
+	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
+'
+
+test_expect_success 'tree_tag'        'git fast-export tree_tag'
+test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
+test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
+test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
+
+test_done
-- 
1.6.2.1.226.gcb2dd
