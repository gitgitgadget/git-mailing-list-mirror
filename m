From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 06/10] refs/refs-internal.h: new header file
Date: Tue, 10 Nov 2015 12:42:36 +0100
Message-ID: <07d860c0fbe055b345b351af48b372a22a7195d8.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7KZ-0000ZR-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbbKJLnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:14 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63195 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903AbbKJLnD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:03 -0500
X-AuditID: 12074413-f79bd6d000007ac2-96-5641d845ca2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 89.0B.31426.548D1465; Tue, 10 Nov 2015 06:43:01 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABgljA014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:43:00 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOt6wzHMYN03DYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGc0961iLpheUnGpZxNrA2NbdBcj
	J4eEgInE6yuLWCFsMYkL99azdTFycQgJXGaU+HfxBiuEc4JJ4sKzdiaQKjYBXYlFPc1gtoiA
	msTEtkMsIDazwDImiVl7bUFsYQF7iS13VzOD2CwCqhK3e7aD1fAKREmsu/OIDWKbnMSU+yAz
	OTg4BSwk5p7LAAkLCZhLHG+fyDiBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzM
	Er3UlNJNjJBQFN7BuOuk3CFGAQ5GJR7eCd8cwoRYE8uKK3MPMUpyMCmJ8u4/5RgmxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYTX/gVQOW9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoR
	TFaGg0NJgvfENaChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDIiC8GxgZIigdo
	r9J1oHbe4oLEXKAoROspRkUpcV4tkIQASCKjNA9uLCzBvGIUB/pSmHciyHYeYHKC634FNJgJ
	aPBSf5CHiksSEVJSDYzZydPOveAPUTsnsfz70tbty75nnv0QH7nQR9t8bvAmdobEdWutouUi
	TrW8j9194EqMR9KhbwtrLI8nB59aHpC4VM1J7MWX5lW/XBxOyBXa6B4p/ntK8Xc3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281110>

There are a number of constants, structs, and static functions defined
in refs.c and treated as private to the references module. But we want
to support multiple reference backends within the reference module,
and those backends will need access to some heretofore private
declarations.

We don't want those declarations to be visible to non-refs code, so we
don't want to move them to refs.h. Instead, add a new header file,
refs/refs-internal.h, that is intended to be included only from within
the refs module. Make some functions non-static and move some
declarations (and their corresponding docstrings) from refs.c to this
file.

In a moment we will add more content to the "refs" subdirectory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 174 +++----------------------------------------------
 refs/refs-internal.h | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 165 deletions(-)
 create mode 100644 refs/refs-internal.h

diff --git a/refs.c b/refs.c
index f48c58a..e6b82ee 100644
--- a/refs.c
+++ b/refs.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "refs.h"
+#include "refs/refs-internal.h"
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
@@ -35,41 +36,6 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
- * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
- * refs (i.e., because the reference is about to be deleted anyway).
- */
-#define REF_DELETING	0x02
-
-/*
- * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
- */
-#define REF_ISPRUNING	0x04
-
-/*
- * Used as a flag in ref_update::flags when the reference should be
- * updated to new_sha1.
- */
-#define REF_HAVE_NEW	0x08
-
-/*
- * Used as a flag in ref_update::flags when old_sha1 should be
- * checked.
- */
-#define REF_HAVE_OLD	0x10
-
-/*
- * Used as a flag in ref_update::flags when the lockfile needs to be
- * committed.
- */
-#define REF_NEEDS_COMMIT 0x20
-
-/*
- * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
- * value to ref_update::flags
- */
-
-/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -340,20 +306,7 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
-/*
- * Return true iff refname is minimally safe. "Safe" here means that
- * deleting a loose reference by this name will not do any damage, for
- * example by causing a file that is not a reference to be deleted.
- * This function does not check that the reference name is legal; for
- * that, use check_refname_format().
- *
- * We consider a refname that starts with "refs/" to be safe as long
- * as any ".." components that it might contain do not escape "refs/".
- * Names that do not start with "refs/" are considered safe iff they
- * consist entirely of upper case characters and '_' (like "HEAD" and
- * "MERGE_HEAD" but not "config" or "FOO/BAR").
- */
-static int refname_is_safe(const char *refname)
+int refname_is_safe(const char *refname)
 {
 	if (starts_with(refname, "refs/")) {
 		char *buf;
@@ -1823,39 +1776,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
-enum peel_status {
-	/* object was peeled successfully: */
-	PEEL_PEELED = 0,
-
-	/*
-	 * object cannot be peeled because the named object (or an
-	 * object referred to by a tag in the peel chain), does not
-	 * exist.
-	 */
-	PEEL_INVALID = -1,
-
-	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG = -2,
-
-	/* ref_entry contains no peeled value because it is a symref: */
-	PEEL_IS_SYMREF = -3,
-
-	/*
-	 * ref_entry cannot be peeled because it is broken (i.e., the
-	 * symbolic reference cannot even be resolved to an object
-	 * name):
-	 */
-	PEEL_BROKEN = -4
-};
-
-/*
- * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  If successful, store the
- * result to sha1 and return PEEL_PEELED.  If the object is not a tag
- * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave sha1 unchanged.
- */
-static enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 {
 	struct object *o = lookup_unknown_object(name);
 
@@ -3110,27 +3031,10 @@ out:
 	return ret;
 }
 
-/*
- * Return 0 if a reference named refname could be created without
- * conflicting with the name of an existing reference. Otherwise,
- * return a negative value and write an explanation to err. If extras
- * is non-NULL, it is a list of additional refnames with which refname
- * is not allowed to conflict. If skip is non-NULL, ignore potential
- * conflicts with refs in skip (e.g., because they are scheduled for
- * deletion in the same operation). Behavior is undefined if the same
- * name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- *
- * extras and skip must be sorted.
- */
-static int verify_refname_available(const char *newname,
-				    struct string_list *extras,
-				    struct string_list *skip,
-				    struct strbuf *err)
+int verify_refname_available(const char *newname,
+			     struct string_list *extras,
+			     struct string_list *skip,
+			     struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -3284,12 +3188,7 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-/*
- * copy the reflog message msg to buf, which has been allocated sufficiently
- * large, while cleaning up the whitespaces.  Especially, convert LF to space,
- * because reflog file is one line per entry.
- */
-static int copy_reflog_msg(char *buf, const char *msg)
+int copy_reflog_msg(char *buf, const char *msg)
 {
 	char *cp = buf;
 	char c;
@@ -3310,7 +3209,7 @@ static int copy_reflog_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-static int should_autocreate_reflog(const char *refname)
+int should_autocreate_reflog(const char *refname)
 {
 	if (!log_all_ref_updates)
 		return 0;
@@ -3963,61 +3862,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-/**
- * Information needed for a single ref update. Set new_sha1 to the new
- * value or to null_sha1 to delete the ref. To check the old value
- * while the ref is locked, set (flags & REF_HAVE_OLD) and set
- * old_sha1 to the old value, or to null_sha1 to ensure the ref does
- * not exist before update.
- */
-struct ref_update {
-	/*
-	 * If (flags & REF_HAVE_NEW), set the reference to this value:
-	 */
-	unsigned char new_sha1[20];
-	/*
-	 * If (flags & REF_HAVE_OLD), check that the reference
-	 * previously had this value:
-	 */
-	unsigned char old_sha1[20];
-	/*
-	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, and REF_ISPRUNING:
-	 */
-	unsigned int flags;
-	struct ref_lock *lock;
-	int type;
-	char *msg;
-	const char refname[FLEX_ARRAY];
-};
-
-/*
- * Transaction states.
- * OPEN:   The transaction is in a valid state and can accept new updates.
- *         An OPEN transaction can be committed.
- * CLOSED: A closed transaction is no longer active and no other operations
- *         than free can be used on it in this state.
- *         A transaction can either become closed by successfully committing
- *         an active transaction or if there is a failure while building
- *         the transaction thus rendering it failed/inactive.
- */
-enum ref_transaction_state {
-	REF_TRANSACTION_OPEN   = 0,
-	REF_TRANSACTION_CLOSED = 1
-};
-
-/*
- * Data structure for holding a reference transaction, which can
- * consist of checks and updates to multiple references, carried out
- * as atomically as possible.  This structure is opaque to callers.
- */
-struct ref_transaction {
-	struct ref_update **updates;
-	size_t alloc;
-	size_t nr;
-	enum ref_transaction_state state;
-};
-
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	assert(err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
new file mode 100644
index 0000000..9077c11
--- /dev/null
+++ b/refs/refs-internal.h
@@ -0,0 +1,180 @@
+#ifndef REFS_REFS_INTERNAL_H
+#define REFS_REFS_INTERNAL_H
+
+/*
+ * Data structures and functions for the internal use of the refs
+ * module. Code outside of the refs module should use only the public
+ * functions defined in "refs.h", and should *not* include this file.
+ */
+
+/*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
+ * Used as a flag in ref_update::flags when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x04
+
+/*
+ * Used as a flag in ref_update::flags when the reference should be
+ * updated to new_sha1.
+ */
+#define REF_HAVE_NEW	0x08
+
+/*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x10
+
+/*
+ * Used as a flag in ref_update::flags when the lockfile needs to be
+ * committed.
+ */
+#define REF_NEEDS_COMMIT 0x20
+
+/*
+ * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
+ * value to ref_update::flags
+ */
+
+/*
+ * Return true iff refname is minimally safe. "Safe" here means that
+ * deleting a loose reference by this name will not do any damage, for
+ * example by causing a file that is not a reference to be deleted.
+ * This function does not check that the reference name is legal; for
+ * that, use check_refname_format().
+ *
+ * We consider a refname that starts with "refs/" to be safe as long
+ * as any ".." components that it might contain do not escape "refs/".
+ * Names that do not start with "refs/" are considered safe iff they
+ * consist entirely of upper case characters and '_' (like "HEAD" and
+ * "MERGE_HEAD" but not "config" or "FOO/BAR").
+ */
+int refname_is_safe(const char *refname);
+
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED = 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID = -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4
+};
+
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
+ */
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+
+/*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference. Otherwise,
+ * return a negative value and write an explanation to err. If extras
+ * is non-NULL, it is a list of additional refnames with which refname
+ * is not allowed to conflict. If skip is non-NULL, ignore potential
+ * conflicts with refs in skip (e.g., because they are scheduled for
+ * deletion in the same operation). Behavior is undefined if the same
+ * name is listed in both extras and skip.
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * extras and skip must be sorted.
+ */
+int verify_refname_available(const char *newname,
+			     struct string_list *extras,
+			     struct string_list *skip,
+			     struct strbuf *err);
+
+/*
+ * Copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+int copy_reflog_msg(char *buf, const char *msg);
+
+int should_autocreate_reflog(const char *refname);
+
+/**
+ * Information needed for a single ref update. Set new_sha1 to the new
+ * value or to null_sha1 to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set
+ * old_sha1 to the old value, or to null_sha1 to ensure the ref does
+ * not exist before update.
+ */
+struct ref_update {
+	/*
+	 * If (flags & REF_HAVE_NEW), set the reference to this value:
+	 */
+	unsigned char new_sha1[20];
+	/*
+	 * If (flags & REF_HAVE_OLD), check that the reference
+	 * previously had this value:
+	 */
+	unsigned char old_sha1[20];
+	/*
+	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
+	 * REF_DELETING, and REF_ISPRUNING:
+	 */
+	unsigned int flags;
+	struct ref_lock *lock;
+	int type;
+	char *msg;
+	const char refname[FLEX_ARRAY];
+};
+
+/*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: A closed transaction is no longer active and no other operations
+ *         than free can be used on it in this state.
+ *         A transaction can either become closed by successfully committing
+ *         an active transaction or if there is a failure while building
+ *         the transaction thus rendering it failed/inactive.
+ */
+enum ref_transaction_state {
+	REF_TRANSACTION_OPEN   = 0,
+	REF_TRANSACTION_CLOSED = 1
+};
+
+/*
+ * Data structure for holding a reference transaction, which can
+ * consist of checks and updates to multiple references, carried out
+ * as atomically as possible.  This structure is opaque to callers.
+ */
+struct ref_transaction {
+	struct ref_update **updates;
+	size_t alloc;
+	size_t nr;
+	enum ref_transaction_state state;
+};
+
+#endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
