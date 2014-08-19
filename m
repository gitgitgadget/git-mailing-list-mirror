From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 06/23] refs.c: move rename_ref to the common code
Date: Tue, 19 Aug 2014 09:30:30 -0700
Message-ID: <1408465847-30384-7-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJS-0002OV-AH
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbaHSQbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:04 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:61851 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so798179yha.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8sqrN6nWjHJyISwpXw/mvKhrSGuQZxsQwvOxlpdDs4=;
        b=Abi64cnJOfXj7J2mBUrpqIGJAaCQgfavzB/AjWd8s6jbiY4AlCfHZ71OoT6Hy0U51Z
         KJN9A9/VJDS+1HMipHYdr/KwdUgHCdY1bvBW7tOEfJ+wU3surD+c+yRAt5NpwMVRRsMR
         XQTkYd/h6uBqE8rn27/qkYpPneQOCNpzhS4q9fmYHotdZ78tHrQIo/aUqhECW3b9v5ky
         qDBifJ1I2diaeD3P1TjDEJBw90hiiqt/myV+QlSiAt19xpjjt00KEE6WfAVloeK16Uh6
         mODlqjrdBx4wJD8wFFqwogrYhBQwTZCKuxZlLb4+56o/ram4ljBoKigeZlIKfm22p2h3
         nWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8sqrN6nWjHJyISwpXw/mvKhrSGuQZxsQwvOxlpdDs4=;
        b=HrGAa1LPIu1IVInPJFgoF6jNRwsmAGNu/eADK9z1GP+iXGJymhOLYWmoBDaEBGpIZN
         BHmXRztCGLLWwHYvlzQYccP6dttaCbbZFP4L+DG2IGViP6yu+m0dD+l5MywfMRLjJO6m
         JtVUBcgbvuy0TZET142VjrL/OE4jQJT98RGQ/nrhbXWRMAzvrTI1ETgXU6xgGjj1xIor
         IpEqMWkBD+cCjEJBKFxljSXcp6yN1n12vNdXDmt+IpymYzDkXh7ivzkBQPKXfVHYYY+c
         mJhxNMglyrMQp01iyrmO8kadf3e68jY/3cx6iRNU3IQxPxl5l+cTkCQXa1c4meSB3JXJ
         +rGw==
X-Gm-Message-State: ALoCoQkWwrJznrIuRELoksPg64n1krfhpmLrfzN7M5lfMF//L5buosn1qtwT2HR/o9GrmHz7lwvR
X-Received: by 10.236.11.80 with SMTP id 56mr4918819yhw.22.1408465853247;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x19si332773yhg.0.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E88695A441C;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8BB24E119C; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255477>

This change moves rename_ref() to the refs.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 92 ---------------------------------------------------------
 refs.c          | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index faf794c..7d579be 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2622,98 +2622,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-struct rename_reflog_cb {
-	struct ref_transaction *transaction;
-	const char *refname;
-	struct strbuf *err;
-};
-
-static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-			     const char *id, unsigned long timestamp, int tz,
-			     const char *message, void *cb_data)
-{
-	struct rename_reflog_cb *cb = cb_data;
-	struct reflog_committer_info ci;
-
-	memset(&ci, 0, sizeof(ci));
-	ci.id = id;
-	ci.timestamp = timestamp;
-	ci.tz = tz;
-	return transaction_update_reflog(cb->transaction, cb->refname,
-					 nsha1, osha1, &ci, message, 0,
-					 cb->err);
-}
-
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
-{
-	unsigned char sha1[20];
-	int flag = 0, log;
-	struct ref_transaction *transaction = NULL;
-	struct strbuf err = STRBUF_INIT;
-	const char *symref = NULL;
-	struct rename_reflog_cb cb;
-	struct reflog_committer_info ci;
-
-	memset(&ci, 0, sizeof(ci));
-	ci.committer_info = git_committer_info(0);
-
-	symref = resolve_ref_unsafe(oldrefname, sha1,
-				    RESOLVE_REF_READING, &flag);
-	if (flag & REF_ISSYMREF) {
-		error("refname %s is a symbolic ref, renaming it is not supported",
-			oldrefname);
-		return 1;
-	}
-	if (!symref) {
-		error("refname %s not found", oldrefname);
-		return 1;
-	}
-
-	if (!is_refname_available(newrefname, &oldrefname, 1))
-		return 1;
-
-	log = reflog_exists(oldrefname);
-	transaction = transaction_begin(&err);
-	if (!transaction)
-		goto fail;
-
-	if (strcmp(oldrefname, newrefname)) {
-		if (log && transaction_update_reflog(transaction, newrefname,
-						     sha1, sha1, &ci, NULL,
-						     REFLOG_TRUNCATE, &err))
-			goto fail;
-		cb.transaction = transaction;
-		cb.refname = newrefname;
-		cb.err = &err;
-		if (log && for_each_reflog_ent(oldrefname, rename_reflog_ent,
-					       &cb))
-			goto fail;
-
-		if (transaction_delete_sha1(transaction, oldrefname, sha1,
-					    REF_NODEREF,
-					    1, NULL, &err))
-			goto fail;
-	}
-	if (transaction_update_sha1(transaction, newrefname, sha1,
-				    NULL, 0, 0, NULL, &err))
-		goto fail;
-	if (log && transaction_update_reflog(transaction, newrefname, sha1,
-					     sha1, &ci, logmsg,
-					     REFLOG_COMMITTER_INFO_IS_VALID,
-					     &err))
-		goto fail;
-	if (transaction_commit(transaction, &err))
-		goto fail;
-	transaction_free(transaction);
-	return 0;
-
- fail:
-	error("rename_ref failed: %s", err.buf);
-	strbuf_release(&err);
-	transaction_free(transaction);
-	return 1;
-}
-
 static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
diff --git a/refs.c b/refs.c
index 70b12eb..319eafa 100644
--- a/refs.c
+++ b/refs.c
@@ -45,3 +45,95 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction_free(transaction);
 	return 0;
 }
+
+struct rename_reflog_cb {
+	struct ref_transaction *transaction;
+	const char *refname;
+	struct strbuf *err;
+};
+
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *id, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	struct rename_reflog_cb *cb = cb_data;
+	struct reflog_committer_info ci;
+
+	memset(&ci, 0, sizeof(ci));
+	ci.id = id;
+	ci.timestamp = timestamp;
+	ci.tz = tz;
+	return transaction_update_reflog(cb->transaction, cb->refname,
+					 nsha1, osha1, &ci, message, 0,
+					 cb->err);
+}
+
+int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+{
+	unsigned char sha1[20];
+	int flag = 0, log;
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	const char *symref = NULL;
+	struct rename_reflog_cb cb;
+	struct reflog_committer_info ci;
+
+	memset(&ci, 0, sizeof(ci));
+	ci.committer_info = git_committer_info(0);
+
+	symref = resolve_ref_unsafe(oldrefname, sha1,
+				    RESOLVE_REF_READING, &flag);
+	if (flag & REF_ISSYMREF) {
+		error("refname %s is a symbolic ref, renaming it is not supported",
+			oldrefname);
+		return 1;
+	}
+	if (!symref) {
+		error("refname %s not found", oldrefname);
+		return 1;
+	}
+
+	if (!is_refname_available(newrefname, &oldrefname, 1))
+		return 1;
+
+	log = reflog_exists(oldrefname);
+	transaction = transaction_begin(&err);
+	if (!transaction)
+		goto fail;
+
+	if (strcmp(oldrefname, newrefname)) {
+		if (log && transaction_update_reflog(transaction, newrefname,
+						     sha1, sha1, &ci, NULL,
+						     REFLOG_TRUNCATE, &err))
+			goto fail;
+		cb.transaction = transaction;
+		cb.refname = newrefname;
+		cb.err = &err;
+		if (log && for_each_reflog_ent(oldrefname, rename_reflog_ent,
+					       &cb))
+			goto fail;
+
+		if (transaction_delete_sha1(transaction, oldrefname, sha1,
+					    REF_NODEREF,
+					    1, NULL, &err))
+			goto fail;
+	}
+	if (transaction_update_sha1(transaction, newrefname, sha1,
+				    NULL, 0, 0, NULL, &err))
+		goto fail;
+	if (log && transaction_update_reflog(transaction, newrefname, sha1,
+					     sha1, &ci, logmsg,
+					     REFLOG_COMMITTER_INFO_IS_VALID,
+					     &err))
+		goto fail;
+	if (transaction_commit(transaction, &err))
+		goto fail;
+	transaction_free(transaction);
+	return 0;
+
+ fail:
+	error("rename_ref failed: %s", err.buf);
+	strbuf_release(&err);
+	transaction_free(transaction);
+	return 1;
+}
-- 
2.0.1.552.g1af257a
