From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] reflog.c: use a reflog transaction when writing during expire
Date: Mon,  1 Dec 2014 23:46:42 -0800
Message-ID: <1417506402-24257-5-git-send-email-sbeller@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 08:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XviB4-0006d2-8U
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 08:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbaLBHrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 02:47:13 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:39138 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932980AbaLBHqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 02:46:52 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so14523894igb.7
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 23:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ir+UHUcWinpcbcbqrIogVqdp5pjTorhDhl4+hHQ8fes=;
        b=Is3PDwKY9v0kFrvscHhfxolgxtZ20z5InCUCARlSkmtEyPRT+4pMQ5DxSaIuTILKyh
         kAi52/Bh6UjGdSv7jp+7on/7yazjvRhbKIoIBz5FoEI2AaN6bdnXHGNqjECJQ7qTROLm
         QaQ/om+msXRK2VCjj1yR/yBp5VCfxLIwC5Y/0+wVFXgp524zGGqNC1q8V85Afx88Yi84
         t5AUVDrYWEsQx4w1ZULF3va6A0OYR6aeVtGsT1AG64pZgOUOGJNkFynxLwV7czQrlC92
         1EYOq69wdFKvvqTfyR8bUJhlGLDfM0V/3cuV4Z/vEnE+2JPuS2wusX+MbHzYELGVyGh1
         joDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ir+UHUcWinpcbcbqrIogVqdp5pjTorhDhl4+hHQ8fes=;
        b=jmlycAJMv9wU1bY1V97ZVtK1a1JO7wtX74/DIYCYEneSEogUA2rHJUCDgPU2OlN+u2
         /nlvNi9C5JjXwhkDqjdu2IyUvV80ewQqBnGUn6FdzSGAW/VnKhpFBzOCIYrKII65v5G2
         r7ji4NSY5cPk62TgkjjTqBo7RGhOoC3KS96h62LXdD/YfV778buNw3yZl9uxeHWxEMPd
         ow03SrdLJ4gMiLhuAtqjENp5dV+lLblwXaNV8q7M2OuHwGXLnrJ8DwX50O6TMkGcRIXO
         nNfF9YW50v66ahxdd1AbKt6LFZG7fXs9QfbNQKp5WkA2y1OCXyQtWUR7uHBzKVL/IXR6
         iOOQ==
X-Gm-Message-State: ALoCoQl/xLOxHUEyT+TvuIKlvTTe1wVjSFRlSnltGn56ztVyH4QpcyTcjMisqSMzaBFrgjdAX2D6
X-Received: by 10.107.136.146 with SMTP id s18mr56529241ioi.36.1417506411321;
        Mon, 01 Dec 2014 23:46:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id p198sm10783011iop.36.2014.12.01.23.46.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 23:46:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417506402-24257-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260548>

From: Ronnie Sahlberg <sahlberg@google.com>

Use a transaction for all updates during expire_reflog.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

no changes since sending it 5 days ago.

 builtin/reflog.c | 86 ++++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d85d26..55f3023 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -33,7 +33,8 @@ struct cmd_reflog_expire_cb {
 };
 
 struct expire_reflog_cb {
-	FILE *newlog;
+	struct transaction *t;
+	const char *refname;
 	enum {
 		UE_NORMAL,
 		UE_ALWAYS,
@@ -290,7 +291,7 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
+		const char *message, void *cb_data, struct strbuf *err)
 {
 	struct expire_reflog_cb *cb = cb_data;
 	struct commit *old, *new;
@@ -316,20 +317,18 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
 		goto prune;
 
-	if (cb->newlog) {
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
-		fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1),
-			email, timestamp, sign, zone,
-			message);
+	if (cb->t) {
+		if (transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
+					      email, timestamp, tz, message, 0,
+					      err))
+			return -1;
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
 	if (cb->cmd->verbose)
 		printf("keep %s", message);
 	return 0;
  prune:
-	if (!cb->newlog)
+	if (!cb->t)
 		printf("would prune %s", message);
 	else if (cb->cmd->verbose)
 		printf("prune %s", message);
@@ -353,29 +352,27 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
-	char *log_file, *newlog_path = NULL;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	struct strbuf err = STRBUF_INIT;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	cb.refname = ref;
 
-	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
-	 */
-	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
-	if (!lock)
-		return error("cannot lock ref '%s'", ref);
-	log_file = git_pathdup("logs/%s", ref);
 	if (!reflog_exists(ref))
 		goto finish;
-	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", ref);
-		cb.newlog = fopen(newlog_path, "w");
+	cb.t = transaction_begin(&err);
+	if (!cb.t) {
+		status |= error("%s", err.buf);
+		goto cleanup;
+	}
+	if (transaction_update_reflog(cb.t, cb.refname, null_sha1, null_sha1,
+				      NULL, 0, 0, NULL, REFLOG_TRUNCATE,
+				      &err)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
 	}
-
 	cb.cmd = cmd;
 
 	if (!cmd->expire_unreachable || !strcmp(ref, "HEAD")) {
@@ -407,7 +404,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		mark_reachable(&cb);
 	}
 
-	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	if (for_each_reflog_ent(ref, expire_reflog_ent, &cb)) {
+		status |= error("%s", err.buf);
+		goto cleanup;
+	}
 
 	if (cb.unreachable_expire_kind != UE_ALWAYS) {
 		if (cb.unreachable_expire_kind == UE_HEAD) {
@@ -420,32 +420,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		}
 	}
  finish:
-	if (cb.newlog) {
-		if (fclose(cb.newlog)) {
-			status |= error("%s: %s", strerror(errno),
-					newlog_path);
-			unlink(newlog_path);
-		} else if (cmd->updateref &&
-			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
-			status |= error("Couldn't write %s",
-					lock->lk->filename.buf);
-			unlink(newlog_path);
-		} else if (rename(newlog_path, log_file)) {
-			status |= error("cannot rename %s to %s",
-					newlog_path, log_file);
-			unlink(newlog_path);
-		} else if (cmd->updateref && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
-		} else {
-			adjust_shared_perm(log_file);
+	if (!cmd->dry_run) {
+		if (cmd->updateref &&
+		    transaction_update_ref(cb.t, cb.refname,
+					   cb.last_kept_sha1, sha1,
+					   0, 1, NULL, &err)) {
+			status |= error("%s", err.buf);
+			goto cleanup;
 		}
+		if (transaction_commit(cb.t, &err))
+			status |= error("%s", err.buf);
 	}
-	free(newlog_path);
-	free(log_file);
-	unlock_ref(lock);
+ cleanup:
+	transaction_free(cb.t);
+	strbuf_release(&err);
 	return status;
 }
 
-- 
2.2.0
