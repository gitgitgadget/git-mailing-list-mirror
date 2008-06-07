From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH v2 04/12] Add getType() method to RevObject hierarchy
Date: Sat,  7 Jun 2008 02:10:15 +0200
Message-ID: <1212797415-31055-1-git-send-email-marek.zawirski@gmail.com>
References: <200806061524.09741.robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 07 02:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4m1a-0003mK-IG
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566AbYFGAKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbYFGAKV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:10:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:43581 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbYFGAKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:10:20 -0400
Received: by mu-out-0910.google.com with SMTP id w8so754271mue.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9wJG5UYF0OQHc2f/9eMq4eIo5BP+HOiT4J6quGS5JG0=;
        b=jpaFhPl+4gaMIgXc/ErTcBvfF0LNBdGNO1Ri/X/NZvooDIgl4d5feHrzTpHkvIATIe
         dkJmC25wMIKtDDfic5g4e8m6siVE9mZU/0UXQaDn6gBzT33s6pgi9fytidvZLxA6XmSP
         TuiJlxHR/v5kN9Dq+6hez5VL8S/d3dOd4YpBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=doKGBenOcEO1lYhiwr0jXvRKQskrC5GB+errL1m/YVUUuyvjpvZQN9KnKuChs+cRzg
         pEZFxjwwxdj4Qp82LIeC8kckwwrBXZ+BrnchAXCYW5PB7CkjTIlOrOegtUuPqdWqGkgn
         RdCXZTlhwrGPWerlNBuztZt5rou2l6AhcSWZQ=
Received: by 10.103.238.4 with SMTP id p4mr408601mur.66.1212797418465;
        Fri, 06 Jun 2008 17:10:18 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id t10sm8600433muh.17.2008.06.06.17.10.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 17:10:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <200806061524.09741.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84149>

Introduce natural correlation between each concrete RevObject and
existing integer (constant) for that object type. Such an integer
allows us reducing code amount to perform indexing array by type
or mapping by type. We can also use switches instead of instanceof
or write output type directly.
We could have a common code with behavior determined by polymorphic
getType() call.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    6 ++++++
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    5 +++++
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    8 ++++++++
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    5 +++++
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    6 ++++++
 5 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
index f6d34f4..66cdc02 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 
 /** A binary file, or a symbolic link. */
 public class RevBlob extends RevObject {
@@ -55,4 +56,9 @@ public class RevBlob extends RevObject {
 	void parse(final RevWalk walk) {
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_BLOB;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 0aa7098..77f1d1a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -135,6 +135,11 @@ public class RevCommit extends RevObject {
 		buffer = raw;
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_COMMIT;
+	}
 
 	static void carryFlags(RevCommit c, final int carry) {
 		for (;;) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 86c50b5..451205c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -42,6 +42,7 @@ import java.io.IOException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 
 /** Base object type accessed during revision walking. */
@@ -56,6 +57,13 @@ public abstract class RevObject extends ObjectId {
 
 	abstract void parse(RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException;
+	
+	/**
+	 * Get Git object type. See {@link Constants}.
+	 * 
+	 * @return object type
+	 */
+	public abstract int getType();
 
 	/**
 	 * Get the name of this object.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 668819c..bbb18ee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -96,6 +96,11 @@ public class RevTag extends RevObject {
 		flags |= PARSED;
 	}
 
+	@Override
+	public int getType() {
+		return Constants.OBJ_TAG;
+	}
+	
 	/**
 	 * Parse this tag buffer for display.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
index 7ad9be0..e1cd4b5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 
 /** A reference to a tree of subtrees/files. */
 public class RevTree extends RevObject {
@@ -55,4 +56,9 @@ public class RevTree extends RevObject {
 	void parse(final RevWalk walk) {
 		flags |= PARSED;
 	}
+	
+	@Override
+	public int getType() {
+		return Constants.OBJ_TREE;
+	}
 }
-- 
1.5.5.1
