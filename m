From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/11] Add tests to increase coverage of WindowCache
Date: Wed, 29 Apr 2009 11:54:48 -0700
Message-ID: <1241031288-23437-12-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
 <1241031288-23437-5-git-send-email-spearce@spearce.org>
 <1241031288-23437-6-git-send-email-spearce@spearce.org>
 <1241031288-23437-7-git-send-email-spearce@spearce.org>
 <1241031288-23437-8-git-send-email-spearce@spearce.org>
 <1241031288-23437-9-git-send-email-spearce@spearce.org>
 <1241031288-23437-10-git-send-email-spearce@spearce.org>
 <1241031288-23437-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwx-0003Rz-Rv
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387AbZD2SzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757306AbZD2SzW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:55:22 -0400
Received: from george.spearce.org ([209.20.77.23]:32901 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbZD2Sy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9B74038069; Wed, 29 Apr 2009 18:54:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0D4C038069;
	Wed, 29 Apr 2009 18:54:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117922>

These tests run the WindowCache in different configurations with known
inputs, forcing it through different code paths as the cache populates
with entries, and potentially overflows.

The list of objects was derived from `git verify-pack -v`, run over all
of the pack files we install by default into a RepositoryTestCase.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 New test, to get better coverage.

 .../jgit/test/resources/all_packed_objects.txt     |   96 +++++++++++++
 .../org/spearce/jgit/lib/WindowCacheGetTest.java   |  143 ++++++++++++++++++++
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    7 +
 .../src/org/spearce/jgit/lib/WindowCache.java      |   12 ++
 4 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/all_packed_objects.txt
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheGetTest.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/all_packed_objects.txt b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/all_packed_objects.txt
new file mode 100644
index 0000000..a97f662
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/all_packed_objects.txt
@@ -0,0 +1,96 @@
+4b825dc642cb6eb9a060e54bf8d69288fbee4904 tree   0 9 7782
+540a36d136cf413e4b064c2b0e0a4db60f77feab commit 191 131 339
+5b6e7c66c276e7610d4a73c70ec1a1f7c1003259 blob   11 40 516 1 6ff87c4664981e4397625791c8ea3bbb5f2279a3
+6ff87c4664981e4397625791c8ea3bbb5f2279a3 blob   18787 7180 556
+82c6b885ff600be425b4ea96dee75dca255b69e7 commit 245 166 12
+902d5476fa249b7abc9d84c611577a81381f0327 tree   35 46 7736
+aabf2ffaec9b497f0950352b3e582d73035c2035 tree   35 46 470
+c59759f143fb1fe21c197981df75a7ee00290799 commit 240 161 178
+02ba32d3649e510002c21651936b7077aa75ffa9 tree   122 127 3806
+0966a434eb1a025db6b71485ab63a3bfbea520b6 commit 287 197 2611
+09efc7e59a839528ac7bda9fa020dc9101278680 tree   68 71 5497
+0a3d7772488b6b106fb62813c4d6d627918d9181 tree   98 95 3367
+1004d0d7ac26fbf63050a234c9b88a46075719d3 tree   68 72 3504
+10da5895682013006950e7da534b705252b03be6 blob   6 15 3591
+1203b03dc816ccbb67773f28b3c19318654b0bc8 commit 222 152 758
+15fae9e651043de0fd1deef588aa3fbf5a7a41c6 blob   6 15 3474
+16f9ec009e5568c435f473ba3a1df732d49ce8c3 blob   3 12 4196
+1fd7d579fb6ae3fe942dc09c2c783443d04cf21e blob   6 15 3678
+20a8ade77639491ea0bd667bf95de8abf3a434c8 tree   66 77 5663
+2675188fd86978d5bc4d7211698b2118ae3bf658 tree   68 72 4124
+2c349335b7f797072cf729c4f3bb0914ecb6dec9 commit 221 154 2457
+2cc3f4155a8eda5c3f1bc85de0988c0155c8cc1c tree   68 72 4717
+30a7b072d441dbfcfe0266b1c5fce94c22c447da tree   38 48 5784
+42e4e7c5e507e113ebbb7801b16b52cf867b7ce1 commit 184 133 1407
+49322bb17d3acc9146f98c97d078513228bbf3c0 commit 338 223 12
+49c5f851406e8004b816b8170f6f18e30ee877b9 tree   68 72 3606
+55a1a760df4b86a02094a904dfa511deb5655905 blob   6 15 3693
+58be4659bb571194ed4562d04b359d26216f526e commit 226 156 2962
+59706a11bde2b9899a278838ef20a97e8f8795d2 commit 222 153 1692
+5f25aaf573e7a094697987a927b833e088134674 tree   66 76 5184
+6020a3b8d5d636e549ccbd0c53e2764684bb3125 tree   122 126 3241
+62b15c9ddac853efbb00f59123f484b05b06d8b3 tree   28 37 4431
+6462e7d8024396b14d7651e2ec11e2bbf07a05c4 commit 221 153 1254
+6c83a9d0a09ce6d12292314ed3d9e1f60e39feb0 tree   66 76 5587
+6c8b137b1c652731597c89668f417b8695f28dd7 commit 172 123 3118
+6db9c2ebf75590eef973081736730a9ea169a0c4 commit 222 152 2153
+6e1475206e57110fcef4b92320436c1e9872a322 commit 282 192 566
+7f822839a2fe9760f386cbbbcb3f92c5fe81def7 commit 222 152 1540
+81e462df7c747d5b8783af18bf83bffbef8dc2bc tree   34 45 5139
+8230f48330e0055d9e0bc5a2a77718f6dd9324b8 blob   10 19 5568
+82b1d08466e9505f8666b778744f9a3471a70c81 blob   20 22 3708
+82fb2e7873759b74c41020a00abaea9c378a7a15 tree   66 76 4801
+835da11381dee94c71a04164cdaa533d0673e4e5 tree   34 45 4468
+83834a7afdaa1a1260568567f6ad90020389f664 commit 282 192 1062
+83d2f0431bcdc9c2fd2c17b828143be6ee4fbe80 commit 221 155 1998
+856ec208ae6cadac25a6d74f19b12bb27a24fe24 tree   66 76 5260
+86265c33b19b2be71bdd7b8cb95823f2743d03a8 tree   94 102 4208
+86cec6b57d80fda40300fb0d667965a5c3c3572f blob   6 15 3576
+8d6a2f2af0b2b96f320dd62fb6d9916fd2497dd9 tree   66 77 5420
+8f50ba15d49353813cc6e20298002c0d17b0a9ee tree   94 102 4961
+9188910f5d18434c2c8a3d78e8bef1a469c5626e tree   68 72 3933
+965361132e2f15897c9fd6c727beb5753057c38a blob   6 15 3489
+968a4b6caa8b55a68098e0495fbd9e75a7d05efa tree   68 72 4310
+a288d2cc3ee7d82f482e70ae7b6fedb4a039dd09 tree   28 37 4394
+a33a091b7c8de98b3a2ad2f21f88ea86f395d787 tree   94 102 4615
+a4e0e50de469ac6e2fdf2ee81808f253d5b78fd3 tree   68 72 5336
+ac7e7e44c1885efb472ad54a78327d66bfc4ecef commit 221 154 2808
+acd0220f06f7e4db50ea5ba242f0dfed297b27af tree   94 102 4513
+ae9304576a6ec3419b231b2b9c8e33a06f97f9fb blob   3 12 4382
+b9877f83f4c2ba0c3dd8fb2f6b5f04a0aaf18594 tree   66 76 5063
+bab66b48f836ed950c99134ef666436fb07a09a0 commit 222 152 910
+be9b45333b66013bde1c7314efc50fabd9b39c6d tree   7 18 4005 1 02ba32d3649e510002c21651936b7077aa75ffa9
+c070ad8c08840c8116da865b2d65593a6bb9cd2a commit 282 192 235
+c17b9ee9d0501fecadfac3b60ca485b14f5dbe98 tree   38 49 5832
+c1827f07e114c20547dc6a7296588870a4b5b62c blob   3 12 5408
+c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 blob   3 12 4949
+cd4bcfc27da62c6b840de700be1c60a7e69952a5 tree   66 76 3730
+d0114ab8ac326bab30e3a657a0397578c5a1af88 commit 84 95 427 1 c070ad8c08840c8116da865b2d65593a6bb9cd2a
+d31f5a60d406e831d056b8ac2538d515100c2df2 commit 221 153 1845
+d4b9b11fc8006af3b05cf2b4611077ed6a9b8c07 tree   68 72 4877
+d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 commit 222 152 2305
+da0f8ed91a8f2f0f067b3bdf26265d5ca48cf82c blob   3 12 3462
+e4ff0b72cb0994dbf7a9da260aeb461c9d882bb5 tree   34 44 5740
+e6bfff5c1d0f0ecd501552b43a1e13d8008abc31 blob   3 12 4789
+f2aacb9368806d6502a03aa9da0834d4b50b9f0e tree   94 101 4023
+f73b95671f326616d66b2afb3bdfcdbbce110b44 commit 33 44 522 2 d0114ab8ac326bab30e3a657a0397578c5a1af88
+17768080a2318cd89bba4c8b87834401e2095703 tag    140 132 12
+032c063ce34486359e3ee3d4f9e5c225b9e1a4c2 tag    152 138 12
+1170b77a48d3ea2d58b043648b1ec63d606e3efa tag    150 138 971
+214cae792433672d28b3aeb9f75c1ae84fd54628 tag    150 136 1109
+8dfd42699e7b10e568fa1eaebe249e33e98da81e tag    150 138 833
+a773cd2d9dbca00d08793dac0d7002a49f0428c0 tag    150 138 422
+bf5123bb77c7b5a379f7de9c1293558e3e24dfb8 tag    150 135 287
+d54e006ebbef94b7d3a5cd56d154f1e6f08efb94 tag    150 137 560
+dd144af286452bfd6a1ea02b0d3745bcdb555e9d tag    150 137 150
+efee904c794b943a06931c76c576dd552212e8bc tag    150 136 697
+8bbde7aacf771a9afb6992434f1ae413e010c6d8 tag    630 436 1187
+fd608fbe625a2b456d9f15c2b1dc41f252057dd7 blob   1512 1175 12
+06b8692d5c4f29a6bc4987e1bec04e9bb2ec54a2 tree   29 40 330
+164bf8c9e69a5c192acd28e95aefd9a5d6f254df blob   7 16 370
+175d5b80bd9768884d8fced02e9bd33488174396 commit 56 68 160 1 47d3697c3747e8184e0dc479ccbd01e359023577
+3d2770618bb1132e59c314dea328b83ac7c83232 tree   29 40 488
+3df983efd6acdf73dfc7b451a2e30f7ed42e7736 blob   5 14 528
+47d3697c3747e8184e0dc479ccbd01e359023577 commit 217 148 12
+5e28f2d1ee99ddf4595a7a1ff31efa1a107c11e7 tree   94 102 386
+737d98fe75742dd9a8f4bce5e176e7f8d99d9de3 tree   94 102 228
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheGetTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheGetTest.java
new file mode 100644
index 0000000..c19bb2b
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheGetTest.java
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2009, Google Inc.
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
+import java.io.BufferedReader;
+import java.io.FileInputStream;
+import java.io.IOException;
+import java.io.InputStreamReader;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.util.JGitTestUtil;
+import org.spearce.jgit.util.MutableInteger;
+
+public class WindowCacheGetTest extends RepositoryTestCase {
+	private List<TestObject> toLoad;
+
+	@Override
+	public void setUp() throws Exception {
+		super.setUp();
+
+		toLoad = new ArrayList<TestObject>();
+		final BufferedReader br = new BufferedReader(new InputStreamReader(
+				new FileInputStream(JGitTestUtil
+						.getTestResourceFile("all_packed_objects.txt")),
+				Constants.CHARSET));
+		try {
+			String line;
+			while ((line = br.readLine()) != null) {
+				final String[] parts = line.split(" {1,}");
+				final TestObject o = new TestObject();
+				o.id = ObjectId.fromString(parts[0]);
+				o.setType(parts[1]);
+				o.rawSize = Integer.parseInt(parts[2]);
+				// parts[3] is the size-in-pack
+				o.offset = Long.parseLong(parts[4]);
+				toLoad.add(o);
+			}
+		} finally {
+			br.close();
+		}
+		assertEquals(96, toLoad.size());
+	}
+
+	public void testCache_Defaults() throws IOException {
+		final WindowCacheConfig cfg = new WindowCacheConfig();
+		WindowCache.reconfigure(cfg);
+		doCacheTests();
+		checkLimits(cfg);
+
+		final WindowCache cache = WindowCache.getInstance();
+		assertEquals(6, cache.getOpenFiles());
+		assertEquals(17346, cache.getOpenBytes());
+	}
+
+	public void testCache_TooFewFiles() throws IOException {
+		final WindowCacheConfig cfg = new WindowCacheConfig();
+		cfg.setPackedGitOpenFiles(2);
+		WindowCache.reconfigure(cfg);
+		doCacheTests();
+		checkLimits(cfg);
+	}
+
+	public void testCache_TooSmallLimit() throws IOException {
+		final WindowCacheConfig cfg = new WindowCacheConfig();
+		cfg.setPackedGitWindowSize(4096);
+		cfg.setPackedGitLimit(4096);
+		WindowCache.reconfigure(cfg);
+		doCacheTests();
+		checkLimits(cfg);
+	}
+
+	private void checkLimits(final WindowCacheConfig cfg) {
+		final WindowCache cache = WindowCache.getInstance();
+		assertTrue(cache.getOpenFiles() <= cfg.getPackedGitOpenFiles());
+		assertTrue(cache.getOpenBytes() <= cfg.getPackedGitLimit());
+		assertTrue(0 < cache.getOpenFiles());
+		assertTrue(0 < cache.getOpenBytes());
+	}
+
+	private void doCacheTests() throws IOException {
+		for (final TestObject o : toLoad) {
+			final ObjectLoader or = db.openObject(o.id);
+			assertNotNull(or);
+			assertTrue(or instanceof PackedObjectLoader);
+			assertEquals(o.type, or.getType());
+			assertEquals(o.rawSize, or.getRawSize());
+			assertEquals(o.offset, ((PackedObjectLoader) or).getObjectOffset());
+		}
+	}
+
+	private class TestObject {
+		ObjectId id;
+
+		int type;
+
+		int rawSize;
+
+		long offset;
+
+		void setType(final String typeStr) throws CorruptObjectException {
+			final byte[] typeRaw = Constants.encode(typeStr + " ");
+			final MutableInteger ptr = new MutableInteger();
+			type = Constants.decodeTypeString(id, typeRaw, (byte) ' ', ptr);
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index 0c3e783..29ec6d3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -99,6 +99,13 @@ public final long getSize() {
 	}
 
 	/**
+	 * @return offset of object header within pack file
+	 */
+	public final long getObjectOffset() {
+		return objectOffset;
+	}
+
+	/**
 	 * @return offset of object data within pack file
 	 */
 	public final long getDataOffset() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 0102a2d..0c60853 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -115,6 +115,10 @@ public static void reconfigure(final WindowCacheConfig cfg) {
 		UnpackedObjectCache.reconfigure(cfg);
 	}
 
+	static WindowCache getInstance() {
+		return cache;
+	}
+
 	static final ByteWindow get(final PackFile pack, final long offset)
 			throws IOException {
 		final WindowCache c = cache;
@@ -165,6 +169,14 @@ private WindowCache(final WindowCacheConfig cfg) {
 			throw new IllegalArgumentException("Window size must be < limit");
 	}
 
+	int getOpenFiles() {
+		return openFiles.get();
+	}
+
+	int getOpenBytes() {
+		return openBytes.get();
+	}
+
 	@Override
 	protected int hash(final int packHash, final long off) {
 		return packHash + (int) (off >>> windowSizeShift);
-- 
1.6.3.rc3.199.g24398
