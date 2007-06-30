From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-merge-ff: fast-forward only merge
Date: Sat, 30 Jun 2007 20:56:18 +1200
Message-ID: <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlN-0006AV-Lx
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbXF3I4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXF3I4m
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:42 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56646 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008U7-HC; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 7DACB5CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51206>

This is primarily so that there is an easy switch to 'git-pull' to
be sure to fast forward only.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/merge-strategies.txt |    5 +++++
 Makefile                           |    2 +-
 git-merge-ff.sh                    |    8 ++++++++
 git-merge.sh                       |    4 ++--
 4 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 git-merge-ff.sh

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 7df0266..00739bc 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -33,3 +33,8 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
+
+ff::
+	This is a degenerate merge strategy that always fails, which
+	means that the only time the target branch will change is if
+	there was no merge ("fast-forward" merge only).
diff --git a/Makefile b/Makefile
index 4ea5e45..7fa8fe3 100644
--- a/Makefile
+++ b/Makefile
@@ -210,7 +210,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-merge-ours.sh \
+	git-merge-resolve.sh git-merge-ours.sh git-merge-ff.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh
 
diff --git a/git-merge-ff.sh b/git-merge-ff.sh
new file mode 100644
index 0000000..b0e0f85
--- /dev/null
+++ b/git-merge-ff.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Sam Vilain
+#
+# A degenerate merge strategy that only allows fast-forwarding.
+#
+
+exit 1;
diff --git a/git-merge.sh b/git-merge.sh
index 981d69d..63aa374 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -16,10 +16,10 @@ test -z "$(git ls-files -u)" ||
 LF='
 '
 
-all_strategies='recur recursive octopus resolve stupid ours subtree'
+all_strategies='recur recursive octopus resolve stupid ours subtree ff'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
-no_trivial_merge_strategies='ours subtree'
+no_trivial_merge_strategies='ours subtree ff'
 use_strategies=
 
 index_merge=t
-- 
1.5.2.1.1131.g3b90
