From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 06/10] Allow history listing on folders and projects.
Date: Sun, 11 Mar 2007 19:15:48 +0100
Message-ID: <20070311181547.18012.12531.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYo-0006Mj-Uj
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945AbXCKSOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933947AbXCKSON
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:13 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1628 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933945AbXCKSOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2BA58802E25;
	Sun, 11 Mar 2007 19:08:57 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26264-03; Sun, 11 Mar 2007 19:08:56 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 7AFCE802841;
	Sun, 11 Mar 2007 19:08:56 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9D3F2291DB;
	Sun, 11 Mar 2007 19:16:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id bLe3RBfBlCpW; Sun, 11 Mar 2007 19:15:58 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 06712291D6;
	Sun, 11 Mar 2007 19:15:48 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41957>

Comparing two commits is disabled on a none-file resource until
we implement the structured compare interfaces.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 org.spearce.egit.core/META-INF/MANIFEST.MF         |    3 ++-
 .../egit/core/internal/mapping/GitFileHistory.java |    2 +-
 org.spearce.egit.ui/plugin.xml                     |   21 ++++++++++++--------
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    3 +++
 .../org/spearce/egit/ui/GitHistoryPageSource.java  |    5 ++++-
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index a8349a1..13ec59d 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -11,6 +11,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.core.resources,
  org.spearce.jgit,
  org.eclipse.core.filesystem
-Export-Package: org.spearce.egit.core.op,
+Export-Package: org.spearce.egit.core.internal.mapping;x-friends:="org.spearce.egit.ui",
+ org.spearce.egit.core.op,
  org.spearce.egit.core.project
 Eclipse-LazyStart: true
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 6c40bb0..2e4e4e9 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -158,7 +158,7 @@ public class GitFileHistory extends FileHistory {
 				}
 			}
 			
-			if (!currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1]))
+			if (currentResourceHash.length == 0 || !currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1]))
 				ret.add(new GitFileRevision(previous, resource));
 
 			lastResourceHash = currentResourceHash;
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index d373d18..d81a0b6 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -50,7 +50,19 @@
                tooltip="%TrackAction_tooltip"
                menubarPath="team.main/group1"
                id="org.spearce.egit.ui.internal.actions.Track"/>
- 	 </objectContribution>
+         <action
+               class="org.spearce.egit.ui.internal.actions.ShowResourceInHistoryAction"
+               id="org.spearce.egit.ui.internal.actions.ShowResourceInHistoryAction"
+               label="%ShowResourceInHistoryAction_label"
+               menubarPath="team.main/group1"
+               tooltip="%ShowResourceInHistoryAction_tooltip"/>
+		<action
+		       class="org.spearce.egit.ui.internal.actions.GitCompareRevisionAction"
+        	   id="org.spearce.egit.ui.internal.actions.GitCompareAction"
+               menubarPath="team.main/group1"
+        	   label="Structured Git Compare">
+		</action>
+ 	  </objectContribution>
       <objectContribution
             objectClass="org.eclipse.core.resources.IFile"
             adaptable="true"
@@ -68,13 +80,6 @@
                overrideActionId="org.eclipse.team.ui.compareLocalHistory"
                tooltip="%CompareWithRevisionAction_tooltip">
          </action>
-         <action
-               class="org.spearce.egit.ui.internal.actions.ShowResourceInHistoryAction"
-               enablesFor="1"
-               id="org.spearce.egit.ui.internal.actions.ShowResourceInHistoryAction"
-               label="%ShowResourceInHistoryAction_label"
-               menubarPath="team.main/group1"
-               tooltip="%ShowResourceInHistoryAction_tooltip"/>
       </objectContribution>
    </extension>
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 0e53036..cd31f18 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -62,6 +62,7 @@ import org.eclipse.team.internal.ui.history.DialogHistoryPageSite;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
+import org.spearce.egit.core.internal.mapping.GitFileRevision;
 
 public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		IHistoryCompareAdapter {
@@ -115,6 +116,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				compareAction.setCurrentFileRevision(fileRevisions[0]);
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
+				
+				compareAction.setEnabled(selection!=null && selection[0]!=null  && ((GitFileRevision)fileRevisions[0]).getResource().getType() == IResource.FILE);
 			}
 		});
 		compareAction.setPage(this);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPageSource.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPageSource.java
index 03c1896..2d56063 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPageSource.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPageSource.java
@@ -27,7 +27,10 @@ public class GitHistoryPageSource extends HistoryPageSource {
 	}
 
 	public boolean canShowHistoryFor(Object object) {
-		return (object instanceof IResource && ((IResource) object).getType() == IResource.FILE);
+		return (object instanceof IResource 
+				&& (((IResource) object).getType() == IResource.FILE
+						|| ((IResource) object).getType() == IResource.FOLDER
+						|| ((IResource) object).getType() == IResource.PROJECT));
 	}
 
 }
