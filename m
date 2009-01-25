From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add new testcase for git-merge-tree
Date: Sun, 25 Jan 2009 19:03:05 +0100
Message-ID: <1232906585-12250-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR9LX-0002Q4-Sl
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbZAYSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbZAYSDL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:03:11 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:40116 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZAYSDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:03:10 -0500
Received: from vmobile.example.net (dsl4E5C5FD2.pool.t-online.hu [78.92.95.210])
	by yugo.frugalware.org (Postfix) with ESMTPA id 1FEE3446CEB;
	Sun, 25 Jan 2009 19:03:07 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 68EB21C4BC; Sun, 25 Jan 2009 19:03:06 +0100 (CET)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107073>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t6034-merge-tree.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t6034-merge-tree.sh

diff --git a/t/t6034-merge-tree.sh b/t/t6034-merge-tree.sh
new file mode 100755
index 0000000..42bd5e7
--- /dev/null
+++ b/t/t6034-merge-tree.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git merge-tree
+
+Testing merging two trees without touching the index.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	c1=$(git hash-object c1.c)
+	git reset --hard c0 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2
+	c2=$(git hash-object c2.c)
+'
+
+test_expect_success 'merge c1 with c2' '
+	cat <<EOF >expected &&
+added in local
+  our    100644 $c1 c1.c
+added in remote
+  their  100644 $c2 c2.c
+@@ -0,0 +1 @@
++c2
+EOF
+	git merge-tree c0 c1 c2 > actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.6.1
