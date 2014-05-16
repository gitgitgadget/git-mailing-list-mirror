From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 06/44] refs.c: add an err argument to delete_ref_loose
Date: Fri, 16 May 2014 10:36:54 -0700
Message-ID: <1400261852-31303-7-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM4s-0006Lp-81
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbaEPRhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:41 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:40279 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756948AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so521264pab.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pSVFlO24xrBlkb6wItrJcYCZ+neHCChpBdh+C+senU=;
        b=JgaN2wqTtA7yNJJduI2VcTfkj14poeVHpbzmTQ1puDY7uHaNGDYnMoSI6Pppen+pcL
         MNOZMZKkZdalGMXNoi6UX0lQmBNtJKDsElm0Vr/22Xp4bA1rgCzOPEelnXBpUR+VHTkZ
         l9qoO+QxyrMzMkNddGu7EFoC2xbXmCKcQ/mgDFvrGNd5k+JbPXbd9HHh07P1c6koT2OW
         gKj0eYY48hqmO+qVTJvqp2ZUU20Lk3c20/R6qReFNdf4z80zeFWPJhl1Dm42LkujCBUs
         x04qeUFwwuM2bfOVcp3FIPHdv+nnUH6DMYEv5qzKAtGYnb9MiqK+4iUuxT/uuSYU+QK2
         yN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pSVFlO24xrBlkb6wItrJcYCZ+neHCChpBdh+C+senU=;
        b=N7ZPqUuRtfrIMwisyeJ06Nj8RSzqGXH7b5nMPp4Jw7RNL7QiKSOhV+5PQ7OnQ4PL4J
         EWM6PbEjvgNQ7tVc0MR5DvwLZYM3HBvlwoyTTYL5P2o8KMqIoy1oHf4NCo0z1gs7c7rQ
         2J0vLhzShJp212Ix4c8S9sNrb0vYJjSl9qY/ZbkS81T+0Z7NBVgYa3WMxx9F588r1oN1
         x+QmJLL5z7fGS9KEEBjsY1QZeGYYaqkLIvNjDaslZZLbLeYHFTiQdxRziiYMMYkXlFQP
         +zqdXTipZAzfcyaeLj91ijeahNMtFRZf9MivR/AXtpPHH00yO9R2c2uujU8t56fw4SFM
         2gtw==
X-Gm-Message-State: ALoCoQnBMO/s/OLJzBIZ3nHnFNQ0aB+S8aS0dwyYvG41MaRlQPl7IdhEH8EuN8tiUF/3LjhaxLa4
X-Received: by 10.66.148.10 with SMTP id to10mr8757194pab.12.1400261856895;
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si368506yhj.5.2014.05.16.10.37.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B29205A40F6;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6426AE0A04; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249357>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Add a new function unlink_or_err that we can call from delete_ref_loose. This
function is similar to unlink_or_warn except that we can pass it an err
argument. If err is non-NULL the function will populate err instead of
printing a warning().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 57ec72a..bc444c7 100644
--- a/refs.c
+++ b/refs.c
@@ -2491,17 +2491,43 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0 && err != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+	}
+	return rc;
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
+		if (res && errno != ENOENT) {
+			if (err)
+				strbuf_addf(err,
+					    "failed to delete loose ref '%s'",
+					    lock->lk->filename);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -2514,7 +2540,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3494,7 +3520,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.rc3.510.g20c254b
