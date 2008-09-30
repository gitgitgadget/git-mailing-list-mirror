From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/8] Set table row height for the glog JTable
Date: Wed,  1 Oct 2008 01:53:40 +0200
Message-ID: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:56:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkp4U-00040Q-89
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYI3Xyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:54:51 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYI3Xyv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:54:51 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:38202 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYI3Xyu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:54:50 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 225F038276; Wed,  1 Oct 2008 01:54:49 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id E4AF538165; Wed,  1 Oct 2008 01:54:48 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 8964C37E43;
	Wed,  1 Oct 2008 01:54:48 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97173>

=46or some obscure reason JTable has a fixed default row size
of 16 pixels. This doesn't work well outside the default
look-and-feels shipped with the JRE, e.g. the GTK look and
feel for Linux.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/awtui/CommitGraphPane.java    |   13 ++++++++++++=
-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPan=
e.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/CommitGraphPane.ja=
va
index 2be0e95..4ab2136 100644
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
 		allCommits =3D new SwingCommitList();
 		configureHeader();
 		setShowHorizontalLines(false);
-		setRowMargin(0);
 		setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
+		configureRowHeight();
+	}
+
+	private void configureRowHeight() {
+		int h =3D 0;
+		for (int i =3D 0; i<getColumnCount(); ++i) {
+			TableCellRenderer renderer =3D getDefaultRenderer(getColumnClass(i)=
);
+			Component c =3D renderer.getTableCellRendererComponent(this, "=C3=85=
Oj", false, false, 0, i);
+			h =3D Math.max(h, c.getPreferredSize().height);
+		}
+		setRowHeight(h + getRowMargin());
 	}
=20
 	/**
--=20
1.6.0.1.310.gf789d0.dirty
