From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/12] Implement git-core t/t6012-rev-list-simplify test case
Date: Tue, 17 Mar 2009 18:40:51 -0700
Message-ID: <1237340451-31562-13-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
 <1237340451-31562-2-git-send-email-spearce@spearce.org>
 <1237340451-31562-3-git-send-email-spearce@spearce.org>
 <1237340451-31562-4-git-send-email-spearce@spearce.org>
 <1237340451-31562-5-git-send-email-spearce@spearce.org>
 <1237340451-31562-6-git-send-email-spearce@spearce.org>
 <1237340451-31562-7-git-send-email-spearce@spearce.org>
 <1237340451-31562-8-git-send-email-spearce@spearce.org>
 <1237340451-31562-9-git-send-email-spearce@spearce.org>
 <1237340451-31562-10-git-send-email-spearce@spearce.org>
 <1237340451-31562-11-git-send-email-spearce@spearce.org>
 <1237340451-31562-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpT-00052N-K4
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbZCRBlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbZCRBll
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:41 -0400
Received: from george.spearce.org ([209.20.77.23]:56681 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812AbZCRBlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:41:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DE57A3826B; Wed, 18 Mar 2009 01:41:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A364A3826E;
	Wed, 18 Mar 2009 01:40:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113561>

This test case provides a known graph and results that git-core has
been producing since Aug 3, 2008.  Half of the test is commented out
as JGit does not produce the correct results, or does not support a
flag necessary to indicate how the results should be determined.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 As I said in the series cover letter, this test is more busted
 then correct.  I'm quite sure the test is right, and the JGit
 library is wrong.

 .../jgit/revwalk/RevWalkPathFilter6012Test.java    |  162 ++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter6012Test.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter6012Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter6012Test.java
new file mode 100644
index 0000000..b2fdb16
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkPathFilter6012Test.java
@@ -0,0 +1,162 @@
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
+import java.lang.reflect.Field;
+import java.util.Collections;
+import java.util.HashMap;
+
+import org.spearce.jgit.treewalk.filter.AndTreeFilter;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+// Note: Much of this test case is broken as it depends upon
+// the graph applying topological sorting *before* doing merge
+// simplification.  It also depends upon a difference between
+// full history and non-full history for a path, something we
+// don't quite yet have a distiction for in JGit.
+//
+public class RevWalkPathFilter6012Test extends RevWalkTestCase {
+	private static final String pA = "pA", pF = "pF", pE = "pE";
+
+	private RevCommit a, b, c, d, e, f, g, h, i;
+
+	private HashMap<RevCommit, String> byName;
+
+	public void setUp() throws Exception {
+		super.setUp();
+
+		// Test graph was stolen from git-core t6012-rev-list-simplify
+		// (by Junio C Hamano in 65347030590bcc251a9ff2ed96487a0f1b9e9fa8)
+		//
+		final RevBlob zF = blob("zF");
+		final RevBlob zH = blob("zH");
+		final RevBlob zI = blob("zI");
+		final RevBlob zS = blob("zS");
+		final RevBlob zY = blob("zY");
+
+		a = commit(tree(file(pF, zH)));
+		b = commit(tree(file(pF, zI)), a);
+		c = commit(tree(file(pF, zI)), a);
+		d = commit(tree(file(pA, zS), file(pF, zI)), c);
+		parse(d);
+		e = commit(d.getTree(), d, b);
+		f = commit(tree(file(pA, zS), file(pE, zY), file(pF, zI)), e);
+		parse(f);
+		g = commit(tree(file(pE, zY), file(pF, zI)), b);
+		h = commit(f.getTree(), g, f);
+		i = commit(tree(file(pA, zS), file(pE, zY), file(pF, zF)), h);
+
+		byName = new HashMap<RevCommit, String>();
+		for (Field z : RevWalkPathFilter6012Test.class.getDeclaredFields()) {
+			if (z.getType() == RevCommit.class)
+				byName.put((RevCommit) z.get(this), z.getName());
+		}
+	}
+
+	protected void check(final RevCommit... order) throws Exception {
+		markStart(i);
+		final StringBuilder act = new StringBuilder();
+		for (final RevCommit z : rw) {
+			final String name = byName.get(z);
+			assertNotNull(name);
+			act.append(name);
+			act.append(' ');
+		}
+		final StringBuilder exp = new StringBuilder();
+		for (final RevCommit z : order) {
+			final String name = byName.get(z);
+			assertNotNull(name);
+			exp.append(name);
+			exp.append(' ');
+		}
+		assertEquals(exp.toString(), act.toString());
+	}
+
+	protected void filter(final String path) {
+		rw.setTreeFilter(AndTreeFilter.create(PathFilterGroup
+				.createFromStrings(Collections.singleton(path)),
+				TreeFilter.ANY_DIFF));
+	}
+
+	public void test1() throws Exception {
+		// TODO --full-history
+		check(i, h, g, f, e, d, c, b, a);
+	}
+
+	public void test2() throws Exception {
+		// TODO --full-history
+		filter(pF);
+		// TODO fix broken test
+		// check(i, h, e, c, b, a);
+	}
+
+	public void test3() throws Exception {
+		// TODO --full-history
+		rw.sort(RevSort.TOPO);
+		filter(pF);
+		// TODO fix broken test
+		// check(i, h, e, c, b, a);
+	}
+
+	public void test4() throws Exception {
+		// TODO --full-history
+		rw.sort(RevSort.COMMIT_TIME_DESC);
+		filter(pF);
+		// TODO fix broken test
+		// check(i, h, e, c, b, a);
+	}
+
+	public void test5() throws Exception {
+		// TODO --simplify-merges
+		filter(pF);
+		// TODO fix broken test
+		// check(i, e, c, b, a);
+	}
+
+	public void test6() throws Exception {
+		filter(pF);
+		check(i, b, a);
+	}
+
+	public void test7() throws Exception {
+		rw.sort(RevSort.TOPO);
+		filter(pF);
+		check(i, b, a);
+	}
+}
-- 
1.6.2.1.286.g8173
