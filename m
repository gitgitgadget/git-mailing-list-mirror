From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/16] lockfile: add accessors get_lock_file_fd() and get_lock_file_fp()
Date: Mon, 10 Aug 2015 11:47:38 +0200
Message-ID: <4676c6a550fecceb921cc71b3cc5320004c6b0c8.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjgl-0001vA-Qz
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbbHJJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:10 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63301 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698AbbHJJsG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:06 -0400
X-AuditID: 1207440e-f79516d0000012b3-bb-55c8734ff99c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AA.1B.04787.F4378C55; Mon, 10 Aug 2015 05:48:00 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswr021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:47:59 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqBtQfCLU4Hkji0XXlW4mi4beK8wW
	T+beZba4vWI+swOLx9/3H5g8Hr7qYve4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujI0XLrIW
	7JermDfvNGsD4wmJLkZODgkBE4mef0/ZIGwxiQv31gPZXBxCApcZJbpevoZyTjBJPP93gBWk
	ik1AV2JRTzMTiC0ioCYxse0QC4jNLJAucWJBO5gtLBAtsWL1NWYQm0VAVWLJn2eMIDavQJRE
	79nLQL0cQNvkJBZcSAcJcwpYSGxv3AA2XkjAXOLxvPPsExh5FzAyrGKUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdbLzSzRS00p3cQICR++HYzt62UOMQpwMCrx8M7YfDxUiDWxrLgy9xCjJAeT
	kiivRf6JUCG+pPyUyozE4oz4otKc1OJDjBIczEoivPEZQDnelMTKqtSifJiUNAeLkjiv2hJ1
	PyGB9MSS1OzU1ILUIpisDAeHkgSvfBFQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJ
	RjwoMuKLgbEBkuIB2msH0s5bXJCYCxSFaD3FqCglzvunECghAJLIKM2DGwtLCq8YxYG+FOZt
	BGnnASYUuO5XQIOZQAYHgg0uSURISTUwxlgoOCkdls2uLbr2yKnWnGWvV/vXss0ntOIOeK12
	Tnbbc3jJcTvrT8cfqnHl+QoeFa8pslRuyL18YUfr3MUBc9YucDj8u/y//NlO/rNfjZYU3upt
	XyV6ul2SZ24ec4XXq4x8o5m3yzWVDO4vi5o1m+GA3IQjgdZLDkzmYN1330NHcMol 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275589>

We are about to move those members, so change client code to read them
through accessor functions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 credential-store.c |  2 +-
 lockfile.c         | 14 ++++++++++++++
 lockfile.h         |  3 +++
 read-cache.c       |  2 +-
 refs.c             | 12 +++++++-----
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index f692509..00aea3a 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -52,7 +52,7 @@ static void print_entry(struct credential *c)
 static void print_line(struct strbuf *buf)
 {
 	strbuf_addch(buf, '\n');
-	write_or_die(credential_lock.fd, buf->buf, buf->len);
+	write_or_die(get_lock_file_fd(&credential_lock), buf->buf, buf->len);
 }
 
 static void rewrite_credential_file(const char *fn, struct credential *c,
diff --git a/lockfile.c b/lockfile.c
index 2369eff..df9c704 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -364,6 +364,20 @@ FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 	return lk->fp;
 }
 
+int get_lock_file_fd(struct lock_file *lk)
+{
+	if (!lk->active)
+		die("BUG: get_lock_file_fd() called for unlocked object");
+	return lk->fd;
+}
+
+FILE *get_lock_file_fp(struct lock_file *lk)
+{
+	if (!lk->active)
+		die("BUG: get_lock_file_fp() called for unlocked object");
+	return lk->fp;
+}
+
 char *get_locked_file_path(struct lock_file *lk)
 {
 	if (!lk->active)
diff --git a/lockfile.h b/lockfile.h
index a483cc9..d9dfbc9 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -203,6 +203,9 @@ extern NORETURN void unable_to_lock_die(const char *path, int err);
  */
 extern FILE *fdopen_lock_file(struct lock_file *lk, const char *mode);
 
+extern int get_lock_file_fd(struct lock_file *lk);
+extern FILE *get_lock_file_fp(struct lock_file *lk);
+
 /*
  * Return the path of the file that is locked by the specified
  * lock_file object. The caller must free the memory.
diff --git a/read-cache.c b/read-cache.c
index 723d48d..96cb9a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2112,7 +2112,7 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, lock->fd, 0);
+	int ret = do_write_index(istate, get_lock_file_fd(lock), 0);
 	if (ret)
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
diff --git a/refs.c b/refs.c
index a742d79..0f49a62 100644
--- a/refs.c
+++ b/refs.c
@@ -3162,6 +3162,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 {
 	static char term = '\n';
 	struct object *o;
+	int fd;
 
 	o = parse_object(sha1);
 	if (!o) {
@@ -3178,8 +3179,9 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
+	fd = get_lock_file_fd(lock->lk);
+	if (write_in_full(fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
@@ -4264,10 +4266,10 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if (update &&
-			   (write_in_full(lock->lk->fd,
+			   (write_in_full(get_lock_file_fd(lock->lk),
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
+			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
+			    close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
 			rollback_lock_file(&reflog_lock);
-- 
2.5.0
