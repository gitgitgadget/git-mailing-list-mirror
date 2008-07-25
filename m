From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/9] Create an optional documentation annotation for TextBuiltin
Date: Fri, 25 Jul 2008 12:46:01 -0700
Message-ID: <1217015167-4680-4-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTG0-0005XG-QH
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYGYTqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYGYTqP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:15 -0400
Received: from george.spearce.org ([209.20.77.23]:45931 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYGYTqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:10 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D693438420; Fri, 25 Jul 2008 19:46:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3B58A383A3;
	Fri, 25 Jul 2008 19:46:09 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90098>

This new annotation can be used for automatic command list creation,
or additional help generation by the default help generator.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Command.java          |   72 ++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java
new file mode 100644
index 0000000..40be1f7
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+import static java.lang.annotation.ElementType.TYPE;
+import static java.lang.annotation.RetentionPolicy.RUNTIME;
+
+import java.lang.annotation.Retention;
+import java.lang.annotation.Target;
+
+/**
+ * Annotation to document a {@link TextBuiltin}.
+ * <p>
+ * This is an optional annotation for TextBuiltin subclasses and it carries
+ * documentation forward into the runtime system describing what the command is
+ * and why users may want to invoke it.
+ */
+@Retention(RUNTIME)
+@Target( { TYPE })
+public @interface Command {
+	/**
+	 * @return name the command is invoked as from the command line. If the
+	 *         (default) empty string is supplied the name will be generated
+	 *         from the class name.
+	 */
+	public String name() default "";
+
+	/**
+	 * @return one line description of the command's feature set.
+	 */
+	public String usage() default "";
+
+	/**
+	 * @return true if this command is considered to be commonly used.
+	 */
+	public boolean common() default false;
+}
-- 
1.6.0.rc0.182.gb96c7
