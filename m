From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 08/41] refs.c: add an err argument to delete_ref_loose
Date: Thu, 29 May 2014 09:07:44 -0700
Message-ID: <1401379676-9307-3-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sN-0006TU-IC
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbaE2QIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:06 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:50593 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbaE2QH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:07:59 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so105495oah.2
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTESxsvIbwZe+xdppM2VEDy4L+fDUrp6EaKKd439H0k=;
        b=d0drqDQLHQptyFLfnDxYJvvIZf0K0kB05DYwj165h7O2lTYJH4nje/RVd/pjSwKcCZ
         pdnordbgzdwcUN2UpOflpJ45bzoMyLwnsTh7LvxWkO6xArA9ASUDg62/eLHCxqOZkSZj
         7fr5z4cJhQfwDRWrN6U1bqO9pwdd6/GDUVxd1G7EC2EoapQLocsVfZ8Z/GTVaVizoS9L
         dVNoLSzMVlc+uNN7f90BxdkH20CX2OgWUUy4fJ1Avl5ICYDOJBXmaRt/YOvTn3c8EcPA
         GqdU+RaY7+wnKFQArSF7Ykq5CzBws1NG4bD//XsjwhSA2pBaoGfY5z9oPILNyS3xX5mT
         Rf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTESxsvIbwZe+xdppM2VEDy4L+fDUrp6EaKKd439H0k=;
        b=TigDFJ1JOfhCnyZ+aLFaJUu5Mv+Wv29DK0hXTNE6bI5/4HbabOJecu+kvnxJvTDJWN
         TGILSX8hJ+VaPuxxFiOnun4bbribXyqFwb2SlCr1SfA8G84GslRXov7truxasJQAz14d
         83QEAX8LsWXZ2YQE5w9/azz4VoXtH4vCAbPZePgZyUDeRSnI6r9jgenPaI+DoxM9nhK8
         yFigDfdCkFA+pJZLcFvNKB22og9FIEw2CvBmY/zHxdHWe4GGjCru/eMU8FZvB4MSKxLM
         fy4g46FzhOMaB/rq+zGg/2YgcCYf/NedqXo6XjHfznTzJhmAyxOnlzxqBUdug4SWUAWM
         +6kg==
X-Gm-Message-State: ALoCoQmBeVvenK+eRmgn3Ad6SJ18CwERNqDSXqCKT2y3hQvmbAqRBkGr0BtmAg8LcXa2OSNwQdcu
X-Received: by 10.51.17.10 with SMTP id ga10mr3449941igd.4.1401379679218;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si80317yhl.7.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 103585A4340;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A9C8AE06F0; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250378>

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
index 9d079ec..d768a5e 100644
--- a/refs.c
+++ b/refs.c
@@ -2491,16 +2491,38 @@ static int repack_without_ref(const char *refname)
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
@@ -2514,7 +2536,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3494,7 +3516,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.rc3.474.g3833130
