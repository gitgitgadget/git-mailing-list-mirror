From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Set table row height for the glog JTable
Date: Wed,  1 Oct 2008 21:31:31 +0200
Message-ID: <1222889493-12736-2-git-send-email-robin.rosenberg@dewire.com>
References: <20081001143815.GV21310@spearce.org>
 <1222889493-12736-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 21:34:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7Si-0007Lh-7e
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbYJATcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753806AbYJATco
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:32:44 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:48641 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbYJATcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:32:41 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id DE4E938534; Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id AB80738522; Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 8D11C37E47;
	Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222889493-12736-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97257>

For some obscure reason JTable has a fixed default row size
of 16 pixels. This doesn't work well outside the default
look-and-feels shipped with the JRE, e.g. the GTK look and
feel for Linux.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/awtui/CommitGraphPane.java    |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
index 2be0e95..d778821 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.java
@@ -52,6 +52,7 @@
 import javax.swing.table.AbstractTableModel;
 import javax.swing.table.DefaultTableCellRenderer;
 import javax.swing.table.JTableHeader;
+import javax.swing.table.TableCellRenderer;
 import javax.swing.table.TableColumn;
 import javax.swing.table.TableColumnModel;
 import javax.swing.table.TableModel;
@@ -83,8 +84,18 @@ public CommitGraphPane() {
 		allCommits = new SwingCommitList();
 		configureHeader();
 		setShowHorizontalLines(false);
-		setRowMargin(0);
 		setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
+		configureRowHeight();
+	}
+
+	private void configureRowHeight() {
+		int h = 0;
+		for (int i = 0; i<getColumnCount(); ++i) {
+			TableCellRenderer renderer = getDefaultRenderer(getColumnClass(i));
+			Component c = renderer.getTableCellRendererComponent(this, "\u00c5Oj", false, false, 0, i);
+			h = Math.max(h, c.getPreferredSize().height);
+		}
+		setRowHeight(h + getRowMargin());
 	}
 
 	/**
-- 
1.6.0.1.310.gf789d0.dirty
