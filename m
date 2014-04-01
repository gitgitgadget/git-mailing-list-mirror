From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/22] struct lock_file: rename lock_filename field to staging_filename
Date: Tue,  1 Apr 2014 17:58:27 +0200
Message-ID: <1396367910-7299-20-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV164-00081C-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaDAP70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56297 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888AbaDAP7G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:06 -0400
X-AuditID: 12074413-f79076d000002d17-0c-533ae2495d7d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id FC.58.11543.942EA335; Tue,  1 Apr 2014 11:59:05 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbN027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:04 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv5yCrY4NFiDYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ2x8O5n9oKu4Iq/X2sbGDc5dzFyckgImEg8aexhgbDFJC7cW8/WxcjFISRwmVFi5afd
	7BDOMSaJ2c8vglWxCehKLOppZgKxRQTUJCa2HQKLMwukSLz6uwvMFhYIlzj+4jAjiM0ioCqx
	bO88NhCbV8BFYuqxI+wQ2+QkpvxeAGZzAsUvPdjDCmILCThLnH6zmHkCI+8CRoZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCEhJbyDcddJuUOMAhyMSjy8B85bBQuxJpYV
	V+YeYpTkYFIS5f1xFyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfWTaAcb0piZVVqUT5MSpqD
	RUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCN+ohUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFq
	XkpqUWJpSUY8KDLii4GxAZLiAdo7HaSdt7ggMRcoCtF6ilFRSpw3BCQhAJLIKM2DGwtLFK8Y
	xYG+FOZdDFLFA0wycN2vgAYzAQ3mXgc2uCQRISXVwLhRN9Tn/vVcxu0yV677Xtr6aSpTqaes
	37/TS+eL36q6v3Dup57tT7fU33Dk+CWbdGvelYJiMzfDHbma0izsXZ7//wr5Xp1uk6NRuPiz
	j/L/64s5g6RumXFkex2rMmhomfnwhVjsIrXexW5NvXcmNJ1ijO6Mrfpx0cppY4KA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245600>

Now that the filename is stored separately, the external users of this
field only use it as the filename to which they are trying to write.
Soon it will not necessarily be the name of the lock file, so rename
the field more generically.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 12 ++++++------
 builtin/reflog.c |  2 +-
 cache.h          |  2 +-
 config.c         |  2 +-
 lockfile.c       | 53 +++++++++++++++++++++++++++--------------------------
 refs.c           |  2 +-
 shallow.c        |  6 +++---
 7 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28944de..6557bde 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -330,7 +330,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.lock_filename.buf, 1);
+		setenv(INDEX_ENVIRONMENT, index_lock.staging_filename.buf, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
@@ -341,10 +341,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(index_lock.lock_filename.buf);
+		read_cache_from(index_lock.staging_filename.buf);
 
 		commit_style = COMMIT_NORMAL;
-		return index_lock.lock_filename.buf;
+		return index_lock.staging_filename.buf;
 	}
 
 	/*
@@ -368,7 +368,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return index_lock.lock_filename.buf;
+		return index_lock.staging_filename.buf;
 	}
 
 	/*
@@ -453,9 +453,9 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
-	read_cache_from(false_lock.lock_filename.buf);
+	read_cache_from(false_lock.staging_filename.buf);
 
-	return false_lock.lock_filename.buf;
+	return false_lock.staging_filename.buf;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 29bc07b..08fd6b3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -431,7 +431,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
-				lock->lk->lock_filename.buf);
+				lock->lk->staging_filename.buf);
 			unlink(newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
diff --git a/cache.h b/cache.h
index 0fefc66..3b9dbd4 100644
--- a/cache.h
+++ b/cache.h
@@ -539,7 +539,7 @@ struct lock_file {
 	pid_t owner;
 	unsigned char flags;
 	struct strbuf filename;
-	struct strbuf lock_filename;
+	struct strbuf staging_filename;
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
diff --git a/config.c b/config.c
index cea0af0..c39bd31 100644
--- a/config.c
+++ b/config.c
@@ -1306,7 +1306,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 static int write_error(struct lock_file *lk)
 {
 	error("failed to write new configuration file %s",
-	      lk->lock_filename.buf);
+	      lk->staging_filename.buf);
 
 	/* Same error code as "failed to rename". */
 	return 4;
diff --git a/lockfile.c b/lockfile.c
index 07b5c21..3974137 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -35,26 +35,26 @@
  *
  * - Uninitialized.  In this state the object's flags field must be
  *   zero but the rest of the contents need not be initialized.  In
- *   particular, the filename and lock_filename strbufs should *not*
- *   be initialized externally.  The first time the object is used in
- *   any way, it is initialized, permanently registered in the
+ *   particular, the filename and staging_filename strbufs should
+ *   *not* be initialized externally.  The first time the object is
+ *   used in any way, it is initialized, permanently registered in the
  *   lock_file_list, and flags & LOCK_FLAGS_ON_LIST is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update() or
  *   hold_lock_file_for_append()).  In this state, the lockfile
  *   exists, filename holds the filename of the locked file,
- *   lock_filename holds the filename of the lockfile, fd holds a file
- *   descriptor open for writing to the lockfile, and owner holds the
- *   PID of the process that locked the file.
+ *   staging_filename holds the filename of the lockfile, fd holds a
+ *   file descriptor open for writing to the lockfile, and owner holds
+ *   the PID of the process that locked the file.
  *
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
  *   failed attempt to lock).  In this state, filename and
- *   lock_filename are the empty string and fd is -1.  The object is
- *   left registered in the lock_file_list, and flags &
- *   LOCK_FLAGS_ON_LIST is set.
+ *   staging_filename are the empty string and fd is -1.  The object is left
+ *   registered in the lock_file_list, and flags & LOCK_FLAGS_ON_LIST
+ *   is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -73,10 +73,10 @@ static void remove_lock_file(void)
 
 	while (lock_file_list) {
 		if (lock_file_list->owner == me &&
-		    lock_file_list->lock_filename.len) {
+		    lock_file_list->staging_filename.len) {
 			if (lock_file_list->fd >= 0)
 				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->lock_filename.buf);
+			unlink_or_warn(lock_file_list->staging_filename.buf);
 		}
 		lock_file_list = lock_file_list->next;
 	}
@@ -168,13 +168,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (lk->flags & LOCK_FLAGS_ON_LIST) {
 		/* Sanity check that object is not already in use: */
 		assert(!lk->filename.len);
-		assert(!lk->lock_filename.len);
+		assert(!lk->staging_filename.len);
 	} else {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
 		lk->flags |= LOCK_FLAGS_ON_LIST;
 		strbuf_init(&lk->filename, path_len);
-		strbuf_init(&lk->lock_filename, 0);
+		strbuf_init(&lk->staging_filename, 0);
 		lk->next = lock_file_list;
 		lock_file_list = lk;
 	}
@@ -183,18 +183,19 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(&lk->filename);
 
-	strbuf_grow(&lk->lock_filename, lk->filename.len + LOCK_SUFFIX_LEN);
-	strbuf_addbuf(&lk->lock_filename, &lk->filename);
-	strbuf_addstr(&lk->lock_filename, ".lock");
+	strbuf_grow(&lk->staging_filename, lk->filename.len + LOCK_SUFFIX_LEN);
+	strbuf_addbuf(&lk->staging_filename, &lk->filename);
+	strbuf_addstr(&lk->staging_filename, ".lock");
 
-	lk->fd = open(lk->lock_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+	lk->fd = open(lk->staging_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
 		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->lock_filename, 0);
+		strbuf_setlen(&lk->staging_filename, 0);
 		return -1;
 	}
-	if (adjust_shared_perm(lk->lock_filename.buf)) {
-		error("cannot fix permission bits on %s", lk->lock_filename.buf);
+	if (adjust_shared_perm(lk->staging_filename.buf)) {
+		error("cannot fix permission bits on %s",
+		      lk->staging_filename.buf);
 		rollback_lock_file(lk);
 		return -1;
 	}
@@ -280,11 +281,11 @@ int commit_lock_file(struct lock_file *lk)
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
-	if (rename(lk->lock_filename.buf, lk->filename.buf)) {
+	if (rename(lk->staging_filename.buf, lk->filename.buf)) {
 		err = -1;
 	} else {
 		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->lock_filename, 0);
+		strbuf_setlen(&lk->staging_filename, 0);
 	}
 	return err;
 }
@@ -307,10 +308,10 @@ int commit_locked_index(struct lock_file *lk)
 	if (alternate_index_output) {
 		if (lk->fd >= 0 && close_lock_file(lk))
 			return -1;
-		if (rename(lk->lock_filename.buf, alternate_index_output))
+		if (rename(lk->staging_filename.buf, alternate_index_output))
 			return -1;
 		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->lock_filename, 0);
+		strbuf_setlen(&lk->staging_filename, 0);
 		return 0;
 	} else {
 		return commit_lock_file(lk);
@@ -322,8 +323,8 @@ void rollback_lock_file(struct lock_file *lk)
 	if (lk->filename.len) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
-		unlink_or_warn(lk->lock_filename.buf);
+		unlink_or_warn(lk->staging_filename.buf);
 		strbuf_setlen(&lk->filename, 0);
-		strbuf_setlen(&lk->lock_filename, 0);
+		strbuf_setlen(&lk->staging_filename, 0);
 	}
 }
diff --git a/refs.c b/refs.c
index 85967e7..47a49a0 100644
--- a/refs.c
+++ b/refs.c
@@ -2822,7 +2822,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close_ref(lock) < 0) {
-		error("Couldn't write %s", lock->lk->lock_filename.buf);
+		error("Couldn't write %s", lock->lk->staging_filename.buf);
 		unlock_ref(lock);
 		return -1;
 	}
diff --git a/shallow.c b/shallow.c
index a27d587..76dc6df 100644
--- a/shallow.c
+++ b/shallow.c
@@ -269,8 +269,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->lock_filename.buf);
-		*alternate_shallow_file = shallow_lock->lock_filename.buf;
+				  shallow_lock->staging_filename.buf);
+		*alternate_shallow_file = shallow_lock->staging_filename.buf;
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -316,7 +316,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.lock_filename.buf);
+				  shallow_lock.staging_filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
-- 
1.9.0
