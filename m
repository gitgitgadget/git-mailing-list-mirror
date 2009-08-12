From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT] Recognize gitlink tree entries when mapping a tree
Date: Wed, 12 Aug 2009 13:30:16 -0400
Message-ID: <1250098216-7760-1-git-send-email-fonseca@diku.dk>
References: <20090812153210.GF1033@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbHeh-00050Z-3N
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 19:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbZHLRaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 13:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZHLRaU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 13:30:20 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:55831 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbZHLRaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 13:30:19 -0400
Received: by gxk9 with SMTP id 9so248602gxk.13
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=qQLZcHRzVERgweCFP06QTW1zl5fL7PKq6DF4JoQ649I=;
        b=Zc7LkwhNc7UGC3yc36t9ZI6F4XksCdNrbgaI1y+QbwwIzhT6DuNehYJyUoa/Tt0zCe
         hSllk6nOPTjjjxP7JENX0c11hVoafsuwCKSqsJL3MnCiNtaIpkgSATbdAntXt2T9cehD
         lX/K7Hf4J2Kbq6AaylMO3pKbFb0FrDQ3hVZ38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=IrpbL6uqa8ojZjvoS8ZeZzu4fqP/AiJMlUXFr89g/FQpitZRht7x35eYNzaIbkghrD
         25DY8KUZMW6681ElY4s4EU1TzImKY1hVVSN73QJhciEp9Uh8IsJ1dH+BsSEaxrz+Vowe
         P+xmTLXOstgsFlgDdH1C2n7Y9AeDP306YXs1M=
Received: by 10.90.106.2 with SMTP id e2mr142403agc.19.1250098219561;
        Wed, 12 Aug 2009 10:30:19 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178045554.dsl.bell.ca [70.55.140.114])
        by mx.google.com with ESMTPS id 7sm30907agb.41.2009.08.12.10.30.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 10:30:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
In-Reply-To: <20090812153210.GF1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125718>

Also adds minimal testing of symlink and gitlink tree entries and amends
gitlink related javadoc.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 On Wed, Aug 12, 2009 at 11:32, Shawn O. Pearce<spearce@spearce.org> wrote:
 > Jonas Fonseca <fonseca@diku.dk> wrote:
 >> Adds minimal support for gitlinks, based on the existing code for
 >> handling symlinks. The goal is to avoid exceptions when reading trees
 >> with gitlinks.
 >
 > Applied, but who calls GitlinkTreeEntry ?

 True, here is a follow up, which should fix this. With this the Netbeans
 module no longer dumps stack traces when dealing with a repository containing
 submodules.

 .../spearce/jgit/test/resources/create-second-pack |   13 ++++++++++++-
 ...ck-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx |  Bin 0 -> 1240 bytes
 ...k-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack |  Bin 0 -> 651 bytes
 .../org/spearce/jgit/test/resources/packed-refs    |    2 ++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    1 +
 .../tst/org/spearce/jgit/lib/T0002_Tree.java       |    7 +++++++
 .../org/spearce/jgit/transport/TransportTest.java  |    2 +-
 .../src/org/spearce/jgit/lib/GitlinkTreeEntry.java |    2 +-
 .../src/org/spearce/jgit/lib/Tree.java             |   14 ++++++++------
 .../src/org/spearce/jgit/lib/TreeEntry.java        |    2 +-
 10 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
index 5501a67..7241fa6 100755
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
@@ -148,8 +148,19 @@ mkdir f
 echo "an F" >f/f
 git add f/f
 git commit -m "An F"
+
 git repack -d
-git pack-refs --all
 
+git checkout -b symlink master
+ln -s c/c1.txt symlink.txt
+git add symlink.txt
+git_commit -m "A symlink"
+
+git checkout -b gitlink master
+git submodule add "$(pwd)/.git" submodule
+git_commit -m "A gitlink"
+
+git repack -d
+git pack-refs --all
 
 gitk --all master
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.idx
new file mode 100644
index 0000000000000000000000000000000000000000..a5aed7def26f945bc329429195702b6c5f82444e
GIT binary patch
literal 1240
zcmexg;-AdGz`z8=LlH0n9X(VqD2$OYGmwuBvjD}hVOF5{D5h^1umQt-L||Q(cO|zM
zGgKV9bGy*?cK4G#9KK}{MLm<dW_8ajIK!!&vwq6jB^fi7V;(SYoVVZcamrV9CnoMI
zycM56ZcfsiRrP4XwN}ZzDP8)fYkSy##?)q<mRHtH`Fu9B>yPaEr_Ga#n2)v}U9D~~
zW#ai1xsB3Wwl8mU{M4|e>CBhT@0-kPc{h9$XyamDB^6LtD7$dd;$mP{Ndso>L%{G~
z3Zy}KoCheTvs+fx_VNdg(i1Ef@{3<GG~MPrAv_`8pq2B=iun8P36r;N{?oH6s!a+2
Df+%BI

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-cbdeda40019ae0e6e789088ea0f51f164f489d14.pack
new file mode 100644
index 0000000000000000000000000000000000000000..24f69429a0fa4f206a7e6481e17fd0e11725c219
GIT binary patch
literal 651
zcmV;60(AXQK|@Ob00062000J@4S1ZL%UcS<Fc5{|_pBltu;kKaG9Y62pbMBxrdsTc
zl7h=O-GXn2|L~PvL<i>(2}m589AalN2)2>jzzK3>0|RypS#7k-Qgn;nxs)tqPt0iB
zFkobaY@p)$#gqomM$u8;>#lqK)Q@vqsX3Z6-Q`R3Hc7+leACuiht+jnUkn(dYMsYY
z<PWNP{Tj<OE+6#+d)Pm+;RS#hc$~Y#c!yE9q$o92A=xxB$;jN;z|zFhFgeZ4#4t6<
z&@d^<B*{F{+ycl=GqNy9GO;k4s2k5@XgRUZQq<7WSV7mo+`xc~%Tb}YGB+nPFPjSh
z!RHoirVMzTGc+(TGci%nOV2FH%}*)KNiAlGDC(KqHLH7O!5L2Fob^-IF3FgwY+?We
z3W*F{w&g`0-Pr>9+cboaT)U<|v3Fu4L@tRzfaSvVHEO@V83ZgcIk}_DjXhlQGDI$!
z!Sm>kK!>~rmK|a{#QF0j9`n5@-)RW3IybSnB(+Gdq@skOY2$^Kw3h+#ZE4#pO8jS;
z6fWm!G&BPnQCyk?aUX-Hk@m(~t1}bbe)deiP!VXPvHSA@0OH(DH@paVoIT1x4uBvG
zMA5aJg1DESz>^pkh!r(xO<V3SsBt%We+J3ZL32)M+kdvBX)dp;?d@--$(#znN(aJ1
zr(p0P9AJ-|0&#S5q33|Ef>RU)745iwN`^1L|0gpF<w63kn7IMT$}+U>0)Z=doIA$2
zka41VwVIIu5GWK^=H_JPW$TqxlrZSByeqlAn4#j(o!f=Bx4WP0;qWa30EL1Q>o|Cv
lOV&>|)GMhd0RRgq0=2sxB|X#d2zAH=&~J0;0D{{I$P-a{H+%p9

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
index a6a14f2..82fb0d7 100644
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
@@ -7,8 +7,10 @@ d0114ab8ac326bab30e3a657a0397578c5a1af88 refs/heads/e
 47d3697c3747e8184e0dc479ccbd01e359023577 refs/heads/f
 175d5b80bd9768884d8fced02e9bd33488174396 refs/heads/g
 175d5b80bd9768884d8fced02e9bd33488174396 refs/heads/prefix/a
+68cb1f232964f3cd698afc1dafe583937203c587 refs/heads/gitlink
 49322bb17d3acc9146f98c97d078513228bbf3c0 refs/heads/master
 d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
+5ce00008cf3fb8f194f52742020bd40d78f3f1b3 refs/heads/symlink
 6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
 17768080a2318cd89bba4c8b87834401e2095703 refs/tags/B
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 6de9afe..b1adde9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -249,6 +249,7 @@ public void run() {
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371",
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
 				"pack-546ff360fe3488adb20860ce3436a2d6373d2796",
+				"pack-cbdeda40019ae0e6e789088ea0f51f164f489d14",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa",
 				"pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12"
 		};
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
index 97f299c..febcbc6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0002_Tree.java
@@ -271,4 +271,11 @@ public void test008_SubtreeInternalSorting() throws IOException {
 		assertSame(e4, ents[3]);
 		assertSame(e2, ents[4]);
 	}
+
+	public void test009_SymlinkAndGitlink() throws IOException {
+		final Tree symlinkTree = db.mapTree("symlink");
+		assertTrue("Symlink entry exists", symlinkTree.existsBlob("symlink.txt"));
+		final Tree gitlinkTree = db.mapTree("gitlink");
+		assertTrue("Gitlink entry exists", gitlinkTree.existsBlob("submodule"));
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
index fcf3f5c..c6bd13d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
@@ -123,7 +123,7 @@ public void testFindRemoteRefUpdatesWildcardNoTracking() throws IOException {
 				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
 						"+refs/heads/*:refs/heads/test/*")));
 
-		assertEquals(10, result.size());
+		assertEquals(12, result.size());
 		boolean foundA = false;
 		boolean foundB = false;
 		for (final RemoteRefUpdate rru : result) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java
index db6a8e2..5cabbd6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java
@@ -42,7 +42,7 @@
 import java.io.IOException;
 
 /**
- * A tree entry representing a symbolic link.
+ * A tree entry representing a gitlink entry used for submodules.
  *
  * Note. Java cannot really handle these as file system objects.
  */
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index ff9e666..291fce8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -428,7 +428,7 @@ private boolean exists(final String s, byte slast) throws IOException {
 	}
 
 	/**
-	 * @param path
+	 * @param path to the tree.
 	 * @return true if a tree with the specified path can be found under this
 	 *         tree.
 	 * @throws IOException
@@ -438,9 +438,9 @@ public boolean existsTree(String path) throws IOException {
 	}
 
 	/**
-	 * @param path
-	 * @return true if a blob or symlink with the specified name can be found
-	 *         under this tree.
+	 * @param path of the non-tree entry.
+	 * @return true if a blob, symlink, or gitlink with the specified name
+	 *         can be found under this tree.
 	 * @throws IOException
 	 */
 	public boolean existsBlob(String path) throws IOException {
@@ -576,10 +576,12 @@ else if (c < '0' || c > '7')
 				ent = new FileTreeEntry(this, id, name, false);
 			else if (FileMode.EXECUTABLE_FILE.equals(mode))
 				ent = new FileTreeEntry(this, id, name, true);
-			else if (FileMode.TREE.equals(mode)) {
+			else if (FileMode.TREE.equals(mode))
 				ent = new Tree(this, id, name);
-			} else if (FileMode.SYMLINK.equals(mode))
+			else if (FileMode.SYMLINK.equals(mode))
 				ent = new SymlinkTreeEntry(this, id, name);
+			else if (FileMode.GITLINK.equals(mode))
+				ent = new GitlinkTreeEntry(this, id, name);
 			else
 				throw new CorruptObjectException(getId(), "Invalid mode: "
 						+ Integer.toOctalString(mode));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index c95863c..4921c7a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -232,7 +232,7 @@ public int compareTo(final Object o) {
 	 * @return '/' for Tree entries and NUL for non-treeish objects.
 	 */
 	final public static int lastChar(TreeEntry treeEntry) {
-		if (treeEntry instanceof FileTreeEntry)
+		if (!(treeEntry instanceof Tree))
 			return '\0';
 		else
 			return '/';
-- 
1.6.4.rc3.195.g2b05f
