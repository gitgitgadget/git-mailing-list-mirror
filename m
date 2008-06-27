From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 09/23] Big refactor: *Connection hierarchy
Date: Sat, 28 Jun 2008 00:06:33 +0200
Message-ID: <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7g-0000rw-DF
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbYF0WHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757019AbYF0WHk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbYF0WHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gD+6uh+9227Pk+rDmyt+hQso5rL6rGYbJjG3fPXu83k=;
        b=liTHgmLSKF9DydmLgxJ71jBnH9Hzx8mFRtRtFscENT+ccEkzmCsBOJ3Gn0DWHDIVci
         JqVFdPIy5RJUvRjEC8yl1LFJZmcFzhZZ8hkWEtSWMDTLlDQmlTi8+/easPTyi7auZ+3K
         U7GLFZnLv/iZbD4f2q8gBkc0/wzCtJ9uogKMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uPq4J/5faNBaqolBJj59mRj/PYX2+F5E6fDh35pNsiBh7et7NfKyR68qlmBwSboZOc
         y44IdtLS/lkTGrTAq+I6yleyu1fzrLfW4PcFuyJjQiqtr8+j+RP85HL1Cg3y3AAovK8i
         453qRfSGhTjoamlXd/snyq0kXuXZ1ioPO+q1Q=
Received: by 10.210.82.7 with SMTP id f7mr1586506ebb.140.1214604454333;
        Fri, 27 Jun 2008 15:07:34 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b36sm2441273ika.5.2008.06.27.15.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86653>

New interfaces and base classes are introduced to cope with lack of
multiple inheritance and allow code reuse between fetch and push
operations implementations. Some renames (adding Base prefix) are also
performed to distinct between interfaces and base implementations.

Some generalizations/cleanings in interfaces and implementations
(particularly in Base* classes) were introduced. readAdvertisedRefs() in
BasePackConnection now support both push and fetch advertisements.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/BaseConnection.java |  103 +++++++++
 .../jgit/transport/BaseFetchConnection.java        |   86 ++++++++
 .../spearce/jgit/transport/BasePackConnection.java |  217 ++++++++++++++++++++
 ...onnection.java => BasePackFetchConnection.java} |  165 ++--------------
 .../src/org/spearce/jgit/transport/Connection.java |  104 ++++++++++
 .../spearce/jgit/transport/FetchConnection.java    |  127 ++----------
 .../org/spearce/jgit/transport/FetchProcess.java   |    2 +-
 .../org/spearce/jgit/transport/PackTransport.java  |    3 +-
 .../org/spearce/jgit/transport/PushConnection.java |   56 +++++-
 .../spearce/jgit/transport/TransportBundle.java    |    2 +-
 .../spearce/jgit/transport/TransportGitAnon.java   |    2 +-
 .../spearce/jgit/transport/TransportGitSsh.java    |    2 +-
 .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
 .../jgit/transport/WalkFetchConnection.java        |    2 +-
 14 files changed, 602 insertions(+), 271 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BaseConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
 rename org.spearce.jgit/src/org/spearce/jgit/transport/{PackFetchConnection.java => BasePackFetchConnection.java} (76%)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/Connection.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BaseConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseConnection.java
new file mode 100644
index 0000000..9a6b7df
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseConnection.java
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Ref;
+
+/**
+ * Base helper class for implementing operations connections.
+ * 
+ * @see BasePackConnection
+ * @see BaseFetchConnection
+ */
+abstract class BaseConnection implements Connection {
+
+	private Map<String, Ref> advertisedRefs = Collections.emptyMap();
+
+	private boolean startedOperation;
+
+	public Map<String, Ref> getRefsMap() {
+		return advertisedRefs;
+	}
+
+	public final Collection<Ref> getRefs() {
+		return advertisedRefs.values();
+	}
+
+	public final Ref getRef(final String name) {
+		return advertisedRefs.get(name);
+	}
+
+	public abstract void close();
+
+	/**
+	 * Denote the list of refs available on the remote repository.
+	 * <p>
+	 * Implementors should invoke this method once they have obtained the refs
+	 * that are available from the remote repository.
+	 * 
+	 * @param all
+	 *            the complete list of refs the remote has to offer. This map
+	 *            will be wrapped in an unmodifiable way to protect it, but it
+	 *            does not get copied.
+	 */
+	protected void available(final Map<String, Ref> all) {
+		advertisedRefs = Collections.unmodifiableMap(all);
+	}
+
+	/**
+	 * Helper method for ensuring one-operation per connection. Check whether
+	 * operation was already marked as started, and mark it as started.
+	 * 
+	 * @throws TransportException
+	 *             if operation was already marked as started.
+	 */
+	protected void markStartedOperation() throws TransportException {
+		if (startedOperation)
+			throw new TransportException(
+					"Only one operation call per connection is supported.");
+		startedOperation = true;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
new file mode 100644
index 0000000..7fb13bc
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+
+/**
+ * Base helper class for fetch connection implementations. Provides some common
+ * typical structures and methods used during fetch connection.
+ * <p>
+ * Implementors of fetch over pack-based protocols should consider using
+ * {@link BasePackFetchConnection} instead.
+ * </p>
+ */
+abstract class BaseFetchConnection extends BaseConnection implements
+		FetchConnection {
+	public final void fetch(final ProgressMonitor monitor,
+			final Collection<Ref> want) throws TransportException {
+		markStartedOperation();
+		doFetch(monitor, want);
+	}
+
+	/**
+	 * Default implementation of {@link FetchConnection#didFetchIncludeTags()} -
+	 * returning false.
+	 */
+	public boolean didFetchIncludeTags() {
+		return false;
+	}
+
+	/**
+	 * Implementation of {@link #fetch(ProgressMonitor, Collection)} without
+	 * checking for multiple fetch.
+	 * 
+	 * @param monitor
+	 *            as in {@link #fetch(ProgressMonitor, Collection)}
+	 * @param want
+	 *            as in {@link #fetch(ProgressMonitor, Collection)}
+	 * @throws TransportException
+	 *             as in {@link #fetch(ProgressMonitor, Collection)}, but
+	 *             implementation doesn't have to care about multiple
+	 *             {@link #fetch(ProgressMonitor, Collection)} calls, as it is
+	 *             checked in this class.
+	 */
+	protected abstract void doFetch(final ProgressMonitor monitor,
+			final Collection<Ref> want) throws TransportException;
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
new file mode 100644
index 0000000..d119672
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -0,0 +1,217 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+import java.io.BufferedInputStream;
+import java.io.BufferedOutputStream;
+import java.io.EOFException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.util.HashSet;
+import java.util.LinkedHashMap;
+import java.util.Set;
+
+import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Base helper class for pack-based operations implementations. Provides partial
+ * implementation of pack-protocol - refs advertising and capabilities support,
+ * and some other helper methods.
+ * 
+ * @see BasePackFetchConnection
+ * @see BasePackPushConnection
+ */
+abstract class BasePackConnection extends BaseConnection {
+
+	/** The repository this transport fetches into, or pushes out of. */
+	protected final Repository local;
+
+	/** Remote repository location. */
+	protected final URIish uri;
+
+	/** Buffered input stream reading from the remote. */
+	protected InputStream in;
+
+	/** Buffered output stream sending to the remote. */
+	protected OutputStream out;
+
+	/** Packet line decoder around {@link #in}. */
+	protected PacketLineIn pckIn;
+
+	/** Packet line encoder around {@link #out}. */
+	protected PacketLineOut pckOut;
+
+	/** Capability tokens advertised by the remote side. */
+	private final Set<String> remoteCapablities = new HashSet<String>();
+
+	BasePackConnection(final PackTransport packTransport) {
+		local = packTransport.local;
+		uri = packTransport.uri;
+	}
+
+	protected void init(final InputStream myIn, final OutputStream myOut) {
+		in = myIn instanceof BufferedInputStream ? myIn
+				: new BufferedInputStream(myIn);
+		out = myOut instanceof BufferedOutputStream ? myOut
+				: new BufferedOutputStream(myOut);
+
+		pckIn = new PacketLineIn(in);
+		pckOut = new PacketLineOut(out);
+	}
+
+	protected void readAdvertisedRefs() throws TransportException {
+		try {
+			readAdvertisedRefsImpl();
+		} catch (TransportException err) {
+			close();
+			throw err;
+		} catch (IOException err) {
+			close();
+			throw new TransportException(err.getMessage(), err);
+		} catch (RuntimeException err) {
+			close();
+			throw new TransportException(err.getMessage(), err);
+		}
+	}
+
+	private void readAdvertisedRefsImpl() throws IOException {
+		final LinkedHashMap<String, Ref> avail = new LinkedHashMap<String, Ref>();
+		for (;;) {
+			String line;
+
+			try {
+				line = pckIn.readString();
+			} catch (EOFException eof) {
+				if (avail.isEmpty())
+					throw new TransportException(uri + " not found.");
+				throw eof;
+			}
+
+			if (avail.isEmpty()) {
+				final int nul = line.indexOf('\0');
+				if (nul >= 0) {
+					// The first line (if any) may contain "hidden"
+					// capability values after a NUL byte.
+					for (String c : line.substring(nul + 1).split(" "))
+						remoteCapablities.add(c);
+					line = line.substring(0, nul);
+				}
+
+				if (line.equals("capabilties^{}")) {
+					// special line from git-receive-pack to show
+					// capabilities when there are no refs to advertise
+					continue;
+				}
+			}
+
+			if (line.length() == 0)
+				break;
+
+			String name = line.substring(41, line.length());
+			final ObjectId id = ObjectId.fromString(line.substring(0, 40));
+			if (name.endsWith("^{}")) {
+				name = name.substring(0, name.length() - 3);
+				final Ref prior = avail.get(name);
+				if (prior == null)
+					throw new PackProtocolException(uri + ": advertisement of "
+							+ name + "^{} came before " + name);
+
+				if (prior.getPeeledObjectId() != null)
+					throw duplicateAdvertisement(name + "^{}");
+
+				avail.put(name, new Ref(name, prior.getObjectId(), id));
+			} else {
+				final Ref prior = avail.put(name, new Ref(name, id));
+				if (prior != null)
+					throw duplicateAdvertisement(name);
+			}
+		}
+		available(avail);
+	}
+
+	protected boolean isCapableOf(final String option) {
+		return remoteCapablities.contains(option);
+	}
+
+	protected boolean wantCapability(final StringBuilder b, final String option) {
+		if (!isCapableOf(option))
+			return false;
+		if (b.length() > 0)
+			b.append(' ');
+		b.append(option);
+		return true;
+	}
+
+	private PackProtocolException duplicateAdvertisement(final String name) {
+		return new PackProtocolException(uri + ": duplicate advertisements of "
+				+ name);
+	}
+
+	@Override
+	public void close() {
+		if (out != null) {
+			try {
+				pckOut.end();
+				out.close();
+			} catch (IOException err) {
+				// Ignore any close errors.
+			} finally {
+				out = null;
+				pckOut = null;
+			}
+		}
+
+		if (in != null) {
+			try {
+				in.close();
+			} catch (IOException err) {
+				// Ignore any close errors.
+			} finally {
+				in = null;
+				pckIn = null;
+			}
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
similarity index 76%
rename from org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java
rename to org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 6209030..04a91bf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -38,26 +38,15 @@
 
 package org.spearce.jgit.transport;
 
-import java.io.BufferedInputStream;
-import java.io.BufferedOutputStream;
-import java.io.EOFException;
 import java.io.IOException;
-import java.io.InputStream;
-import java.io.OutputStream;
 import java.util.Collection;
 import java.util.Date;
-import java.util.HashSet;
-import java.util.LinkedHashMap;
-import java.util.Set;
 
-import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.MutableObjectId;
-import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevCommitList;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -78,8 +67,14 @@ import org.spearce.jgit.revwalk.filter.RevFilter;
  * This connection requires only a bi-directional pipe or socket, and thus is
  * easily wrapped up into a local process pipe, anonymous TCP socket, or a
  * command executed through an SSH tunnel.
+ * <p>
+ * Concrete implementations should just call
+ * {@link #init(java.io.InputStream, java.io.OutputStream)} and
+ * {@link #readAdvertisedRefs()} methods in constructor or before any use. They
+ * should also handle resources releasing in {@link #close()} method if needed.
  */
-abstract class PackFetchConnection extends FetchConnection {
+abstract class BasePackFetchConnection extends BasePackConnection implements
+		FetchConnection {
 	/**
 	 * Maximum number of 'have' lines to send before giving up.
 	 * <p>
@@ -103,27 +98,6 @@ abstract class PackFetchConnection extends FetchConnection {
 
 	static final String OPTION_SHALLOW = "shallow";
 
-	/** The repository this transport fetches into, or pushes out of. */
-	protected final Repository local;
-
-	/** Remote repository location. */
-	protected final URIish uri;
-
-	/** Capability tokens advertised by the remote side. */
-	protected final Set<String> remoteCapablities = new HashSet<String>();
-
-	/** Buffered input stream reading from the remote. */
-	protected InputStream in;
-
-	/** Buffered output stream sending to the remote. */
-	protected OutputStream out;
-
-	/** Packet line decoder around {@link #in}. */
-	protected PacketLineIn pckIn;
-
-	/** Packet line encoder around {@link #out}. */
-	protected PacketLineOut pckOut;
-
 	private final RevWalk walk;
 
 	/** All commits that are immediately reachable by a local ref. */
@@ -146,9 +120,8 @@ abstract class PackFetchConnection extends FetchConnection {
 
 	private boolean includeTags;
 
-	PackFetchConnection(final PackTransport packTransport) {
-		local = packTransport.local;
-		uri = packTransport.uri;
+	BasePackFetchConnection(final PackTransport packTransport) {
+		super(packTransport);
 		includeTags = packTransport.getTagOpt() != TagOpt.NO_TAGS;
 		thinPack = packTransport.isFetchThin();
 
@@ -163,91 +136,16 @@ abstract class PackFetchConnection extends FetchConnection {
 		walk.carry(ADVERTISED);
 	}
 
-	protected void init(final InputStream myIn, final OutputStream myOut) {
-		in = myIn instanceof BufferedInputStream ? myIn
-				: new BufferedInputStream(myIn);
-		out = myOut instanceof BufferedOutputStream ? myOut
-				: new BufferedOutputStream(myOut);
-
-		pckIn = new PacketLineIn(in);
-		pckOut = new PacketLineOut(out);
+	public final void fetch(final ProgressMonitor monitor,
+			final Collection<Ref> want) throws TransportException {
+		markStartedOperation();
+		doFetch(monitor, want);
 	}
 
-	@Override
 	public boolean didFetchIncludeTags() {
-		return includeTags;
-	}
-
-	protected void readAdvertisedRefs() throws TransportException {
-		try {
-			readAdvertisedRefsImpl();
-		} catch (TransportException err) {
-			close();
-			throw err;
-		} catch (IOException err) {
-			close();
-			throw new TransportException(err.getMessage(), err);
-		} catch (RuntimeException err) {
-			close();
-			throw new TransportException(err.getMessage(), err);
-		}
-	}
-
-	private void readAdvertisedRefsImpl() throws IOException {
-		final LinkedHashMap<String, Ref> avail = new LinkedHashMap<String, Ref>();
-		for (;;) {
-			String line;
-
-			try {
-				line = pckIn.readString();
-			} catch (EOFException eof) {
-				if (avail.isEmpty())
-					throw new TransportException(uri + " not found.");
-				throw eof;
-			}
-
-			if (avail.isEmpty()) {
-				// The first line (if any) may contain "hidden"
-				// capability values after a NUL byte.
-				//
-				final int nul = line.indexOf('\0');
-				if (nul >= 0) {
-					for (String c : line.substring(nul + 1).split(" "))
-						remoteCapablities.add(c);
-					line = line.substring(0, nul);
-				}
-			}
-
-			if (line.length() == 0)
-				break;
-
-			String name = line.substring(41, line.length());
-			final ObjectId id = ObjectId.fromString(line.substring(0, 40));
-			if (name.endsWith("^{}")) {
-				name = name.substring(0, name.length() - 3);
-				final Ref prior = avail.get(name);
-				if (prior == null)
-					throw new PackProtocolException("advertisement of " + name
-							+ "^{} came before " + name);
-
-				if (prior.getPeeledObjectId() != null)
-					throw duplicateAdvertisement(name + "^{}");
-
-				avail.put(name, new Ref(name, prior.getObjectId(), id));
-			} else {
-				final Ref prior = avail.put(name, new Ref(name, id));
-				if (prior != null)
-					throw duplicateAdvertisement(name);
-			}
-		}
-		available(avail);
+		return false;
 	}
 
-	private PackProtocolException duplicateAdvertisement(final String name) {
-		return new PackProtocolException("duplicate advertisements of " + name);
-	}
-
-	@Override
 	protected void doFetch(final ProgressMonitor monitor,
 			final Collection<Ref> want) throws TransportException {
 		try {
@@ -373,15 +271,6 @@ abstract class PackFetchConnection extends FetchConnection {
 		return line.toString();
 	}
 
-	private boolean wantCapability(final StringBuilder b, final String option) {
-		if (!remoteCapablities.contains(option))
-			return false;
-		if (b.length() > 0)
-			b.append(' ');
-		b.append(option);
-		return true;
-	}
-
 	private void negotiate(final ProgressMonitor monitor) throws IOException,
 			CancelledException {
 		final MutableObjectId ackId = new MutableObjectId();
@@ -568,32 +457,6 @@ abstract class PackFetchConnection extends FetchConnection {
 		ip.renameAndOpenPack();
 	}
 
-	@Override
-	public void close() {
-		if (out != null) {
-			try {
-				pckOut.end();
-				out.close();
-			} catch (IOException err) {
-				// Ignore any close errors.
-			} finally {
-				out = null;
-				pckOut = null;
-			}
-		}
-
-		if (in != null) {
-			try {
-				in.close();
-			} catch (IOException err) {
-				// Ignore any close errors.
-			} finally {
-				in = null;
-				pckIn = null;
-			}
-		}
-	}
-
 	private static class CancelledException extends Exception {
 		private static final long serialVersionUID = 1L;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Connection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Connection.java
new file mode 100644
index 0000000..5a91e9b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Connection.java
@@ -0,0 +1,104 @@
+/*
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
+import java.util.Map;
+
+import org.spearce.jgit.lib.Ref;
+
+/**
+ * Represent connection for operation on a remote repository.
+ * <p>
+ * Currently all operations on remote repository (fetch and push) provide
+ * information about remote refs. Every connection is able to be closed and
+ * should be closed - this is a connection client responsibility.
+ * 
+ * @see Transport
+ */
+public interface Connection {
+
+	/**
+	 * Get the complete map of refs advertised as available for fetching or
+	 * pushing.
+	 * 
+	 * @return available/advertised refs: map of refname to ref. Never null. Not
+	 *         modifiable. The collection can be empty if the remote side has no
+	 *         refs (it is an empty/newly created repository).
+	 */
+	public Map<String, Ref> getRefsMap();
+
+	/**
+	 * Get the complete list of refs advertised as available for fetching or
+	 * pushing.
+	 * <p>
+	 * The returned refs may appear in any order. If the caller needs these to
+	 * be sorted, they should be copied into a new array or List and then sorted
+	 * by the caller as necessary.
+	 * 
+	 * @return available/advertised refs. Never null. Not modifiable. The
+	 *         collection can be empty if the remote side has no refs (it is an
+	 *         empty/newly created repository).
+	 */
+	public Collection<Ref> getRefs();
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
+	public Ref getRef(final String name);
+
+	/**
+	 * Close any resources used by this connection.
+	 * <p>
+	 * If the remote repository is contacted by a network socket this method
+	 * must close that network socket, disconnecting the two peers. If the
+	 * remote repository is actually local (same system) this method must close
+	 * any open file handles used to read the "remote" repository.
+	 */
+	public void close();
+
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
index 8e7641c..9d25b0d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
@@ -38,8 +38,6 @@
 package org.spearce.jgit.transport;
 
 import java.util.Collection;
-import java.util.Collections;
-import java.util.Map;
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ProgressMonitor;
@@ -62,84 +60,13 @@ import org.spearce.jgit.lib.Ref;
  * 
  * @see Transport
  */
-public abstract class FetchConnection {
-	private Map<String, Ref> cachedRefs = Collections.<String, Ref> emptyMap();
-
-	/** Have we started {@link #fetch(ProgressMonitor, Collection)} yet? */
-	private boolean startedFetch;
-
-	Map<String, Ref> getCachedRefs() {
-		return cachedRefs;
-	}
-
-	/**
-	 * Denote the list of refs available on the remote repository.
-	 * <p>
-	 * Implementors should invoke this method once they have obtained the refs
-	 * that are available from the remote repository.s
-	 * 
-	 * @param all
-	 *            the complete list of refs the remote has to offer. This map
-	 *            will be wrapped in an unmodifiable way to protect it, but it
-	 *            does not get copied.
-	 */
-	protected void available(final Map<String, Ref> all) {
-		cachedRefs = Collections.unmodifiableMap(all);
-	}
-
-	/**
-	 * Get the complete list of refs advertised as available for fetching.
-	 * <p>
-	 * The returned refs may appear in any order. If the caller needs these to
-	 * be sorted, they should be copied into a new array or List and then sorted
-	 * by the caller as necessary.
-	 * 
-	 * @return available/advertised refs. Never null. Not modifiable. The
-	 *         collection can be empty if the remote side has no refs (it is an
-	 *         empty/newly created repository).
-	 */
-	public final Collection<Ref> getRefs() {
-		return cachedRefs.values();
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
-	public final Ref getRef(final String name) {
-		return cachedRefs.get(name);
-	}
-
+public interface FetchConnection extends Connection {
 	/**
 	 * Fetch objects we don't have but that are reachable from advertised refs.
-	 * 
-	 * @param monitor
-	 *            progress monitor to update the end-user about the amount of
-	 *            work completed, or to indicate cancellation.
-	 * @param want
-	 *            one or more refs advertised by this connection that the caller
-	 *            wants to store locally.
-	 * @throws TransportException
-	 *             objects could not be copied due to a network failure,
-	 *             protocol error, or error on remote side.
-	 */
-	public final void fetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException {
-		if (startedFetch)
-			throw new TransportException("Only one fetch call supported.");
-		startedFetch = true;
-		doFetch(monitor, want);
-	}
-
-	/**
-	 * Fetch objects this repository does not yet contain.
+	 * <p>
+	 * Only one call per connection is allowed. Subsequent calls will result in
+	 * {@link TransportException}.
+	 * </p>
 	 * <p>
 	 * Implementations are free to use network connections as necessary to
 	 * efficiently (for both client and server) transfer objects from the remote
@@ -147,22 +74,24 @@ public abstract class FetchConnection {
 	 * avoid replacing/overwriting/duplicating an object already available in
 	 * the local destination repository. Locally available objects and packs
 	 * should always be preferred over remotely available objects and packs.
+	 * {@link Transport#isFetchThin()} should be honored if applicable.
+	 * </p>
 	 * 
 	 * @param monitor
-	 *            progress feedback to inform the end-user about the status of
-	 *            the object transfer. Implementors should poll the monitor at
-	 *            regular intervals to look for cancellation requests from the
-	 *            user.
+	 *            progress monitor to inform the end-user about the amount of
+	 *            work completed, or to indicate cancellation. Implementations
+	 *            should poll the monitor at regular intervals to look for
+	 *            cancellation requests from the user.
 	 * @param want
-	 *            one or more refs that were previously passed to
-	 *            {@link #available(Map)} by the implementation. These refs
-	 *            indicate the objects the caller wants copied.
+	 *            one or more refs advertised by this connection that the caller
+	 *            wants to store locally.
 	 * @throws TransportException
 	 *             objects could not be copied due to a network failure,
-	 *             protocol error, or error on remote side.
+	 *             protocol error, or error on remote side, or connection was
+	 *             already used for fetch.
 	 */
-	protected abstract void doFetch(ProgressMonitor monitor,
-			Collection<Ref> want) throws TransportException;
+	public void fetch(final ProgressMonitor monitor, final Collection<Ref> want)
+			throws TransportException;
 
 	/**
 	 * Did the last {@link #fetch(ProgressMonitor, Collection)} get tags?
@@ -170,9 +99,9 @@ public abstract class FetchConnection {
 	 * Some Git aware transports are able to implicitly grab an annotated tag if
 	 * {@link TagOpt#AUTO_FOLLOW} or {@link TagOpt#FETCH_TAGS} was selected and
 	 * the object the tag peels to (references) was transferred as part of the
-	 * last {@link #doFetch(ProgressMonitor, Collection)} call. If it is
-	 * possible for such tags to have been included in the transfer this method
-	 * returns true, allowing the caller to attempt tag discovery.
+	 * last {@link #fetch(ProgressMonitor, Collection)} call. If it is possible
+	 * for such tags to have been included in the transfer this method returns
+	 * true, allowing the caller to attempt tag discovery.
 	 * <p>
 	 * By returning only true/false (and not the actual list of tags obtained)
 	 * the transport itself does not need to be aware of whether or not tags
@@ -181,17 +110,5 @@ public abstract class FetchConnection {
 	 * @return true if the last fetch call implicitly included tag objects;
 	 *         false if tags were not implicitly obtained.
 	 */
-	public boolean didFetchIncludeTags() {
-		return false;
-	}
-
-	/**
-	 * Close any resources used by this connection.
-	 * <p>
-	 * If the remote repository is contacted by a network socket this method
-	 * must close that network socket, disconnecting the two peers. If the
-	 * remote repository is actually local (same system) this method must close
-	 * any open file handles used to read the "remote" repository.
-	 */
-	public abstract void close();
-}
+	public boolean didFetchIncludeTags();
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index e33b35b..c765c12 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -97,7 +97,7 @@ class FetchProcess {
 
 		conn = transport.openFetch();
 		try {
-			result.setAdvertisedRefs(conn.getCachedRefs());
+			result.setAdvertisedRefs(conn.getRefsMap());
 			final Set<Ref> matched = new HashSet<Ref>();
 			for (final RefSpec spec : toFetch) {
 				if (spec.isWildcard())
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
index 177e065..50708d3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackTransport.java
@@ -46,7 +46,8 @@ import org.spearce.jgit.lib.Repository;
  * forth by creating pack files on the source side and indexing them on the
  * receiving side.
  * 
- * @see PackFetchConnection
+ * @see BasePackFetchConnection
+ * @see BasePackPushConnection
  */
 abstract class PackTransport extends Transport {
 	PackTransport(final Repository local, final URIish u) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushConnection.java
index 316bb95..835b15c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushConnection.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ * 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or
@@ -37,6 +38,12 @@
 
 package org.spearce.jgit.transport;
 
+import java.util.Map;
+
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
 /**
  * Lists known refs from the remote and sends objects to the remote.
  * <p>
@@ -55,14 +62,47 @@ package org.spearce.jgit.transport;
  * 
  * @see Transport
  */
-public abstract class PushConnection {
+public interface PushConnection extends Connection {
+
 	/**
-	 * Close any resources used by this connection.
+	 * Pushes to the remote repository basing on provided specification. This
+	 * possibly result in update/creation/deletion of refs on remote repository
+	 * and sending objects that remote repository need to have a consistent
+	 * objects graph from new refs.
+	 * <p>
+	 * <p>
+	 * Only one call per connection is allowed. Subsequent calls will result in
+	 * {@link TransportException}.
+	 * </p>
 	 * <p>
-	 * If the remote repository is contacted by a network socket this method
-	 * must close that network socket, disconnecting the two peers. If the
-	 * remote repository is actually local (same system) this method must close
-	 * any open file handles used to read the "remote" repository.
+	 * Implementation may use local repository to send a minimum set of objects
+	 * needed by remote repository in efficient way.
+	 * {@link Transport#isPushThin()} should be honored if applicable.
+	 * refUpdates should be filled with information about status of each update.
+	 * </p>
+	 * 
+	 * @param monitor
+	 *            progress monitor to update the end-user about the amount of
+	 *            work completed, or to indicate cancellation. Implementors
+	 *            should poll the monitor at regular intervals to look for
+	 *            cancellation requests from the user.
+	 * @param refUpdates
+	 *            map of remote refnames to remote refs update
+	 *            specifications/statuses. Can't be empty. This indicate what
+	 *            refs caller want to update on remote side. Only refs updates
+	 *            with {@link Status#NOT_ATTEMPTED} should passed.
+	 *            Implementation must ensure that and appropriate status with
+	 *            optional message should be set during call. No refUpdate with
+	 *            {@link Status#AWAITING_REPORT} or {@link Status#NOT_ATTEMPTED}
+	 *            can be leaved by implementation after return from this call.
+	 * @throws TransportException
+	 *             objects could not be copied due to a network failure,
+	 *             critical protocol error, or error on remote side, or
+	 *             connection was already used for push - new connection must be
+	 *             created. Non-critical errors concerning only isolated refs
+	 *             should be placed in refUpdates.
 	 */
-	public abstract void close();
+	public void push(final ProgressMonitor monitor,
+			final Map<String, RemoteRefUpdate> refUpdates)
+			throws TransportException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 2c173fd..48120a8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -95,7 +95,7 @@ class TransportBundle extends PackTransport {
 		return new BundleFetchConnection();
 	}
 
-	class BundleFetchConnection extends FetchConnection {
+	class BundleFetchConnection extends BaseFetchConnection {
 		FileInputStream in;
 
 		RewindBufferedInputStream bin;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index e37757a..a7a419e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -99,7 +99,7 @@ class TransportGitAnon extends PackTransport {
 		pckOut.flush();
 	}
 
-	class TcpFetchConnection extends PackFetchConnection {
+	class TcpFetchConnection extends BasePackFetchConnection {
 		private Socket sock;
 
 		TcpFetchConnection() throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index 8944df7..f6e456a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -188,7 +188,7 @@ class TransportGitSsh extends PackTransport {
 		}
 	}
 
-	class SshFetchConnection extends PackFetchConnection {
+	class SshFetchConnection extends BasePackFetchConnection {
 		private Session session;
 
 		private ChannelExec channel;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index cde648d..e109cf4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -83,7 +83,7 @@ class TransportLocal extends PackTransport {
 		return new LocalFetchConnection();
 	}
 
-	class LocalFetchConnection extends PackFetchConnection {
+	class LocalFetchConnection extends BasePackFetchConnection {
 		private Process uploadPack;
 
 		LocalFetchConnection() throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 45c2ded..78116b2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -95,7 +95,7 @@ import org.spearce.jgit.treewalk.TreeWalk;
  * 
  * @see WalkRemoteObjectDatabase
  */
-class WalkFetchConnection extends FetchConnection {
+class WalkFetchConnection extends BaseFetchConnection {
 	/** The repository this transport fetches into, or pushes out of. */
 	private final Repository local;
 
-- 
1.5.5.3
