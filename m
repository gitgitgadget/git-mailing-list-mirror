From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: [PATCH 1/2] Throw IllegalStateException if DirCacheEntry has not been fully initialized.
Date: Tue, 11 Aug 2009 17:56:20 -0700
Message-ID: <1250038581-31241-1-git-send-email-grek@tuffmail.com>
Cc: Grzegorz Kossakowski <grek@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb29J-0001ln-1A
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZHLA4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZHLA4m
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:56:42 -0400
Received: from smtp-out.google.com ([216.239.45.13]:60438 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZHLA4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 20:56:42 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n7C0uglK031440
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 17:56:42 -0700
Received: from localhost (glacegreek.mtv.corp.google.com [172.18.102.106])
	by spaceape12.eur.corp.google.com with ESMTP id n7C0ucxP032382;
	Tue, 11 Aug 2009 17:56:39 -0700
Received: by localhost (Postfix, from userid 97043)
	id 7B3247AAD3; Tue, 11 Aug 2009 17:56:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125633>

From: Grzegorz Kossakowski <grek@google.com>

When mode's object type of entry equals to Constants.OBJ_BAD it's a sign
of bad (uninitialized) state of an entry and not of problems with merging.

Signed-off-by: Grzegorz Kossakowski <grek@google.com>
---
 .../org/spearce/jgit/dircache/DirCacheTree.java    |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
index 9d5af70..79e95cb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheTree.java
@@ -377,7 +377,8 @@ private int computeSize(final DirCacheEntry[] cache, int cIdx,
 
 			final FileMode mode = e.getFileMode();
 			if (mode.getObjectType() == Constants.OBJ_BAD)
-				throw new UnmergedPathException(e);
+				throw new IllegalStateException("Entry \"" + e.getPathString()
+						+ "\" has incorrect mode set up.");
 
 			size += mode.copyToLength();
 			size += ep.length - pathOffset;
-- 
1.6.3.3
