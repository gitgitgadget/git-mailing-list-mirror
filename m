From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 03/23] Added the interface FilePattern.
Date: Fri, 23 May 2008 22:34:12 +0200
Message-ID: <1211574872-23676-4-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzv-0006CA-Ic
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbYEWUek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:40 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756974AbYEWUej
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:39 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45418 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbYEWUeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:36 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2EFF8DC4A33E
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:35 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyE-0005iq-00; Fri, 23 May 2008 22:34:34 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+h3P/n9y/4sjiCSOC+RDNvrnr4WtqEzYkKPXJX
	eMQvl+Tabq0EmeKUgDybbKLGEnGJyl1CiyWmpqQl88OVSWcSEf
	ygBqtZJxIJJOqSyLlHvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82740>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../spearce/jgit/treewalk/rules/FilePattern.java   |  107 ++++++++++++=
++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/FilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FileP=
attern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/File=
Pattern.java
new file mode 100644
index 0000000..75262c8
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FilePattern.=
java
@@ -0,0 +1,107 @@
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
+ * A {@link FilePattern} can be used to check if files in a directory =
matches a
+ * pattern. It provides with the {@link #getPatternForSubDirectory(Str=
ing)}
+ * method {@link FilePattern}s for sub directories.
+ *=20
+ * Implementations of this interface should be immutable.
+ *=20
+ */
+interface FilePattern {
+	/**
+	 * Contains the only instance of {@link FilePatternMatchAlways}.
+	 */
+	public static final FilePattern MATCH_ALWAYS =3D new FilePatternMatch=
Always();
+
+	/**
+	 * Contains the only instance of {@link FilePatternMatchNever}.
+	 */
+	public static final FilePattern MATCH_NEVER =3D new FilePatternMatchN=
ever();
+
+	/**
+	 * @param fileName
+	 *            the name of the file or directory
+	 * @param fileIsDirectory
+	 *            determines if the file is a directory.
+	 * @return true if the pattern matches.
+	 */
+	boolean match(String fileName, boolean fileIsDirectory);
+
+	/**
+	 *=20
+	 * @param directoryName
+	 *            the name of a subdirectory.
+	 * @return a pattern which can be used to match files in sub director=
ies. A
+	 *         user may check if the returned value is {@link #MATCH_NEVE=
R} in
+	 *         order to do some performance optimizations.
+	 *=20
+	 */
+	FilePattern getPatternForSubDirectory(String directoryName);
+
+	/**
+	 * @return true if {@link #getPatternForSubDirectory(String)} returns=
 true
+	 *         for every value.
+	 */
+	boolean isSameForSubDirectories();
+
+	/**
+	 * This implementation does always match.
+	 */
+	public static final class FilePatternMatchAlways implements FilePatte=
rn {
+
+		private FilePatternMatchAlways() {
+			// declared to make the constructor private
+		}
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_ALWAYS;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return true;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	}
+
+	/**
+	 * This implementation does never match.
+	 */
+	public static final class FilePatternMatchNever implements FilePatter=
n {
+		private FilePatternMatchNever() {
+			// declared to make the constructor private
+		}
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_NEVER;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return false;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	}
+
+}
--=20
1.5.4.3
