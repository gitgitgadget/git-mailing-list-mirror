From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/4] Update EGit plugin to use WindowCacheConfig
Date: Mon, 16 Mar 2009 18:16:08 -0700
Message-ID: <1237252570-8596-3-git-send-email-spearce@spearce.org>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org>
 <1237252570-8596-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjNwI-0003eC-7G
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759362AbZCQBQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757833AbZCQBQS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:16:18 -0400
Received: from george.spearce.org ([209.20.77.23]:47499 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbZCQBQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:16:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 035C538265; Tue, 17 Mar 2009 01:16:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 05DF6381D3;
	Tue, 17 Mar 2009 01:16:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237252570-8596-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113412>

Its more flexible for future additions to the parameters.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/project/GitProjectData.java  |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 8b72818..31d5483 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -42,6 +42,7 @@
 import org.spearce.egit.core.GitProvider;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCache;
+import org.spearce.jgit.lib.WindowCacheConfig;
 
 /**
  * This class keeps information about how a project is mapped to
@@ -229,12 +230,13 @@ private synchronized static Repository lookupRepository(final File gitDir)
 	 * Update the settings for the global window cache of the workspace.
 	 */
 	public static void reconfigureWindowCache() {
+		final WindowCacheConfig c = new WindowCacheConfig();
 		Preferences p = Activator.getDefault().getPluginPreferences();
-		int wLimit = p.getInt(GitCorePreferences.core_packedGitLimit);
-		int wSize = p.getInt(GitCorePreferences.core_packedGitWindowSize);
-		boolean mmap = p.getBoolean(GitCorePreferences.core_packedGitMMAP);
-		int dbLimit = p.getInt(GitCorePreferences.core_deltaBaseCacheLimit);
-		WindowCache.reconfigure(wLimit, wSize, mmap, dbLimit);
+		c.setPackedGitLimit(p.getInt(GitCorePreferences.core_packedGitLimit));
+		c.setPackedGitWindowSize(p.getInt(GitCorePreferences.core_packedGitWindowSize));
+		c.setPackedGitMMAP(p.getBoolean(GitCorePreferences.core_packedGitMMAP));
+		c.setDeltaBaseCacheLimit(p.getInt(GitCorePreferences.core_deltaBaseCacheLimit));
+		WindowCache.reconfigure(c);
 	}
 
 	private final IProject project;
-- 
1.6.2.1.286.g8173
