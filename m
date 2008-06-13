From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 20/24] Formatted Repository class.
Date: Fri, 13 Jun 2008 20:35:17 +0200
Message-ID: <1213382121-19786-20-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAQ-0005zA-Nh
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbYFMSgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYFMSgB
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43439 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbYFMSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:34 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id D3F3AE184E02
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:33 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7Y-0000eI-02; Fri, 13 Jun 2008 20:35:33 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18S2I+2Fn1NjOArBKdnR8G8Se9LzaOSlcpw5lfB
	P4qgRADD81Jx4u4bKQJp4ALsZqnKpI53tKp7QJeMEg5ezcitbS
	SJRNwfQD4sGgJae2/sJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84916>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Repository.java       |  285 +++++++++++---------
 1 files changed, 160 insertions(+), 125 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5a21c6e..d7c3b13 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -66,16 +66,17 @@ import org.spearce.jgit.util.FS;
  *
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
  *
- * This implementation only handles a subtly undocumented subset of git features.
+ * This implementation only handles a subtly undocumented subset of git
+ * features.
  *
  */
 public class Repository {
@@ -93,7 +94,7 @@ public class Repository {
 
 	/**
 	 * Construct a representation of a Git repository.
-	 * 
+	 *
 	 * @param d
 	 *            GIT_DIR (the location of the repository metadata).
 	 * @throws IOException
@@ -106,7 +107,8 @@ public class Repository {
 			objectsDirs = readObjectsDirs(FS.resolve(gitDir, "objects"),
 					new ArrayList<File>()).toArray(new File[0]);
 		} catch (IOException e) {
-			IOException ex = new IOException("Cannot find all object dirs for " + gitDir);
+			IOException ex = new IOException("Cannot find all object dirs for "
+					+ gitDir);
 			ex.initCause(e);
 			throw ex;
 		}
@@ -130,12 +132,13 @@ public class Repository {
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
@@ -204,9 +207,9 @@ public class Repository {
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
@@ -233,14 +236,13 @@ public class Repository {
 	/**
 	 * @param id
 	 *            SHA-1 of an object.
-	 * 
+	 *
 	 * @return a {@link ObjectLoader} for accessing the data of the named
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
@@ -248,7 +250,7 @@ public class Repository {
 	 *            temporary working space associated with the calling thread.
 	 * @param id
 	 *            SHA-1 of an object.
-	 * 
+	 *
 	 * @return a {@link ObjectLoader} for accessing the data of the named
 	 *         object, or null if the object does not exist.
 	 * @throws IOException
@@ -266,7 +268,8 @@ public class Repository {
 					// This shouldn't happen unless the pack was corrupted
 					// after we opened it or the VM runs out of memory. This is
 					// a know problem with memory mapped I/O in java and have
-					// been noticed with JDK < 1.6. Tell the gc that now is a good
+					// been noticed with JDK < 1.6. Tell the gc that now is a
+					// good
 					// time to collect and try once more.
 					try {
 						curs.release();
@@ -312,13 +315,15 @@ public class Repository {
 	}
 
 	/**
-	 * Access a Commit object using a symbolic reference. This reference may
-	 * be a SHA-1 or ref in combination with a number of symbols translating
-	 * from one ref or SHA1-1 to another, such as HEAD^ etc.
+	 * Access a Commit object using a symbolic reference. This reference may be
+	 * a SHA-1 or ref in combination with a number of symbols translating from
+	 * one ref or SHA1-1 to another, such as HEAD^ etc.
 	 *
-	 * @param revstr a reference to a git commit object
+	 * @param revstr
+	 *            a reference to a git commit object
 	 * @return a Commit named by the specified string
-	 * @throws IOException for I/O error or unexpected object type.
+	 * @throws IOException
+	 *             for I/O error or unexpected object type.
 	 *
 	 * @see #resolve(String)
 	 */
@@ -332,11 +337,13 @@ public class Repository {
 	 *
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
@@ -352,9 +359,11 @@ public class Repository {
 
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
@@ -372,11 +381,12 @@ public class Repository {
 	}
 
 	/**
-	 * Access a Tree object using a symbolic reference. This reference may
-	 * be a SHA-1 or ref in combination with a number of symbols translating
-	 * from one ref or SHA1-1 to another, such as HEAD^{tree} etc.
+	 * Access a Tree object using a symbolic reference. This reference may be a
+	 * SHA-1 or ref in combination with a number of symbols translating from one
+	 * ref or SHA1-1 to another, such as HEAD^{tree} etc.
 	 *
-	 * @param revstr a reference to a git commit object
+	 * @param revstr
+	 *            a reference to a git commit object
 	 * @return a Tree named by the specified string
 	 * @throws IOException
 	 *
@@ -389,9 +399,11 @@ public class Repository {
 
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
@@ -406,12 +418,14 @@ public class Repository {
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
@@ -421,7 +435,8 @@ public class Repository {
 	 *
 	 * @param revstr
 	 * @return a Tag or null
-	 * @throws IOException on I/O error or unexpected type
+	 * @throws IOException
+	 *             on I/O error or unexpected type
 	 */
 	public Tag mapTag(String revstr) throws IOException {
 		final ObjectId id = resolve(revstr);
@@ -430,12 +445,15 @@ public class Repository {
 
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
@@ -447,7 +465,7 @@ public class Repository {
 
 	/**
 	 * Create a command to update (or create) a ref in this repository.
-	 * 
+	 *
 	 * @param ref
 	 *            name of the ref the caller wants to modify.
 	 * @return an update command. The caller must finish populating this command
@@ -466,13 +484,13 @@ public class Repository {
 	 *
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
 	 *
 	 * Not supported is
@@ -481,9 +499,11 @@ public class Repository {
 	 * <li>abbreviated SHA-1's</li>
 	 * </ul>
 	 *
-	 * @param revstr A git object references expression
+	 * @param revstr
+	 *            A git object references expression
 	 * @return an ObjectId
-	 * @throws IOException on serious errors
+	 * @throws IOException
+	 *             on serious errors
 	 */
 	public ObjectId resolve(final String revstr) throws IOException {
 		char[] rev = revstr.toCharArray();
@@ -493,7 +513,7 @@ public class Repository {
 			switch (rev[i]) {
 			case '^':
 				if (refId == null) {
-					String refstr = new String(rev,0,i);
+					String refstr = new String(rev, 0, i);
 					refId = resolveSimple(refstr);
 					if (refId == null)
 						return null;
@@ -513,23 +533,24 @@ public class Repository {
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
@@ -538,44 +559,43 @@ public class Repository {
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
@@ -583,22 +603,24 @@ public class Repository {
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
@@ -607,10 +629,10 @@ public class Repository {
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
@@ -619,14 +641,16 @@ public class Repository {
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
@@ -662,7 +686,7 @@ public class Repository {
 
 	/**
 	 * Add a single existing pack to the list of available pack files.
-	 * 
+	 *
 	 * @param pack
 	 *            path of the pack file to open.
 	 * @param idx
@@ -675,10 +699,10 @@ public class Repository {
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
 
@@ -690,12 +714,11 @@ public class Repository {
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
@@ -735,14 +758,16 @@ public class Repository {
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
 		refs.link(name, target);
 	}
@@ -756,12 +781,13 @@ public class Repository {
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
@@ -775,7 +801,7 @@ public class Repository {
 	 * @throws IOException
 	 */
 	public String getFullBranch() throws IOException {
-		final File ptr = new File(getDirectory(),"HEAD");
+		final File ptr = new File(getDirectory(), "HEAD");
 		final BufferedReader br = new BufferedReader(new FileReader(ptr));
 		String ref;
 		try {
@@ -787,7 +813,7 @@ public class Repository {
 			ref = ref.substring(5);
 		return ref;
 	}
-	
+
 	/**
 	 * @return name of current branch.
 	 * @throws IOException
@@ -808,7 +834,7 @@ public class Repository {
 				ref = ref.substring(11);
 			return ref;
 		} catch (FileNotFoundException e) {
-			final File ptr = new File(getDirectory(),"head-name");
+			final File ptr = new File(getDirectory(), "head-name");
 			final BufferedReader br = new BufferedReader(new FileReader(ptr));
 			String ref;
 			try {
@@ -819,7 +845,7 @@ public class Repository {
 			return ref;
 		}
 	}
-	
+
 	/**
 	 * @return all known refs (heads, tags, remotes).
 	 */
@@ -864,13 +890,17 @@ public class Repository {
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
@@ -881,7 +911,7 @@ public class Repository {
 		}
 		return ret;
 	}
-	
+
 	/** Clean up stale caches */
 	public void refreshFromDisk() {
 		refs.clearCache();
@@ -904,7 +934,7 @@ public class Repository {
 	static byte[] gitInternalSlash(byte[] bytes) {
 		if (File.separatorChar == '/')
 			return bytes;
-		for (int i=0; i<bytes.length; ++i)
+		for (int i = 0; i < bytes.length; ++i)
 			if (bytes[i] == File.separatorChar)
 				bytes[i] = '/';
 		return bytes;
@@ -916,18 +946,18 @@ public class Repository {
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
 	 *
 	 * @param refName
@@ -937,11 +967,11 @@ public class Repository {
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
@@ -953,11 +983,14 @@ public class Repository {
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
@@ -970,8 +1003,10 @@ public class Repository {
 	/**
 	 * String work dir and return normalized repository path
 	 *
-	 * @param wd Work dir
-	 * @param f File whose path shall be stripp off it's workdir
+	 * @param wd
+	 *            Work dir
+	 * @param f
+	 *            File whose path shall be stripp off it's workdir
 	 * @return normalized repository relative path
 	 */
 	public static String stripWorkDir(File wd, File f) {
@@ -989,7 +1024,7 @@ public class Repository {
 
 	/**
 	 * Creates a new {@link WorkTree} and initialize a repository for it.
-	 * 
+	 *
 	 * @param workTreeDirectory
 	 *            the directory with the project files.
 	 * @return a new {@link WorkTree} with a new and open {@link Repository}.
-- 
1.5.4.3
