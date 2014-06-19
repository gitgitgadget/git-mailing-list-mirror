From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 07/48] lockfile.c: make lock_file return a meaningful errno on failurei
Date: Thu, 19 Jun 2014 08:52:49 -0700
Message-ID: <1403193210-6028-8-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxehd-0001G2-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080AbaFSP4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:32 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:54602 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so296268pbc.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=saBgioEbpqshmS52H+C9xe3qrrcVmBp9vmiAoAm4ViI=;
        b=GPSJW1uGfvp2TSXGikZgJjRCFBY9iNnVk9jqicM31aq2d37ZAzmTi2gIuOPYs8SHro
         P/xhcI/6bALoA8/uLglkH+B6zUWUiHR6scmhkO50yTXYrB5zzh3UcHT7qW8GeEZjKOdN
         LIL3E5MJLKPiG804EH9Nz4GcQlbaB30Fq4ZU+PWV9h15J4E9lCGN5W65opb9vXK7WmQ0
         KgP8pyhLxkn4WcSykbOJ2tceYfvk/eCjfOB9xQopKBpil/h+92PWOxlvnB9tiBlcxsRm
         07THBnp+KanXNedMbD9bW/+qY+OWqkX7lHdpEqJvKzqWNSmSKBH5/cC9SwMnt0/Z1N8s
         oPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=saBgioEbpqshmS52H+C9xe3qrrcVmBp9vmiAoAm4ViI=;
        b=Q7aTLwA0Bp+qi8xd4YUkUh0mjRG0WSQXE4OFfd9mpFDoBfmjZZh5Sa3B5YRYPuXECs
         V8mV/+rqadyF+g9SNBK00wKJ2NVCsmz49pgNgDQ2sT5HJtutsJzuNfbUzqMaFNqOS0ny
         1hf5BNEkl/2j1ZIDsUiWCWdgYGXU+Xrw98RLyMBCkkT3vV0iWfc89VUQBvVQLyw1rGBX
         WoMPWjQeDC3Su+2jzDlRQXXMjb7GNyxpU7fE/GaXkcdzp0J7qUcrvEidqhLs2fi6hRtp
         r9d7LCGyO0OUXxdTzzb9f+CY2ZaiRO2F13jBPIIl4TrfvXJ2TKfCzn5uqvSDBtWY+n9P
         G9rQ==
X-Gm-Message-State: ALoCoQktVzkOah2Hjsg76g+QXrlhQCpBw9DYGoVHJOAuxw3ihCSMt/OShHR2Gh432cXkuSJ9+edr
X-Received: by 10.66.65.109 with SMTP id w13mr2642523pas.21.1403193213171;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si418315yhl.7.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 01DCD31C3A6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7BF56E094D; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252163>

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
2.0.0.438.g337c581
