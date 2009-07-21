From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/12] Match config subsection names using case sensitive search
Date: Tue, 21 Jul 2009 13:19:28 -0700
Message-ID: <1248207570-13880-11-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
 <1248207570-13880-7-git-send-email-spearce@spearce.org>
 <1248207570-13880-8-git-send-email-spearce@spearce.org>
 <1248207570-13880-9-git-send-email-spearce@spearce.org>
 <1248207570-13880-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpz-0001jT-25
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbZGUUTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbZGUUTn
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:43 -0400
Received: from george.spearce.org ([209.20.77.23]:59251 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbZGUUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D425B38215; Tue, 21 Jul 2009 20:19:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 240B33821F;
	Tue, 21 Jul 2009 20:19:34 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123703>

The subsection name is case sensitive, and should be matched as such.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index e379c37..974ffea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -4,6 +4,7 @@
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
  * Copyright (C) 2008, Thad Hughes <thadh@thad.corp.google.com>
  * Copyright (C) 2009, JetBrains s.r.o.
+ * Copyright (C) 2009, Google, Inc.
  *
  * All rights reserved.
  *
@@ -1024,17 +1025,25 @@ private static String readValue(final BufferedReader r, boolean quote,
 
 		boolean match(final String aSection, final String aSubsection,
 				final String aKey) {
-			return eq(section, aSection) && eq(subsection, aSubsection)
-					&& eq(name, aKey);
+			return eqIgnoreCase(section, aSection)
+					&& eqSameCase(subsection, aSubsection)
+					&& eqIgnoreCase(name, aKey);
 		}
 
-		private static boolean eq(final String a, final String b) {
+		private static boolean eqIgnoreCase(final String a, final String b) {
 			if (a == null && b == null)
 				return true;
 			if (a == null || b == null)
 				return false;
 			return a.equalsIgnoreCase(b);
 		}
-	}
 
-}
\ No newline at end of file
+		private static boolean eqSameCase(final String a, final String b) {
+			if (a == null && b == null)
+				return true;
+			if (a == null || b == null)
+				return false;
+			return a.equals(b);
+		}
+	}
+}
-- 
1.6.4.rc1.186.g60aa0c
