From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 08/41] refs.c: add an err argument to delete_ref_loose
Date: Tue,  3 Jun 2014 14:37:26 -0700
Message-ID: <1401831479-3388-9-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwTM-000847-L1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934160AbaFCVmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:42:04 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44026 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934075AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1534276oah.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVvwE2cguw60d4T4Q8RORrWP5fGL1LLaTqxW5tKz7bM=;
        b=dQjPsu/nS3lku4j3zx4rTdgtz0P+nQMWNG5d/3uHhemH6RJ8YT885C57rVN1Q8eR87
         JplGMRezF+21bTLkb4YL9CF01uqP2OVU2B/tNtgGppAB4u71WjngvdIriHeGXqFTyUss
         96eRZ9isahsIiJra7tcpejPQtLhbmCXCJZqJK/O+6EiqnNvYRsqIX5xO2YnNQ558hubT
         cZ23CHleb9B/hlP3eaDDozoIcHiwuV5CJC7AJhAFVVoIWa5yQyjbfXH57WdMKE1FVrtb
         lpsdp9SHLB15tWhWxjwGfEd5euhURQX3bHFyY5OdbJ0DUurxypTMBoB+e4RAV/F1V2pi
         IeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aVvwE2cguw60d4T4Q8RORrWP5fGL1LLaTqxW5tKz7bM=;
        b=L2SIwczCFIs3gxNtrkE2BIK/4ATcopqJaKOMfXfzA+x/SsRYZwHcRgQTMsZC3eVE3K
         unYUXTFzWkboRU/BVLifCKvbQGeDQpUFgM9CSK4VL0qBTpAhj+R2UYr7Uvv4lCdLReR0
         eLmFWV12D9LprFa/tg5ukQuZhwZ4X4/4sY3yxH+QxTBf7hOa0rPbVozhSaaztl+Krlao
         4+xRnb1kaPnkEz8m03wkG8lMdRneDywi1GMf7/HenHDuDpX/ljwo+Hqlr2CGJLG8+W2q
         wmrVLLQlI5hiqH3+leDVx13xlV5FskbgUkdUHLneDpRjrgzRSibsnOx3ZXcaK0GJo4xU
         pXHg==
X-Gm-Message-State: ALoCoQmoDS681J1vbpvFjYFpbSC+xE3nVmcJUVF0iD4ya1j3aJfrphF6vaC85pcgAVJidzNTII8u
X-Received: by 10.182.106.229 with SMTP id gx5mr19462694obb.31.1401831487257;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si8967yhm.0.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0535E31C4B6;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 96C69E0AA8; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250688>

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
 refs.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2d6941b..dd498cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2510,16 +2510,38 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0  && errno != ENOENT) {
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
+		if (res && errno != ENOENT)
 			return 1;
 	}
 	return 0;
@@ -2533,7 +2555,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3540,7 +3562,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.567.g64a7adf
