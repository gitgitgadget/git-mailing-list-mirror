From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/3] Drop the non-structured compare
Date: Thu, 19 Apr 2007 19:10:37 +0000
Message-ID: <20070419191036.19224.81654.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 19 21:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hebyu-0001MY-7P
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 21:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766941AbXDSTHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766942AbXDSTHX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 15:07:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21289 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1766941AbXDSTHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 15:07:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 16185802884;
	Thu, 19 Apr 2007 21:01:32 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20805-05; Thu, 19 Apr 2007 21:01:31 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A0DA2802873;
	Thu, 19 Apr 2007 21:01:31 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 3194C29211;
	Thu, 19 Apr 2007 21:10:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id NgmBMIRTvcbz; Thu, 19 Apr 2007 19:10:37 +0000 (UTC)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9408B291D5;
	Thu, 19 Apr 2007 21:10:37 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45037>


---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   11 +----------
 .../internal/actions/GitCompareRevisionAction.java |    2 +-
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 3057344..bd80324 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -57,7 +57,6 @@ import org.eclipse.team.core.history.IFileHistory;
 import org.eclipse.team.core.history.IFileHistoryProvider;
 import org.eclipse.team.core.history.IFileRevision;
 import org.eclipse.team.internal.ui.TeamUIMessages;
-import org.eclipse.team.internal.ui.actions.CompareRevisionAction;
 import org.eclipse.team.internal.ui.history.DialogHistoryPageSite;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
@@ -103,10 +102,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		if (parentSite != null && parentSite instanceof DialogHistoryPageSite)
 			parentSite.setSelectionProvider(viewer);
 
-		final CompareRevisionAction compareAction = new CompareRevisionAction(
+		final GitCompareRevisionAction compareAction = new GitCompareRevisionAction(
 				"Compare");
-		final GitCompareRevisionAction compareActionNG = new GitCompareRevisionAction(
-				"Compare NG");
 		tree.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
@@ -119,20 +116,14 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				compareAction.setCurrentFileRevision(fileRevisions[0]);
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
-
-				compareActionNG.setCurrentFileRevision(fileRevisions[0]);
-				compareActionNG.selectionChanged(new StructuredSelection(
-						selection2));
 			}
 		});
 		compareAction.setPage(this);
-		compareActionNG.setPage(this);
 		MenuManager menuMgr = new MenuManager();
 		Menu menu = menuMgr.createContextMenu(tree);
 		menuMgr.addMenuListener(new IMenuListener() {
 			public void menuAboutToShow(IMenuManager menuMgr) {
 				menuMgr.add(compareAction);
-				menuMgr.add(compareActionNG);
 			}
 		});
 		menuMgr.setRemoveAllWhenShown(true);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
index 9a0b378..9487197 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
@@ -188,7 +188,7 @@ public class GitCompareRevisionAction extends BaseSelectionListenerAction {
 			return shouldShow();
 		}
 		else if (selection.size() == 2){
-			this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther+" NG");
+			this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther);
 			return shouldShow();
 		}
 
