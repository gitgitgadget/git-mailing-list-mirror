From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH (resending) 1/3] Changed Transport class hierarchy basing 
	on underlying transport
Date: Fri, 17 Apr 2009 19:25:26 +0400
Message-ID: <85647ef50904170825u1bee4d03sdf64e0134adbc4b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 17:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luq3P-0004gG-1e
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZDQPaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbZDQPay
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:30:54 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:63619 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZDQPaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:30:52 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 11:30:50 EDT
Received: by bwz7 with SMTP id 7so215644bwz.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+7iYx9OanxEyGuLKYX9+DxBXqe96XW73zS6qqkhc70Q=;
        b=DlLNxMTPy+2SMRk3mfQkOWQLm1jZzvWaNh8Q9X7E7TZeaXUEYktYxRh9IrLKBQnvuJ
         P3DzDrsON2azs7/q45sQX5Y0CFdcRUX9pf+AA1vj8ELTHTE7NCcerQf94jZxTmqFvqen
         YnTFWXfv3XG0bjgJ+E0Fz149VjaMU6mV8KscM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mX5BHasnvbkiP9XqEbhHw6stvT99exY3CuvvubYNxR9hCru9ZxOhEz/hwmqxo/X/F2
         ung/yk0qvwa0LRrYZNCH3VQds6T8IOr7alROLE+YiaeTE1zy0YCIR/Cl0O2n+o6f9Ybl
         QoKI34SgunYGi57bAoiEnKCctepH5484cE4+8=
Received: by 10.204.66.17 with SMTP id l17mr2415848bki.51.1239981926087; Fri, 
	17 Apr 2009 08:25:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116748>

Instead of WalkTransport and PackTransport the transports
are now using SshTransport, TcpTransport, and HttpTransport,
indicating the type of basic underlying protocol is dealt
with. This lays groundwork for supplying transport specific
properties in the future. The WalkTransport and PackTransport
are now marker interfaces.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
Resending the patch as is through git imap-send

 .../spearce/jgit/transport/BasePackConnection.java |    8 +-
 .../jgit/transport/BasePackFetchConnection.java    |    4 +-
 .../jgit/transport/BasePackPushConnection.java     |    4 +-
 .../jgit/transport/BundleFetchConnection.java      |  247 ++++++++++++++++++++
 .../org/spearce/jgit/transport/HttpTransport.java  |   62 +++++
 .../org/spearce/jgit/transport/PackTransport.java  |   12 +-
 .../org/spearce/jgit/transport/SshTransport.java   |   62 +++++
 .../org/spearce/jgit/transport/TcpTransport.java   |   62 +++++
 .../spearce/jgit/transport/TransportAmazonS3.java  |    2 +-
 .../spearce/jgit/transport/TransportBundle.java    |  227 +-----------------
 .../jgit/transport/TransportBundleFile.java        |   16 ++-
 .../jgit/transport/TransportBundleStream.java      |   11 +-
 .../spearce/jgit/transport/TransportGitAnon.java   |    2 +-
 .../spearce/jgit/transport/TransportGitSsh.java    |    2 +-
 .../org/spearce/jgit/transport/TransportHttp.java  |    9 +-
 .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |    2 +-
 .../jgit/transport/WalkFetchConnection.java        |    3 +-
 .../spearce/jgit/transport/WalkPushConnection.java |    5 +-
 .../org/spearce/jgit/transport/WalkTransport.java  |   21 +--
 20 files changed, 497 insertions(+), 266 deletions(-)
 create mode 100644
org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
 create mode 100644
org.spearce.jgit/src/org/spearce/jgit/transport/HttpTransport.java
 create mode 100644
org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
 create mode 100644
org.spearce.jgit/src/org/spearce/jgit/transport/TcpTransport.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index c9232ce..c6440c7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -73,7 +73,7 @@
 	protected final URIish uri;

 	/** A transport connected to {@link #uri}. */
-	protected final PackTransport transport;
+	protected final Transport transport;

 	/** Buffered input stream reading from the remote. */
 	protected InputStream in;
@@ -97,9 +97,9 @@
 	protected final Set<ObjectId> additionalHaves = new HashSet<ObjectId>();

 	BasePackConnection(final PackTransport packTransport) {
-		local = packTransport.local;
-		uri = packTransport.uri;
-		transport = packTransport;
+		transport = (Transport)packTransport;
+		local = transport.local;
+		uri = transport.uri;
 	}

 	protected void init(final InputStream myIn, final OutputStream myOut) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 19ac161..b75e0ef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -128,8 +128,8 @@

 	BasePackFetchConnection(final PackTransport packTransport) {
 		super(packTransport);
-		includeTags = packTransport.getTagOpt() != TagOpt.NO_TAGS;
-		thinPack = packTransport.isFetchThin();
+		includeTags = transport.getTagOpt() != TagOpt.NO_TAGS;
+		thinPack = transport.isFetchThin();

 		walk = new RevWalk(local);
 		reachableCommits = new RevCommitList<RevCommit>();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index dde1d26..07e8cb9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -88,8 +88,8 @@

 	private boolean writePack;

-	BasePackPushConnection(final PackTransport transport) {
-		super(transport);
+	BasePackPushConnection(final PackTransport packTransport) {
+		super(packTransport);
 		thinPack = transport.isPushThin();
 	}

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
new file mode 100644
index 0000000..7ab6c6d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
@@ -0,0 +1,247 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.transport;
+
+import java.io.BufferedInputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.HashSet;
+import java.util.LinkedHashMap;
+import java.util.List;
+import java.util.Set;
+
+import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.util.RawParseUtils;
+
+/**
+ * Fetch connection for bundle based classes. It used by
+ * instances of {@link TransportBundle}
+ */
+class BundleFetchConnection extends BaseFetchConnection {
+
+	private final Transport transport;
+
+	InputStream bin;
+
+	final Set<ObjectId> prereqs = new HashSet<ObjectId>();
+
+	BundleFetchConnection(Transport transportBundle, final InputStream
src) throws TransportException {
+		transport = transportBundle;
+		bin = new BufferedInputStream(src, IndexPack.BUFFER_SIZE);
+		try {
+			switch (readSignature()) {
+			case 2:
+				readBundleV2();
+				break;
+			default:
+				throw new TransportException(transport.uri, "not a bundle");
+			}
+		} catch (TransportException err) {
+			close();
+			throw err;
+		} catch (IOException err) {
+			close();
+			throw new TransportException(transport.uri, err.getMessage(), err);
+		} catch (RuntimeException err) {
+			close();
+			throw new TransportException(transport.uri, err.getMessage(), err);
+		}
+	}
+
+	private int readSignature() throws IOException {
+		final String rev = readLine(new byte[1024]);
+		if (TransportBundle.V2_BUNDLE_SIGNATURE.equals(rev))
+			return 2;
+		throw new TransportException(transport.uri, "not a bundle");
+	}
+
+	private void readBundleV2() throws IOException {
+		final byte[] hdrbuf = new byte[1024];
+		final LinkedHashMap<String, Ref> avail = new LinkedHashMap<String, Ref>();
+		for (;;) {
+			String line = readLine(hdrbuf);
+			if (line.length() == 0)
+				break;
+
+			if (line.charAt(0) == '-') {
+				prereqs.add(ObjectId.fromString(line.substring(1, 41)));
+				continue;
+			}
+
+			final String name = line.substring(41, line.length());
+			final ObjectId id = ObjectId.fromString(line.substring(0, 40));
+			final Ref prior = avail.put(name, new Ref(Ref.Storage.NETWORK,
+					name, id));
+			if (prior != null)
+				throw duplicateAdvertisement(name);
+		}
+		available(avail);
+	}
+
+	private PackProtocolException duplicateAdvertisement(final String name) {
+		return new PackProtocolException(transport.uri,
+				"duplicate advertisements of " + name);
+	}
+
+	private String readLine(final byte[] hdrbuf) throws IOException {
+		bin.mark(hdrbuf.length);
+		final int cnt = bin.read(hdrbuf);
+		int lf = 0;
+		while (lf < cnt && hdrbuf[lf] != '\n')
+			lf++;
+		bin.reset();
+		bin.skip(lf);
+		if (lf < cnt && hdrbuf[lf] == '\n')
+			bin.skip(1);
+		return RawParseUtils.decode(Constants.CHARSET, hdrbuf, 0, lf);
+	}
+
+	public boolean didFetchTestConnectivity() {
+		return false;
+	}
+
+	@Override
+	protected void doFetch(final ProgressMonitor monitor,
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException {
+		verifyPrerequisites();
+		try {
+			final IndexPack ip = newIndexPack();
+			ip.index(monitor);
+			ip.renameAndOpenPack();
+		} catch (IOException err) {
+			close();
+			throw new TransportException(transport.uri, err.getMessage(), err);
+		} catch (RuntimeException err) {
+			close();
+			throw new TransportException(transport.uri, err.getMessage(), err);
+		}
+	}
+
+	private IndexPack newIndexPack() throws IOException {
+		final IndexPack ip = IndexPack.create(transport.local, bin);
+		ip.setFixThin(true);
+		ip.setObjectChecking(transport.isCheckFetchedObjects());
+		return ip;
+	}
+
+	private void verifyPrerequisites() throws TransportException {
+		if (prereqs.isEmpty())
+			return;
+
+		final RevWalk rw = new RevWalk(transport.local);
+		final RevFlag PREREQ = rw.newFlag("PREREQ");
+		final RevFlag SEEN = rw.newFlag("SEEN");
+
+		final List<ObjectId> missing = new ArrayList<ObjectId>();
+		final List<RevObject> commits = new ArrayList<RevObject>();
+		for (final ObjectId p : prereqs) {
+			try {
+				final RevCommit c = rw.parseCommit(p);
+				if (!c.has(PREREQ)) {
+					c.add(PREREQ);
+					commits.add(c);
+				}
+			} catch (MissingObjectException notFound) {
+				missing.add(p);
+			} catch (IOException err) {
+				throw new TransportException(transport.uri, "Cannot read commit "
+						+ p.name(), err);
+			}
+		}
+		if (!missing.isEmpty())
+			throw new MissingBundlePrerequisiteException(transport.uri, missing);
+
+		for (final Ref r : transport.local.getAllRefs().values()) {
+			try {
+				rw.markStart(rw.parseCommit(r.getObjectId()));
+			} catch (IOException readError) {
+				// If we cannot read the value of the ref skip it.
+			}
+		}
+
+		int remaining = commits.size();
+		try {
+			RevCommit c;
+			while ((c = rw.next()) != null) {
+				if (c.has(PREREQ)) {
+					c.add(SEEN);
+					if (--remaining == 0)
+						break;
+				}
+			}
+		} catch (IOException err) {
+			throw new TransportException(transport.uri, "Cannot read object", err);
+		}
+
+		if (remaining > 0) {
+			for (final RevObject o : commits) {
+				if (!o.has(SEEN))
+					missing.add(o);
+			}
+			throw new MissingBundlePrerequisiteException(transport.uri, missing);
+		}
+	}
+
+	@Override
+	public void close() {
+		if (bin != null) {
+			try {
+				bin.close();
+			} catch (IOException ie) {
+				// Ignore close failures.
+			} finally {
+				bin = null;
+			}
+		}
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/HttpTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/HttpTransport.java
new file mode 100644
index 0000000..5c60094
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/HttpTransport.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2009, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
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
+package org.spearce.jgit.transport;
+
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The base class for transports that use HTTP as underlying
protocol. This class
+ * allows customizing HTTP connection settings.
+ */
+public abstract class HttpTransport extends Transport {
+
+	/**
+	 * Create a new transport instance.
+	 *
+	 * @param local
+	 *            the repository this instance will fetch into, or push out of.
+	 *            This must be the repository passed to
+	 *            {@link #open(Repository, URIish)}.
+	 * @param uri
+	 *            the URI used to access the remote repository. This must be the
+	 *            URI passed to {@link #open(Repository, URIish)}.
+	 */
+	public HttpTransport(Repository local, URIish uri) {
+		super(local, uri);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
index 50708d3..522022e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
  *
  * All rights reserved.
  *
@@ -34,13 +35,10 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-
 package org.spearce.jgit.transport;

-import org.spearce.jgit.lib.Repository;
-
 /**
- * Canonical implementation of an object transport using Git pack transfers.
+ * Marker interface an object transport using Git pack transfers.
  * <p>
  * Implementations of PackTransport setup connections and move objects back and
  * forth by creating pack files on the source side and indexing them on the
@@ -49,8 +47,6 @@
  * @see BasePackFetchConnection
  * @see BasePackPushConnection
  */
-abstract class PackTransport extends Transport {
-	PackTransport(final Repository local, final URIish u) {
-		super(local, u);
-	}
+public interface PackTransport {
+	// no methods in marker interface
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
new file mode 100644
index 0000000..4532590
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2009, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
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
+package org.spearce.jgit.transport;
+
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The base class for transports that use SSH protocol. This class
+ * allows customizing SSH connection settings.
+ */
+public abstract class SshTransport extends TcpTransport {
+
+	/**
+	 * Create a new transport instance.
+	 *
+	 * @param local
+	 *            the repository this instance will fetch into, or push out of.
+	 *            This must be the repository passed to
+	 *            {@link #open(Repository, URIish)}.
+	 * @param uri
+	 *            the URI used to access the remote repository. This must be the
+	 *            URI passed to {@link #open(Repository, URIish)}.
+	 */
+	public SshTransport(Repository local, URIish uri) {
+		super(local, uri);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TcpTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TcpTransport.java
new file mode 100644
index 0000000..82ef1cc
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TcpTransport.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2009, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
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
+package org.spearce.jgit.transport;
+
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The base class for transports based on TCP sockets. This class
+ * holds settings common for all TCP based transports.
+ */
+public abstract class TcpTransport extends Transport {
+
+	/**
+	 * Create a new transport instance.
+	 *
+	 * @param local
+	 *            the repository this instance will fetch into, or push out of.
+	 *            This must be the repository passed to
+	 *            {@link #open(Repository, URIish)}.
+	 * @param uri
+	 *            the URI used to access the remote repository. This must be the
+	 *            URI passed to {@link #open(Repository, URIish)}.
+	 */
+	public TcpTransport(Repository local, URIish uri) {
+		super(local, uri);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
index a9fcdb9..f09060f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -85,7 +85,7 @@
  * @see WalkFetchConnection
  * @see WalkPushConnection
  */
-class TransportAmazonS3 extends WalkTransport {
+public class TransportAmazonS3 extends HttpTransport implements WalkTransport {
 	static final String S3_SCHEME = "amazon-s3";

 	static boolean canHandle(final URIish uri) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 1734d94..7dca433 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -39,230 +39,17 @@

 package org.spearce.jgit.transport;

-import java.io.BufferedInputStream;
-import java.io.IOException;
-import java.io.InputStream;
-import java.util.ArrayList;
-import java.util.Collection;
-import java.util.HashSet;
-import java.util.LinkedHashMap;
-import java.util.List;
-import java.util.Set;
-
-import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
-import org.spearce.jgit.errors.MissingObjectException;
-import org.spearce.jgit.errors.NotSupportedException;
-import org.spearce.jgit.errors.PackProtocolException;
-import org.spearce.jgit.errors.TransportException;
-import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.ObjectId;
-import org.spearce.jgit.lib.ProgressMonitor;
-import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.revwalk.RevCommit;
-import org.spearce.jgit.revwalk.RevFlag;
-import org.spearce.jgit.revwalk.RevObject;
-import org.spearce.jgit.revwalk.RevWalk;
-import org.spearce.jgit.util.RawParseUtils;
-
 /**
- * Supports fetching from a git bundle (sneaker-net object transport).
+ * Marker interface for transports that supports fetching from a git bundle
+ * (sneaker-net object transport).
  * <p>
  * Push support for a bundle is complex, as one does not have a peer to
  * communicate with to decide what the peer already knows. So push is not
  * supported by the bundle transport.
  */
-abstract class TransportBundle extends PackTransport {
-	static final String V2_BUNDLE_SIGNATURE = "# v2 git bundle";
-
-	TransportBundle(final Repository local, final URIish uri) {
-		super(local, uri);
-	}
-
-	@Override
-	public PushConnection openPush() throws NotSupportedException {
-		throw new NotSupportedException(
-				"Push is not supported for bundle transport");
-	}
-
-	@Override
-	public void close() {
-		// Resources must be established per-connection.
-	}
-
-	class BundleFetchConnection extends BaseFetchConnection {
-		InputStream bin;
-
-		final Set<ObjectId> prereqs = new HashSet<ObjectId>();
-
-		BundleFetchConnection(final InputStream src) throws TransportException {
-			bin = new BufferedInputStream(src, IndexPack.BUFFER_SIZE);
-			try {
-				switch (readSignature()) {
-				case 2:
-					readBundleV2();
-					break;
-				default:
-					throw new TransportException(uri, "not a bundle");
-				}
-			} catch (TransportException err) {
-				close();
-				throw err;
-			} catch (IOException err) {
-				close();
-				throw new TransportException(uri, err.getMessage(), err);
-			} catch (RuntimeException err) {
-				close();
-				throw new TransportException(uri, err.getMessage(), err);
-			}
-		}
-
-		private int readSignature() throws IOException {
-			final String rev = readLine(new byte[1024]);
-			if (V2_BUNDLE_SIGNATURE.equals(rev))
-				return 2;
-			throw new TransportException(uri, "not a bundle");
-		}
-
-		private void readBundleV2() throws IOException {
-			final byte[] hdrbuf = new byte[1024];
-			final LinkedHashMap<String, Ref> avail = new LinkedHashMap<String, Ref>();
-			for (;;) {
-				String line = readLine(hdrbuf);
-				if (line.length() == 0)
-					break;
-
-				if (line.charAt(0) == '-') {
-					prereqs.add(ObjectId.fromString(line.substring(1, 41)));
-					continue;
-				}
-
-				final String name = line.substring(41, line.length());
-				final ObjectId id = ObjectId.fromString(line.substring(0, 40));
-				final Ref prior = avail.put(name, new Ref(Ref.Storage.NETWORK,
-						name, id));
-				if (prior != null)
-					throw duplicateAdvertisement(name);
-			}
-			available(avail);
-		}
-
-		private PackProtocolException duplicateAdvertisement(final String name) {
-			return new PackProtocolException(uri,
-					"duplicate advertisements of " + name);
-		}
-
-		private String readLine(final byte[] hdrbuf) throws IOException {
-			bin.mark(hdrbuf.length);
-			final int cnt = bin.read(hdrbuf);
-			int lf = 0;
-			while (lf < cnt && hdrbuf[lf] != '\n')
-				lf++;
-			bin.reset();
-			bin.skip(lf);
-			if (lf < cnt && hdrbuf[lf] == '\n')
-				bin.skip(1);
-			return RawParseUtils.decode(Constants.CHARSET, hdrbuf, 0, lf);
-		}
-
-		public boolean didFetchTestConnectivity() {
-			return false;
-		}
-
-		@Override
-		protected void doFetch(final ProgressMonitor monitor,
-				final Collection<Ref> want, final Set<ObjectId> have)
-				throws TransportException {
-			verifyPrerequisites();
-			try {
-				final IndexPack ip = newIndexPack();
-				ip.index(monitor);
-				ip.renameAndOpenPack();
-			} catch (IOException err) {
-				close();
-				throw new TransportException(uri, err.getMessage(), err);
-			} catch (RuntimeException err) {
-				close();
-				throw new TransportException(uri, err.getMessage(), err);
-			}
-		}
-
-		private IndexPack newIndexPack() throws IOException {
-			final IndexPack ip = IndexPack.create(local, bin);
-			ip.setFixThin(true);
-			ip.setObjectChecking(TransportBundle.this.isCheckFetchedObjects());
-			return ip;
-		}
-
-		private void verifyPrerequisites() throws TransportException {
-			if (prereqs.isEmpty())
-				return;
-
-			final RevWalk rw = new RevWalk(local);
-			final RevFlag PREREQ = rw.newFlag("PREREQ");
-			final RevFlag SEEN = rw.newFlag("SEEN");
-
-			final List<ObjectId> missing = new ArrayList<ObjectId>();
-			final List<RevObject> commits = new ArrayList<RevObject>();
-			for (final ObjectId p : prereqs) {
-				try {
-					final RevCommit c = rw.parseCommit(p);
-					if (!c.has(PREREQ)) {
-						c.add(PREREQ);
-						commits.add(c);
-					}
-				} catch (MissingObjectException notFound) {
-					missing.add(p);
-				} catch (IOException err) {
-					throw new TransportException(uri, "Cannot read commit "
-							+ p.name(), err);
-				}
-			}
-			if (!missing.isEmpty())
-				throw new MissingBundlePrerequisiteException(uri, missing);
-
-			for (final Ref r : local.getAllRefs().values()) {
-				try {
-					rw.markStart(rw.parseCommit(r.getObjectId()));
-				} catch (IOException readError) {
-					// If we cannot read the value of the ref skip it.
-				}
-			}
-
-			int remaining = commits.size();
-			try {
-				RevCommit c;
-				while ((c = rw.next()) != null) {
-					if (c.has(PREREQ)) {
-						c.add(SEEN);
-						if (--remaining == 0)
-							break;
-					}
-				}
-			} catch (IOException err) {
-				throw new TransportException(uri, "Cannot read object", err);
-			}
-
-			if (remaining > 0) {
-				for (final RevObject o : commits) {
-					if (!o.has(SEEN))
-						missing.add(o);
-				}
-				throw new MissingBundlePrerequisiteException(uri, missing);
-			}
-		}
-
-		@Override
-		public void close() {
-			if (bin != null) {
-				try {
-					bin.close();
-				} catch (IOException ie) {
-					// Ignore close failures.
-				} finally {
-					bin = null;
-				}
-			}
-		}
-	}
+public interface TransportBundle extends PackTransport {
+	/**
+	 * Bundle signature
+	 */
+	public static final String V2_BUNDLE_SIGNATURE = "# v2 git bundle";
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
index c9ff1b2..91f076d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
@@ -47,7 +47,7 @@
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.FS;

-class TransportBundleFile extends TransportBundle {
+class TransportBundleFile extends Transport implements TransportBundle {
 	static boolean canHandle(final URIish uri) {
 		if (uri.getHost() != null || uri.getPort() > 0 || uri.getUser() != null
 				|| uri.getPass() != null || uri.getPath() == null)
@@ -77,6 +77,18 @@ public FetchConnection openFetch() throws
NotSupportedException,
 		} catch (FileNotFoundException err) {
 			throw new TransportException(uri, "not found");
 		}
-		return new BundleFetchConnection(src);
+		return new BundleFetchConnection(this, src);
 	}
+
+	@Override
+	public PushConnection openPush() throws NotSupportedException {
+		throw new NotSupportedException(
+				"Push is not supported for bundle transport");
+	}
+
+	@Override
+	public void close() {
+		// Resources must be established per-connection.
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
index 611ad3b..71c0723 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
@@ -40,6 +40,7 @@
 import java.io.IOException;
 import java.io.InputStream;

+import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;

@@ -50,7 +51,7 @@
  * transport to opening at most one FetchConnection before needing to recreate
  * the transport instance.
  */
-public class TransportBundleStream extends TransportBundle {
+public class TransportBundleStream extends Transport implements
TransportBundle {
 	private InputStream src;

 	/**
@@ -84,13 +85,19 @@ public FetchConnection openFetch() throws
TransportException {
 		if (src == null)
 			throw new TransportException(uri, "Only one fetch supported");
 		try {
-			return new BundleFetchConnection(src);
+			return new BundleFetchConnection(this, src);
 		} finally {
 			src = null;
 		}
 	}

 	@Override
+	public PushConnection openPush() throws NotSupportedException {
+		throw new NotSupportedException(
+				"Push is not supported for bundle transport");
+	}
+
+	@Override
 	public void close() {
 		if (src != null) {
 			try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index a11f293..add7e2a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -55,7 +55,7 @@
  * the IANA registered port 9418. It is a popular means for distributing open
  * source projects, as there are no authentication or authorization overheads.
  */
-class TransportGitAnon extends PackTransport {
+class TransportGitAnon extends TcpTransport implements PackTransport {
 	static final int GIT_PORT = Daemon.DEFAULT_PORT;

 	static boolean canHandle(final URIish uri) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index d4bf466..1f69ed7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -64,7 +64,7 @@
  * assumes there are Git specific smarts on the remote side to perform object
  * enumeration, save file modification and hook execution.
  */
-class TransportGitSsh extends PackTransport {
+public class TransportGitSsh extends SshTransport implements PackTransport {
 	static boolean canHandle(final URIish uri) {
 		if (!uri.isRemote())
 			return false;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index fe4a437..da0dfd9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -69,7 +69,7 @@
  *
  * @see WalkFetchConnection
  */
-class TransportHttp extends WalkTransport {
+public class TransportHttp extends HttpTransport implements WalkTransport {
 	static boolean canHandle(final URIish uri) {
 		if (!uri.isRemote())
 			return false;
@@ -107,6 +107,13 @@ public FetchConnection openFetch() throws
TransportException {
 	}

 	@Override
+	public PushConnection openPush() throws NotSupportedException,
+			TransportException {
+		final String s = getURI().getScheme();
+		throw new NotSupportedException("Push not supported over " + s + ".");
+	}
+
+	@Override
 	public void close() {
 		// No explicit connections are maintained.
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index 17d95c2..d5a6c14 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -60,7 +60,7 @@
  * {@link TransportGitSsh} implementation causes the remote side to run a C Git
  * process.
  */
-class TransportLocal extends PackTransport {
+class TransportLocal extends Transport implements PackTransport {
 	private static final String PWD = ".";

 	static boolean canHandle(final URIish uri) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index d8b4ff7..50bd564 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -87,7 +87,7 @@
  *
  * @see WalkFetchConnection
  */
-class TransportSftp extends WalkTransport {
+public class TransportSftp extends SshTransport implements WalkTransport {
 	static boolean canHandle(final URIish uri) {
 		return uri.isRemote() && "sftp".equals(uri.getScheme());
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 93b5bd2..6912a1f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -167,7 +167,8 @@
 	 */
 	private final HashMap<ObjectId, List<Throwable>> fetchErrors;

-	WalkFetchConnection(final WalkTransport wt, final
WalkRemoteObjectDatabase w) {
+	WalkFetchConnection(final WalkTransport t, final WalkRemoteObjectDatabase w) {
+		Transport wt = (Transport)t;
 		local = wt.local;
 		objCheck = wt.isCheckFetchedObjects() ? new ObjectChecker() : null;

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index acdb5b8..b9b9ae1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -114,8 +114,9 @@

 	WalkPushConnection(final WalkTransport walkTransport,
 			final WalkRemoteObjectDatabase w) {
-		local = walkTransport.local;
-		uri = walkTransport.getURI();
+		Transport t = (Transport)walkTransport;
+		local = t.local;
+		uri = t.getURI();
 		dest = w;
 	}

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
index 87949a6..4d54e17 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, JetBrains s.r.o.
  *
  * All rights reserved.
  *
@@ -34,15 +35,10 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-
 package org.spearce.jgit.transport;

-import org.spearce.jgit.errors.NotSupportedException;
-import org.spearce.jgit.errors.TransportException;
-import org.spearce.jgit.lib.Repository;
-
 /**
- * Canonical implementation of an object transport walking transport.
+ * Marker interface for an object transport walking transport.
  * <p>
  * Implementations of WalkTransport transfer individual objects one at a time
  * from the loose objects directory, or entire packs if the source
side does not
@@ -53,15 +49,6 @@
  *
  * @see WalkFetchConnection
  */
-abstract class WalkTransport extends Transport {
-	WalkTransport(final Repository local, final URIish u) {
-		super(local, u);
-	}
-
-	@Override
-	public PushConnection openPush() throws NotSupportedException,
-			TransportException {
-		final String s = getURI().getScheme();
-		throw new NotSupportedException("Push not supported over " + s + ".");
-	}
+public interface WalkTransport {
+	// no methods in marker interface
 }
-- 
1.6.0.2.1172.ga5ed0
