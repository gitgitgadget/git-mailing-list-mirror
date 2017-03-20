Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360782095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755813AbdCTQhm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:37:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60962 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755585AbdCTQeG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:06 -0400
X-AuditID: 12074414-807ff70000002bfd-24-58d0046ea8eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 33.96.11261.E6400D85; Mon, 20 Mar 2017 12:33:50 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9J010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/20] refs: split `ref_cache` code into separate files
Date:   Mon, 20 Mar 2017 17:33:14 +0100
Message-Id: <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqJvPciHCYP88VouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6M3Vs3sxdcncJcceX0CZYGxuaDTF2MnBwSAiYSvzduYu9i5OIQEtjB
        JHHjNoxzikni5NL7YFVsAroSi3qawWwRATWJiW2HWECKmAUeMUpcnX+XHSQhLOAuMfXLTmYQ
        m0VAVeLSumcsIDavQJTE9t37WCDWyUvsarvICmJzClhIfLnfCBYXEjCX6FzQyz6BkWcBI8Mq
        RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJCgEtnBeOSk3CFGAQ5GJR7eFVfO
        RwixJpYVV+YeYpTkYFIS5X16GyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLfqJVCONyWxsiq1
        KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCdwHDhQghwaLU9NSKtMycEoQ0Ewcn
        yHAeoOFzQGp4iwsSc4sz0yHypxgVpcR5CxiBEgIgiYzSPLheWNS/YhQHekWYN+8/0G08wIQB
        1/0KaDAT0OBlN86ADC5JREhJNTBWTXEo3BQ7p+TfdPvbE51ffZNWj5jBuWfR98c61hVfjQw/
        Wfv07QwzU6jeYTonYM2M7w8+7f2fxXF7achFydJw+R8J/o53557U16+LmOHSvevMfq6jbaeP
        HVifo/VqkuzP51t/r2jf+FtY/Duvc3eElLzAO5PbjAesIljnB/3en5owq9rncc8yJZbijERD
        Leai4kQAcFHF+dUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `ref_cache` code is currently too tightly coupled to
`files-backend`, making the code harder to understand and making it
awkward for new code to use `ref_cache` (as we indeed have planned).
Start loosening that coupling by splitting `ref_cache` into a separate
module.

This commit moves code, adds declarations, and changes the visibility
of some functions, but doesn't change any code.

The modules are still too tightly coupled, but the situation will be
improved in subsequent commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile             |   1 +
 refs/files-backend.c | 736 +--------------------------------------------------
 refs/ref-cache.c     | 512 +++++++++++++++++++++++++++++++++++
 refs/ref-cache.h     | 251 ++++++++++++++++++
 4 files changed, 767 insertions(+), 733 deletions(-)
 create mode 100644 refs/ref-cache.c
 create mode 100644 refs/ref-cache.h

diff --git a/Makefile b/Makefile
index 5f3844e33e..2f30580cde 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
+LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4c11afadf..f07e93d522 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #include "../cache.h"
 #include "../refs.h"
 #include "refs-internal.h"
+#include "ref-cache.h"
 #include "../iterator.h"
 #include "../dir-iterator.h"
 #include "../lockfile.h"
@@ -13,509 +14,6 @@ struct ref_lock {
 	struct object_id old_oid;
 };
 
-struct ref_entry;
-
-/*
- * Information used (along with the information in ref_entry) to
- * describe a single cached reference.  This data structure only
- * occurs embedded in a union in struct ref_entry, and only when
- * (ref_entry->flag & REF_DIR) is zero.
- */
-struct ref_value {
-	/*
-	 * The name of the object to which this reference resolves
-	 * (which may be a tag object).  If REF_ISBROKEN, this is
-	 * null.  If REF_ISSYMREF, then this is the name of the object
-	 * referred to by the last reference in the symlink chain.
-	 */
-	struct object_id oid;
-
-	/*
-	 * If REF_KNOWS_PEELED, then this field holds the peeled value
-	 * of this reference, or null if the reference is known not to
-	 * be peelable.  See the documentation for peel_ref() for an
-	 * exact definition of "peelable".
-	 */
-	struct object_id peeled;
-};
-
-struct files_ref_store;
-
-/*
- * Information used (along with the information in ref_entry) to
- * describe a level in the hierarchy of references.  This data
- * structure only occurs embedded in a union in struct ref_entry, and
- * only when (ref_entry.flag & REF_DIR) is set.  In that case,
- * (ref_entry.flag & REF_INCOMPLETE) determines whether the references
- * in the directory have already been read:
- *
- *     (ref_entry.flag & REF_INCOMPLETE) unset -- a directory of loose
- *         or packed references, already read.
- *
- *     (ref_entry.flag & REF_INCOMPLETE) set -- a directory of loose
- *         references that hasn't been read yet (nor has any of its
- *         subdirectories).
- *
- * Entries within a directory are stored within a growable array of
- * pointers to ref_entries (entries, nr, alloc).  Entries 0 <= i <
- * sorted are sorted by their component name in strcmp() order and the
- * remaining entries are unsorted.
- *
- * Loose references are read lazily, one directory at a time.  When a
- * directory of loose references is read, then all of the references
- * in that directory are stored, and REF_INCOMPLETE stubs are created
- * for any subdirectories, but the subdirectories themselves are not
- * read.  The reading is triggered by get_ref_dir().
- */
-struct ref_dir {
-	int nr, alloc;
-
-	/*
-	 * Entries with index 0 <= i < sorted are sorted by name.  New
-	 * entries are appended to the list unsorted, and are sorted
-	 * only when required; thus we avoid the need to sort the list
-	 * after the addition of every reference.
-	 */
-	int sorted;
-
-	/* A pointer to the files_ref_store that contains this ref_dir. */
-	struct files_ref_store *ref_store;
-
-	struct ref_entry **entries;
-};
-
-/*
- * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
- * REF_ISPACKED=0x02, REF_ISBROKEN=0x04 and REF_BAD_NAME=0x08 are
- * public values; see refs.h.
- */
-
-/*
- * The field ref_entry->u.value.peeled of this value entry contains
- * the correct peeled value for the reference, which might be
- * null_sha1 if the reference is not a tag or if it is broken.
- */
-#define REF_KNOWS_PEELED 0x10
-
-/* ref_entry represents a directory of references */
-#define REF_DIR 0x20
-
-/*
- * Entry has not yet been read from disk (used only for REF_DIR
- * entries representing loose references)
- */
-#define REF_INCOMPLETE 0x40
-
-/*
- * A ref_entry represents either a reference or a "subdirectory" of
- * references.
- *
- * Each directory in the reference namespace is represented by a
- * ref_entry with (flags & REF_DIR) set and containing a subdir member
- * that holds the entries in that directory that have been read so
- * far.  If (flags & REF_INCOMPLETE) is set, then the directory and
- * its subdirectories haven't been read yet.  REF_INCOMPLETE is only
- * used for loose reference directories.
- *
- * References are represented by a ref_entry with (flags & REF_DIR)
- * unset and a value member that describes the reference's value.  The
- * flag member is at the ref_entry level, but it is also needed to
- * interpret the contents of the value field (in other words, a
- * ref_value object is not very much use without the enclosing
- * ref_entry).
- *
- * Reference names cannot end with slash and directories' names are
- * always stored with a trailing slash (except for the top-level
- * directory, which is always denoted by "").  This has two nice
- * consequences: (1) when the entries in each subdir are sorted
- * lexicographically by name (as they usually are), the references in
- * a whole tree can be generated in lexicographic order by traversing
- * the tree in left-to-right, depth-first order; (2) the names of
- * references and subdirectories cannot conflict, and therefore the
- * presence of an empty subdirectory does not block the creation of a
- * similarly-named reference.  (The fact that reference names with the
- * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available().)
- *
- * Please note that the name field contains the fully-qualified
- * reference (or subdirectory) name.  Space could be saved by only
- * storing the relative names.  But that would require the full names
- * to be generated on the fly when iterating in do_for_each_ref(), and
- * would break callback functions, who have always been able to assume
- * that the name strings that they are passed will not be freed during
- * the iteration.
- */
-struct ref_entry {
-	unsigned char flag; /* ISSYMREF? ISPACKED? */
-	union {
-		struct ref_value value; /* if not (flags&REF_DIR) */
-		struct ref_dir subdir; /* if (flags&REF_DIR) */
-	} u;
-	/*
-	 * The full name of the reference (e.g., "refs/heads/master")
-	 * or the full name of the directory with a trailing slash
-	 * (e.g., "refs/heads/"):
-	 */
-	char name[FLEX_ARRAY];
-};
-
-static void read_loose_refs(const char *dirname, struct ref_dir *dir);
-static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len);
-static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
-					  const char *dirname, size_t len,
-					  int incomplete);
-static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
-static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const unsigned char *old_sha1,
-			       const unsigned char *new_sha1, const char *msg,
-			       int flags, struct strbuf *err);
-
-static struct ref_dir *get_ref_dir(struct ref_entry *entry)
-{
-	struct ref_dir *dir;
-	assert(entry->flag & REF_DIR);
-	dir = &entry->u.subdir;
-	if (entry->flag & REF_INCOMPLETE) {
-		read_loose_refs(entry->name, dir);
-
-		/*
-		 * Manually add refs/bisect, which, being
-		 * per-worktree, might not appear in the directory
-		 * listing for refs/ in the main repo.
-		 */
-		if (!strcmp(entry->name, "refs/")) {
-			int pos = search_ref_dir(dir, "refs/bisect/", 12);
-			if (pos < 0) {
-				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->ref_store,
-							       "refs/bisect/",
-							       12, 1);
-				add_entry_to_dir(dir, child_entry);
-			}
-		}
-		entry->flag &= ~REF_INCOMPLETE;
-	}
-	return dir;
-}
-
-static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag,
-					  int check_name)
-{
-	struct ref_entry *ref;
-
-	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		die("Reference has invalid format: '%s'", refname);
-	FLEX_ALLOC_STR(ref, name, refname);
-	hashcpy(ref->u.value.oid.hash, sha1);
-	oidclr(&ref->u.value.peeled);
-	ref->flag = flag;
-	return ref;
-}
-
-static void clear_ref_dir(struct ref_dir *dir);
-
-static void free_ref_entry(struct ref_entry *entry)
-{
-	if (entry->flag & REF_DIR) {
-		/*
-		 * Do not use get_ref_dir() here, as that might
-		 * trigger the reading of loose refs.
-		 */
-		clear_ref_dir(&entry->u.subdir);
-	}
-	free(entry);
-}
-
-/*
- * Add a ref_entry to the end of dir (unsorted).  Entry is always
- * stored directly in dir; no recursion into subdirectories is
- * done.
- */
-static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
-{
-	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
-	dir->entries[dir->nr++] = entry;
-	/* optimize for the case that entries are added in order */
-	if (dir->nr == 1 ||
-	    (dir->nr == dir->sorted + 1 &&
-	     strcmp(dir->entries[dir->nr - 2]->name,
-		    dir->entries[dir->nr - 1]->name) < 0))
-		dir->sorted = dir->nr;
-}
-
-/*
- * Clear and free all entries in dir, recursively.
- */
-static void clear_ref_dir(struct ref_dir *dir)
-{
-	int i;
-	for (i = 0; i < dir->nr; i++)
-		free_ref_entry(dir->entries[i]);
-	free(dir->entries);
-	dir->sorted = dir->nr = dir->alloc = 0;
-	dir->entries = NULL;
-}
-
-/*
- * Create a struct ref_entry object for the specified dirname.
- * dirname is the name of the directory with a trailing slash (e.g.,
- * "refs/heads/") or "" for the top-level directory.
- */
-static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
-					  const char *dirname, size_t len,
-					  int incomplete)
-{
-	struct ref_entry *direntry;
-	FLEX_ALLOC_MEM(direntry, name, dirname, len);
-	direntry->u.subdir.ref_store = ref_store;
-	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
-	return direntry;
-}
-
-static int ref_entry_cmp(const void *a, const void *b)
-{
-	struct ref_entry *one = *(struct ref_entry **)a;
-	struct ref_entry *two = *(struct ref_entry **)b;
-	return strcmp(one->name, two->name);
-}
-
-static void sort_ref_dir(struct ref_dir *dir);
-
-struct string_slice {
-	size_t len;
-	const char *str;
-};
-
-static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
-{
-	const struct string_slice *key = key_;
-	const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
-	int cmp = strncmp(key->str, ent->name, key->len);
-	if (cmp)
-		return cmp;
-	return '\0' - (unsigned char)ent->name[key->len];
-}
-
-/*
- * Return the index of the entry with the given refname from the
- * ref_dir (non-recursively), sorting dir if necessary.  Return -1 if
- * no such entry is found.  dir must already be complete.
- */
-static int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len)
-{
-	struct ref_entry **r;
-	struct string_slice key;
-
-	if (refname == NULL || !dir->nr)
-		return -1;
-
-	sort_ref_dir(dir);
-	key.len = len;
-	key.str = refname;
-	r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
-		    ref_entry_cmp_sslice);
-
-	if (r == NULL)
-		return -1;
-
-	return r - dir->entries;
-}
-
-/*
- * Search for a directory entry directly within dir (without
- * recursing).  Sort dir if necessary.  subdirname must be a directory
- * name (i.e., end in '/').  If mkdir is set, then create the
- * directory if it is missing; otherwise, return NULL if the desired
- * directory cannot be found.  dir must already be complete.
- */
-static struct ref_dir *search_for_subdir(struct ref_dir *dir,
-					 const char *subdirname, size_t len,
-					 int mkdir)
-{
-	int entry_index = search_ref_dir(dir, subdirname, len);
-	struct ref_entry *entry;
-	if (entry_index == -1) {
-		if (!mkdir)
-			return NULL;
-		/*
-		 * Since dir is complete, the absence of a subdir
-		 * means that the subdir really doesn't exist;
-		 * therefore, create an empty record for it but mark
-		 * the record complete.
-		 */
-		entry = create_dir_entry(dir->ref_store, subdirname, len, 0);
-		add_entry_to_dir(dir, entry);
-	} else {
-		entry = dir->entries[entry_index];
-	}
-	return get_ref_dir(entry);
-}
-
-/*
- * If refname is a reference name, find the ref_dir within the dir
- * tree that should hold refname.  If refname is a directory name
- * (i.e., ends in '/'), then return that ref_dir itself.  dir must
- * represent the top-level directory and must already be complete.
- * Sort ref_dirs and recurse into subdirectories as necessary.  If
- * mkdir is set, then create any missing directories; otherwise,
- * return NULL if the desired directory cannot be found.
- */
-static struct ref_dir *find_containing_dir(struct ref_dir *dir,
-					   const char *refname, int mkdir)
-{
-	const char *slash;
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
-		size_t dirnamelen = slash - refname + 1;
-		struct ref_dir *subdir;
-		subdir = search_for_subdir(dir, refname, dirnamelen, mkdir);
-		if (!subdir) {
-			dir = NULL;
-			break;
-		}
-		dir = subdir;
-	}
-
-	return dir;
-}
-
-/*
- * Find the value entry with the given name in dir, sorting ref_dirs
- * and recursing into subdirectories as necessary.  If the name is not
- * found or it corresponds to a directory entry, return NULL.
- */
-static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
-{
-	int entry_index;
-	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname, 0);
-	if (!dir)
-		return NULL;
-	entry_index = search_ref_dir(dir, refname, strlen(refname));
-	if (entry_index == -1)
-		return NULL;
-	entry = dir->entries[entry_index];
-	return (entry->flag & REF_DIR) ? NULL : entry;
-}
-
-/*
- * Remove the entry with the given name from dir, recursing into
- * subdirectories as necessary.  If refname is the name of a directory
- * (i.e., ends with '/'), then remove the directory and its contents.
- * If the removal was successful, return the number of entries
- * remaining in the directory entry that contained the deleted entry.
- * If the name was not found, return -1.  Please note that this
- * function only deletes the entry from the cache; it does not delete
- * it from the filesystem or ensure that other cache entries (which
- * might be symbolic references to the removed entry) are updated.
- * Nor does it remove any containing dir entries that might be made
- * empty by the removal.  dir must represent the top-level directory
- * and must already be complete.
- */
-static int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
-{
-	int refname_len = strlen(refname);
-	int entry_index;
-	struct ref_entry *entry;
-	int is_dir = refname[refname_len - 1] == '/';
-	if (is_dir) {
-		/*
-		 * refname represents a reference directory.  Remove
-		 * the trailing slash; otherwise we will get the
-		 * directory *representing* refname rather than the
-		 * one *containing* it.
-		 */
-		char *dirname = xmemdupz(refname, refname_len - 1);
-		dir = find_containing_dir(dir, dirname, 0);
-		free(dirname);
-	} else {
-		dir = find_containing_dir(dir, refname, 0);
-	}
-	if (!dir)
-		return -1;
-	entry_index = search_ref_dir(dir, refname, refname_len);
-	if (entry_index == -1)
-		return -1;
-	entry = dir->entries[entry_index];
-
-	memmove(&dir->entries[entry_index],
-		&dir->entries[entry_index + 1],
-		(dir->nr - entry_index - 1) * sizeof(*dir->entries)
-		);
-	dir->nr--;
-	if (dir->sorted > entry_index)
-		dir->sorted--;
-	free_ref_entry(entry);
-	return dir->nr;
-}
-
-/*
- * Add a ref_entry to the ref_dir (unsorted), recursing into
- * subdirectories as necessary.  dir must represent the top-level
- * directory.  Return 0 on success.
- */
-static int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
-{
-	dir = find_containing_dir(dir, ref->name, 1);
-	if (!dir)
-		return -1;
-	add_entry_to_dir(dir, ref);
-	return 0;
-}
-
-/*
- * Emit a warning and return true iff ref1 and ref2 have the same name
- * and the same sha1.  Die if they have the same name but different
- * sha1s.
- */
-static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
-{
-	if (strcmp(ref1->name, ref2->name))
-		return 0;
-
-	/* Duplicate name; make sure that they don't conflict: */
-
-	if ((ref1->flag & REF_DIR) || (ref2->flag & REF_DIR))
-		/* This is impossible by construction */
-		die("Reference directory conflict: %s", ref1->name);
-
-	if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
-		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
-
-	warning("Duplicated ref: %s", ref1->name);
-	return 1;
-}
-
-/*
- * Sort the entries in dir non-recursively (if they are not already
- * sorted) and remove any duplicate entries.
- */
-static void sort_ref_dir(struct ref_dir *dir)
-{
-	int i, j;
-	struct ref_entry *last = NULL;
-
-	/*
-	 * This check also prevents passing a zero-length array to qsort(),
-	 * which is a problem on some platforms.
-	 */
-	if (dir->sorted == dir->nr)
-		return;
-
-	QSORT(dir->entries, dir->nr, ref_entry_cmp);
-
-	/* Remove any duplicates: */
-	for (i = 0, j = 0; j < dir->nr; j++) {
-		struct ref_entry *entry = dir->entries[j];
-		if (last && is_dup_ref(last, entry))
-			free_ref_entry(entry);
-		else
-			last = dir->entries[i++] = entry;
-	}
-	dir->sorted = dir->nr = i;
-}
-
 /*
  * Return true if refname, which has the specified oid and flags, can
  * be resolved to an object in the database. If the referred-to object
@@ -545,199 +43,6 @@ static int entry_resolves_to_object(struct ref_entry *entry)
 				      &entry->u.value.oid, entry->flag);
 }
 
-typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
-
-/*
- * Call fn for each reference in dir that has index in the range
- * offset <= index < dir->nr.  Recurse into subdirectories that are in
- * that index range, sorting them before iterating.  This function
- * does not sort dir itself; it should be sorted beforehand.  fn is
- * called for all references, including broken ones.
- */
-static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
-				    each_ref_entry_fn fn, void *cb_data)
-{
-	int i;
-	assert(dir->sorted == dir->nr);
-	for (i = offset; i < dir->nr; i++) {
-		struct ref_entry *entry = dir->entries[i];
-		int retval;
-		if (entry->flag & REF_DIR) {
-			struct ref_dir *subdir = get_ref_dir(entry);
-			sort_ref_dir(subdir);
-			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
-		} else {
-			retval = fn(entry, cb_data);
-		}
-		if (retval)
-			return retval;
-	}
-	return 0;
-}
-
-/*
- * Load all of the refs from the dir into our in-memory cache. The hard work
- * of loading loose refs is done by get_ref_dir(), so we just need to recurse
- * through all of the sub-directories. We do not even need to care about
- * sorting, as traversal order does not matter to us.
- */
-static void prime_ref_dir(struct ref_dir *dir)
-{
-	int i;
-	for (i = 0; i < dir->nr; i++) {
-		struct ref_entry *entry = dir->entries[i];
-		if (entry->flag & REF_DIR)
-			prime_ref_dir(get_ref_dir(entry));
-	}
-}
-
-/*
- * A level in the reference hierarchy that is currently being iterated
- * through.
- */
-struct cache_ref_iterator_level {
-	/*
-	 * The ref_dir being iterated over at this level. The ref_dir
-	 * is sorted before being stored here.
-	 */
-	struct ref_dir *dir;
-
-	/*
-	 * The index of the current entry within dir (which might
-	 * itself be a directory). If index == -1, then the iteration
-	 * hasn't yet begun. If index == dir->nr, then the iteration
-	 * through this level is over.
-	 */
-	int index;
-};
-
-/*
- * Represent an iteration through a ref_dir in the memory cache. The
- * iteration recurses through subdirectories.
- */
-struct cache_ref_iterator {
-	struct ref_iterator base;
-
-	/*
-	 * The number of levels currently on the stack. This is always
-	 * at least 1, because when it becomes zero the iteration is
-	 * ended and this struct is freed.
-	 */
-	size_t levels_nr;
-
-	/* The number of levels that have been allocated on the stack */
-	size_t levels_alloc;
-
-	/*
-	 * A stack of levels. levels[0] is the uppermost level that is
-	 * being iterated over in this iteration. (This is not
-	 * necessary the top level in the references hierarchy. If we
-	 * are iterating through a subtree, then levels[0] will hold
-	 * the ref_dir for that subtree, and subsequent levels will go
-	 * on from there.)
-	 */
-	struct cache_ref_iterator_level *levels;
-};
-
-static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
-{
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
-
-	while (1) {
-		struct cache_ref_iterator_level *level =
-			&iter->levels[iter->levels_nr - 1];
-		struct ref_dir *dir = level->dir;
-		struct ref_entry *entry;
-
-		if (level->index == -1)
-			sort_ref_dir(dir);
-
-		if (++level->index == level->dir->nr) {
-			/* This level is exhausted; pop up a level */
-			if (--iter->levels_nr == 0)
-				return ref_iterator_abort(ref_iterator);
-
-			continue;
-		}
-
-		entry = dir->entries[level->index];
-
-		if (entry->flag & REF_DIR) {
-			/* push down a level */
-			ALLOC_GROW(iter->levels, iter->levels_nr + 1,
-				   iter->levels_alloc);
-
-			level = &iter->levels[iter->levels_nr++];
-			level->dir = get_ref_dir(entry);
-			level->index = -1;
-		} else {
-			iter->base.refname = entry->name;
-			iter->base.oid = &entry->u.value.oid;
-			iter->base.flags = entry->flag;
-			return ITER_OK;
-		}
-	}
-}
-
-static enum peel_status peel_entry(struct ref_entry *entry, int repeel);
-
-static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
-	struct cache_ref_iterator_level *level;
-	struct ref_entry *entry;
-
-	level = &iter->levels[iter->levels_nr - 1];
-
-	if (level->index == -1)
-		die("BUG: peel called before advance for cache iterator");
-
-	entry = level->dir->entries[level->index];
-
-	if (peel_entry(entry, 0))
-		return -1;
-	oidcpy(peeled, &entry->u.value.peeled);
-	return 0;
-}
-
-static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
-{
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
-
-	free(iter->levels);
-	base_ref_iterator_free(ref_iterator);
-	return ITER_DONE;
-}
-
-static struct ref_iterator_vtable cache_ref_iterator_vtable = {
-	cache_ref_iterator_advance,
-	cache_ref_iterator_peel,
-	cache_ref_iterator_abort
-};
-
-static struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
-{
-	struct cache_ref_iterator *iter;
-	struct ref_iterator *ref_iterator;
-	struct cache_ref_iterator_level *level;
-
-	iter = xcalloc(1, sizeof(*iter));
-	ref_iterator = &iter->base;
-	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
-	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
-
-	iter->levels_nr = 1;
-	level = &iter->levels[0];
-	level->index = -1;
-	level->dir = dir;
-
-	return ref_iterator;
-}
-
 struct packed_ref_cache {
 	struct ref_entry *root;
 
@@ -1117,7 +422,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
-		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+		      create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
 /*
@@ -1125,7 +430,7 @@ static void add_packed_ref(struct files_ref_store *refs,
  * (without recursing).  dirname must end with '/'.  dir must be the
  * directory entry corresponding to dirname.
  */
-static void read_loose_refs(const char *dirname, struct ref_dir *dir)
+void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
 	struct files_ref_store *refs = dir->ref_store;
 	DIR *d;
@@ -1635,41 +940,6 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	return ret;
 }
 
-/*
- * Peel the entry (if possible) and return its new peel_status.  If
- * repeel is true, re-peel the entry even if there is an old peeled
- * value that is already stored in it.
- *
- * It is OK to call this function with a packed reference entry that
- * might be stale and might even refer to an object that has since
- * been garbage-collected.  In such a case, if the entry has
- * REF_KNOWS_PEELED then leave the status unchanged and return
- * PEEL_PEELED or PEEL_NON_TAG; otherwise, return PEEL_INVALID.
- */
-static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
-{
-	enum peel_status status;
-
-	if (entry->flag & REF_KNOWS_PEELED) {
-		if (repeel) {
-			entry->flag &= ~REF_KNOWS_PEELED;
-			oidclr(&entry->u.value.peeled);
-		} else {
-			return is_null_oid(&entry->u.value.peeled) ?
-				PEEL_NON_TAG : PEEL_PEELED;
-		}
-	}
-	if (entry->flag & REF_ISBROKEN)
-		return PEEL_BROKEN;
-	if (entry->flag & REF_ISSYMREF)
-		return PEEL_IS_SYMREF;
-
-	status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
-	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
-		entry->flag |= REF_KNOWS_PEELED;
-	return status;
-}
-
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
new file mode 100644
index 0000000000..4274a43a9b
--- /dev/null
+++ b/refs/ref-cache.c
@@ -0,0 +1,512 @@
+#include "../cache.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "ref-cache.h"
+#include "../iterator.h"
+
+/* FIXME: This declaration shouldn't be here */
+void read_loose_refs(const char *dirname, struct ref_dir *dir);
+
+void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
+{
+	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
+	dir->entries[dir->nr++] = entry;
+	/* optimize for the case that entries are added in order */
+	if (dir->nr == 1 ||
+	    (dir->nr == dir->sorted + 1 &&
+	     strcmp(dir->entries[dir->nr - 2]->name,
+		    dir->entries[dir->nr - 1]->name) < 0))
+		dir->sorted = dir->nr;
+}
+
+struct ref_dir *get_ref_dir(struct ref_entry *entry)
+{
+	struct ref_dir *dir;
+	assert(entry->flag & REF_DIR);
+	dir = &entry->u.subdir;
+	if (entry->flag & REF_INCOMPLETE) {
+		read_loose_refs(entry->name, dir);
+
+		/*
+		 * Manually add refs/bisect, which, being
+		 * per-worktree, might not appear in the directory
+		 * listing for refs/ in the main repo.
+		 */
+		if (!strcmp(entry->name, "refs/")) {
+			int pos = search_ref_dir(dir, "refs/bisect/", 12);
+			if (pos < 0) {
+				struct ref_entry *child_entry;
+				child_entry = create_dir_entry(dir->ref_store,
+							       "refs/bisect/",
+							       12, 1);
+				add_entry_to_dir(dir, child_entry);
+			}
+		}
+		entry->flag &= ~REF_INCOMPLETE;
+	}
+	return dir;
+}
+
+struct ref_entry *create_ref_entry(const char *refname,
+				   const unsigned char *sha1, int flag,
+				   int check_name)
+{
+	struct ref_entry *ref;
+
+	if (check_name &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		die("Reference has invalid format: '%s'", refname);
+	FLEX_ALLOC_STR(ref, name, refname);
+	hashcpy(ref->u.value.oid.hash, sha1);
+	oidclr(&ref->u.value.peeled);
+	ref->flag = flag;
+	return ref;
+}
+
+static void clear_ref_dir(struct ref_dir *dir);
+
+void free_ref_entry(struct ref_entry *entry)
+{
+	if (entry->flag & REF_DIR) {
+		/*
+		 * Do not use get_ref_dir() here, as that might
+		 * trigger the reading of loose refs.
+		 */
+		clear_ref_dir(&entry->u.subdir);
+	}
+	free(entry);
+}
+
+/*
+ * Clear and free all entries in dir, recursively.
+ */
+static void clear_ref_dir(struct ref_dir *dir)
+{
+	int i;
+	for (i = 0; i < dir->nr; i++)
+		free_ref_entry(dir->entries[i]);
+	free(dir->entries);
+	dir->sorted = dir->nr = dir->alloc = 0;
+	dir->entries = NULL;
+}
+
+struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+				   const char *dirname, size_t len,
+				   int incomplete)
+{
+	struct ref_entry *direntry;
+	FLEX_ALLOC_MEM(direntry, name, dirname, len);
+	direntry->u.subdir.ref_store = ref_store;
+	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
+	return direntry;
+}
+
+static int ref_entry_cmp(const void *a, const void *b)
+{
+	struct ref_entry *one = *(struct ref_entry **)a;
+	struct ref_entry *two = *(struct ref_entry **)b;
+	return strcmp(one->name, two->name);
+}
+
+static void sort_ref_dir(struct ref_dir *dir);
+
+struct string_slice {
+	size_t len;
+	const char *str;
+};
+
+static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
+{
+	const struct string_slice *key = key_;
+	const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
+	int cmp = strncmp(key->str, ent->name, key->len);
+	if (cmp)
+		return cmp;
+	return '\0' - (unsigned char)ent->name[key->len];
+}
+
+int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len)
+{
+	struct ref_entry **r;
+	struct string_slice key;
+
+	if (refname == NULL || !dir->nr)
+		return -1;
+
+	sort_ref_dir(dir);
+	key.len = len;
+	key.str = refname;
+	r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
+		    ref_entry_cmp_sslice);
+
+	if (r == NULL)
+		return -1;
+
+	return r - dir->entries;
+}
+
+/*
+ * Search for a directory entry directly within dir (without
+ * recursing).  Sort dir if necessary.  subdirname must be a directory
+ * name (i.e., end in '/').  If mkdir is set, then create the
+ * directory if it is missing; otherwise, return NULL if the desired
+ * directory cannot be found.  dir must already be complete.
+ */
+static struct ref_dir *search_for_subdir(struct ref_dir *dir,
+					 const char *subdirname, size_t len,
+					 int mkdir)
+{
+	int entry_index = search_ref_dir(dir, subdirname, len);
+	struct ref_entry *entry;
+	if (entry_index == -1) {
+		if (!mkdir)
+			return NULL;
+		/*
+		 * Since dir is complete, the absence of a subdir
+		 * means that the subdir really doesn't exist;
+		 * therefore, create an empty record for it but mark
+		 * the record complete.
+		 */
+		entry = create_dir_entry(dir->ref_store, subdirname, len, 0);
+		add_entry_to_dir(dir, entry);
+	} else {
+		entry = dir->entries[entry_index];
+	}
+	return get_ref_dir(entry);
+}
+
+struct ref_dir *find_containing_dir(struct ref_dir *dir,
+				    const char *refname, int mkdir)
+{
+	const char *slash;
+	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		size_t dirnamelen = slash - refname + 1;
+		struct ref_dir *subdir;
+		subdir = search_for_subdir(dir, refname, dirnamelen, mkdir);
+		if (!subdir) {
+			dir = NULL;
+			break;
+		}
+		dir = subdir;
+	}
+
+	return dir;
+}
+
+struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
+{
+	int entry_index;
+	struct ref_entry *entry;
+	dir = find_containing_dir(dir, refname, 0);
+	if (!dir)
+		return NULL;
+	entry_index = search_ref_dir(dir, refname, strlen(refname));
+	if (entry_index == -1)
+		return NULL;
+	entry = dir->entries[entry_index];
+	return (entry->flag & REF_DIR) ? NULL : entry;
+}
+
+int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
+{
+	int refname_len = strlen(refname);
+	int entry_index;
+	struct ref_entry *entry;
+	int is_dir = refname[refname_len - 1] == '/';
+	if (is_dir) {
+		/*
+		 * refname represents a reference directory.  Remove
+		 * the trailing slash; otherwise we will get the
+		 * directory *representing* refname rather than the
+		 * one *containing* it.
+		 */
+		char *dirname = xmemdupz(refname, refname_len - 1);
+		dir = find_containing_dir(dir, dirname, 0);
+		free(dirname);
+	} else {
+		dir = find_containing_dir(dir, refname, 0);
+	}
+	if (!dir)
+		return -1;
+	entry_index = search_ref_dir(dir, refname, refname_len);
+	if (entry_index == -1)
+		return -1;
+	entry = dir->entries[entry_index];
+
+	memmove(&dir->entries[entry_index],
+		&dir->entries[entry_index + 1],
+		(dir->nr - entry_index - 1) * sizeof(*dir->entries)
+		);
+	dir->nr--;
+	if (dir->sorted > entry_index)
+		dir->sorted--;
+	free_ref_entry(entry);
+	return dir->nr;
+}
+
+int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
+{
+	dir = find_containing_dir(dir, ref->name, 1);
+	if (!dir)
+		return -1;
+	add_entry_to_dir(dir, ref);
+	return 0;
+}
+
+/*
+ * Emit a warning and return true iff ref1 and ref2 have the same name
+ * and the same sha1.  Die if they have the same name but different
+ * sha1s.
+ */
+static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
+{
+	if (strcmp(ref1->name, ref2->name))
+		return 0;
+
+	/* Duplicate name; make sure that they don't conflict: */
+
+	if ((ref1->flag & REF_DIR) || (ref2->flag & REF_DIR))
+		/* This is impossible by construction */
+		die("Reference directory conflict: %s", ref1->name);
+
+	if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
+		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
+
+	warning("Duplicated ref: %s", ref1->name);
+	return 1;
+}
+
+/*
+ * Sort the entries in dir non-recursively (if they are not already
+ * sorted) and remove any duplicate entries.
+ */
+static void sort_ref_dir(struct ref_dir *dir)
+{
+	int i, j;
+	struct ref_entry *last = NULL;
+
+	/*
+	 * This check also prevents passing a zero-length array to qsort(),
+	 * which is a problem on some platforms.
+	 */
+	if (dir->sorted == dir->nr)
+		return;
+
+	QSORT(dir->entries, dir->nr, ref_entry_cmp);
+
+	/* Remove any duplicates: */
+	for (i = 0, j = 0; j < dir->nr; j++) {
+		struct ref_entry *entry = dir->entries[j];
+		if (last && is_dup_ref(last, entry))
+			free_ref_entry(entry);
+		else
+			last = dir->entries[i++] = entry;
+	}
+	dir->sorted = dir->nr = i;
+}
+
+int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+			     each_ref_entry_fn fn, void *cb_data)
+{
+	int i;
+	assert(dir->sorted == dir->nr);
+	for (i = offset; i < dir->nr; i++) {
+		struct ref_entry *entry = dir->entries[i];
+		int retval;
+		if (entry->flag & REF_DIR) {
+			struct ref_dir *subdir = get_ref_dir(entry);
+			sort_ref_dir(subdir);
+			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
+		} else {
+			retval = fn(entry, cb_data);
+		}
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
+void prime_ref_dir(struct ref_dir *dir)
+{
+	/*
+	 * The hard work of loading loose refs is done by get_ref_dir(), so we
+	 * just need to recurse through all of the sub-directories. We do not
+	 * even need to care about sorting, as traversal order does not matter
+	 * to us.
+	 */
+	int i;
+	for (i = 0; i < dir->nr; i++) {
+		struct ref_entry *entry = dir->entries[i];
+		if (entry->flag & REF_DIR)
+			prime_ref_dir(get_ref_dir(entry));
+	}
+}
+
+/*
+ * A level in the reference hierarchy that is currently being iterated
+ * through.
+ */
+struct cache_ref_iterator_level {
+	/*
+	 * The ref_dir being iterated over at this level. The ref_dir
+	 * is sorted before being stored here.
+	 */
+	struct ref_dir *dir;
+
+	/*
+	 * The index of the current entry within dir (which might
+	 * itself be a directory). If index == -1, then the iteration
+	 * hasn't yet begun. If index == dir->nr, then the iteration
+	 * through this level is over.
+	 */
+	int index;
+};
+
+/*
+ * Represent an iteration through a ref_dir in the memory cache. The
+ * iteration recurses through subdirectories.
+ */
+struct cache_ref_iterator {
+	struct ref_iterator base;
+
+	/*
+	 * The number of levels currently on the stack. This is always
+	 * at least 1, because when it becomes zero the iteration is
+	 * ended and this struct is freed.
+	 */
+	size_t levels_nr;
+
+	/* The number of levels that have been allocated on the stack */
+	size_t levels_alloc;
+
+	/*
+	 * A stack of levels. levels[0] is the uppermost level that is
+	 * being iterated over in this iteration. (This is not
+	 * necessary the top level in the references hierarchy. If we
+	 * are iterating through a subtree, then levels[0] will hold
+	 * the ref_dir for that subtree, and subsequent levels will go
+	 * on from there.)
+	 */
+	struct cache_ref_iterator_level *levels;
+};
+
+static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	while (1) {
+		struct cache_ref_iterator_level *level =
+			&iter->levels[iter->levels_nr - 1];
+		struct ref_dir *dir = level->dir;
+		struct ref_entry *entry;
+
+		if (level->index == -1)
+			sort_ref_dir(dir);
+
+		if (++level->index == level->dir->nr) {
+			/* This level is exhausted; pop up a level */
+			if (--iter->levels_nr == 0)
+				return ref_iterator_abort(ref_iterator);
+
+			continue;
+		}
+
+		entry = dir->entries[level->index];
+
+		if (entry->flag & REF_DIR) {
+			/* push down a level */
+			ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+				   iter->levels_alloc);
+
+			level = &iter->levels[iter->levels_nr++];
+			level->dir = get_ref_dir(entry);
+			level->index = -1;
+		} else {
+			iter->base.refname = entry->name;
+			iter->base.oid = &entry->u.value.oid;
+			iter->base.flags = entry->flag;
+			return ITER_OK;
+		}
+	}
+}
+
+enum peel_status peel_entry(struct ref_entry *entry, int repeel)
+{
+	enum peel_status status;
+
+	if (entry->flag & REF_KNOWS_PEELED) {
+		if (repeel) {
+			entry->flag &= ~REF_KNOWS_PEELED;
+			oidclr(&entry->u.value.peeled);
+		} else {
+			return is_null_oid(&entry->u.value.peeled) ?
+				PEEL_NON_TAG : PEEL_PEELED;
+		}
+	}
+	if (entry->flag & REF_ISBROKEN)
+		return PEEL_BROKEN;
+	if (entry->flag & REF_ISSYMREF)
+		return PEEL_IS_SYMREF;
+
+	status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
+	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
+		entry->flag |= REF_KNOWS_PEELED;
+	return status;
+}
+
+static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+	struct cache_ref_iterator_level *level;
+	struct ref_entry *entry;
+
+	level = &iter->levels[iter->levels_nr - 1];
+
+	if (level->index == -1)
+		die("BUG: peel called before advance for cache iterator");
+
+	entry = level->dir->entries[level->index];
+
+	if (peel_entry(entry, 0))
+		return -1;
+	oidcpy(peeled, &entry->u.value.peeled);
+	return 0;
+}
+
+static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	free(iter->levels);
+	base_ref_iterator_free(ref_iterator);
+	return ITER_DONE;
+}
+
+static struct ref_iterator_vtable cache_ref_iterator_vtable = {
+	cache_ref_iterator_advance,
+	cache_ref_iterator_peel,
+	cache_ref_iterator_abort
+};
+
+struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
+{
+	struct cache_ref_iterator *iter;
+	struct ref_iterator *ref_iterator;
+	struct cache_ref_iterator_level *level;
+
+	iter = xcalloc(1, sizeof(*iter));
+	ref_iterator = &iter->base;
+	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
+	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
+
+	iter->levels_nr = 1;
+	level = &iter->levels[0];
+	level->index = -1;
+	level->dir = dir;
+
+	return ref_iterator;
+}
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
new file mode 100644
index 0000000000..2e7b1a366e
--- /dev/null
+++ b/refs/ref-cache.h
@@ -0,0 +1,251 @@
+#ifndef REFS_REF_CACHE_H
+#define REFS_REF_CACHE_H
+
+/*
+ * Information used (along with the information in ref_entry) to
+ * describe a single cached reference.  This data structure only
+ * occurs embedded in a union in struct ref_entry, and only when
+ * (ref_entry->flag & REF_DIR) is zero.
+ */
+struct ref_value {
+	/*
+	 * The name of the object to which this reference resolves
+	 * (which may be a tag object).  If REF_ISBROKEN, this is
+	 * null.  If REF_ISSYMREF, then this is the name of the object
+	 * referred to by the last reference in the symlink chain.
+	 */
+	struct object_id oid;
+
+	/*
+	 * If REF_KNOWS_PEELED, then this field holds the peeled value
+	 * of this reference, or null if the reference is known not to
+	 * be peelable.  See the documentation for peel_ref() for an
+	 * exact definition of "peelable".
+	 */
+	struct object_id peeled;
+};
+
+/*
+ * Information used (along with the information in ref_entry) to
+ * describe a level in the hierarchy of references.  This data
+ * structure only occurs embedded in a union in struct ref_entry, and
+ * only when (ref_entry.flag & REF_DIR) is set.  In that case,
+ * (ref_entry.flag & REF_INCOMPLETE) determines whether the references
+ * in the directory have already been read:
+ *
+ *     (ref_entry.flag & REF_INCOMPLETE) unset -- a directory of loose
+ *         or packed references, already read.
+ *
+ *     (ref_entry.flag & REF_INCOMPLETE) set -- a directory of loose
+ *         references that hasn't been read yet (nor has any of its
+ *         subdirectories).
+ *
+ * Entries within a directory are stored within a growable array of
+ * pointers to ref_entries (entries, nr, alloc).  Entries 0 <= i <
+ * sorted are sorted by their component name in strcmp() order and the
+ * remaining entries are unsorted.
+ *
+ * Loose references are read lazily, one directory at a time.  When a
+ * directory of loose references is read, then all of the references
+ * in that directory are stored, and REF_INCOMPLETE stubs are created
+ * for any subdirectories, but the subdirectories themselves are not
+ * read.  The reading is triggered by get_ref_dir().
+ */
+struct ref_dir {
+	int nr, alloc;
+
+	/*
+	 * Entries with index 0 <= i < sorted are sorted by name.  New
+	 * entries are appended to the list unsorted, and are sorted
+	 * only when required; thus we avoid the need to sort the list
+	 * after the addition of every reference.
+	 */
+	int sorted;
+
+	/* A pointer to the files_ref_store that contains this ref_dir. */
+	struct files_ref_store *ref_store;
+
+	struct ref_entry **entries;
+};
+
+/*
+ * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
+ * REF_ISPACKED=0x02, REF_ISBROKEN=0x04 and REF_BAD_NAME=0x08 are
+ * public values; see refs.h.
+ */
+
+/*
+ * The field ref_entry->u.value.peeled of this value entry contains
+ * the correct peeled value for the reference, which might be
+ * null_sha1 if the reference is not a tag or if it is broken.
+ */
+#define REF_KNOWS_PEELED 0x10
+
+/* ref_entry represents a directory of references */
+#define REF_DIR 0x20
+
+/*
+ * Entry has not yet been read from disk (used only for REF_DIR
+ * entries representing loose references)
+ */
+#define REF_INCOMPLETE 0x40
+
+/*
+ * A ref_entry represents either a reference or a "subdirectory" of
+ * references.
+ *
+ * Each directory in the reference namespace is represented by a
+ * ref_entry with (flags & REF_DIR) set and containing a subdir member
+ * that holds the entries in that directory that have been read so
+ * far.  If (flags & REF_INCOMPLETE) is set, then the directory and
+ * its subdirectories haven't been read yet.  REF_INCOMPLETE is only
+ * used for loose reference directories.
+ *
+ * References are represented by a ref_entry with (flags & REF_DIR)
+ * unset and a value member that describes the reference's value.  The
+ * flag member is at the ref_entry level, but it is also needed to
+ * interpret the contents of the value field (in other words, a
+ * ref_value object is not very much use without the enclosing
+ * ref_entry).
+ *
+ * Reference names cannot end with slash and directories' names are
+ * always stored with a trailing slash (except for the top-level
+ * directory, which is always denoted by "").  This has two nice
+ * consequences: (1) when the entries in each subdir are sorted
+ * lexicographically by name (as they usually are), the references in
+ * a whole tree can be generated in lexicographic order by traversing
+ * the tree in left-to-right, depth-first order; (2) the names of
+ * references and subdirectories cannot conflict, and therefore the
+ * presence of an empty subdirectory does not block the creation of a
+ * similarly-named reference.  (The fact that reference names with the
+ * same leading components can conflict *with each other* is a
+ * separate issue that is regulated by refs_verify_refname_available().)
+ *
+ * Please note that the name field contains the fully-qualified
+ * reference (or subdirectory) name.  Space could be saved by only
+ * storing the relative names.  But that would require the full names
+ * to be generated on the fly when iterating in do_for_each_ref(), and
+ * would break callback functions, who have always been able to assume
+ * that the name strings that they are passed will not be freed during
+ * the iteration.
+ */
+struct ref_entry {
+	unsigned char flag; /* ISSYMREF? ISPACKED? */
+	union {
+		struct ref_value value; /* if not (flags&REF_DIR) */
+		struct ref_dir subdir; /* if (flags&REF_DIR) */
+	} u;
+	/*
+	 * The full name of the reference (e.g., "refs/heads/master")
+	 * or the full name of the directory with a trailing slash
+	 * (e.g., "refs/heads/"):
+	 */
+	char name[FLEX_ARRAY];
+};
+
+/*
+ * Return the index of the entry with the given refname from the
+ * ref_dir (non-recursively), sorting dir if necessary.  Return -1 if
+ * no such entry is found.  dir must already be complete.
+ */
+int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len);
+
+struct ref_dir *get_ref_dir(struct ref_entry *entry);
+
+/*
+ * Create a struct ref_entry object for the specified dirname.
+ * dirname is the name of the directory with a trailing slash (e.g.,
+ * "refs/heads/") or "" for the top-level directory.
+ */
+struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+				   const char *dirname, size_t len,
+				   int incomplete);
+
+struct ref_entry *create_ref_entry(const char *refname,
+				   const unsigned char *sha1, int flag,
+				   int check_name);
+
+void free_ref_entry(struct ref_entry *entry);
+
+/*
+ * Add a ref_entry to the end of dir (unsorted).  Entry is always
+ * stored directly in dir; no recursion into subdirectories is
+ * done.
+ */
+void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
+
+/*
+ * Remove the entry with the given name from dir, recursing into
+ * subdirectories as necessary.  If refname is the name of a directory
+ * (i.e., ends with '/'), then remove the directory and its contents.
+ * If the removal was successful, return the number of entries
+ * remaining in the directory entry that contained the deleted entry.
+ * If the name was not found, return -1.  Please note that this
+ * function only deletes the entry from the cache; it does not delete
+ * it from the filesystem or ensure that other cache entries (which
+ * might be symbolic references to the removed entry) are updated.
+ * Nor does it remove any containing dir entries that might be made
+ * empty by the removal.  dir must represent the top-level directory
+ * and must already be complete.
+ */
+int remove_entry_from_dir(struct ref_dir *dir, const char *refname);
+
+/*
+ * Add a ref_entry to the ref_dir (unsorted), recursing into
+ * subdirectories as necessary.  dir must represent the top-level
+ * directory.  Return 0 on success.
+ */
+int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref);
+
+/*
+ * If refname is a reference name, find the ref_dir within the dir
+ * tree that should hold refname. If refname is a directory name
+ * (i.e., it ends in '/'), then return that ref_dir itself. dir must
+ * represent the top-level directory and must already be complete.
+ * Sort ref_dirs and recurse into subdirectories as necessary. If
+ * mkdir is set, then create any missing directories; otherwise,
+ * return NULL if the desired directory cannot be found.
+ */
+struct ref_dir *find_containing_dir(struct ref_dir *dir,
+				    const char *refname, int mkdir);
+
+/*
+ * Find the value entry with the given name in dir, sorting ref_dirs
+ * and recursing into subdirectories as necessary.  If the name is not
+ * found or it corresponds to a directory entry, return NULL.
+ */
+struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
+
+struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir);
+
+typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
+
+/*
+ * Call fn for each reference in dir that has index in the range
+ * offset <= index < dir->nr.  Recurse into subdirectories that are in
+ * that index range, sorting them before iterating.  This function
+ * does not sort dir itself; it should be sorted beforehand.  fn is
+ * called for all references, including broken ones.
+ */
+int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+			     each_ref_entry_fn fn, void *cb_data);
+
+/*
+ * Peel the entry (if possible) and return its new peel_status.  If
+ * repeel is true, re-peel the entry even if there is an old peeled
+ * value that is already stored in it.
+ *
+ * It is OK to call this function with a packed reference entry that
+ * might be stale and might even refer to an object that has since
+ * been garbage-collected.  In such a case, if the entry has
+ * REF_KNOWS_PEELED then leave the status unchanged and return
+ * PEEL_PEELED or PEEL_NON_TAG; otherwise, return PEEL_INVALID.
+ */
+enum peel_status peel_entry(struct ref_entry *entry, int repeel);
+
+/*
+ * Load all of the refs from `dir` into our in-memory cache.
+ */
+void prime_ref_dir(struct ref_dir *dir);
+
+#endif /* REFS_REF_CACHE_H */
-- 
2.11.0

