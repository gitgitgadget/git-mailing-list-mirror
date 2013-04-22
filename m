From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/33] pack-refs: merge code from pack-refs.{c,h} into refs.{c,h}
Date: Mon, 22 Apr 2013 21:52:32 +0200
Message-ID: <1366660361-21831-25-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMvn-0006yB-0G
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab3DVUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:39 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63503 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847Ab3DVUBh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:37 -0400
X-AuditID: 12074412-b7f216d0000008d4-67-51759559bdec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 11.8F.02260.95595715; Mon, 22 Apr 2013 15:54:01 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOb008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:00 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqBs5tTTQYN8mfYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M648WIJY8HZ8IqFj5pZGxiP
	u3YxcnJICJhInD36lwnCFpO4cG89WxcjF4eQwGVGiev/lzJBOBeYJGb3nGYGqWIT0JVY1NMM
	1iEioCYxse0QC4jNLOAgsflzIyOILSwQInH71AJ2EJtFQFViye3LQDYHB6+Aq8SKrzwQyxQk
	jm/fBlbOCRQ+3XECbIyQgIvEioNTWSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGum
	l5tZopeaUrqJERIqQjsY15+UO8QowMGoxMMr4F4aKMSaWFZcmXuIUZKDSUmUl2MKUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIr2g+UI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFq
	EUxWhoNDSYL322SgRsGi1PTUirTMnBKENBMHJ4jgAtnAA7RBHmQ7b3FBYm5xZjpE0SlGRSlx
	XrdJQAkBkERGaR7cAFhUv2IUB/pHmJcPpJ0HmBDgul8BDWYCGpyZUAIyuCQRISXVwBgk/sHt
	dRrXB6dTNonS1/irazjLDTRqpQ90HtSXbt+e87JAeckDi+ylD9wdLZRqJaceil17WO9jXowS
	97eqY1lHNd+u+B/BGvFn07cyrZv/V212+frc+ewVi3uCl2QvXZjTMDP0EFOjsRLPkiCto9u6
	pqsmMj+6kfY/7QfHLma2eIuOS4ILmZRYijMSDbWYi4oTAUlIMk/FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222075>

pack-refs.c doesn't contain much code, and the code it does contain is
closely related to reference handling.  Moreover, there is some
duplication between pack_refs() and repack_without_ref().  Therefore,
merge pack-refs.c into refs.c and pack-refs.h into refs.h.

The code duplication will be addressed in future commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile            |   2 -
 builtin/clone.c     |   1 -
 builtin/pack-refs.c |   2 +-
 pack-refs.c         | 148 ----------------------------------------------------
 pack-refs.h         |  18 -------
 refs.c              | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h              |  14 +++++
 7 files changed, 159 insertions(+), 170 deletions(-)
 delete mode 100644 pack-refs.c
 delete mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index 0f931a2..de38539 100644
--- a/Makefile
+++ b/Makefile
@@ -684,7 +684,6 @@ LIB_H += notes-cache.h
 LIB_H += notes-merge.h
 LIB_H += notes.h
 LIB_H += object.h
-LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += pack.h
 LIB_H += parse-options.h
@@ -817,7 +816,6 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
-LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
diff --git a/builtin/clone.c b/builtin/clone.c
index f9c380e..883cf2a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -18,7 +18,6 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
-#include "pack-refs.h"
 #include "sigchain.h"
 #include "branch.h"
 #include "remote.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b5a0f88..b20b1ec 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "parse-options.h"
-#include "pack-refs.h"
+#include "refs.h"
 
 static char const * const pack_refs_usage[] = {
 	N_("git pack-refs [options]"),
diff --git a/pack-refs.c b/pack-refs.c
deleted file mode 100644
index d840055..0000000
--- a/pack-refs.c
+++ /dev/null
@@ -1,148 +0,0 @@
-#include "cache.h"
-#include "refs.h"
-#include "tag.h"
-#include "pack-refs.h"
-
-struct ref_to_prune {
-	struct ref_to_prune *next;
-	unsigned char sha1[20];
-	char name[FLEX_ARRAY];
-};
-
-struct pack_refs_cb_data {
-	unsigned int flags;
-	struct ref_to_prune *ref_to_prune;
-	FILE *refs_file;
-};
-
-static int do_not_prune(int flags)
-{
-	/* If it is already packed or if it is a symref,
-	 * do not prune it.
-	 */
-	return (flags & (REF_ISSYMREF|REF_ISPACKED));
-}
-
-static int pack_one_ref(const char *path, const unsigned char *sha1,
-			  int flags, void *cb_data)
-{
-	struct pack_refs_cb_data *cb = cb_data;
-	struct object *o;
-	int is_tag_ref;
-
-	/* Do not pack the symbolic refs */
-	if ((flags & REF_ISSYMREF))
-		return 0;
-	is_tag_ref = !prefixcmp(path, "refs/tags/");
-
-	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
-		return 0;
-
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
-
-	o = parse_object_or_die(sha1, path);
-	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, path, 0);
-		if (o)
-			fprintf(cb->refs_file, "^%s\n",
-				sha1_to_hex(o->sha1));
-	}
-
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
-		int namelen = strlen(path) + 1;
-		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
-		hashcpy(n->sha1, sha1);
-		strcpy(n->name, path);
-		n->next = cb->ref_to_prune;
-		cb->ref_to_prune = n;
-	}
-	return 0;
-}
-
-/*
- * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
- */
-static void try_remove_empty_parents(char *name)
-{
-	char *p, *q;
-	int i;
-	p = name;
-	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
-		while (*p && *p != '/')
-			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p == '/')
-			p++;
-	}
-	for (q = p; *q; q++)
-		;
-	while (1) {
-		while (q > p && *q != '/')
-			q--;
-		while (q > p && *(q-1) == '/')
-			q--;
-		if (q == p)
-			break;
-		*q = '\0';
-		if (rmdir(git_path("%s", name)))
-			break;
-	}
-}
-
-/* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
-{
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
-
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
-	}
-}
-
-static void prune_refs(struct ref_to_prune *r)
-{
-	while (r) {
-		prune_ref(r);
-		r = r->next;
-	}
-}
-
-static struct lock_file packed;
-
-int pack_refs(unsigned int flags)
-{
-	int fd;
-	struct pack_refs_cb_data cbdata;
-
-	memset(&cbdata, 0, sizeof(cbdata));
-	cbdata.flags = flags;
-
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
-				       LOCK_DIE_ON_ERROR);
-	cbdata.refs_file = fdopen(fd, "w");
-	if (!cbdata.refs_file)
-		die_errno("unable to create ref-pack file structure");
-
-	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
-
-	for_each_ref(pack_one_ref, &cbdata);
-	if (ferror(cbdata.refs_file))
-		die("failed to write ref-pack file");
-	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-		die_errno("failed to write ref-pack file");
-	/*
-	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
-	 * assign -1 to the lock file descriptor so that commit_lock_file()
-	 * won't try to close() it.
-	 */
-	packed.fd = -1;
-	if (commit_lock_file(&packed) < 0)
-		die_errno("unable to overwrite old ref-pack file");
-	prune_refs(cbdata.ref_to_prune);
-	return 0;
-}
diff --git a/pack-refs.h b/pack-refs.h
deleted file mode 100644
index 518acfb..0000000
--- a/pack-refs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef PACK_REFS_H
-#define PACK_REFS_H
-
-/*
- * Flags for controlling behaviour of pack_refs()
- * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
- */
-#define PACK_REFS_PRUNE 0x0001
-#define PACK_REFS_ALL   0x0002
-
-/*
- * Write a packed-refs file for the current repository.
- * flags: Combination of the above PACK_REFS_* flags.
- */
-int pack_refs(unsigned int flags);
-
-#endif /* PACK_REFS_H */
diff --git a/refs.c b/refs.c
index 42298db..268c1a0 100644
--- a/refs.c
+++ b/refs.c
@@ -1983,6 +1983,150 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
 	}
 }
 
+struct ref_to_prune {
+	struct ref_to_prune *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+};
+
+struct pack_refs_cb_data {
+	unsigned int flags;
+	struct ref_to_prune *ref_to_prune;
+	FILE *refs_file;
+};
+
+static int do_not_prune(int flags)
+{
+	/* If it is already packed or if it is a symref,
+	 * do not prune it.
+	 */
+	return (flags & (REF_ISSYMREF|REF_ISPACKED));
+}
+
+static int pack_one_ref(const char *path, const unsigned char *sha1,
+			  int flags, void *cb_data)
+{
+	struct pack_refs_cb_data *cb = cb_data;
+	struct object *o;
+	int is_tag_ref;
+
+	/* Do not pack the symbolic refs */
+	if ((flags & REF_ISSYMREF))
+		return 0;
+	is_tag_ref = !prefixcmp(path, "refs/tags/");
+
+	/* ALWAYS pack refs that were already packed or are tags */
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
+		return 0;
+
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+
+	o = parse_object_or_die(sha1, path);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, path, 0);
+		if (o)
+			fprintf(cb->refs_file, "^%s\n",
+				sha1_to_hex(o->sha1));
+	}
+
+	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
+		int namelen = strlen(path) + 1;
+		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
+		hashcpy(n->sha1, sha1);
+		strcpy(n->name, path);
+		n->next = cb->ref_to_prune;
+		cb->ref_to_prune = n;
+	}
+	return 0;
+}
+
+/*
+ * Remove empty parents, but spare refs/ and immediate subdirs.
+ * Note: munges *name.
+ */
+static void try_remove_empty_parents(char *name)
+{
+	char *p, *q;
+	int i;
+	p = name;
+	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
+		while (*p && *p != '/')
+			p++;
+		/* tolerate duplicate slashes; see check_refname_format() */
+		while (*p == '/')
+			p++;
+	}
+	for (q = p; *q; q++)
+		;
+	while (1) {
+		while (q > p && *q != '/')
+			q--;
+		while (q > p && *(q-1) == '/')
+			q--;
+		if (q == p)
+			break;
+		*q = '\0';
+		if (rmdir(git_path("%s", name)))
+			break;
+	}
+}
+
+/* make sure nobody touched the ref, and unlink */
+static void prune_ref(struct ref_to_prune *r)
+{
+	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+
+	if (lock) {
+		unlink_or_warn(git_path("%s", r->name));
+		unlock_ref(lock);
+		try_remove_empty_parents(r->name);
+	}
+}
+
+static void prune_refs(struct ref_to_prune *r)
+{
+	while (r) {
+		prune_ref(r);
+		r = r->next;
+	}
+}
+
+static struct lock_file packed;
+
+int pack_refs(unsigned int flags)
+{
+	int fd;
+	struct pack_refs_cb_data cbdata;
+
+	memset(&cbdata, 0, sizeof(cbdata));
+	cbdata.flags = flags;
+
+	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
+				       LOCK_DIE_ON_ERROR);
+	cbdata.refs_file = fdopen(fd, "w");
+	if (!cbdata.refs_file)
+		die_errno("unable to create ref-pack file structure");
+
+	/* perhaps other traits later as well */
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
+
+	for_each_ref(pack_one_ref, &cbdata);
+	if (ferror(cbdata.refs_file))
+		die("failed to write ref-pack file");
+	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
+		die_errno("failed to write ref-pack file");
+	/*
+	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
+	 * assign -1 to the lock file descriptor so that commit_lock_file()
+	 * won't try to close() it.
+	 */
+	packed.fd = -1;
+	if (commit_lock_file(&packed) < 0)
+		die_errno("unable to overwrite old ref-pack file");
+	prune_refs(cbdata.ref_to_prune);
+	return 0;
+}
+
 static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 {
 	int *fd = cb_data;
diff --git a/refs.h b/refs.h
index ac0ff92..8060ed8 100644
--- a/refs.h
+++ b/refs.h
@@ -72,6 +72,20 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
  */
 extern void add_packed_ref(const char *refname, const unsigned char *sha1);
 
+/*
+ * Flags for controlling behaviour of pack_refs()
+ * PACK_REFS_PRUNE: Prune loose refs after packing
+ * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
+ */
+#define PACK_REFS_PRUNE 0x0001
+#define PACK_REFS_ALL   0x0002
+
+/*
+ * Write a packed-refs file for the current repository.
+ * flags: Combination of the above PACK_REFS_* flags.
+ */
+int pack_refs(unsigned int flags);
+
 extern int ref_exists(const char *);
 
 /*
-- 
1.8.2.1
