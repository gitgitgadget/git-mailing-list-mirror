From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Add "jgit init" command to create a new repository
Date: Tue, 23 Dec 2008 10:03:40 -0800
Message-ID: <1230055423-9944-3-git-send-email-spearce@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <1230055423-9944-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBdc-0002sv-BO
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYLWSDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYLWSDx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:03:53 -0500
Received: from george.spearce.org ([209.20.77.23]:58223 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYLWSDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:03:50 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4819B38211; Tue, 23 Dec 2008 18:03:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0202A38197;
	Tue, 23 Dec 2008 18:03:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230055423-9944-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103844>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Init.java             |   60 ++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 0e7e7d8..4a2b605 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -4,6 +4,7 @@ org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
 org.spearce.jgit.pgm.Glog
 org.spearce.jgit.pgm.IndexPack
+org.spearce.jgit.pgm.Init
 org.spearce.jgit.pgm.Log
 org.spearce.jgit.pgm.LsRemote
 org.spearce.jgit.pgm.LsTree
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
new file mode 100644
index 0000000..197864d
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+
+import org.spearce.jgit.lib.Repository;
+
+@Command(common = true, usage = "Create an empty git repository")
+class Init extends TextBuiltin {
+	@Override
+	protected final boolean requiresRepository() {
+		return false;
+	}
+
+	@Override
+	protected void run() throws Exception {
+		if (gitdir == null)
+			gitdir = new File(".git");
+		db = new Repository(gitdir);
+		db.create();
+		out.println("Initialized empty Git repository in "
+				+ gitdir.getAbsolutePath());
+	}
+}
-- 
1.6.1.rc4.301.g5497a
