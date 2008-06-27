From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 06/23] Refactor: extract superclass OperationResult from FetchResult
Date: Sat, 28 Jun 2008 00:06:30 +0200
Message-ID: <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7e-0000rw-9e
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbYF0WHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbYF0WHV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbYF0WHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:16 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5XV5H2Od8dTAgVt1US9n+04RubdeI3FAhFtumzpokbo=;
        b=ICB+qw2SgCjCyWKnha00laYzg5Leq/uXxJreVv23+eU4cqWp+thHoDTLnAY9PxJWRH
         ylNsxVHmVRGOKyCcw7qAOMzjEt0rJvTcs8FPtbhFZzh+hHOXglqFg6irmawy0eJgAXeJ
         VDIlouZ2vFhAlbon71MiIDtS2aPme7eSa+2Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cQzxgQGoJzoAT26GF663ymsgd/qDoudMHa1FjJgG2hAJoUe/158UKuMXsy8T2IiYbe
         p3Pmm4RHiphx8w2TvIbXqdZvFQvWBGAjt2hD9gBDSA+PTvaS1j+INVZ6qh4ASJU/0uFM
         39/cERrGAsmEpdX6sd/ra1/hkgwI83USLRqNE=
Received: by 10.210.46.12 with SMTP id t12mr1629455ebt.23.1214604435625;
        Fri, 27 Jun 2008 15:07:15 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id c25sm2437625ika.11.2008.06.27.15.07.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86649>

New superclass holds information about advertised refs and updated
tracking refs, which is all common to fetch and push operations.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/FetchResult.java    |   74 +------------
 .../spearce/jgit/transport/OperationResult.java    |  119 ++++++++++++++++++++
 2 files changed, 120 insertions(+), 73 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchResult.java
index bd94b5f..cc8557f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchResult.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchResult.java
@@ -40,94 +40,22 @@ package org.spearce.jgit.transport;
 
 import java.util.ArrayList;
 import java.util.Collection;
-import java.util.Collections;
 import java.util.List;
-import java.util.Map;
-import java.util.SortedMap;
-import java.util.TreeMap;
-
-import org.spearce.jgit.lib.Ref;
 
 /**
  * Final status after a successful fetch from a remote repository.
  * 
  * @see Transport#fetch(org.spearce.jgit.lib.ProgressMonitor, Collection)
  */
-public class FetchResult {
-	private final SortedMap<String, TrackingRefUpdate> updates;
-
+public class FetchResult extends OperationResult {
 	private final List<FetchHeadRecord> forMerge;
 
-	private Map<String, Ref> advertisedRefs;
-
 	FetchResult() {
-		updates = new TreeMap<String, TrackingRefUpdate>();
 		forMerge = new ArrayList<FetchHeadRecord>();
-		advertisedRefs = Collections.<String, Ref> emptyMap();
-	}
-
-	void add(final TrackingRefUpdate u) {
-		updates.put(u.getLocalName(), u);
 	}
 
 	void add(final FetchHeadRecord r) {
 		if (!r.notForMerge)
 			forMerge.add(r);
 	}
-
-	void setAdvertisedRefs(final Map<String, Ref> ar) {
-		advertisedRefs = ar;
-	}
-
-	/**
-	 * Get the complete list of refs advertised by the remote.
-	 * <p>
-	 * The returned refs may appear in any order. If the caller needs these to
-	 * be sorted, they should be copied into a new array or List and then sorted
-	 * by the caller as necessary.
-	 * 
-	 * @return available/advertised refs. Never null. Not modifiable. The
-	 *         collection can be empty if the remote side has no refs (it is an
-	 *         empty/newly created repository).
-	 */
-	public Collection<Ref> getAdvertisedRefs() {
-		return advertisedRefs.values();
-	}
-
-	/**
-	 * Get a single advertised ref by name.
-	 * <p>
-	 * The name supplied should be valid ref name. To get a peeled value for a
-	 * ref (aka <code>refs/tags/v1.0^{}</code>) use the base name (without
-	 * the <code>^{}</code> suffix) and look at the peeled object id.
-	 * 
-	 * @param name
-	 *            name of the ref to obtain.
-	 * @return the requested ref; null if the remote did not advertise this ref.
-	 */
-	public final Ref getAdvertisedRef(final String name) {
-		return advertisedRefs.get(name);
-	}
-
-	/**
-	 * Get the status of all local tracking refs that were updated.
-	 * 
-	 * @return unmodifiable collection of local updates. Never null. Empty if
-	 *         there were no local tracking refs updated.
-	 */
-	public Collection<TrackingRefUpdate> getTrackingRefUpdates() {
-		return Collections.unmodifiableCollection(updates.values());
-	}
-
-	/**
-	 * Get the status for a specific local tracking ref update.
-	 * 
-	 * @param localName
-	 *            name of the local ref (e.g. "refs/remotes/origin/master").
-	 * @return status of the local ref; null if this local ref was not touched
-	 *         during this fetch.
-	 */
-	public TrackingRefUpdate getTrackingRefUpdate(final String localName) {
-		return updates.get(localName);
-	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
new file mode 100644
index 0000000..9b411e1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Map;
+import java.util.SortedMap;
+import java.util.TreeMap;
+
+import org.spearce.jgit.lib.Ref;
+
+/**
+ * Class holding result of operation on remote repository. This includes refs
+ * advertised by remote repo and local tracking refs updates.
+ */
+public abstract class OperationResult {
+
+	protected Map<String, Ref> advertisedRefs = Collections.emptyMap();
+
+	protected final SortedMap<String, TrackingRefUpdate> updates = new TreeMap<String, TrackingRefUpdate>();
+
+	/**
+	 * Get the complete list of refs advertised by the remote.
+	 * <p>
+	 * The returned refs may appear in any order. If the caller needs these to
+	 * be sorted, they should be copied into a new array or List and then sorted
+	 * by the caller as necessary.
+	 * 
+	 * @return available/advertised refs. Never null. Not modifiable. The
+	 *         collection can be empty if the remote side has no refs (it is an
+	 *         empty/newly created repository).
+	 */
+	public Collection<Ref> getAdvertisedRefs() {
+		return Collections.unmodifiableCollection(advertisedRefs.values());
+	}
+
+	/**
+	 * Get a single advertised ref by name.
+	 * <p>
+	 * The name supplied should be valid ref name. To get a peeled value for a
+	 * ref (aka <code>refs/tags/v1.0^{}</code>) use the base name (without
+	 * the <code>^{}</code> suffix) and look at the peeled object id.
+	 * 
+	 * @param name
+	 *            name of the ref to obtain.
+	 * @return the requested ref; null if the remote did not advertise this ref.
+	 */
+	public final Ref getAdvertisedRef(final String name) {
+		return advertisedRefs.get(name);
+	}
+
+	/**
+	 * Get the status of all local tracking refs that were updated.
+	 * 
+	 * @return unmodifiable collection of local updates. Never null. Empty if
+	 *         there were no local tracking refs updated.
+	 */
+	public Collection<TrackingRefUpdate> getTrackingRefUpdates() {
+		return Collections.unmodifiableCollection(updates.values());
+	}
+
+	/**
+	 * Get the status for a specific local tracking ref update.
+	 * 
+	 * @param localName
+	 *            name of the local ref (e.g. "refs/remotes/origin/master").
+	 * @return status of the local ref; null if this local ref was not touched
+	 *         during this operation.
+	 */
+	public TrackingRefUpdate getTrackingRefUpdate(final String localName) {
+		return updates.get(localName);
+	}
+
+	protected void setAdvertisedRefs(final Map<String, Ref> ar) {
+		advertisedRefs = ar;
+	}
+
+	protected void add(final TrackingRefUpdate u) {
+		updates.put(u.getLocalName(), u);
+	}
+}
\ No newline at end of file
-- 
1.5.5.3
