From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/4] Teach WindowCacheConfig to read core.packedgit* settings from config
Date: Mon, 16 Mar 2009 18:16:10 -0700
Message-ID: <1237252570-8596-5-git-send-email-spearce@spearce.org>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org>
 <1237252570-8596-2-git-send-email-spearce@spearce.org>
 <1237252570-8596-3-git-send-email-spearce@spearce.org>
 <1237252570-8596-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjNwI-0003eC-UA
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759581AbZCQBQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759144AbZCQBQU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:16:20 -0400
Received: from george.spearce.org ([209.20.77.23]:47504 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439AbZCQBQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:16:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E5A2938222; Tue, 17 Mar 2009 01:16:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AFB1338221;
	Tue, 17 Mar 2009 01:16:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237252570-8596-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113413>

This may help applications which want to read configuration from
the current repository, or from ~/.gitconfig when picking the access
strategy for the current process.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/WindowCacheConfig.java    |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
index d906a7c..ea28164 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
@@ -151,4 +151,20 @@ public int getDeltaBaseCacheLimit() {
 	public void setDeltaBaseCacheLimit(final int newLimit) {
 		deltaBaseCacheLimit = newLimit;
 	}
+
+	/**
+	 * Update properties by setting fields from the configuration.
+	 * <p>
+	 * If a property is not defined in the configuration, then it is left
+	 * unmodified.
+	 *
+	 * @param rc configuration to read properties from.
+	 */
+	public void fromConfig(final RepositoryConfig rc) {
+		setPackedGitOpenFiles(rc.getInt("core", null, "packedgitopenfiles", getPackedGitOpenFiles()));
+		setPackedGitLimit(rc.getInt("core", null, "packedgitlimit", getPackedGitLimit()));
+		setPackedGitWindowSize(rc.getInt("core", null, "packedgitwindowsize", getPackedGitWindowSize()));
+		setPackedGitMMAP(rc.getBoolean("core", null, "packedgitmmap", isPackedGitMMAP()));
+		setDeltaBaseCacheLimit(rc.getInt("core", null, "deltabasecachelimit", getDeltaBaseCacheLimit()));
+	}
 }
-- 
1.6.2.1.286.g8173
