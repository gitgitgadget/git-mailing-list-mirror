From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] JUnit tests for some TreeFilter implementations
Date: Thu, 28 Aug 2008 08:27:43 -0700
Message-ID: <1219937266-24903-2-git-send-email-spearce@spearce.org>
References: <1219937266-24903-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQc-0003J4-5y
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbYH1P1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbYH1P1v
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:51 -0400
Received: from george.spearce.org ([209.20.77.23]:51097 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYH1P1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 917553837B; Thu, 28 Aug 2008 15:27:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2A2B438375;
	Thu, 28 Aug 2008 15:27:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219937266-24903-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94072>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../treewalk/filter/AlwaysCloneTreeFilter.java     |   57 +++++++++++++
 .../jgit/treewalk/filter/NotTreeFilterTest.java    |   85 ++++++++++++++++++++
 .../jgit/treewalk/filter/TreeFilterTest.java       |   74 +++++++++++++++++
 .../jgit/treewalk/filter/NotTreeFilter.java        |    3 +-
 4 files changed, 218 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/AlwaysCloneTreeFilter.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/NotTreeFilterTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/TreeFilterTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/AlwaysCloneTreeFilter.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/AlwaysCloneTreeFilter.java
new file mode 100644
index 0000000..054f081
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/AlwaysCloneTreeFilter.java
@@ -0,0 +1,57 @@
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
+package org.spearce.jgit.treewalk.filter;
+
+import org.spearce.jgit.treewalk.TreeWalk;
+
+class AlwaysCloneTreeFilter extends TreeFilter {
+	@Override
+	public TreeFilter clone() {
+		return new AlwaysCloneTreeFilter();
+	}
+
+	@Override
+	public boolean include(final TreeWalk walker) {
+		return false;
+	}
+
+	@Override
+	public boolean shouldBeRecursive() {
+		return false;
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/NotTreeFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/NotTreeFilterTest.java
new file mode 100644
index 0000000..7749a51
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/NotTreeFilterTest.java
@@ -0,0 +1,85 @@
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
+package org.spearce.jgit.treewalk.filter;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+public class NotTreeFilterTest extends RepositoryTestCase {
+	public void testWrap() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		final TreeFilter a = TreeFilter.ALL;
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertNotNull(n);
+		assertTrue(a.include(tw));
+		assertFalse(n.include(tw));
+	}
+
+	public void testNegateIsUnwrap() throws Exception {
+		final TreeFilter a = PathFilter.create("a/b");
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertSame(a, n.negate());
+	}
+
+	public void testShouldBeRecursive_ALL() throws Exception {
+		final TreeFilter a = TreeFilter.ALL;
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertEquals(a.shouldBeRecursive(), n.shouldBeRecursive());
+	}
+
+	public void testShouldBeRecursive_PathFilter() throws Exception {
+		final TreeFilter a = PathFilter.create("a/b");
+		assertTrue(a.shouldBeRecursive());
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertTrue(n.shouldBeRecursive());
+	}
+
+	public void testCloneIsDeepClone() throws Exception {
+		final TreeFilter a = new AlwaysCloneTreeFilter();
+		assertNotSame(a, a.clone());
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertNotSame(n, n.clone());
+	}
+
+	public void testCloneIsSparseWhenPossible() throws Exception {
+		final TreeFilter a = TreeFilter.ALL;
+		assertSame(a, a.clone());
+		final TreeFilter n = NotTreeFilter.create(a);
+		assertSame(n, n.clone());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/TreeFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/TreeFilterTest.java
new file mode 100644
index 0000000..a8643bd
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/TreeFilterTest.java
@@ -0,0 +1,74 @@
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
+package org.spearce.jgit.treewalk.filter;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+public class TreeFilterTest extends RepositoryTestCase {
+	public void testALL_IncludesAnything() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		assertTrue(TreeFilter.ALL.include(tw));
+	}
+
+	public void testALL_ShouldNotBeRecursive() throws Exception {
+		assertFalse(TreeFilter.ALL.shouldBeRecursive());
+	}
+
+	public void testALL_IdentityClone() throws Exception {
+		assertSame(TreeFilter.ALL, TreeFilter.ALL.clone());
+	}
+
+	public void testNotALL_IncludesNothing() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		assertFalse(TreeFilter.ALL.negate().include(tw));
+	}
+
+	public void testANY_DIFF_IncludesSingleTreeCase() throws Exception {
+		final TreeWalk tw = new TreeWalk(db);
+		assertTrue(TreeFilter.ANY_DIFF.include(tw));
+	}
+
+	public void testANY_DIFF_ShouldNotBeRecursive() throws Exception {
+		assertFalse(TreeFilter.ANY_DIFF.shouldBeRecursive());
+	}
+
+	public void testANY_DIFF_IdentityClone() throws Exception {
+		assertSame(TreeFilter.ANY_DIFF, TreeFilter.ANY_DIFF.clone());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/NotTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/NotTreeFilter.java
index 86ae82d..37d655e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/NotTreeFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/NotTreeFilter.java
@@ -81,7 +81,8 @@ public boolean shouldBeRecursive() {
 
 	@Override
 	public TreeFilter clone() {
-		return new NotTreeFilter(a.clone());
+		final TreeFilter n = a.clone();
+		return n == a ? this : new NotTreeFilter(n);
 	}
 
 	@Override
-- 
1.6.0.174.gd789c
