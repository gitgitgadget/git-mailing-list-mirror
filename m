From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 04/23] Added the class Rule.
Date: Fri, 23 May 2008 22:34:13 +0200
Message-ID: <1211574872-23676-5-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzx-0006CA-2W
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158AbYEWUeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:44 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbYEWUem
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:42 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45421 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485AbYEWUeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:36 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id A0980DC4A297
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:35 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyF-0005iq-00; Fri, 23 May 2008 22:34:35 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/H/13ZRHGd3nZcJCFBuiY6QDfqS5L4d0r9j38F
	tPykSlZ7q4WtJ/wJtfnnEGh24Er4SIe1rOgepngpK+2CisHSOz
	NICuokR2AZFKbF3MfxLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82736>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/treewalk/rules/Rule.java  |   61 ++++++++++++=
++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/Rule.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.=
java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.java
new file mode 100644
index 0000000..1cc74f5
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.java
@@ -0,0 +1,61 @@
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
+/**
+ * A Rule defines what to do with a files which match a specified
+ * {@link FilePattern}.
+ */
+public class Rule {
+	private boolean ignoreAtMatch;
+
+	private FilePattern pattern;
+
+	/**
+	 *=20
+	 * @param ignoreAtMatch
+	 *            defines if the rules ignores or accepts at a match.
+	 * @param pattern
+	 *            the pattern used to test if a file matches.
+	 */
+	Rule(boolean ignoreAtMatch, FilePattern pattern) {
+		this.ignoreAtMatch =3D ignoreAtMatch;
+		this.pattern =3D pattern;
+	}
+
+	FilePattern getPattern() {
+		return pattern;
+	}
+
+	boolean isIgnoreAtMatch() {
+		return ignoreAtMatch;
+	}
+
+	Rule getRuleForSubDirectory(String directoryName) {
+		final FilePattern subPattern =3D pattern
+				.getPatternForSubDirectory(directoryName);
+		if (subPattern =3D=3D pattern) {
+			return this;
+		}
+		return new Rule(ignoreAtMatch, subPattern);
+	}
+
+	boolean isSameForSubDirectories() {
+		return pattern.isSameForSubDirectories();
+	}
+
+}
--=20
1.5.4.3
