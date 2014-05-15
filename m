From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 04/44] refs.c: add an err argument to repack_without_refs
Date: Thu, 15 May 2014 16:15:01 -0700
Message-ID: <1400195741-22996-5-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sQ-0003g3-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbaEOXPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:39476 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so388997obc.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lCBGsM79w1WikC93qCXegoBlnERhsOT+dzY3qNKjAYs=;
        b=DC927gFwMvnE7pcECYenMZo9IPAlhT4WTnbj1W8tPzjF5KMGI/PwIb9WubU2nSUBKj
         I+S+QaRKuPN3eNZFI/81ShmM9qVX03QYaQFhJFiiiWnSxZ9442NF9URJ07Sr8AqcKYM2
         nB97+I3o40LJVah5PpRattwBnJ9AgRcPQ0IRdXbbI4cYzwq6xJ/8Jf7C7GOM4Vi0fpZ0
         msPGbmk5k4xd6F0TEauIbU6jkk04UTVtgyUJNYKc7s6/bqfryqu3XKs+8+e7UbOTY8st
         Tb8hOAgfvisZl+E8ZkOizgNrB7eBYkAvtsrRyI6roJ/ZX/hs4f4ccYIpt50XYJdKRYRh
         eB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lCBGsM79w1WikC93qCXegoBlnERhsOT+dzY3qNKjAYs=;
        b=nAW5kZkPowgv6BPPKuShoOztU5hkAo99Aak2G+K3ySKF4kPpU/9y6Z7VpPtpUDe+fV
         BfquRzjxH9PW7MyJPeMxazehfTzd6w/HwSt8LYcxRYeRTllL6uK+MG7U4QCeVYH8kBrU
         PR5ziRtStL8z9hbcrZFSLekxhj7TX1I1MNrvsh3riC4pCySKk90fb++QlhXCxldz5wxw
         LeZpYKBsDN3t8zOE2fHMQvz2N9LwHhsyPwYMCPeh0gk9DJEwHe1SoH04RLKOPHMM7n4Y
         VomvvnL3/SV6doAmlhmcDMmgLY8lM/VlkObOStBfW1Kzii/2byRGTpeLsAZimA/fR7oO
         MjJw==
X-Gm-Message-State: ALoCoQkcVdk1fUf2ZYo8vtWNnFYufJhIRH1EIShXK9Vz+9jiFquVqUNceR9rX6/yjcIn5BMcvb65
X-Received: by 10.43.103.136 with SMTP id di8mr5721682icc.14.1400195744588;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244834yhj.5.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5E2DE31C259;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0BD7E0528; Thu, 15 May 2014 16:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249221>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to a problem in repack_without_refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h    |  2 ++
 lockfile.c | 17 ++++++++++-------
 refs.c     | 25 +++++++++++++++++++------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 8c6cdc2..48548d6 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,8 @@ struct lock_file {
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
 extern int unable_to_lock_error(const char *path, int err);
+extern void unable_to_lock_strbuf(const char *path, int err,
+				  struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..67e9bb5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -157,9 +157,8 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-static char *unable_to_lock_message(const char *path, int err)
+void unable_to_lock_strbuf(const char *path, int err, struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
 
 	if (err == EEXIST) {
 		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
@@ -170,20 +169,24 @@ static char *unable_to_lock_message(const char *path, int err)
 	} else
 		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
 			    absolute_path(path), strerror(err));
-	return strbuf_detach(&buf, NULL);
 }
 
 int unable_to_lock_error(const char *path, int err)
 {
-	char *msg = unable_to_lock_message(path, err);
-	error("%s", msg);
-	free(msg);
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_strbuf(path, err, &buf);
+	error("%s", buf.buf);
+	strbuf_release(&buf);
 	return -1;
 }
 
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
-	die("%s", unable_to_lock_message(path, err));
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_strbuf(path, err, &buf);
+	die("%s", buf.buf);
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
diff --git a/refs.c b/refs.c
index 1a7f9d9..66938d7 100644
--- a/refs.c
+++ b/refs.c
@@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
+	int save_errno;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2217,10 +2218,13 @@ int commit_packed_refs(void)
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn,
 				 &packed_ref_cache->lock->fd);
-	if (commit_lock_file(packed_ref_cache->lock))
+	if (commit_lock_file(packed_ref_cache->lock)) {
+		save_errno = errno;
 		error = -1;
+	}
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
+	errno = save_errno;
 	return error;
 }
 
@@ -2427,12 +2431,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_refs(const char **refnames, int n)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
+		if (err) {
+			unable_to_lock_strbuf(git_path("packed-refs"), errno,
+					      err);
+			return 1;
+		}
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
@@ -2470,12 +2479,16 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
+			    strerror(errno));
+	return ret;
 }
 
 static int repack_without_ref(const char *refname)
 {
-	return repack_without_refs(&refname, 1);
+	return repack_without_refs(&refname, 1, NULL);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
@@ -3486,7 +3499,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.rc3.477.gffe78a2
