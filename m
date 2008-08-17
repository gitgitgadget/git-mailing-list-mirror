From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 12/31] Add another RemoteRefUpdate constructor, useful for 2-stage push
Date: Sun, 17 Aug 2008 22:43:53 +0200
Message-ID: <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp97-00038o-9Q
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYHQUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbYHQUpA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYHQUo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489195fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nPZONYY75TpWJrcWafds2z6JXvAvFGuzkwq932OsR6w=;
        b=inZyGvMDv10r+CMIx+5RyIyNYtVbiv37xf873XymTlfVdHQgah2u99sbvkp2rcjOHq
         qXXiWtF3tu6p9myUSGntRlQqjyTE7te6iIi7cOZcQ55Ik9p0Nv887IC9+x0JH85lQm4j
         3zFNBul8XWUJqh6Lk+qUZ79acUcHEv5R3SI/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WpMC2m5Y8n4Bh8gkBn3hpiIizy4VHr3ZzewbRdEBnnxKlPNOYs2zg8IfzZGq5tIaFG
         1dw510rE9RnNqrXMp7P5lWhsgfcVRFsPYCKk2KLHHUu3yMpw3vCJM5LCkLOnz5Vd+avj
         Z5mZkhiPwGYAtT602XJuqw4+9q9wSfGkPceSk=
Received: by 10.86.28.2 with SMTP id b2mr4017225fgb.31.1219005897918;
        Sun, 17 Aug 2008 13:44:57 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d4sm12229630fga.8.2008.08.17.13.44.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92647>

New constructor base on existing RemoteRefUpdate instance, providing
deep copy of object, but allowing change of expectedOldObjectId.

It may be useful for copying ref updates during one-to-many push or
2-stage push, with first 1st step being dry run, 2nd being actual push.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   28 +++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index 5afb8a4..42588c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -123,7 +123,7 @@ public class RemoteRefUpdate {
 
 	private final TrackingRefUpdate trackingRefUpdate;
 
-	private String srcRef;
+	private final String srcRef;
 
 	private final boolean forceUpdate;
 
@@ -133,6 +133,8 @@ public class RemoteRefUpdate {
 
 	private String message;
 
+	private final Repository db;
+
 	/**
 	 * Construct remote ref update request by providing an update specification.
 	 * Object is created with default {@link Status#NOT_ATTEMPTED} status and no
@@ -190,11 +192,35 @@ public class RemoteRefUpdate {
 					remoteName, forceUpdate, newObjectId, "push");
 		else
 			trackingRefUpdate = null;
+		this.db = db;
 		this.expectedOldObjectId = expectedOldObjectId;
 		this.status = Status.NOT_ATTEMPTED;
 	}
 
 	/**
+	 * Create a new instance of this object basing on existing instance for
+	 * configuration. State (like {@link #getMessage()}, {@link #getStatus()})
+	 * of base object is not shared. Expected old object id is set up from
+	 * scratch, as this constructor may be used for 2-stage push: first one
+	 * being dry run, second one being actual push.
+	 * 
+	 * @param base
+	 *            configuration base.
+	 * @param newExpectedOldObjectId
+	 *            new expected object id value.
+	 * @throws IOException
+	 *             when I/O error occurred during creating
+	 *             {@link TrackingRefUpdate} for local tracking branch or srcRef
+	 *             of base object no longer can be resolved to any object.
+	 */
+	public RemoteRefUpdate(final RemoteRefUpdate base,
+			final ObjectId newExpectedOldObjectId) throws IOException {
+		this(base.db, base.srcRef, base.remoteName, base.forceUpdate,
+				(base.trackingRefUpdate == null ? null : base.trackingRefUpdate
+						.getLocalName()), newExpectedOldObjectId);
+	}
+
+	/**
 	 * @return expectedOldObjectId required to be advertised by remote side, as
 	 *         set in constructor; may be null.
 	 */
-- 
1.5.6.3
