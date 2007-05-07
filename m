From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 02/10] Recursion and update of all elements regardless of
	need.
Date: Mon, 07 May 2007 23:29:20 +0200
Message-ID: <20070507212919.21546.75269.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmF-0003qz-EC
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966777AbXEGV3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966789AbXEGV3p
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:29:45 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12237 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966777AbXEGV3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:29:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5E115802676;
	Mon,  7 May 2007 23:23:38 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24594-10; Mon,  7 May 2007 23:23:38 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id F2AEC800783;
	Mon,  7 May 2007 23:23:37 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 96A1E294E7;
	Mon,  7 May 2007 23:29:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id mGDJ+9VrLZsF; Mon,  7 May 2007 23:29:29 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E03C9294E8;
	Mon,  7 May 2007 23:29:20 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46484>

When selecting an element in the history view viewer.updateElement
is called for every element recursively. If the number of
elements is very largs this results in a stack overflow. This
only happens with Eclipse 3.3 M7 and not M6.

Is it thig bug? https://bugs.eclipse.org/bugs/show_bug.cgi?id=149642

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 7bc947b..8be23ec 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -281,6 +281,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		viewer = new TreeViewer(tree, SWT.VIRTUAL | SWT.FULL_SELECTION);
 
+		viewer.setUseHashlookup(true);
+
 		createColumns();
 
 		viewer.setLabelProvider(new GitHistoryLabelProvider());
@@ -354,6 +356,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 
 		public void updateElement(Object parent, int index) {
+			System.out.println("updateElement("+parent+","+index);
 			viewer.replace(parent, index, fileRevisions[index]);
 		}
 	}
