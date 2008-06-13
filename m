From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 09/24] Added test class OverallIgnoreRulestest.
Date: Fri, 13 Jun 2008 20:35:06 +0200
Message-ID: <1213382121-19786-9-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAN-0005zA-9z
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYFMSfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:50 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYFMSfs
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43415 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYFMSf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:29 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5737CE184E16
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:28 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7T-0000eI-01; Fri, 13 Jun 2008 20:35:27 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+XiVe/zsEZqfI/3i/oYlsjuZM4NDdT3eGfRmM4
	Z4S0vZhUMTKcNDRZWZLkOQVPk9ITEkD4RCZxYHfNEYclZdx8dJ
	mR3ahPLc+u80F5qKhrQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84913>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/OverallIgnoreRulesTest.java     |  396 ++++++++++++=
++++++++
 1 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/rules/OverallIgnoreRulesTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/=
OverallIgnoreRulesTest.java b/org.spearce.jgit.test/tst/org/spearce/jgi=
t/treewalk/rules/OverallIgnoreRulesTest.java
new file mode 100644
index 0000000..55e9de5
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/Overall=
IgnoreRulesTest.java
@@ -0,0 +1,396 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
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
+package org.spearce.jgit.treewalk.rules;
+
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
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
+	public void testSimpleGlobalPattern() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("ab");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.shouldIgnore("ab", false));
+		assertTrue(ignoreRules.shouldIgnore("ab", true));
+		assertFalse(ignoreRules.shouldIgnore("abc", false));
+		assertFalse(ignoreRules.shouldIgnore("abc", true));
+	}
+
+	public void testGlobalPatternWithOneStar() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a*c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.shouldIgnore("ac", false));
+		assertTrue(ignoreRules.shouldIgnore("ac", true));
+
+		assertTrue(ignoreRules.shouldIgnore("abc", false));
+		assertTrue(ignoreRules.shouldIgnore("abc", true));
+
+		assertTrue(ignoreRules.shouldIgnore("abbc", false));
+		assertTrue(ignoreRules.shouldIgnore("abbc", true));
+
+		assertTrue(ignoreRules.shouldIgnore("aabc", false));
+		assertTrue(ignoreRules.shouldIgnore("aabc", true));
+
+		assertFalse(ignoreRules.shouldIgnore("cab", false));
+		assertFalse(ignoreRules.shouldIgnore("cab", true));
+	}
+
+	public void testGlobalPatternWithTwoStars() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a*c*e");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.shouldIgnore("ace", false));
+		assertTrue(ignoreRules.shouldIgnore("ace", true));
+
+		assertTrue(ignoreRules.shouldIgnore("abcde", false));
+		assertTrue(ignoreRules.shouldIgnore("abcde", true));
+
+		assertTrue(ignoreRules.shouldIgnore("aHellocWorlde", false));
+		assertTrue(ignoreRules.shouldIgnore("aHellocWorlde", true));
+
+		assertFalse(ignoreRules.shouldIgnore("ae", false));
+		assertFalse(ignoreRules.shouldIgnore("ae", true));
+	}
+
+	public void testGlobalPatternWithDots() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("*.tar.gz");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.shouldIgnore("test.tar.gz", false));
+		assertTrue(ignoreRules.shouldIgnore("test.tar.gz", true));
+
+		assertTrue(ignoreRules.shouldIgnore(".tar.gz", false));
+		assertTrue(ignoreRules.shouldIgnore(".tar.gz", true));
+
+		assertFalse(ignoreRules.shouldIgnore("test", false));
+		assertFalse(ignoreRules.shouldIgnore("test", true));
+
+		// test that "." isn't handled as "any character"
+		assertFalse(ignoreRules.shouldIgnore(".tarogz", false));
+		assertFalse(ignoreRules.shouldIgnore(".tarogz", true));
+	}
+
+	public void testGlobalPatternDirectoryOnlyRule() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.shouldIgnore("a", true));
+		assertFalse(ignoreRules.shouldIgnore("a", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertSame(Rules.IGNORE_ALL, ignoreRulesA);
+
+		final Rules ignoreRulesB =3D ignoreRules.getRulesForSubDirectory("b"=
);
+		assertTrue(ignoreRulesB.shouldIgnore("a", true));
+		assertFalse(ignoreRulesB.shouldIgnore("a", false));
+
+		final Rules ignoreRulesBA =3D ignoreRulesB.getRulesForSubDirectory("=
a");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesBA);
+
+	}
+
+	public void testSimpleFilePathPattern() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/b/c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertFalse(ignoreRules.shouldIgnore("a", true));
+		assertFalse(ignoreRules.shouldIgnore("a", false));
+		assertFalse(ignoreRules.shouldIgnore("b", true));
+		assertFalse(ignoreRules.shouldIgnore("b", false));
+		assertFalse(ignoreRules.shouldIgnore("c", true));
+		assertFalse(ignoreRules.shouldIgnore("c", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertFalse(ignoreRulesA.shouldIgnore("a", true));
+		assertFalse(ignoreRulesA.shouldIgnore("a", false));
+		assertFalse(ignoreRulesA.shouldIgnore("b", true));
+		assertFalse(ignoreRulesA.shouldIgnore("b", false));
+		assertFalse(ignoreRulesA.shouldIgnore("c", true));
+		assertFalse(ignoreRulesA.shouldIgnore("c", false));
+
+		final Rules ignoreRulesAB =3D ignoreRulesA.getRulesForSubDirectory("=
b");
+		assertFalse(ignoreRulesAB.shouldIgnore("a", true));
+		assertFalse(ignoreRulesAB.shouldIgnore("a", false));
+		assertFalse(ignoreRulesAB.shouldIgnore("b", true));
+		assertFalse(ignoreRulesAB.shouldIgnore("b", false));
+		assertTrue(ignoreRulesAB.shouldIgnore("c", true));
+		assertTrue(ignoreRulesAB.shouldIgnore("c", false));
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
+	public void testFilePathPatternDirectoryOnlyRule() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("a/b/c/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertFalse(ignoreRules.shouldIgnore("a", true));
+		assertFalse(ignoreRules.shouldIgnore("a", false));
+		assertFalse(ignoreRules.shouldIgnore("b", true));
+		assertFalse(ignoreRules.shouldIgnore("b", false));
+		assertFalse(ignoreRules.shouldIgnore("c", true));
+		assertFalse(ignoreRules.shouldIgnore("c", false));
+
+		final Rules ignoreRulesA =3D ignoreRules.getRulesForSubDirectory("a"=
);
+		assertFalse(ignoreRulesA.shouldIgnore("a", true));
+		assertFalse(ignoreRulesA.shouldIgnore("a", false));
+		assertFalse(ignoreRulesA.shouldIgnore("b", true));
+		assertFalse(ignoreRulesA.shouldIgnore("b", false));
+		assertFalse(ignoreRulesA.shouldIgnore("c", true));
+		assertFalse(ignoreRulesA.shouldIgnore("c", false));
+
+		final Rules ignoreRulesAB =3D ignoreRulesA.getRulesForSubDirectory("=
b");
+		assertFalse(ignoreRulesAB.shouldIgnore("a", true));
+		assertFalse(ignoreRulesAB.shouldIgnore("a", false));
+		assertFalse(ignoreRulesAB.shouldIgnore("b", true));
+		assertFalse(ignoreRulesAB.shouldIgnore("b", false));
+		assertTrue(ignoreRulesAB.shouldIgnore("c", true));
+		assertFalse(ignoreRulesAB.shouldIgnore("c", false));
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
+	public void testShortPathPattern() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/alpha");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.shouldIgnore("alpha", true));
+		assertTrue(ignoreRules.shouldIgnore("alpha", false));
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
+	public void testShortDirectoryPathPattern() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/alpha/");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.shouldIgnore("alpha", true));
+		assertFalse(ignoreRules.shouldIgnore("alpha", false));
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
+	public void testShortPathPatternWithStar() throws Exception {
+		List<String> lines =3D new ArrayList<String>();
+		lines.add("/.*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertTrue(ignoreRules.shouldIgnore(".test", true));
+		assertTrue(ignoreRules.shouldIgnore(".test", false));
+
+		assertFalse(ignoreRules.shouldIgnore("test", true));
+		assertFalse(ignoreRules.shouldIgnore("test", false));
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
+	public void testPathPatternWith2Times2Stars() throws Exception {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("he*wor*d/*.*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+
+		assertFalse(ignoreRules.shouldIgnore("hello", true));
+		assertFalse(ignoreRules.shouldIgnore("hello", false));
+		final Rules ignoreRulesHello =3D ignoreRules
+				.getRulesForSubDirectory("hello");
+		assertSame(Rules.IGNORE_NOTHING, ignoreRulesHello);
+
+		assertFalse(ignoreRules.shouldIgnore("helloworld", true));
+		assertFalse(ignoreRules.shouldIgnore("helloworld", false));
+		final Rules ignoreRulesHelloWorld =3D ignoreRules
+				.getRulesForSubDirectory("helloworld");
+		assertNotSame(Rules.IGNORE_NOTHING, ignoreRulesHelloWorld);
+
+		assertTrue(ignoreRulesHelloWorld.shouldIgnore("test.txt", true));
+		assertTrue(ignoreRulesHelloWorld.shouldIgnore("test.txt", false));
+
+		assertFalse(ignoreRulesHelloWorld.shouldIgnore("test", true));
+		assertFalse(ignoreRulesHelloWorld.shouldIgnore("test", false));
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
+	public void testEmptyIgnoreList() throws Exception {
+		final List<String> lines =3D Collections.emptyList();
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testOnlyOneNegatedIgnore() throws Exception {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("!a");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testOnlyThreeNegatedIgnores() throws Exception {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("!a");
+		lines.add("!a/b/c");
+		lines.add("!b*");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertSame(Rules.IGNORE_NOTHING, ignoreRules);
+	}
+
+	public void testNegatedIgnoreCase1() throws Exception {
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
+		assertTrue(ignoreRules.shouldIgnore("a", true));
+		assertTrue(ignoreRules.shouldIgnore("a", false));
+		assertTrue(ignoreRulesA.shouldIgnore("c", true));
+		assertTrue(ignoreRulesA.shouldIgnore("c", false));
+	}
+
+	public void testExceptionOfException() throws Exception {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("*.*");
+		lines.add("!*.c");
+		lines.add("a.c");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.shouldIgnore("b.txt", false));
+		assertTrue(ignoreRules.shouldIgnore("b.txt", true));
+		assertTrue(ignoreRules.shouldIgnore("a.c", false));
+		assertTrue(ignoreRules.shouldIgnore("a.c", true));
+		assertFalse(ignoreRules.shouldIgnore("b.c", false));
+		assertFalse(ignoreRules.shouldIgnore("b.c", true));
+	}
+
+	public void testComplexCase() throws Exception {
+		final List<String> lines =3D new ArrayList<String>();
+		lines.add("*");
+		lines.add("!/alpha/src");
+		lines.add("*~");
+		final Rules ignoreRules =3D factory.createIgnoreRulesFromLines(lines=
);
+		assertTrue(ignoreRules.shouldIgnore("beta", true));
+		assertTrue(ignoreRules.shouldIgnore("alpha", true));
+		final Rules ignoreRulesAlpha =3D ignoreRules
+				.getRulesForSubDirectory("alpha");
+		final Rules ignoreRulesAlphaBin =3D ignoreRulesAlpha
+				.getRulesForSubDirectory("bin");
+		final Rules ignoreRulesAlphaSrc =3D ignoreRulesAlpha
+				.getRulesForSubDirectory("src");
+		assertSame(Rules.IGNORE_ALL, ignoreRulesAlphaBin);
+		assertFalse(ignoreRulesAlphaSrc.shouldIgnore("com", true));
+		assertFalse(ignoreRulesAlphaSrc.shouldIgnore("b.java", false));
+		assertTrue(ignoreRulesAlphaSrc.shouldIgnore("b.java~", true));
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
+		 * @throws InvalidPatternException
+		 */
+		public Rules createIgnoreRulesFromLines(Iterable<String> ignoreFileL=
ines)
+				throws InvalidPatternException {
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
