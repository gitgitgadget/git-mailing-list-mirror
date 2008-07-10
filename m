From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/6] Using the page site selection turned out to be cumbersome.
Date: Fri, 11 Jul 2008 00:39:29 +0200
Message-ID: <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tj-0003md-Es
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYGJWoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYGJWom
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13070 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbYGJWom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D45DD802846;
	Fri, 11 Jul 2008 00:44:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hG6ZMRFRXpq; Fri, 11 Jul 2008 00:44:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 13E688030BA;
	Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88026>

So we use the view site instead. I'm not sure that is the proper
way though.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml                     |   23 ++++++++++++++++++++
 .../egit/ui/internal/history/GitHistoryPage.java   |    3 +-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 611829a..924c6e5 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -97,6 +97,29 @@
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
 	  </objectContribution>
+      <objectContribution
+            id="org.spearce.egit.ui.revobjectContributions"
+            adaptable="true"
+            objectClass="org.spearce.jgit.revwalk.RevObject">
+         <action
+               class="org.spearce.egit.ui.internal.actions.BranchAction"
+               id="org.spearce.egit.ui.action1"
+               label="Kolla"
+               enablesFor="*"
+               menubarPath="additions">
+         </action>
+      </objectContribution>
+      <viewerContribution
+            id="org.spearce.egit.ui.viewerContribution1"
+            targetID="org.spearce.egit.ui.historyPageContributions">
+         <action
+               class="org.spearce.egit.ui.internal.actions.ResetAction"
+               id="org.spearce.egit.ui.action1"
+               label="Titta"
+               enablesFor="*"
+               menubarPath="additions">
+         </action>
+      </viewerContribution>
    </extension>
 
    <extension
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 6eaa6e4..d8777ef 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -235,7 +235,8 @@ public class GitHistoryPage extends HistoryPage {
 		popupMgr.add(new Separator(IWorkbenchActionConstants.MB_ADDITIONS));
 		getSite().registerContextMenu(POPUP_ID, popupMgr,
 				revObjectSelectionProvider);
-		getSite().setSelectionProvider(revObjectSelectionProvider);
+		getHistoryPageSite().getPart().getSite().setSelectionProvider(
+				revObjectSelectionProvider);
 	}
 
 	private void attachContextMenu(final Control c) {
-- 
1.5.6.2.220.g44701
