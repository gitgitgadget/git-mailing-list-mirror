From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 05/23] refs-common.c: move rename_ref to the common code
Date: Wed, 13 Aug 2014 13:14:49 -0700
Message-ID: <1407960907-18189-6-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexS-0008Pc-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbaHMUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:26 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:51241 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbaHMUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:12 -0400
Received: by mail-vc0-f201.google.com with SMTP id le20so35838vcb.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+Qep3j2pNOod3tR+rD4U8sTWiDtlvH5U8FQlLAclWw=;
        b=KKuhRpCRBwkqV0MJ/PPT2LYrLMDJkumleCGPC9RayLci2rB9Z9fV1Bz/QPVrMelE4/
         VPQ01aZtw7bET07D3LSe08b/uXlGw2NkG6o/E1+tJ/iV6W4xHNcyUFse5syvoBU0/e65
         ZEIhe7pwizdkkJ2wzOyaUe1wm4mY74ykeV/N0q+2ASdD4QJJrNwPULDOgRuIQzltjuSC
         YlwO4W3SDF95xwaLa4IMcN5a4arzA9cf6krstTxrLoEwALFzt7Ow62itf6dwPuQtCQ3o
         4kZSsjrXTV0Kd0tbmT3jUf03H/qYr/fjM9Vfy8pv+Fo5KwVb9x8KmzrRWfg4uJDR45dI
         C+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+Qep3j2pNOod3tR+rD4U8sTWiDtlvH5U8FQlLAclWw=;
        b=YQ4knscQBRtbsCNLirCdZ55NIP5pjUimIAVxJwoF/BnsDmUljpyiihm9e5rJlv2UQT
         yy9+lJoQNAFBY2xdniRS7WBvY3Gh/9aV4PesZTlPNgnp9awVyMzFpUvOPRgMw2ABpCAE
         uQ+plr7ULHc4/+7yVBSlYbET39fy1rsZR8hzvhPFRTn4ZD4TdwKuhtpbLh95cJ5fODMs
         1dNuPW0qTELZT9O5Yuq/ePWs+VvDhVe96sIS9UBjhr19zgedEyQVI3c0ZFnSu1zaSfLi
         jYnNHJQgEl9Ew3Y+agRBif1ZepWozOb8F/Vf6gd+/HDUPOcYKpm/khrjAxSsMA+hITmN
         aABg==
X-Gm-Message-State: ALoCoQk+IjCTQ3dcwkrvEEtJtIvx8iC8Q8qNehr8GWbGPw/4hU3p/kuun30Wrux0Op3KR6NgjI1y
X-Received: by 10.224.0.137 with SMTP id 9mr2550593qab.5.1407960909950;
        Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si207148yhg.7.2014.08.13.13.15.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B9A0231C3D9;
	Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 65E67E025A; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255234>

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
2.0.1.556.g3edca4c
