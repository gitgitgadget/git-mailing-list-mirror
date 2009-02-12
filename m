From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/6] Add setBoolean, setInt to RepositoryConfig
Date: Thu, 12 Feb 2009 15:54:36 -0800
Message-ID: <1234482880-1316-3-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
 <1234482880-1316-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPl-0004ei-QQ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZBLXyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbZBLXyp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:45 -0500
Received: from george.spearce.org ([209.20.77.23]:49153 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZBLXyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:43 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id BEB7238221; Thu, 12 Feb 2009 23:54:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 43BC03819E;
	Thu, 12 Feb 2009 23:54:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109690>

This makes it easier for application level code to make edits to the
configuration file, especially when setting boolean or integers into
any property.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 821d8be..87535d1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -439,6 +439,63 @@ private Object getRawEntry(final String section, final String subsection,
 	/**
 	 * Add or modify a configuration value. The parameters will result in a
 	 * configuration entry like this.
+	 * 
+	 * <pre>
+	 * [section &quot;subsection&quot;]
+	 *         name = value
+	 * </pre>
+	 * 
+	 * @param section
+	 *            section name, e.g "branch"
+	 * @param subsection
+	 *            optional subsection value, e.g. a branch name
+	 * @param name
+	 *            parameter name, e.g. "filemode"
+	 * @param value
+	 *            parameter value
+	 */
+	public void setInt(final String section, final String subsection,
+			final String name, final int value) {
+		final String s;
+
+		if ((value % (1024 * 1024 * 1024)) == 0)
+			s = String.valueOf(value / (1024 * 1024 * 1024)) + " g";
+		else if ((value % (1024 * 1024)) == 0)
+			s = String.valueOf(value / (1024 * 1024)) + " m";
+		else if ((value % 1024) == 0)
+			s = String.valueOf(value / 1024) + " k";
+		else
+			s = String.valueOf(value);
+
+		setString(section, subsection, name, s);
+	}
+
+	/**
+	 * Add or modify a configuration value. The parameters will result in a
+	 * configuration entry like this.
+	 *
+	 * <pre>
+	 * [section &quot;subsection&quot;]
+	 *         name = value
+	 * </pre>
+	 *
+	 * @param section
+	 *            section name, e.g "branch"
+	 * @param subsection
+	 *            optional subsection value, e.g. a branch name
+	 * @param name
+	 *            parameter name, e.g. "filemode"
+	 * @param value
+	 *            parameter value
+	 */
+	public void setBoolean(final String section, final String subsection,
+			final String name, final boolean value) {
+		setString(section, subsection, name, value ? "true" : "false");
+	}
+
+	/**
+	 * Add or modify a configuration value. The parameters will result in a
+	 * configuration entry like this.
 	 *
 	 * <pre>
 	 * [section &quot;subsection&quot;]
-- 
1.6.2.rc0.226.gf08f
