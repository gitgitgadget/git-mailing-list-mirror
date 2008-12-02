From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/2] Close a forgotten reference to the HEAD ref.
Date: Tue,  2 Dec 2008 22:20:15 +0100
Message-ID: <1228252816-5987-1-git-send-email-robin.rosenberg@dewire.com>
References: <y>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 02 22:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7cgj-0008DH-9t
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbYLBVUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYLBVUV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:20:21 -0500
Received: from mail.dewire.com ([83.140.172.130]:21126 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbYLBVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:20:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3DB828026CA;
	Tue,  2 Dec 2008 22:20:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inUvba9ZdMaR; Tue,  2 Dec 2008 22:20:17 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 525238006BF;
	Tue,  2 Dec 2008 22:20:16 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102177>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index c953531..b54afd5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -989,9 +989,10 @@ public Ref peel(final Ref ref) {
 	 * @return true if HEAD points to a StGit patch.
 	 */
 	public boolean isStGitMode() {
+		File file = new File(getDirectory(), "HEAD");
+		BufferedReader reader = null;
 		try {
-			File file = new File(getDirectory(), "HEAD");
-			BufferedReader reader = new BufferedReader(new FileReader(file));
+			reader = new BufferedReader(new FileReader(file));
 			String string = reader.readLine();
 			if (!string.startsWith("ref: refs/heads/"))
 				return false;
@@ -1007,6 +1008,13 @@ public boolean isStGitMode() {
 		} catch (IOException e) {
 			e.printStackTrace();
 			return false;
+		} finally {
+			try {
+				if (reader != null)
+					reader.close();
+			} catch (IOException e1) {
+				// nothing to do here
+			}
 		}
 	}
 
-- 
1.6.0.3.640.g6331a
