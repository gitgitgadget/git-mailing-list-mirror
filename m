From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree merge strategy
Date: Thu, 23 Oct 2008 23:14:29 +0200
Message-ID: <200810232314.29867.robin.rosenberg@dewire.com>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <1223932217-4771-8-git-send-email-spearce@spearce.org> <1223932217-4771-9-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 23:16:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt7XC-0005np-5z
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 23:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYJWVOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 17:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYJWVOn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 17:14:43 -0400
Received: from mail.dewire.com ([83.140.172.130]:18211 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbYJWVOn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2008 17:14:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 74A4B147EAE9;
	Thu, 23 Oct 2008 23:14:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x+ZaDJZDpiZw; Thu, 23 Oct 2008 23:14:39 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CD6E380267D;
	Thu, 23 Oct 2008 23:14:39 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1223932217-4771-9-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98987>

Hi, Shawn

Shouldn't testTrivialTwoWay_disjointhistories()  work?

The two trees have nothing in common and so should be trivially mergeable.

-- robin

>From cef2695431e368da616a1e9c8de3e5e419854a4c Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Thu, 23 Oct 2008 23:09:10 +0200
Subject: [EGIT PATCH] Simple merge test

---
 .../org/spearce/jgit/merge/SimpleMergeTest.java    |   28 ++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
new file mode 100644
index 0000000..8ec1c7f
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
@@ -0,0 +1,28 @@
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class SimpleMergeTest extends RepositoryTestCase {
+
+	public void testTrivialTwoWay_noway() throws IOException {
+		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
+		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a"), db.resolve("c") });
+		assertFalse(merge);
+	}
+
+	public void testTrivialTwoWay_disjointhistories() throws IOException {
+		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
+		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a"), db.resolve("c~4") });
+		assertTrue(merge); 
+	}
+
+	public void testTrivialTwoWay_ok() throws IOException {
+		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
+		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a^0^0^0"), db.resolve("a^0^0^1") });
+		assertTrue(merge);
+		assertEquals(db.mapTree("a^0^0").getId(), ourMerger.getResultTreeId());
+	}
+}
-- 
1.6.0.2.308.gef4a
