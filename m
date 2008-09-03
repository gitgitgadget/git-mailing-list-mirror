From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/4] Switch usage of AnyObjectId.toString() to new AnyObjectId.name() in Eclipse plugin
Date: Wed,  3 Sep 2008 23:28:13 +0200
Message-ID: <1220477294-23268-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080903170438.GA28315@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0Sq-0003b4-Qh
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYICWD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYICWD3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:03:29 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:41120 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYICWD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:03:28 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 96C7E37FB2; Wed,  3 Sep 2008 23:30:46 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 5EB5037E69; Wed,  3 Sep 2008 23:30:46 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 23D3A37E4C;
	Wed,  3 Sep 2008 23:30:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.161.g7f314
In-Reply-To: <20080903170438.GA28315@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94862>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../core/internal/storage/CommitFileRevision.java  |    2 +-
 .../actions/HardResetToRevisionAction.java         |    6 ++++--
 .../actions/MixedResetToRevisionAction.java        |    6 ++++--
 .../actions/SetQuickdiffBaselineAction.java        |    2 +-
 .../actions/SoftResetToRevisionAction.java         |    6 ++++--
 .../egit/ui/internal/components/RefSpecPanel.java  |    2 +-
 .../egit/ui/internal/history/CommitGraphTable.java |    2 +-
 .../ui/internal/history/CommitMessageViewer.java   |    4 ++--
 .../ui/internal/history/FindToolbarThread.java     |    2 +-
 9 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/CommitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/CommitFileRevision.java
index 58d4801..e364027 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/CommitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/CommitFileRevision.java
@@ -76,7 +76,7 @@ public long getTimestamp() {
 	}
 
 	public String getContentIdentifier() {
-		return commit.getId().toString();
+		return commit.getId().name();
 	}
 
 	public String getAuthor() {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
index 78fd87f..f787e38 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/HardResetToRevisionAction.java
@@ -12,6 +12,7 @@
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.jface.action.IAction;
 import org.spearce.egit.core.op.ResetOperation;
+import org.spearce.jgit.lib.AnyObjectId;
 
 /**
  * Hard reset to selected revision
@@ -20,7 +21,8 @@
 
 	@Override
 	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
-		return new ResetOperation(getActiveRepository(), selection.get(0)
-				.toString(), ResetOperation.ResetType.HARD);
+		return new ResetOperation(getActiveRepository(),
+				((AnyObjectId) selection.get(0)).name(),
+				ResetOperation.ResetType.HARD);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
index 6e4a9bf..9d8bde0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/MixedResetToRevisionAction.java
@@ -12,6 +12,7 @@
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.jface.action.IAction;
 import org.spearce.egit.core.op.ResetOperation;
+import org.spearce.jgit.lib.AnyObjectId;
 
 /**
  * Mixed reset to selected revision
@@ -20,7 +21,8 @@
 
 	@Override
 	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
-		return new ResetOperation(getActiveRepository(), selection.get(0)
-				.toString(), ResetOperation.ResetType.MIXED);
+		return new ResetOperation(getActiveRepository(),
+				((AnyObjectId) selection.get(0)).name(),
+				ResetOperation.ResetType.MIXED);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
index 05686cf..b5ac2b8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
@@ -20,7 +20,7 @@
 
 	@Override
 	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
-		return new QuickdiffBaselineOperation(getActiveRepository(), ((RevObject)selection.get(0)).getId().toString());
+		return new QuickdiffBaselineOperation(getActiveRepository(), ((RevObject)selection.get(0)).getId().name());
 	}
 
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
index 7abbc92..7d7ff7a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SoftResetToRevisionAction.java
@@ -12,6 +12,7 @@
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.jface.action.IAction;
 import org.spearce.egit.core.op.ResetOperation;
+import org.spearce.jgit.lib.AnyObjectId;
 
 /**
  * Soft reset to selected revision
@@ -20,7 +21,8 @@
 
 	@Override
 	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
-		return new ResetOperation(getActiveRepository(), selection.get(0)
-				.toString(), ResetOperation.ResetType.SOFT);
+		return new ResetOperation(getActiveRepository(),
+				((AnyObjectId) selection.get(0)).name(),
+				ResetOperation.ResetType.SOFT);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
index a2661ae..a5a9529 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -1095,7 +1095,7 @@ protected Object getValue(final Object element) {
 			@Override
 			protected void setValue(final Object element, final Object value) {
 				if (value == null || ((String) value).length() == 0
-						|| ObjectId.zeroId().toString().equals(value)) {
+						|| ObjectId.zeroId().name().equals(value)) {
 					// Ignore empty strings or null objects - do not set them in
 					// model.User won't loose any information if we just fall
 					// back to the old value.
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index 478f0b5..a28e3c4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -146,7 +146,7 @@ void doCopy() {
 			final PlotCommit d = itr.next();
 			if (r.length() > 0)
 				r.append("\n");
-			r.append(d.getId().toString());
+			r.append(d.getId().name());
 		}
 
 		clipboard.setContents(new Object[] { r.toString() },
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
index 108aca9..76d57bd 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
@@ -130,7 +130,7 @@ private void format() {
 		final ArrayList<StyleRange> styles = new ArrayList<StyleRange>();
 
 		d.append("commit ");
-		d.append(commit.getId());
+		d.append(commit.getId().name());
 		d.append("\n");
 
 		if (author != null) {
@@ -221,7 +221,7 @@ private void addLink(final StringBuilder d,
 		sr.foreground = sys_linkColor;
 		sr.underline = true;
 		sr.start = d.length();
-		d.append(to.getId().toString());
+		d.append(to.getId().name());
 		sr.length = d.length() - sr.start;
 		styles.add(sr);
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
index 2b76da0..60eaf72 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
@@ -115,7 +115,7 @@ public void run() {
 				SWTCommit revision = fileRevisions[i];
 
 				if (findInCommitId) {
-					String contentId = revision.getId().toString();
+					String contentId = revision.getId().name();
 					if (contentId != null) {
 						if (ignoreCase) {
 							contentId = contentId.toLowerCase();
-- 
1.6.0.1.161.g7f314
