From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 16/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 10 Jun 2014 15:29:04 -0700
Message-ID: <1402439376-25839-17-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZx-0006FL-UH
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbaFJWbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:38 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:34590 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pb0-f73.google.com with SMTP id md12so206164pbc.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qu/8EgB4DgeISI/avKwjFizpOndQgukA5TMYJnF8Md8=;
        b=dCZWL5SO2DGTfrlzFlAssssX0d3Nmun5ALvBiVu+WL/firXD0aGWCXxoKbSOr5lMh9
         EHg6EiRaU54QmujjU3SKov1gvsPR01RGQOWzCWP6Cv9qiwvJQiypUz0JkCm/ZiDiPvfZ
         7Wg5vUtf+kpJNkkG7IhCYFt6ti6SKiBq2jmasEUVTzrEtqPXPwNNr3mdE3CDbodF63nH
         Cc3I7I4DY3Jq0YlOsB2LnIO3+M+0MosqRjIXA2rV7SgyzZA7Y/VP7hQo1CvCJMuQrFJc
         8G3DUL9q/nPUdY2Yz9idYz2CmFFXCX44IYXvRcGh130nGy845Op/N9HfRY4kOcHIoI0w
         MJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qu/8EgB4DgeISI/avKwjFizpOndQgukA5TMYJnF8Md8=;
        b=a/+AKwsP0T31vYRms10zu8BmQsjg99aUwnIJQlrbaUVAWynCJsEvSDwr8BudMNZ65e
         XyaYLPUDqcVpCrixQeE19jJKdKD7Gzz8pWdd5o0acZ29yKBBpbk3DRgJC879o33lvVzg
         Wd8WJm5QVEdLjIXoGS43IgfQBd/zWNkdv/fVNp/PcgJmEzAsuUux/XBiGL5EZEyPoutp
         snBZYU57kolQ5wD1pG6Qa1yPGQR9OreKqv7OI0RU3MJsNiqDSZUYFsq6NlhbILb/JIB/
         +NfeFMT3nzhhp8NQkKKH08Av2YBnefZQIrCcCc+mexCPy1q0V2CJiWTJyb9enDy6FJU6
         4Tsw==
X-Gm-Message-State: ALoCoQlvVD4W5Jd1eIPXr3vP5YZupF+L/PHNgxlw4OYTukHO1yt/Uk4GqH3rEeNr+OLBM6+1Q4U/
X-Received: by 10.66.169.79 with SMTP id ac15mr570430pac.48.1402439380673;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1396411yhg.2.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7CA535A472D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3EE08E137B; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251278>

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
index 81d3605..ff55670 100644
--- a/refs.c
+++ b/refs.c
@@ -2515,16 +2515,38 @@ static int repack_without_ref(const char *refname)
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
@@ -2538,7 +2560,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3547,7 +3569,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.574.g30c2c5e
