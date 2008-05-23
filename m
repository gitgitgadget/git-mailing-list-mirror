From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 05/23] Added the iterface Rules.
Date: Fri, 23 May 2008 22:34:14 +0200
Message-ID: <1211574872-23676-6-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzy-0006CA-P7
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758984AbYEWUev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:51 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756913AbYEWUes
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:48 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45426 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbYEWUeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:37 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 22F7EDC4A343
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:36 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyF-0005iq-01; Fri, 23 May 2008 22:34:35 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/WIVQjO0MSYegKffQ7JwYTFW517tBQR3U0QmPW
	SLsdsR+1JrVjdwV1qiLrinMvb8YQipCy53pfRYqCBbZYnrQja1
	mZLlkuuZUzHCNqpdgvBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82737>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/treewalk/rules/Rules.java |   99 ++++++++++++=
++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/Rules.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules=
=2Ejava b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.ja=
va
new file mode 100644
index 0000000..627d974
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.java
@@ -0,0 +1,99 @@
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
+ * A {@link Rules} instances defines ignore or do not ignore rules for=
 files in
+ * a directory. It can't directly be used to match files in sub direct=
ories, but
+ * provides a method {@link #getRulesForSubDirectory}.
+ *=20
+ */
+public interface Rules {
+
+	/**
+	 * Provides the instance of {@link IgnoreAllRules}.
+	 */
+	public static final Rules IGNORE_ALL =3D new IgnoreAllRules();
+
+	/**
+	 * Provides the instance of {@link IgnoreNothingRules}.
+	 */
+	public static final Rules IGNORE_NOTHING =3D new IgnoreNothingRules()=
;
+
+	/**
+	 * @param fileName
+	 *            the name of the file or directory.
+	 * @param fileIsDirectory
+	 *            should be true if the file is a directory.
+	 * @return true if the file or directory should be ignored.
+	 */
+	public abstract boolean toIgnore(String fileName, boolean fileIsDirec=
tory);
+
+	/**
+	 * @param directoryName
+	 *            the sub directory for which you want an {@link Rules}
+	 *            instance.
+	 * @return an {@link Rules} instance, which can be used to check file=
s in
+	 *         the specified sub directory.
+	 */
+	public abstract Rules getRulesForSubDirectory(String directoryName);
+
+	/**
+	 * This implementation ignores everything.
+	 */
+	public static final class IgnoreAllRules implements Rules {
+		private IgnoreAllRules() {
+			// declared to make the constructor private
+		}
+
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean toIgnore(String fileName, boolean fileIsDirectory) {
+			return true;
+		}
+
+		@Override
+		public String toString() {
+			return "ignore all rules";
+		}
+	}
+
+	/**
+	 * This implementation ignores nothing.
+	 */
+	public static final class IgnoreNothingRules implements Rules {
+		private IgnoreNothingRules() {
+			// declared to make the constructor private
+		}
+
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean toIgnore(String fileName, boolean fileIsDirectory) {
+			return false;
+		}
+
+		@Override
+		public String toString() {
+			return "ignore nothing rules";
+		}
+	}
+
+}
--=20
1.5.4.3
