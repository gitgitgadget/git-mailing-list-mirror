From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/19] Use type specific sets when creating a new RepositoryConfig
Date: Sat, 25 Jul 2009 11:52:48 -0700
Message-ID: <1248547982-4003-6-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO3-0002ZF-Ia
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZGYSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZGYSxZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:25 -0400
Received: from george.spearce.org ([209.20.77.23]:35555 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZGYSxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 78C1138200; Sat, 25 Jul 2009 18:53:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4DC1538196;
	Sat, 25 Jul 2009 18:53:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124040>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    5 ++---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 1076fe1..98a276b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -166,9 +166,8 @@ public void create(boolean bare) throws IOException {
 
 		RepositoryConfig cfg = getConfig();
 		cfg.create();
-		if (bare) {
-			cfg.setString("core", null, "bare", "true");
-		}
+		if (bare)
+			cfg.setBoolean("core", null, "bare", true);
 		cfg.save();
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 85e8738..c80db00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -203,8 +203,8 @@ private String getUserEmailInternal(String gitVariableKey) {
 	public void create() {
 		clear();
 		setFileRead(true);
-		setString("core", null, "repositoryformatversion", "0");
-		setString("core", null, "filemode", "true");
+		setInt("core", null, "repositoryformatversion", 0);
+		setBoolean("core", null, "filemode", true);
 
 		core = new CoreConfig(this);
 		transfer = new TransferConfig(this);
-- 
1.6.4.rc2.216.g769fa
