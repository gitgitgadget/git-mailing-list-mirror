From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 8/9] Make git dectected changes depend on the automatic refresh setting
Date: Fri, 11 Jul 2008 00:40:50 +0200
Message-ID: <1215729651-26781-9-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-6-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-7-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-8-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:48:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vX-0004Lo-B7
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbYGJWqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbYGJWqO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13142 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbYGJWqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AC529147B7F2;
	Fri, 11 Jul 2008 00:46:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TU2ieaNsDKTg; Fri, 11 Jul 2008 00:46:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 18B0F147B7ED;
	Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88044>

This is the same setting that scans the workspace regularly for
changes in resources. We scan more often can can trigger sooner because
we can scan fewer files.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/Activator.java         |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index 39d3bc9..d8928cb 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -203,6 +203,11 @@ public class Activator extends AbstractUIPlugin {
 		}
 
 		public void indexChanged(IndexChangedEvent e) {
+			// Check the workspace setting "refresh automatically" setting first
+			if (!ResourcesPlugin.getPlugin().getPluginPreferences().getBoolean(
+					ResourcesPlugin.PREF_AUTO_REFRESH))
+				return;
+
 			IProject[] projects = ResourcesPlugin.getWorkspace().getRoot().getProjects();
 			Set<IProject> toRefresh= new HashSet<IProject>();
 			for (IProject p : projects) {
-- 
1.5.6.2.220.g44701
