From: imyousuf@gmail.com
Subject: [JGit-io-RFC-PATCH v2 2/4] Add JGit IO SPI and default implementation
Date: Sun, 11 Oct 2009 21:07:51 +0700
Message-ID: <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwz7k-0008An-B5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbZJKOJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbZJKOJC
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:09:02 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:40147 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbZJKOJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:09:00 -0400
Received: by ewy4 with SMTP id 4so1831396ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=H9oARRFGZ1qfjkSNYbAaus0NI3FNi8Kx0D/YeePw6L8=;
        b=mQ2t7r9nsyiBqnBCoWB8eos6FcbPoxd36roWNmd79wk4sh2dFiDUN7RFy4cWCx96P9
         lWdYj67tec0fe+P5K9i5xq+czlvSEcxpkHhN89LwhuPFx8m2jQXc8pqYnHz9PaKR+p2B
         ewqWKpAAYmvJZmP2T6XYpe2mFOOQ/l/pTfraY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oqgfIAbq4lfFHm6j2SzkjtDJHvyko4WtFoxjp7cozSW5EZk0oPlxXLMIj7/f2hkZxp
         JM+buhBZnbcbK+r1l6TAsJfvtA0BNR/WtzhWsenv8q5l8wALyRkFoVv9nJVcoD/b/K3y
         nWj08EXC10HL6EejvpEtYNzDV0bEhHcvIGXjg=
Received: by 10.211.130.6 with SMTP id h6mr5803599ebn.97.1255270102044;
        Sun, 11 Oct 2009 07:08:22 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 23sm2698205eya.42.2009.10.11.07.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:08:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129929>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

The SPI mainly focus's in providing an API to JGit to be able to perform
similar operations to that of java.io.File. All direct I/O is based on the
java.io.Input/OutputStream classes.

Different JGit IO SPI provider is designed to be URI scheme based and thus
the default implementation is that of "file" scheme. SPI provider will be
integrated by their respective users in a manner similar to that of JDBC
driver registration. There is a SystemStorageManager that has similar
registration capabilities and the system storage providers should be
registered with the manager in one of the provided ways.

This SPI is based on the initial requirements for switching to it and thus
this SPI will change as required during full migration to it.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../src/org/eclipse/jgit/io/Entry.java             |  148 +++++++++++++
 .../src/org/eclipse/jgit/io/StorageSystem.java     |   57 +++---
 .../org/eclipse/jgit/io/StorageSystemManager.java  |  154 ++++++++++++++
 .../eclipse/jgit/io/localfs/LocalFileEntry.java    |  219 ++++++++++++++++++++
 .../eclipse/jgit/io/localfs/LocalFileSystem.java   |   51 +++--
 5 files changed, 577 insertions(+), 52 deletions(-)
 create mode 100644 org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
 copy org.eclipse.jgit.test/tst/org/eclipse/jgit/util/JGitTestUtil.java => org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java (62%)
 create mode 100644 org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystemManager.java
 create mode 100644 org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
 copy org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/Init.java => org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java (65%)

diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
new file mode 100644
index 0000000..cd69172
--- /dev/null
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
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
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
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
+package org.eclipse.jgit.io;
+
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.URI;
+
+/**
+ * Represents each entry in a storage system. For example, in a local filesystem
+ * storage it would represent {@link java.io.File}. Here the storage system
+ * mainly refers to where repository meta data such as git objects, ref logs,
+ * packs are stored; for example a '.git' directory and all its contents in a
+ * clone repo would correspond to an entry.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public interface Entry {
+
+  /**
+   * Retrieves the name of the entry
+   * @return Name of the entry
+   */
+  public String getName();
+
+  /**
+   * Retrieves the absolute path of the entry.
+   * @return Absoluth path
+   */
+  public String getAbsolutePath();
+
+  /**
+   * Retrieves whether the entry represents a directory or not
+   * @return True if represents a directory else false
+   */
+  public boolean isDirectory();
+
+  /**
+   * Signifies whether the entry is a new one or being read from the
+   * persistent storage
+   * @return True if being read form storage else false
+   */
+  public boolean isExists();
+
+  /**
+   * Make directories upto the entry represented by this instance, provided
+   * that this instance itself is a directory.
+   * @return True if directories were created.
+   */
+  public boolean mkdirs();
+
+  /**
+   * Retrieves the URI of this entry. URI in this case acts as a primary key
+   * to identify an entry.
+   * @return URI to identify this entry instance
+   */
+  public URI getURI();
+
+  /**
+   * Retrieves the length of the entry if its predictable.
+   * @return < 0 if the length is unpredictable else the length of the entry's
+   *         content
+   */
+  public long length();
+
+  /**
+   * Retrieves the InputStream for reading the content of the entry
+   * @return Input stream to read entry content
+   * @throws IOException If no such file exists or there is any other error
+   */
+  public InputStream getInputStream()
+          throws IOException;
+
+  /**
+   * Retrieves the OutputStream for writing content into the entry. It can be
+   * opened to either overwrite it or append to it.
+   * @param overwrite False if to write in append mode else true
+   * @return Output stream to write content to
+   * @throws IOException If no such file exists in append mode or there is any
+   *                     error in retrieving it.
+   */
+  public OutputStream getOutputStream(boolean overwrite)
+          throws IOException;
+
+  /**
+   * Retrieve all the child entries of this entries if its a directory.
+   * @return If not a directory then a empty array else array of sub-entries.
+   */
+  public Entry[] getChildren();
+
+  /**
+   * Retrieve a specific child of an entry. It will basically match
+   * {@link Entry#getName() name} of the children to find and that too only
+   * the direct children.
+   * @param name Name of the child to find
+   * @return If child is not found then NULL or else the child specified by
+   *         the name
+   */
+  public Entry getChild(String name);
+
+  /**
+   * Retrieve the parent entry of the current entry.
+   * @return NULL if no parent or else the direct parent of the current entry
+   */
+  public Entry getParent();
+
+  /**
+   * Retrieve the storage system this entry either is from or will be
+   * persisted to.
+   * @return Storage system of the entry, will never be NULL.
+   */
+  public StorageSystem getStorageSystem();
+}
diff --git a/org.eclipse.jgit.test/tst/org/eclipse/jgit/util/JGitTestUtil.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
similarity index 62%
copy from org.eclipse.jgit.test/tst/org/eclipse/jgit/util/JGitTestUtil.java
copy to org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
index b259185..9f45cb3 100644
--- a/org.eclipse.jgit.test/tst/org/eclipse/jgit/util/JGitTestUtil.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Imran M Yousuf <imyousuf@smartitengineering.com>
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
  *
  * All rights reserved.
  *
@@ -34,38 +34,35 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+package org.eclipse.jgit.io;
 
-package org.eclipse.jgit.util;
+import java.net.URI;
 
-import java.io.File;
-import java.net.URISyntaxException;
-import java.net.URL;
-
-public abstract class JGitTestUtil {
-	public static final String CLASSPATH_TO_RESOURCES = "org/eclipse/jgit/test/resources/";
+/**
+ * SPI providing access to the underlying storage system. Each provider is
+ * differentiated using their {@link StorageSystem#getURIProtocol() URI Protocol}.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public interface StorageSystem {
 
-	private JGitTestUtil() {
-		throw new UnsupportedOperationException();
-	}
+  /**
+   * Returns the supported scheme of this storage system.
+   * @return Scheme supported by this storage system.
+   * @see {@link http://tr.im/BiQ0 URI Scheme}
+   */
+  public String getURIScheme();
 
-	public static File getTestResourceFile(final String fileName) {
-		if (fileName == null || fileName.length() <= 0) {
-			return null;
-		}
-		final URL url = cl().getResource(CLASSPATH_TO_RESOURCES + fileName);
-		if (url == null) {
-			// If URL is null then try to load it as it was being
-			// loaded previously
-			return new File("tst", fileName);
-		}
-		try {
-			return new File(url.toURI());
-		} catch(URISyntaxException e) {
-			return new File(url.getPath());
-		}
-	}
+  /**
+   * Retrieve an entry using its URI
+   * @param uri URI to retrieve the entry for.
+   * @return Entry representing the URI
+   */
+  public Entry getEntry(URI uri);
 
-	private static ClassLoader cl() {
-		return JGitTestUtil.class.getClassLoader();
-	}
+  /**
+   * Retrieve the current working directory from the file system if any.
+   * @return Entry for current working directory.
+   */
+  public Entry getWorkingDirectory();
 }
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystemManager.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystemManager.java
new file mode 100644
index 0000000..999122e
--- /dev/null
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystemManager.java
@@ -0,0 +1,154 @@
+/*
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
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
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
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
+package org.eclipse.jgit.io;
+
+import java.io.IOException;
+import java.net.URI;
+import java.util.Hashtable;
+import java.util.Map;
+import org.eclipse.jgit.io.localfs.LocalFileSystem;
+
+/**
+ * Manager that registers different storage system for different {@link URI}
+ * schemes and serves users with {@link Entry} or {@link StorageSystem} as URI
+ * schemes request.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public class StorageSystemManager {
+
+  /**
+   * Map to act as registrar for all registered schemes
+   */
+  private static Map<String, StorageSystem> storageSystemMap;
+
+  /**
+   * Initialize the registrar and and load the instance for default storage,
+   * i.e. the local file system.
+   */
+  static {
+    storageSystemMap = new Hashtable<String, StorageSystem>();
+    try {
+      register(LocalFileSystem.class);
+    }
+    catch (Exception ex) {
+      ex.printStackTrace();
+    }
+  }
+
+  /**
+   * Retrieves the storage system for a given scheme from the registrar.
+   * @param scheme Scheme to retrieve; it should never be null
+   * @return Storage system representing the scheme.
+   * @throws IOException If scheme is null or scheme does not exist.
+   */
+  public static StorageSystem getStorageSystem(String scheme)
+          throws IOException {
+    if (scheme != null && storageSystemMap.containsKey(scheme)) {
+      return storageSystemMap.get(scheme);
+    }
+    else {
+      throw new IOException("Scheme ( " + scheme +
+                            " ) not registered with manager!");
+    }
+  }
+
+  /**
+   * Load an storage system entry using its respective URI.
+   * @param uri URI to retrieve the storage system entity for
+   * @return The entry in the storage system for the requested URI
+   * @throws IOException If scheme does not exist.
+   * @throws NullPointerException If uri is null
+   */
+  public static Entry getEntry(URI uri)
+          throws IOException,
+                 NullPointerException {
+    String scheme = uri.getScheme();
+    return getStorageSystem(scheme).getEntry(uri);
+  }
+
+  /**
+   * Registers a {@link StorageSystem} implementaiton against its schema into
+   * the registrar using the implementions fully qualified class name and its
+   * non-args constructor.
+   * @param storageSystemClassName The class names representation is string.
+   * @throws ClassNotFoundException If no class is found with the name specified
+   * @throws InstantiationException If there is any exception during
+   *                                initialization
+   * @throws IllegalAccessException If the class dpes not have a public
+   *                                non-args constructor
+   * @throws ClassCastException If the class does implement {@link StorageSystem}
+   */
+  public static void register(String storageSystemClassName)
+          throws ClassNotFoundException,
+                 InstantiationException,
+                 IllegalAccessException,
+                 ClassCastException {
+    register((Class<? extends StorageSystem>) Class.forName(
+            storageSystemClassName));
+  }
+
+  /**
+   * Registers a {@link StorageSystem} implementaiton against its schema into
+   * the registrar using the implemention class name and its non-args constructor.
+   * @param storageSystemClassName The class names representation is string.
+   * @throws InstantiationException If there is any exception during
+   *                                initialization
+   * @throws IllegalAccessException If the class dpes not have a public
+   *                                non-args constructor
+   */
+  public static void register(
+          Class<? extends StorageSystem> storageSystemClass)
+          throws InstantiationException,
+                 IllegalAccessException {
+    if (storageSystemClass != null) {
+      StorageSystem system = storageSystemClass.newInstance();
+      register(system);
+    }
+  }
+
+  /**
+   * Registers a {@link StorageSystem} instance into the reigstrar. It would be
+   * particularly useful if system does not have a non-args constructor.
+   * @param system System to register in the manager
+   */
+  public static void register(StorageSystem system) {
+    if (system != null) {
+      storageSystemMap.put(system.getURIScheme(), system);
+    }
+  }
+}
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
new file mode 100644
index 0000000..99df831
--- /dev/null
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
@@ -0,0 +1,219 @@
+/*
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
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
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
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
+package org.eclipse.jgit.io.localfs;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.URI;
+import org.eclipse.jgit.io.Entry;
+import org.eclipse.jgit.io.StorageSystem;
+import org.eclipse.jgit.io.StorageSystemManager;
+
+/**
+ * Entry implementation for local file system. This class should not be
+ * initialized directly unless its a {@link LocalFileSystem}. SPI users should
+ * use {@link StorageSystemManager#getEntry(java.net.URI)} to get the first
+ * {@link Entry} and then traverse from there onwards.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public class LocalFileEntry
+        implements Entry {
+
+  private File localFile;
+  private StorageSystem storageSystem;
+
+  /**
+   * Contructs an entry based of on the local file system storage and a file
+   * that will be represented by this entry.
+   * @param localFile File represented by this entry
+   * @param storageSystem Storage system of the entry
+   * @throws IllegalArgumentException If either argument is NULL
+   */
+  protected LocalFileEntry(File localFile,
+                           StorageSystem storageSystem)
+          throws IllegalArgumentException {
+    setLocalFile(localFile);
+    setStorageSystem(storageSystem);
+  }
+
+  /**
+   * Sets the storage system instance for this entry.
+   * @param storageSystem Storage system
+   * @throws IllegalArgumentException IF storageSystem is null
+   */
+  protected void setStorageSystem(StorageSystem storageSystem)
+          throws IllegalArgumentException {
+    if (storageSystem == null) {
+      throw new IllegalArgumentException("Storage system can't be NULL!");
+    }
+    this.storageSystem = storageSystem;
+  }
+
+  /**
+   * Retrieves the file being adapted by this entry.
+   * @return File being adapted
+   */
+  public File getLocalFile() {
+    return localFile;
+  }
+
+  /**
+   * Sets the file which is to be used as adapt from this instance by this
+   * implementation
+   * @param localFile Local file being adapted by this instance
+   * @throws IllegalArgumentException If localFile is null
+   */
+  protected void setLocalFile(File localFile)
+          throws IllegalArgumentException {
+    if (localFile == null) {
+      throw new IllegalArgumentException(
+              "Local file to be set can't be NULL");
+    }
+    this.localFile = localFile;
+  }
+
+  public String getName() {
+    return getLocalFile().getName();
+  }
+
+  public String getAbsolutePath() {
+    return getLocalFile().getAbsolutePath();
+  }
+
+  public boolean isDirectory() {
+    return getLocalFile().isDirectory();
+  }
+
+  public boolean isExists() {
+    return getLocalFile().exists();
+  }
+
+  public boolean mkdirs() {
+    return getLocalFile().mkdirs();
+  }
+
+  public URI getURI() {
+    return getLocalFile().toURI();
+  }
+
+  public InputStream getInputStream()
+          throws IOException {
+    if (getLocalFile().exists()) {
+      try {
+        return new FileInputStream(getLocalFile());
+      }
+      catch (FileNotFoundException ex) {
+        throw ex;
+      }
+    }
+    else {
+      throw new FileNotFoundException("File does not exists!");
+    }
+  }
+
+  public OutputStream getOutputStream(boolean overwrite)
+          throws IOException {
+    try {
+      if (!isExists()) {
+
+        return new FileOutputStream(getLocalFile());
+      }
+      else {
+        if (overwrite) {
+          return new FileOutputStream(getLocalFile());
+        }
+        else {
+          return new FileOutputStream(getLocalFile(), true);
+        }
+      }
+    }
+    catch (FileNotFoundException ex) {
+      throw ex;
+    }
+  }
+
+  public Entry[] getChildren() {
+    File[] children = getLocalFile().listFiles();
+    if (children == null || children.length == 0) {
+      return new Entry[0];
+    }
+    else {
+      Entry[] entries = new Entry[children.length];
+      for (int i = 0; i < children.length; ++i) {
+        entries[i] = getStorageSystem().getEntry(children[i].toURI());
+      }
+      return entries;
+    }
+  }
+
+  public Entry getChild(String name) {
+    if (name == null || name.length() == 0) {
+      return null;
+    }
+    Entry[] children = getChildren();
+    for (Entry entry : children) {
+      if (name.equals(entry.getName())) {
+        return entry;
+      }
+    }
+    return null;
+  }
+
+  public Entry getParent() {
+    File parent = getLocalFile().getParentFile();
+    if (parent == null) {
+      return null;
+    }
+    else {
+      return getStorageSystem().getEntry(parent.toURI());
+    }
+  }
+
+  public StorageSystem getStorageSystem() {
+    return storageSystem;
+  }
+
+  public long length() {
+    return getLocalFile().length();
+  }
+}
diff --git a/org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/Init.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
similarity index 65%
copy from org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/Init.java
copy to org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
index 49aa418..d0cb536 100644
--- a/org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/Init.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
  *
  * All rights reserved.
  *
@@ -34,31 +34,38 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-
-package org.eclipse.jgit.pgm;
+package org.eclipse.jgit.io.localfs;
 
 import java.io.File;
+import java.net.URI;
+import org.eclipse.jgit.io.Entry;
+import org.eclipse.jgit.io.StorageSystem;
+
+/**
+ * Implementation of storage system for the local file system.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public class LocalFileSystem
+        implements StorageSystem {
 
-import org.kohsuke.args4j.Option;
-import org.eclipse.jgit.lib.Repository;
+  public static final String PROTOCOL_FILE = "file";
 
-@Command(common = true, usage = "Create an empty git repository")
-class Init extends TextBuiltin {
-	@Option(name = "--bare", usage = "Create a bare repository")
-	private boolean bare;
+  public String getURIScheme() {
+    return PROTOCOL_FILE;
+  }
 
-	@Override
-	protected final boolean requiresRepository() {
-		return false;
-	}
+  public Entry getEntry(URI uri) {
+    if (uri == null) {
+      return null;
+    }
+    else {
+      return new LocalFileEntry(new File(uri), this);
+    }
+  }
 
-	@Override
-	protected void run() throws Exception {
-		if (gitdir == null)
-			gitdir = new File(bare ? "." : ".git");
-		db = new Repository(gitdir);
-		db.create(bare);
-		out.println("Initialized empty Git repository in "
-				+ gitdir.getAbsolutePath());
-	}
+  public Entry getWorkingDirectory() {
+    String curDir = System.getProperty("user.dir");
+    return new LocalFileEntry(new File(curDir), this);
+  }
 }
-- 
1.6.2.1
