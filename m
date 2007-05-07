From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 01/10] Fixes due to changes in the Eclipse Team API
Date: Mon, 07 May 2007 23:29:14 +0200
Message-ID: <20070507212913.21546.76860.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAm0-0003n9-2l
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966775AbXEGV3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966777AbXEGV3c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:29:32 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12228 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966776AbXEGV3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:29:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A47EE8028B2;
	Mon,  7 May 2007 23:23:25 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24643-08; Mon,  7 May 2007 23:23:25 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 1BC6A800783;
	Mon,  7 May 2007 23:23:25 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 7AB4A2926D;
	Mon,  7 May 2007 23:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id nrfPUKJD4JgX; Mon,  7 May 2007 23:29:14 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6E3B7294E1;
	Mon,  7 May 2007 23:29:14 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46482>

There were changes made in Eclipse 3.3M7 that
blew our cover. Apparently we were not using the
API:s properly. Hopefully this is somewhat better.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../actions/CompareWithRevisionAction.java         |    5 ++---
 .../actions/ShowResourceInHistoryAction.java       |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithRevisionAction.java
index 9cded79..981c14c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithRevisionAction.java
@@ -22,14 +22,13 @@ import java.util.Hashtable;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.jface.action.IAction;
 import org.eclipse.swt.widgets.Shell;
-import org.eclipse.team.core.TeamException;
 import org.eclipse.team.internal.ui.actions.TeamAction;
 import org.eclipse.team.ui.TeamUI;
 import org.eclipse.team.ui.history.HistoryPageSaveablePart;
 
 public class CompareWithRevisionAction extends TeamAction {
 
-	public void run(IAction action) {
+	public void execute(IAction action) {
 		super.run(action);
 		System.out.println("Run:" + action);
 		System.out.println("Selection resources:"
@@ -45,7 +44,7 @@ public class CompareWithRevisionAction extends TeamAction {
 		HistoryPageSaveablePart.showHistoryInDialog(shell, object);
 	}
 
-	protected boolean isEnabled() throws TeamException {
+	public boolean isEnabled() {
 		return !getSelection().isEmpty();
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ShowResourceInHistoryAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ShowResourceInHistoryAction.java
index db6f3e2..d2f9c47 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ShowResourceInHistoryAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ShowResourceInHistoryAction.java
@@ -18,14 +18,13 @@ package org.spearce.egit.ui.internal.actions;
 
 import org.eclipse.jface.action.IAction;
 import org.eclipse.swt.widgets.Shell;
-import org.eclipse.team.core.TeamException;
 import org.eclipse.team.internal.ui.actions.TeamAction;
 import org.eclipse.team.ui.TeamUI;
 import org.eclipse.team.ui.history.HistoryPageSaveablePart;
 
 public class ShowResourceInHistoryAction extends TeamAction {
 
-	public void run(IAction action) {
+	public void execute(IAction action) {
 		TeamUI.getHistoryView().showHistoryFor(getSelectedResources()[0]);
 	}
 
@@ -33,7 +32,7 @@ public class ShowResourceInHistoryAction extends TeamAction {
 		HistoryPageSaveablePart.showHistoryInDialog(shell, object);
 	}
 
-	protected boolean isEnabled() throws TeamException {
+	public boolean isEnabled() {
 		return !getSelection().isEmpty();
 	}
 }
