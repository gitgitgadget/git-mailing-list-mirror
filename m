From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Wed, 13 Jun 2007 16:01:53 +0200
Message-ID: <1181743313509-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyTQ7-0007pA-Nv
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbXFMOBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755819AbXFMOBz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:01:55 -0400
Received: from pan.madism.org ([88.191.52.104]:34198 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbXFMOBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:01:54 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 03259D5E1;
	Wed, 13 Jun 2007 16:01:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 398BEC3CA; Wed, 13 Jun 2007 16:01:53 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50059>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/guilt-export.txt |   30 ++++++++++++++++++++++++++++++
 guilt-export                   |   26 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/guilt-export.txt
 create mode 100755 guilt-export

diff --git a/Documentation/guilt-export.txt b/Documentation/guilt-export.txt
new file mode 100644
index 0000000..b7b0a4b
--- /dev/null
+++ b/Documentation/guilt-export.txt
@@ -0,0 +1,30 @@
+guilt-export(1)
+===============
+
+NAME
+----
+guilt-export - Export a patch series (to be used by quilt)
+
+SYNOPSIS
+--------
+include::usage-guilt-export.txt[]
+
+DESCRIPTION
+-----------
+Export a guilt series to be used by quilt.
+
+OPTIONS
+-------
+<target_dir>::
+        Name of the directory to export the patch series to.
+        (defaults to patches).
+
+Author
+------
+Written by Pierre Habouzit <madcoder@debian.org>
+
+Documentation
+-------------
+Documentation by Pierre Habouzit <madcoder@debian.org>
+
+include::footer.txt[]
diff --git a/guilt-export b/guilt-export
new file mode 100755
index 0000000..9ff9924
--- /dev/null
+++ b/guilt-export
@@ -0,0 +1,26 @@
+#!/bin/bash
+#
+# Copyright (c) Pierre Habouzit, 2007
+#
+
+USAGE="[<target_dir>]"
+. guilt
+
+if [ $# -gt 1 ]; then
+	usage
+fi
+target_dir=${1:-"patches"}
+
+if [ -e "$target_dir" ]; then
+	die "Specified directory already exists"
+fi
+
+trap "rm -rf \"$target_dir\"" 0
+mkdir -p "$target_dir"
+
+get_series | tee "$target_dir/series" | while read p; do
+	cp "$GUILT_DIR/$branch/$p" "$target_dir/$p"
+done
+
+trap - 0
+echo "Series exported to \"$target_dir\" sucessfully."
-- 
1.5.2.1
