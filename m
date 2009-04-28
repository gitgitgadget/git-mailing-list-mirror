From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/13] Create the new WindowCache before clearing the old one
Date: Tue, 28 Apr 2009 14:12:18 -0700
Message-ID: <1240953146-12878-6-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:16:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyueQ-0006Nh-08
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbZD1VMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbZD1VMw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:52 -0400
Received: from george.spearce.org ([209.20.77.23]:58322 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbZD1VMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C73FC38221; Tue, 28 Apr 2009 21:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4FB9338239;
	Tue, 28 Apr 2009 21:12:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117818>

This way if the cache configuration is invalid the old cache is left
unmodified, permitting the caller to recover with no penalty.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index e4c88d2..aaad033 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -112,10 +112,11 @@ public static void reconfigure(final int packedGitLimit,
 	 *             settings, usually too low of a limit.
 	 */
 	public static void reconfigure(final WindowCacheConfig cfg) {
-		final WindowCache c = cache;
-		if (c != null)
-			c.removeAll();
-		cache = new WindowCache(cfg);
+		final WindowCache nc = new WindowCache(cfg);
+		final WindowCache oc = cache;
+		if (oc != null)
+			oc.removeAll();
+		cache = nc;
 		UnpackedObjectCache.reconfigure(cfg);
 	}
 
-- 
1.6.3.rc1.205.g37f8
