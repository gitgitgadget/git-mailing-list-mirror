From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 12/22] Added the class GlobalFilePattern
Date: Sat, 10 May 2008 15:00:30 +0200
Message-ID: <1210424440-13886-13-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojg-0008FZ-Eb
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbYEJNBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:15 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbYEJNBO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44607 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbYEJNAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:48 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6891FDE9877E
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:47 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogw-000860-02; Sat, 10 May 2008 15:00:47 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/EawpEP42ohy/Dh16suB1eMFhyWwxx5mFt70c6
	7cdhjwX8ckF/FsZK2i6dfj4wsY3zEt8spMbX7PXO26Ml2lsohK
	lLmd1eGK+yyCBov9UYcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81670>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/lib/fileiteration/GlobalFilePattern.java  |   50 ++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/GlobalFilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Gl=
obalFilePattern.java b/org.spearce.jgit/src/org/spearce/jgit/lib/fileit=
eration/GlobalFilePattern.java
new file mode 100644
index 0000000..92b133f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/GlobalFil=
ePattern.java
@@ -0,0 +1,50 @@
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
+class GlobalFilePattern implements FilePattern {
+	private final StarPattern starPattern;
+
+	private final boolean matchDirectoriesOnly;
+
+	GlobalFilePattern(String starPatternString, boolean matchDirectoriesO=
nly) {
+		this.starPattern =3D new StarPattern(starPatternString);
+		this.matchDirectoriesOnly =3D matchDirectoriesOnly;
+	}
+
+	public boolean canMatchAtThisDirectoryLevel() {
+		return true;
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
+		return starPattern.matches(fileName);
+	}
+
+	public boolean isSameForSubDirectories() {
+		return false;
+	}
+}
--=20
1.5.2.5
