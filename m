From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 2/5] FileMode: Store bit masks in int constants
Date: Wed, 12 Aug 2009 11:09:36 -0400
Message-ID: <1250089776-22895-1-git-send-email-fonseca@diku.dk>
References: <2c6b72b30908120733h4ecb3fccm3a1e80c111c1185c@mail.gmail.com>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFSk-0004M7-Ut
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZHLPJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZHLPJi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:09:38 -0400
Received: from mail-yw0-f191.google.com ([209.85.211.191]:58835 "EHLO
	mail-yw0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbZHLPJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:09:38 -0400
Received: by ywh29 with SMTP id 29so96341ywh.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=KMHGkyQqnHyop0mI/iLXAyFCa/Lw9oOrzAe70LB/OII=;
        b=o+xP8WsU2pSkXz+1rhRasoll3qS9P3AEyCKLlSYXTrpGU6NYb4ykLBDc+ZOF3qEJHj
         M+Jrk7RBHUrtxVjvFU3aTpS5gyEXRYFrXB5GCQp382I5eTFC33Wy+Ml9466oioYVOLaa
         jmIvGHybukZboGtpco7FmYakGbZn0G62cROsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=lamWlKjvD34S6aiUqxP1ZuzzZvBgfF/PuVrHT6frE+rWljCTNQL07UMoZjqKifTYhd
         t1zjIwuEiIT/MUjRaNcVP8fLzkWvNd5/SOZFzJDaX0vGB3si3DJPobYSoabpDR0gQkjI
         t66McjJFKx4pHYFGziEUgYQwlufFMNltaPfJM=
Received: by 10.90.58.2 with SMTP id g2mr131614aga.73.1250089778692;
        Wed, 12 Aug 2009 08:09:38 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178045554.dsl.bell.ca [70.55.140.114])
        by mx.google.com with ESMTPS id 38sm16342aga.39.2009.08.12.08.09.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 08:09:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
In-Reply-To: <2c6b72b30908120733h4ecb3fccm3a1e80c111c1185c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125708>


Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../src/org/spearce/jgit/lib/FileMode.java         |   38 ++++++++++++--------
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    8 ++--
 2 files changed, 27 insertions(+), 19 deletions(-)

 Resend without mailer errors ...

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
index cf42f37..a1f82f8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
@@ -50,21 +50,29 @@
  * </p>
  */
 public abstract class FileMode {
+
+	public static final int TYPE_MASK = 0170000;
+	public static final int TREE_MASK = 0040000;
+	public static final int SYMLINK_MASK = 0120000;
+	public static final int FILE_MASK = 0100000;
+	public static final int GITLINK_MASK = 0160000;
+	public static final int MISSING_MASK = 0000000;
+
 	/** Mode indicating an entry is a {@link Tree}. */
 	@SuppressWarnings("synthetic-access")
-	public static final FileMode TREE = new FileMode(0040000,
+	public static final FileMode TREE = new FileMode(TREE_MASK,
 			Constants.OBJ_TREE) {
 		public boolean equals(final int modeBits) {
-			return (modeBits & 0170000) == 0040000;
+			return (modeBits & TYPE_MASK) == TREE_MASK;
 		}
 	};
 
 	/** Mode indicating an entry is a {@link SymlinkTreeEntry}. */
 	@SuppressWarnings("synthetic-access")
-	public static final FileMode SYMLINK = new FileMode(0120000,
+	public static final FileMode SYMLINK = new FileMode(SYMLINK_MASK,
 			Constants.OBJ_BLOB) {
 		public boolean equals(final int modeBits) {
-			return (modeBits & 0170000) == 0120000;
+			return (modeBits & TYPE_MASK) == SYMLINK_MASK;
 		}
 	};
 
@@ -73,7 +81,7 @@ public boolean equals(final int modeBits) {
 	public static final FileMode REGULAR_FILE = new FileMode(0100644,
 			Constants.OBJ_BLOB) {
 		public boolean equals(final int modeBits) {
-			return (modeBits & 0170000) == 0100000 && (modeBits & 0111) == 0;
+			return (modeBits & TYPE_MASK) == FILE_MASK && (modeBits & 0111) == 0;
 		}
 	};
 
@@ -82,22 +90,22 @@ public boolean equals(final int modeBits) {
 	public static final FileMode EXECUTABLE_FILE = new FileMode(0100755,
 			Constants.OBJ_BLOB) {
 		public boolean equals(final int modeBits) {
-			return (modeBits & 0170000) == 0100000 && (modeBits & 0111) != 0;
+			return (modeBits & TYPE_MASK) == FILE_MASK && (modeBits & 0111) != 0;
 		}
 	};
 
 	/** Mode indicating an entry is a submodule commit in another repository. */
 	@SuppressWarnings("synthetic-access")
-	public static final FileMode GITLINK = new FileMode(0160000,
+	public static final FileMode GITLINK = new FileMode(GITLINK_MASK,
 			Constants.OBJ_COMMIT) {
 		public boolean equals(final int modeBits) {
-			return (modeBits & 0170000) == 0160000;
+			return (modeBits & TYPE_MASK) == GITLINK_MASK;
 		}
 	};
 
 	/** Mode indicating an entry is missing during parallel walks. */
 	@SuppressWarnings("synthetic-access")
-	public static final FileMode MISSING = new FileMode(0000000,
+	public static final FileMode MISSING = new FileMode(MISSING_MASK,
 			Constants.OBJ_BAD) {
 		public boolean equals(final int modeBits) {
 			return modeBits == 0;
@@ -112,20 +120,20 @@ public boolean equals(final int modeBits) {
 	 * @return the FileMode instance that represents the given bits.
 	 */
 	public static final FileMode fromBits(final int bits) {
-		switch (bits & 0170000) {
-		case 0000000:
+		switch (bits & TYPE_MASK) {
+		case MISSING_MASK:
 			if (bits == 0)
 				return MISSING;
 			break;
-		case 0040000:
+		case TREE_MASK:
 			return TREE;
-		case 0100000:
+		case FILE_MASK:
 			if ((bits & 0111) != 0)
 				return EXECUTABLE_FILE;
 			return REGULAR_FILE;
-		case 0120000:
+		case SYMLINK_MASK:
 			return SYMLINK;
-		case 0160000:
+		case GITLINK_MASK:
 			return GITLINK;
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index d4291ea..6003736 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -134,16 +134,16 @@ protected WorkingTreeIterator(final WorkingTreeIterator p) {
 	public byte[] idBuffer() {
 		if (contentIdFromPtr == ptr)
 			return contentId;
-		switch (mode & 0170000) {
-		case 0100000: /* normal files */
+		switch (mode & FileMode.TYPE_MASK) {
+		case FileMode.FILE_MASK:
 			contentIdFromPtr = ptr;
 			return contentId = idBufferBlob(entries[ptr]);
-		case 0120000: /* symbolic links */
+		case FileMode.SYMLINK_MASK:
 			// Java does not support symbolic links, so we should not
 			// have reached this particular part of the walk code.
 			//
 			return zeroid;
-		case 0160000: /* gitlink */
+		case FileMode.GITLINK_MASK:
 			// TODO: Support obtaining current HEAD SHA-1 from nested repository
 			//
 			return zeroid;
-- 
1.6.4.rc3.195.g2b05f
