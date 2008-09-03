From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/2] Switch usage of AnyObjectId.toString() to new
	AnyObjectId.name()
Date: Wed, 3 Sep 2008 10:04:38 -0700
Message-ID: <20080903170438.GA28315@spearce.org>
References: <20080903090157.GB23406@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kavns-0002AD-Bb
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYICREl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYICREl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:04:41 -0400
Received: from george.spearce.org ([209.20.77.23]:44787 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYICREj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:04:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CC83C38375; Wed,  3 Sep 2008 17:04:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080903090157.GB23406@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94816>

Jonas Fonseca <fonseca@diku.dk> wrote:
> This allows objects that extend AnyObjectId to override toString() to
> their needs. With this it is possible to subclass for example RevCommit
> and provide a custom toString() implementation without breaking the
> revision walker.
> 
> AnyObjectId's toString() implementation is changed to make sure that
> users relying on the old behavior will break. This patch passes the
> test suite.
 
> ---
>  .../tst/org/spearce/jgit/lib/PackIndexTest.java    |   24 ++++++++++----------
>  .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    4 +-
>  .../src/org/spearce/jgit/lib/AnyObjectId.java      |    7 +++++-
>  .../src/org/spearce/jgit/lib/ObjectId.java         |    4 +-
>  .../src/org/spearce/jgit/lib/RefLogWriter.java     |    2 +-
>  .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
>  6 files changed, 24 insertions(+), 19 deletions(-)

Hmm.  I had to squash this into it just to fix most of the code and
make it pass tests, let alone fix the fetch and push implementations.
Most of the library plain up and broke with this toString change.

Missing T0001_ObjectId suggests to me that your method of running
the tests isn't working right.

And this is only JGit.  I haven't even started to look into EGit.
Though I don't expect you to fix EGit since you are working on
NetBeans.  :-)

 .../src/org/spearce/jgit/pgm/DiffTree.java         |    2 +-
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    2 +-
 .../src/org/spearce/jgit/pgm/LsTree.java           |    2 +-
 .../src/org/spearce/jgit/pgm/MergeBase.java        |    2 +-
 .../src/org/spearce/jgit/pgm/ShowRef.java          |    2 +-
 .../org/spearce/jgit/pgm/debug/ShowDirCache.java   |    2 +-
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    6 +-
 .../tst/org/spearce/jgit/lib/T0001_ObjectId.java   |    4 +-
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   36 ++++++------
 .../tst/org/spearce/jgit/lib/T0007_Index.java      |    6 +-
 .../org/spearce/jgit/lib/T0008_testparserev.java   |   64 ++++++++++----------
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |    2 +-
 .../jgit/errors/CorruptObjectException.java        |    2 +-
 .../jgit/errors/IncorrectObjectTypeException.java  |    2 +-
 .../jgit/errors/MissingObjectException.java        |    2 +-
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    5 +-
 .../src/org/spearce/jgit/lib/Commit.java           |    2 +-
 .../src/org/spearce/jgit/lib/GitIndex.java         |    2 +-
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |    2 +-
 .../src/org/spearce/jgit/revwalk/DateRevQueue.java |    2 +-
 .../src/org/spearce/jgit/revwalk/FIFORevQueue.java |    2 +-
 .../src/org/spearce/jgit/revwalk/LIFORevQueue.java |    2 +-
 .../spearce/jgit/revwalk/MergeBaseGenerator.java   |    2 +-
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |    4 +-
 .../jgit/transport/BasePackFetchConnection.java    |    4 +-
 .../jgit/transport/BasePackPushConnection.java     |    4 +-
 .../spearce/jgit/transport/FetchHeadRecord.java    |    2 +-
 .../src/org/spearce/jgit/transport/IndexPack.java  |    2 +-
 .../jgit/transport/WalkFetchConnection.java        |   38 ++++++------
 .../spearce/jgit/transport/WalkPushConnection.java |    2 +-
 30 files changed, 107 insertions(+), 104 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
index b3f6738..56b4c99 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
@@ -87,7 +87,7 @@ protected void run() throws Exception {
 			}
 
 			for (int i = 0; i < nTree; i++) {
-				out.print(walk.getObjectId(i));
+				out.print(walk.getObjectId(i).name());
 				out.print(' ');
 			}
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
index 391a04d..bfa38ec 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
@@ -64,7 +64,7 @@ protected void run() throws Exception {
 	}
 
 	private void show(final AnyObjectId id, final String name) {
-		out.print(id);
+		out.print(id.name());
 		out.print('\t');
 		out.print(name);
 		out.println();
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
index 8d4937f..a5c0ca0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
@@ -67,7 +67,7 @@ protected void run() throws Exception {
 			out.print(Constants.typeString(mode.getObjectType()));
 
 			out.print(' ');
-			out.print(walk.getObjectId(0));
+			out.print(walk.getObjectId(0).name());
 
 			out.print('\t');
 			out.print(walk.getPathString());
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
index c0ddd3b..93b1506 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
@@ -67,7 +67,7 @@ protected void run() throws Exception {
 			final RevCommit b = argWalk.next();
 			if (b == null)
 				break;
-			out.println(b.getId());
+			out.println(b.getId().name());
 		}
 	}
 }
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
index 6dfba3e..b09ae5b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
@@ -53,7 +53,7 @@ protected void run() throws Exception {
 	}
 
 	private void show(final AnyObjectId id, final String name) {
-		out.print(id);
+		out.print(id.name());
 		out.print('\t');
 		out.print(name);
 		out.println();
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
index 0822503..79f5500 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
@@ -63,7 +63,7 @@ protected void run() throws Exception {
 			out.print(' ');
 			out.print(fmt.format(mtime));
 			out.print(' ');
-			out.print(ent.getObjectId());
+			out.print(ent.getObjectId().name());
 			out.print('\t');
 			out.print(ent.getPathString());
 			out.println();
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 539b731..0fcb2dc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -372,7 +372,7 @@ private void writeVerifyPack1() throws IOException {
 		assertEquals(expectedOrder.length, writer.getObjectsNumber());
 		verifyObjectsOrder(expectedOrder);
 		assertEquals("34be9032ac282b11fa9babdc2b2a93ca996c9c2f", writer
-				.computeName().toString());
+				.computeName().name());
 	}
 
 	private void writeVerifyPack2(boolean deltaReuse) throws IOException {
@@ -401,7 +401,7 @@ private void writeVerifyPack2(boolean deltaReuse) throws IOException {
 		assertEquals(expectedOrder.length, writer.getObjectsNumber());
 		verifyObjectsOrder(expectedOrder);
 		assertEquals("ed3f96b8327c7c66b0f8f70056129f0769323d86", writer
-				.computeName().toString());
+				.computeName().name());
 	}
 
 	private void writeVerifyPack4(final boolean thin) throws IOException {
@@ -431,7 +431,7 @@ private void writeVerifyPack4(final boolean thin) throws IOException {
 		}
 		verifyObjectsOrder(expectedObjects);
 		assertEquals("cded4b74176b4456afa456768b2b5aafb41c44fc", writer
-				.computeName().toString());
+				.computeName().name());
 	}
 
 	private void createVerifyOpenPack(final Collection<ObjectId> interestings,
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
index 6fc9645..4c03667 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0001_ObjectId.java
@@ -43,13 +43,13 @@
 	public void test001_toString() {
 		final String x = "def4c620bc3713bb1bb26b808ec9312548e73946";
 		final ObjectId oid = ObjectId.fromString(x);
-		assertEquals(x, oid.toString());
+		assertEquals(x, oid.name());
 	}
 
 	public void test002_toString() {
 		final String x = "ff00eedd003713bb1bb26b808ec9312548e73946";
 		final ObjectId oid = ObjectId.fromString(x);
-		assertEquals(x, oid.toString());
+		assertEquals(x, oid.name());
 	}
 
 	public void test003_equals() {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
index fbe8f0a..6a296be 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -80,7 +80,7 @@ public void test002_WriteEmptyTree() throws IOException {
 		final Tree t = new Tree(db);
 		t.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
 		assertEquals("4b825dc642cb6eb9a060e54bf8d69288fbee4904", t.getId()
-				.toString());
+				.name());
 		final File o = new File(new File(new File(trash_git, "objects"), "4b"),
 				"825dc642cb6eb9a060e54bf8d69288fbee4904");
 		assertTrue("Exists " + o, o.isFile());
@@ -93,7 +93,7 @@ public void test002_WriteEmptyTree2() throws IOException {
 		final Tree t = new Tree(db);
 		t.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
 		assertEquals("4b825dc642cb6eb9a060e54bf8d69288fbee4904", t.getId()
-				.toString());
+				.name());
 		final File o = new File(new File(new File(trash_git, "objects"), "4b"),
 				"825dc642cb6eb9a060e54bf8d69288fbee4904");
 		assertFalse("Exists " + o, o.isFile());
@@ -105,7 +105,7 @@ public void test003_WriteShouldBeEmptyTree() throws IOException {
 		t.addFile("should-be-empty").setId(emptyId);
 		t.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
 		assertEquals("7bb943559a305bdd6bdee2cef6e5df2413c3d30a", t.getId()
-				.toString());
+				.name());
 
 		File o;
 		o = new File(new File(new File(trash_git, "objects"), "7b"),
@@ -264,13 +264,13 @@ public void test020_createBlobTag() throws IOException {
 		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
 		t.setMessage("test020 tagged\n");
 		t.tag();
-		assertEquals("6759556b09fbb4fd8ae5e315134481cc25d46954", t.getTagId().toString());
+		assertEquals("6759556b09fbb4fd8ae5e315134481cc25d46954", t.getTagId().name());
 
 		Tag mapTag = db.mapTag("test020");
 		assertEquals("blob", mapTag.getType());
 		assertEquals("test020 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
-		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().toString());
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().name());
 	}
 
 	public void test020b_createBlobPlainTag() throws IOException {
@@ -281,7 +281,7 @@ public void test020b_createBlobPlainTag() throws IOException {
 		t.tag();
 		
 		Tag mapTag = db.mapTag("test020b");
-		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().toString());
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag.getObjId().name());
 		
 		// We do not repeat the plain tag test for other object types
 	}
@@ -298,13 +298,13 @@ public void test021_createTreeTag() throws IOException {
 		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
 		t.setMessage("test021 tagged\n");
 		t.tag();
-		assertEquals("b0517bc8dbe2096b419d42424cd7030733f4abe5", t.getTagId().toString());
+		assertEquals("b0517bc8dbe2096b419d42424cd7030733f4abe5", t.getTagId().name());
 
 		Tag mapTag = db.mapTag("test021");
 		assertEquals("tree", mapTag.getType());
 		assertEquals("test021 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
-		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag.getObjId().toString());
+		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag.getObjId().name());
 	}
 
 	public void test022_createCommitTag() throws IOException {
@@ -325,13 +325,13 @@ public void test022_createCommitTag() throws IOException {
 		t.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
 		t.setMessage("test022 tagged\n");
 		t.tag();
-		assertEquals("0ce2ebdb36076ef0b38adbe077a07d43b43e3807", t.getTagId().toString());
+		assertEquals("0ce2ebdb36076ef0b38adbe077a07d43b43e3807", t.getTagId().name());
 
 		Tag mapTag = db.mapTag("test022");
 		assertEquals("commit", mapTag.getType());
 		assertEquals("test022 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
-		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag.getObjId().toString());
+		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag.getObjId().name());
 	}
 	
 	public void test023_createCommitNonAnullii() throws IOException {
@@ -346,7 +346,7 @@ public void test023_createCommitNonAnullii() throws IOException {
 		commit.setEncoding("UTF-8");
 		commit.setMessage("\u00dcbergeeks");
 		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
-		assertEquals("4680908112778718f37e686cbebcc912730b3154", cid.toString());
+		assertEquals("4680908112778718f37e686cbebcc912730b3154", cid.name());
 	}
 
 	public void test024_createCommitNonAscii() throws IOException {
@@ -361,7 +361,7 @@ public void test024_createCommitNonAscii() throws IOException {
 		commit.setEncoding("ISO-8859-1");
 		commit.setMessage("\u00dcbergeeks");
 		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
-		assertEquals("2979b39d385014b33287054b87f77bcb3ecb5ebf", cid.toString());
+		assertEquals("2979b39d385014b33287054b87f77bcb3ecb5ebf", cid.name());
 	}
 	
 	public void test025_packedRefs() throws IOException {
@@ -393,19 +393,19 @@ public void test025_packedRefs() throws IOException {
 		assertEquals("blob", mapTag20.getType());
 		assertEquals("test020 tagged\n", mapTag20.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag20.getAuthor());
-		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag20.getObjId().toString());
+		assertEquals("e69de29bb2d1d6434b8b29ae775ad8c2e48c5391", mapTag20.getObjId().name());
 
 		Tag mapTag21 = db.mapTag("test021");
 		assertEquals("tree", mapTag21.getType());
 		assertEquals("test021 tagged\n", mapTag21.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag21.getAuthor());
-		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag21.getObjId().toString());
+		assertEquals("417c01c8795a35b8e835113a85a5c0c1c77f67fb", mapTag21.getObjId().name());
 
 		Tag mapTag22 = db.mapTag("test022");
 		assertEquals("commit", mapTag22.getType());
 		assertEquals("test022 tagged\n", mapTag22.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag22.getAuthor());
-		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag22.getObjId().toString());
+		assertEquals("b5d3b45a96b340441f5abb9080411705c51cc86c", mapTag22.getObjId().name());
 	}
 
 	public void test025_computeSha1NoStore() throws IOException {
@@ -414,7 +414,7 @@ public void test025_computeSha1NoStore() throws IOException {
 		// TODO: but we do not test legacy header writing
 		final ObjectId id = new ObjectWriter(db).computeBlobSha1(data.length,
 				new ByteArrayInputStream(data));
-		assertEquals("4f561df5ecf0dfbd53a0dc0f37262fef075d9dde", id.toString());
+		assertEquals("4f561df5ecf0dfbd53a0dc0f37262fef075d9dde", id.name());
 	}
 
 	public void test026_CreateCommitMultipleparents() throws IOException {
@@ -512,7 +512,7 @@ public void test027_UnpackedRefHigherPriorityThanPacked() throws IOException {
 		writer.close();
 
 		ObjectId resolved = db.resolve("refs/heads/a");
-		assertEquals(unpackedId, resolved.toString());
+		assertEquals(unpackedId, resolved.name());
 	}
 
 	public void test028_LockPackedRef() throws IOException {
@@ -520,7 +520,7 @@ public void test028_LockPackedRef() throws IOException {
 		writeTrashFile(".git/HEAD", "ref: refs/heads/foobar\n");
 
 		ObjectId resolve = db.resolve("HEAD");
-		assertEquals("7f822839a2fe9760f386cbbbcb3f92c5fe81def7", resolve.toString());
+		assertEquals("7f822839a2fe9760f386cbbbcb3f92c5fe81def7", resolve.name());
 
 		RefUpdate lockRef = db.updateRef("HEAD");
 		ObjectId newId = ObjectId.fromString("07f822839a2fe9760f386cbbbcb3f92c5fe81def");
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
index a46daf3..69f3a48 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
@@ -171,7 +171,7 @@ public void testWriteTree() throws Exception {
 		index.write();
 
 		ObjectId id = index.writeTree();
-		assertEquals("c696abc3ab8e091c665f49d00eb8919690b3aec3", id.toString());
+		assertEquals("c696abc3ab8e091c665f49d00eb8919690b3aec3", id.name());
 		
 		writeTrashFile("a/b", "data:a/b");
 		index.add(trash, new File(trash, "a/b"));
@@ -193,7 +193,7 @@ public void testReadTree() throws Exception {
 
 		ObjectId id = index.writeTree();
 		System.out.println("wrote id " + id);
-		assertEquals("c696abc3ab8e091c665f49d00eb8919690b3aec3", id.toString());
+		assertEquals("c696abc3ab8e091c665f49d00eb8919690b3aec3", id.name());
 		GitIndex index2 = new GitIndex(db);
 
 		index2.readTree(db.mapTree(ObjectId.fromString(
@@ -236,7 +236,7 @@ public void testReadTree2() throws Exception {
 		index.write();
 		ObjectId id = index.writeTree();
 		System.out.println("wrote id " + id);
-		assertEquals("ba78e065e2c261d4f7b8f42107588051e87e18e9", id.toString());
+		assertEquals("ba78e065e2c261d4f7b8f42107588051e87e18e9", id.name());
 		GitIndex index2 = new GitIndex(db);
 
 		index2.readTree(db.mapTree(ObjectId.fromString(
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
index 08da671..8883b8b 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
@@ -43,75 +43,75 @@
 public class T0008_testparserev extends RepositoryTestCase {
 
 	public void testObjectId_existing() throws IOException {
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0").toString());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0").name());
 	}
 
 	public void testObjectId_nonexisting() throws IOException {
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c1",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c1").toString());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c1",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c1").name());
 	}
 
 	public void testObjectId_objectid_implicit_firstparent() throws IOException {
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^").toString());
-		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^").toString());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^^").toString());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^").name());
+		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^^").name());
 	}
 
 	public void testObjectId_objectid_self() throws IOException {
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0").toString());
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0^0").toString());
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0^0^0").toString());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0").name());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0^0").name());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^0^0^0").name());
 	}
 
 	public void testObjectId_objectid_explicit_firstparent() throws IOException {
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1").toString());
-		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1^1").toString());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1^1^1").toString());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1").name());
+		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1^1").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1^1^1").name());
 	}
 
 	public void testObjectId_objectid_explicit_otherparents() throws IOException {
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1").toString());
-		assertEquals("f73b95671f326616d66b2afb3bdfcdbbce110b44",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^2").toString());
-		assertEquals("d0114ab8ac326bab30e3a657a0397578c5a1af88",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^3").toString());
-		assertEquals("d0114ab8ac326bab30e3a657a0397578c5a1af88",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^03").toString());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^1").name());
+		assertEquals("f73b95671f326616d66b2afb3bdfcdbbce110b44",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^2").name());
+		assertEquals("d0114ab8ac326bab30e3a657a0397578c5a1af88",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^3").name());
+		assertEquals("d0114ab8ac326bab30e3a657a0397578c5a1af88",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^03").name());
 	}
 
 	public void testRef_refname() throws IOException {
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("master^0").toString());
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("master^").toString());
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("refs/heads/master^1").toString());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("master^0").name());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("master^").name());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("refs/heads/master^1").name());
 	}
 
 	public void testDistance() throws IOException {
-		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~0").toString());
-		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~1").toString());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~2").toString());
-		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~02").toString());
+		assertEquals("6e1475206e57110fcef4b92320436c1e9872a322",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~0").name());
+		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~1").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~2").name());
+		assertEquals("bab66b48f836ed950c99134ef666436fb07a09a0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0~02").name());
 	}
 
 	public void testTree() throws IOException {
-		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{tree}").toString());
-		assertEquals("02ba32d3649e510002c21651936b7077aa75ffa9",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^{tree}").toString());
+		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{tree}").name());
+		assertEquals("02ba32d3649e510002c21651936b7077aa75ffa9",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^^{tree}").name());
 	}
 
 	public void testHEAD() throws IOException {
-		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("HEAD^{tree}").toString());
+		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("HEAD^{tree}").name());
 	}
 
 	public void testDerefCommit() throws IOException {
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{}").toString());
-		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{commit}").toString());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{}").name());
+		assertEquals("49322bb17d3acc9146f98c97d078513228bbf3c0",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{commit}").name());
 		// double deref
-		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{commit}^{tree}").toString());
+		assertEquals("6020a3b8d5d636e549ccbd0c53e2764684bb3125",db.resolve("49322bb17d3acc9146f98c97d078513228bbf3c0^{commit}^{tree}").name());
 	}
 
 	public void testDerefTag() throws IOException {
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{}").toString());
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{blob}").toString());
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{}").name());
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{blob}").name());
 	}
 
 	public void testDerefBlob() throws IOException {
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{}").toString());
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{blob}").toString());
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{}").name());
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{blob}").name());
 	}
 	
 	// TODO: ^{tree} for a tag pointing to a tag
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
index 2645337..3d9d42d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
@@ -54,7 +54,7 @@ public void testParse_NoParents() throws Exception {
 		final StringBuilder body = new StringBuilder();
 
 		body.append("tree ");
-		body.append(treeId);
+		body.append(treeId.name());
 		body.append("\n");
 
 		body.append("author ");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
index 0396762..4eb7aa6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/CorruptObjectException.java
@@ -56,7 +56,7 @@
 	 * @param why
 	 */
 	public CorruptObjectException(final ObjectId id, final String why) {
-		super("Object " + id + " is corrupt: " + why);
+		super("Object " + id.name() + " is corrupt: " + why);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
index 24bdf56..a194f19 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/IncorrectObjectTypeException.java
@@ -60,6 +60,6 @@
 	 * @param type object type
 	 */
 	public IncorrectObjectTypeException(final ObjectId id, final String type) {
-		super("Object " + id + " is not a " + type + ".");
+		super("Object " + id.name() + " is not a " + type + ".");
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
index b663411..37147c3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingObjectException.java
@@ -56,6 +56,6 @@
 	 * @param type object type
 	 */
 	public MissingObjectException(final ObjectId id, final String type) {
-		super("Missing " + type + " " + id);
+		super("Missing " + type + " " + id.name());
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index f82b37f..a534202 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -411,7 +411,10 @@ public String toString() {
 		return "AnyObjectId[" + name() + "]";
 	}
 
-	public String name() {
+	/**
+	 * @return string form of the SHA-1, in lower case hexadecimal.
+	 */
+	public final String name() {
 		return new String(toHexCharArray());
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index 0469b7a..085e2b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -332,7 +332,7 @@ public void commit() throws IOException {
 	}
 
 	public String toString() {
-		return "Commit[" + getCommitId() + " " + getAuthor() + "]";
+		return "Commit[" + ObjectId.toString(getCommitId()) + " " + getAuthor() + "]";
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 0dc61aa..22935ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -580,7 +580,7 @@ private File getFile(File wd) {
 		}
 
 		public String toString() {
-			return new String(name) + "/SHA-1(" + sha1 + ")/M:"
+			return new String(name) + "/SHA-1(" + sha1.name() + ")/M:"
 					+ new Date(ctime / 1000000L) + "/C:"
 					+ new Date(mtime / 1000000L) + "/d" + dev + "/i" + ino
 					+ "/m" + Integer.toString(mode, 8) + "/u" + uid + "/g"
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
index bf1ae1e..db94875 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
@@ -200,6 +200,6 @@ public Storage getStorage() {
 	}
 
 	public String toString() {
-		return "Ref[" + name + "=" + getObjectId() + "]";
+		return "Ref[" + name + "=" + ObjectId.toString(getObjectId()) + "]";
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
index 2a8bd8d..f797477 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
@@ -128,7 +128,7 @@ int outputType() {
 	public String toString() {
 		final StringBuffer s = new StringBuffer();
 		for (Entry q = head; q != null; q = q.next) {
-			s.append(q.commit);
+			s.append(q.commit.name());
 			s.append(' ');
 			s.append(q.commit.commitTime);
 			s.append('\n');
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
index e80bafa..2c4c003 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/FIFORevQueue.java
@@ -152,7 +152,7 @@ public String toString() {
 		final StringBuffer s = new StringBuffer();
 		for (Block q = head; q != null; q = q.next) {
 			for (int i = q.headIndex; i < q.tailIndex; i++) {
-				s.append(q.commits[i]);
+				s.append(q.commits[i].name());
 				s.append(' ');
 				s.append(q.commits[i].commitTime);
 				s.append('\n');
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
index 5dfb8dc..5e885c0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/LIFORevQueue.java
@@ -107,7 +107,7 @@ public String toString() {
 		final StringBuffer s = new StringBuffer();
 		for (Block q = head; q != null; q = q.next) {
 			for (int i = q.headIndex; i < q.tailIndex; i++) {
-				s.append(q.commits[i]);
+				s.append(q.commits[i].name());
 				s.append(' ');
 				s.append(q.commits[i].commitTime);
 				s.append('\n');
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
index 308e62e..1676caa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
@@ -102,7 +102,7 @@ private void add(final RevCommit c) {
 			// commit admitted to the initial queue only once. If
 			// we see this marks aren't correctly erased.
 			//
-			throw new IllegalStateException("Stale RevFlags found on " + c);
+			throw new IllegalStateException("Stale RevFlags on " + c.name());
 		}
 		c.flags |= flag;
 		pending.add(c);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 1ba21eb..69a20aa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -277,7 +277,7 @@ public RevObject nextObject() throws MissingObjectException,
 				if (FileMode.GITLINK.equals(mode))
 					continue;
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0) + " "
+						+ " for " + treeWalk.getObjectId(0).name() + " "
 						+ treeWalk.getPathString() + " in " + currentTree + ".");
 			}
 		}
@@ -407,7 +407,7 @@ private void markTreeUninteresting(final RevTree tree)
 				if (FileMode.GITLINK.equals(mode))
 					continue;
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0) + " "
+						+ " for " + treeWalk.getObjectId(0).name() + " "
 						+ treeWalk.getPathString() + " in " + tree + ".");
 			}
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 12b36f2..39fa761 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -244,7 +244,7 @@ private boolean sendWants(final Collection<Ref> want) throws IOException {
 
 			final StringBuilder line = new StringBuilder(46);
 			line.append("want ");
-			line.append(r.getObjectId());
+			line.append(r.getObjectId().name());
 			if (first) {
 				line.append(enableCapabilities());
 				first = false;
@@ -288,7 +288,7 @@ private void negotiate(final ProgressMonitor monitor) throws IOException,
 			if (c == null)
 				break;
 
-			pckOut.writeString("have " + c.getId() + "\n");
+			pckOut.writeString("have " + c.getId().name() + "\n");
 			havesSent++;
 			havesSinceLastContinue++;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index a6ab9c4..2594623 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -154,9 +154,9 @@ private void writeCommands(final Collection<RemoteRefUpdate> refUpdates,
 			final Ref advertisedRef = getRef(rru.getRemoteName());
 			final ObjectId oldId = (advertisedRef == null ? ObjectId.zeroId()
 					: advertisedRef.getObjectId());
-			sb.append(oldId);
+			sb.append(oldId.name());
 			sb.append(' ');
-			sb.append(rru.getNewObjectId());
+			sb.append(rru.getNewObjectId().name());
 			sb.append(' ');
 			sb.append(rru.getRemoteName());
 			if (!sentCommand) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
index 83a16dc..d957028 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
@@ -71,7 +71,7 @@ void write(final PrintWriter pw) {
 			name = sourceName;
 		}
 
-		pw.print(newValue);
+		pw.print(newValue.name());
 		pw.print('\t');
 		if (notForMerge)
 			pw.print("not-for-merge");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index d8e6548..2c98823 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -842,7 +842,7 @@ public void renameAndOpenPack() throws IOException {
 			d.update(oeBytes);
 		}
 
-		final ObjectId name = ObjectId.fromRaw(d.digest());
+		final String name = ObjectId.fromRaw(d.digest()).name();
 		final File packDir = new File(repo.getObjectsDirectory(), "pack");
 		final File finalPack = new File(packDir, "pack-" + name + ".pack");
 		final File finalIdx = new File(packDir, "pack-" + name + ".idx");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 5a21d24..f309fe1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -224,7 +224,7 @@ private void queueWants(final Collection<Ref> want)
 				if (inWorkQueue.add(id))
 					workQueue.add(id);
 			} catch (IOException e) {
-				throw new TransportException("Object read error " + id + ".", e);
+				throw new TransportException("Cannot read " + id.name(), e);
 			}
 		}
 	}
@@ -243,7 +243,7 @@ private void process(final ObjectId id) throws TransportException {
 					return;
 			}
 		} catch (IOException e) {
-			throw new TransportException("Object read error " + id + ".", e);
+			throw new TransportException("Cannot read " + id.name(), e);
 		}
 
 		// We only care about traversal; disposing an object throws its
@@ -266,7 +266,7 @@ private void process(final ObjectId id) throws TransportException {
 			processTag(obj);
 			break;
 		default:
-			throw new TransportException("Unknown object type " + obj.getId());
+			throw new TransportException("Unknown object type " + id.name());
 		}
 
 		// If we had any prior errors fetching this object they are
@@ -277,7 +277,7 @@ private void process(final ObjectId id) throws TransportException {
 
 	private void processBlob(final RevObject obj) throws TransportException {
 		if (!local.hasObject(obj))
-			throw new TransportException("Cannot read blob " + obj,
+			throw new TransportException("Cannot read blob " + obj.name(),
 					new MissingObjectException(obj, Constants.TYPE_BLOB));
 		obj.add(COMPLETE);
 	}
@@ -300,13 +300,13 @@ private void processTree(final RevObject obj) throws TransportException {
 					if (FileMode.GITLINK.equals(mode))
 						continue;
 					throw new CorruptObjectException("Invalid mode " + mode
-							+ " for " + treeWalk.getObjectId(0) + " "
-							+ treeWalk.getPathString() + " in " + obj.getId()
-							+ ".");
+							+ " for " + treeWalk.getObjectId(0).name() + " "
+							+ treeWalk.getPathString() + " in "
+							+ obj.getId().name() + ".");
 				}
 			}
 		} catch (IOException ioe) {
-			throw new TransportException("Cannot read tree " + obj, ioe);
+			throw new TransportException("Cannot read tree " + obj.name(), ioe);
 		}
 		obj.add(COMPLETE);
 	}
@@ -351,7 +351,7 @@ private void downloadObject(final ProgressMonitor pm, final AnyObjectId id)
 			// Search for a loose object over all alternates, starting
 			// from the one we last successfully located an object through.
 			//
-			final String idStr = id.toString();
+			final String idStr = id.name();
 			final String subdir = idStr.substring(0, 2);
 			final String file = idStr.substring(2);
 			final String looseName = subdir + "/" + file;
@@ -413,7 +413,7 @@ private void downloadObject(final ProgressMonitor pm, final AnyObjectId id)
 			List<Throwable> failures = fetchErrors.get(id.copy());
 			final TransportException te;
 
-			te = new TransportException("Cannot get " + id + ".");
+			te = new TransportException("Cannot get " + id.name() + ".");
 			if (failures != null && !failures.isEmpty()) {
 				if (failures.size() == 1)
 					te.initCause(failures.get(0));
@@ -489,7 +489,7 @@ private boolean downloadPackedObject(final ProgressMonitor monitor,
 				// the object, but after indexing we didn't
 				// actually find it in the pack.
 				//
-				recordError(id, new FileNotFoundException("Object " + id
+				recordError(id, new FileNotFoundException("Object " + id.name()
 						+ " not found in " + pack.packName + "."));
 				continue;
 			}
@@ -533,7 +533,7 @@ private boolean downloadLooseObject(final AnyObjectId id,
 			recordError(id, e);
 			return false;
 		} catch (IOException e) {
-			throw new TransportException("Cannot download " + id + ".", e);
+			throw new TransportException("Cannot download " + id.name(), e);
 		}
 	}
 
@@ -555,15 +555,15 @@ private void verifyLooseObject(final AnyObjectId id, final byte[] compressed)
 			// source.
 			//
 			final FileNotFoundException e;
-			e = new FileNotFoundException(id.toString());
+			e = new FileNotFoundException(id.name());
 			e.initCause(parsingError);
 			throw e;
 		}
 
 		if (!AnyObjectId.equals(id, uol.getId()))
-			throw new TransportException("Incorrect hash for " + id
-					+ "; computed " + uol.getId() + " as a " + uol.getType()
-					+ " from " + compressed.length + " bytes.");
+			throw new TransportException("Incorrect hash for " + id.name()
+					+ "; computed " + uol.getId().name() + " as a "
+					+ uol.getType() + " from " + compressed.length + " bytes.");
 	}
 
 	private void saveLooseObject(final AnyObjectId id, final byte[] compressed)
@@ -599,7 +599,7 @@ private void saveLooseObject(final AnyObjectId id, final byte[] compressed)
 		tmp.delete();
 		if (local.hasObject(id))
 			return;
-		throw new ObjectWritingException("Unable to store " + id + ".");
+		throw new ObjectWritingException("Unable to store " + id.name() + ".");
 	}
 
 	private Collection<WalkRemoteObjectDatabase> expandOneAlternate(
@@ -713,8 +713,8 @@ private void markTreeComplete(final RevTree tree) throws IOException {
 				if (FileMode.GITLINK.equals(mode))
 					continue;
 				throw new CorruptObjectException("Invalid mode " + mode
-						+ " for " + treeWalk.getObjectId(0) + " "
-						+ treeWalk.getPathString() + " in " + tree + ".");
+						+ " for " + treeWalk.getObjectId(0).name() + " "
+						+ treeWalk.getPathString() + " in " + tree.name() + ".");
 			}
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 31c86df..601ae66 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -223,7 +223,7 @@ private void sendpack(final List<RemoteRefUpdate> updates,
 			for (final String n : dest.getPackNames())
 				packNames.put(n, n);
 
-			final String base = "pack-" + pw.computeName();
+			final String base = "pack-" + pw.computeName().name();
 			final String packName = base + ".pack";
 			pathPack = "pack/" + packName;
 			pathIdx = "pack/" + base + ".idx";

-- 
Shawn.
