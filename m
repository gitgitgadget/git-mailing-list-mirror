From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 06/23] Added the class FileNamePattern.
Date: Fri, 23 May 2008 22:34:15 +0200
Message-ID: <1211574872-23676-7-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzz-0006CA-Cz
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbYEWUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:52 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758806AbYEWUev
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:51 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45447 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730AbYEWUei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:38 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 91D8EDC49FE9
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:36 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyG-0005iq-00; Fri, 23 May 2008 22:34:36 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19x80wOCSpyipQo9oLQTZ61jmN6ffyK33uOBDwi
	DRaeLJ7uFXvLrjItC4NULDdJFLjrlwwgsmE0JRdIOeRuslijEw
	r9R8ZqWeLx1gIQClxMoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82749>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/FileNamePattern.java       |   58 ++++++++++++=
++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/FileNamePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FileN=
amePattern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/=
=46ileNamePattern.java
new file mode 100644
index 0000000..f14fdef
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FileNamePatt=
ern.java
@@ -0,0 +1,58 @@
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
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.lib.FileNameMatcher;
+
+/**
+ * A {@link FileNamePattern} defines a pattern for all files in a tree=
=2E A
+ * typical example would be "*.txt", which would match at any file or =
subtree
+ * which ends with ".txt" like "a/b/c.txt" and "a.txt/a.c".
+ *=20
+ */
+class FileNamePattern implements FilePattern {
+	private final FileNameMatcher fileNameMatcher;
+
+	private final boolean matchDirectoriesOnly;
+
+	FileNamePattern(String fnMatchPatternString, boolean matchDirectories=
Only)
+			throws InvalidPatternException {
+		this.fileNameMatcher =3D new FileNameMatcher(fnMatchPatternString, n=
ull);
+		this.matchDirectoriesOnly =3D matchDirectoriesOnly;
+	}
+
+	public FilePattern getPatternForSubDirectory(String directoryName) {
+		if (match(directoryName, true)) {
+			return MATCH_ALWAYS;
+		}
+		return this;
+	}
+
+	public boolean match(String fileName, boolean fileIsDirectory) {
+		if (matchDirectoriesOnly && !fileIsDirectory) {
+			return false;
+		}
+		fileNameMatcher.resetStringToMatch();
+		fileNameMatcher.extendStringToMatch(fileName);
+		return fileNameMatcher.isMatch();
+	}
+
+	public boolean isSameForSubDirectories() {
+		return false;
+	}
+}
--=20
1.5.4.3
