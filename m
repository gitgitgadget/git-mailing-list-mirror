From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Tue, 17 Jun 2014 08:53:21 -0700
Message-ID: <1403020442-31049-8-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviS-0003mk-84
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379AbaFQPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:18 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:48283 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so962401vcb.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HAl5vqZ6NnpNsRkzCwmuyN5bhrjx+Z9auKpl3q19vUo=;
        b=RLjiRqTLQnyxfjMKqd9j5fshDLa3gyBaggED931AvZTerSt2ybKFUlOhCEKprqAM84
         EbF7z+xXnEJ620eaUVu8ODmtAOrFttdRIYdF0l4m2juuW3NP91StwOdF0DNZSiSNrxnp
         NfEKm6kB+FLwZCp8P4ce98i5QuzLwm+dYlPGBKb5APK+biEZqPt37Wl5gwcnMaPt6u4s
         FSM7+uRnL4GXJc5KmhbzeR0ZFvQJRxeKN8PnVSDowwuzcl6cJ1uewbBR9QxzrGmrH11I
         RkUuwpnD0ZbSmn68AZ+y2folZvfTf/V1/HffpqkpO3WumHiQBO21v2vpiZCGxEeckTfy
         vnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HAl5vqZ6NnpNsRkzCwmuyN5bhrjx+Z9auKpl3q19vUo=;
        b=CZhu4ODSLY9uTocwqlP9yuzOD9EsXvvIgnomD2uOpLkj+IyXq4qN3k4j5J4gMtxHy4
         dPlW7ogwtvYWIhx3uoSTkxyO2x6oxlSqFFw8X3O5L3+VMqV6qvxycPQqpoOr/b8ObsLL
         P4EkUTNyFBkBLAG+FkVE04/VVjlCvegDMYe67alJ3bkgJwT+fwwD6roJw8OVOdJBq7cZ
         fBdDqHkiHzTtVzH1sgV3TyDj2TxWIAQafXBKs6cnLPOaoSa421g2LUNUkvLzUy+YucPF
         2OSdmtBQgCcx9tRpktiMvi/zCiK8iShplYCtRp6+zP2fmF9LyZTqRPzhVtce7U98WlNC
         X1nQ==
X-Gm-Message-State: ALoCoQn1dHHaArrvFWzF3GJuYXWQgxgethBAe9e6Gqm90U+ew83Rfww494bFT+JfswtwgD2qUdKj
X-Received: by 10.58.69.49 with SMTP id b17mr52483veu.26.1403020444635;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1209458yhg.2.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7BC8A5A45B3;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 00F4AE1158; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251876>

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
index db05602..e9d53e4 100644
--- a/refs.c
+++ b/refs.c
@@ -2212,6 +2212,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+/* This should return a meaningful errno on failure */
 int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
diff --git a/refs.h b/refs.h
index 09d3564..64f25d9 100644
--- a/refs.h
+++ b/refs.h
@@ -82,6 +82,7 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 /*
  * Lock the packed-refs file for writing.  Flags is passed to
  * hold_lock_file_for_update().  Return 0 on success.
+ * Errno is set to something meaningful on error.
  */
 extern int lock_packed_refs(int flags);
 
-- 
2.0.0.438.gec92e5c
