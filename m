From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 15/20] Refactor getRevSort() calls to hasRevSort()
Date: Sun, 15 Jun 2008 23:45:44 +0200
Message-ID: <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805c-00020y-Nq
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbYFOVrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbYFOVrl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:41 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31454 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYFOVrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:40 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958678ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AE+/OQFakv3SJrD9Cc/NRNW8qpHeXPPQ5/X2AKb8bX8=;
        b=KiG/yXnZLp320tAk3FgIYegJ3Ei2H7WCQ0llOP/3gOlcHpOw6XSOMaWztSYQXbk1eh
         DZHy5OlvHkMljL4sVIgHj8rfyFKYnrzdZy0E/0w6zp/J2Ulucux0q2+1aLr8BAuEVx8B
         T0f/aAtQaa/5iG2NBsYirOqHw5IwvdxecPL4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S4cgtg2LT8p2ArvyzBpnC1yJDjcGzGyENuGdOMA95uEb7gGUNR99mRvZMhuVNs+brc
         +qbeFv57ysZzxLyepRQ59ATpVXyzjquYUuPrhIy6ZtATRFBNc2cBSTOBqqMxwPAUWdU/
         e/EPZdgKkDEVIB+XswZWoAIC+JIRaG1Q3r7/E=
Received: by 10.151.101.20 with SMTP id d20mr9431799ybm.104.1213566459970;
        Sun, 15 Jun 2008 14:47:39 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id k7sm16646880qba.3.2008.06.15.14.47.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85142>

It is not signifficant performance improvement, just avoids creation of
few unnecessary objects.
However, it improves encapsulation and keeps existing RevSort checking
code consistent with further use of hasRevSort().

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |    2 +-
 .../org/spearce/jgit/revwalk/StartGenerator.java   |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index a36c1cc..68ed861 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -198,7 +198,7 @@ public class ObjectWalk extends RevWalk {
 				return null;
 			if ((r.flags & UNINTERESTING) != 0) {
 				markTreeUninteresting(r.getTree());
-				if (getRevSort().contains(RevSort.BOUNDARY))
+				if (hasRevSort(RevSort.BOUNDARY))
 					return r;
 				continue;
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
index debd168..7ddcd3c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
@@ -38,7 +38,6 @@
 package org.spearce.jgit.revwalk;
 
 import java.io.IOException;
-import java.util.EnumSet;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
@@ -91,8 +90,7 @@ class StartGenerator extends Generator {
 			return mbg.next();
 		}
 
-		final EnumSet<RevSort> sort = w.getRevSort();
-		boolean boundary = sort.contains(RevSort.BOUNDARY);
+		boolean boundary = walker.hasRevSort(RevSort.BOUNDARY);
 
 		if (!boundary && walker instanceof ObjectWalk) {
 			// The object walker requires boundary support to color
@@ -110,9 +108,10 @@ class StartGenerator extends Generator {
 		}
 
 		int pendingOutputType = 0;
-		if (sort.contains(RevSort.START_ORDER) && !(q instanceof FIFORevQueue))
+		if (walker.hasRevSort(RevSort.START_ORDER)
+				&& !(q instanceof FIFORevQueue))
 			q = new FIFORevQueue(q);
-		if (sort.contains(RevSort.COMMIT_TIME_DESC)
+		if (walker.hasRevSort(RevSort.COMMIT_TIME_DESC)
 				&& !(q instanceof DateRevQueue))
 			q = new DateRevQueue(q);
 		if (tf != TreeFilter.ALL) {
@@ -141,9 +140,10 @@ class StartGenerator extends Generator {
 			g = new RewriteGenerator(g);
 		}
 
-		if (sort.contains(RevSort.TOPO) && (g.outputType() & SORT_TOPO) == 0)
+		if (walker.hasRevSort(RevSort.TOPO)
+				&& (g.outputType() & SORT_TOPO) == 0)
 			g = new TopoSortGenerator(g);
-		if (sort.contains(RevSort.REVERSE))
+		if (walker.hasRevSort(RevSort.REVERSE))
 			g = new LIFORevQueue(q);
 		if (boundary)
 			g = new BoundaryGenerator(w, g);
-- 
1.5.5.1
