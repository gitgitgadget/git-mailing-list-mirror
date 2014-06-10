From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Tue, 10 Jun 2014 15:28:55 -0700
Message-ID: <1402439376-25839-8-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaZ-0006or-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbaFJWcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:13 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:42162 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1714666obc.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8d+iyvAsbzd7Y1MDZf2uryZypiBkGrGtIA0JX05BnE0=;
        b=R22dDQY7FUpOqmJq2gHn2nzng4f5FmsC7m3ZVqLr56XOFB1W+XPxW3Edo0OEUxMdM6
         yTnqAcA/RW82pvw7RWHh170EgwW55OHkJBom2VhtIvf+cBA8wOVtk8Cu2zZ1LadDSIph
         7lCaHtnWyzXIM8+gFQchpxZX3L7Juv2F7/qcnVMaXzLTny9sS75NLe30WrxETewdzndy
         4uAK468E9wO9V0AXz6dOLVfJce5zyyfp27o7yczoVw9x9pdnH4vgTTnUF/Xm1+5gc00i
         iYwND6jGRWkxYG21QDtSvynGUTHirYnEhZBnJbmFUtIRovd5tFyu34u9jUC0KSvT+zcX
         tJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8d+iyvAsbzd7Y1MDZf2uryZypiBkGrGtIA0JX05BnE0=;
        b=mgsH8ge7saQVOPwm0/rbbdFH0fw7YASy9yT6vQhJHruMSwF8CHLan9kFFDXHva7b0s
         N6e9XbBCG3THvg0ipq+dMcuqx5Vo//aJybAhbNC7znnq63AD641ZWkAqpeZbopUbO3VJ
         ohVE9iWvMtnTzr55K6Z9sTqC1iyqKzIteL+vGAwn++bM7wjsyJEEmfX4qFFiAaa9p9pt
         LQcQcBLU6w/2ZejxRU61ufrk35rAD4rjPELdjM24gl4A3f27I5P5ERNWqy4VLMfyyzCi
         uhOwlXshSHXwkkDOFOWFIhRwyWdYn5INQ37l6SA9Gfs9XrDRci/dhr8SLV/qTk+iqWzj
         UrKw==
X-Gm-Message-State: ALoCoQlrIYnSCJIt0VQhrb8JO11J6XKr/vIsMa9hR81nVxY7pQlVDlCPwhYg6SCNOG+dMfVN5YFg
X-Received: by 10.42.136.1 with SMTP id r1mr16171156ict.24.1402439380477;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1394547yhl.7.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 42D125A46F1;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C0C95E0BF1; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251307>

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
2.0.0.574.g30c2c5e
