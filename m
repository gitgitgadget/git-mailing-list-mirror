From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/7] Fix FindBugs String == is bad form
Date: Mon,  4 May 2009 16:30:44 -0700
Message-ID: <1241479848-20687-3-git-send-email-spearce@spearce.org>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
 <1241479848-20687-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17cj-0005qi-H3
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbZEDXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbZEDXav
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:30:51 -0400
Received: from george.spearce.org ([209.20.77.23]:52547 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbZEDXat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EC3B53819F; Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6E86438196;
	Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
In-Reply-To: <1241479848-20687-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118271>

We only used "a == b" to test for both values == null, as we can't
use a.equalsIgnoreCase if a is null.  Instead test for that null
case, and fall through for everything else.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 87fc254..cb287ee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -1102,7 +1102,7 @@ boolean match(final String aBase, final String aExtendedBase,
 		}
 
 		private static boolean eq(final String a, final String b) {
-			if (a == b)
+			if (a == null && b == null)
 				return true;
 			if (a == null || b == null)
 				return false;
-- 
1.6.3.rc4.206.g03e16
