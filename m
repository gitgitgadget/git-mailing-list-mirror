From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 02/20] Integer versions of copyRawTo() and fromRaw() in ObjectId
Date: Sun, 15 Jun 2008 23:45:31 +0200
Message-ID: <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804C-0001bl-BK
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYFOVqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYFOVqM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYFOVqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3137938fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bcKoxcHPJ3F0NqopWdJu/VZ4GtEKScghmjfmJc5/xWw=;
        b=lZcByqoibWTUPRWqjfOOhcGYtVhi5D+csbVH0unPwM5t9gTB7Wk7U7yj1AUcSlFzXD
         +A5aBqGvtONssPTs3uxlFAH7TPF8DDSMRt8FMh0iy+5UKBcMpubbEPwfKdzJH1bRKhWn
         Mi9ygEBwWntZDSuO+2fidsUnxgHFm6qbSYzSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R7MCjARSnbhIJZu+XH9AszOZ/nxMW/+YPy7EYtqzhV1RV9nxWKB7lsAQ6DXRYORlSp
         +6e9ks/QKFXLUOEMgXaWtMEDxLP2Uzms9MlZL3+UNXcKPpdXdTQ6bHBG4i8c7hXrZuvO
         jnoRMU3v35DnQ7k+CBaWg3UBnThu5aTn+rKzI=
Received: by 10.86.71.1 with SMTP id t1mr7224230fga.36.1213566360278;
        Sun, 15 Jun 2008 14:46:00 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l12sm9661909fgb.6.2008.06.15.14.45.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:45:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85126>

Helper methods in ObjectId and AnyobjectId for int[], overload existing
byte[] versions.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   16 ++++++++++++
 .../src/org/spearce/jgit/lib/ObjectId.java         |   26 ++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index c348598..871a76d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -276,6 +276,22 @@ public abstract class AnyObjectId implements Comparable {
 	}
 
 	/**
+	 * Copy this ObjectId to an int array.
+	 * 
+	 * @param b
+	 *            the buffer to copy to.
+	 * @param o
+	 *            the offset within b to write at.
+	 */
+	public void copyRawTo(final int[] b, final int o) {
+		b[o] = w1;
+		b[o + 1] = w2;
+		b[o + 2] = w3;
+		b[o + 3] = w4;
+		b[o + 4] = w5;
+	}
+
+	/**
 	 * Copy this ObjectId to an output writer in raw binary.
 	 * 
 	 * @param w
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 9688a2e..7646a7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -168,6 +168,32 @@ public class ObjectId extends AnyObjectId {
 	}
 
 	/**
+	 * Convert an ObjectId from raw binary representation.
+	 * 
+	 * @param is
+	 *            the raw integers buffer to read from. At least 5 integers must
+	 *            be available within this int array.
+	 * @return the converted object id.
+	 */
+	public static final ObjectId fromRaw(final int[] is) {
+		return fromRaw(is, 0);
+	}
+
+	/**
+	 * Convert an ObjectId from raw binary representation.
+	 * 
+	 * @param is
+	 *            the raw integers buffer to read from. At least 5 integers
+	 *            after p must be available within this int array.
+	 * @param p
+	 *            position to read the first integer of data from.
+	 * @return the converted object id.
+	 */
+	public static final ObjectId fromRaw(final int[] is, final int p) {
+		return new ObjectId(is[p], is[p + 1], is[p + 2], is[p + 3], is[p + 4]);
+	}
+
+	/**
 	 * Convert an ObjectId from hex characters (US-ASCII).
 	 * 
 	 * @param buf
-- 
1.5.5.1
