From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/11] Remove ObjectIdMap from the JGit library
Date: Wed, 29 Apr 2009 11:54:44 -0700
Message-ID: <1241031288-23437-8-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
 <1241031288-23437-5-git-send-email-spearce@spearce.org>
 <1241031288-23437-6-git-send-email-spearce@spearce.org>
 <1241031288-23437-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwu-0003Rz-JT
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbZD2SzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757198AbZD2SzE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:55:04 -0400
Received: from george.spearce.org ([209.20.77.23]:32891 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836AbZD2Syy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E08453806D; Wed, 29 Apr 2009 18:54:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FRT_LEVITRA autolearn=no version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 877293806A;
	Wed, 29 Apr 2009 18:54:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117923>

Nobody within the library uses it anymore.

Applications should consider ObjectIdSubclassMap, or just use a normal
JDK map type like HashMap or TreeMap.  In general ObjectIdSubclassMap
supports major map functionality, runs faster, and uses less memory for
the same sized data set.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Unchanged.

 .../tst/org/spearce/jgit/lib/ObjectIdMapTest.java  |  103 ----------
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |  201 --------------------
 2 files changed, 0 insertions(+), 304 deletions(-)
 delete mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
deleted file mode 100644
index f1c1c0c..0000000
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.spearce.jgit.lib;
-
-import java.util.Arrays;
-import java.util.Collection;
-import java.util.Map;
-import java.util.TreeMap;
-
-import junit.framework.TestCase;
-
-/**
- * Test functionality of ObjectIdMap
- *
- * The reason this class exists is performance, but those figures
- * are hard to make stable.
- */
-public class ObjectIdMapTest extends TestCase {
-
-	ObjectId[] ids = new ObjectId[500];
-	
-	protected void setUp() throws Exception {
-		int b=0;
-		for (int i=0; i<ids.length; ++i) {
-			byte[] data = new byte[Constants.OBJECT_ID_LENGTH];
-			for (int j=0; j<Constants.OBJECT_ID_LENGTH; ++j)
-				data[j] = (byte) (b++^0xEE);
-			ids[i] = ObjectId.fromRaw(data);
-		}
-	}
-
-	protected void tearDown() throws Exception {
-		ids = null; // avoid out of memory
-	}
-
-	/**
-	 * Verify that ObjectIdMap and TreeMap functionally are equivalent.
-	 */
-	@SuppressWarnings("unchecked")
-	public void testFunc() {
-		Map treeMap = new TreeMap();
-		for (int i=0; i<ids.length/100; ++i)
-			treeMap.put(ids[i],ids[i]);
-		Map levelMapWithTree = new ObjectIdMap(new TreeMap());
-		for (int i=0; i<ids.length/100; ++i)
-			levelMapWithTree.put(ids[i],ids[i]);
-		
-		assertEquals(treeMap, levelMapWithTree);
-		assertEquals(treeMap.values(), levelMapWithTree.values());
-		assertEquals(treeMap.keySet(), levelMapWithTree.keySet());
-
-		treeMap.remove(ids[30]);
-		levelMapWithTree.remove(ids[30]);
-		assertFalse(treeMap.containsKey(ids[30]));
-		assertFalse(levelMapWithTree.containsKey(ids[30]));
-		assertEquals(treeMap.values(), levelMapWithTree.values());
-		assertEquals(treeMap.keySet(), levelMapWithTree.keySet());
-	}
-
-	void assertEquals(Collection a, Collection b) {
-		Object[] aa = a.toArray();
-		Object[] ba = b.toArray();
-		Arrays.sort(aa);
-		Arrays.sort(ba);
-		assertTrue(Arrays.equals(aa, ba));
-	}
-
-}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
deleted file mode 100644
index d5b4294..0000000
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
+++ /dev/null
@@ -1,201 +0,0 @@
-/*
- * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.spearce.jgit.lib;
-
-import java.lang.reflect.InvocationTargetException;
-import java.lang.reflect.Method;
-import java.util.AbstractMap;
-import java.util.AbstractSet;
-import java.util.Iterator;
-import java.util.Map;
-import java.util.Set;
-import java.util.TreeMap;
-
-/**
- * Very much like a map, but specialized to partition the data on the first byte
- * of the key. This is about twice as fast. See test class.
- *
- * Inspiration is taken from the Git pack file format which uses this technique
- * to improve lookup performance.
- *
- * @param <V>
- *            The value we map ObjectId's to.
- *
- */
-public class ObjectIdMap<V> extends AbstractMap<ObjectId, V> {
-
-	@SuppressWarnings("unchecked")
-	final Map<ObjectId, V>[] level0 = new Map[256];
-	
-	/**
-	 * Construct an ObjectIdMap with an underlying TreeMap implementation
-	 */
-	public ObjectIdMap() {
-		this(new TreeMap());
-	}
-
-	/**
-	 * Construct an ObjectIdMap with the same underlying map implementation as
-	 * the provided example.
-	 *
-	 * @param sample
-	 */
-	@SuppressWarnings("unchecked")
-	public ObjectIdMap(Map sample) {
-		try {
-			Method m=sample.getClass().getMethod("clone", (Class[])null);
-			for (int i=0; i<256; ++i) {
-				level0[i] = (Map)m.invoke(sample, (Object[])null);
-			}
-		} catch (IllegalAccessException e) {
-			throw new IllegalArgumentException(e);
-		} catch (IllegalArgumentException e) {
-			throw new IllegalArgumentException(e);
-		} catch (InvocationTargetException e) {
-			throw new IllegalArgumentException(e);
-		} catch (SecurityException e) {
-			throw new IllegalArgumentException(e);
-		} catch (NoSuchMethodException e) {
-			throw new IllegalArgumentException(e);
-		}
-	}
-	
-	public void clear() {
-		for (int i=0; i<256; ++i)
-			level0[i].clear();
-	}
-
-	public boolean containsKey(Object key) {
-		return submap((ObjectId)key).containsKey(key);
-	}
-
-	private final Map<ObjectId, V> submap(ObjectId key) {
-		return level0[key.getFirstByte()];
-	}
-
-	public boolean containsValue(Object value) {
-		for (int i=0; i<256; ++i)
-			if (level0[i].containsValue(value))
-				return true;
-		return false;
-	}
-
-	private Set<Map.Entry<ObjectId, V>> entrySet =
-		new AbstractSet<Map.Entry<ObjectId, V>>() {
-
-			@Override
-			final public Iterator<Map.Entry<ObjectId, V>> iterator() {
-				return new Iterator<Entry<ObjectId,V>>() {
-					private int levelIndex;
-					private boolean hasNext;
-					private Iterator<Map.Entry<ObjectId, V>> levelIterator;
-					private Iterator<Map.Entry<ObjectId, V>> lastIterator;
-					{
-						step();
-					}
-					public boolean hasNext() {
-						return hasNext;
-					}
-					public java.util.Map.Entry<ObjectId, V> next() {
-						Entry<ObjectId, V> ret = levelIterator.next();
-						step();
-						return ret;
-					}
-					public void remove() {
-						lastIterator.remove();
-					}
-
-					private void step() {
-						hasNext = false;
-						lastIterator = levelIterator;
-						while ((levelIterator==null || !(hasNext=levelIterator.hasNext()))) {
-							if (levelIndex < level0.length)
-								levelIterator = level0[levelIndex++].entrySet().iterator();
-							else
-								break;
-						}
-					}
-				};
-			}
-
-			@Override
-			public int size() {
-				int ret=0;
-				for (int i=0; i<256; ++i)
-					ret += level0[i].size();
-				return ret;
-			}
-	};
-
-
-	public Set<Map.Entry<ObjectId, V>> entrySet() {
-		return entrySet;
-	}
-
-	public V get(Object key) {
-		return submap((ObjectId)key).get(key);
-	}
-
-	public boolean isEmpty() {
-		for (int i=0; i<256; ++i)
-			if (!level0[i].isEmpty())
-				return false;
-		return true;
-	}
-
-	public V put(ObjectId key, V value) {
-		return submap(key).put(key, value);
-	}
-
-	public void putAll(Map<? extends ObjectId, ? extends V> arg0) {
-		for (Map.Entry<? extends ObjectId, ? extends V> entry : arg0.entrySet()) {
-			final ObjectId k = entry.getKey();
-			final V v = entry.getValue();
-			put(k,v);
-		}
-	}
-
-	public V remove(Object key) {
-		return submap((ObjectId) key).remove(key);
-	}
-
-	public int size() {
-		return entrySet().size();
-	}
-
-}
-- 
1.6.3.rc3.199.g24398
