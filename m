From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/12] Add unit tests for AbstractRevQueue.EMPTY_QUEUE
Date: Tue, 17 Mar 2009 18:40:47 -0700
Message-ID: <1237340451-31562-9-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
 <1237340451-31562-7-git-send-email-spearce@spearce.org>
 <1237340451-31562-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpQ-00052N-8A
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810AbZCRBl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbZCRBl3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:29 -0400
Received: from george.spearce.org ([209.20.77.23]:56671 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbZCRBlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5A10D38239; Wed, 18 Mar 2009 01:41:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 41CA338267;
	Wed, 18 Mar 2009 01:40:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113563>

Also fix anybodyHasFlag() to return false, as the queue is empty,
and thus nobody has that flag.  This matches the behavior of the
other queue types.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/revwalk/AlwaysEmptyRevQueueTest.java      |   63 ++++++++++++++++++++
 .../org/spearce/jgit/revwalk/AbstractRevQueue.java |    2 +-
 2 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/AlwaysEmptyRevQueueTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/AlwaysEmptyRevQueueTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/AlwaysEmptyRevQueueTest.java
new file mode 100644
index 0000000..94edd0a
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/AlwaysEmptyRevQueueTest.java
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.revwalk;
+
+public class AlwaysEmptyRevQueueTest extends RevWalkTestCase {
+	private final AbstractRevQueue q = AbstractRevQueue.EMPTY_QUEUE;
+
+	public void testEmpty() throws Exception {
+		assertNull(q.next());
+		assertTrue(q.everbodyHasFlag(RevWalk.UNINTERESTING));
+		assertFalse(q.anybodyHasFlag(RevWalk.UNINTERESTING));
+		assertEquals(0, q.outputType());
+	}
+
+	public void testClear() throws Exception {
+		q.clear();
+		testEmpty();
+	}
+
+	public void testAddFails() throws Exception {
+		try {
+			q.add(commit());
+			fail("Did not throw UnsupportedOperationException");
+		} catch (UnsupportedOperationException e) {
+			// expected result
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
index 5bb969d..9a6bf81 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/AbstractRevQueue.java
@@ -133,7 +133,7 @@ public RevCommit next() {
 
 		@Override
 		boolean anybodyHasFlag(int f) {
-			return true;
+			return false;
 		}
 
 		@Override
-- 
1.6.2.1.286.g8173
