From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Use Integer.valueOf instead of new Integer
Date: Wed, 6 Feb 2008 21:15:37 +0100
Message-ID: <200802062115.38212.robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com> <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com> <20080206070631.GM24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:16:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqgy-0005G6-Vz
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbYBFUPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbYBFUPv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:15:51 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10463 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755580AbYBFUPu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 15:15:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 732EC800695;
	Wed,  6 Feb 2008 21:15:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7MglcEJybLb; Wed,  6 Feb 2008 21:15:47 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 44EBA800680;
	Wed,  6 Feb 2008 21:15:42 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080206070631.GM24004@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72841>

onsdagen den 6 februari 2008 skrev Shawn O. Pearce:
> Use Integer.valueOf(int).  Post Java 5 implementations of the J2SE
> are required to cache values between -128 and 127 (inclusive).
> 
> Actually, when the Java compiler autoboxes values it does so through
> these static valueOf methods, which were mostly introduced as part
> of the Java 5 API updates.  For small common values its cached and
> will thus avoid garbage generation, for less common values it goes
> back to allocating the object.

Thank you for this information.

-- robin

>From 2f2248fc01c169d85e88d42d10693e4ec59a0c1d Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 6 Feb 2008 21:06:08 +0100
Subject: [EGIT PATCH 2/2] Use Integer.valueOf instead of new Integer

Java 1.5+ has a cache for small numbers.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/FindResults.java       |   10 +++++-----
 .../internal/decorators/GitResourceDecorator.java  |    4 ++--
 .../tst/org/spearce/jgit/lib/MappedListTest.java   |    8 ++++----
 .../tst/org/spearce/jgit/lib/SuperListTest.java    |   12 ++++++------
 .../src/org/spearce/jgit/lib/SuperList.java        |    2 +-
 .../org/spearce/jgit/lib/TopologicalSorter.java    |    8 ++++----
 6 files changed, 22 insertions(+), 22 deletions(-)

Thanks to Shawn

-- robin

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
index 9484503..2b49597 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindResults.java
@@ -45,7 +45,7 @@ public class FindResults {
 	 *         <code>false</code> otherwise
 	 */
 	public synchronized boolean isFoundAt(int index) {
-		return matchesMap.containsKey(new Integer(index));
+		return matchesMap.containsKey(Integer.valueOf(index));
 	}
 
 	/**
@@ -59,7 +59,7 @@ public class FindResults {
 	 */
 	public synchronized int getIndexAfter(int index) {
 		Integer[] matches = getkeysArray();
-		int sres = Arrays.binarySearch(matches, new Integer(index));
+		int sres = Arrays.binarySearch(matches, Integer.valueOf(index));
 		if (sres >= 0 && sres != matches.length - 1) {
 			return matches[sres + 1].intValue();
 		} else if (sres < 0) {
@@ -83,7 +83,7 @@ public class FindResults {
 	 */
 	public synchronized int getIndexBefore(int index) {
 		Integer[] matches = getkeysArray();
-		int sres = Arrays.binarySearch(matches, new Integer(index));
+		int sres = Arrays.binarySearch(matches, Integer.valueOf(index));
 		if (sres >= 0 && sres != 0) {
 			return matches[sres - 1].intValue();
 		} else if (sres < -1) {
@@ -136,7 +136,7 @@ public class FindResults {
 	 *         list. Returns -1 if <code>index</code> doesn't contain a match
 	 */
 	public synchronized int getMatchNumberFor(int index) {
-		Integer ix = matchesMap.get(new Integer(index));
+		Integer ix = matchesMap.get(Integer.valueOf(index));
 		if (ix != null) {
 			return ix.intValue();
 		}
@@ -168,7 +168,7 @@ public class FindResults {
 	 *            the history table item index that matches a find pattern.
 	 */
 	public synchronized void add(int matchIx) {
-		matchesMap.put(new Integer(matchIx), new Integer(++matchesCount));
+		matchesMap.put(Integer.valueOf(matchIx), Integer.valueOf(++matchesCount));
 		keysArray = null;
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java 
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 9592817..df2f569 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -358,7 +358,7 @@ public class GitResourceDecorator extends LabelProvider implements
 		try {
 			Integer dirty = (Integer) rsrc.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
 			if (dirty == null) {
-				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, new Integer(flag));
+				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, Integer.valueOf(flag));
 				Activator.trace("SETTING:"+rsrc.getFullPath().toOSString()+" => "+flag);
 				orState(rsrc.getParent(), flag);
 				Display.getDefault().asyncExec(new Runnable() {
@@ -375,7 +375,7 @@ public class GitResourceDecorator extends LabelProvider implements
 				});
 			} else {
 				if ((dirty.intValue() | flag) != dirty.intValue()) {
-					dirty = new Integer(dirty.intValue() | flag);
+					dirty = Integer.valueOf(dirty.intValue() | flag);
 					rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, dirty);
 					Activator.trace("SETTING:"+rsrc.getFullPath().toOSString()+" => "+dirty);
 					orState(rsrc.getParent(), dirty.intValue());
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MappedListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MappedListTest.java
index ccc13a0..6513d99 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MappedListTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/MappedListTest.java
@@ -29,13 +29,13 @@ public class MappedListTest extends TestCase {
 						new Float(3.14f) })) {
 			@Override
 			protected Integer map(Float from) {
-				return new Integer((int) from.floatValue() * 2);
+				return Integer.valueOf((int) from.floatValue() * 2);
 			}
 		};
 
 		assertEquals(3, x.toArray().length);
-		assertEquals(new Integer(2), x.toArray()[0]);
-		assertEquals(new Integer(4), x.toArray()[1]);
-		assertEquals(new Integer(6), x.toArray()[2]);
+		assertEquals(Integer.valueOf(2), x.toArray()[0]);
+		assertEquals(Integer.valueOf(4), x.toArray()[1]);
+		assertEquals(Integer.valueOf(6), x.toArray()[2]);
 	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
index 79f4da6..be38b95 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/SuperListTest.java
@@ -38,14 +38,14 @@ public class SuperListTest extends TestCase {
 		l.addAll(sl1);
 		l.addAll(sl2);
 		l.addAll(sl3);
-		l.add(new Integer(7));
+		l.add(Integer.valueOf(7));
 
 		assertEquals(5, l.size());
-		assertEquals(new Integer(3), l.toArray()[0]);
-		assertEquals(new Integer(4), l.toArray()[1]);
-		assertEquals(new Integer(5), l.toArray()[2]);
-		assertEquals(new Integer(6), l.toArray()[3]);
-		assertEquals(new Integer(7), l.toArray()[4]);
+		assertEquals(Integer.valueOf(3), l.toArray()[0]);
+		assertEquals(Integer.valueOf(4), l.toArray()[1]);
+		assertEquals(Integer.valueOf(5), l.toArray()[2]);
+		assertEquals(Integer.valueOf(6), l.toArray()[3]);
+		assertEquals(Integer.valueOf(7), l.toArray()[4]);
 
 		assertEquals(5, l.toArray().length);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/SuperList.java b/org.spearce.jgit/src/org/spearce/jgit/lib/SuperList.java
index 4a50794..04c9958 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/SuperList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/SuperList.java
@@ -48,7 +48,7 @@ public class SuperList<T> extends AbstractList<T> {
 	 */
 	public boolean addAll(List<T> subList) {
 		int lastEnd = subLists.size() > 0 ? subListEnd.get(subListEnd.size()-1).intValue() : 0;
-		subListEnd.add(new Integer(lastEnd + subList.size()));
+		subListEnd.add(Integer.valueOf(lastEnd + subList.size()));
 		subLists.add(subList);
 		return true;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
index c33334e..d5c2430 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TopologicalSorter.java
@@ -205,9 +205,9 @@ public class TopologicalSorter<T> {
 		allNodes.add(edge.to);
 		Integer n = inCount.get(edge.to);
 		if (n == null)
-			inCount.put(edge.to, new Integer(1));
+			inCount.put(edge.to, Integer.valueOf(1));
 		else
-			inCount.put(edge.to, new Integer(n.intValue() + 1));
+			inCount.put(edge.to, Integer.valueOf(n.intValue() + 1));
 	}
 
 	/**
@@ -255,7 +255,7 @@ public class TopologicalSorter<T> {
 					zeroIn.add(e.to);
 					inCount.remove(e.to);
 				} else {
-					inCount.put(e.to, new Integer(c.intValue() - 1));
+					inCount.put(e.to, Integer.valueOf(c.intValue() - 1));
 				}
 			}
 //			allEdges.remove(from);
@@ -356,7 +356,7 @@ public class TopologicalSorter<T> {
 		}
 		Iterator<T> i = zeroIn.iterator();
 		ret = i.next();
-		internalOrder.put(ret, new Integer(internalOrder.size()));
+		internalOrder.put(ret, Integer.valueOf(internalOrder.size()));
 		i.remove();
 		removeallfrom(ret);
 		return ret;
-- 
1.5.4.rc4.25.g81cc
