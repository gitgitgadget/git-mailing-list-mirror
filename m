From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH v3 1/1] Make sure to set up the default remote branch correctly
Date: Mon, 23 Feb 2009 19:55:23 +0100
Message-ID: <0c1bcfebbad98e6e6f3432d03550f7710186d231.1235415204.git.ferry.huberts@pelagic.nl>
References: <cover.1235415204.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 19:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbfzM-0000iu-2I
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZBWSzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbZBWSzh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:55:37 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:58489 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754756AbZBWSzf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 13:55:35 -0500
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 61FAC58BDBB;
	Mon, 23 Feb 2009 19:55:31 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <cover.1235415204.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1235415204.git.ferry.huberts@pelagic.nl>
References: <cover.1235415204.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111168>

This is to make sure that the plugin sets up a clone
in the same fashion as git-clone.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../org/spearce/egit/core/op/CloneOperation.java   |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
index 777894c..a5b4e50 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
@@ -32,6 +32,7 @@
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.WorkDirCheckout;
 import org.spearce.jgit.transport.FetchResult;
@@ -158,6 +159,17 @@ private void doInit(final IProgressMonitor monitor)
 		local.getConfig().setBoolean("core", null, "bare", false);
 
 		remoteConfig.update(local.getConfig());
+
+		// branch is like 'Constants.R_HEADS + branchName', we need only 
+		// the 'branchName' part
+		String branchName = branch.substring(Constants.R_HEADS.length());
+
+		// setup the default remote branch for branchName
+		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION,
+				branchName, "remote", remoteName);
+		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION,
+				branchName, "merge", branch);
+
 		local.getConfig().save();
 	}
 
-- 
1.6.0.6
