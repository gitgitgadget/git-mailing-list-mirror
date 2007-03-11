From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 01/10] Git history refresh problem
Date: Sun, 11 Mar 2007 19:15:21 +0100
Message-ID: <20070311181521.18012.76975.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYC-00066B-I9
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933937AbXCKSNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933941AbXCKSNk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:13:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1589 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933937AbXCKSNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:13:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 59B13802E25;
	Sun, 11 Mar 2007 19:08:24 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26000-09; Sun, 11 Mar 2007 19:08:23 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E0D9D802841;
	Sun, 11 Mar 2007 19:08:22 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id CDF7C28D45;
	Sun, 11 Mar 2007 19:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 0QN-L5R375UX; Sun, 11 Mar 2007 19:15:21 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 84AA428D5B;
	Sun, 11 Mar 2007 19:15:21 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41950>

It seems the history window often lags one event behind.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 2a5fa98..d1591f0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -242,9 +242,13 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					.getFileHistoryFor((IResource) getInput(),
 							IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, null/* monitor */);
 			fileRevisions = fileHistoryFor.getFileRevisions();
-			tree.setData(fileRevisions);
+			tree.clearAll(true);
 			tree.setItemCount(fileRevisions.length);
+			tree.setData(fileRevisions);
+			System.out.println("inputchanged, invoking refresh");
 			viewer.refresh();
+			tree.getParent().layout();
+			tree.getParent().getParent().layout();
 		}
 
 		public void dispose() {
