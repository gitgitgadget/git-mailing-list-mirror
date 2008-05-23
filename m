From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 21/23] Formatted Repository class.
Date: Fri, 23 May 2008 22:34:30 +0200
Message-ID: <1211574872-23676-22-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze09-0006CA-6Y
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298AbYEWUfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759260AbYEWUf3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:29 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39687 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757525AbYEWUep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:45 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 048A8DE1A8BD
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:44 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyN-0005iq-00; Fri, 23 May 2008 22:34:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18aquwZep4V/LdjxDfSqX8PASR+k/M+bMRWEnGr
	cpZBKp8TyAO4wSiZiifkExPRnGLF5clu2+nvW8vHPUYsHNHKlP
	aNa6V9hvBWMUqSyKytMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82755>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Repository.java       |  345 +++++++++++---------
 1 files changed, 192 insertions(+), 153 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 86817c9..06e686f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -38,24 +38,25 @@ import org.spearce.jgit.util.FS;
  * Represents a Git repository. A repository holds all objects and refs used for
  * managing source code (could by any type of file, but source code is what
  * SCM's are typically used for).
- *
+ * 
  * In Git terms all data is stored in GIT_DIR, typically a directory called
  * .git. A work tree is maintained unless the repository is a bare repository.
  * Typically the .git directory is located at the root of the work dir.
- *
+ * 
  * <ul>
  * <li>GIT_DIR
- * 	<ul>
- * 		<li>objects/ - objects</li>
- * 		<li>refs/ - tags and heads</li>
- * 		<li>config - configuration</li>
- * 		<li>info/ - more configurations</li>
- * 	</ul>
+ * <ul>
+ * <li>objects/ - objects</li>
+ * <li>refs/ - tags and heads</li>
+ * <li>config - configuration</li>
+ * <li>info/ - more configurations</li>
+ * </ul>
  * </li>
  * </ul>
- *
- * This implementation only handles a subtly undocumented subset of git features.
- *
+ * 
+ * This implementation only handles a subtly undocumented subset of git
+ * features.
+ * 
  */
 public class Repository {
 	private static final String[] refSearchPaths = { "", "refs/",
@@ -80,7 +81,7 @@ public class Repository {
 
 	/**
 	 * Construct a representation of this git repo managing a Git repository.
-	 *
+	 * 
 	 * @param d
 	 *            GIT_DIR
 	 * @throws IOException
@@ -109,7 +110,8 @@ public class Repository {
 			objectsDirs = readObjectsDirs(FS.resolve(gitDir, "objects"),
 					new ArrayList<File>()).toArray(new File[0]);
 		} catch (IOException e) {
-			IOException ex = new IOException("Cannot find all object dirs for " + gitDir);
+			IOException ex = new IOException("Cannot find all object dirs for "
+					+ gitDir);
 			ex.initCause(e);
 			throw ex;
 		}
@@ -135,12 +137,13 @@ public class Repository {
 			scanForPacks();
 	}
 
-	private Collection<File> readObjectsDirs(File objectsDir, Collection<File> ret) throws IOException {
+	private Collection<File> readObjectsDirs(File objectsDir,
+			Collection<File> ret) throws IOException {
 		ret.add(objectsDir);
 		final File altFile = FS.resolve(objectsDir, "info/alternates");
 		if (altFile.exists()) {
 			BufferedReader ar = new BufferedReader(new FileReader(altFile));
-			for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
+			for (String alt = ar.readLine(); alt != null; alt = ar.readLine()) {
 				readObjectsDirs(FS.resolve(objectsDir, alt), ret);
 			}
 			ar.close();
@@ -151,7 +154,7 @@ public class Repository {
 	/**
 	 * Create a new Git repository initializing the necessary files and
 	 * directories.
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	public void create() throws IOException {
@@ -213,15 +216,15 @@ public class Repository {
 	 * to the alternative repo will be returned. If the object is not yet store
 	 * a usable path in this repo will be returned. It is assumed that callers
 	 * will look for objects in a pack first.
-	 *
+	 * 
 	 * @param objectId
 	 * @return suggested file name
 	 */
 	public File toFile(final AnyObjectId objectId) {
 		final String n = objectId.toString();
-		String d=n.substring(0, 2);
-		String f=n.substring(2);
-		for (int i=0; i<objectsDirs.length; ++i) {
+		String d = n.substring(0, 2);
+		String f = n.substring(2);
+		for (int i = 0; i < objectsDirs.length; ++i) {
 			File ret = new File(new File(objectsDirs[i], d), f);
 			if (ret.exists())
 				return ret;
@@ -253,9 +256,8 @@ public class Repository {
 	 *         object, or null if the object does not exist.
 	 * @throws IOException
 	 */
-	public ObjectLoader openObject(final AnyObjectId id)
-			throws IOException {
-		return openObject(new WindowCursor(),id);
+	public ObjectLoader openObject(final AnyObjectId id) throws IOException {
+		return openObject(new WindowCursor(), id);
 	}
 
 	/**
@@ -281,7 +283,8 @@ public class Repository {
 					// This shouldn't happen unless the pack was corrupted
 					// after we opened it or the VM runs out of memory. This is
 					// a know problem with memory mapped I/O in java and have
-					// been noticed with JDK < 1.6. Tell the gc that now is a good
+					// been noticed with JDK < 1.6. Tell the gc that now is a
+					// good
 					// time to collect and try once more.
 					try {
 						curs.release();
@@ -327,14 +330,16 @@ public class Repository {
 	}
 
 	/**
-	 * Access a Commit object using a symbolic reference. This reference may
-	 * be a SHA-1 or ref in combination with a number of symbols translating
-	 * from one ref or SHA1-1 to another, such as HEAD^ etc.
-	 *
-	 * @param revstr a reference to a git commit object
+	 * Access a Commit object using a symbolic reference. This reference may be
+	 * a SHA-1 or ref in combination with a number of symbols translating from
+	 * one ref or SHA1-1 to another, such as HEAD^ etc.
+	 * 
+	 * @param revstr
+	 *            a reference to a git commit object
 	 * @return a Commit named by the specified string
-	 * @throws IOException for I/O error or unexpected object type.
-	 *
+	 * @throws IOException
+	 *             for I/O error or unexpected object type.
+	 * 
 	 * @see #resolve(String)
 	 */
 	public Commit mapCommit(final String revstr) throws IOException {
@@ -344,14 +349,16 @@ public class Repository {
 
 	/**
 	 * Access any type of Git object by id and
-	 *
+	 * 
 	 * @param id
 	 *            SHA-1 of object to read
-	 * @param refName optional, only relevant for simple tags
+	 * @param refName
+	 *            optional, only relevant for simple tags
 	 * @return The Git object if found or null
 	 * @throws IOException
 	 */
-	public Object mapObject(final ObjectId id, final String refName) throws IOException {
+	public Object mapObject(final ObjectId id, final String refName)
+			throws IOException {
 		final ObjectLoader or = openObject(id);
 		final byte[] raw = or.getBytes();
 		if (or.getType() == Constants.OBJ_TREE)
@@ -367,9 +374,11 @@ public class Repository {
 
 	/**
 	 * Access a Commit by SHA'1 id.
+	 * 
 	 * @param id
 	 * @return Commit or null
-	 * @throws IOException for I/O error or unexpected object type.
+	 * @throws IOException
+	 *             for I/O error or unexpected object type.
 	 */
 	public Commit mapCommit(final ObjectId id) throws IOException {
 		final ObjectLoader or = openObject(id);
@@ -387,14 +396,15 @@ public class Repository {
 	}
 
 	/**
-	 * Access a Tree object using a symbolic reference. This reference may
-	 * be a SHA-1 or ref in combination with a number of symbols translating
-	 * from one ref or SHA1-1 to another, such as HEAD^{tree} etc.
-	 *
-	 * @param revstr a reference to a git commit object
+	 * Access a Tree object using a symbolic reference. This reference may be a
+	 * SHA-1 or ref in combination with a number of symbols translating from one
+	 * ref or SHA1-1 to another, such as HEAD^{tree} etc.
+	 * 
+	 * @param revstr
+	 *            a reference to a git commit object
 	 * @return a Tree named by the specified string
 	 * @throws IOException
-	 *
+	 * 
 	 * @see #resolve(String)
 	 */
 	public Tree mapTree(final String revstr) throws IOException {
@@ -404,9 +414,11 @@ public class Repository {
 
 	/**
 	 * Access a Tree by SHA'1 id.
+	 * 
 	 * @param id
 	 * @return Tree or null
-	 * @throws IOException for I/O error or unexpected object type.
+	 * @throws IOException
+	 *             for I/O error or unexpected object type.
 	 */
 	public Tree mapTree(final ObjectId id) throws IOException {
 		final ObjectLoader or = openObject(id);
@@ -421,22 +433,25 @@ public class Repository {
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_TREE);
 	}
 
-	private Tree makeTree(final ObjectId id, final byte[] raw) throws IOException {
+	private Tree makeTree(final ObjectId id, final byte[] raw)
+			throws IOException {
 		Tree ret = new Tree(this, id, raw);
 		return ret;
 	}
 
-	private Tag makeTag(final ObjectId id, final String refName, final byte[] raw) {
+	private Tag makeTag(final ObjectId id, final String refName,
+			final byte[] raw) {
 		Tag ret = new Tag(this, id, refName, raw);
 		return ret;
 	}
 
 	/**
 	 * Access a tag by symbolic name.
-	 *
+	 * 
 	 * @param revstr
 	 * @return a Tag or null
-	 * @throws IOException on I/O error or unexpected type
+	 * @throws IOException
+	 *             on I/O error or unexpected type
 	 */
 	public Tag mapTag(String revstr) throws IOException {
 		final ObjectId id = resolve(revstr);
@@ -445,12 +460,15 @@ public class Repository {
 
 	/**
 	 * Access a Tag by SHA'1 id
+	 * 
 	 * @param refName
 	 * @param id
 	 * @return Commit or null
-	 * @throws IOException for I/O error or unexpected object type.
+	 * @throws IOException
+	 *             for I/O error or unexpected object type.
 	 */
-	public Tag mapTag(final String refName, final ObjectId id) throws IOException {
+	public Tag mapTag(final String refName, final ObjectId id)
+			throws IOException {
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
@@ -462,8 +480,9 @@ public class Repository {
 
 	/**
 	 * Get a locked handle to a ref suitable for updating or creating.
-	 *
-	 * @param ref name to lock
+	 * 
+	 * @param ref
+	 *            name to lock
 	 * @return a locked ref
 	 * @throws IOException
 	 */
@@ -492,27 +511,29 @@ public class Repository {
 
 	/**
 	 * Parse a git revision string and return an object id.
-	 *
+	 * 
 	 * Currently supported is combinations of these.
 	 * <ul>
-	 *  <li>SHA-1 - a SHA-1</li>
-	 *  <li>refs/... - a ref name</li>
-	 *  <li>ref^n - nth parent reference</li>
-	 *  <li>ref~n - distance via parent reference</li>
-	 *  <li>ref@{n} - nth version of ref</li>
-	 *  <li>ref^{tree} - tree references by ref</li>
-	 *  <li>ref^{commit} - commit references by ref</li>
+	 * <li>SHA-1 - a SHA-1</li>
+	 * <li>refs/... - a ref name</li>
+	 * <li>ref^n - nth parent reference</li>
+	 * <li>ref~n - distance via parent reference</li>
+	 * <li>ref@{n} - nth version of ref</li>
+	 * <li>ref^{tree} - tree references by ref</li>
+	 * <li>ref^{commit} - commit references by ref</li>
 	 * </ul>
-	 *
+	 * 
 	 * Not supported is
 	 * <ul>
 	 * <li>timestamps in reflogs, ref@{full or relative timestamp}</li>
 	 * <li>abbreviated SHA-1's</li>
 	 * </ul>
-	 *
-	 * @param revstr A git object references expression
+	 * 
+	 * @param revstr
+	 *            A git object references expression
 	 * @return an ObjectId
-	 * @throws IOException on serious errors
+	 * @throws IOException
+	 *             on serious errors
 	 */
 	public ObjectId resolve(final String revstr) throws IOException {
 		char[] rev = revstr.toCharArray();
@@ -522,7 +543,7 @@ public class Repository {
 			switch (rev[i]) {
 			case '^':
 				if (refId == null) {
-					String refstr = new String(rev,0,i);
+					String refstr = new String(rev, 0, i);
 					refId = resolveSimple(refstr);
 					if (refId == null)
 						return null;
@@ -542,23 +563,24 @@ public class Repository {
 						int j;
 						ref = mapObject(refId, null);
 						if (!(ref instanceof Commit))
-							throw new IncorrectObjectTypeException(refId, Constants.TYPE_COMMIT);
-						for (j=i+1; j<rev.length; ++j) {
+							throw new IncorrectObjectTypeException(refId,
+									Constants.TYPE_COMMIT);
+						for (j = i + 1; j < rev.length; ++j) {
 							if (!Character.isDigit(rev[j]))
 								break;
 						}
-						String parentnum = new String(rev, i+1, j-i-1);
+						String parentnum = new String(rev, i + 1, j - i - 1);
 						int pnum = Integer.parseInt(parentnum);
 						if (pnum != 0)
-							refId = ((Commit)ref).getParentIds()[pnum - 1];
+							refId = ((Commit) ref).getParentIds()[pnum - 1];
 						i = j - 1;
 						break;
 					case '{':
 						int k;
 						String item = null;
-						for (k=i+2; k<rev.length; ++k) {
+						for (k = i + 2; k < rev.length; ++k) {
 							if (rev[k] == '}') {
-								item = new String(rev, i+2, k-i-2);
+								item = new String(rev, i + 2, k - i - 2);
 								break;
 							}
 						}
@@ -567,44 +589,43 @@ public class Repository {
 							if (item.equals("tree")) {
 								ref = mapObject(refId, null);
 								while (ref instanceof Tag) {
-									Tag t = (Tag)ref;
+									Tag t = (Tag) ref;
 									refId = t.getObjId();
 									ref = mapObject(refId, null);
 								}
 								if (ref instanceof Treeish)
-									refId = ((Treeish)ref).getTreeId();
+									refId = ((Treeish) ref).getTreeId();
 								else
-									throw new IncorrectObjectTypeException(refId,  Constants.TYPE_TREE);
-							}
-							else if (item.equals("commit")) {
+									throw new IncorrectObjectTypeException(
+											refId, Constants.TYPE_TREE);
+							} else if (item.equals("commit")) {
 								ref = mapObject(refId, null);
 								while (ref instanceof Tag) {
-									Tag t = (Tag)ref;
+									Tag t = (Tag) ref;
 									refId = t.getObjId();
 									ref = mapObject(refId, null);
 								}
 								if (!(ref instanceof Commit))
-									throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
-							}
-							else if (item.equals("blob")) {
+									throw new IncorrectObjectTypeException(
+											refId, Constants.TYPE_COMMIT);
+							} else if (item.equals("blob")) {
 								ref = mapObject(refId, null);
 								while (ref instanceof Tag) {
-									Tag t = (Tag)ref;
+									Tag t = (Tag) ref;
 									refId = t.getObjId();
 									ref = mapObject(refId, null);
 								}
 								if (!(ref instanceof byte[]))
-									throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
-							}
-							else if (item.equals("")) {
+									throw new IncorrectObjectTypeException(
+											refId, Constants.TYPE_COMMIT);
+							} else if (item.equals("")) {
 								ref = mapObject(refId, null);
 								if (ref instanceof Tag)
-									refId = ((Tag)ref).getObjId();
+									refId = ((Tag) ref).getObjId();
 								else {
 									// self
 								}
-							}
-							else
+							} else
 								throw new RevisionSyntaxException(revstr);
 						else
 							throw new RevisionSyntaxException(revstr);
@@ -612,22 +633,24 @@ public class Repository {
 					default:
 						ref = mapObject(refId, null);
 						if (ref instanceof Commit)
-							refId = ((Commit)ref).getParentIds()[0];
+							refId = ((Commit) ref).getParentIds()[0];
 						else
-							throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
-						
+							throw new IncorrectObjectTypeException(refId,
+									Constants.TYPE_COMMIT);
+
 					}
 				} else {
 					ref = mapObject(refId, null);
 					if (ref instanceof Commit)
-						refId = ((Commit)ref).getParentIds()[0];
+						refId = ((Commit) ref).getParentIds()[0];
 					else
-						throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
+						throw new IncorrectObjectTypeException(refId,
+								Constants.TYPE_COMMIT);
 				}
 				break;
 			case '~':
 				if (ref == null) {
-					String refstr = new String(rev,0,i);
+					String refstr = new String(rev, 0, i);
 					refId = resolveSimple(refstr);
 					ref = mapCommit(refId);
 				}
@@ -636,10 +659,10 @@ public class Repository {
 					if (!Character.isDigit(rev[l]))
 						break;
 				}
-				String distnum = new String(rev, i+1, l-i-1);
+				String distnum = new String(rev, i + 1, l - i - 1);
 				int dist = Integer.parseInt(distnum);
 				while (dist >= 0) {
-					refId = ((Commit)ref).getParentIds()[0];
+					refId = ((Commit) ref).getParentIds()[0];
 					ref = mapCommit(refId);
 					--dist;
 				}
@@ -648,14 +671,16 @@ public class Repository {
 			case '@':
 				int m;
 				String time = null;
-				for (m=i+2; m<rev.length; ++m) {
+				for (m = i + 2; m < rev.length; ++m) {
 					if (rev[m] == '}') {
-						time = new String(rev, i+2, m-i-2);
+						time = new String(rev, i + 2, m - i - 2);
 						break;
 					}
 				}
 				if (time != null)
-					throw new RevisionSyntaxException("reflogs not yet supported by revision parser yet", revstr);
+					throw new RevisionSyntaxException(
+							"reflogs not yet supported by revision parser yet",
+							revstr);
 				i = m - 1;
 				break;
 			default:
@@ -707,10 +732,10 @@ public class Repository {
 		final String p = pack.getName();
 		final String i = idx.getName();
 		if (p.length() != 50 || !p.startsWith("pack-") || !p.endsWith(".pack"))
-		    throw new IllegalArgumentException("Not a valid pack " + pack);
+			throw new IllegalArgumentException("Not a valid pack " + pack);
 		if (i.length() != 49 || !i.startsWith("pack-") || !i.endsWith(".idx"))
-		    throw new IllegalArgumentException("Not a valid pack " + idx);
-		if (!p.substring(0,45).equals(i.substring(0,45)))
+			throw new IllegalArgumentException("Not a valid pack " + idx);
+		if (!p.substring(0, 45).equals(i.substring(0, 45)))
 			throw new IllegalArgumentException("Pack " + pack
 					+ "does not match index " + idx);
 
@@ -722,12 +747,11 @@ public class Repository {
 	}
 
 	/**
-	 * Scan the object dirs, including alternates for packs
-	 * to use.
+	 * Scan the object dirs, including alternates for packs to use.
 	 */
 	public void scanForPacks() {
 		final ArrayList<PackFile> p = new ArrayList<PackFile>();
-		for (int i=0; i<objectsDirs.length; ++i)
+		for (int i = 0; i < objectsDirs.length; ++i)
 			scanForPacks(new File(objectsDirs[i], "pack"), p);
 		final PackFile[] arr = new PackFile[p.size()];
 		p.toArray(arr);
@@ -758,14 +782,16 @@ public class Repository {
 		}
 	}
 
-    /**
-     * Writes a symref (e.g. HEAD) to disk
-     *
-     * @param name symref name
-     * @param target pointed to ref
-     * @throws IOException
-     */
-    public void writeSymref(final String name, final String target)
+	/**
+	 * Writes a symref (e.g. HEAD) to disk
+	 * 
+	 * @param name
+	 *            symref name
+	 * @param target
+	 *            pointed to ref
+	 * @throws IOException
+	 */
+	public void writeSymref(final String name, final String target)
 			throws IOException {
 		final byte[] content = ("ref: " + target + "\n").getBytes("UTF-8");
 		final LockFile lck = new LockFile(fileForRef(name));
@@ -802,7 +828,7 @@ public class Repository {
 				ObjectId id = packedRefs.get(name);
 				if (id != null)
 					return new Ref(name, id);
-				
+
 				// no packed ref found, return blank one
 				return new Ref(name, null);
 			}
@@ -840,12 +866,13 @@ public class Repository {
 	 * @throws IOException
 	 */
 	public String getPatch() throws IOException {
-		final File ptr = new File(getDirectory(),"patches/"+getBranch()+"/applied");
+		final File ptr = new File(getDirectory(), "patches/" + getBranch()
+				+ "/applied");
 		final BufferedReader br = new BufferedReader(new FileReader(ptr));
-		String last=null;
+		String last = null;
 		try {
 			String line;
-			while ((line=br.readLine())!=null) {
+			while ((line = br.readLine()) != null) {
 				last = line;
 			}
 		} finally {
@@ -859,7 +886,7 @@ public class Repository {
 	 * @throws IOException
 	 */
 	public String getFullBranch() throws IOException {
-		final File ptr = new File(getDirectory(),"HEAD");
+		final File ptr = new File(getDirectory(), "HEAD");
 		final BufferedReader br = new BufferedReader(new FileReader(ptr));
 		String ref;
 		try {
@@ -871,7 +898,7 @@ public class Repository {
 			ref = ref.substring(5);
 		return ref;
 	}
-	
+
 	/**
 	 * @return name of current branch.
 	 * @throws IOException
@@ -892,7 +919,7 @@ public class Repository {
 				ref = ref.substring(11);
 			return ref;
 		} catch (FileNotFoundException e) {
-			final File ptr = new File(getDirectory(),"head-name");
+			final File ptr = new File(getDirectory(), "head-name");
 			final BufferedReader br = new BufferedReader(new FileReader(ptr));
 			String ref;
 			try {
@@ -910,25 +937,27 @@ public class Repository {
 	public Collection<String> getBranches() {
 		return listRefs("heads");
 	}
-	
+
 	/**
 	 * @return the names of all refs (local and remotes branches, tags)
 	 */
 	public Collection<String> getAllRefs() {
 		return listRefs("");
 	}
-	
+
 	private Collection<String> listRefs(String refSubDir) {
 		// add / to end, unless empty
-		if (refSubDir.length() > 0 && refSubDir.charAt(refSubDir.length() -1 ) != '/')
+		if (refSubDir.length() > 0
+				&& refSubDir.charAt(refSubDir.length() - 1) != '/')
 			refSubDir += "/";
-		
-		Collection<String> branchesRaw = listFilesRecursively(new File(refsDir, refSubDir), null);
+
+		Collection<String> branchesRaw = listFilesRecursively(new File(refsDir,
+				refSubDir), null);
 		ArrayList<String> branches = new ArrayList<String>();
 		for (String b : branchesRaw) {
 			branches.add("refs/" + refSubDir + b);
 		}
-		
+
 		refreshPackedRefsCache();
 		Set<String> keySet = packedRefs.keySet();
 		for (String s : keySet)
@@ -944,22 +973,23 @@ public class Repository {
 		return listRefs("tags");
 	}
 
-	private Map<String,ObjectId> packedRefs = new HashMap<String,ObjectId>();
+	private Map<String, ObjectId> packedRefs = new HashMap<String, ObjectId>();
+
 	private long packedrefstime = 0;
 
 	private void refreshPackedRefsCache() {
 		if (!packedRefsFile.exists()) {
 			if (packedRefs.size() > 0)
-				packedRefs = new HashMap<String,ObjectId>();
+				packedRefs = new HashMap<String, ObjectId>();
 			return;
 		}
 		if (packedRefsFile.lastModified() == packedrefstime)
 			return;
-		Map<String,ObjectId> newPackedRefs = new HashMap<String,ObjectId>();
+		Map<String, ObjectId> newPackedRefs = new HashMap<String, ObjectId>();
 		FileReader fileReader = null;
 		try {
 			fileReader = new FileReader(packedRefsFile);
-			BufferedReader b=new BufferedReader(fileReader);
+			BufferedReader b = new BufferedReader(fileReader);
 			String p;
 			while ((p = b.readLine()) != null) {
 				if (p.charAt(0) == '#')
@@ -968,12 +998,12 @@ public class Repository {
 					continue;
 				}
 				int spos = p.indexOf(' ');
-				ObjectId id = ObjectId.fromString(p.substring(0,spos));
-				String name = p.substring(spos+1);
+				ObjectId id = ObjectId.fromString(p.substring(0, spos));
+				String name = p.substring(spos + 1);
 				newPackedRefs.put(name, id);
 			}
 		} catch (IOException e) {
-			throw new Error("Cannot read packed refs",e);
+			throw new Error("Cannot read packed refs", e);
 		} finally {
 			if (fileReader != null) {
 				try {
@@ -1016,13 +1046,17 @@ public class Repository {
 	 * @return applied patches in a map indexed on current commit id
 	 * @throws IOException
 	 */
-	public Map<ObjectId,StGitPatch> getAppliedPatches() throws IOException {
-		Map<ObjectId,StGitPatch> ret = new HashMap<ObjectId,StGitPatch>();
+	public Map<ObjectId, StGitPatch> getAppliedPatches() throws IOException {
+		Map<ObjectId, StGitPatch> ret = new HashMap<ObjectId, StGitPatch>();
 		if (isStGitMode()) {
-			File patchDir = new File(new File(getDirectory(),"patches"),getBranch());
-			BufferedReader apr = new BufferedReader(new FileReader(new File(patchDir,"applied")));
-			for (String patchName=apr.readLine(); patchName!=null; patchName=apr.readLine()) {
-				File topFile = new File(new File(new File(patchDir,"patches"), patchName), "top");
+			File patchDir = new File(new File(getDirectory(), "patches"),
+					getBranch());
+			BufferedReader apr = new BufferedReader(new FileReader(new File(
+					patchDir, "applied")));
+			for (String patchName = apr.readLine(); patchName != null; patchName = apr
+					.readLine()) {
+				File topFile = new File(new File(new File(patchDir, "patches"),
+						patchName), "top");
 				BufferedReader tfr = new BufferedReader(new FileReader(topFile));
 				String objectId = tfr.readLine();
 				ObjectId id = ObjectId.fromString(objectId);
@@ -1052,7 +1086,7 @@ public class Repository {
 		}
 		return ret;
 	}
-	
+
 	/** Clean up stale caches */
 	public void refreshFromDisk() {
 		packedRefs = null;
@@ -1075,7 +1109,7 @@ public class Repository {
 	static byte[] gitInternalSlash(byte[] bytes) {
 		if (File.separatorChar == '/')
 			return bytes;
-		for (int i=0; i<bytes.length; ++i)
+		for (int i = 0; i < bytes.length; ++i)
 			if (bytes[i] == File.separatorChar)
 				bytes[i] = '/';
 		return bytes;
@@ -1087,32 +1121,32 @@ public class Repository {
 	public RepositoryState getRepositoryState() {
 		if (new File(getWorkDir(), ".dotest").exists())
 			return RepositoryState.REBASING;
-		if (new File(gitDir,".dotest-merge").exists())
+		if (new File(gitDir, ".dotest-merge").exists())
 			return RepositoryState.REBASING_INTERACTIVE;
-		if (new File(gitDir,"MERGE_HEAD").exists())
+		if (new File(gitDir, "MERGE_HEAD").exists())
 			return RepositoryState.MERGING;
-		if (new File(gitDir,"BISECT_LOG").exists())
+		if (new File(gitDir, "BISECT_LOG").exists())
 			return RepositoryState.BISECTING;
 		return RepositoryState.SAFE;
 	}
 
 	/**
-	 * Check validty of a ref name. It must not contain character that has
-	 * a special meaning in a Git object reference expression. Some other
+	 * Check validty of a ref name. It must not contain character that has a
+	 * special meaning in a Git object reference expression. Some other
 	 * dangerous characters are also excluded.
-	 *
+	 * 
 	 * @param refName
-	 *
+	 * 
 	 * @return true if refName is a valid ref name
 	 */
 	public static boolean isValidRefName(final String refName) {
 		final int len = refName.length();
 		char p = '\0';
-		for (int i=0; i<len; ++i) {
+		for (int i = 0; i < len; ++i) {
 			char c = refName.charAt(i);
 			if (c <= ' ')
 				return false;
-			switch(c) {
+			switch (c) {
 			case '.':
 				if (i == 0)
 					return false;
@@ -1124,11 +1158,14 @@ public class Repository {
 			case '/':
 				if (i == 0)
 					return false;
-				if (i == len -1)
+				if (i == len - 1)
 					return false;
 				break;
-			case '~': case '^': case ':':
-			case '?': case '[':
+			case '~':
+			case '^':
+			case ':':
+			case '?':
+			case '[':
 				return false;
 			case '*':
 				return false;
@@ -1140,9 +1177,11 @@ public class Repository {
 
 	/**
 	 * String work dir and return normalized repository path
-	 *
-	 * @param wd Work dir
-	 * @param f File whose path shall be stripp off it's workdir
+	 * 
+	 * @param wd
+	 *            Work dir
+	 * @param f
+	 *            File whose path shall be stripp off it's workdir
 	 * @return normalized repository relative path
 	 */
 	public static String stripWorkDir(File wd, File f) {
-- 
1.5.4.3
