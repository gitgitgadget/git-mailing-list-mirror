From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 11/31] Clean up exception issues in RemoteRefUpdate
Date: Sun, 17 Aug 2008 22:43:52 +0200
Message-ID: <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp96-00038o-D3
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbYHQUo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbYHQUo5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:57 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbYHQUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:55 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Yzj5keF9Bce8o7Yshq9KaGqQzsZkN8X63U6/dkp6m7A=;
        b=rYPXA4Quf1wbSH1iEp1Jq1aGu00h8oUMWOaoZ17pD71LjBB6635c2XUOmgioVZcxXQ
         atdGKBHUizHmAuDlziiW4HNgZf3fqTzhZ1g7p8ONg8e8BCchfncFD8ldDjPncaXqD3u0
         rZOgxju0KcLhCE8n2ZQ0EaVorQTu5QoZVlEnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g/lvbYtEuh77ZdHwt7kAV97NDJiDi16UomaxFpDk8o6mxkTphGQ6yAsPrR/5DYYlfn
         AkGDmC2rNHJqZCfzCyveWn4s1M+5jZI8+oD8oLwi8yOpC7hDt2zf1u6FLMeUKqu3ZG8N
         frcGDw4LRSBz0M6tTAzROQJgnQnaa7NGkfbzE=
Received: by 10.103.219.18 with SMTP id w18mr3463734muq.121.1219005894770;
        Sun, 17 Aug 2008 13:44:54 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id t10sm2114469muh.16.2008.08.17.13.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92642>

IllegalArgumentException was probably a wrong choice for exception
thrown in RemoteRefUpdate when src object can't be resolved - it should
be checked one.

Now it's IOException, which makes call more safe for external clients.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   12 +++---
 .../src/org/spearce/jgit/transport/Transport.java  |   48 +++++++++----------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index 7db6c55..5afb8a4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -166,23 +166,23 @@ public class RemoteRefUpdate {
 	 *            remote ref with this name.
 	 * @throws IOException
 	 *             when I/O error occurred during creating
-	 *             {@link TrackingRefUpdate} for local tracking branch.
+	 *             {@link TrackingRefUpdate} for local tracking branch or srcRef
+	 *             can't be resolved to any object.
 	 * @throws IllegalArgumentException
-	 *             if some required parameter was null or srcRef can't be
-	 *             resolved to any object.
+	 *             if some required parameter was null
 	 */
 	public RemoteRefUpdate(final Repository db, final String srcRef,
 			final String remoteName, final boolean forceUpdate,
 			final String localName, final ObjectId expectedOldObjectId)
 			throws IOException {
 		if (remoteName == null)
-			throw new IllegalArgumentException("remote name can't be null");
+			throw new IllegalArgumentException("Remote name can't be null.");
 		this.srcRef = srcRef;
 		this.newObjectId = (srcRef == null ? ObjectId.zeroId() : db
 				.resolve(srcRef));
 		if (newObjectId == null)
-			throw new IllegalArgumentException(
-					"source ref doesn't resolve to any object");
+			throw new IOException("Source ref " + srcRef
+					+ " doesn't resolve to any object.");
 		this.remoteName = remoteName;
 		this.forceUpdate = forceUpdate;
 		if (localName != null && db != null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 8e42516..939347e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -39,6 +39,7 @@
 
 package org.spearce.jgit.transport;
 
+import java.io.IOException;
 import java.net.URISyntaxException;
 import java.util.ArrayList;
 import java.util.Collection;
@@ -211,7 +212,7 @@ public abstract class Transport {
 
 		throw new NotSupportedException("URI not supported: " + remote);
 	}
-	
+
 	/**
 	 * Convert push remote refs update specification from {@link RefSpec} form
 	 * to {@link RemoteRefUpdate}. Conversion expands wildcards by matching
@@ -228,38 +229,29 @@ public abstract class Transport {
 	 *            fetch specifications used for finding localtracking refs. May
 	 *            be null or empty collection.
 	 * @return collection of set up {@link RemoteRefUpdate}.
-	 * @throws TransportException
+	 * @throws IOException
 	 *             when problem occurred during conversion or specification set
 	 *             up: most probably, missing objects or refs.
 	 */
 	public static Collection<RemoteRefUpdate> findRemoteRefUpdatesFor(
 			final Repository db, final Collection<RefSpec> specs,
-			Collection<RefSpec> fetchSpecs) throws TransportException {
+			Collection<RefSpec> fetchSpecs) throws IOException {
 		if (fetchSpecs == null)
 			fetchSpecs = Collections.emptyList();
 		final List<RemoteRefUpdate> result = new LinkedList<RemoteRefUpdate>();
 		final Collection<RefSpec> procRefs = expandPushWildcardsFor(db, specs);
 
 		for (final RefSpec spec : procRefs) {
-			try {
-				final String srcRef = spec.getSource();
-				// null destination (no-colon in ref-spec) is a special case
-				final String remoteName = (spec.getDestination() == null ? spec
-						.getSource() : spec.getDestination());
-				final boolean forceUpdate = spec.isForceUpdate();
-				final String localName = findTrackingRefName(remoteName,
-						fetchSpecs);
-
-				final RemoteRefUpdate rru = new RemoteRefUpdate(db, srcRef,
-						remoteName, forceUpdate, localName, null);
-				result.add(rru);
-			} catch (TransportException x) {
-				throw x;
-			} catch (Exception x) {
-				throw new TransportException(
-						"Problem with resolving push ref spec \"" + spec
-								+ "\" locally: " + x.getMessage(), x);
-			}
+			final String srcRef = spec.getSource();
+			// null destination (no-colon in ref-spec) is a special case
+			final String remoteName = (spec.getDestination() == null ? spec
+					.getSource() : spec.getDestination());
+			final boolean forceUpdate = spec.isForceUpdate();
+			final String localName = findTrackingRefName(remoteName, fetchSpecs);
+
+			final RemoteRefUpdate rru = new RemoteRefUpdate(db, srcRef,
+					remoteName, forceUpdate, localName, null);
+			result.add(rru);
 		}
 		return result;
 	}
@@ -643,7 +635,13 @@ public abstract class Transport {
 			TransportException {
 		if (toPush == null || toPush.isEmpty()) {
 			// If the caller did not ask for anything use the defaults.
-			toPush = findRemoteRefUpdatesFor(push);
+			try {
+				toPush = findRemoteRefUpdatesFor(push);
+			} catch (final IOException e) {
+				throw new TransportException(
+						"Problem with resolving push ref specs locally: "
+								+ e.getMessage(), e);
+			}
 			if (toPush.isEmpty())
 				throw new TransportException("Nothing to push.");
 		}
@@ -665,12 +663,12 @@ public abstract class Transport {
 	 * @param specs
 	 *            collection of RefSpec to convert.
 	 * @return collection of set up {@link RemoteRefUpdate}.
-	 * @throws TransportException
+	 * @throws IOException
 	 *             when problem occurred during conversion or specification set
 	 *             up: most probably, missing objects or refs.
 	 */
 	public Collection<RemoteRefUpdate> findRemoteRefUpdatesFor(
-			final Collection<RefSpec> specs) throws TransportException {
+			final Collection<RefSpec> specs) throws IOException {
 		return findRemoteRefUpdatesFor(local, specs, fetch);
 	}
 
-- 
1.5.6.3
