From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/7] Add tests for RawParseUtil's hex string parsing
Date: Thu,  4 Jun 2009 14:44:00 -0700
Message-ID: <1244151843-26954-5-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
 <1244151843-26954-3-git-send-email-spearce@spearce.org>
 <1244151843-26954-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkI-0001OL-AA
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbZFDVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZFDVoO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:14 -0400
Received: from george.spearce.org ([209.20.77.23]:35371 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbZFDVoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8D620381FE; Thu,  4 Jun 2009 21:44:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CF5E438200;
	Thu,  4 Jun 2009 21:44:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120720>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/util/RawParseUtils_HexParseTest.java      |  158 ++++++++++++++++++++
 1 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_HexParseTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_HexParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_HexParseTest.java
new file mode 100644
index 0000000..0f0ddde
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/RawParseUtils_HexParseTest.java
@@ -0,0 +1,158 @@
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
+package org.spearce.jgit.util;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+
+public class RawParseUtils_HexParseTest extends TestCase {
+	public void testInt4_1() {
+		assertEquals(0, RawParseUtils.parseHexInt4((byte) '0'));
+		assertEquals(1, RawParseUtils.parseHexInt4((byte) '1'));
+		assertEquals(2, RawParseUtils.parseHexInt4((byte) '2'));
+		assertEquals(3, RawParseUtils.parseHexInt4((byte) '3'));
+		assertEquals(4, RawParseUtils.parseHexInt4((byte) '4'));
+		assertEquals(5, RawParseUtils.parseHexInt4((byte) '5'));
+		assertEquals(6, RawParseUtils.parseHexInt4((byte) '6'));
+		assertEquals(7, RawParseUtils.parseHexInt4((byte) '7'));
+		assertEquals(8, RawParseUtils.parseHexInt4((byte) '8'));
+		assertEquals(9, RawParseUtils.parseHexInt4((byte) '9'));
+		assertEquals(10, RawParseUtils.parseHexInt4((byte) 'a'));
+		assertEquals(11, RawParseUtils.parseHexInt4((byte) 'b'));
+		assertEquals(12, RawParseUtils.parseHexInt4((byte) 'c'));
+		assertEquals(13, RawParseUtils.parseHexInt4((byte) 'd'));
+		assertEquals(14, RawParseUtils.parseHexInt4((byte) 'e'));
+		assertEquals(15, RawParseUtils.parseHexInt4((byte) 'f'));
+
+		assertEquals(10, RawParseUtils.parseHexInt4((byte) 'A'));
+		assertEquals(11, RawParseUtils.parseHexInt4((byte) 'B'));
+		assertEquals(12, RawParseUtils.parseHexInt4((byte) 'C'));
+		assertEquals(13, RawParseUtils.parseHexInt4((byte) 'D'));
+		assertEquals(14, RawParseUtils.parseHexInt4((byte) 'E'));
+		assertEquals(15, RawParseUtils.parseHexInt4((byte) 'F'));
+
+		assertNotHex('q');
+		assertNotHex(' ');
+		assertNotHex('.');
+	}
+
+	private static void assertNotHex(final char c) {
+		try {
+			RawParseUtils.parseHexInt4((byte) c);
+			fail("Incorrectly acccepted " + c);
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+	}
+
+	public void testInt16() {
+		assertEquals(0x0000, parse16("0000"));
+		assertEquals(0x0001, parse16("0001"));
+		assertEquals(0x1234, parse16("1234"));
+		assertEquals(0xdead, parse16("dead"));
+		assertEquals(0xBEEF, parse16("BEEF"));
+		assertEquals(0x4321, parse16("4321"));
+		assertEquals(0xffff, parse16("ffff"));
+
+		try {
+			parse16("noth");
+			fail("Incorrectly acccepted \"noth\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+
+		try {
+			parse16("01");
+			fail("Incorrectly acccepted \"01\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+
+		try {
+			parse16("000.");
+			fail("Incorrectly acccepted \"000.\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+	}
+
+	private static int parse16(final String str) {
+		return RawParseUtils.parseHexInt16(Constants.encodeASCII(str), 0);
+	}
+
+	public void testInt32() {
+		assertEquals(0x00000000, parse32("00000000"));
+		assertEquals(0x00000001, parse32("00000001"));
+		assertEquals(0xc0ffEE42, parse32("c0ffEE42"));
+		assertEquals(0xffffffff, parse32("ffffffff"));
+		assertEquals(-1, parse32("ffffffff"));
+
+		try {
+			parse32("noth");
+			fail("Incorrectly acccepted \"noth\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+
+		try {
+			parse32("notahexs");
+			fail("Incorrectly acccepted \"notahexs\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+
+		try {
+			parse32("01");
+			fail("Incorrectly acccepted \"01\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+
+		try {
+			parse32("0000000.");
+			fail("Incorrectly acccepted \"0000000.\"");
+		} catch (ArrayIndexOutOfBoundsException e) {
+			// pass
+		}
+	}
+
+	private static int parse32(final String str) {
+		return RawParseUtils.parseHexInt32(Constants.encodeASCII(str), 0);
+	}
+}
-- 
1.6.3.1.333.g3ebba7
