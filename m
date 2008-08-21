From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/4] Add getNameString to TreeWalk to get only the last path component
Date: Thu, 21 Aug 2008 13:57:38 -0700
Message-ID: <1219352258-15431-4-git-send-email-spearce@spearce.org>
References: <1219352258-15431-1-git-send-email-spearce@spearce.org>
 <1219352258-15431-2-git-send-email-spearce@spearce.org>
 <1219352258-15431-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHFM-0002hz-7c
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbYHUU5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbYHUU5p
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:57:45 -0400
Received: from george.spearce.org ([209.20.77.23]:41823 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbYHUU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:57:41 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F022C38375; Thu, 21 Aug 2008 20:57:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A2AD338376;
	Thu, 21 Aug 2008 20:57:39 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.112.g9c75
In-Reply-To: <1219352258-15431-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93208>

Some applications may need to see only the name of the current
entry within its parent tree and not require the full path from
the root of the repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index ef27e4e..53b94d2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -548,6 +548,24 @@ public boolean idEqual(final int nthA, final int nthB) {
 	}
 
 	/**
+	 * Get the current entry's name within its parent tree.
+	 * <p>
+	 * This method is not very efficient and is primarily meant for debugging
+	 * and final output generation. Applications should try to avoid calling it,
+	 * and if invoked do so only once per interesting entry, where the name is
+	 * absolutely required for correct function.
+	 * 
+	 * @return name of the current entry within the parent tree (or directory).
+	 *         The name never includes a '/'.
+	 */
+	public String getNameString() {
+		final AbstractTreeIterator t = currentHead;
+		final int off = t.pathOffset;
+		final int end = t.pathLen;
+		return RawParseUtils.decode(Constants.CHARSET, t.path, off, end);
+	}
+
+	/**
 	 * Get the current entry's complete path.
 	 * <p>
 	 * This method is not very efficient and is primarily meant for debugging
-- 
1.6.0.112.g9c75
