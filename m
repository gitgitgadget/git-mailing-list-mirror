From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Allow exceptions to be created with integer type codes
Date: Fri, 12 Jun 2009 16:00:16 -0700
Message-ID: <1244847619-7364-3-git-send-email-spearce@spearce.org>
References: <1244847619-7364-1-git-send-email-spearce@spearce.org>
 <1244847619-7364-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjm-000336-5R
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZFLXA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbZFLXA1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:27 -0400
Received: from george.spearce.org ([209.20.77.23]:40051 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZFLXAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4D3AC381FD; Fri, 12 Jun 2009 23:00:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id ADB98381FE;
	Fri, 12 Jun 2009 23:00:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244847619-7364-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121463>

This may be easier in some contexts where we have the type code
we expect handy, but not the type string constant.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/errors/IncorrectObjectTypeException.java  |   13 +++++++++++++
 .../jgit/errors/MissingObjectException.java        |   12 ++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
index a194f19..3af1f44 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
@@ -40,6 +40,7 @@
 
 import java.io.IOException;
 
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 
 /**
@@ -62,4 +63,16 @@
 	public IncorrectObjectTypeException(final ObjectId id, final String type) {
 		super("Object " + id.name() + " is not a " + type + ".");
 	}
+
+	/**
+	 * Construct and IncorrectObjectTypeException for the specified object id.
+	 *
+	 * Provide the type to make it easier to track down the problem.
+	 *
+	 * @param id SHA-1
+	 * @param type object type
+	 */
+	public IncorrectObjectTypeException(final ObjectId id, final int type) {
+		this(id, Constants.typeString(type));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
index 37147c3..7b7b8f3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
@@ -40,6 +40,7 @@
 
 import java.io.IOException;
 
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 
 /**
@@ -58,4 +59,15 @@
 	public MissingObjectException(final ObjectId id, final String type) {
 		super("Missing " + type + " " + id.name());
 	}
+
+	/**
+	 * Construct a MissingObjectException for the specified object id.
+	 * Expected type is reported to simplify tracking down the problem.
+	 *
+	 * @param id SHA-1
+	 * @param type object type
+	 */
+	public MissingObjectException(final ObjectId id, final int type) {
+		this(id, Constants.typeString(type));
+	}
 }
-- 
1.6.3.2.367.gf0de
