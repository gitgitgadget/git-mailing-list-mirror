From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/28] Make TextBuiltin public so other packages can implement and use it
Date: Thu, 17 Jul 2008 21:43:58 -0400
Message-ID: <1216345461-59382-6-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2p-00060p-Rr
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212AbYGRBoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758582AbYGRBoy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:54 -0400
Received: from george.spearce.org ([209.20.77.23]:46949 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655AbYGRBob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6E4833845D; Fri, 18 Jul 2008 01:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E959938351;
	Fri, 18 Jul 2008 01:44:24 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88953>

Later we may want to place other command line programs into different
packages, or permit the user to supply their own from their own JAR
and package namespace.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Die.java              |   17 +++++++++++-
 .../src/org/spearce/jgit/pgm/DiffTree.java         |    2 +-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    2 +-
 .../src/org/spearce/jgit/pgm/IndexPack.java        |    2 +-
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    2 +-
 .../src/org/spearce/jgit/pgm/LsTree.java           |    2 +-
 .../src/org/spearce/jgit/pgm/Main.java             |    2 +
 .../src/org/spearce/jgit/pgm/MergeBase.java        |    2 +-
 .../src/org/spearce/jgit/pgm/Push.java             |    2 +-
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |    2 +-
 .../src/org/spearce/jgit/pgm/ShowRef.java          |    2 +-
 .../src/org/spearce/jgit/pgm/Tag.java              |    2 +-
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   27 ++++++++++++++++++-
 13 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
index b372ff3..3ca898d 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
@@ -37,10 +37,23 @@
 
 package org.spearce.jgit.pgm;
 
-class Die extends RuntimeException {
+/**
+ * Indicates a {@link TextBuiltin} implementation has failed during execution.
+ * <p>
+ * Typically the stack trace for a Die exception is not shown to the user as it
+ * may indicate a simple error condition that the end-user can fix on their own,
+ * without needing a screen of Java stack frames.
+ */
+public class Die extends RuntimeException {
 	private static final long serialVersionUID = 1L;
 
-	Die(final String why) {
+	/**
+	 * Construct a new message explaining what has gone wrong.
+	 * 
+	 * @param why
+	 *            the message to show to the end-user.
+	 */
+	public Die(final String why) {
 		super(why);
 	}
 }
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
index 74e8d2f..17858ba 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
@@ -49,7 +49,7 @@ import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 class DiffTree extends TextBuiltin {
 	@Override
-	void execute(String[] args) throws Exception {
+	public void execute(String[] args) throws Exception {
 		final TreeWalk walk = new TreeWalk(db);
 		final List<String> argList = new ArrayList<String>();
 		List<TreeFilter> pathLimiter = null;
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 8a35025..e5a0dce 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -49,7 +49,7 @@ import org.spearce.jgit.transport.Transport;
 
 class Fetch extends TextBuiltin {
 	@Override
-	void execute(String[] args) throws Exception {
+	public void execute(String[] args) throws Exception {
 		int argi = 0;
 		for (; argi < args.length; argi++) {
 			final String a = args[argi];
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
index 60926c1..5f4134d 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
@@ -44,7 +44,7 @@ import org.spearce.jgit.lib.TextProgressMonitor;
 
 class IndexPack extends TextBuiltin {
 	@Override
-	void execute(final String[] args) throws Exception {
+	public void execute(final String[] args) throws Exception {
 		boolean fixThin = false;
 		int argi = 0;
 		int version = 0;
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
index 21e02ec..921bcff 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
@@ -44,7 +44,7 @@ import org.spearce.jgit.transport.Transport;
 
 class LsRemote extends TextBuiltin {
 	@Override
-	void execute(final String[] args) throws Exception {
+	public void execute(final String[] args) throws Exception {
 		int argi = 0;
 		for (; argi < args.length; argi++) {
 			final String a = args[argi];
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
index 05ec8c3..a0a7216 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
@@ -46,7 +46,7 @@ import org.spearce.jgit.treewalk.TreeWalk;
 
 class LsTree extends TextBuiltin {
 	@Override
-	void execute(final String[] args) throws Exception {
+	public void execute(final String[] args) throws Exception {
 		final TreeWalk walk = new TreeWalk(db);
 		int argi = 0;
 		for (; argi < args.length; argi++) {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
index 3d507c6..a155039 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
@@ -44,6 +44,8 @@ import java.util.Arrays;
 import org.spearce.jgit.awtui.AwtAuthenticator;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.pgm.opt.CmdLineParser;
+import org.spearce.jgit.pgm.opt.SubcommandHandler;
 import org.spearce.jgit.util.HttpSupport;
 
 /** Command line entry point. */
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
index c8381f5..c1648a0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
@@ -43,7 +43,7 @@ import org.spearce.jgit.revwalk.filter.RevFilter;
 
 class MergeBase extends TextBuiltin {
 	@Override
-	void execute(final String[] args) throws Exception {
+	public void execute(final String[] args) throws Exception {
 		final RevWalk walk = new RevWalk(db);
 		int max = 1;
 		for (final String a : args) {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index ef93f2f..5671cc5 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -55,7 +55,7 @@ class Push extends TextBuiltin {
 	private boolean first = true;
 
 	@Override
-	void execute(String[] args) throws Exception {
+	public void execute(String[] args) throws Exception {
 		final LinkedList<RefSpec> refSpecs = new LinkedList<RefSpec>();
 		Boolean thin = null;
 		String exec = null;
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
index b992767..2aba3c5 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
@@ -69,7 +69,7 @@ abstract class RevWalkTextBuiltin extends TextBuiltin {
 	char[] outbuffer = new char[Constants.OBJECT_ID_LENGTH * 2];
 
 	@Override
-	final void execute(String[] args) throws Exception {
+	public final void execute(String[] args) throws Exception {
 		final EnumSet<RevSort> sorting = EnumSet.noneOf(RevSort.class);
 		final List<String> argList = new ArrayList<String>();
 		final List<RevFilter> revLimiter = new ArrayList<RevFilter>();
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
index c7cd76e..576e342 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
@@ -44,7 +44,7 @@ import org.spearce.jgit.lib.Ref;
 
 class ShowRef extends TextBuiltin {
 	@Override
-	void execute(String[] args) throws Exception {
+	public void execute(String[] args) throws Exception {
 		for (final Ref r : new TreeMap<String, Ref>(db.getAllRefs()).values()) {
 			show(r.getObjectId(), r.getName());
 			if (r.getPeeledObjectId() != null)
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
index 10b8aa0..d59616b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
@@ -42,7 +42,7 @@ import org.spearce.jgit.lib.PersonIdent;
 
 class Tag extends TextBuiltin {
 	@Override
-	void execute(String[] args) throws Exception {
+	public void execute(String[] args) throws Exception {
 		String tagName = null;
 		String message = null;
 		String ref = "HEAD";
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index b3d8f39..5f2fbce 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -47,15 +47,28 @@ import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 
-abstract class TextBuiltin {
+/**
+ * Abstract command which can be invoked from the command line.
+ * <p>
+ * Commands are configured with a single "current" repository and then the
+ * {@link #execute(String[])} method is invoked with the arguments that appear
+ * on the command line after the command name.
+ * <p>
+ * Command constructors should perform as little work as possible as they may be
+ * invoked very early during process loading, and the command may not execute
+ * even though it was constructed.
+ */
+public abstract class TextBuiltin {
 	protected static final String REFS_HEADS = Constants.HEADS_PREFIX + "/";
 
 	protected static final String REFS_REMOTES = Constants.REMOTES_PREFIX + "/";
 
 	protected static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
 
+	/** Stream to output to, typically this is standard output. */
 	protected PrintWriter out;
 
+	/** Git repository the command was invoked within. */
 	protected Repository db;
 
 	TextBuiltin() {
@@ -67,7 +80,17 @@ abstract class TextBuiltin {
 		}
 	}
 
-	abstract void execute(String[] args) throws Exception;
+	/**
+	 * Perform the action(s) of this command.
+	 * 
+	 * @param args
+	 *            command line arguments passed after the command name.
+	 * @throws Exception
+	 *             an error occurred while processing the command. The main
+	 *             framework will catch the exception and print a message on
+	 *             standard error.
+	 */
+	public abstract void execute(String[] args) throws Exception;
 
 	protected ObjectId resolve(final String s) throws IOException {
 		final ObjectId r = db.resolve(s);
-- 
1.5.6.3.569.ga9185
