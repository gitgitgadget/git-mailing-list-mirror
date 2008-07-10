From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/6] Add actions in history view to perform reset actions
Date: Fri, 11 Jul 2008 00:39:33 +0200
Message-ID: <1215729573-26536-7-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-4-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-5-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-6-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tm-0003md-ML
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYGJWoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbYGJWoy
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:54 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13094 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbYGJWoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 13C11827593;
	Fri, 11 Jul 2008 00:44:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BarLwe3brxL; Fri, 11 Jul 2008 00:44:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 100FA8027F7;
	Fri, 11 Jul 2008 00:44:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88028>

Soft, mixed and hard reset supported

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml                     |   43 +++++++++++---------
 .../actions/HardResetToRevisionAction.java         |   26 ++++++++++++
 .../actions/MixedResetToRevisionAction.java        |   26 ++++++++++++
 .../actions/SoftResetToRevisionAction.java         |   26 ++++++++++++
 4 files changed, 102 insertions(+), 19 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 924c6e5..cfd4b80 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -97,29 +97,34 @@
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
 	  </objectContribution>
-      <objectContribution
-            id="org.spearce.egit.ui.revobjectContributions"
-            adaptable="true"
-            objectClass="org.spearce.jgit.revwalk.RevObject">
+	  <objectContribution
+         id="org.spearce.egit.ui.resetto"
+         objectClass="org.spearce.jgit.revwalk.RevCommit">
          <action
-               class="org.spearce.egit.ui.internal.actions.BranchAction"
-               id="org.spearce.egit.ui.action1"
-               label="Kolla"
-               enablesFor="*"
-               menubarPath="additions">
+               class="org.spearce.egit.ui.internal.actions.SoftResetToRevisionAction"
+               id="org.spearce.egit.ui.softresettorevision"
+               label="Soft Reset"
+               menubarPath="additions"
+               enablesFor="1"
+               tooltip="Resets HEAD but not working directory nor index">
          </action>
-      </objectContribution>
-      <viewerContribution
-            id="org.spearce.egit.ui.viewerContribution1"
-            targetID="org.spearce.egit.ui.historyPageContributions">
          <action
-               class="org.spearce.egit.ui.internal.actions.ResetAction"
-               id="org.spearce.egit.ui.action1"
-               label="Titta"
-               enablesFor="*"
-               menubarPath="additions">
+               class="org.spearce.egit.ui.internal.actions.MixedResetToRevisionAction"
+               id="org.spearce.egit.ui.mixedresettorevision"
+               label="Mixed Reset"
+               menubarPath="additions"
+               enablesFor="1"
+               tooltip="Resets HEAD and index, but not working directory">
          </action>
-      </viewerContribution>
+         <action
+               class="org.spearce.egit.ui.internal.actions.HardResetToRevisionAction"
+               id="org.spearce.egit.ui.hardresettorevision"
+               label="Hard Reset"
+               menubarPath="additions"
+               enablesFor="1"
+               tooltip="Resets HEAD and index, and working directory (changed in tracked files will be lost)">
+         </action>
+	  </objectContribution>
    </extension>
 
    <extension
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
new file mode 100644
index 0000000..78fd87f
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
@@ -0,0 +1,26 @@
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
+import org.spearce.egit.core.op.ResetOperation;
+
+/**
+ * Hard reset to selected revision
+ */
+public class HardResetToRevisionAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new ResetOperation(getActiveRepository(), selection.get(0)
+				.toString(), ResetOperation.ResetType.HARD);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
new file mode 100644
index 0000000..6e4a9bf
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
@@ -0,0 +1,26 @@
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
+import org.spearce.egit.core.op.ResetOperation;
+
+/**
+ * Mixed reset to selected revision
+ */
+public class MixedResetToRevisionAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new ResetOperation(getActiveRepository(), selection.get(0)
+				.toString(), ResetOperation.ResetType.MIXED);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
new file mode 100644
index 0000000..7abbc92
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
@@ -0,0 +1,26 @@
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
+import org.spearce.egit.core.op.ResetOperation;
+
+/**
+ * Soft reset to selected revision
+ */
+public class SoftResetToRevisionAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new ResetOperation(getActiveRepository(), selection.get(0)
+				.toString(), ResetOperation.ResetType.SOFT);
+	}
+}
-- 
1.5.6.2.220.g44701
