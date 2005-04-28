From: simon@hollie.ento.csiro.au (Simon Fowler)
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 18:41:57 +1000
Message-ID: <20050428084156.GK17682@himi.org>
References: <200504271251.00635.mason@suse.com> <200504271423.37433.mason@suse.com> <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org> <200504271831.47830.mason@suse.com>
Reply-To: simon@dreamcraft.com.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vLGWvOrvbSM0Ba8"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 10:52:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR4ji-0004Cg-0Y
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 10:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVD1Itz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVD1Isu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 04:48:50 -0400
Received: from act-ironport-ext-out2.csiro.au ([150.229.7.38]:23950 "EHLO
	act-ironport-ext-out2.csiro.au") by vger.kernel.org with ESMTP
	id S261950AbVD1ImM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 04:42:12 -0400
Received: from hollie.ento.csiro.au (152.83.145.236)
  by act-ironport-ext-out2.csiro.au with ESMTP; 28 Apr 2005 18:42:07 +1000
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
X-IronPort-AV: i="3.92,136,1112536800"; 
   d="asc'?diff'?scan'208"; a="42146854:sNHT70919118"
Received: by hollie.ento.csiro.au (Postfix, from userid 1000)
	id A9DAFB6F0; Thu, 28 Apr 2005 18:42:04 +1000 (EST)
To: Chris Mason <mason@suse.com>
Mail-Followup-To: Chris Mason <mason@suse.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200504271831.47830.mason@suse.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--7vLGWvOrvbSM0Ba8
Content-Type: multipart/mixed; boundary="sCNd3Ivk/oijKKf1"
Content-Disposition: inline


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2005 at 06:31:47PM -0400, Chris Mason wrote:
> On Wednesday 27 April 2005 18:19, Linus Torvalds wrote:
> > On Wed, 27 Apr 2005, Chris Mason wrote:
> > > So, new prog attached.  New usage:
> > >
> > > file-changes [-c commit_id] [-s commit_id] file ...
> > >
> > > -c is the commit where you want to start searching
> > > -s is the commit where you want to stop searching
> >
> > Your script will do some funky stuff, because you incorrectly think that
> > the rev-list is sorted linearly. It's not. It's sorted in a rough
> > chronological order, but you really can't do the "last" vs "cur" thing
> > that you do, because two commits after each other in the rev-list listi=
ng
> > may well be from two totally different branches, so when you compare one
> > tree against the other, you're really doing something pretty nonsensica=
l.
>=20
> Aha, didn't realize that one.  Thanks, I'll rework things here.
>=20
I've got a version of this written in C that I've been working on
for a bit - some example output:

+040000 tree    bfb75011c32589b282dd9c86621dadb0f0bb3866        ppc
+100644 blob    5ba4fc5259b063dab6417c142938d987ee894fc0        ppc/sha1.c
+100644 blob    c3c51aa4d487f2e85c02b0257c1f0b57d6158d76        ppc/sha1.h
+100644 blob    e85611a4ef0598f45911357d0d2f1fc354039de4        ppc/sha1ppc=
=2ES
commit b5af9107270171b79d46b099ee0b198e653f3a24->a6ef3518f9ac8a1c46a36c8d27=
173b1f73d839c4

You run it as:
find-changes commit_id file_prefix ...

The file_prefix is a path prefix to match - it's not as flexible as
regexes, but it shouldn't be too much less useful.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="find-changes.diff"
Content-Transfer-Encoding: quoted-printable

Find commits that changed files matching the prefix given on the command li=
ne.

Signed-off-by: Simon Fowler <simon@dreamcraft.com.au>
---

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/Makefile  (mode:100644 sha1:d7=
3bea1cbb9451a89b03d6066bf2ed7fec32fd31)
+++ uncommitted/Makefile  (mode:100644)
@@ -38,7 +38,7 @@
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
 	diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
-	diff-tree-helper
+	diff-tree-helper find-changes
=20
 SCRIPT=3D	commit-id tree-id parent-id cg-Xdiffdo cg-Xmergefile \
 	cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
Index: find-changes.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null  (tree:c3aa1e6b53cc59d5fbe261f3f859584904ae3a63)
+++ uncommitted/find-changes.c  (mode:100644 sha1:64c0c3627d84969ee1596b05f=
97705455fba1871)
@@ -0,0 +1,279 @@
+/*
+ * find-changes.c - find the commits that changed a particular file.
+ */
+
+#include "cache.h"
+//#include "revision.h"
+#include "commit.h"
+#include <sys/param.h>
+
+/*=20
+ * This is a simple tool that walks through the revisions cache and
+ * checks the parent-child diffs to see if they include the given
+ * filename.=20
+ */
+
+static int recursive =3D 1;
+static int found =3D 0;
+
+static char *malloc_base(const char *base, const char *path, int pathlen)
+{
+	int baselen =3D strlen(base);
+	char *newbase =3D malloc(baselen + pathlen + 2);
+	memcpy(newbase, base, baselen);
+	memcpy(newbase + baselen, path, pathlen);
+	memcpy(newbase + baselen + pathlen, "/", 2);
+	return newbase;
+}
+
+static void update_tree_entry(void **bufp, unsigned long *sizep)
+{
+	void *buf =3D *bufp;
+	unsigned long size =3D *sizep;
+	int len =3D strlen(buf) + 1 + 20;
+
+	if (size < len)
+		die("corrupt tree file");
+	*bufp =3D buf + len;
+	*sizep =3D size - len;
+}
+
+static const unsigned char *extract(void *tree, unsigned long size, const =
char **pathp, unsigned int *modep)
+{
+	int len =3D strlen(tree)+1;
+	const unsigned char *sha1 =3D tree + len;
+	const char *path =3D strchr(tree, ' ');
+
+	if (!path || size < len + 20 || sscanf(tree, "%o", modep) !=3D 1)
+		die("corrupt tree file");
+	*pathp =3D path+1;
+	return sha1;
+}
+
+static int check_file(void *tree, unsigned long size, const char *base, co=
nst char *target);
+
+/* A whole sub-tree went away or appeared */
+static int check_tree(void *tree, unsigned long size, const char *base, co=
nst char *target)
+{
+	int retval =3D 0;
+
+	while (size && !retval) {
+		retval =3D check_file(tree, size, base, target);
+		update_tree_entry(&tree, &size);
+	}
+	return retval;
+}
+
+/* A file entry went away or appeared.
+ * Check the entire subtree under this, and long_jmp() back to the parse_d=
iffs()
+ * function if we find the target. */
+static int check_file(void *tree, unsigned long size, const char *base, co=
nst char *target)
+{
+	unsigned mode;
+	const char *path;
+	char full_path[MAXPATHLEN + 1];
+	int pathlen, retval;
+	const unsigned char *sha1 =3D extract(tree, size, &path, &mode);
+
+	pathlen =3D snprintf(full_path, MAXPATHLEN, "%s%s", base, path);
+	if (!cache_name_compare(full_path, pathlen, target, strlen(target)))
+		found =3D 1;
+
+	if (recursive && S_ISDIR(mode)) {
+		char type[20];
+		unsigned long size;
+		char *newbase =3D malloc_base(base, path, strlen(path));
+		void *tree;
+
+		tree =3D read_sha1_file(sha1, type, &size);
+		if (!tree || strcmp(type, "tree"))
+			die("corrupt tree sha %s", sha1_to_hex(sha1));
+
+		retval =3D check_tree(tree, size, newbase, target);
+	=09
+		free(tree);
+		free(newbase);
+		return retval;
+	}
+	return 0;
+}
+=09
+static int diff_tree_sha1(const unsigned char *old, const unsigned char *n=
ew, const char *base, const char *target);
+
+/* the diff-tree algorithm depends on compare_tree_entry returning basical=
ly
+ * the same thing that memcmp() would on the filenames - this is important
+ * because the directories are sorted, and hence you need to decide what */
+static int compare_tree_entry(void *tree1, unsigned long size1,=20
+			      void *tree2, unsigned long size2,=20
+			      const char *base, const char *target)
+{
+	unsigned mode1, mode2;
+	const char *path1, *path2;
+	const unsigned char *sha1, *sha2;
+	int cmp, pathlen1, pathlen2;
+
+	if (found)
+		return 0;
+
+	sha1 =3D extract(tree1, size1, &path1, &mode1);
+	sha2 =3D extract(tree2, size2, &path2, &mode2);
+
+	pathlen1 =3D strlen(path1);
+	pathlen2 =3D strlen(path2);
+	cmp =3D cache_name_compare(path1, pathlen1, path2, pathlen2);
+	/* these files are different - if this is a directory then the
+	 * contents of the subtree are all different. So, we need to
+	 * run over the subtree and see if our target is in there
+	 * . . . */
+	if (cmp) {
+		check_file(tree1, size1, base, target);
+		check_file(tree2, size2, base, target);
+		return cmp;
+	}
+
+	if (!memcmp(sha1, sha2, 20) && mode1 =3D=3D mode2)
+		return 0;
+
+	/*
+	 * If the filemode has changed to/from a directory from/to a regular
+	 * file, we need to consider it a remove and an add.
+	 */
+	if (S_ISDIR(mode1) !=3D S_ISDIR(mode2)) {
+		check_file(tree1, size1, base, target);
+		check_file(tree2, size2, base, target);
+		return 0;
+	}
+
+	if (recursive && S_ISDIR(mode1)) {
+		int retval;
+		char *newbase =3D malloc_base(base, path1, pathlen1);
+		retval =3D diff_tree_sha1(sha1, sha2, newbase, target);
+		free(newbase);
+		return retval;
+	}
+=09
+	check_file(tree1, size1, base, target);
+	check_file(tree2, size2, base, target);
+	return 0;
+}
+
+static int diff_tree(void *tree1, unsigned long size1, void *tree2, unsign=
ed long size2,=20
+		     const char *base, const char *target)
+{
+	while (size1 | size2) {
+		if (!size1) {
+			check_file(tree2, size2, base, target);
+			update_tree_entry(&tree2, &size2);
+			continue;
+		}
+		if (!size2) {
+			check_file(tree1, size1, base, target);
+			update_tree_entry(&tree1, &size1);
+			continue;
+		}
+		switch (compare_tree_entry(tree1, size1, tree2, size2, base, target)) {
+		case -1:
+			update_tree_entry(&tree1, &size1);
+			continue;
+		case 0:
+			update_tree_entry(&tree1, &size1);
+			/* Fallthrough */
+		case 1:
+			update_tree_entry(&tree2, &size2);
+			continue;
+		}
+		die("diff-tree: internal error");
+	}
+	return 0;
+}
+
+static int diff_tree_sha1(const unsigned char *old, const unsigned char *n=
ew, const char *base,
+			  const char *target)
+{
+	void *tree1, *tree2;
+	unsigned long size1, size2;
+	char type[20];
+	int retval;
+
+	tree1 =3D read_sha1_file(old, type, &size1);
+	if (!tree1 || strcmp(type, "tree"))
+		die("unable to read source tree %s", sha1_to_hex(old));
+	tree2 =3D read_sha1_file(new, type, &size2);
+	if (!tree2 || strcmp(type, "tree"))
+		die("unable to read destination tree %s", sha1_to_hex(new));
+	retval =3D diff_tree(tree1, size1, tree2, size2, base, target);
+	free(tree1);
+	free(tree2);
+	return retval;
+}
+
+static int process_diffs(struct commit *parent, struct commit *commit, con=
st char *target)
+{
+	found =3D 0;
+	diff_tree_sha1(parent->tree->object.sha1, commit->tree->object.sha1, "", =
target);
+	if (found)
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+	return 0;
+}
+
+/*
+ * Walk the set of parents, and collect a list of the objects.=20
+ */
+void process_commit(struct commit *item)
+{
+	struct commit_list *parents;
+
+	if (parse_commit(item))
+		die("unable to parse commit %s", sha1_to_hex(item->object.sha1));
+=09
+	parents =3D item->parents;
+	while (parents) {
+		process_commit(parents->item);
+		parents =3D parents->next;
+	}
+}
+
+/*
+ * Usage: find-changes <parent-id> <filename>
+ *
+ * Note that this code will find the commits that change the given
+ * file in the set of commits that are parents of the one given on the
+ * command line.
+ */=20
+
+int main(int argc, char **argv)
+{
+	int i;
+	char sha1[20];
+	struct commit *orig;
+
+	if (argc !=3D 3)=20
+		usage("find-changes <parent-id> <filename>");
+	=09
+	get_sha1_hex(argv[1], sha1);
+	orig =3D lookup_commit(sha1);
+	process_commit(orig);
+	mark_reachable(&lookup_commit(argv[1])->object, 1);
+
+	/* this code needs to use tree.c to do most of the work - this
+	 * will simplify things a lot.=20
+	 * XXX: rewrite diff-tree.c to do the same. */
+=09
+	for (i =3D 0; i < nr_objs; i++) {
+		struct object *obj =3D objs[i];
+		struct commit *commit;
+		struct commit_list *p;
+
+		if (obj->type !=3D commit_type)
+			continue;
+
+		commit =3D (struct commit *) obj;
+
+		p =3D commit->parents;
+		while (p) {
+			process_diffs(p->item, commit, argv[2]);
+			p =3D p->next;
+		}
+	}
+	return 0;
+}

--sCNd3Ivk/oijKKf1--

--7vLGWvOrvbSM0Ba8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCcKHUQPlfmRRKmRwRAl19AKCCuHAG/qDGEAoh/xn8CEh+zo+M0QCghhpt
y60q1/hO0uvLRuG9HySS8yY=
=8GPM
-----END PGP SIGNATURE-----

--7vLGWvOrvbSM0Ba8--
