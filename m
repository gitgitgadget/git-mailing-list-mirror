From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 2/5] FileMode: Store bit masks in int constants
Date: Wed, 12 Aug 2009 10:33:34 -0400
Message-ID: <2c6b72b30908120733h4ecb3fccm3a1e80c111c1185c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbEuL-0002Uh-7Q
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZHLOdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZHLOdy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:33:54 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:61707 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZHLOdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:33:53 -0400
Received: by mail-qy0-f196.google.com with SMTP id 34so40222qyk.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Sch8brFZdEN/q9MHGHyr/wnXjuFKWImREL6Ellke43o=;
        b=IBgWyMg9CHJxTcemGKePYaDsCZldL4pci3NZ/MfyNiWzonvR55v+O00qRqGEhmqsTe
         8yUhxhaiqHwQg6dWqnBNysW5jzbjEs7y4JT4D/Jqd7TKmszY1scvQAhfslv58sW0ABRb
         Km9E0g5gECr1M5qS6/aW0/oXQougDfYbNNAVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=l6EXy6oJ3lcUj58bwgMy+Nie1spQiqiS2+w+pG6jXT/SR3YP+htgokpEZxMcu5WVgp
         EghddKHxz/yVAHye9bhAlv7gGqqfFraKvqm2RKyUTh/rTdvpX5bTbtrMP6rn/g4jWi5v
         oF5GFuNkTRZ+MpYVYfYsx0teYK6in/cDXkoOw=
Received: by 10.224.74.79 with SMTP id t15mr127251qaj.291.1250087634156; Wed, 
	12 Aug 2009 07:33:54 -0700 (PDT)
X-Google-Sender-Auth: 8ed42e6ed3dbfe99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125701>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../src/org/spearce/jgit/lib/FileMode.java         |   38 ++++++++++++--------
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    8 ++--
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/FileMode.java
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

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index d4291ea..6003736 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -134,16 +134,16 @@ protected WorkingTreeIterator(final
WorkingTreeIterator p) {
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
