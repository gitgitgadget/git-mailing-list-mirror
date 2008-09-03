From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it for
	locating test files
Date: Wed, 3 Sep 2008 11:10:22 +0200
Message-ID: <20080903091022.GC23406@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoOr-00048Z-36
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYICJKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYICJKa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:10:30 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:40998 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbYICJK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:10:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id D779519BBD9;
	Wed,  3 Sep 2008 11:10:27 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28874-05; Wed,  3 Sep 2008 11:10:23 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id EE75C19BBCD;
	Wed,  3 Sep 2008 11:10:22 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B3DC96E1091; Wed,  3 Sep 2008 11:07:27 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id C6C4C1DE5C4; Wed,  3 Sep 2008 11:10:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94772>

This simplifies the code for accessing files.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 This is a workaround patch disguised as a cleanup patch. For NetBeans I
 am not yet sure how to setup JGit as a project where everythng works.
 For now I need to be able to override the path to files used by the
 tests and this patch reduces that change to one single place.

 .../dircache/DirCacheCGitCompatabilityTest.java    |    4 ----
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |    6 ++----
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |    6 ++----
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |    3 +--
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +--
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    8 ++++++--
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    4 ++--
 .../org/spearce/jgit/transport/IndexPackTest.java  |    4 ++--
 8 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
index 43b23f6..f8f7fe9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
@@ -137,10 +137,6 @@ assertEquals(ObjectId
 		}
 	}
 
-	private File pathOf(final String name) {
-		return new File("tst", name);
-	}
-
 	private Map<String, CGitIndexRecord> readLsFiles() throws Exception {
 		final LinkedHashMap<String, CGitIndexRecord> r = new LinkedHashMap<String, CGitIndexRecord>();
 		final BufferedReader br = new BufferedReader(new InputStreamReader(
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
index 49235ca..036aacb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
@@ -44,14 +44,12 @@
 public class PackIndexV1Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
-				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
+		return pathOf("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
-				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
+		return pathOf("pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
 	}
 
 	/**
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
index c986c49..c44edcf 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
@@ -44,14 +44,12 @@
 public class PackIndexV2Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
-				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2");
+		return pathOf("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
-				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
+		return pathOf("pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
 	}
 
 	/**
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
index 52d1282..63bf083 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
@@ -54,8 +54,7 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		// index with both small (< 2^31) and big offsets
-		idx = PackIndex.open(new File(new File("tst"),
-				"pack-huge.idx"));
+		idx = PackIndex.open(pathOf("pack-huge.idx"));
 		reverseIdx = new PackReverseIndex(idx);
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 4dd4b2a..c715182 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -239,8 +239,7 @@ public void testWritePack2DeltasCRC32Copy() throws IOException {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final File crc32Idx = new File(packDir,
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
-		copyFile(new File(new File("tst"),
-				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2"),
+		copyFile(pathOf("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2"),
 				crc32Idx);
 		db.openPack(crc32Pack, crc32Idx);
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 14e7179..610296f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -50,7 +50,7 @@
 
 public abstract class RepositoryTestCase extends TestCase {
 
-	protected final File trashParent = new File("trash");
+	protected final File trashParent = pathOf("trash");
 
 	protected File trash;
 
@@ -65,6 +65,10 @@
 		jcommitter = new PersonIdent("J. Committer", "jcommitter@example.com");
 	}
 
+	protected static File pathOf(final String name) {
+		return new File("tst", name);
+	}
+
 	protected static void recursiveDelete(final File dir) {
 		final File[] ls = dir.listFiles();
 		if (ls != null) {
@@ -142,7 +146,7 @@ public void run() {
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
 		};
-		final File tst = new File("tst");
+		final File tst = pathOf(".");
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
 		for (int k = 0; k < packs.length; k++) {
 			copyFile(new File(tst, packs[k] + ".pack"), new File(packDir,
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index c036e79..fa95939 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -43,7 +43,7 @@
 
 public class T0004_PackReader extends RepositoryTestCase {
 	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
-	private static final File TEST_PACK = new File(new File("tst"), PACK_NAME + ".pack");
+	private static final File TEST_PACK = pathOf(PACK_NAME + ".pack");
 	private static final File TEST_IDX = new File(TEST_PACK.getParentFile(), PACK_NAME + ".idx");
 
 	public void test003_lookupCompressedObject() throws IOException {
@@ -77,7 +77,7 @@ public void test004_lookupDeltifiedObject() throws IOException {
 	}
 
 	public void test005_todopack() throws IOException {
-		final File todopack = new File(new File("tst"), "todopack");
+		final File todopack = pathOf("todopack");
 		if (!todopack.isDirectory()) {
 			System.err.println("Skipping " + getName() + ": no " + todopack);
 			return;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
index ffa9142..18575c8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
@@ -63,7 +63,7 @@
 	 * @throws IOException
 	 */
 	public void test1() throws  IOException {
-		File packFile = new File("tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
+		File packFile = pathOf("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack1"));
@@ -89,7 +89,7 @@ public void test1() throws  IOException {
 	 * @throws IOException
 	 */
 	public void test2() throws  IOException {
-		File packFile = new File("tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
+		File packFile = pathOf("pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack2"));
-- 
1.6.0.336.ga07ba



-- 
Jonas Fonseca
