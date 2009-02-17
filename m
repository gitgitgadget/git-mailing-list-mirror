From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 13/12] Add new file tree iterator that can adapt into a ContainerTreeIterator
Date: Tue, 17 Feb 2009 18:51:41 +0100
Message-ID: <1234893101-23143-1-git-send-email-torarnv@gmail.com>
References: <200902170652.36701.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZU7M-0006CJ-Q1
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZBQRuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZBQRuz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:50:55 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41850 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZBQRux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:50:53 -0500
Received: by bwz5 with SMTP id 5so4389213bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=c6IU4aP/sjKy4DHOAPU/tANIBrrwzPLsfN9fo8zSh8Q=;
        b=YWm5LprwxSniCwkFb2Sn9vhdTP3UE9ZCsMI1JgQttcHh5kAWjHG4z3+n+BY/txW+Hs
         qSCq6l1gq5Ggl+aCMsizrSzhd5jc9oRJn/UlQF3tkReRpuCtQ6FOQ7OxK2k4okec+Xhg
         46UfwVNsQhr9eFG46aSg/5PbmOAC1LbhFTYY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ig0G83ZEMtzPYTfmP440ZpboJTHqDxmN/m4oaGE4wT9yJ1a0QNMJrbTfFf8JUhkv1o
         tDliTSSOGfEuQq9vJr9jldKgwgOxIM0aJ0bhXDbWhK9CzzG5yzEySxfKv5p9uv0wp1Bs
         0ns4bllAnIEloCA8mSx7uCLpUc2mwB3TsI8pk=
Received: by 10.103.198.20 with SMTP id a20mr2847214muq.63.1234893050306;
        Tue, 17 Feb 2009 09:50:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id s10sm1573633muh.22.2009.02.17.09.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 09:50:49 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 86940468001; Tue, 17 Feb 2009 18:51:41 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <200902170652.36701.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110424>

As the iterator recurses into subtrees it will look for directories
that can be mapped using a given workspace root, and if there's a
mapping it will return a ContainerTreeIterator instead.

This feature required exposing the underlying file of the FileEntry,
as well as making ContainerTreeIterator's constructor that takes a
parent iterator public.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../core/T0003_AdaptableFileTreeIteratorTest.java  |   74 ++++++++++++=
+++++
 .../egit/core/AdaptableFileTreeIterator.java       |   87 ++++++++++++=
++++++++
 .../spearce/egit/core/ContainerTreeIterator.java   |   17 ++++-
 .../spearce/jgit/treewalk/FileTreeIterator.java    |   14 +++-
 4 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.egit.core.test/src/org/spearce/egit/cor=
e/T0003_AdaptableFileTreeIteratorTest.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/Ada=
ptableFileTreeIterator.java

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003=
_AdaptableFileTreeIteratorTest.java b/org.spearce.egit.core.test/src/or=
g/spearce/egit/core/T0003_AdaptableFileTreeIteratorTest.java
new file mode 100644
index 0000000..1e2fe03
--- /dev/null
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003_Adapta=
bleFileTreeIteratorTest.java
@@ -0,0 +1,74 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2009, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+package org.spearce.egit.core;
+
+import java.io.File;
+import java.io.FileWriter;
+import java.io.IOException;
+import java.util.Collections;
+import java.util.Set;
+
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IWorkspaceRoot;
+import org.spearce.egit.core.op.ConnectProviderOperation;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.core.test.GitTestCase;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.WorkingTreeIterator;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+
+public class T0003_AdaptableFileTreeIteratorTest extends GitTestCase {
+
+	private Repository repository;
+
+	private File repositoryRoot;
+
+	private File file;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+
+		repository =3D new Repository(gitDir);
+		repositoryRoot =3D repository.getWorkDir();
+		repository.create();
+
+		file =3D new File(project.getProject().getLocation().toFile(), "a.tx=
t");
+		final FileWriter fileWriter =3D new FileWriter(file);
+		fileWriter.write("aaaaaaaaaaa");
+		fileWriter.close();
+
+		final ConnectProviderOperation operation =3D new ConnectProviderOper=
ation(
+				project.getProject(), null);
+		operation.run(null);
+	}
+
+	public void testFileTreeToContainerAdaptation() throws IOException {
+		final IWorkspaceRoot root =3D project.getProject().getWorkspace()
+				.getRoot();
+
+		final TreeWalk treeWalk =3D new TreeWalk(repository);
+		treeWalk.addTree(new AdaptableFileTreeIterator(repositoryRoot, root)=
);
+		treeWalk.setRecursive(true);
+
+		final IFile eclipseFile =3D project.getProject().getFile(file.getNam=
e());
+		final RepositoryMapping mapping =3D RepositoryMapping
+				.getMapping(eclipseFile);
+		final Set<String> repositoryPaths =3D Collections.singleton(mapping
+				.getRepoRelativePath(eclipseFile));
+
+		assertTrue(repositoryPaths.size() =3D=3D 1);
+		treeWalk.setFilter(PathFilterGroup.createFromStrings(repositoryPaths=
));
+
+		assertTrue(treeWalk.next());
+
+		final WorkingTreeIterator iterator =3D treeWalk.getTree(1,
+				WorkingTreeIterator.class);
+		assertTrue(iterator instanceof ContainerTreeIterator);
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/AdaptableF=
ileTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/=
AdaptableFileTreeIterator.java
new file mode 100644
index 0000000..61211f6
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/AdaptableFileTree=
Iterator.java
@@ -0,0 +1,87 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2009, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+
+package org.spearce.egit.core;
+
+import java.io.File;
+import java.io.IOException;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IWorkspaceRoot;
+import org.eclipse.core.runtime.Path;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.FileTreeIterator;
+
+/**
+ * Java IO file tree iterator that can adapt to a {@link ContainerTree=
Iterator}
+ * <p>
+ * The iterator automatically adapts to a {@link ContainerTreeIterator=
} when
+ * recursing into directories that are accessible from the given works=
pace root.
+ *
+ * @see org.spearce.jgit.treewalk.FileTreeIterator
+ * @see org.spearce.egit.core.ContainerTreeIterator
+ */
+public class AdaptableFileTreeIterator extends FileTreeIterator {
+
+	IWorkspaceRoot root;
+
+	/**
+	 * Create a new iterator to traverse the given directory and its chil=
dren
+	 * <p>
+	 * The iterator will automatically adapt to a {@link ContainerTreeIte=
rator}
+	 * when encountering directories what can be mapped into the given wo=
rkspace
+	 * root.
+	 *
+	 * @param path
+	 *            the starting directory. This directory should correspon=
d to
+	 *            the repository root.
+	 * @param workspaceRoot
+	 *            the workspace root to check resource mapping against.
+	 *
+	 */
+	public AdaptableFileTreeIterator(final File path,
+			final IWorkspaceRoot workspaceRoot) {
+		super(path);
+		root =3D workspaceRoot;
+	}
+
+	/**
+	 * Create a new iterator to traverse a subdirectory.
+	 * <p>
+	 * The iterator will automatically adapt to a {@link ContainerTreeIte=
rator}
+	 * when encountering directories what can be mapped into the given wo=
rkspace
+	 * root.
+	 *
+	 * @param path
+	 *            the subdirectory. This should be a directory contained =
within
+	 *            the parent directory.
+	 * @param parent
+	 *            the parent iterator we were created from.
+	 * @param workspaceRoot
+	 *            the workspace root to check resource mapping against.
+	 */
+	protected AdaptableFileTreeIterator(final AdaptableFileTreeIterator p=
arent,
+			File path, final IWorkspaceRoot workspaceRoot) {
+		super(parent, path);
+		root =3D workspaceRoot;
+	}
+
+	@Override
+	public AbstractTreeIterator createSubtreeIterator(Repository repo)
+			throws IncorrectObjectTypeException, IOException {
+		final File currentFile =3D ((FileEntry) current()).getFile();
+		final IContainer[] containers =3D root.findContainersForLocation(new=
 Path(
+				currentFile.getAbsolutePath()));
+		if (containers.length > 0)
+			return new ContainerTreeIterator(this, containers[0]);
+		else
+			return new AdaptableFileTreeIterator(this, currentFile, root);
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerT=
reeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/Cont=
ainerTreeIterator.java
index 2403252..de592aa 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
@@ -88,7 +88,22 @@ public ContainerTreeIterator(final IWorkspaceRoot ro=
ot) {
 		init(entries());
 	}
=20
-	private ContainerTreeIterator(final WorkingTreeIterator p,
+	/**
+	 * Construct a new iterator from a container in the workspace, with a=
 given
+	 * parent iterator.
+	 * <p>
+	 * The iterator will support traversal over the named container, but =
only if
+	 * it is contained within a project which has the Git repository prov=
ider
+	 * connected and this resource is mapped into a Git repository. Durin=
g the
+	 * iteration the paths will be automatically generated to match the p=
roper
+	 * repository paths for this container's children.
+	 *=20
+	 * @param p
+	 *            the parent iterator we were created from.
+	 * @param base
+	 *            the part of the workspace the iterator will walk over.
+	 */
+	public ContainerTreeIterator(final WorkingTreeIterator p,
 			final IContainer base) {
 		super(p);
 		node =3D base;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIte=
rator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIte=
rator.java
index 2c71151..ef9866a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.j=
ava
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.j=
ava
@@ -100,7 +100,10 @@ public AbstractTreeIterator createSubtreeIterator(=
final Repository repo)
 		return r;
 	}
=20
-	static class FileEntry extends Entry {
+	/**
+	 * Wrapper for a standard Java IO file
+	 */
+	static public class FileEntry extends Entry {
 		final File file;
=20
 		private final FileMode mode;
@@ -151,5 +154,14 @@ public long getLastModified() {
 		public InputStream openInputStream() throws IOException {
 			return new FileInputStream(file);
 		}
+
+		/**
+		 * Get the underlying file of this entry.
+		 *=20
+		 * @return the underlying file of this entry
+		 */
+		public File getFile() {
+			return file;
+		}
 	}
 }
--=20
1.6.1.2.309.g2ea3
