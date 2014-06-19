From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 40/48] refs.c: add an err argument to delete_ref_loose
Date: Thu, 19 Jun 2014 08:53:22 -0700
Message-ID: <1403193210-6028-41-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxef9-0006a7-2B
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbaFSPx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:59 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:38389 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so694266iec.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4MTnLcCyq4MtpYjIKpXm5SQ+OywnE2n2ls4FZP0jdY=;
        b=cx6Tnwp6LRSjLpyxZpOYI4somhyFswABXhzzy1vagRe1mw/2kmswlnbNU2zFdZuvZb
         3FZrtVkfH2SAdSfEKFpalG4RDKGnBpt4G146yD1xJaU8nOHNtRD4NQYd8KzX7BbW12jh
         35hKLUT+nPsoCgzA4Y76GprsvsN4e+m1elax/F1rgeEy8m2jS+MjX0b3zn7ws3OuT/gt
         DJ06qNACbfLyxEwld0+54W/qxBRMDBJ1wEhVdizQzKaV8c+J4dMWGh+wQrjchMzUSx8R
         ROL9kFfoRAPs6Nkziy0ALbKOy4VkCVNwL7brQSJCUHj2SPmzPriaZsSlI6XAJ6B53M+s
         FQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4MTnLcCyq4MtpYjIKpXm5SQ+OywnE2n2ls4FZP0jdY=;
        b=QtCB5T9z9y2Hxsgoud5J4CE2RGs6BTReeHn2ZNrHT4iyaqzRl8smqsfnGPh6glQO73
         876REpwnBNPlojgRTu1GVp7x6HT4r1YALih4Eb6f7DhXaPSXaaCb4sEW8cn6Vxq8fYir
         10VohnyLrFWL2SkPiN15NCoGYsPyiohWrCy1LoGPcNAZCSd8SMHAAk9dRRUGViMEsQfk
         VLm1dQwCBaorWHGtvLFF9LzxEbCPkkxZBvkA83f00jFfIWnyFhjhySdD12E85ncpWEF5
         cM8TNkubrxdsfSS22aPApYUJRYrBNQjlXlbgdAu3eVTT6m5DkHXNIbp6wbxzX2x+o4gx
         46BQ==
X-Gm-Message-State: ALoCoQl8OorC335eYQsGiRW5rGMA9pm/oPKBbAGHjfXoklfXWfZYrNqqP0hArrX3cASb8lNOxx6U
X-Received: by 10.43.12.67 with SMTP id ph3mr2456096icb.28.1403193214303;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si419496yhk.4.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 287DD5A4435;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 08D78E0734; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252125>

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
index 15cc5f9..fee7d76 100644
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
@@ -3600,7 +3622,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.g337c581
