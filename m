From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 14/14] Add test case for NameConflictTreeWalk
Date: Mon, 18 Aug 2008 16:53:22 -0700
Message-ID: <1219103602-32222-15-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
 <1219103602-32222-3-git-send-email-spearce@spearce.org>
 <1219103602-32222-4-git-send-email-spearce@spearce.org>
 <1219103602-32222-5-git-send-email-spearce@spearce.org>
 <1219103602-32222-6-git-send-email-spearce@spearce.org>
 <1219103602-32222-7-git-send-email-spearce@spearce.org>
 <1219103602-32222-8-git-send-email-spearce@spearce.org>
 <1219103602-32222-9-git-send-email-spearce@spearce.org>
 <1219103602-32222-10-git-send-email-spearce@spearce.org>
 <1219103602-32222-11-git-send-email-spearce@spearce.org>
 <1219103602-32222-12-git-send-email-spearce@spearce.org>
 <1219103602-32222-13-git-send-email-spearce@spearce.org>
 <1219103602-32222-14-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZA-0006i3-3K
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbYHRXxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbYHRXxx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:53 -0400
Received: from george.spearce.org ([209.20.77.23]:45168 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbYHRXxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1AC8538378; Mon, 18 Aug 2008 23:53:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B03ED3837A;
	Mon, 18 Aug 2008 23:53:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-14-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92779>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/treewalk/NameConflictTreeWalkTest.java    |  205 ++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/NameConflictTreeWalkTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/NameConflictTreeWalkTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/NameConflictTreeWalkTest.java
new file mode 100644
index 0000000..8ab7f93
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/NameConflictTreeWalkTest.java
@@ -0,0 +1,205 @@
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
+import java.io.ByteArrayInputStream;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.dircache.DirCacheIterator;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class NameConflictTreeWalkTest extends RepositoryTestCase {
+	private static final FileMode TREE = FileMode.TREE;
+
+	private static final FileMode SYMLINK = FileMode.SYMLINK;
+
+	private static final FileMode MISSING = FileMode.MISSING;
+
+	private static final FileMode REGULAR_FILE = FileMode.REGULAR_FILE;
+
+	private static final FileMode EXECUTABLE_FILE = FileMode.EXECUTABLE_FILE;
+
+	public void testNoDF_NoGap() throws Exception {
+		final DirCache tree0 = DirCache.read(db);
+		final DirCache tree1 = DirCache.read(db);
+		{
+			final DirCacheBuilder b0 = tree0.builder();
+			final DirCacheBuilder b1 = tree1.builder();
+
+			b0.add(makeEntry("a", REGULAR_FILE));
+			b0.add(makeEntry("a.b", EXECUTABLE_FILE));
+			b1.add(makeEntry("a/b", REGULAR_FILE));
+			b0.add(makeEntry("a0b", SYMLINK));
+
+			b0.finish();
+			b1.finish();
+			assertEquals(3, tree0.getEntryCount());
+			assertEquals(1, tree1.getEntryCount());
+		}
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(tree0));
+		tw.addTree(new DirCacheIterator(tree1));
+
+		assertModes("a", REGULAR_FILE, MISSING, tw);
+		assertModes("a.b", EXECUTABLE_FILE, MISSING, tw);
+		assertModes("a", MISSING, TREE, tw);
+		tw.enterSubtree();
+		assertModes("a/b", MISSING, REGULAR_FILE, tw);
+		assertModes("a0b", SYMLINK, MISSING, tw);
+	}
+
+	public void testDF_NoGap() throws Exception {
+		final DirCache tree0 = DirCache.read(db);
+		final DirCache tree1 = DirCache.read(db);
+		{
+			final DirCacheBuilder b0 = tree0.builder();
+			final DirCacheBuilder b1 = tree1.builder();
+
+			b0.add(makeEntry("a", REGULAR_FILE));
+			b0.add(makeEntry("a.b", EXECUTABLE_FILE));
+			b1.add(makeEntry("a/b", REGULAR_FILE));
+			b0.add(makeEntry("a0b", SYMLINK));
+
+			b0.finish();
+			b1.finish();
+			assertEquals(3, tree0.getEntryCount());
+			assertEquals(1, tree1.getEntryCount());
+		}
+
+		final NameConflictTreeWalk tw = new NameConflictTreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(tree0));
+		tw.addTree(new DirCacheIterator(tree1));
+
+		assertModes("a", REGULAR_FILE, TREE, tw);
+		assertTrue(tw.isSubtree());
+		tw.enterSubtree();
+		assertModes("a/b", MISSING, REGULAR_FILE, tw);
+		assertModes("a.b", EXECUTABLE_FILE, MISSING, tw);
+		assertModes("a0b", SYMLINK, MISSING, tw);
+	}
+
+	public void testDF_GapByOne() throws Exception {
+		final DirCache tree0 = DirCache.read(db);
+		final DirCache tree1 = DirCache.read(db);
+		{
+			final DirCacheBuilder b0 = tree0.builder();
+			final DirCacheBuilder b1 = tree1.builder();
+
+			b0.add(makeEntry("a", REGULAR_FILE));
+			b0.add(makeEntry("a.b", EXECUTABLE_FILE));
+			b1.add(makeEntry("a.b", EXECUTABLE_FILE));
+			b1.add(makeEntry("a/b", REGULAR_FILE));
+			b0.add(makeEntry("a0b", SYMLINK));
+
+			b0.finish();
+			b1.finish();
+			assertEquals(3, tree0.getEntryCount());
+			assertEquals(2, tree1.getEntryCount());
+		}
+
+		final NameConflictTreeWalk tw = new NameConflictTreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(tree0));
+		tw.addTree(new DirCacheIterator(tree1));
+
+		assertModes("a", REGULAR_FILE, TREE, tw);
+		assertTrue(tw.isSubtree());
+		tw.enterSubtree();
+		assertModes("a/b", MISSING, REGULAR_FILE, tw);
+		assertModes("a.b", EXECUTABLE_FILE, EXECUTABLE_FILE, tw);
+		assertModes("a0b", SYMLINK, MISSING, tw);
+	}
+
+	public void testDF_SkipsSeenSubtree() throws Exception {
+		final DirCache tree0 = DirCache.read(db);
+		final DirCache tree1 = DirCache.read(db);
+		{
+			final DirCacheBuilder b0 = tree0.builder();
+			final DirCacheBuilder b1 = tree1.builder();
+
+			b0.add(makeEntry("a", REGULAR_FILE));
+			b1.add(makeEntry("a.b", EXECUTABLE_FILE));
+			b1.add(makeEntry("a/b", REGULAR_FILE));
+			b0.add(makeEntry("a0b", SYMLINK));
+			b1.add(makeEntry("a0b", SYMLINK));
+
+			b0.finish();
+			b1.finish();
+			assertEquals(2, tree0.getEntryCount());
+			assertEquals(3, tree1.getEntryCount());
+		}
+
+		final NameConflictTreeWalk tw = new NameConflictTreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(tree0));
+		tw.addTree(new DirCacheIterator(tree1));
+
+		assertModes("a", REGULAR_FILE, TREE, tw);
+		assertTrue(tw.isSubtree());
+		tw.enterSubtree();
+		assertModes("a/b", MISSING, REGULAR_FILE, tw);
+		assertModes("a.b", MISSING, EXECUTABLE_FILE, tw);
+		assertModes("a0b", SYMLINK, SYMLINK, tw);
+	}
+
+	private DirCacheEntry makeEntry(final String path, final FileMode mode)
+			throws Exception {
+		final byte[] pathBytes = Constants.encode(path);
+		final DirCacheEntry ent = new DirCacheEntry(path);
+		ent.setFileMode(mode);
+		ent.setObjectId(new ObjectWriter(db).computeBlobSha1(pathBytes.length,
+				new ByteArrayInputStream(pathBytes)));
+		return ent;
+	}
+
+	private static void assertModes(final String path, final FileMode mode0,
+			final FileMode mode1, final TreeWalk tw) throws Exception {
+		assertTrue("has " + path, tw.next());
+		assertEquals(path, tw.getPathString());
+		assertEquals(mode0, tw.getFileMode(0));
+		assertEquals(mode1, tw.getFileMode(1));
+	}
+}
-- 
1.6.0.87.g2858d
