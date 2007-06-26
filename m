From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] cleanup merge-base test script
Date: Wed, 27 Jun 2007 11:44:22 +1200
Message-ID: <11829014621752-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 01:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Ki0-0005WO-DN
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 01:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbXFZXob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 19:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbXFZXoa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 19:44:30 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49319 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbXFZXoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 19:44:30 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I3Khq-0006VV-Oc; Wed, 27 Jun 2007 11:44:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id AE93FCB9E8; Wed, 27 Jun 2007 11:44:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50988>

Add a picture, and keep the setup and the tests together.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t6010-merge-base.sh |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index b15920b..22e0893 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -34,6 +34,12 @@ doit() {
 	echo $commit
 }
 
+#  E---D---C---B---A
+#  \'-_         \   \
+#   \  `---------G   \
+#    \                \
+#     F----------------H
+
 # Setup...
 E=$(doit 5 E)
 D=$(doit 4 D $E)
@@ -44,6 +50,18 @@ A=$(doit 1 A $B)
 G=$(doit 7 G $B $E)
 H=$(doit 8 H $A $F)
 
+test_expect_success 'compute merge-base (single)' \
+    'MB=$(git-merge-base G H) &&
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
+
+test_expect_success 'compute merge-base (all)' \
+    'MB=$(git-merge-base --all G H) &&
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
+
+test_expect_success 'compute merge-base with show-branch' \
+    'MB=$(git-show-branch --merge-base G H) &&
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
+
 # Setup for second test to demonstrate that relying on timestamps in a
 # distributed SCM to provide a _consistent_ partial ordering of commits
 # leads to insanity.
@@ -82,18 +100,6 @@ PL=$(doit  4 PL $L2 $C2)
 PR=$(doit  4 PR $C2 $R2)
 
 test_expect_success 'compute merge-base (single)' \
-    'MB=$(git-merge-base G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-test_expect_success 'compute merge-base (all)' \
-    'MB=$(git-merge-base --all G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-test_expect_success 'compute merge-base with show-branch' \
-    'MB=$(git-show-branch --merge-base G H) &&
-     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
-
-test_expect_success 'compute merge-base (single)' \
     'MB=$(git-merge-base PL PR) &&
      expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/C2"'
 
-- 
1.5.2.1.1131.g3b90
