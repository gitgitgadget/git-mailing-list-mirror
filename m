From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Clone: If url is changed was changed, forget the old value
Date: Sun, 22 Jun 2008 19:46:37 +0200
Message-ID: <1214156797-29186-3-git-send-email-robin.rosenberg@dewire.com>
References: <20080622013640.GA18629@spearce.org>
 <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
 <1214156797-29186-2-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 21:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUoV-0004am-6E
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbYFVTA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbYFVTA2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:00:28 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:63568 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753291AbYFVTA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 15:00:26 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB003C2069; Sun, 22 Jun 2008 19:50:28 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214156797-29186-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85792>

This fixes a bug found by some monkey testing where the dialog
get stuck in a state where changing connection parameters have
no effect.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/clone/SourceBranchPage.java   |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index 615be32..b704aaa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -75,8 +75,10 @@ class SourceBranchPage extends WizardPage {
 		setImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
 		sourcePage.addURIishChangeListener(new URIishChangeListener() {
 			public void uriishChanged(final URIish newURI) {
-				if (newURI == null || !newURI.equals(validated))
+				if (newURI == null || !newURI.equals(validated)) {
+					validated = null;
 					setPageComplete(false);
+				}
 			}
 		});
 		branchChangeListeners = new ArrayList<BranchChangeListener>(3);
-- 
1.5.5.1.178.g1f811
