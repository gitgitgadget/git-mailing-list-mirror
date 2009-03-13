From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Make RevObject.getType implementations final
Date: Thu, 12 Mar 2009 19:07:39 -0700
Message-ID: <1236910062-18476-3-git-send-email-spearce@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org>
 <1236910062-18476-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhwqU-0006PX-Nk
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbZCMCHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 22:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZCMCHs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:07:48 -0400
Received: from george.spearce.org ([209.20.77.23]:46989 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbZCMCHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0804B38239; Fri, 13 Mar 2009 02:07:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2ED6C38215;
	Fri, 13 Mar 2009 02:07:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
In-Reply-To: <1236910062-18476-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113132>

These methods should never be overridden once defined by the base
class of RevCommit, RevTree, RevBlob or RevTag.  An override is
only going to provide confusion to calls who rely upon the return
value to know if a downcast is safe.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    2 +-
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    3 ++-
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    1 +
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    2 +-
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
index 66cdc02..cf241cf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevBlob.java
@@ -58,7 +58,7 @@ void parse(final RevWalk walk) {
 	}
 	
 	@Override
-	public int getType() {
+	public final int getType() {
 		return Constants.OBJ_BLOB;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 1b25fce..2a59ec4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -139,7 +139,7 @@ else if (nParents == 1) {
 	}
 	
 	@Override
-	public int getType() {
+	public final int getType() {
 		return Constants.OBJ_COMMIT;
 	}
 
@@ -393,6 +393,7 @@ public void dispose() {
 	public String toString() {
 		final StringBuilder s = new StringBuilder();
 		s.append(Constants.typeString(getType()));
+		s.append(' ');
 		s.append(name());
 		s.append(' ');
 		s.append(commitTime);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 7dadb7b..8c7cc23 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -172,6 +172,7 @@ public void dispose() {
 	public String toString() {
 		final StringBuilder s = new StringBuilder();
 		s.append(Constants.typeString(getType()));
+		s.append(' ');
 		s.append(name());
 		s.append(' ');
 		appendCoreFlags(s);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index aba8744..cace82d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -99,7 +99,7 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 	}
 
 	@Override
-	public int getType() {
+	public final int getType() {
 		return Constants.OBJ_TAG;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
index e1cd4b5..4d767e4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTree.java
@@ -58,7 +58,7 @@ void parse(final RevWalk walk) {
 	}
 	
 	@Override
-	public int getType() {
+	public final int getType() {
 		return Constants.OBJ_TREE;
 	}
 }
-- 
1.6.2.288.gc3f22
