From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 19/20] Simplified implementation of pack creation: PackWriter
Date: Sun, 15 Jun 2008 23:45:48 +0200
Message-ID: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-18-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-19-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:49:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8062-00026j-GL
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYFOVsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbYFOVsF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:48:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:31273 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbYFOVsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:48:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958696ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HmZ07zvZKEAivAqFS/iqcYQrvqtHIwHD1yaaRVuOInI=;
        b=ogp8I1n1NOi0fz0pYRxZb99W4xhbIiRfL88/ZxdOvWXwiXvJQ+UZuQsBE63JMi7Ip5
         JAfrH9WS6D30Eo6R2/Dq11NIovO4MYLLD5hi3zR7iouBNL4ZUtKPIJ5gBS4BN/fwJ8vC
         iFDRq1Bnzsgo+hwuk+6aSh/UefuhESD2ufxO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uscdQ1zXdpbZ9jpApiq/QdM7MaYUszESDM3NzuBbpZSqgzghTQy37PvVI7hjNo6pKi
         AR3sau0F5k8ECY1QTxUHWrepmwvTWH5sz9P9wJnHcXOINKAMNp93HJuloMRv9f7z+Ek7
         0onj8ncUlNa+PdkQ/uL8FAeeX6CXZME1CFXSE=
Received: by 10.151.42.9 with SMTP id u9mr9411147ybj.128.1213566480171;
        Sun, 15 Jun 2008 14:48:00 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id k27sm1415512qba.10.2008.06.15.14.47.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-19-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85144>

This class is able to create a pack basing on provided objects
specification and options.

The core unimplemented feature comparing to the original
git-pack-objects is windowed delta searching algorithm (and needed
binary delta between 2 files).

This implementation can create an always correct pack, with
appropriate objects set and optimized order (as in original git).
Objects are written as whole objects or deltas to another objects (ref
or offset). Existing deltas and objects may be reused if set writer is
set up accordingly. Thin-packs and delta-depth options are also
supported.

Comparing to the original implementation, delta reuse is performed in a
slightly different way - allowing delta-chains longer than 2.
Delta-depth and delta-cycles are checked on-line when writing out
objects. These changes were introduced (possibly temporary) to give us
sensible pack creation implementation without binary delta generation
algorithm which is not yet implemented.

Mentored-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |  882 ++++++++++++++++++++
 1 files changed, 882 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
new file mode 100644
index 0000000..18d3ec2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -0,0 +1,882 @@
+/*
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
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.io.OutputStream;
+import java.security.DigestOutputStream;
+import java.security.MessageDigest;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Iterator;
+import java.util.LinkedList;
+import java.util.List;
+import java.util.zip.Deflater;
+import java.util.zip.DeflaterOutputStream;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.revwalk.ObjectWalk;
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevSort;
+import org.spearce.jgit.util.CountingOutputStream;
+import org.spearce.jgit.util.NB;
+
+/**
+ * <p>
+ * PackWriter class is responsible for generating pack files from specified set
+ * of objects from repository. This implementation produce pack files in format
+ * version 2.
+ * </p>
+ * <p>
+ * Source of objects may be specified in two ways:
+ * <ul>
+ * <li>(usually) by providing sets of interesting and uninteresting objects in
+ * repository - all interesting objects and their ancestors except uninteresting
+ * objects and their ancestors will be included in pack, or</li>
+ * <li>by providing iterator of {@link RevObject} specifying exact list and
+ * order of objects in pack</li>
+ * </ul>
+ * Typical usage consists of creating instance intended for some pack,
+ * configuring options through accessors methods and finally call
+ * {@link #writePack(Iterator)} or
+ * {@link #writePack(Collection, Collection, boolean)} with objects
+ * specification, to generate a pack stream.
+ * </p>
+ * <p>
+ * Class provide set of configurable options and {@link ProgressMonitor}
+ * support, as operations may take a long time for big repositories. Deltas
+ * searching algorithm is <b>NOT IMPLEMENTED</b> yet - this implementation
+ * relies only on deltas and objects reuse.
+ * </p>
+ * <p>
+ * This class is not thread safe, it is intended to be used in one thread, with
+ * one instance per created pack. Subsequent calls to writePack result in
+ * undefined behavior.
+ * </p>
+ */
+
+public class PackWriter {
+	/**
+	 * Title of {@link ProgressMonitor} task used during counting objects to
+	 * pack.
+	 * 
+	 * @see #writePack(Collection, Collection, boolean)
+	 */
+	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects to pack";
+
+	/**
+	 * Title of {@link ProgressMonitor} task used during searching for objects
+	 * reuse or delta reuse.
+	 * 
+	 * @see #writePack(Iterator)
+	 * @see #writePack(Collection, Collection, boolean)
+	 */
+	public static final String SEARCHING_REUSE_PROGRESS = "Searching for delta and object reuse";
+
+	/**
+	 * Title of {@link ProgressMonitor} task used during writing out pack
+	 * (objects)
+	 * 
+	 * @see #writePack(Iterator)
+	 * @see #writePack(Collection, Collection, boolean)
+	 */
+	public static final String WRITING_OBJECTS_PROGRESS = "Writing objects";
+
+	/**
+	 * Default value of deltas reuse option.
+	 * 
+	 * @see #setReuseDeltas(boolean)
+	 */
+	public static final boolean DEFAULT_REUSE_DELTAS = true;
+
+	/**
+	 * Default value of objects reuse option.
+	 * 
+	 * @see #setReuseObjects(boolean)
+	 */
+	public static final boolean DEFAULT_REUSE_OBJECTS = true;
+
+	/**
+	 * Default value of delta base as offset option.
+	 * 
+	 * @see #setDeltaBaseAsOffset(boolean)
+	 */
+	public static final boolean DEFAULT_DELTA_BASE_AS_OFFSET = false;
+
+	/**
+	 * Default value of maximum delta chain depth.
+	 * 
+	 * @see #setMaxDeltaDepth(int)
+	 */
+	public static final int DEFAULT_MAX_DELTA_DEPTH = 50;
+
+	private static final int PACK_VERSION_GENERATED = 2;
+
+	@SuppressWarnings("unchecked")
+	private final List<ObjectToPack> objectsLists[] = new List[Constants.OBJ_TAG + 1];
+	{
+		objectsLists[0] = Collections.<ObjectToPack> emptyList();
+		objectsLists[Constants.OBJ_COMMIT] = new ArrayList<ObjectToPack>();
+		objectsLists[Constants.OBJ_TREE] = new ArrayList<ObjectToPack>();
+		objectsLists[Constants.OBJ_BLOB] = new ArrayList<ObjectToPack>();
+		objectsLists[Constants.OBJ_TAG] = new ArrayList<ObjectToPack>();
+	}
+
+	private final ObjectIdSubclassMap<ObjectToPack> objectsMap = new ObjectIdSubclassMap<ObjectToPack>();
+
+	// edge objects for thin packs
+	private final ObjectIdSubclassMap<ObjectId> edgeObjects = new ObjectIdSubclassMap<ObjectId>();
+
+	private final Repository db;
+
+	private final DigestOutputStream out;
+
+	private final CountingOutputStream countingOut;
+
+	private final Deflater deflater;
+
+	private final ProgressMonitor monitor;
+
+	private final byte[] buf = new byte[16384]; // 16 KB
+
+	private final WindowCursor windowCursor = new WindowCursor();
+
+	private boolean reuseDeltas = DEFAULT_REUSE_DELTAS;
+
+	private boolean reuseObjects = DEFAULT_REUSE_OBJECTS;
+
+	private boolean deltaBaseAsOffset = DEFAULT_DELTA_BASE_AS_OFFSET;
+
+	private int maxDeltaDepth = DEFAULT_MAX_DELTA_DEPTH;
+
+	private boolean thin;
+
+	/**
+	 * Create writer for specified repository, that will write a pack to
+	 * provided output stream. Objects for packing are specified in
+	 * {@link #writePack(Iterator)} or
+	 * {@link #writePack(Collection, Collection, boolean)}.
+	 * 
+	 * @param repo
+	 *            repository where objects are stored.
+	 * @param out
+	 *            output stream of pack data; no buffering is guaranteed by
+	 *            writer.
+	 * @param monitor
+	 *            operations progress monitor, used within
+	 *            {@link #writePack(Iterator)} or
+	 *            {@link #writePack(Collection, Collection, boolean)}.
+	 */
+	public PackWriter(final Repository repo, final OutputStream out,
+			final ProgressMonitor monitor) {
+		this.db = repo;
+		this.monitor = monitor;
+		this.countingOut = new CountingOutputStream(out);
+		this.out = new DigestOutputStream(countingOut, Constants
+				.newMessageDigest());
+		this.deflater = new Deflater(db.getConfig().getCore().getCompression());
+	}
+
+	/**
+	 * Check whether object is configured to reuse deltas existing in
+	 * repository.
+	 * <p>
+	 * Default setting: {@value #DEFAULT_REUSE_DELTAS}
+	 * </p>
+	 * 
+	 * @return true if object is configured to reuse deltas; false otherwise.
+	 */
+	public boolean isReuseDeltas() {
+		return reuseDeltas;
+	}
+
+	/**
+	 * Set reuse deltas configuration option for this writer. When enabled,
+	 * writer will search for delta representation of object in repository and
+	 * use it if possible. Normally, only deltas with base to another object
+	 * existing in set of objects to pack will be used. Exception is however
+	 * thin-pack (see {@link #writePack(Collection, Collection, boolean)} and
+	 * {@link #writePack(Iterator)}) where base object must exist on other side
+	 * machine.
+	 * <p>
+	 * When raw delta data is directly copied from a pack file, checksum is
+	 * computed to verify data.
+	 * </p>
+	 * <p>
+	 * Default setting: {@value #DEFAULT_REUSE_DELTAS}
+	 * </p>
+	 * 
+	 * @param reuseDeltas
+	 *            boolean indicating whether or not try to reuse deltas.
+	 */
+	public void setReuseDeltas(boolean reuseDeltas) {
+		this.reuseDeltas = reuseDeltas;
+	}
+
+	/**
+	 * Checks whether object is configured to reuse existing objects
+	 * representation in repository.
+	 * <p>
+	 * Default setting: {@value #DEFAULT_REUSE_OBJECTS}
+	 * </p>
+	 * 
+	 * @return true if writer is configured to reuse objects representation from
+	 *         pack; false otherwise.
+	 */
+	public boolean isReuseObjects() {
+		return reuseObjects;
+	}
+
+	/**
+	 * Set reuse objects configuration option for this writer. If enabled,
+	 * writer searches for representation in a pack file. If possible,
+	 * compressed data is directly copied from such a pack file. Data checksum
+	 * is verified.
+	 * <p>
+	 * Default setting: {@value #DEFAULT_REUSE_OBJECTS}
+	 * </p>
+	 * 
+	 * @param reuseObjects
+	 *            boolean indicating whether or not writer should reuse existing
+	 *            objects representation.
+	 */
+	public void setReuseObjects(boolean reuseObjects) {
+		this.reuseObjects = reuseObjects;
+	}
+
+	/**
+	 * Check whether writer can store delta base as an offset (new style
+	 * reducing pack size) or should store it as an object id (legacy style,
+	 * compatible with old readers).
+	 * <p>
+	 * Default setting: {@value #DEFAULT_DELTA_BASE_AS_OFFSET}
+	 * </p>
+	 * 
+	 * @return true if delta base is stored as an offset; false if it is stored
+	 *         as an object id.
+	 */
+	public boolean isDeltaBaseAsOffset() {
+		return deltaBaseAsOffset;
+	}
+
+	/**
+	 * Set writer delta base format. Delta base can be written as an offset in a
+	 * pack file (new approach reducing file size) or as an object id (legacy
+	 * approach, compatible with old readers).
+	 * <p>
+	 * Default setting: {@value #DEFAULT_DELTA_BASE_AS_OFFSET}
+	 * </p>
+	 * 
+	 * @param deltaBaseAsOffset
+	 *            boolean indicating whether delta base can be stored as an
+	 *            offset.
+	 */
+	public void setDeltaBaseAsOffset(boolean deltaBaseAsOffset) {
+		this.deltaBaseAsOffset = deltaBaseAsOffset;
+	}
+
+	/**
+	 * Get maximum depth of delta chain set up for this writer. Generated chains
+	 * are not longer than this value.
+	 * <p>
+	 * Default setting: {@value #DEFAULT_MAX_DELTA_DEPTH}
+	 * </p>
+	 * 
+	 * @return maximum delta chain depth.
+	 */
+	public int getMaxDeltaDepth() {
+		return maxDeltaDepth;
+	}
+
+	/**
+	 * Set up maximum depth of delta chain for this writer. Generated chains are
+	 * not longer than this value. Too low value causes low compression level,
+	 * while too big makes unpacking (reading) longer.
+	 * <p>
+	 * Default setting: {@value #DEFAULT_MAX_DELTA_DEPTH}
+	 * </p>
+	 * 
+	 * @param maxDeltaDepth
+	 *            maximum delta chain depth.
+	 */
+	public void setMaxDeltaDepth(int maxDeltaDepth) {
+		this.maxDeltaDepth = maxDeltaDepth;
+	}
+
+	/**
+	 * Returns objects number in a pack file that was created by this writer.
+	 * 
+	 * @return number of objects in pack.
+	 */
+	public int getObjectsNumber() {
+		return objectsMap.size();
+	}
+
+	/**
+	 * Write pack to output stream according to current writer configuration for
+	 * provided source iterator of objects.
+	 * <p>
+	 * Iterator <b>exactly</b> determines which objects are included in a pack
+	 * and order they appear in pack (except that objects order by type is not
+	 * needed at input). This order should conform general rules of ordering
+	 * objects in git - by recency and path (type and delta-base first is
+	 * internally secured) and responsibility for guaranteeing this order is on
+	 * a caller side. Iterator must return each id of object to write exactly
+	 * once.
+	 * </p>
+	 * <p>
+	 * When iterator returns object that has {@link RevFlag#UNINTERESTING} flag,
+	 * this object won't be included in an output pack. Instead, it is recorded
+	 * as edge-object (known to remote repository) for thin-pack. In such a case
+	 * writer may pack objects with delta base object not within set of objects
+	 * to pack, but belonging to party repository - those marked with
+	 * {@link RevFlag#UNINTERESTING} flag. This type of pack is used only for
+	 * transport.
+	 * </p>
+	 * <p>
+	 * At first, this method collects and sorts objects to pack, then deltas
+	 * search is performed if set up accordingly, finally pack stream is
+	 * written. {@link ProgressMonitor} tasks {@value #SEARCHING_REUSE_PROGRESS}
+	 * (only if resueDeltas or reuseObjects is enabled) and
+	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
+	 * </p>
+	 * <p>
+	 * All reused objects data checksum (Adler32/CRC32) is computed and
+	 * validated against existing checksum.
+	 * </p>
+	 * 
+	 * @param objectsSource
+	 *            iterator of object to store in a pack; order of objects within
+	 *            each type is important, ordering by type is not needed;
+	 *            allowed types for objects are {@link Constants#OBJ_COMMIT},
+	 *            {@link Constants#OBJ_TREE}, {@link Constants#OBJ_BLOB} and
+	 *            {@link Constants#OBJ_TAG}; objects returned by iterator may
+	 *            be later reused by caller as object id and type are internally
+	 *            copied in each iteration; if object returned by iterator has
+	 *            {@link RevFlag#UNINTERESTING} flag set, it won't be included
+	 *            in a pack, but is considered as edge-object for thin-pack.
+	 * @throws IOException
+	 *             when some I/O problem occur during reading objects for pack
+	 *             or writing pack stream.
+	 */
+	public void writePack(final Iterator<RevObject> objectsSource)
+			throws IOException {
+		while (objectsSource.hasNext()) {
+			addObject(objectsSource.next());
+		}
+		writePackInternal();
+	}
+
+	/**
+	 * Write pack to output stream according to current writer configuration for
+	 * provided sets of interesting and uninteresting objects.
+	 * <p>
+	 * Basing on these 2 sets, another set of objects to put in a pack file is
+	 * created: this set consists of all objects reachable (ancestors) from
+	 * interesting objects, except uninteresting objects and their ancestors.
+	 * This method uses class {@link ObjectWalk} extensively to find out that
+	 * appropriate set of output objects and their optimal order in output pack.
+	 * Order is consistent with general git in-pack rules: sort by object type,
+	 * recency, path and delta-base first.
+	 * </p>
+	 * <p>
+	 * At first, this method collects and sorts objects to pack, then deltas
+	 * search is performed if set up accordingly, finally pack stream is
+	 * written. {@link ProgressMonitor} tasks
+	 * {@value #COUNTING_OBJECTS_PROGRESS}, {@value #SEARCHING_REUSE_PROGRESS}
+	 * (only if resueDeltas or reuseObjects is enabled) and
+	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
+	 * </p>
+	 * <p>
+	 * All reused objects data checksum (Adler32/CRC32) is computed and
+	 * validated against existing checksum.
+	 * </p>
+	 * 
+	 * @param interestingObjects
+	 *            collection of objects to be marked as interesting (start
+	 *            points of graph traversal).
+	 * @param uninterestingObjects
+	 *            collection of objects to be marked as uninteresting (end
+	 *            points of graph traversal).
+	 * @param thin
+	 *            a boolean indicating whether writer may pack objects with
+	 *            delta base object not within set of objects to pack, but
+	 *            belonging to party repository (uninteresting/boundary) as
+	 *            determined by set; this kind of pack is used only for
+	 *            transport; true - to produce thin pack, false - otherwise.
+	 * @throws IOException
+	 *             when some I/O problem occur during reading objects for pack
+	 *             or writing pack stream.
+	 */
+	public void writePack(final Collection<ObjectId> interestingObjects,
+			final Collection<ObjectId> uninterestingObjects, boolean thin)
+			throws IOException {
+		ObjectWalk walker = setUpWalker(interestingObjects,
+				uninterestingObjects, thin);
+		findObjectsToPack(walker);
+		writePackInternal();
+	}
+
+	/**
+	 * Computes SHA-1 of lexicographically sorted objects ids written in this
+	 * pack, as used to name a pack file in repository.
+	 * 
+	 * @return ObjectId representing SHA-1 name of a pack that was created.
+	 */
+	public ObjectId computeName() {
+		final ArrayList<ObjectToPack> sorted = new ArrayList<ObjectToPack>(
+				objectsMap.size());
+		for (List<ObjectToPack> list : objectsLists) {
+			for (ObjectToPack otp : list)
+				sorted.add(otp);
+		}
+
+		final MessageDigest md = Constants.newMessageDigest();
+		Collections.sort(sorted);
+		for (ObjectToPack otp : sorted) {
+			otp.copyRawTo(buf, 0);
+			md.update(buf, 0, Constants.OBJECT_ID_LENGTH);
+		}
+		return ObjectId.fromRaw(md.digest());
+	}
+
+	private void writePackInternal() throws IOException {
+		if (reuseDeltas || reuseObjects)
+			searchForReuse();
+
+		monitor.beginTask(WRITING_OBJECTS_PROGRESS, getObjectsNumber());
+		writeHeader();
+		writeObjects();
+		writeChecksum();
+
+		out.flush();
+		windowCursor.release();
+		monitor.endTask();
+	}
+
+	private void searchForReuse() throws IOException {
+		monitor.beginTask(SEARCHING_REUSE_PROGRESS, getObjectsNumber());
+		final Collection<PackedObjectLoader> reuseLoaders = new LinkedList<PackedObjectLoader>();
+
+		for (List<ObjectToPack> list : objectsLists) {
+			for (ObjectToPack otp : list) {
+				if (monitor.isCancelled())
+					throw new IOException(
+							"Packing cancelled during objects writing");
+				reuseLoaders.clear();
+				db.openObjectInAllPacks(otp, reuseLoaders, windowCursor);
+				if (reuseDeltas) {
+					selectDeltaReuseForObject(otp, reuseLoaders);
+				}
+				// delta reuse is preferred over object reuse
+				if (reuseObjects && !otp.hasReuseLoader()) {
+					selectObjectReuseForObject(otp, reuseLoaders);
+				}
+				monitor.update(1);
+			}
+		}
+
+		monitor.endTask();
+	}
+
+	private void selectDeltaReuseForObject(final ObjectToPack otp,
+			final Collection<PackedObjectLoader> loaders) throws IOException {
+		PackedObjectLoader bestLoader = null;
+		ObjectId bestBase = null;
+
+		for (PackedObjectLoader loader : loaders) {
+			ObjectId idBase = loader.getDeltaBase();
+			if (idBase == null)
+				continue;
+			ObjectToPack otpBase = objectsMap.get(idBase);
+
+			// only if base is in set of objects to write or thin-pack's edge
+			if ((otpBase != null || (thin && edgeObjects.get(idBase) != null))
+			// select smallest possible delta if > 1 available
+					&& isBetterDeltaReuseLoader(bestLoader, loader)) {
+				bestLoader = loader;
+				bestBase = (otpBase != null ? otpBase : idBase);
+			}
+		}
+
+		if (bestLoader != null) {
+			otp.setReuseLoader(bestLoader);
+			otp.setDeltaBase(bestBase);
+		}
+	}
+
+	private boolean isBetterDeltaReuseLoader(PackedObjectLoader currentLoader,
+			PackedObjectLoader loader) throws IOException {
+		if (currentLoader == null)
+			return true;
+		if (loader.getRawSize() < currentLoader.getRawSize())
+			return true;
+		return (loader.getRawSize() == currentLoader.getRawSize()
+				&& loader.supportsFastCopyRawData() && !currentLoader
+				.supportsFastCopyRawData());
+	}
+
+	private void selectObjectReuseForObject(final ObjectToPack otp,
+			final Collection<PackedObjectLoader> loaders) {
+		for (final PackedObjectLoader loader : loaders) {
+			if (loader instanceof WholePackedObjectLoader) {
+				otp.setReuseLoader(loader);
+				return;
+			}
+		}
+	}
+
+	private void writeHeader() throws IOException {
+		out.write(Constants.PACK_SIGNATURE);
+
+		NB.encodeInt32(buf, 0, PACK_VERSION_GENERATED);
+		out.write(buf, 0, 4);
+
+		NB.encodeInt32(buf, 0, getObjectsNumber());
+		out.write(buf, 0, 4);
+	}
+
+	private void writeObjects() throws IOException {
+		for (List<ObjectToPack> list : objectsLists) {
+			for (ObjectToPack otp : list) {
+				if (monitor.isCancelled())
+					throw new IOException(
+							"Packing cancelled during objects writing");
+				if (!otp.isWritten())
+					writeObject(otp);
+			}
+		}
+	}
+
+	private void writeObject(final ObjectToPack otp) throws IOException {
+		otp.markWantWrite();
+		if (otp.isDeltaRepresentation()) {
+			ObjectToPack deltaBase = otp.getDeltaBase();
+			assert deltaBase != null || thin;
+			if (deltaBase != null && !deltaBase.isWritten()) {
+				if (deltaBase.wantWrite()) {
+					otp.clearDeltaBase(); // cycle detected
+					otp.disposeLoader();
+				} else {
+					writeObject(deltaBase);
+				}
+			}
+
+			otp.updateDeltaDepth();
+			if (otp.getDeltaDepth() > maxDeltaDepth) {
+				otp.clearDeltaBase();
+				otp.disposeLoader();
+			}
+		}
+
+		assert !otp.isWritten();
+
+		otp.markWritten(countingOut.getCount());
+		if (otp.isDeltaRepresentation())
+			writeDeltaObject(otp);
+		else
+			writeWholeObject(otp);
+
+		monitor.update(1);
+	}
+
+	private void writeWholeObject(final ObjectToPack otp) throws IOException {
+		if (otp.hasReuseLoader()) {
+			final PackedObjectLoader loader = otp.getReuseLoader();
+			writeObjectHeader(loader.getType(), loader.getSize());
+			loader.copyRawData(out, buf);
+			otp.disposeLoader();
+		} else {
+			final ObjectLoader loader = db.openObject(windowCursor, otp);
+			final DeflaterOutputStream deflaterOut = new DeflaterOutputStream(
+					out, deflater);
+			writeObjectHeader(loader.getType(), loader.getSize());
+			deflaterOut.write(loader.getCachedBytes());
+			deflaterOut.finish();
+			deflater.reset();
+		}
+	}
+
+	private void writeDeltaObject(final ObjectToPack otp) throws IOException {
+		final PackedObjectLoader loader = otp.getReuseLoader();
+		if (deltaBaseAsOffset && otp.getDeltaBase() != null) {
+			writeObjectHeader(Constants.OBJ_OFS_DELTA, loader.getRawSize());
+
+			final ObjectToPack deltaBase = otp.getDeltaBase();
+			long offsetDiff = otp.getOffset() - deltaBase.getOffset();
+			int pos = buf.length - 1;
+			buf[pos] = (byte) (offsetDiff & 0x7F);
+			while ((offsetDiff >>= 7) > 0) {
+				buf[--pos] = (byte) (0x80 | (--offsetDiff & 0x7F));
+			}
+
+			out.write(buf, pos, buf.length - pos);
+		} else {
+			writeObjectHeader(Constants.OBJ_REF_DELTA, loader.getRawSize());
+			otp.getDeltaBaseId().copyRawTo(buf, 0);
+			out.write(buf, 0, Constants.OBJECT_ID_LENGTH);
+		}
+		loader.copyRawData(out, buf);
+		otp.disposeLoader();
+	}
+
+	private void writeObjectHeader(final int objectType, long dataLength)
+			throws IOException {
+		long nextLength = dataLength >>> 4;
+		int size = 0;
+		buf[size++] = (byte) ((nextLength > 0 ? 0x80 : 0x00)
+				| (objectType << 4) | (dataLength & 0x0F));
+		dataLength = nextLength;
+		while (dataLength > 0) {
+			nextLength >>>= 7;
+			buf[size++] = (byte) ((nextLength > 0 ? 0x80 : 0x00) | (dataLength & 0x7F));
+			dataLength = nextLength;
+		}
+		out.write(buf, 0, size);
+	}
+
+	private void writeChecksum() throws IOException {
+		out.on(false);
+		final byte checksum[] = out.getMessageDigest().digest();
+		out.write(checksum);
+	}
+
+	private ObjectWalk setUpWalker(
+			final Collection<ObjectId> interestingObjects,
+			final Collection<ObjectId> uninterestingObjects, boolean thin)
+			throws MissingObjectException, IOException,
+			IncorrectObjectTypeException {
+		final ObjectWalk walker = new ObjectWalk(db);
+		walker.sort(RevSort.TOPO, true);
+		walker.sort(RevSort.COMMIT_TIME_DESC, true);
+		if (thin)
+			walker.sort(RevSort.BOUNDARY);
+
+		for (ObjectId id : interestingObjects) {
+			RevObject o = walker.parseAny(id);
+			walker.markStart(o);
+		}
+		for (ObjectId id : uninterestingObjects) {
+			RevObject o = walker.parseAny(id);
+			walker.markUninteresting(o);
+		}
+		return walker;
+	}
+
+	private void findObjectsToPack(final ObjectWalk walker)
+			throws MissingObjectException, IncorrectObjectTypeException,
+			IOException {
+		monitor.beginTask(COUNTING_OBJECTS_PROGRESS, ProgressMonitor.UNKNOWN);
+		RevObject o;
+
+		while ((o = walker.next()) != null) {
+			addObject(o);
+			monitor.update(1);
+		}
+		while ((o = walker.nextObject()) != null) {
+			addObject(o);
+			monitor.update(1);
+		}
+		monitor.endTask();
+	}
+
+	private void addObject(RevObject object)
+			throws IncorrectObjectTypeException {
+		if (object.has(RevFlag.UNINTERESTING)) {
+			edgeObjects.add(object);
+			thin = true;
+			return;
+		}
+
+		final ObjectToPack otp = new ObjectToPack(object);
+		try {
+			objectsLists[object.getType()].add(otp);
+		} catch (ArrayIndexOutOfBoundsException x) {
+			throw new IncorrectObjectTypeException(object,
+					"COMMIT nor TREE nor BLOB nor TAG");
+		} catch (UnsupportedOperationException x) {
+			// index pointing to "dummy" empty list
+			throw new IncorrectObjectTypeException(object,
+					"COMMIT nor TREE nor BLOB nor TAG");
+		}
+		objectsMap.add(otp);
+	}
+
+	/**
+	 * Class holding information about object that is going to be packed by
+	 * {@link PackWriter}. Information include object representation in a
+	 * pack-file and object status.
+	 * 
+	 */
+	static class ObjectToPack extends ObjectId {
+		private ObjectId deltaBase;
+
+		private PackedObjectLoader reuseLoader;
+
+		private long offset = -1;
+
+		private int deltaDepth;
+
+		private boolean wantWrite;
+
+		/**
+		 * Construct object for specified object id. <br/> By default object is
+		 * marked as not written and non-delta packed (as a whole object).
+		 * 
+		 * @param src
+		 *            object id of object for packing
+		 */
+		ObjectToPack(AnyObjectId src) {
+			super(src);
+		}
+
+		/**
+		 * @return delta base object id if object is going to be packed in delta
+		 *         representation; null otherwise - if going to be packed as a
+		 *         whole object.
+		 */
+		ObjectId getDeltaBaseId() {
+			return deltaBase;
+		}
+
+		/**
+		 * @return delta base object to pack if object is going to be packed in
+		 *         delta representation and delta is specified as object to
+		 *         pack; null otherwise - if going to be packed as a whole
+		 *         object or delta base is specified only as id.
+		 */
+		ObjectToPack getDeltaBase() {
+			if (deltaBase instanceof ObjectToPack)
+				return (ObjectToPack) deltaBase;
+			return null;
+		}
+
+		/**
+		 * Set delta base for the object. Delta base set by this method is used
+		 * by {@link PackWriter} to write object - determines its representation
+		 * in a created pack.
+		 * 
+		 * @param deltaBase
+		 *            delta base object or null if object should be packed as a
+		 *            whole object.
+		 * 
+		 */
+		void setDeltaBase(ObjectId deltaBase) {
+			this.deltaBase = deltaBase;
+		}
+
+		void clearDeltaBase() {
+			this.deltaBase = null;
+		}
+
+		/**
+		 * @return true if object is going to be written as delta; false
+		 *         otherwise.
+		 */
+		boolean isDeltaRepresentation() {
+			return deltaBase != null;
+		}
+
+		/**
+		 * Check if object is already written in a pack. This information is
+		 * used to achieve delta-base precedence in a pack file.
+		 * 
+		 * @return true if object is already written; false otherwise.
+		 */
+		boolean isWritten() {
+			return offset != -1;
+		}
+
+		/**
+		 * @return offset in pack when object has been already written, or -1 if
+		 *         it has not been written yet
+		 */
+		long getOffset() {
+			return offset;
+		}
+
+		/**
+		 * Mark object as written. This information is used to achieve
+		 * delta-base precedence in a pack file.
+		 * 
+		 * @param offset
+		 *            offset where written object starts
+		 */
+		void markWritten(long offset) {
+			this.offset = offset;
+		}
+
+		PackedObjectLoader getReuseLoader() {
+			return reuseLoader;
+		}
+
+		boolean hasReuseLoader() {
+			return reuseLoader != null;
+		}
+
+		void setReuseLoader(PackedObjectLoader reuseLoader) {
+			this.reuseLoader = reuseLoader;
+		}
+
+		void disposeLoader() {
+			this.reuseLoader = null;
+		}
+
+		int getDeltaDepth() {
+			return deltaDepth;
+		}
+
+		void updateDeltaDepth() {
+			if (deltaBase instanceof ObjectToPack)
+				deltaDepth = ((ObjectToPack) deltaBase).deltaDepth + 1;
+			else if (deltaBase != null)
+				deltaDepth = 1;
+		}
+
+		boolean wantWrite() {
+			return wantWrite;
+		}
+
+		void markWantWrite() {
+			this.wantWrite = true;
+		}
+	}
+}
-- 
1.5.5.1
