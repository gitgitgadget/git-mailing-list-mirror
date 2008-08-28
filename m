From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] JUnit test for EmptyTreeIterator
Date: Thu, 28 Aug 2008 08:27:42 -0700
Message-ID: <1219937266-24903-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQb-0003J4-Gz
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYH1P1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYH1P1t
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:49 -0400
Received: from george.spearce.org ([209.20.77.23]:51093 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYH1P1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BD1F038379; Thu, 28 Aug 2008 15:27:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D362438360;
	Thu, 28 Aug 2008 15:27:46 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94070>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/EmptyTreeIteratorTest.java       |  106 ++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/EmptyTreeIteratorTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/EmptyTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/EmptyTreeIteratorTest.java
new file mode 100644
index 0000000..2cf5eca
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/EmptyTreeIteratorTest.java
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.treewalk;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class EmptyTreeIteratorTest extends RepositoryTestCase {
+	public void testAtEOF() throws Exception {
+		final EmptyTreeIterator etp = new EmptyTreeIterator();
+		assertTrue(etp.first());
+		assertTrue(etp.eof());
+	}
+
+	public void testCreateSubtreeIterator() throws Exception {
+		final EmptyTreeIterator etp = new EmptyTreeIterator();
+		final AbstractTreeIterator sub = etp.createSubtreeIterator(db);
+		assertNotNull(sub);
+		assertTrue(sub.first());
+		assertTrue(sub.eof());
+		assertTrue(sub instanceof EmptyTreeIterator);
+	}
+
+	public void testEntryObjectId() throws Exception {
+		final EmptyTreeIterator etp = new EmptyTreeIterator();
+		assertSame(ObjectId.zeroId(), etp.getEntryObjectId());
+		assertNotNull(etp.idBuffer());
+		assertEquals(0, etp.idOffset());
+		assertEquals(ObjectId.zeroId(), ObjectId.fromRaw(etp.idBuffer()));
+	}
+
+	public void testNextDoesNothing() throws Exception {
+		final EmptyTreeIterator etp = new EmptyTreeIterator();
+		etp.next(1);
+		assertTrue(etp.first());
+		assertTrue(etp.eof());
+		assertEquals(ObjectId.zeroId(), ObjectId.fromRaw(etp.idBuffer()));
+
+		etp.next(1);
+		assertTrue(etp.first());
+		assertTrue(etp.eof());
+		assertEquals(ObjectId.zeroId(), ObjectId.fromRaw(etp.idBuffer()));
+	}
+
+	public void testBackDoesNothing() throws Exception {
+		final EmptyTreeIterator etp = new EmptyTreeIterator();
+		etp.back(1);
+		assertTrue(etp.first());
+		assertTrue(etp.eof());
+		assertEquals(ObjectId.zeroId(), ObjectId.fromRaw(etp.idBuffer()));
+
+		etp.back(1);
+		assertTrue(etp.first());
+		assertTrue(etp.eof());
+		assertEquals(ObjectId.zeroId(), ObjectId.fromRaw(etp.idBuffer()));
+	}
+
+	public void testStopWalkCallsParent() throws Exception {
+		final boolean called[] = new boolean[1];
+		assertFalse(called[0]);
+
+		final EmptyTreeIterator parent = new EmptyTreeIterator() {
+			@Override
+			public void stopWalk() {
+				called[0] = true;
+			}
+		};
+		parent.createSubtreeIterator(db).stopWalk();
+		assertTrue(called[0]);
+	}
+}
-- 
1.6.0.174.gd789c
