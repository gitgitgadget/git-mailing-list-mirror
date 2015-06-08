From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/14] lockfile: remove some redundant functions
Date: Mon,  8 Jun 2015 11:07:34 +0200
Message-ID: <0d17c04842bef618ecd474c56f2dbcf6a613a379.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t32-0002r8-2b
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbFHJIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61572 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882AbbFHJII (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:08 -0400
X-AuditID: 1207440c-f79df6d000000d2d-26-55755b6c54b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C9.E2.03373.C6B55755; Mon,  8 Jun 2015 05:07:56 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojR010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:55 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqJsTXRpqsKJP1aLrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdcW7SZvaC
	breKvbcfsjUwnrDoYuTkkBAwkfh1+hgLhC0mceHeerYuRi4OIYHLjBJNmy+xQzgnmCT+/l3F
	ClLFJqArsainmQnEFhFwlDjx4DpYnFnAQWLz50ZGEFsYyJ526guYzSKgKnFtyXdmEJtXIEpi
	65YuqG1yEueP/wSLcwpYSPz6ugtoJgfQMnOJH3NZJzDyLmBkWMUol5hTmqubm5iZU5yarFuc
	nJiXl1qka6iXm1mil5pSuokREj48Oxi/rZM5xCjAwajEw3tgUUmoEGtiWXFl7iFGSQ4mJVHe
	jxGloUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJksgHK8KYmVValF+TApaQ4WJXFe1SXqfkIC
	6YklqdmpqQWpRTBZGQ4OJQneH5FAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg
	yIgvBsYGSIoHaC93FMje4oLEXKAoROspRkUpcd7dIHMFQBIZpXlwY2FJ4RWjONCXwrw2IO08
	wIQC1/0KaDAT0ODvX4tBBpckIqSkGhgdV31s+KPWUepevNH/06GTO8WvCt30t3Hfd+6zod6R
	C8+UrDqyQyJV+fnaPMIdJNWP+7uf3uI9ZU5rVfP6p9Ub/yv8M95ia8OSs72i9cpHqXlGh64Z
	+0f/+biM2d6g4Xb/aqG9rRp/s514X+7w0Viy9rxh3tY3nF52O3ouBEfPEutQFY0X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271007>

Remove the following functions and rewrite their callers to use the
equivalent tempfile functions directly:

* fdopen_lock_file() -> fdopen_tempfile()
* reopen_lock_file() -> reopen_tempfile()
* close_lock_file() -> close_tempfile()

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c |  2 +-
 fast-import.c    |  2 +-
 lockfile.c       | 15 ------------
 lockfile.h       | 70 ++++++++++++--------------------------------------------
 read-cache.c     |  2 +-
 refs.c           |  8 +++----
 6 files changed, 22 insertions(+), 77 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c9fbe42..970565c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -358,7 +358,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		discard_cache();
 		read_cache_from(index_lock.tempfile.filename.buf);
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
-			if (reopen_lock_file(&index_lock) < 0)
+			if (reopen_tempfile(&index_lock.tempfile) < 0)
 				die(_("unable to write index file"));
 			if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 				die(_("unable to update temporary index"));
diff --git a/fast-import.c b/fast-import.c
index 32a3e21..ca30fe9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1807,7 +1807,7 @@ static void dump_marks(void)
 		return;
 	}
 
-	f = fdopen_lock_file(&mark_lock, "w");
+	f = fdopen_tempfile(&mark_lock.tempfile, "w");
 	if (!f) {
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
diff --git a/lockfile.c b/lockfile.c
index b453016..c2d6ad1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -228,11 +228,6 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
-{
-	return fdopen_tempfile(&lk->tempfile, mode);
-}
-
 char *get_locked_file_path(struct lock_file *lk)
 {
 	if (!lk->tempfile.active)
@@ -242,16 +237,6 @@ char *get_locked_file_path(struct lock_file *lk)
 	return xmemdupz(lk->tempfile.filename.buf, lk->tempfile.filename.len - LOCK_SUFFIX_LEN);
 }
 
-int close_lock_file(struct lock_file *lk)
-{
-	return close_tempfile(&lk->tempfile);
-}
-
-int reopen_lock_file(struct lock_file *lk)
-{
-	return reopen_tempfile(&lk->tempfile);
-}
-
 int commit_lock_file_to(struct lock_file *lk, const char *path)
 {
 	return rename_tempfile(&lk->tempfile, path);
diff --git a/lockfile.h b/lockfile.h
index 5b313ef..3a212e9 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -53,8 +53,8 @@
  *     `hold_lock_file_for_*()` functions (also available via
  *     `lock->fd`).
  *
- *   * calling `fdopen_lock_file()` to get a `FILE` pointer for the
- *     open file and writing to the file using stdio.
+ *   * calling `fdopen_tempfile(lk->tempfile)` to get a `FILE` pointer
+ *     for the open file and writing to the file using stdio.
  *
  * When finished writing, the caller can:
  *
@@ -65,10 +65,16 @@
  * * Close the file descriptor and remove the lockfile by calling
  *   `rollback_lock_file()`.
  *
- * * Close the file descriptor without removing or renaming the
- *   lockfile by calling `close_lock_file()`, and later call
- *   `commit_lock_file()`, `commit_lock_file_to()`,
- *   `rollback_lock_file()`, or `reopen_lock_file()`.
+ * It is also permissable to call the following functions on the
+ * underlying tempfile object:
+ *
+ * * close_tempfile(lk->tempfile)
+ *
+ * * reopen_tempfile(lk->tempfile)
+ *
+ * * fdopen_tempfile(lk->tempfile, mode)
+ *
+ * See "tempfile.h" for more information.
  *
  * Even after the lockfile is committed or rolled back, the
  * `lock_file` object must not be freed or altered by the caller.
@@ -80,11 +86,6 @@
  * tempfile module will close and remove the lockfile, thereby rolling
  * back any uncommitted changes.
  *
- * If you need to close the file descriptor you obtained from a
- * `hold_lock_file_for_*()` function yourself, do so by calling
- * `close_lock_file()`. See "tempfile.h" for more information.
- *
- *
  * Under the covers, a lockfile is just a tempfile with a few helper
  * functions. In particular, the state diagram and the cleanup
  * machinery are all implemented in the tempfile module.
@@ -99,10 +100,9 @@
  * failure. Errors can be reported by passing `errno` to
  * `unable_to_lock_message()` or `unable_to_lock_die()`.
  *
- * Similarly, `commit_lock_file`, `commit_lock_file_to`, and
- * `close_lock_file` return 0 on success. On failure they set `errno`
- * appropriately, do their best to roll back the lockfile, and return
- * -1.
+ * Similarly, `commit_lock_file` and `commit_lock_file_to` return 0 on
+ * success. On failure they set `errno` appropriately, do their best
+ * to roll back the lockfile, and return -1.
  */
 
 struct lock_file {
@@ -192,52 +192,12 @@ extern void unable_to_lock_message(const char *path, int err,
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 
 /*
- * Associate a stdio stream with the lockfile (which must still be
- * open). Return `NULL` (*without* rolling back the lockfile) on
- * error. The stream is closed automatically when `close_lock_file()`
- * is called or when the file is committed or rolled back.
- */
-extern FILE *fdopen_lock_file(struct lock_file *lk, const char *mode);
-
-/*
  * Return the path of the file that is locked by the specified
  * lock_file object. The caller must free the memory.
  */
 extern char *get_locked_file_path(struct lock_file *lk);
 
 /*
- * If the lockfile is still open, close it (and the file pointer if it
- * has been opened using `fdopen_lock_file()`) without renaming the
- * lockfile over the file being locked. Return 0 upon success. On
- * failure to `close(2)`, return a negative value and roll back the
- * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
- * or `rollback_lock_file()` should eventually be called if
- * `close_lock_file()` succeeds.
- */
-extern int close_lock_file(struct lock_file *lk);
-
-/*
- * Re-open a lockfile that has been closed using `close_lock_file()`
- * but not yet committed or rolled back. This can be used to implement
- * a sequence of operations like the following:
- *
- * * Lock file.
- *
- * * Write new contents to lockfile, then `close_lock_file()` to
- *   cause the contents to be written to disk.
- *
- * * Pass the name of the lockfile to another program to allow it (and
- *   nobody else) to inspect the contents you wrote, while still
- *   holding the lock yourself.
- *
- * * `reopen_lock_file()` to reopen the lockfile. Make further updates
- *   to the contents.
- *
- * * `commit_lock_file()` to make the final version permanent.
- */
-extern int reopen_lock_file(struct lock_file *lk);
-
-/*
  * Commit the change represented by `lk`: close the file descriptor
  * and/or file pointer if they are still open and rename the lockfile
  * to its final destination. Return 0 upon success. On failure, roll
diff --git a/read-cache.c b/read-cache.c
index e20e003..3e49c49 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2121,7 +2121,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
 	else if (flags & CLOSE_LOCK)
-		return close_lock_file(lock);
+		return close_tempfile(&lock->tempfile);
 	else
 		return ret;
 }
diff --git a/refs.c b/refs.c
index d98b0f5..b46deba 100644
--- a/refs.c
+++ b/refs.c
@@ -2549,7 +2549,7 @@ int commit_packed_refs(void)
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 
-	out = fdopen_lock_file(packed_ref_cache->lock, "w");
+	out = fdopen_tempfile(&packed_ref_cache->lock->tempfile, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -2984,7 +2984,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 static int close_ref(struct ref_lock *lock)
 {
-	if (close_lock_file(lock->lk))
+	if (close_tempfile(&lock->lk->tempfile))
 		return -1;
 	return 0;
 }
@@ -4237,7 +4237,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			strbuf_release(&err);
 			goto failure;
 		}
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		cb.newlog = fdopen_tempfile(&reflog_lock.tempfile, "w");
 		if (!cb.newlog) {
 			error("cannot fdopen %s (%s)",
 			      reflog_lock.tempfile.filename.buf, strerror(errno));
@@ -4261,7 +4261,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			!(type & REF_ISSYMREF) &&
 			!is_null_sha1(cb.last_kept_sha1);
 
-		if (close_lock_file(&reflog_lock)) {
+		if (close_tempfile(&reflog_lock.tempfile)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if (update &&
-- 
2.1.4
