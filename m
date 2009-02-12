From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/6] Fix RefUpdate.delete to update the result status
Date: Thu, 12 Feb 2009 15:54:35 -0800
Message-ID: <1234482880-1316-2-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPl-0004ei-20
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbZBLXyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbZBLXyo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:44 -0500
Received: from george.spearce.org ([209.20.77.23]:49149 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZBLXym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:42 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 27CC338211; Thu, 12 Feb 2009 23:54:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AFA8638210;
	Thu, 12 Feb 2009 23:54:41 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109686>

Some applications may want to use getResult() to obtain the
status of the delete operation, as perhaps they lost access
to the return value.  This makes delete() more consistent in
use with update().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 7ad2bab..d1820da 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -401,11 +401,11 @@ public Result delete(final RevWalk walk) throws IOException {
 		if (getName().startsWith(Constants.R_HEADS)) {
 			final Ref head = db.readRef(Constants.HEAD);
 			if (head != null && getName().equals(head.getName()))
-				return Result.REJECTED_CURRENT_BRANCH;
+				return result = Result.REJECTED_CURRENT_BRANCH;
 		}
 
 		try {
-			return updateImpl(walk, new DeleteStore());
+			return result = updateImpl(walk, new DeleteStore());
 		} catch (IOException x) {
 			result = Result.IO_FAILURE;
 			throw x;
-- 
1.6.2.rc0.226.gf08f
