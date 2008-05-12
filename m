From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 16/24] Added test class OverallIgnoreRulestest.
Date: Mon, 12 May 2008 22:13:34 +0200
Message-ID: <1210623222-24908-17-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSh-00086f-By
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbYELUO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:28 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbYELUO0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:26 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:51240 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757610AbYELUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:54 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id EDC87DA8112D
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:52 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP6-00016x-01; Mon, 12 May 2008 22:13:48 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+mn8zKzP1GyIg/zIUDPgjq5PTkTNKbmWFES56w
	BEuCYcMlkp9ktX25FaSHziv1Fad9Nslg+jlRUAn2U6UWQIqLPw
	qqvUBg8s1zhy2oDb/LVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81938>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/OverallIgnoreRulesTest.java     |  371 ++++++++++++=
++++++++
 1 files changed, 371 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/rules/OverallIgnoreRulesTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/=
OverallIgnoreRulesTest.java b/org.spearce.jgit.test/tst/org/spearce/jgi=
t/treewalk/rules/OverallIgnoreRulesTest.java
new file mode 100644
index 0000000..60e1bdc
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/Overall=
IgnoreRulesTest.java
@@ -0,0 +1,371 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk.rules;
+
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
+import junit.framework.TestCase;
+
+public class OverallIgnoreRulesTest extends TestCase {
+	private IgnoreRulesFactory factory;
+
+	@Override
+	protected void setUp() throws Exception {
+		factory =3D new IgnoreRulesFactory();
+	}
+
+	public void testSimpleGlobalPattern() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("ab");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.toIgnore("ab", false));
+		assertTrue(ignoreRules.toIgnore("ab", true));
+		assertFalse(ignoreRules.toIgnore("abc", false));
+		assertFalse(ignoreRules.toIgnore("abc", true));
+	}
+
+	public void testGlobalPatternWithOneStar() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a*c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.toIgnore("ac", false));
+		assertTrue(ignoreRules.toIgnore("ac", true));
+
+		assertTrue(ignoreRules.toIgnore("abc", false));
+		assertTrue(ignoreRules.toIgnore("abc", true));
+
+		assertTrue(ignoreRules.toIgnore("abbc", false));
+		assertTrue(ignoreRules.toIgnore("abbc", true));
+
+		assertTrue(ignoreRules.toIgnore("aabc", false));
+		assertTrue(ignoreRules.toIgnore("aabc", true));
+
+		assertFalse(ignoreRules.toIgnore("cab", false));
+		assertFalse(ignoreRules.toIgnore("cab", true));
+	}
+
+	public void testGlobalPatternWithTwoStars() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a*c*e");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.toIgnore("ace", false));
+		assertTrue(ignoreRules.toIgnore("ace", true));
+
+		assertTrue(ignoreRules.toIgnore("abcde", false));
+		assertTrue(ignoreRules.toIgnore("abcde", true));
+
+		assertTrue(ignoreRules.toIgnore("aHellocWorlde", false));
+		assertTrue(ignoreRules.toIgnore("aHellocWorlde", true));
+
+		assertFalse(ignoreRules.toIgnore("ae", false));
+		assertFalse(ignoreRules.toIgnore("ae", true));
+	}
+
+	public void testGlobalPatternWithDots() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("*.tar.gz");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.toIgnore("test.tar.gz", false));
+		assertTrue(ignoreRules.toIgnore("test.tar.gz", true));
+
+		assertTrue(ignoreRules.toIgnore(".tar.gz", false));
+		assertTrue(ignoreRules.toIgnore(".tar.gz", true));
+
+		assertFalse(ignoreRules.toIgnore("test", false));
+		assertFalse(ignoreRules.toIgnore("test", true));
+
+		// test that "." isn't handled as "any character"
+		assertFalse(ignoreRules.toIgnore(".tarogz", false));
+		assertFalse(ignoreRules.toIgnore(".tarogz", true));
+	}
+
+	public void testGlobalPatternDirectoryOnlyRule() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.toIgnore("a", true));
+		assertFalse(ignoreRules.toIgnore("a", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertSame(Rules.IGNORE_ALL, ignoreRulesA);
+
+		final Rules ignoreRulesB =3D ignoreRules.getRulesForSubDirectory("b"=
);
+		assertTrue(ignoreRulesB.toIgnore("a", true));
+		assertFalse(ignoreRulesB.toIgnore("a", false));
+
+		final Rules ignoreRulesBA =3D ignoreRulesB.getRulesForSubDirectory("=
a");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesBA);
+
+	}
+
+	public void testSimpleFilePathPattern() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/b/c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertFalse(ignoreRules.toIgnore("a", true));
+		assertFalse(ignoreRules.toIgnore("a", false));
+		assertFalse(ignoreRules.toIgnore("b", true));
+		assertFalse(ignoreRules.toIgnore("b", false));
+		assertFalse(ignoreRules.toIgnore("c", true));
+		assertFalse(ignoreRules.toIgnore("c", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertFalse(ignoreRulesA.toIgnore("a", true));
+		assertFalse(ignoreRulesA.toIgnore("a", false));
+		assertFalse(ignoreRulesA.toIgnore("b", true));
+		assertFalse(ignoreRulesA.toIgnore("b", false));
+		assertFalse(ignoreRulesA.toIgnore("c", true));
+		assertFalse(ignoreRulesA.toIgnore("c", false));
+
+		final Rules ignoreRulesAB =3D ignoreRulesA.getRulesForSubDirectory("=
b");
+		assertFalse(ignoreRulesAB.toIgnore("a", true));
+		assertFalse(ignoreRulesAB.toIgnore("a", false));
+		assertFalse(ignoreRulesAB.toIgnore("b", true));
+		assertFalse(ignoreRulesAB.toIgnore("b", false));
+		assertTrue(ignoreRulesAB.toIgnore("c", true));
+		assertTrue(ignoreRulesAB.toIgnore("c", false));
+
+		final Rules ignoreRulesABA =3D ignoreRulesAB.getRulesForSubDirectory=
("a");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesABA);
+
+		final Rules ignoreRulesABB =3D ignoreRulesAB.getRulesForSubDirectory=
("b");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesABB);
+
+		final Rules ignoreRulesABC =3D ignoreRulesAB.getRulesForSubDirectory=
("c");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesABC);
+	}
+
+	public void testFilePathPatternDirectoryOnlyRule() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/b/c/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertFalse(ignoreRules.toIgnore("a", true));
+		assertFalse(ignoreRules.toIgnore("a", false));
+		assertFalse(ignoreRules.toIgnore("b", true));
+		assertFalse(ignoreRules.toIgnore("b", false));
+		assertFalse(ignoreRules.toIgnore("c", true));
+		assertFalse(ignoreRules.toIgnore("c", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertFalse(ignoreRulesA.toIgnore("a", true));
+		assertFalse(ignoreRulesA.toIgnore("a", false));
+		assertFalse(ignoreRulesA.toIgnore("b", true));
+		assertFalse(ignoreRulesA.toIgnore("b", false));
+		assertFalse(ignoreRulesA.toIgnore("c", true));
+		assertFalse(ignoreRulesA.toIgnore("c", false));
+
+		final Rules ignoreRulesAB =3D ignoreRulesA.getRulesForSubDirectory("=
b");
+		assertFalse(ignoreRulesAB.toIgnore("a", true));
+		assertFalse(ignoreRulesAB.toIgnore("a", false));
+		assertFalse(ignoreRulesAB.toIgnore("b", true));
+		assertFalse(ignoreRulesAB.toIgnore("b", false));
+		assertTrue(ignoreRulesAB.toIgnore("c", true));
+		assertFalse(ignoreRulesAB.toIgnore("c", false));
+
+		final Rules ignoreRulesABA =3D ignoreRulesAB.getRulesForSubDirectory=
("a");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesABA);
+
+		final Rules ignoreRulesABB =3D ignoreRulesAB.getRulesForSubDirectory=
("b");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesABB);
+
+		final Rules ignoreRulesABC =3D ignoreRulesAB.getRulesForSubDirectory=
("c");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesABC);
+	}
+
+	public void testShortPathPattern() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/alpha");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.toIgnore("alpha", true));
+		assertTrue(ignoreRules.toIgnore("alpha", false));
+
+		final Rules ignoreRulesAlpha =3D ignoreRules
+				.getRulesForSubDirectory("alpha");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesAlpha);
+
+		final Rules ignoreRulesBeta =3D ignoreRules
+				.getRulesForSubDirectory("beta");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesBeta);
+	}
+
+	public void testShortDirectoryPathPattern() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/alpha/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.toIgnore("alpha", true));
+		assertFalse(ignoreRules.toIgnore("alpha", false));
+
+		final Rules ignoreRulesAlpha =3D ignoreRules
+				.getRulesForSubDirectory("alpha");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesAlpha);
+
+		final Rules ignoreRulesBeta =3D ignoreRules
+				.getRulesForSubDirectory("beta");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesBeta);
+	}
+
+	public void testShortPathPatternWithStar() {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/.*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.toIgnore(".test", true));
+		assertTrue(ignoreRules.toIgnore(".test", false));
+
+		assertFalse(ignoreRules.toIgnore("test", true));
+		assertFalse(ignoreRules.toIgnore("test", false));
+
+		final Rules ignoreRulesDotTest =3D ignoreRules
+				.getRulesForSubDirectory(".test");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesDotTest);
+
+		final Rules ignoreRulesTest =3D ignoreRules
+				.getRulesForSubDirectory("test");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesTest);
+	}
+
+	public void testPathPatternWith2Times2Stars() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("he*wor*d/*.*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertFalse(ignoreRules.toIgnore("hello", true));
+		assertFalse(ignoreRules.toIgnore("hello", false));
+		final Rules ignoreRulesHello =3D ignoreRules
+				.getRulesForSubDirectory("hello");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesHello);
+
+		assertFalse(ignoreRules.toIgnore("helloworld", true));
+		assertFalse(ignoreRules.toIgnore("helloworld", false));
+		final Rules ignoreRulesHelloWorld =3D ignoreRules
+				.getRulesForSubDirectory("helloworld");
+		assertNotSame(Rules.IGNORE_NOTHING, ignoreRulesHelloWorld);
+
+		assertTrue(ignoreRulesHelloWorld.toIgnore("test.txt", true));
+		assertTrue(ignoreRulesHelloWorld.toIgnore("test.txt", false));
+
+		assertFalse(ignoreRulesHelloWorld.toIgnore("test", true));
+		assertFalse(ignoreRulesHelloWorld.toIgnore("test", false));
+
+		final Rules ignoreRulesTestTxt =3D ignoreRulesHelloWorld
+				.getRulesForSubDirectory("test.txt");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesTestTxt);
+
+		final Rules ignoreRulesTest =3D ignoreRulesHelloWorld
+				.getRulesForSubDirectory("test");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesTest);
+	}
+
+	public void testEmptyIgnoreList() {
+		final List<String> lines =3D Collections.emptyList();
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testOnlyOneNegatedIgnore() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("!a");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testOnlyThreeNegatedIgnores() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("!a");
+		lines.add("!a/b/c");
+		lines.add("!b*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testNegatedIgnoreCase1() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("/a");
+		lines.add("!b");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		final Rules ignoreRulesAB =3D ignoreRulesA.getRulesForSubDirectory("=
b");
+		final Rules ignoreRulesB =3D ignoreRules.getRulesForSubDirectory("b"=
);
+		final Rules ignoreRulesC =3D ignoreRules.getRulesForSubDirectory("c"=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesB);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesAB);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesC);
+		assertTrue(ignoreRules.toIgnore("a", true));
+		assertTrue(ignoreRules.toIgnore("a", false));
+		assertTrue(ignoreRulesA.toIgnore("c", true));
+		assertTrue(ignoreRulesA.toIgnore("c", false));
+	}
+
+	public void testExceptionOfException() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("*.*");
+		lines.add("!*.c");
+		lines.add("a.c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.toIgnore("b.txt", false));
+		assertTrue(ignoreRules.toIgnore("b.txt", true));
+		assertTrue(ignoreRules.toIgnore("a.c", false));
+		assertTrue(ignoreRules.toIgnore("a.c", true));
+		assertFalse(ignoreRules.toIgnore("b.c", false));
+		assertFalse(ignoreRules.toIgnore("b.c", true));
+	}
+
+	public void testComplexCase() {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("*");
+		lines.add("!/alpha/src");
+		lines.add("*~");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.toIgnore("beta", true));
+		assertTrue(ignoreRules.toIgnore("alpha", true));
+		final Rules ignoreRulesAlpha =3D ignoreRules
+				.getRulesForSubDirectory("alpha");
+		final Rules ignoreRulesAlphaBin =3D ignoreRulesAlpha
+				.getRulesForSubDirectory("bin");
+		final Rules ignoreRulesAlphaSrc =3D ignoreRulesAlpha
+				.getRulesForSubDirectory("src");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesAlphaBin);
+		assertFalse(ignoreRulesAlphaSrc.toIgnore("com", true));
+		assertFalse(ignoreRulesAlphaSrc.toIgnore("b.java", false));
+		assertTrue(ignoreRulesAlphaSrc.toIgnore("b.java~", true));
+	}
+
+	private class IgnoreRulesFactory {
+		private RuleListToObjectConverter converter =3D new RuleListToObject=
Converter();
+
+		private IgnoreRuleListFactory listFactory =3D new IgnoreRuleListFact=
ory();
+
+		/**
+		 * @param ignoreFileLines
+		 *            the lines of a ignore file like .gitignore.
+		 * @return a immutable IgnoreRules object.
+		 */
+		public Rules createIgnoreRulesFromLines(Iterable<String> ignoreFileL=
ines) {
+			final List<Rule> rules =3D listFactory
+					.createIgnoreRuleList(ignoreFileLines);
+			return converter.createIgnoreRules(rules.iterator());
+		}
+
+	}
+
+}
--=20
1.5.4.3
