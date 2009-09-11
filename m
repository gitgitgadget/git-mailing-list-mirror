From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Use keep(1) instead of add() when skipping an entry
Date: Fri, 11 Sep 2009 12:58:49 -0700
Message-ID: <1252699129-6961-3-git-send-email-spearce@spearce.org>
References: <1252699129-6961-1-git-send-email-spearce@spearce.org>
 <1252699129-6961-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmCH4-0001yS-DC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 21:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbZIKT6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 15:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756151AbZIKT6x
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 15:58:53 -0400
Received: from george.spearce.org ([209.20.77.23]:53655 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124AbZIKT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 15:58:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 037613815E; Fri, 11 Sep 2009 19:58:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 145F0381FD;
	Fri, 11 Sep 2009 19:58:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
In-Reply-To: <1252699129-6961-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128215>

Doing a keep call with a length of 1 will copy the current entry just
like the previous add was doing, but it avoids doing any validation
on the entry.  This is sane because the entry can be assumed to be
already valid, since its originating from the destination index.

Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 .../jgit/dircache/DirCacheBuildIterator.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
index 9818b76..94fc071 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
@@ -111,7 +111,7 @@ public void skip() throws CorruptObjectException {
 		if (currentSubtree != null)
 			builder.keep(ptr, currentSubtree.getEntrySpan());
 		else
-			builder.add(currentEntry);
+			builder.keep(ptr, 1);
 		next(1);
 	}
 
-- 
1.6.5.rc0.164.g5f6b0
