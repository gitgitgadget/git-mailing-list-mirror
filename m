From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 05/23] Add RemoteRefUpdate class
Date: Sat, 28 Jun 2008 00:06:29 +0200
Message-ID: <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:08:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7d-0000rw-8G
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbYF0WHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638AbYF0WHS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:18 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:45022 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbYF0WHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:14 -0400
Received: by ik-out-1112.google.com with SMTP id c28so252786ika.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=theve1SOdiHmDpK3l0TAT5XYaQ6W+04BHnyAzVb3kDg=;
        b=iFqKm/KKKyrnNd01Rfwrv5t1j+VzhPN6XOX/4z4GZ+3Mti+YXQ8StKvacovY4PGNOg
         U8uPdJnDVbICU6BbdhYWpQqb6mPH9WWSUt/zBRIBl3jQiXmzeNkD9AFHHBxdYyirLsOe
         nTSy/z8w/UoHT7Ldzld/TRoKmEfMNVHjT9iLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KMOkMo2fnEHnVgAAoY+F7T0a0ZmpvFR6PUpxfvtU9+iVm/M1cGvG8EMV0tZaInp2VQ
         DF4cuJITkDgbcM3A4E8o9GUqPBJOqaBR8X8g2bgRRCnhTlWjmxpXaA2iEaFJHdghaVVS
         wKKB1kWWrL0iBvuCovhkmi7EghxSsLcQXJMYc=
Received: by 10.210.27.20 with SMTP id a20mr1607175eba.89.1214604431344;
        Fri, 27 Jun 2008 15:07:11 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z33sm2443001ikz.0.2008.06.27.15.07.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86645>

This class holds specification and status of remote ref update during
push operation.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |  315 ++++++++++++++++++++
 1 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
new file mode 100644
index 0000000..3737c7a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -0,0 +1,315 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
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
+ * - Neither the remoteName of the Git Development Community nor the
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
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevWalk;
+
+/**
+ * Represent request and status of a remote ref update. Specification is
+ * provided by client, while status is handled by {@link PushProcess} class,
+ * being read-only for client.
+ * <p>
+ * Client can create instances of this class directly, basing on user
+ * specification and advertised refs ({@link Connection} or through
+ * {@link Transport} helper methods. Apply this specification on remote
+ * repository using
+ * {@link Transport#push(org.spearce.jgit.lib.ProgressMonitor, java.util.Collection)}
+ * method.
+ * </p>
+ * 
+ */
+public class RemoteRefUpdate {
+	/**
+	 * Represent current status of a remote ref update.
+	 */
+	public static enum Status {
+		/**
+		 * Push process hasn't yet attempted to update this ref. This is the
+		 * default status, prior to push process execution.
+		 */
+		NOT_ATTEMPTED,
+
+		/**
+		 * Remote ref was up to date, there was no need to update anything.
+		 */
+		UP_TO_DATE,
+
+		/**
+		 * Remote ref update was rejected, as it would cause non fast-forward
+		 * update.
+		 */
+		REJECTED_NONFASTFORWARD,
+
+		/**
+		 * Remote ref update was rejected, because remote side doesn't
+		 * support/allow deleting refs.
+		 */
+		REJECTED_NODELETE,
+
+		/**
+		 * Remote ref update was rejected, because old object id on remote
+		 * repository wasn't the same as defined expected old object.
+		 */
+		REJECTED_REMOTE_CHANGED,
+
+		/**
+		 * Remote ref update was rejected for other reason, possibly described
+		 * in {@link RemoteRefUpdate#getMessage()}.
+		 */
+		REJECTED_OTHER_REASON,
+
+		/**
+		 * Remote ref didn't exist. Can occur on delete request of a non
+		 * existing ref.
+		 */
+		NON_EXISTING,
+
+		/**
+		 * Push process is awaiting update report from remote repository. This
+		 * is a temporary state or state after critical error in push process.
+		 */
+		AWAITING_REPORT,
+
+		/**
+		 * Remote ref was successfully updated.
+		 */
+		OK;
+	}
+
+	private final ObjectId expectedOldObjectId;
+
+	private final ObjectId newObjectId;
+
+	private final String remoteName;
+
+	private final TrackingRefUpdate trackingRefUpdate;
+
+	private String srcRef;
+
+	private final boolean forceUpdate;
+
+	private Status status;
+
+	private boolean fastForward;
+
+	private String message;
+
+	/**
+	 * Construct remote ref update request by providing an update specification.
+	 * Object is created with default {@link Status#NOT_ATTEMPTED} status and no
+	 * message.
+	 * 
+	 * @param db
+	 *            repository to push from.
+	 * @param srcRef
+	 *            source revision - any string resolvable by
+	 *            {@link Repository#resolve(String)}. This resolves to the new
+	 *            object that the caller want remote ref to be after update. Use
+	 *            null or {@link ObjectId#zeroId()} string for delete request.
+	 * @param remoteName
+	 *            full name of a remote ref to update, e.g. "refs/heads/master"
+	 *            (no wildcard, no short name).
+	 * @param forceUpdate
+	 *            true when caller want remote ref to be updated regardless
+	 *            whether it is fast-forward update (old object is ancestor of
+	 *            new object).
+	 * @param localName
+	 *            optional full name of a local stored tracking branch, to
+	 *            update after push, e.g. "refs/remotes/zawir/dirty" (no
+	 *            wildcard, no short name); null if no local tracking branch
+	 *            should be updated.
+	 * @param expectedOldObjectId
+	 *            optional object id that caller is expecting, requiring to be
+	 *            advertised by remote side before update; update will take
+	 *            place ONLY if remote side advertise exactly this expected id;
+	 *            null if caller doesn't care what object id remote side
+	 *            advertise. Use {@link ObjectId#zeroId()} when expecting no
+	 *            remote ref with this name.
+	 * @throws IOException
+	 *             when I/O error occurred during creating
+	 *             {@link TrackingRefUpdate} for local tracking branch.
+	 * @throws IllegalArgumentException
+	 *             if some required parameter was null or srcRef can't be
+	 *             resolved to any object.
+	 */
+	public RemoteRefUpdate(final Repository db, final String srcRef,
+			final String remoteName, final boolean forceUpdate,
+			final String localName, final ObjectId expectedOldObjectId)
+			throws IOException {
+		if (remoteName == null)
+			throw new IllegalArgumentException("remote name can't be null");
+		this.srcRef = srcRef;
+		this.newObjectId = (srcRef == null ? ObjectId.zeroId() : db
+				.resolve(srcRef));
+		if (newObjectId == null)
+			throw new IllegalArgumentException(
+					"source ref doesn't resolve to any object");
+		this.remoteName = remoteName;
+		this.forceUpdate = forceUpdate;
+		if (localName != null && db != null)
+			trackingRefUpdate = new TrackingRefUpdate(db, localName,
+					remoteName, forceUpdate, newObjectId, "push");
+		else
+			trackingRefUpdate = null;
+		this.expectedOldObjectId = expectedOldObjectId;
+		this.status = Status.NOT_ATTEMPTED;
+	}
+
+	/**
+	 * @return expectedOldObjectId required to be advertised by remote side, as
+	 *         set in constructor; may be null.
+	 */
+	public ObjectId getExpectedOldObjectId() {
+		return expectedOldObjectId;
+	}
+
+	/**
+	 * @return true if some object is required to be advertised by remote side,
+	 *         as set in constructor; false otherwise.
+	 */
+	public boolean isExpectingOldObjectId() {
+		return expectedOldObjectId != null;
+	}
+
+	/**
+	 * @return newObjectId for remote ref, as set in constructor.
+	 */
+	public ObjectId getNewObjectId() {
+		return newObjectId;
+	}
+
+	/**
+	 * @return true if this update is deleting update; false otherwise.
+	 */
+	public boolean isDelete() {
+		return ObjectId.zeroId().equals(newObjectId);
+	}
+
+	/**
+	 * @return name of remote ref to update, as set in constructor.
+	 */
+	public String getRemoteName() {
+		return remoteName;
+	}
+
+	/**
+	 * @return local tracking branch update if localName was set in constructor.
+	 */
+	public TrackingRefUpdate getTrackingRefUpdate() {
+		return trackingRefUpdate;
+	}
+
+	/**
+	 * @return source revision as specified by user (in constructor), could be
+	 *         any string parseable by {@link Repository#resolve(String)}; can
+	 *         be null if specified that way in constructor - this stands for
+	 *         delete request.
+	 */
+	public String getSrcRef() {
+		return srcRef;
+	}
+
+	/**
+	 * @return true if user specified a local tracking branch for remote update;
+	 *         false otherwise.
+	 */
+	public boolean hasTrackingRefUpdate() {
+		return trackingRefUpdate != null;
+	}
+
+	/**
+	 * @return true if this update is forced regardless of old remote ref
+	 *         object; false otherwise.
+	 */
+	public boolean isForceUpdate() {
+		return forceUpdate;
+	}
+
+	/**
+	 * @return status of remote ref update operation.
+	 */
+	public Status getStatus() {
+		return status;
+	}
+
+	/**
+	 * Check whether update was fast-forward. Note that this result is
+	 * meaningful only after successful update (when status is {@link Status#OK}).
+	 * 
+	 * @return true if update was fast-forward; false otherwise.
+	 */
+	public boolean isFastForward() {
+		return fastForward;
+	}
+
+	/**
+	 * @return message describing reasons of status when needed/possible; may be
+	 *         null.
+	 */
+	public String getMessage() {
+		return message;
+	}
+
+	protected void setStatus(final Status status) {
+		this.status = status;
+	}
+
+	protected void setFastForward(boolean fastForward) {
+		this.fastForward = fastForward;
+	}
+
+	protected void setMessage(final String message) {
+		this.message = message;
+	}
+
+	/**
+	 * Update locally stored tracking branch with the new object.
+	 * 
+	 * @param walk
+	 *            walker used for checking update properties.
+	 * @throws IOException
+	 *             when I/O error occurred during update
+	 */
+	protected void updateTrackingRef(final RevWalk walk) throws IOException {
+		trackingRefUpdate.update(walk);
+	}
+}
-- 
1.5.5.3
