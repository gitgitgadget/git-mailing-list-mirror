From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Showing abbreviated commit hash of the versions in Compare editor.
Date: Mon, 7 Jan 2008 23:15:29 -0200
Organization: Intelinet
Message-ID: <200801072315.30122.rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 02:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC33o-0007Qx-Ds
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 02:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382AbYAHBOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 20:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758044AbYAHBOf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 20:14:35 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1711 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757958AbYAHBOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 20:14:34 -0500
Received: (qmail 64980 invoked by uid 0); 7 Jan 2008 23:16:59 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.029875 secs); 08 Jan 2008 01:16:59 -0000
Received: from unknown (HELO ?192.168.1.100?) (189.5.206.233)
  by cvxbsd.convex.com.br with SMTP; 8 Jan 2008 01:16:59 -0000
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69831>


Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Some more patches, please evaluate.
Don't know what others are working on,
but right now I'm missing a search functionality so
this will probably be my next egit little feature.

cheers

 .../GitCompareFileRevisionEditorInput.java         |   12 ++++++++++++
 .../spearce/egit/ui/internal/GitResourceNode.java  |    5 +++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index eaba1fa..403fdc1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -152,6 +152,18 @@ public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
 
 	private void initLabels(ICompareInput input) {
 		CompareConfiguration cc = getCompareConfiguration();
+		if(left != null && left instanceof GitResourceNode) {
+			String ci = ((GitResourceNode)left).getContentIdentifier();
+			if(ci != null) {
+				cc.setLeftLabel(ci.substring(0, 7) + "..");
+			}
+		}
+		if(right != null && right instanceof GitResourceNode) {
+			String ci = ((GitResourceNode)right).getContentIdentifier();
+			if(ci != null) {
+				cc.setRightLabel(ci.substring(0, 7) + "..");
+			}
+		}
 		if (getLeftRevision() != null) {
 			String leftLabel = getFileRevisionLabel(getLeftRevision());
 			cc.setLeftLabel(leftLabel);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
index e19cef5..f25855a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitResourceNode.java
@@ -21,6 +21,7 @@ import org.spearce.jgit.lib.TreeEntry;
 public class GitResourceNode extends BufferedContent implements IStructureComparator, ITypedElement {
 	TreeEntry entry;
 	GitResourceNode[] children;
+	String contentIdentifier;
 
 	public GitResourceNode(TreeEntry e) {
 		entry = e;
@@ -28,6 +29,7 @@ public class GitResourceNode extends BufferedContent implements IStructureCompar
 
 	public GitResourceNode(IFileRevision file) {
 		this(file instanceof GitCommitFileRevision ? ((GitCommitFileRevision)file).getTreeEntry() : null);
+		contentIdentifier = ((GitCommitFileRevision)file).getContentIdentifier();
 	}
 
 	public Object[] getChildren() {
@@ -100,5 +102,8 @@ public class GitResourceNode extends BufferedContent implements IStructureCompar
 		}
 	}
 
+	public String getContentIdentifier() {
+		return contentIdentifier;
+	}
 }
 
-- 
1.5.3.7
