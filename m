From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Mon, 16 Jun 2014 11:03:38 -0700
Message-ID: <1402941859-29354-8-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKh-0007ix-1L
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbaFPSI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:29 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:56641 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so661278pab.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDpDzmdTra3DhqWBCLWGpZ4/qEBsrdiiJcJyuBIyqY4=;
        b=bhST11ynw4+NhBjQHyc2ftfMf/yj5f0j+RySTNaWBwPKDezoldktdr4pk4LE7m/Slr
         BwF+WzZ1VOBzxtc7QHlz67lCnLH/Xegkdyffr62x4R+9f4fm5JProqMfIW27uNHLQfrm
         UnAUrvFZme7forBs4gvfIpxImhuO4LEV6mHsENQ/h/eJajm6iGoLWutlsf8uPtp9WwT7
         lVBo+pXcbUHT1laUbExC9g5JTsJy220xMvym/R4cr28h97gw6vVYr4nqjhXoneDyKbHD
         uAr1YRmaUUNpXhSv9BqMhwQtO/nahQOO7h5gQI/PPuY+C9NMXjyMxEIWL+a9rslp3O9b
         kJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDpDzmdTra3DhqWBCLWGpZ4/qEBsrdiiJcJyuBIyqY4=;
        b=GxuZfaMEb7x++pcRaPnsStPdSO0zcPRxwIsPnACxtTgxwkO2xAGi8ZY5FyZeIFfzbq
         PV5PBRLvLbX4linwdf17PTBr7bTwL070wh8ZQnGoOFbGlB5aQ5QBx4sbK7CGDxr6r6K6
         fAHG53Ruxt6a31sdRS+2leHr5nvVmtIdNVSdvzvcVyFk4RNJBdKd8msa5brDAsmMwhWY
         cOPOQGWTA6/zqGyGn3TjvYS07QyuKV6S5+euD9I7FFsvwif9gDl6bwhkLoIGNtfk1XbL
         H4aVyKLBgd9nZeOvW49wrP49KG94SPL2NgSBmiCNoebWobpO0f2ELWkjnDo2gJRH26KJ
         FhGQ==
X-Gm-Message-State: ALoCoQlc1TIseI2nCn2ofP6J14alcamX/k1IghYc8zmgUltxYXTq5v9LfOwmcexK0obkHiu36WMq
X-Received: by 10.66.218.105 with SMTP id pf9mr493672pac.36.1402941862663;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997321yhk.4.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 797E65A4912;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1B6F7E0E22; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251781>

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
2.0.0.282.g3799eda.dirty
