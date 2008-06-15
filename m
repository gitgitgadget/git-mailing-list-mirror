From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 16/20] Support for RevSort.BOUNDARY in ObjectWalk
Date: Sun, 15 Jun 2008 23:45:45 +0200
Message-ID: <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
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
 <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K805d-00020y-Aw
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYFOVrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYFOVrq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:31273 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYFOVrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958696ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HJvmEK8I7JvYgrBjnCwuRL2Ls4x6JuyMC/GQ2eXa73Y=;
        b=Vp1qaofpg0wGOFcn0L2X/aPm3SH5l1eu1bsN0Yty4OpC4UjFWWcchZYPW6JVIp1APz
         w683/quymgulBuokx281x566Xbc6jlNGP+mfBA4ldkRSRpCVY9Z8I+qqEE2QWldpXdTe
         Ff2sC/60LZlQSkOxAx7UUHHJTG/JM2QXq+FGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S13rH4WbAVHNoOnPlkCcnFaKW61mFWqWqSd0oIlmF/hyIsgla7eTbIhe0OdzqpxO1s
         TUNiRBrfPtLCfEu0MaSgTn+t0v7pjv5RfNFej1P1OBSaRsZczXC3XtdEBgmO2F+uJ1yq
         oTywAzuNzcA1oaYMjw/bFsu/MnEorUug3Yj4s=
Received: by 10.150.202.14 with SMTP id z14mr9410595ybf.95.1213566464875;
        Sun, 15 Jun 2008 14:47:44 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id s31sm15636622qbs.11.2008.06.15.14.47.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:43 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85141>

When RevSort.BOUNDARY strategy in enabled, ObjectWalk now includes in
nextObjects() all objects associated with boundary commits (trees,
blobs) and all other objects explictly marked as  uninteresting
(boundary).

This behavior is something more than original C git-rev-list offers in
this matter - it is impossible to get such a behavior (to include all
boundary objects, not only commits, at output) directly from:
$ git-rev-list --objects-edge
Here, it is added for compactness - callers usually need also boundary
objects (e.g. for preparing thin-pack). If not, they can still easily
filter out such objects from nextObject() by checking for UNINTERESTING
flag or just use next() if interested only in commits.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |   26 +++++++++++++++----
 .../src/org/spearce/jgit/revwalk/RevSort.java      |    5 +++-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 68ed861..81cebbd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -66,8 +66,6 @@ import org.spearce.jgit.treewalk.TreeWalk;
  * commits that are returned first.
  */
 public class ObjectWalk extends RevWalk {
-	private static final int SEEN_OR_UNINTERESTING = SEEN | UNINTERESTING;
-
 	private final TreeWalk treeWalk;
 
 	private BlockObjQueue objects;
@@ -177,6 +175,8 @@ public class ObjectWalk extends RevWalk {
 			IncorrectObjectTypeException, IOException {
 		while (o instanceof RevTag) {
 			o.flags |= UNINTERESTING;
+			if (hasRevSort(RevSort.BOUNDARY))
+				addObject(o);
 			o = ((RevTag) o).getObject();
 			parse(o);
 		}
@@ -187,6 +187,10 @@ public class ObjectWalk extends RevWalk {
 			markTreeUninteresting((RevTree) o);
 		else
 			o.flags |= UNINTERESTING;
+
+		if (o.getType() != Constants.OBJ_COMMIT && hasRevSort(RevSort.BOUNDARY)) {
+			addObject(o);
+		}
 	}
 
 	@Override
@@ -198,8 +202,10 @@ public class ObjectWalk extends RevWalk {
 				return null;
 			if ((r.flags & UNINTERESTING) != 0) {
 				markTreeUninteresting(r.getTree());
-				if (hasRevSort(RevSort.BOUNDARY))
+				if (hasRevSort(RevSort.BOUNDARY)) {
+					objects.add(r.getTree());
 					return r;
+				}
 				continue;
 			}
 			objects.add(r.getTree());
@@ -237,17 +243,23 @@ public class ObjectWalk extends RevWalk {
 			switch (sType) {
 			case Constants.OBJ_BLOB: {
 				final RevObject o = lookupAny(treeWalk.getObjectId(0), sType);
-				if ((o.flags & SEEN_OR_UNINTERESTING) != 0)
+				if ((o.flags & SEEN) != 0)
 					continue;
 				o.flags |= SEEN;
+				if ((o.flags & UNINTERESTING) != 0
+						&& !hasRevSort(RevSort.BOUNDARY))
+					continue;
 				fromTreeWalk = true;
 				return o;
 			}
 			case Constants.OBJ_TREE: {
 				final RevObject o = lookupAny(treeWalk.getObjectId(0), sType);
-				if ((o.flags & SEEN_OR_UNINTERESTING) != 0)
+				if ((o.flags & SEEN) != 0)
 					continue;
 				o.flags |= SEEN;
+				if ((o.flags & UNINTERESTING) != 0
+						&& !hasRevSort(RevSort.BOUNDARY))
+					continue;
 				enterSubtree = true;
 				fromTreeWalk = true;
 				return o;
@@ -265,9 +277,11 @@ public class ObjectWalk extends RevWalk {
 			final RevObject o = objects.next();
 			if (o == null)
 				return null;
-			if ((o.flags & SEEN_OR_UNINTERESTING) != 0)
+			if ((o.flags & SEEN) != 0)
 				continue;
 			o.flags |= SEEN;
+			if ((o.flags & UNINTERESTING) != 0 && !hasRevSort(RevSort.BOUNDARY))
+				continue;
 			if (o instanceof RevTree) {
 				currentTree = (RevTree) o;
 				treeWalk.reset(new ObjectId[] { currentTree });
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
index 8688f7f..b0a03ad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevSort.java
@@ -37,7 +37,7 @@
 
 package org.spearce.jgit.revwalk;
 
-/** Sorting strategies supported by {@link RevWalk}. */
+/** Sorting strategies supported by {@link RevWalk} and {@link ObjectWalk}. */
 public enum RevSort {
 	/**
 	 * No specific sorting is requested.
@@ -83,6 +83,9 @@ public enum RevSort {
 
 	/**
 	 * Include {@link RevFlag#UNINTERESTING} boundary commits after all others.
+	 * In {@link ObjectWalk}, objects associated with such commits (trees,
+	 * blobs), and all other objects marked explicitly as UNINTERESTING are also
+	 * included.
 	 * <p>
 	 * A boundary commit is a UNINTERESTING parent of an interesting commit that
 	 * was previously output.
-- 
1.5.5.1
