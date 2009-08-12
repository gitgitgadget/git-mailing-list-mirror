From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Rename RevTag.getName() to RevTag.getTagName()
Date: Wed, 12 Aug 2009 12:39:16 -0700
Message-ID: <1250105956-17795-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJfk-0007LJ-Ko
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbZHLTjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbZHLTjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:39:16 -0400
Received: from george.spearce.org ([209.20.77.23]:44881 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZHLTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:39:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8CF62381FE; Wed, 12 Aug 2009 19:39:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F1B883816F;
	Wed, 12 Aug 2009 19:39:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.225.gb589e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125727>

The method getName() conflicts semantically with the method name()
we have inherited from our base class, ObjectId.  It is a rather
unfortunate turn of events that for performance reasons we wind up
subclassing what should be a property of this class, but since we
do that we need to pay attention to the methods declared on our
base class.

We want to use getName() to be a mirror of name() on AnyObjectId,
as it has a more JavaBeans style feel to the accessing of that
particular value.  So, rename getTagName() so it doesn't wind up
conflicting with the SHA-1 hex formatted string.

Noticed-by: Alex Blewitt <alex.blewitt@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 2fab266..51ff49b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -56,7 +56,7 @@
 
 	private byte[] buffer;
 
-	private String name;
+	private String tagName;
 
 	/**
 	 * Create a new tag reference.
@@ -96,7 +96,7 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 
 		int p = pos.value += 4; // "tag "
 		final int nameEnd = RawParseUtils.nextLF(rawTag, p) - 1;
-		name = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
+		tagName = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
 
 		if (walk.isRetainBody())
 			buffer = rawTag;
@@ -186,7 +186,7 @@ public final String getShortMessage() {
 	 * @return parsed tag.
 	 */
 	public Tag asTag(final RevWalk walk) {
-		return new Tag(walk.db, this, name, buffer);
+		return new Tag(walk.db, this, tagName, buffer);
 	}
 
 	/**
@@ -204,7 +204,7 @@ public final RevObject getObject() {
 	 * @return name of the tag, according to the tag header.
 	 */
 	public final String getName() {
-		return name;
+		return tagName;
 	}
 
 	final void disposeBody() {
-- 
1.6.4.225.gb589e
