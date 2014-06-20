From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Fri, 20 Jun 2014 07:42:48 -0700
Message-ID: <1403275409-28173-8-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02h-00017d-4J
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbaFTOno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:44 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:59064 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so504682veb.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tMv8KSA0ETQfXjrTxqRjY+8TSNidkQwubKO+Nc5yEno=;
        b=Stp3TUQplq1DrBvbkMKyT5f0QVMNbYGa9mtX2DxwAn/Sf70aCN+RuqC8Kqt8v+cqvi
         Kud3H0FnPJdZf3nYKSffnO61AvOsMUeq5S7D8lwNtqrRinV2FtblWllB38SLW3+w5Oqj
         rM3dCgUSwt8V34YGB0oO3DPIuiQnduLA33CFigTPNJm5ua7CiJQY3CnZMrXc1UPWKdkm
         y/DULXLY/ryaWwmruLe6dD1tadkmONrxj34TQmG1n9UxCCVfBggk3o7BrFQ3yrOPHcKF
         1wbMnuPt0/0gt+AYPpFMb0A7H1kNGYqDx9d89B4CxD94U86M7gED+lzIzPC3uuREncRL
         hDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tMv8KSA0ETQfXjrTxqRjY+8TSNidkQwubKO+Nc5yEno=;
        b=Ke5M02VcnjtjDz+lCo0IweRutlI2TiQGN9LuRIhg2B7FV9ErBtEYI/Eq0AGCkXiMp3
         01g/viJq2WZtXmhxIbD45+3aOPlZ7xkRW7Z/KACB8bWRe1+r8M1czou3z3467WnfHAMw
         R6xBJ9krvDbQKrXSRUaXD25s6ChKLKGmAaSiYDP6G2lk9JR2p9p/Tss+j/UdItCqL7gA
         B7NoCZu6E3P4Tt8qPBzCmYP7YfiI+LobtQCPDrYOwcM8UsWZHpTPQ6jE5k7OQFG/fBye
         voavmxam7QjTQz8vsOrP9kSGxgLavqIo18qma+92tfF0m9Y6+4wx2Kzv8DRQFYJ19NGr
         cXIA==
X-Gm-Message-State: ALoCoQn6cUJTpzCDsHGgP6rGmsJ7ou3qKOUAzxL7KSoqlhEXF/abMMO5XQdzRtNo/3OF6dNuWNUH
X-Received: by 10.58.69.49 with SMTP id b17mr1509730veu.26.1403275412347;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si665230yhi.1.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 354AD31C6B6;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E41ACE12AA; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252228>

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
2.0.0.420.g181e020.dirty
