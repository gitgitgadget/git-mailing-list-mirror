From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 40/48] refs.c: add an err argument to delete_ref_loose
Date: Fri, 20 Jun 2014 07:43:21 -0700
Message-ID: <1403275409-28173-41-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy034-0001VS-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbaFTOoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:08 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:54355 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so506793qcz.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FG0CpyxFZggZbeGioApMF7Q6dpC5HPaq5WtgJFvfpZM=;
        b=DaNUeAC3kXTqj3hmRUExK6HE20vG1/2gkzaDzd6t3z34AuZuHtRGj/38KFp18M/inl
         hToHiUr6pawAP8jTPL619JyUfCJxkhB52GnKFK0IFuRj1iFcXUa5ng9qAAYQHTJ43wuM
         eib/8emOVMh6T76uY0uPT4V2WuacXDKFPvUDwSBWeN0el/2xxZVmplF9zLW9itvt64Si
         xjow49n1/VuzPwL/EIZIk/aU7Cfk/w4PFQjL03kTqRWnKRB/tBakUOKrkP30UCjT7NzO
         L+DIO4QPN1+/RXZDub95kpO12XYJxcyKT/y9gIpN4i6TVSeWUkjrAKwHL59wG7DRX5n8
         BStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FG0CpyxFZggZbeGioApMF7Q6dpC5HPaq5WtgJFvfpZM=;
        b=CUiokaSO+RbgD40n7XRcmTZkKGKOlEMonDb4L3gfsz/ke+glHRkmhe5z475wguHVsf
         w8FNbaJhKIE6muN9jnZSUhAWJNeqRMwecdFG9HZ4d9vLaxy+/kXEzpQ95nOIZdB58K9O
         MnYhXKv826RICD87TWbF+FpYQVjc6m8TzDLGpcd/BwzOVlKYfRL4F8BU3pL+Z7cgDVTj
         Gr5YeLTT+6EIYAoZZXXDwiVe/AzSY6ZO+iOx/IXXrSpmaZuHxm37i1q3FEiM1fAGltg7
         bgODJc4oZYWvOyPgtQhXt/aqGFZI56TNwrdOvTjp074TyHg3ttyHEEEnl1w+p7zOKQ01
         4tcQ==
X-Gm-Message-State: ALoCoQlqGIScI3H+rV/domMwqje0GyAmZb7rWTZ298f2lJpxtZX6LZ0Wnxnrlk1VGbeBE/6n5RCa
X-Received: by 10.236.197.226 with SMTP id t62mr1288851yhn.50.1403275413683;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si664710yhb.3.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8908931C6B1;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69420E0A04; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252237>

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
 refs.c    | 33 ++++++++++++++++++++++++++++-----
 wrapper.c | 14 ++++++--------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 92a06d4..c7d1f3e 100644
--- a/refs.c
+++ b/refs.c
@@ -2544,16 +2544,38 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	return ret;
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
@@ -3603,7 +3625,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
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
2.0.0.420.g181e020.dirty
