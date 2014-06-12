From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Thu, 12 Jun 2014 10:20:58 -0700
Message-ID: <1402593699-13983-8-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hP-0006vy-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbaFLRV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:56 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:35536 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so310478obc.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LH+nPDhANAWO1oHp5t22PJ0Mzk9DYVejKR7AcyDqRPg=;
        b=inKx5EqibgfzmfOUJzLMsruSWqkj5P9lI39S44LthtH0T1Tv7tp6pGRDgPR2VkB94i
         37Vh02CIaiqAsalJBypQiGrbRoCsjU0wLLS4YF3ecQulNwW0xRe7JHt/KVyiC7dvp6pD
         KGRtK+6gyxB4F5i3C2g9ClyBp0CES+Vq/3yM5IrWQJ1g76cPQaphawBHSRvlQmdC3Ggs
         5lX7Yx7L7VVmPR20dCPcWU/dpTAmUsQhOVbFj6p94iI/F2WO8G0NBm7o/9wcMgoHNhGI
         6GhsfmqrlEjyaZMJ8tWGm1KFsEnPaNCGLQ+OyS2EEoyDa4afnCnhotQZSmgEmbDicjEL
         DqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LH+nPDhANAWO1oHp5t22PJ0Mzk9DYVejKR7AcyDqRPg=;
        b=L/MGef1LDKgSPd1glsWE0f6AIPwGrMjFW27LaFcmG4gWYcgZ8+fX15ljC1lb6HPhBn
         Lv0zBufOzaeXI9WRzl/qaRV483CpFoxtEeNp73sVefRFQEmwTik4KXiNLv/sESCeuo1E
         4vyq77GyL+yMZcYyWNxVSflMUk8jH5VolTEPo0Y46fRRGH3oZWoXN9efrhwde3quE1W2
         S67TSSRFMMIdnxwTJIcGky9zbXfc4lC+yOyr987GUrDj0Qg0YC4PkV0U0s5FiVeD9Rbb
         lH7QEgFX3EJHzdN61/CGktRsMMVRzrZKg2iFcLPQTrqBxm+s2R6Rf9qgpWYnn1ERNpsd
         7+mg==
X-Gm-Message-State: ALoCoQmJrFORdKjleIGffEKqy8eAc0frKP4/Zl95yP7FGb7lMDH+sid7z9iGXxWjUp/XfPYJiVnA
X-Received: by 10.182.29.1 with SMTP id f1mr7739183obh.23.1402593703195;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si111180yhl.7.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0B0725A47FA;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B118EE0A87; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251420>

Making errno when returning from lock_file() meaningful, which should
fix

 * an existing almost-bug in lock_ref_sha1_basic where it assumes
   errno==ENOENT is meaningful and could waste some work on retries

 * an existing bug in repack_without_refs where it prints
   strerror(errno) and picks advice based on errno, despite errno
   potentially being zero and potentially having been clobbered by
   that point

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 17 ++++++++++++-----
 refs.c     |  1 +
 refs.h     |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 464031b..a921d77 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
-
+/* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
@@ -130,8 +130,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 */
 	static const size_t max_path_len = sizeof(lk->filename) - 5;
 
-	if (strlen(path) >= max_path_len)
+	if (strlen(path) >= max_path_len) {
+		errno = ENAMETOOLONG;
 		return -1;
+	}
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
@@ -148,9 +150,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			lock_file_list = lk;
 			lk->on_list = 1;
 		}
-		if (adjust_shared_perm(lk->filename))
-			return error("cannot fix permission bits on %s",
-				     lk->filename);
+		if (adjust_shared_perm(lk->filename)) {
+			int save_errno = errno;
+			error("cannot fix permission bits on %s",
+			      lk->filename);
+			errno = save_errno;
+			return -1;
+		}
 	}
 	else
 		lk->filename[0] = 0;
@@ -188,6 +194,7 @@ NORETURN void unable_to_lock_index_die(const char *path, int err)
 	die("%s", buf.buf);
 }
 
+/* This should return a meaningful errno on failure */
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
diff --git a/refs.c b/refs.c
index 25c3a93..1e8f293 100644
--- a/refs.c
+++ b/refs.c
@@ -2184,6 +2184,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/* This should return a meaningful errno on failure */
 int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
diff --git a/refs.h b/refs.h
index 94d4cd4..948cc53 100644
--- a/refs.h
+++ b/refs.h
@@ -81,6 +81,7 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
 /*
  * Lock the packed-refs file for writing.  Flags is passed to
  * hold_lock_file_for_update().  Return 0 on success.
+ * Errno is set to something meaningful on error.
  */
 extern int lock_packed_refs(int flags);
 
-- 
2.0.0.599.g83ced0e
