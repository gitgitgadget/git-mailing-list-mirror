From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 16/23] Transport* - general support for push() and implementations
Date: Sat, 28 Jun 2008 00:06:40 +0200
Message-ID: <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
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
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM95-0001Lw-EO
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762043AbYF0WIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761806AbYF0WIR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400AbYF0WIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:07 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pWvkw3heV2IdcGeEJge3q4mpQIZY/jEvDfr27/rHk5s=;
        b=fLleybMq89+jgCLcHm0V4ijyQ2kakX6nagzEhZYz08HRWobw+MWS/iWh7CxhUa16ly
         MUZoW9TyZ1mODWPPHP5I/hMm6UddPGSFYiltBQvsxLUgIkMIYXIsMPyE14LmCKDq+/nK
         9Q+VEr/INUpX2V56C0qkKef2iv0jH3qIU5JZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=As5EszGJivV78whe+xI2HpfDc3y07+yzlw2Ga6zZQbKUZZjkIOlKx0K+z6BgZ6X+Gm
         HhfGkhoWbKTOM2ANvvltDqTF9h+3zJA3oNoRxpZXhGoL7FBJgE1phcsSk1hdwViKEL1g
         xDTx5V/Qjnv9nh7xCc9y0UHkmX/pN3++uO2Zk=
Received: by 10.210.125.7 with SMTP id x7mr1617817ebc.45.1214604487051;
        Fri, 27 Jun 2008 15:08:07 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b33sm2446484ika.2.2008.06.27.15.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86658>

Implementation of push() at abstract Transport class level and
implementations of concrete protocols: SSH, local, git-daemon.

Some Transport* implementations required refactoring to share code
between pack and fetch connections.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/Transport.java  |  184 +++++++++++++++++++-
 .../spearce/jgit/transport/TransportBundle.java    |    6 +
 .../spearce/jgit/transport/TransportGitAnon.java   |   39 ++++
 .../spearce/jgit/transport/TransportGitSsh.java    |   51 ++++++
 .../org/spearce/jgit/transport/TransportLocal.java |  113 ++++++++----
 .../org/spearce/jgit/transport/WalkTransport.java  |    7 +
 6 files changed, 361 insertions(+), 39 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index c4b71eb..da5b41e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -42,12 +43,16 @@ import java.net.URISyntaxException;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Collections;
+import java.util.HashSet;
+import java.util.LinkedList;
 import java.util.List;
+import java.util.Map;
 
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 
 /**
@@ -105,6 +110,8 @@ public abstract class Transport {
 		tn.setOptionUploadPack(cfg.getUploadPack());
 		tn.fetch = cfg.getFetchRefSpecs();
 		tn.tagopt = cfg.getTagOpt();
+		tn.setOptionReceivePack(cfg.getReceivePack());
+		tn.push = cfg.getPushRefSpecs();
 		return tn;
 	}
 
@@ -152,6 +159,20 @@ public abstract class Transport {
 	 */
 	public static final boolean DEFAULT_PUSH_THIN = false;
 
+	/**
+	 * Specification for fetch or push operations, to fetch or push all tags.
+	 * Acts as --tags.
+	 */
+	public static final RefSpec REFSPEC_TAGS = new RefSpec(
+			"refs/tags/*:refs/tags/*");
+
+	/**
+	 * Specification for push operation, to push all refs under refs/heads. Acts
+	 * as --all.
+	 */
+	public static final RefSpec REFSPEC_PUSH_ALL = new RefSpec(
+			"refs/heads/*:refs/heads/*");
+
 	/** The repository this transport fetches into, or pushes out of. */
 	protected final Repository local;
 
@@ -162,7 +183,7 @@ public abstract class Transport {
 	private String optionUploadPack = RemoteConfig.DEFAULT_UPLOAD_PACK;
 
 	/** Specifications to apply during fetch. */
-	private List<RefSpec> fetch = Collections.<RefSpec> emptyList();
+	private List<RefSpec> fetch = Collections.emptyList();
 
 	/**
 	 * How {@link #fetch(ProgressMonitor, Collection)} should handle tags.
@@ -178,6 +199,12 @@ public abstract class Transport {
 	/** Should fetch request thin-pack if remote repository can produce it. */
 	private boolean fetchThin = DEFAULT_FETCH_THIN;
 
+	/** Name of the receive pack program, if it must be executed. */
+	private String optionReceivePack = RemoteConfig.DEFAULT_RECEIVE_PACK;
+
+	/** Specifications to apply during push. */
+	private List<RefSpec> push = Collections.emptyList();
+
 	/** Should push produce thin-pack when sending objects to remote repository. */
 	private boolean pushThin = DEFAULT_PUSH_THIN;
 
@@ -274,6 +301,31 @@ public abstract class Transport {
 	}
 
 	/**
+	 * Default setting is: {@value RemoteConfig#DEFAULT_RECEIVE_PACK}
+	 * 
+	 * @return remote executable providing receive-pack service for pack
+	 *         transports.
+	 * @see PackTransport
+	 */
+	public String getOptionReceivePack() {
+		return optionReceivePack;
+	}
+
+	/**
+	 * Set remote executable providing receive-pack service for pack transports.
+	 * Default setting is: {@value RemoteConfig#DEFAULT_RECEIVE_PACK}
+	 * 
+	 * @param optionReceivePack
+	 *            remote executable, if null or empty default one is set;
+	 */
+	public void setOptionReceivePack(String optionReceivePack) {
+		if (optionReceivePack != null && optionReceivePack.length() > 0)
+			this.optionReceivePack = optionReceivePack;
+		else
+			this.optionReceivePack = RemoteConfig.DEFAULT_RECEIVE_PACK;
+	}
+
+	/**
 	 * Default setting is: {@value #DEFAULT_PUSH_THIN}
 	 * 
 	 * @return true if push should produce thin-pack in pack transports
@@ -356,6 +408,98 @@ public abstract class Transport {
 	}
 
 	/**
+	 * Push objects and refs from the local repository to the remote one.
+	 * <p>
+	 * This is a utility function providing standard push behavior. It updates
+	 * remote refs and send there necessary objects according to remote ref
+	 * update specification. After successful remote ref update, associated
+	 * locally stored tracking branch is updated if set up accordingly. Detailed
+	 * operation result is provided after execution.
+	 * <p>
+	 * For setting up remote ref update specification from ref spec, see helper
+	 * method {@link #findRemoteRefUpdatesFor(Collection)}, predefined refspecs ({@link #REFSPEC_TAGS},
+	 * {@link #REFSPEC_PUSH_ALL}) or consider using directly
+	 * {@link RemoteRefUpdate} for more possibilities.
+	 * 
+	 * @see RemoteRefUpdate
+	 * 
+	 * @param monitor
+	 *            progress monitor to inform the user about our processing
+	 *            activity. Must not be null. Use {@link NullProgressMonitor} if
+	 *            progress updates are not interesting or necessary.
+	 * @param toPush
+	 *            specification of refs to push. May be null or the empty
+	 *            collection to use the specifications from the RemoteConfig
+	 *            converted by {@link #findRemoteRefUpdatesFor(Collection)}. No
+	 *            more than 1 RemoteRefUpdate with the same remoteName is
+	 *            allowed.
+	 * @return information about results of remote refs updates, tracking refs
+	 *         updates and refs advertised by remote repository.
+	 * @throws NotSupportedException
+	 *             this transport implementation does not support pusing
+	 *             objects.
+	 * @throws TransportException
+	 *             the remote connection could not be established or object
+	 *             copying (if necessary) failed at I/O or protocol level or
+	 *             update specification was incorrect.
+	 */
+	public PushResult push(final ProgressMonitor monitor,
+			Collection<RemoteRefUpdate> toPush) throws NotSupportedException,
+			TransportException {
+		if (toPush == null || toPush.isEmpty()) {
+			// If the caller did not ask for anything use the defaults.
+			toPush = findRemoteRefUpdatesFor(push);
+			if (toPush.isEmpty())
+				throw new TransportException("Nothing to push.");
+		}
+		final PushProcess pushProcess = new PushProcess(this, toPush);
+		return pushProcess.execute(monitor);
+	}
+
+	/**
+	 * Convert push remote refs update specification from {@link RefSpec} form
+	 * to {@link RemoteRefUpdate}. Conversion expands wildcards by matching
+	 * source part to local refs. expectedOldObjectId in RemoteRefUpdate is
+	 * always set as null. Tracking branch is configured if RefSpec destination
+	 * matches source of any fetch ref spec for this transport remote
+	 * configuration.
+	 * 
+	 * @param specs
+	 *            collection of RefSpec to convert.
+	 * @return collection of set up {@link RemoteRefUpdate}.
+	 * @throws TransportException
+	 *             when problem occurred during conversion or specification set
+	 *             up: most probably, missing objects or refs.
+	 */
+	public Collection<RemoteRefUpdate> findRemoteRefUpdatesFor(
+			final Collection<RefSpec> specs) throws TransportException {
+		final List<RemoteRefUpdate> result = new LinkedList<RemoteRefUpdate>();
+		final Collection<RefSpec> procRefs = expandPushWildcardsFor(specs);
+
+		for (final RefSpec spec : procRefs) {
+			try {
+				final String srcRef = spec.getSource();
+				// null destination (no-colon in ref-spec) is a special case
+				final String remoteName = (spec.getDestination() == null ? spec
+						.getSource() : spec.getDestination());
+				final boolean forceUpdate = spec.isForceUpdate();
+				final String localName = findTrackingRefName(remoteName);
+
+				final RemoteRefUpdate rru = new RemoteRefUpdate(local, srcRef,
+						remoteName, forceUpdate, localName, null);
+				result.add(rru);
+			} catch (TransportException x) {
+				throw x;
+			} catch (Exception x) {
+				throw new TransportException(
+						"Problem with resolving push ref spec \"" + spec
+								+ "\" locally: " + x.getMessage(), x);
+			}
+		}
+		return result;
+	}
+
+	/**
 	 * Begins a new connection for fetching from the remote repository.
 	 * 
 	 * @return a fresh connection to fetch from the remote repository.
@@ -373,9 +517,41 @@ public abstract class Transport {
 	 * @return a fresh connection to push into the remote repository.
 	 * @throws NotSupportedException
 	 *             the implementation does not support pushing.
+	 * @throws TransportException
+	 *             the remote connection could not be established
 	 */
-	public final PushConnection openPush() throws NotSupportedException
-	/* TransportException */{
-		throw new NotSupportedException("No push support.");
+	public abstract PushConnection openPush() throws NotSupportedException,
+			TransportException;
+
+	private Collection<RefSpec> expandPushWildcardsFor(
+			final Collection<RefSpec> specs) {
+		final Map<String, Ref> localRefs = local.getAllRefs();
+		final Collection<RefSpec> procRefs = new HashSet<RefSpec>();
+
+		for (final RefSpec spec : specs) {
+			if (spec.isWildcard()) {
+				for (final Ref localRef : localRefs.values()) {
+					if (spec.matchSource(localRef))
+						procRefs.add(spec.expandFromSource(localRef));
+				}
+			} else {
+				procRefs.add(spec);
+			}
+		}
+		return procRefs;
+	}
+
+	private String findTrackingRefName(final String remoteName) {
+		// try to find matching tracking refs
+		for (final RefSpec fetchSpec : fetch) {
+			if (fetchSpec.matchSource(remoteName)) {
+				if (fetchSpec.isWildcard())
+					return fetchSpec.expandFromSource(remoteName)
+							.getDestination();
+				else
+					return fetchSpec.getDestination();
+			}
+		}
+		return null;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 48120a8..1bf081a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -95,6 +95,12 @@ class TransportBundle extends PackTransport {
 		return new BundleFetchConnection();
 	}
 
+	@Override
+	public PushConnection openPush() throws NotSupportedException {
+		throw new NotSupportedException(
+				"Push is not supported for bundle transport");
+	}
+
 	class BundleFetchConnection extends BaseFetchConnection {
 		FileInputStream in;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index a7a419e..6e49083 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -71,6 +72,11 @@ class TransportGitAnon extends PackTransport {
 		return new TcpFetchConnection();
 	}
 
+	@Override
+	public PushConnection openPush() throws TransportException {
+		return new TcpPushConnection();
+	}
+
 	Socket openConnection() throws TransportException {
 		final int port = uri.getPort() > 0 ? uri.getPort() : GIT_PORT;
 		try {
@@ -131,4 +137,37 @@ class TransportGitAnon extends PackTransport {
 			}
 		}
 	}
+
+	class TcpPushConnection extends BasePackPushConnection {
+		private Socket sock;
+
+		TcpPushConnection() throws TransportException {
+			super(TransportGitAnon.this);
+			sock = openConnection();
+			try {
+				init(sock.getInputStream(), sock.getOutputStream());
+				service("git-receive-pack", pckOut);
+			} catch (IOException err) {
+				close();
+				throw new TransportException(uri.toString()
+						+ ": remote hung up unexpectedly", err);
+			}
+			readAdvertisedRefs();
+		}
+
+		@Override
+		public void close() {
+			super.close();
+
+			if (sock != null) {
+				try {
+					sock.close();
+				} catch (IOException err) {
+					// Ignore errors during close.
+				} finally {
+					sock = null;
+				}
+			}
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index f6e456a..55be4f6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -88,6 +89,11 @@ class TransportGitSsh extends PackTransport {
 		return new SshFetchConnection();
 	}
 
+	@Override
+	public PushConnection openPush() throws TransportException {
+		return new SshPushConnection();
+	}
+
 	private static void sqMinimal(final StringBuilder cmd, final String val) {
 		if (val.matches("^[a-zA-Z0-9._/-]*$")) {
 			// If the string matches only generally safe characters
@@ -232,4 +238,49 @@ class TransportGitSsh extends PackTransport {
 			}
 		}
 	}
+
+	class SshPushConnection extends BasePackPushConnection {
+		private Session session;
+
+		private ChannelExec channel;
+
+		SshPushConnection() throws TransportException {
+			super(TransportGitSsh.this);
+			try {
+				session = openSession();
+				channel = exec(session, getOptionReceivePack());
+				init(channel.getInputStream(), channel.getOutputStream());
+			} catch (TransportException err) {
+				close();
+				throw err;
+			} catch (IOException err) {
+				close();
+				throw new TransportException(uri.toString()
+						+ ": remote hung up unexpectedly", err);
+			}
+			readAdvertisedRefs();
+		}
+
+		@Override
+		public void close() {
+			super.close();
+
+			if (channel != null) {
+				try {
+					if (channel.isConnected())
+						channel.disconnect();
+				} finally {
+					channel = null;
+				}
+			}
+
+			if (session != null) {
+				try {
+					sch.releaseSession(session);
+				} finally {
+					session = null;
+				}
+			}
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index e109cf4..f48dc6d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -2,6 +2,7 @@
  * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -43,6 +44,7 @@ import java.io.File;
 import java.io.IOException;
 import java.io.InputStream;
 
+import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.FS;
@@ -83,50 +85,35 @@ class TransportLocal extends PackTransport {
 		return new LocalFetchConnection();
 	}
 
+	@Override
+	public PushConnection openPush() throws NotSupportedException,
+			TransportException {
+		return new LocalPushConnection();
+	}
+
+	protected Process startProcessWithErrStream(final String cmd)
+			throws TransportException {
+		try {
+			final Process proc = Runtime.getRuntime().exec(
+					new String[] { cmd, "." }, null, remoteGitDir);
+			new StreamRewritingThread(proc.getErrorStream()).start();
+			return proc;
+		} catch (IOException err) {
+			throw new TransportException(uri.toString() + ": "
+					+ err.getMessage(), err);
+		}
+	}
+
 	class LocalFetchConnection extends BasePackFetchConnection {
 		private Process uploadPack;
 
 		LocalFetchConnection() throws TransportException {
 			super(TransportLocal.this);
-			try {
-				uploadPack = Runtime.getRuntime().exec(
-						new String[] { getOptionUploadPack(), "." }, null,
-						remoteGitDir);
-			} catch (IOException err) {
-				throw new TransportException(uri.toString() + ": "
-						+ err.getMessage(), err);
-			}
-			startErrorThread();
+			uploadPack = startProcessWithErrStream(getOptionReceivePack());
 			init(uploadPack.getInputStream(), uploadPack.getOutputStream());
 			readAdvertisedRefs();
 		}
 
-		private void startErrorThread() {
-			final InputStream errorStream = uploadPack.getErrorStream();
-			new Thread("JGit " + getOptionUploadPack() + " Errors") {
-				public void run() {
-					final byte[] tmp = new byte[512];
-					try {
-						for (;;) {
-							final int n = errorStream.read(tmp);
-							if (n < 0)
-								break;
-							System.err.write(tmp, 0, n);
-							System.err.flush();
-						}
-					} catch (IOException err) {
-						// Ignore errors reading errors.
-					} finally {
-						try {
-							errorStream.close();
-						} catch (IOException err2) {
-							// Ignore errors closing the pipe.
-						}
-					}
-				}
-			}.start();
-		}
-
 		@Override
 		public void close() {
 			super.close();
@@ -142,4 +129,60 @@ class TransportLocal extends PackTransport {
 			}
 		}
 	}
+
+	class LocalPushConnection extends BasePackPushConnection {
+		private Process receivePack;
+
+		LocalPushConnection() throws TransportException {
+			super(TransportLocal.this);
+			receivePack = startProcessWithErrStream(getOptionReceivePack());
+			init(receivePack.getInputStream(), receivePack.getOutputStream());
+			readAdvertisedRefs();
+		}
+
+		@Override
+		public void close() {
+			super.close();
+
+			if (receivePack != null) {
+				try {
+					receivePack.waitFor();
+				} catch (InterruptedException ie) {
+					// Stop waiting and return anyway.
+				} finally {
+					receivePack = null;
+				}
+			}
+		}
+	}
+
+	class StreamRewritingThread extends Thread {
+		private final InputStream in;
+
+		StreamRewritingThread(final InputStream in) {
+			super("JGit " + getOptionUploadPack() + " Errors");
+			this.in = in;
+		}
+
+		public void run() {
+			final byte[] tmp = new byte[512];
+			try {
+				for (;;) {
+					final int n = in.read(tmp);
+					if (n < 0)
+						break;
+					System.err.write(tmp, 0, n);
+					System.err.flush();
+				}
+			} catch (IOException err) {
+				// Ignore errors reading errors.
+			} finally {
+				try {
+					in.close();
+				} catch (IOException err2) {
+					// Ignore errors closing the pipe.
+				}
+			}
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
index ae51d6d..29dd661 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
@@ -37,6 +37,7 @@
 
 package org.spearce.jgit.transport;
 
+import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.lib.Repository;
 
 /**
@@ -55,4 +56,10 @@ abstract class WalkTransport extends Transport {
 	WalkTransport(final Repository local, final URIish u) {
 		super(local, u);
 	}
+
+	@Override
+	public PushConnection openPush() throws NotSupportedException {
+		throw new NotSupportedException(
+				"Push is not supported by object walking transports");
+	}
 }
-- 
1.5.5.3
