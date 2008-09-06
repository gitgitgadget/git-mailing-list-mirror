From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Add an action to set quickdiff baseline to first parent of HEAD
Date: Sat,  6 Sep 2008 17:48:22 +0200
Message-ID: <1220716102-25837-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Sep 06 18:21:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc0X3-0003Q0-6z
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 18:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbYIFQT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 12:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYIFQT5
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 12:19:57 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:42527 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYIFQT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 12:19:56 -0400
X-Greylist: delayed 1725 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2008 12:19:56 EDT
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 58B4F3802A; Sat,  6 Sep 2008 17:51:09 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 366AB37E72; Sat,  6 Sep 2008 17:51:09 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id AA85E37E42;
	Sat,  6 Sep 2008 17:51:08 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.161.g7f314
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95078>

This is useful when reviewing code.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml                     |    7 +++++
 .../actions/ResetQuickdiffBaselineAction.java      |    2 +-
 .../ResetQuickdiffBaselineHeadParentAction.java    |   24 ++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineHeadParentAction.java

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 55207eb..2472c9b 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -150,6 +150,13 @@
 	       label="Reset quickdiff baseline to HEAD"
 	       menubarPath="additions">
 	 </action>
+	 <action
+	       class="org.spearce.egit.ui.internal.actions.ResetQuickdiffBaselineHeadParentAction"
+	       enablesFor="*"
+	       id="org.spearce.egit.ui.resetquickdiffheadparentbaseline"
+	       label="Reset quickdiff baseline to first parent of HEAD"
+	       menubarPath="additions">
+	 </action>
 	  </objectContribution>
    </extension>
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
index a42635a..597ee10 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
@@ -13,7 +13,7 @@
 import org.eclipse.jface.action.IAction;
 
 /**
- * Changes the reference for the quickdiff
+ * Changes the reference for the quickdiff to HEAD
  */
 public class ResetQuickdiffBaselineAction extends AbstractRevObjectAction {
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineHeadParentAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineHeadParentAction.java
new file mode 100644
index 0000000..85a9998
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineHeadParentAction.java
@@ -0,0 +1,24 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.util.List;
+
+import org.eclipse.core.resources.IWorkspaceRunnable;
+import org.eclipse.jface.action.IAction;
+
+/**
+ * Changes the reference for the quickdiff to the (first) parent of HEAD
+ */
+public class ResetQuickdiffBaselineHeadParentAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new QuickdiffBaselineOperation(getActiveRepository(), "HEAD^1");
+	}
+}
-- 
1.6.0.1.161.g7f314
