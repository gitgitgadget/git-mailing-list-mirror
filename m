From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 06/41] refs.c: add an err argument to repack_without_refs
Date: Tue, 27 May 2014 13:25:25 -0700
Message-ID: <1401222360-21175-7-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNzj-0006nO-FY
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbaE0U2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:28:11 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:49921 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so1918746ieb.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yN1XvTJa9TP43VfhaSe4BeYLD7pbUCwB0ZyVZ4lduvE=;
        b=XPpe6sEX/xbZPAZik1QlLxaNDhQw/QMNFBTs+yuIznxJ8tj65qxaCVXDO2sB6iU8uZ
         N/rcYc000EUg99EXzKD6yQjFAoN9oD+Ah7Trzku9Khst4CakJ8OU0g8EFm1BQhpooCjn
         C4tA8+Tmc7TakM1REqkZDn9HLEnUz8ihiBGvCHvvGjaA4EoS/Np6elVrNhpNdnejSXls
         Wmt9v/IA6xkK9WPx18/gJHaykO9vw5Uh/pKhdiR/Yjve1jmIi0pbzS+l2wyIdfF727by
         qT0t5Lc3IEJBFTkTNqtEVZ6Upe3BkeAeDC6L1B1NlZ/huEJ6SafMzkQibOoOQjmAIru2
         hjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yN1XvTJa9TP43VfhaSe4BeYLD7pbUCwB0ZyVZ4lduvE=;
        b=btrQaxq4E/iunPQ7pOwQ4NmQsUTHRI6vUTwUE97ktztxEpSqpKRcuJs7K1TX82sjV0
         N9nQPYhPvDl47ZEPCK3/IW2tYs6VwJc28iVfqTaqB6QYsfPag5L85i7v4CZ5GgVL4zS3
         S0eTGPTPvggvuIfyx0t+pwcJI80zw+zD1QzlWw+hE1i8Y9madC3MTICC6BUaAGsGqoHU
         Cw5qWPTGZef43Yg6Q7CyzvpsG8cBfBuZZ2RWqY0BveN4hYEEc23Sis/J0a2lgA6pD1iC
         yLs6Q8p6D6vU4faKQjkTDr6L7BLAQmuScn1Jsr7MKeULC3S+6BJr/Ejf2n8t3cfOAJ6/
         IaTQ==
X-Gm-Message-State: ALoCoQn/ozMJ6LaqPMaQMqeD70G0/2Kh45coFYHFb7ZI+fXuDmTDJjm9a2rdf5jAzOaKypO7eK82
X-Received: by 10.182.250.229 with SMTP id zf5mr15301906obc.4.1401222364166;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si1575166yhq.3.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ED4A32F4AE0;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98ED1E1958; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250238>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to a problem in repack_without_refs.

Add a new function unable_to_lock_strbuf that takes a strbuf argument and
fills in the reason for the failure.

In commit_packed_refs, make sure that we propagate any errno that
commit_lock_file might have set back to our caller.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h    |  2 ++
 lockfile.c | 21 ++++++++++++---------
 refs.c     | 25 +++++++++++++++++++------
 3 files changed, 33 insertions(+), 15 deletions(-)

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
index 8fbcb6a..9e04b43 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -157,33 +157,36 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-static char *unable_to_lock_message(const char *path, int err)
+void unable_to_lock_strbuf(const char *path, int err, struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
 
 	if (err == EEXIST) {
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 			    absolute_path(path), strerror(err));
 	} else
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
+		strbuf_addf(buf, "Unable to create '%s.lock': %s",
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
index 25c3a93..2da62ac 100644
--- a/refs.c
+++ b/refs.c
@@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
+	int save_errno = 0;
 
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
+			return -1;
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
@@ -3481,7 +3494,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.rc3.474.g0203784
