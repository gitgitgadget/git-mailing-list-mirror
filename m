From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 01/10] Require javadoc on protected methods in jgit core
Date: Mon, 16 Mar 2009 21:14:34 +0100
Message-ID: <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJEV-0007a9-Oo
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbZCPUO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbZCPUO4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:14:56 -0400
Received: from mail.dewire.com ([83.140.172.130]:5260 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685AbZCPUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:14:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D2D80138AD59;
	Mon, 16 Mar 2009 21:14:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YTr1E7bIaZQs; Mon, 16 Mar 2009 21:14:44 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4EAD9138AD57;
	Mon, 16 Mar 2009 21:14:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113367>

In general protected methods are part of a public API since they grant
access to code outside of the package that declares the method or field.

A few protected fields and methods do not have javadocs, but it turns
out all but one are not used outside the package that declares them so
we can simply make them package private. This doesn't mean they aren't
supposed to be an API, but we can upgrade them if necessary.

A few places are actually used outside the package and are valid uses. For
those appropriate javadocs are added.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |    7 ++++---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    9 +++++++--
 .../.settings/org.eclipse.jdt.core.prefs           |    5 +++--
 .../jgit/dircache/DirCacheBuildIterator.java       |    2 +-
 .../spearce/jgit/dircache/DirCacheIterator.java    |    2 +-
 .../src/org/spearce/jgit/lib/ObjectId.java         |    2 +-
 .../src/org/spearce/jgit/lib/PackIndex.java        |    6 +++---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    2 +-
 .../jgit/lib/TreeVisitorWithCurrentDirectory.java  |    4 ++--
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |   14 +++++++-------
 .../org/spearce/jgit/merge/StrategyOneSided.java   |    2 +-
 .../src/org/spearce/jgit/patch/FileHeader.java     |   18 +++++++++---------
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    4 ++--
 .../org/spearce/jgit/revplot/PlotCommitList.java   |    9 +++++++++
 .../src/org/spearce/jgit/revplot/PlotWalk.java     |    4 ++++
 .../org/spearce/jgit/transport/DaemonService.java  |    4 ++--
 .../org/spearce/jgit/transport/OpenSshConfig.java  |    2 +-
 .../spearce/jgit/transport/OperationResult.java    |   10 +++++-----
 .../spearce/jgit/transport/PackedObjectInfo.java   |    2 +-
 .../src/org/spearce/jgit/transport/PushResult.java |    2 +-
 .../spearce/jgit/transport/RemoteRefUpdate.java    |    6 +++---
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    7 +++++++
 22 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
index a67b954..f0c80d3 100644
--- a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Sun Feb 03 03:16:45 CET 2008
+#Sun Mar 15 19:46:39 CET 2009
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -36,10 +36,11 @@ org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
 org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
 org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=public
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagDescription=return_tag
 org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=protected
 org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
 org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index d3e32b3..0cbd0d9 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -207,18 +207,23 @@ public Repository getRepository() {
 		return db;
 	}
 
-	protected ObjectId resolve(final String s) throws IOException {
+	ObjectId resolve(final String s) throws IOException {
 		final ObjectId r = db.resolve(s);
 		if (r == null)
 			throw die("Not a revision: " + s);
 		return r;
 	}
 
+	/**
+	 * @param why
+	 *            textual explanation
+	 * @return a runtime exception the caller is expected to throw
+	 */
 	protected static Die die(final String why) {
 		return new Die(why);
 	}
 
-	protected String abbreviateRef(String dst, boolean abbreviateRemote) {
+	String abbreviateRef(String dst, boolean abbreviateRemote) {
 		if (dst.startsWith(R_HEADS))
 			dst = dst.substring(R_HEADS.length());
 		else if (dst.startsWith(R_TAGS))
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
index a67b954..8e8e172 100644
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Sun Feb 03 03:16:45 CET 2008
+#Sun Mar 15 01:13:43 CET 2009
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -36,7 +36,8 @@ org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
 org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
 org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=public
+org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
+org.eclipse.jdt.core.compiler.problem.missingJavadocTagDescription=return_tag
 org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
index 234ffd2..9818b76 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheBuildIterator.java
@@ -91,7 +91,7 @@ public DirCacheBuildIterator(final DirCacheBuilder dcb) {
 		builder = dcb;
 	}
 
-	protected DirCacheBuildIterator(final DirCacheBuildIterator p,
+	DirCacheBuildIterator(final DirCacheBuildIterator p,
 			final DirCacheTree dct) {
 		super(p, dct);
 		builder = p.builder;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
index 8384723..356d735 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheIterator.java
@@ -105,7 +105,7 @@ public DirCacheIterator(final DirCache dc) {
 			parseEntry();
 	}
 
-	protected DirCacheIterator(final DirCacheIterator p, final DirCacheTree dct) {
+	DirCacheIterator(final DirCacheIterator p, final DirCacheTree dct) {
 		super(p, p.path, p.pathLen + 1);
 		cache = p.cache;
 		tree = dct;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 52ce0d4..fde209b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -238,7 +238,7 @@ private static final ObjectId fromHexString(final byte[] bs, int p) {
 		}
 	}
 
-	protected ObjectId(final int new_1, final int new_2, final int new_3,
+	ObjectId(final int new_1, final int new_2, final int new_3,
 			final int new_4, final int new_5) {
 		w1 = new_1;
 		w2 = new_2;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 473ce1e..b8e7447 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -243,7 +243,7 @@ abstract long findCRC32(AnyObjectId objId) throws MissingObjectException,
 	 * 
 	 */
 	public static class MutableEntry {
-		protected final MutableObjectId idBuffer = new MutableObjectId();
+		final MutableObjectId idBuffer = new MutableObjectId();
 
 		long offset;
 
@@ -281,12 +281,12 @@ public MutableEntry cloneEntry() {
 			return r;
 		}
 
-		protected void ensureId() {
+		void ensureId() {
 			// Override in implementations.
 		}
 	}
 
-	protected abstract class EntriesIterator implements Iterator<MutableEntry> {
+	abstract class EntriesIterator implements Iterator<MutableEntry> {
 		protected final MutableEntry entry = initEntry();
 
 		protected long returnedNumber = 0;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index b878409..2183872 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -931,7 +931,7 @@ boolean isDeltaRepresentation() {
 		 * @return true if object is already written; false otherwise.
 		 */
 		boolean isWritten() {
-			return offset != 0;
+			return getOffset() != 0;
 		}
 
 		PackedObjectLoader getReuseLoader() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
index e227adb..3e1e1ea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitorWithCurrentDirectory.java
@@ -50,11 +50,11 @@
 
 	private File currentDirectory;
 
-	protected TreeVisitorWithCurrentDirectory(final File rootDirectory) {
+	TreeVisitorWithCurrentDirectory(final File rootDirectory) {
 		currentDirectory = rootDirectory;
 	}
 
-	protected File getCurrentDirectory() {
+	File getCurrentDirectory() {
 		return currentDirectory;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
index 15e00df..d3da74a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
@@ -56,15 +56,15 @@
  * Three-way merges are no performed. See {@link #setFailOnConflict(boolean)}.
  */
 public class WorkDirCheckout {
-	protected Repository repo;
+	Repository repo;
 
-	protected File root;
+	File root;
 
-	protected GitIndex index;
+	GitIndex index;
 	
 	private boolean failOnConflict = true;
 
-	protected Tree merge;
+	Tree merge;
 
 	
 	/**
@@ -151,9 +151,9 @@ private void checkoutTwoTrees() throws FileNotFoundException, IOException {
 	ArrayList<String> conflicts  = new ArrayList<String>();
 	ArrayList<String> removed = new ArrayList<String>();
 
-	protected Tree head = null;
+	Tree head = null;
 
-	protected HashMap<String, ObjectId> updated = new HashMap<String, ObjectId>();
+	HashMap<String, ObjectId> updated = new HashMap<String, ObjectId>();
 	
 	private void checkoutOutIndexNoHead() throws IOException {
 		new IndexTreeWalker(index, merge, root, new AbstractIndexTreeVisitor() {
@@ -294,7 +294,7 @@ else if (file.isDirectory()) {
 		conflicts.removeAll(removed);
 	}
 
-	protected void processEntry(TreeEntry h, TreeEntry m, Entry i,
+	void processEntry(TreeEntry h, TreeEntry m, Entry i,
 			File file) throws IOException {
 				ObjectId iId = (i == null ? null : i.getObjectId());
 				ObjectId mId = (m == null ? null : m.getId());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
index 8677b28..c594daa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
@@ -77,7 +77,7 @@ public Merger newMerger(final Repository db) {
 		return new OneSide(db, treeIndex);
 	}
 
-	protected static class OneSide extends Merger {
+	static class OneSide extends Merger {
 		private final int treeIndex;
 
 		protected OneSide(final Repository local, final int index) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index e6cccb2..7d341d8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -68,9 +68,9 @@
 
 	private static final byte[] NEW_MODE = encodeASCII("new mode ");
 
-	protected static final byte[] DELETED_FILE_MODE = encodeASCII("deleted file mode ");
+	static final byte[] DELETED_FILE_MODE = encodeASCII("deleted file mode ");
 
-	protected static final byte[] NEW_FILE_MODE = encodeASCII("new file mode ");
+	static final byte[] NEW_FILE_MODE = encodeASCII("new file mode ");
 
 	private static final byte[] COPY_FROM = encodeASCII("copy from ");
 
@@ -88,7 +88,7 @@
 
 	private static final byte[] DISSIMILARITY_INDEX = encodeASCII("dissimilarity index ");
 
-	protected static final byte[] INDEX = encodeASCII("index ");
+	static final byte[] INDEX = encodeASCII("index ");
 
 	static final byte[] OLD_NAME = encodeASCII("--- ");
 
@@ -220,7 +220,7 @@ public String getScriptText(Charset oldCharset, Charset newCharset) {
 		return getScriptText(new Charset[] { oldCharset, newCharset });
 	}
 
-	protected String getScriptText(Charset[] charsetGuess) {
+	String getScriptText(Charset[] charsetGuess) {
 		if (getHunks().isEmpty()) {
 			// If we have no hunks then we can safely assume the entire
 			// patch is a binary style patch, or a meta-data only style
@@ -562,19 +562,19 @@ int parseGitHeaders(int ptr, final int end) {
 		return ptr;
 	}
 
-	protected void parseOldName(int ptr, final int eol) {
+	void parseOldName(int ptr, final int eol) {
 		oldName = p1(parseName(oldName, ptr + OLD_NAME.length, eol));
 		if (oldName == DEV_NULL)
 			changeType = ChangeType.ADD;
 	}
 
-	protected void parseNewName(int ptr, final int eol) {
+	void parseNewName(int ptr, final int eol) {
 		newName = p1(parseName(newName, ptr + NEW_NAME.length, eol));
 		if (newName == DEV_NULL)
 			changeType = ChangeType.DELETE;
 	}
 
-	protected void parseNewFileMode(int ptr, final int eol) {
+	void parseNewFileMode(int ptr, final int eol) {
 		oldMode = FileMode.MISSING;
 		newMode = parseFileMode(ptr + NEW_FILE_MODE.length, eol);
 		changeType = ChangeType.ADD;
@@ -633,7 +633,7 @@ private static String p1(final String r) {
 		return s > 0 ? r.substring(s + 1) : r;
 	}
 
-	protected FileMode parseFileMode(int ptr, final int end) {
+	FileMode parseFileMode(int ptr, final int end) {
 		int tmp = 0;
 		while (ptr < end - 1) {
 			tmp <<= 3;
@@ -642,7 +642,7 @@ protected FileMode parseFileMode(int ptr, final int end) {
 		return FileMode.fromBits(tmp);
 	}
 
-	protected void parseIndexLine(int ptr, final int end) {
+	void parseIndexLine(int ptr, final int end) {
 		// "index $asha1..$bsha1[ $mode]" where $asha1 and $bsha1
 		// can be unique abbreviations
 		//
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index fc30311..e3ce546 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -307,7 +307,7 @@ void extractFileLines(final StringBuilder sb, final String[] text,
 		}
 	}
 
-	protected void copyLine(final StringBuilder sb, final String[] text,
+	void copyLine(final StringBuilder sb, final String[] text,
 			final int[] offsets, final int fileIdx) {
 		final String s = text[fileIdx];
 		final int start = offsets[fileIdx];
@@ -320,7 +320,7 @@ protected void copyLine(final StringBuilder sb, final String[] text,
 		offsets[fileIdx] = end;
 	}
 
-	protected void skipLine(final String[] text, final int[] offsets,
+	void skipLine(final String[] text, final int[] offsets,
 			final int fileIdx) {
 		final String s = text[fileIdx];
 		final int end = s.indexOf('\n', offsets[fileIdx]);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
index 7e9f509..a0959e2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommitList.java
@@ -171,10 +171,19 @@ private PlotLane nextFreeLane() {
 		return p;
 	}
 
+	/**
+	 * @return a new Lane appropriate for this particular PlotList.
+	 */
 	protected L createLane() {
 		return (L) new PlotLane();
 	}
 
+	/**
+	 * Return colors and other reusable information to the plotter when a lane
+	 * is no longer needed.
+	 * 
+	 * @param lane
+	 */
 	protected void recycleLane(final L lane) {
 		// Nothing.
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
index 8801850..f2a5976 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
@@ -88,6 +88,10 @@ protected RevCommit createCommit(final AnyObjectId id) {
 		return new PlotCommit(id, getTags(id));
 	}
 
+	/**
+	 * @param commitId
+	 * @return return the list of knows tags referring to this commit
+	 */
 	protected Ref[] getTags(final AnyObjectId commitId) {
 		Collection<Ref> list = reverseRefMap.get(commitId);
 		Ref[] tags;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
index 4dc11ef..c511d5a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
@@ -51,7 +51,7 @@
 
 	private boolean overridable;
 
-	protected DaemonService(final String cmdName, final String cfgName) {
+	DaemonService(final String cmdName, final String cfgName) {
 		command = cmdName.startsWith("git-") ? cmdName : "git-" + cmdName;
 		config = cfgName;
 		overridable = true;
@@ -115,6 +115,6 @@ void execute(final DaemonClient client, final String commandLine)
 			execute(client, db);
 	}
 
-	protected abstract void execute(DaemonClient client, Repository db)
+	abstract void execute(DaemonClient client, Repository db)
 			throws IOException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index b08d5c6..0d9f12f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -95,7 +95,7 @@ public static OpenSshConfig get() {
 	/** Cached entries read out of the configuration file. */
 	private Map<String, Host> hosts;
 
-	protected OpenSshConfig(final File h, final File cfg) {
+	OpenSshConfig(final File h, final File cfg) {
 		home = h;
 		configFile = cfg;
 		hosts = Collections.emptyMap();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
index f078f39..7b56d8b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
@@ -53,11 +53,11 @@
  */
 public abstract class OperationResult {
 
-	protected Map<String, Ref> advertisedRefs = Collections.emptyMap();
+	Map<String, Ref> advertisedRefs = Collections.emptyMap();
 
-	protected URIish uri;
+	URIish uri;
 
-	protected final SortedMap<String, TrackingRefUpdate> updates = new TreeMap<String, TrackingRefUpdate>();
+	final SortedMap<String, TrackingRefUpdate> updates = new TreeMap<String, TrackingRefUpdate>();
 
 	/**
 	 * Get the URI this result came from.
@@ -122,12 +122,12 @@ public TrackingRefUpdate getTrackingRefUpdate(final String localName) {
 		return updates.get(localName);
 	}
 
-	protected void setAdvertisedRefs(final URIish u, final Map<String, Ref> ar) {
+	void setAdvertisedRefs(final URIish u, final Map<String, Ref> ar) {
 		uri = u;
 		advertisedRefs = ar;
 	}
 
-	protected void add(final TrackingRefUpdate u) {
+	void add(final TrackingRefUpdate u) {
 		updates.put(u.getLocalName(), u);
 	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
index 045b795..f37f421 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
@@ -49,7 +49,7 @@
  * objects from the pack. This extension of ObjectId includes the offset.
  */
 public class PackedObjectInfo extends ObjectId {
-	protected long offset;
+	private long offset;
 
 	private int crc;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
index f7fbd58..91f9f69 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
@@ -77,7 +77,7 @@ public RemoteRefUpdate getRemoteUpdate(final String refName) {
 		return remoteUpdates.get(refName);
 	}
 
-	protected void setRemoteUpdates(
+	void setRemoteUpdates(
 			final Map<String, RemoteRefUpdate> remoteUpdates) {
 		this.remoteUpdates = remoteUpdates;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index c79f7dc..9b054eb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -315,15 +315,15 @@ public String getMessage() {
 		return message;
 	}
 
-	protected void setStatus(final Status status) {
+	void setStatus(final Status status) {
 		this.status = status;
 	}
 
-	protected void setFastForward(boolean fastForward) {
+	void setFastForward(boolean fastForward) {
 		this.fastForward = fastForward;
 	}
 
-	protected void setMessage(final String message) {
+	void setMessage(final String message) {
 		this.message = message;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index 07ce2ed..836b01a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -309,6 +309,13 @@ static int lastPathChar(final Entry e) {
 		return e.getMode() == FileMode.TREE ? '/' : '\0';
 	}
 
+	/**
+	 * Constructor helper.
+	 *
+	 * @param list
+	 *            files in the subtree of the work tree this iterator operates
+	 *            on
+	 */
 	protected void init(final Entry[] list) {
 		// Filter out nulls, . and .. as these are not valid tree entries,
 		// also cache the encoded forms of the path names for efficient use
-- 
1.6.1.285.g35d8b
