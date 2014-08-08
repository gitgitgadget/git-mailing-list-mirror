From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/22] refs-common.c: move rename_ref to the common code
Date: Fri,  8 Aug 2014 09:44:52 -0700
Message-ID: <1407516309-27989-6-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJj-0000s3-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbaHHQqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:46:36 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:36789 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so1476518pde.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sN07l9LOb/Z1Cp/ZqmCpvi9vW5CsEQgMI6yOXTZeMJA=;
        b=ct3fTkupSyz/TQ6uqVX9596Tjf7yYxhxSunKDp4vvjF0NHl2KC08yxg2xMluVI1gy4
         ptNkwQWbXg4TJZ4Yvad7sfSsvCc5NMGRTH6oWO/JhxjoI6FIQ7WZlRIeVMqzePympQmf
         XAVpnMWO/L3PwQRXAbmKzt9EEnwe2CW/wudegSkosJL2gSbjJdcIezwqaNaaO8cEfr0e
         62X3O+fiXqMqrNPEzlgihVm8+jJzNXCnHsjrdLu/mH61s6gguRkvBRgNbcM/N79Sepbc
         Br3aCQon5rHOH4ay29TNxfK0+Y6WIomIDKja7Vb/IZ+MC5miIj327q0tkJHLRZZW2h59
         Msww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sN07l9LOb/Z1Cp/ZqmCpvi9vW5CsEQgMI6yOXTZeMJA=;
        b=JXOdABVhGUE19QX6GzenX1ME9qVIYfv/4HW/PTlOEqSkyTjYA7Av539QlUhFpPK8Qg
         R63ImcLW7FVoCbVS79m83gTOPE4HRTio9jjOV8J+fmn+yc0j5FgEmZ0R88MOK6sOewdX
         6VyBu6neolCxLj/g4p+HORjN8IhDLzJi9e2SxFfm6zEIm0R//IE7ggcaGxgURxNtBYca
         KxQEi+Mlj6vVfd1WdV/EwpUTesRFneTbOW0WrJZTkpNbRY9HnQVt9jn4N0hJsDPXj1g8
         +Gdg+DgQ8VDARZohT7wLTol5d+0EodqhbtU86fC/lYt6x13ntfPlrW/Cbk5PNW8Eulq4
         eQyQ==
X-Gm-Message-State: ALoCoQnyiUiBvUlGvIxEoJkRVhjeBTC2KpVRCWIhDXHZPR4ReIsS0c/NHfDETHciG1hUzK8nznAN
X-Received: by 10.67.5.71 with SMTP id ck7mr13443102pad.9.1407516315802;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si503484yhp.6.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8CDBC31C5BA;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0B960E0AA5; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255042>

This change moves rename_ref() to the refs-common.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 92 -----------------------------------------------------------
 2 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 71ad358..f99d83e 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -43,3 +43,95 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
diff --git a/refs.c b/refs.c
index faf794c..7d579be 100644
--- a/refs.c
+++ b/refs.c
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
-- 
2.0.1.553.geee1b3e
