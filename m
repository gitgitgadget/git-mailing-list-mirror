From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 13/23] Add PushProcess class implementing git-send-pack logic
Date: Sat, 28 Jun 2008 00:06:37 +0200
Message-ID: <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7k-0000rw-PY
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbYF0WIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758135AbYF0WH7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:59 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:45496 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712AbYF0WHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:55 -0400
Received: by ik-out-1112.google.com with SMTP id c28so252883ika.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OWEWA2A8RFyohb9bRXn5MpHOpfXV9axoTq93Y0KlYsg=;
        b=Qc0fpFiyQF+Wb4H/zpQfSOkIBJk1RSOj8pwWB8tXUjiQosUIIWm1971FoOFuq/xXtg
         /lQWbsZJDLYNNeHwVt7GWXibsDT3/ltXHpd86J0KJJEsfeWzyuRTUztRfA5uP/u9R8yN
         tgcUmlW69eMmyjt4RXIinuKaWkWc0c8aiBoW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZJ/6y/plmIaavh0DJPYEz1FsZplc09pLM5uU9CtsUbAc3i8eEdV4N5nF4TPg6kYbgq
         64wWk0ybXGPI2ncBzUpSYyd1E8c/py8FpSuv4ufTkC3EY2BcHj1886T4+fVq7RkVB2n5
         jegBwyTSDHHncxUMnzD59JsxxsVkyOLMc0sSk=
Received: by 10.210.13.17 with SMTP id 17mr1630236ebm.1.1214604473515;
        Fri, 27 Jun 2008 15:07:53 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b36sm2441604ika.5.2008.06.27.15.07.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:50 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86651>

This class perform analogous operations as FetchProcess. It processes
refs advertised by connection, updates RemoteRefUpdates and
local tracking branches - TrackingRefUpdates.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/PushProcess.java    |  224 ++++++++++++++++++++
 1 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
new file mode 100644
index 0000000..f742949
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
@@ -0,0 +1,224 @@
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
+ * - Neither the name of the Git Development Community nor the
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
+import java.util.Collection;
+import java.util.HashMap;
+import java.util.Map;
+
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+/**
+ * Class performing push operation on remote repository.
+ * 
+ * @see Transport#push(ProgressMonitor, Collection)
+ */
+class PushProcess {
+	/** Task name for {@link ProgressMonitor} used during opening connection. */
+	static final String PROGRESS_OPENING_CONNECTION = "Opening connection";
+
+	/** Transport used to perform this operation. */
+	private final Transport transport;
+
+	/** Push operation connection created to perform this operation */
+	private PushConnection connection;
+
+	/** Refs to update on remote side. */
+	private final Map<String, RemoteRefUpdate> toPush;
+
+	/** Revision walker for checking some updates properties. */
+	private final RevWalk walker;
+
+	/**
+	 * Create process for specified transport and refs updates specification.
+	 * 
+	 * @param transport
+	 *            transport between remote and local repository, used to create
+	 *            connection.
+	 * @param toPush
+	 *            specification of refs updates (and local tracking branches).
+	 * @throws TransportException
+	 */
+	PushProcess(final Transport transport,
+			final Collection<RemoteRefUpdate> toPush) throws TransportException {
+		this.walker = new RevWalk(transport.local);
+		this.transport = transport;
+		this.toPush = new HashMap<String, RemoteRefUpdate>();
+		for (final RemoteRefUpdate rru : toPush) {
+			if (this.toPush.put(rru.getRemoteName(), rru) != null)
+				throw new TransportException(
+						"Duplicate remote ref update is illegal. Affected remote name: "
+								+ rru.getRemoteName());
+		}
+	}
+
+	/**
+	 * Perform push operation between local and remote repository - set remote
+	 * refs appropriately, send needed objects and update local tracking refs.
+	 * 
+	 * @param monitor
+	 *            progress monitor used for feedback about operation.
+	 * @return result of push operation with complete status description.
+	 * @throws NotSupportedException
+	 *             when push operation is not supported by provided transport.
+	 * @throws TransportException
+	 *             when some error occurred during operation, like I/O, protocol
+	 *             error, or local database consistency error.
+	 */
+	PushResult execute(final ProgressMonitor monitor)
+			throws NotSupportedException, TransportException {
+		monitor.beginTask(PROGRESS_OPENING_CONNECTION, ProgressMonitor.UNKNOWN);
+		connection = transport.openPush();
+		try {
+			monitor.endTask();
+
+			final Map<String, RemoteRefUpdate> preprocessed = prepareRemoteUpdates();
+			if (!preprocessed.isEmpty())
+				connection.push(monitor, preprocessed);
+		} finally {
+			connection.close();
+		}
+		updateTrackingRefs();
+		return prepareOperationResult();
+	}
+
+	private Map<String, RemoteRefUpdate> prepareRemoteUpdates()
+			throws TransportException {
+		final Map<String, RemoteRefUpdate> result = new HashMap<String, RemoteRefUpdate>();
+		for (final RemoteRefUpdate rru : toPush.values()) {
+			final Ref advertisedRef = connection.getRef(rru.getRemoteName());
+			final ObjectId advertisedOld = (advertisedRef == null ? ObjectId
+					.zeroId() : advertisedRef.getObjectId());
+
+			if (rru.getNewObjectId().equals(advertisedOld)) {
+				if (rru.isDelete()) {
+					// ref does exist neither locally nor remotely
+					rru.setStatus(Status.NON_EXISTING);
+				} else {
+					// same object - nothing to do
+					rru.setStatus(Status.UP_TO_DATE);
+				}
+				continue;
+			}
+
+			// caller has explicitly specified expected old object id, while it
+			// has been changed in the mean time - reject
+			if (rru.isExpectingOldObjectId()
+					&& !rru.getExpectedOldObjectId().equals(advertisedOld)) {
+				rru.setStatus(Status.REJECTED_REMOTE_CHANGED);
+				continue;
+			}
+
+			// create ref (hasn't existed on remote side) and delete ref
+			// are always fast-forward commands, feasible at this level
+			if (advertisedOld.equals(ObjectId.zeroId()) || rru.isDelete()) {
+				rru.setFastForward(true);
+				result.put(rru.getRemoteName(), rru);
+				continue;
+			}
+
+			// check for fast-forward:
+			// - both old and new ref must point to commits, AND
+			// - both of them must be known for us, exist in repository, AND
+			// - old commit must be ancestor of new commit
+			boolean fastForward = true;
+			try {
+				RevObject oldRev = walker.parseAny(advertisedOld);
+				final RevObject newRev = walker.parseAny(rru.getNewObjectId());
+				if (!(oldRev instanceof RevCommit)
+						|| !(newRev instanceof RevCommit)
+						|| !walker.isMergedInto((RevCommit) oldRev,
+								(RevCommit) newRev))
+					fastForward = false;
+			} catch (MissingObjectException x) {
+				fastForward = false;
+			} catch (Exception x) {
+				throw new TransportException(transport.getURI()
+						+ ": reading objects from local repository failed: "
+						+ x.getMessage(), x);
+			}
+			rru.setFastForward(fastForward);
+			if (!fastForward && !rru.isForceUpdate())
+				rru.setStatus(Status.REJECTED_NONFASTFORWARD);
+			else
+				result.put(rru.getRemoteName(), rru);
+		}
+		return result;
+	}
+
+	private void updateTrackingRefs() {
+		for (final RemoteRefUpdate rru : toPush.values()) {
+			final Status status = rru.getStatus();
+			if (rru.hasTrackingRefUpdate()
+					&& (status == Status.UP_TO_DATE || status == Status.OK)) {
+				// update local tracking branch only when there is a chance that
+				// it has changed; this is possible for:
+				// -updated (OK) status,
+				// -up to date (UP_TO_DATE) status
+				try {
+					rru.updateTrackingRef(walker);
+				} catch (IOException e) {
+					// ignore as RefUpdate has stored I/O error status
+				}
+			}
+		}
+	}
+
+	private PushResult prepareOperationResult() {
+		final PushResult result = new PushResult();
+		result.setAdvertisedRefs(connection.getRefsMap());
+		result.setRemoteUpdates(toPush);
+
+		for (final RemoteRefUpdate rru : toPush.values()) {
+			final TrackingRefUpdate tru = rru.getTrackingRefUpdate();
+			if (tru != null)
+				result.add(tru);
+		}
+		return result;
+	}
+}
-- 
1.5.5.3
