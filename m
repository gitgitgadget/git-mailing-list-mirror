From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 08/24] Added the interface FilePattern.
Date: Mon, 12 May 2008 22:13:26 +0200
Message-ID: <1210623222-24908-9-git-send-email-florianskarten@web.de>
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
	id 1JveSl-00086f-UX
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbYELUOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:44 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbYELUOn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40177 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbYELUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:46 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 32FB4DECE7A8
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:45 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP2-00016x-01; Mon, 12 May 2008 22:13:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+ePdU1isWBirLhQb44kZw04grARgjyM0w5KYvv
	QQnojrW5i+c/ChSND+18YldLSTXY5aJkM0zQKM1OglnbVS7weK
	QBZPySWNnkB8ehSg6kUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81935>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../spearce/jgit/treewalk/rules/FilePattern.java   |  105 ++++++++++++=
++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/FilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FileP=
attern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/File=
Pattern.java
new file mode 100644
index 0000000..666ff08
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FilePattern.=
java
@@ -0,0 +1,105 @@
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
+	 * This pattern instance matches always.
+	 */
+	public static final FilePattern MATCH_ALWAYS =3D new FilePattern() {
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_ALWAYS;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return true;
+		}
+
+		public boolean canMatchAtThisDirectoryLevel() {
+			return true;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	};
+
+	/**
+	 * This pattern instance matches never.
+	 */
+	public static final FilePattern MATCH_NEVER =3D new FilePattern() {
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_NEVER;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return false;
+		}
+
+		public boolean canMatchAtThisDirectoryLevel() {
+			return false;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	};
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
+	 * This method can be used to generate an smaller list of rules, whic=
h can
+	 * match.
+	 *=20
+	 * @return true if {@link #match(String, boolean)} returns always fal=
se.
+	 */
+	boolean canMatchAtThisDirectoryLevel();
+
+	/**
+	 * @return true if {@link #getPatternForSubDirectory(String)} returns=
 true
+	 *         for every value.
+	 */
+	boolean isSameForSubDirectories();
+}
--=20
1.5.4.3
