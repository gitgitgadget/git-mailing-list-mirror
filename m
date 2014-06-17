From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 16/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 17 Jun 2014 08:53:30 -0700
Message-ID: <1403020442-31049-17-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvl8-0007Le-9n
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbaFQP4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:25 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:50457 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1487163oag.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mo7wYuHv8MaKsNQMwUor2KIwgOlh8GwNUevbbmP/Qd8=;
        b=IHSrbM+akx4sdefBdcS2zGNUUCqUmbnWYOnx0qY8T5KuLBfaW267BMHjjHTnIW6Aav
         G83nFbA/aHKhBz2twoeQTU2CYjoRBG5BVictAoYL3L4IpuLa3jeapQhV6GoeoQKpEpU/
         +3Yf/ufRY/ZtI9vUnyoBz8KFqKU9g1m1bsZ3f4BQ3WsB/zPKq8xqJMxNV9zeDriuHHZk
         9l+ArK4faV0098P7DL5RbGj75GpR0uZjLXJMZp0U7jNPL9insjI+thL5m7lPLqAZD0Kl
         Cfgo3wDbhlLiGtuGs6sT1BTIa/hFoioHXQF2N3EaR7nDOFSlwoiclr0qZTbTtmq0VU1+
         gm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mo7wYuHv8MaKsNQMwUor2KIwgOlh8GwNUevbbmP/Qd8=;
        b=jReMV1b5wVSSLl+m8GwW9r6vhnzpVoZYu7wrs0rFKxvyx0anHA+vlVWrjQ40BN0kGR
         pACITIHjBZoj7LouiyboSHlHc7NN0jIkH0lsYbnSU4WFzmkYGdnMfCFQEjOap1/IqBQ8
         IsZpx/lX5jAPJxYO8skjN6SSvo0EVxoQ7C6Lx9Xa3Ar4KAS/b78aJDftWVyn+7AkN1EV
         ep6TmTG6Ks8VqWn6YoX/JrKjfuQzTdFWoGKdVL/q+gUXQrmIi8SJq2Di4srrpLnpMAKG
         QpyI7VXk1ZBZMr5d0CludXm7zVYwngi0WGE4a8wphBr90EkGYbmumIJnl6uBHRZhTYUB
         YOQw==
X-Gm-Message-State: ALoCoQkVmcaxf5pLsz3d58Uy5eF5ZqYruzmKU2XovWl51YjCFanqeta89aQNcEDJDClxMqZemY6k
X-Received: by 10.50.32.4 with SMTP id e4mr710750igi.7.1403020444883;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1209460yhg.2.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A9D7B5A4367;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6CB19E10DE; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251909>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Add a new function unlink_or_err that we can call from delete_ref_loose. This
function is similar to unlink_or_warn except that we can pass it an err
argument. If err is non-NULL the function will populate err instead of
printing a warning().

Simplify warn_if_unremovable.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c    | 35 +++++++++++++++++++++++++++++------
 wrapper.c | 14 ++++++--------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 4c1612a..7223542 100644
--- a/refs.c
+++ b/refs.c
@@ -2543,16 +2543,38 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0 && errno != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+		return -1;
+	}
+	return 0;
+}
+
+static int unlink_or_err(const char *file, struct strbuf *err)
+{
+	if (err)
+		return add_err_if_unremovable("unlink", file, err,
+					      unlink(file));
+	else
+		return unlink_or_warn(file);
+}
+
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_err(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res)
 			return 1;
 	}
 	return 0;
@@ -2566,7 +2588,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3573,7 +3595,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..740e193 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	if (rc < 0) {
-		int err = errno;
-		if (ENOENT != err) {
-			warning("unable to %s %s: %s",
-				op, file, strerror(errno));
-			errno = err;
-		}
-	}
+	int err;
+	if (rc >= 0 || errno == ENOENT)
+		return rc;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
-- 
2.0.0.438.gec92e5c
