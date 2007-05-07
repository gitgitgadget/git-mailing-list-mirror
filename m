From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 04/10] Bug: Do not crash when showing diff for first
	version of a file
Date: Mon, 07 May 2007 23:29:34 +0200
Message-ID: <20070507212933.21546.44917.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmW-0003vQ-TV
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966797AbXEGVaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966608AbXEGVaF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12247 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966797AbXEGVaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 526FC802676;
	Mon,  7 May 2007 23:23:55 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24816-01; Mon,  7 May 2007 23:23:55 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id E9315800783;
	Mon,  7 May 2007 23:23:54 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 82CA4294E9;
	Mon,  7 May 2007 23:30:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id UUXYx3prHiEk; Mon,  7 May 2007 23:29:45 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1784F2926D;
	Mon,  7 May 2007 23:29:34 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46486>

We crashed because the right side did not contain any information

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../spearce/egit/ui/internal/GitResourceNode.java  |   28 ++++++++++++++---------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
index bdf8902..010b738 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
@@ -70,7 +70,10 @@ public class GitResourceNode extends BufferedContent implements IStructureCompar
 	}
 
 	public String getName() {
-		return entry.getFullName();
+		if (entry != null)
+			return entry.getFullName();
+		else
+			return "<none>";
 	}
 
 	public Image getImage() {
@@ -81,16 +84,19 @@ public class GitResourceNode extends BufferedContent implements IStructureCompar
 		if (entry instanceof Tree)
 			return ITypedElement.FOLDER_TYPE;
 		else {
-			String name = entry.getName();
-			if (name != null) {
-				int index = name.lastIndexOf('.');
-				if (index == -1)
-					return ""; //$NON-NLS-1$
-				if (index == (name.length() - 1))
-					return ""; //$NON-NLS-1$
-				return name.substring(index + 1);
-			}
-			return "";
+			if (entry != null) {
+				String name = entry.getName();
+				if (name != null) {
+					int index = name.lastIndexOf('.');
+					if (index == -1)
+						return ""; //$NON-NLS-1$
+					if (index == (name.length() - 1))
+						return ""; //$NON-NLS-1$
+					return name.substring(index + 1);
+				}
+				return "";
+			} else
+				return "";
 		}
 	}
 
