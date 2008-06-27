From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 10/23] Add ignoreMissingUninteresting option to PackWriter
Date: Sat, 28 Jun 2008 00:06:34 +0200
Message-ID: <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
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
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7h-0000rw-N1
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052AbYF0WHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757019AbYF0WHn
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995AbYF0WHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zaw7PE2+ErxBsXOy3vWHHOcGYbzfeUrOhaIwGXXppjU=;
        b=e7wM81b9qiMX1r9UsoqiyqzvCBdhotv0XqQW1LyOtg5h0EeoXmL0nUNVLUN/FSJEfv
         ZOR5EFhQAvSV2YpccrU49jwtzb0dR+C4RmroNpn08q2K0G9kme8471Z8mFdzFq1gdONM
         4Mvt//iRIBy+8wBfv85cmtwtSlPGyC59ZHChg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KT6ZIEwFbg58s28AruPO8Ih837YYFwh9yqkq4XTY4X4R+v/9mMUH39i5pPeBf/JGPi
         ovuWtc5Kg8aD8P2Yb4mIaD0E+x4+D3Iwq/T4f9l9yYo0DqZLge1dvoyMOXdCGx56upWs
         bUhMzg7hV5AO0+kSwDWlNZm1QRe3LOQ0u5SZI=
Received: by 10.210.71.13 with SMTP id t13mr1616538eba.42.1214604458948;
        Fri, 27 Jun 2008 15:07:38 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z33sm2443358ikz.0.2008.06.27.15.07.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86648>

This option is useful when caller cares only about locally existing
uninteresting objects.

Test cases created.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   45 +++++++++++++++++---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   37 +++++++++++-----
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 9572342..f94eb72 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -120,7 +120,7 @@ public class PackWriterTest extends RepositoryTestCase {
 	 * @throws IOException
 	 */
 	public void testWriteEmptyPack1() throws IOException {
-		createVerifyOpenPack(EMPTY_LIST_OBJECT, EMPTY_LIST_OBJECT, false);
+		createVerifyOpenPack(EMPTY_LIST_OBJECT, EMPTY_LIST_OBJECT, false, false);
 
 		assertEquals(0, writer.getObjectsNumber());
 		assertEquals(0, pack.getObjectCount());
@@ -142,6 +142,37 @@ public class PackWriterTest extends RepositoryTestCase {
 	}
 
 	/**
+	 * Try to pass non-existing object as uninteresting, with non-ignoring
+	 * setting.
+	 * 
+	 * @throws IOException
+	 */
+	public void testNotIgnoreNonExistingObjects() throws IOException {
+		final ObjectId nonExisting = ObjectId
+				.fromString("0000000000000000000000000000000000000001");
+		try {
+			createVerifyOpenPack(EMPTY_LIST_OBJECT, Collections.nCopies(1,
+					nonExisting), false, false);
+			fail("Should have thrown MissingObjectException");
+		} catch (MissingObjectException x) {
+			// expected
+		}
+	}
+
+	/**
+	 * Try to pass non-existing object as uninteresting, with ignoring setting.
+	 * 
+	 * @throws IOException
+	 */
+	public void testIgnoreNonExistingObjects() throws IOException {
+		final ObjectId nonExisting = ObjectId
+				.fromString("0000000000000000000000000000000000000001");
+		createVerifyOpenPack(EMPTY_LIST_OBJECT, Collections.nCopies(1,
+				nonExisting), false, true);
+		// shouldn't throw anything
+	}
+
+	/**
 	 * Create pack basing on only interesting objects, then precisely verify
 	 * content. No delta reuse here.
 	 * 
@@ -326,7 +357,7 @@ public class PackWriterTest extends RepositoryTestCase {
 		final LinkedList<ObjectId> interestings = new LinkedList<ObjectId>();
 		interestings.add(ObjectId
 				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"));
-		createVerifyOpenPack(interestings, EMPTY_LIST_OBJECT, false);
+		createVerifyOpenPack(interestings, EMPTY_LIST_OBJECT, false, false);
 
 		final ObjectId expectedOrder[] = new ObjectId[] {
 				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
@@ -352,7 +383,7 @@ public class PackWriterTest extends RepositoryTestCase {
 		final LinkedList<ObjectId> uninterestings = new LinkedList<ObjectId>();
 		uninterestings.add(ObjectId
 				.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab"));
-		createVerifyOpenPack(interestings, uninterestings, false);
+		createVerifyOpenPack(interestings, uninterestings, false, false);
 
 		final ObjectId expectedOrder[] = new ObjectId[] {
 				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
@@ -380,7 +411,7 @@ public class PackWriterTest extends RepositoryTestCase {
 		final LinkedList<ObjectId> uninterestings = new LinkedList<ObjectId>();
 		uninterestings.add(ObjectId
 				.fromString("c59759f143fb1fe21c197981df75a7ee00290799"));
-		createVerifyOpenPack(interestings, uninterestings, thin);
+		createVerifyOpenPack(interestings, uninterestings, thin, false);
 
 		final ObjectId writtenObjects[] = new ObjectId[] {
 				ObjectId.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7"),
@@ -404,9 +435,11 @@ public class PackWriterTest extends RepositoryTestCase {
 	}
 
 	private void createVerifyOpenPack(final Collection<ObjectId> interestings,
-			final Collection<ObjectId> uninterestings, final boolean thin)
+			final Collection<ObjectId> uninterestings, final boolean thin,
+			final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException {
-		writer.writePack(interestings, uninterestings, thin);
+		writer.writePack(interestings, uninterestings, thin,
+				ignoreMissingUninteresting);
 		verifyOpenPack(thin);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index ba43da5..a331237 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -77,7 +77,7 @@ import org.spearce.jgit.util.NB;
  * Typical usage consists of creating instance intended for some pack,
  * configuring options through accessors methods and finally call
  * {@link #writePack(Iterator)} or
- * {@link #writePack(Collection, Collection, boolean)} with objects
+ * {@link #writePack(Collection, Collection, boolean, boolean)} with objects
  * specification, to generate a pack stream.
  * </p>
  * <p>
@@ -98,7 +98,7 @@ public class PackWriter {
 	 * Title of {@link ProgressMonitor} task used during counting objects to
 	 * pack.
 	 * 
-	 * @see #writePack(Collection, Collection, boolean)
+	 * @see #writePack(Collection, Collection, boolean, boolean)
 	 */
 	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects to pack";
 
@@ -107,7 +107,7 @@ public class PackWriter {
 	 * reuse or delta reuse.
 	 * 
 	 * @see #writePack(Iterator)
-	 * @see #writePack(Collection, Collection, boolean)
+	 * @see #writePack(Collection, Collection, boolean, boolean)
 	 */
 	public static final String SEARCHING_REUSE_PROGRESS = "Searching for delta and object reuse";
 
@@ -116,7 +116,7 @@ public class PackWriter {
 	 * (objects)
 	 * 
 	 * @see #writePack(Iterator)
-	 * @see #writePack(Collection, Collection, boolean)
+	 * @see #writePack(Collection, Collection, boolean, boolean)
 	 */
 	public static final String WRITING_OBJECTS_PROGRESS = "Writing objects";
 
@@ -193,7 +193,7 @@ public class PackWriter {
 	 * Create writer for specified repository, that will write a pack to
 	 * provided output stream. Objects for packing are specified in
 	 * {@link #writePack(Iterator)} or
-	 * {@link #writePack(Collection, Collection, boolean)}.
+	 * {@link #writePack(Collection, Collection, boolean, boolean)}.
 	 * 
 	 * @param repo
 	 *            repository where objects are stored.
@@ -203,7 +203,7 @@ public class PackWriter {
 	 * @param monitor
 	 *            operations progress monitor, used within
 	 *            {@link #writePack(Iterator)} or
-	 *            {@link #writePack(Collection, Collection, boolean)}.
+	 *            {@link #writePack(Collection, Collection, boolean, boolean)}.
 	 */
 	public PackWriter(final Repository repo, final OutputStream out,
 			final ProgressMonitor monitor) {
@@ -233,7 +233,8 @@ public class PackWriter {
 	 * writer will search for delta representation of object in repository and
 	 * use it if possible. Normally, only deltas with base to another object
 	 * existing in set of objects to pack will be used. Exception is however
-	 * thin-pack (see {@link #writePack(Collection, Collection, boolean)} and
+	 * thin-pack (see
+	 * {@link #writePack(Collection, Collection, boolean, boolean)} and
 	 * {@link #writePack(Iterator)}) where base object must exist on other side
 	 * machine.
 	 * <p>
@@ -442,15 +443,21 @@ public class PackWriter {
 	 *            belonging to party repository (uninteresting/boundary) as
 	 *            determined by set; this kind of pack is used only for
 	 *            transport; true - to produce thin pack, false - otherwise.
+	 * @param ignoreMissingUninteresting
+	 *            true if writer should ignore non existing uninteresting
+	 *            objects during construction set of objects to pack; false
+	 *            otherwise - non existing uninteresting objects may cause
+	 *            {@link MissingObjectException}
 	 * @throws IOException
 	 *             when some I/O problem occur during reading objects for pack
 	 *             or writing pack stream.
 	 */
 	public void writePack(final Collection<ObjectId> interestingObjects,
-			final Collection<ObjectId> uninterestingObjects, boolean thin)
+			final Collection<ObjectId> uninterestingObjects,
+			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws IOException {
 		ObjectWalk walker = setUpWalker(interestingObjects,
-				uninterestingObjects, thin);
+				uninterestingObjects, thin, ignoreMissingUninteresting);
 		findObjectsToPack(walker);
 		writePackInternal();
 	}
@@ -682,7 +689,8 @@ public class PackWriter {
 
 	private ObjectWalk setUpWalker(
 			final Collection<ObjectId> interestingObjects,
-			final Collection<ObjectId> uninterestingObjects, boolean thin)
+			final Collection<ObjectId> uninterestingObjects,
+			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
 		final ObjectWalk walker = new ObjectWalk(db);
@@ -696,7 +704,14 @@ public class PackWriter {
 			walker.markStart(o);
 		}
 		for (ObjectId id : uninterestingObjects) {
-			RevObject o = walker.parseAny(id);
+			final RevObject o;
+			try {
+				o = walker.parseAny(id);
+			} catch (MissingObjectException x) {
+				if (ignoreMissingUninteresting)
+					continue;
+				throw x;
+			}
 			walker.markUninteresting(o);
 		}
 		return walker;
-- 
1.5.5.3
