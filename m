From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 08/11] Expose the current entry's length, last modified in WorkingTreeIterator
Date: Sun, 10 Aug 2008 01:46:23 -0700
Message-ID: <1218357986-19671-9-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
 <1218357986-19671-7-git-send-email-spearce@spearce.org>
 <1218357986-19671-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aZ-0001pt-A0
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYHJIqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYHJIqq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:46 -0400
Received: from george.spearce.org ([209.20.77.23]:51287 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYHJIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5FCF43838A; Sun, 10 Aug 2008 08:46:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C8CF7381FD;
	Sun, 10 Aug 2008 08:46:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91820>

We need the last modified time available to us in application level
code so we can pull the current WorkingTreeIterator from TreeWalk
and then grab the last modified time off it to compare against the
index file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index cb4a089..05d9282 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -259,6 +259,25 @@ public abstract class WorkingTreeIterator extends AbstractTreeIterator {
 		pathLen = pathOffset + nameLen;
 	}
 
+	/**
+	 * Get the byte length of this entry.
+	 * 
+	 * @return size of this file, in bytes.
+	 */
+	public long getEntryLength() {
+		return current().getLength();
+	}
+
+	/**
+	 * Get the last modified time of this entry.
+	 * 
+	 * @return last modified time of this file, in milliseconds since the epoch
+	 *         (Jan 1, 1970 UTC).
+	 */
+	public long getEntryLastModified() {
+		return current().getLastModified();
+	}
+
 	private static final Comparator<Entry> ENTRY_CMP = new Comparator<Entry>() {
 		public int compare(final Entry o1, final Entry o2) {
 			final byte[] a = o1.encodedName;
-- 
1.6.0.rc2.219.g1250ab
