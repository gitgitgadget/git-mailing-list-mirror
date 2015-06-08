From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/13] refs: remove some functions from the module's public interface
Date: Mon,  8 Jun 2015 13:45:44 +0200
Message-ID: <399429406fc6ec7a7e1a148c0a3a4b126240e59a.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVd-0005Ts-K1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbbFHLqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:21 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58253 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752630AbbFHLqI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:08 -0400
X-AuditID: 12074413-f79386d000000d23-41-5575807d14a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B7.32.03363.D7085755; Mon,  8 Jun 2015 07:46:05 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop7017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:04 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqFvbUBpqcGKZmEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M058msBU8Eep4tOHTSwNjHtkuhg5OSQETCQ23LrJDmGLSVy4t56ti5GLQ0jgMqPEzENd
	UM4JJon55+aCVbEJ6Eos6mlmArFFBNQkJrYdYgEpYhboYJS4sHwbUBEHh7BAqMTnRYwgNSwC
	qhIbnu5gAbF5BaIk5j6+xAixTU7i/PGfzCA2p4CFxN3/F9hAbCEBc4mP29oZJzDyLmBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokRElLCOxh3nZQ7xCjAwajEw3tgUUmo
	EGtiWXFl7iFGSQ4mJVHerrLSUCG+pPyUyozE4oz4otKc1OJDjBIczEoivEwWQDnelMTKqtSi
	fJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvxzqgRsGi1PTUirTMnBKENBMHJ8hw
	LimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtFelHmRvcUFiLlAUovUUo6KUOO9jkLkCIImM0jy4
	sbBE8YpRHOhLYV5dkHYeYJKB634FNJgJaPD3r8Ugg0sSEVJSDYxdR1Ln7f62svd+NnfB2fWR
	IdvXPctIEJAs+Sw71SrlysOJvAL9175YeeYk/k+RXzJtJdPLPZOU+LbNaP5VYqj2NSHP/PSb
	0zcfzv3ds+7et1sxUyQvPTR/93yBJPeNY8U/NF75b7VdIvTxevGThey931s+lje9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271019>

The following functions are no longer used from outside the refs
module:

* lock_packed_refs()
* add_packed_ref()
* commit_packed_refs()
* rollback_packed_refs()

So make these functions private.

This is an important step, because it means that nobody outside of the
refs module needs to know the difference between loose and packed
references.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 31 ++++++++++++++++++++++++-------
 refs.h | 30 ------------------------------
 2 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/refs.c b/refs.c
index ec4b8a0..b103a4b 100644
--- a/refs.c
+++ b/refs.c
@@ -1314,7 +1314,13 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+/*
+ * Add a reference to the in-memory packed reference cache.  This may
+ * only be called while the packed-refs file is locked (see
+ * lock_packed_refs()).  To actually write the packed-refs file, call
+ * commit_packed_refs().
+ */
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2503,8 +2509,12 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-/* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+/*
+ * Lock the packed-refs file for writing. Flags is passed to
+ * hold_lock_file_for_update(). Return 0 on success. On errors, set
+ * errno appropriately and return a nonzero value.
+ */
+static int lock_packed_refs(int flags)
 {
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
@@ -2534,10 +2544,12 @@ int lock_packed_refs(int flags)
 }
 
 /*
- * Commit the packed refs changes.
- * On error we must make sure that errno contains a meaningful value.
+ * Write the current version of the packed refs cache from memory to
+ * disk. The packed-refs file must already be locked for writing (see
+ * lock_packed_refs()). Return zero on success. On errors, set errno
+ * and return a nonzero value
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2566,7 +2578,12 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+/*
+ * Rollback the lockfile for the packed-refs file, and discard the
+ * in-memory packed reference cache.  (The packed-refs file will be
+ * read anew if it is needed again after this function is called.)
+ */
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index fa600b5..cb56662 100644
--- a/refs.h
+++ b/refs.h
@@ -111,36 +111,6 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
 /*
- * Lock the packed-refs file for writing.  Flags is passed to
- * hold_lock_file_for_update().  Return 0 on success.
- * Errno is set to something meaningful on error.
- */
-extern int lock_packed_refs(int flags);
-
-/*
- * Add a reference to the in-memory packed reference cache.  This may
- * only be called while the packed-refs file is locked (see
- * lock_packed_refs()).  To actually write the packed-refs file, call
- * commit_packed_refs().
- */
-extern void add_packed_ref(const char *refname, const unsigned char *sha1);
-
-/*
- * Write the current version of the packed refs cache from memory to
- * disk.  The packed-refs file must already be locked for writing (see
- * lock_packed_refs()).  Return zero on success.
- * Sets errno to something meaningful on error.
- */
-extern int commit_packed_refs(void);
-
-/*
- * Rollback the lockfile for the packed-refs file, and discard the
- * in-memory packed reference cache.  (The packed-refs file will be
- * read anew if it is needed again after this function is called.)
- */
-extern void rollback_packed_refs(void);
-
-/*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
-- 
2.1.4
