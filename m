From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 06/22] Added the interface FilePattern.
Date: Sat, 10 May 2008 15:00:24 +0200
Message-ID: <1210424440-13886-7-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojb-0008FZ-DV
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbYEJNA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:00:56 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYEJNAz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:00:55 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44581 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbYEJNAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:45 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 415EBDE99C8D
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:44 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogt-000860-01; Sat, 10 May 2008 15:00:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+IgL+Xvma06iuO7XodcAS7kzylyYX1YrcaqG7u
	/ZYr20VRywrc68o2pOJUd+jQYO9mDZ6005HvWM07NjIK7/4/m2
	bGIUhPwznDETZ+pNCV9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81667>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/lib/fileiteration/FilePattern.java        |  107 ++++++++++++=
++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/FilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Fi=
lePattern.java b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteratio=
n/FilePattern.java
new file mode 100644
index 0000000..01edbd4
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/FilePatte=
rn.java
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
+package org.spearce.jgit.lib.fileiteration;
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
+ * @author Florian Koeberle
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
\ No newline at end of file
--=20
1.5.2.5
