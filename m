From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/10] Clear the reverse index when closing a PackFile
Date: Mon, 20 Apr 2009 18:21:06 -0700
Message-ID: <1240276872-17893-5-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
 <1240276872-17893-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hU-00021g-61
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647AbZDUBV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756556AbZDUBVW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:22 -0400
Received: from george.spearce.org ([209.20.77.23]:33022 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbZDUBVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1CBC138267; Tue, 21 Apr 2009 01:21:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C9CD138222;
	Tue, 21 Apr 2009 01:21:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117066>

We clear the forward index (ObjectId -> offset) when we close the pack,
so we might as well clear the reverse index (offset -> ObjectId).

The reverse index is protected by the lock on "this", just like the
forward index is.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 1e6f170..b525a82 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -155,6 +155,7 @@ public void close() {
 		pack.close();
 		synchronized (this) {
 			loadedIdx = null;
+			reverseIdx = null;
 		}
 	}
 
-- 
1.6.3.rc1.188.ga02b
