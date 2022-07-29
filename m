Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E42CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiG2KNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiG2KNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:13:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F24820E2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b22so4177039plz.9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PhWKU4MN5bMx+NXOnDwjycrCERAx8ueheavkbDBhlE=;
        b=QTcdjcxcu0ZfF3Z+TvCTlTxYvV8wcd+h60zKAx5D9KXujZ9kaEGtL2RswhFxTiMg7Q
         v1Qu3Gyi7BmoDwRc28jLZwNwsYwpvuLkkttbjoD2RAoElvsL1K3iBjntv2zD3gHuC0xV
         zbB2nRMfV5AUfYNI6Alc1NtWDoLw78Lhp8dcFGYkkrvMqdHZRAq5z12YLl6M1TpMBAim
         o2FKbgS16g8hCqtRxRRiZ7dubjsS5rsmwuOjB7R4zmwL1SmKPiUEIpql3bruHmp9eFoe
         GVHkMKLx7c7W2cnxw1TMjD+Aqh17FP2EzEP3XU7cKoRX/7YqIs8xQRv5XbtvfI8aggKa
         nZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PhWKU4MN5bMx+NXOnDwjycrCERAx8ueheavkbDBhlE=;
        b=a+HBzPWpIbuDbvqF2S0AbAe3CFhChQAey7F2gxSHj7hT8qRMMU02nlLiRcbyIHyQM2
         D9AqjDQsusY8Z1JGvWbF9ZJa8WH49G6aEhaP7zZzSFQnPJi3ggsuOn65kDW6UiN2M8gF
         a9jFna8EX6HokP3rjR/398U5tcTh3OVaI/HJ7DbUU307cN/U6N6MAZ3I4Cj6vKHYtCDx
         nzIgrtsrHnihKKC20QBkI1h+62DmRgP88tflno80jXjXH0uZFPudjxQQeYhmHsgY3j9P
         7e3djcqpP6vF3ezOfFsjiiIHZiwY+mcalUCclh3FbZT2jW0nrRFW9RYyWqCd6ccrKRpo
         UlFA==
X-Gm-Message-State: ACgBeo2AWlvm6Elt08sqc5hrsKRZ5w2aS6g66QsMDxgD5+PSxSihugqG
        IfFVEcZ8I5N6K63JfQARyZg=
X-Google-Smtp-Source: AA6agR7s//uRCOT+e5iQq/ROMNfRN08AXKrW7gl2GNCHhdRdZkfJA7bCHJtmbE/2APYqVQAz9/oatQ==
X-Received: by 2002:a17:90b:180d:b0:1f3:16ae:5c44 with SMTP id lw13-20020a17090b180d00b001f316ae5c44mr3914162pjb.170.1659089579183;
        Fri, 29 Jul 2022 03:12:59 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:58 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 6/9] refs: add reflog_info to hold more fields for reflog entry
Date:   Fri, 29 Jul 2022 18:12:42 +0800
Message-Id: <20220729101245.6469-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The parameter "msg" of the functions "ref_transaction_add_update()" and
"refs_update_ref()" is used as a comment for creating a new reflog
entry. For some cases, like copying or renaming a branch, we may need
more custom fields for the new reflog entry, such as old-oid which is
different from the oid we get from the lock file. Therefore, we create
a new structure "reflog_info" to hold more custom fields for the new
reflog entry, and add two additional extended version functions.

We will use this extension in a later commit to reimplement
"files_copy_or_rename_ref()" using "refs_update_ref_extended()" to
create new reference in a transaction and add proper reflog entry.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c               | 54 +++++++++++++++++++++++++++++++++++++++-----
 refs.h               | 20 ++++++++++++++++
 refs/debug.c         |  2 +-
 refs/files-backend.c | 14 ++++++++----
 refs/refs-internal.h | 17 ++++++++++++--
 5 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 48b69460e2..e53f011e6b 100644
--- a/refs.c
+++ b/refs.c
@@ -1045,7 +1045,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	}
 
 	for (i = 0; i < transaction->nr; i++) {
-		free(transaction->updates[i]->msg);
+		if (transaction->updates[i]->reflog_info) {
+			free(transaction->updates[i]->reflog_info->msg);
+			free(transaction->updates[i]->reflog_info->old_oid);
+			free(transaction->updates[i]->reflog_info);
+		}
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1057,7 +1061,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
-		const char *msg)
+		const struct reflog_info *reflog_info)
 {
 	struct ref_update *update;
 
@@ -1074,7 +1078,12 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
-	update->msg = normalize_reflog_message(msg);
+	if (reflog_info) {
+		update->reflog_info = xmalloc(sizeof(*reflog_info));
+		update->reflog_info->msg = normalize_reflog_message(reflog_info->msg);
+		if (reflog_info->old_oid)
+			update->reflog_info->old_oid = oiddup(reflog_info->old_oid);
+	}
 	return update;
 }
 
@@ -1084,6 +1093,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
+{
+	struct reflog_info reflog_info;
+
+	reflog_info.msg = (char *)msg;
+	reflog_info.old_oid = NULL;
+	return ref_transaction_update_extended(transaction,
+					       refname, new_oid, old_oid,
+					       flags, &reflog_info, err);
+}
+
+int ref_transaction_update_extended(struct ref_transaction *transaction,
+				    const char *refname,
+				    const struct object_id *new_oid,
+				    const struct object_id *old_oid,
+				    unsigned int flags,
+				    const struct reflog_info *reflog_info,
+				    struct strbuf *err)
 {
 	assert(err);
 
@@ -1109,7 +1135,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, msg);
+				   new_oid, old_oid, reflog_info);
 	return 0;
 }
 
@@ -1157,6 +1183,22 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 		    const char *refname, const struct object_id *new_oid,
 		    const struct object_id *old_oid, unsigned int flags,
 		    enum action_on_err onerr)
+{
+	struct reflog_info reflog_info;
+
+	reflog_info.msg = (char *)msg;
+	reflog_info.old_oid = NULL;
+	return refs_update_ref_extended(refs, refname, new_oid, old_oid,
+					flags, &reflog_info, onerr);
+}
+
+int refs_update_ref_extended(struct ref_store *refs,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
+			     unsigned int flags,
+			     const struct reflog_info *reflog_info,
+			     enum action_on_err onerr)
 {
 	struct ref_transaction *t = NULL;
 	struct strbuf err = STRBUF_INIT;
@@ -1164,8 +1206,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	t = ref_store_transaction_begin(refs, &err);
 	if (!t ||
-	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
-				   &err) ||
+	    ref_transaction_update_extended(t, refname, new_oid, old_oid,
+					    flags, reflog_info, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		ret = 1;
 		ref_transaction_free(t);
diff --git a/refs.h b/refs.h
index 715127ab58..0f21ba259f 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,7 @@ struct strbuf;
 struct string_list;
 struct string_list_item;
 struct worktree;
+struct reflog_info;
 
 /*
  * Resolve a reference, recursively following symbolic refererences.
@@ -677,6 +678,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const struct object_id *old_oid,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
+/*
+ * Extended version of ref_transaction_update() that allows us to
+ * provide more fields (in reflog_info) to custom reflog, such
+ * as msg and old_oid.
+ */
+int ref_transaction_update_extended(struct ref_transaction *transaction,
+				    const char *refname,
+				    const struct object_id *new_oid,
+				    const struct object_id *old_oid,
+				    unsigned int flags,
+				    const struct reflog_info *reflog_info,
+				    struct strbuf *err);
 
 /*
  * Add a reference creation to transaction. new_oid is the value that
@@ -806,6 +819,13 @@ void ref_transaction_free(struct ref_transaction *transaction);
 int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
 		    const struct object_id *new_oid, const struct object_id *old_oid,
 		    unsigned int flags, enum action_on_err onerr);
+int refs_update_ref_extended(struct ref_store *refs,
+			     const char *refname,
+			     const struct object_id *new_oid,
+			     const struct object_id *old_oid,
+			     unsigned int flags,
+			     const struct reflog_info *reflog_info,
+			     enum action_on_err onerr);
 int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
diff --git a/refs/debug.c b/refs/debug.c
index eed8bc94b0..1e60507249 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -79,7 +79,7 @@ static void print_transaction(struct ref_transaction *transaction)
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
-			     u->type, u->msg);
+			     u->type, u->reflog_info? u->reflog_info->msg : NULL);
 	}
 	trace_printf_key(&trace_refs, "}\n");
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e8d12cb343..e2eabe9d8e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2340,7 +2340,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			update->reflog_info);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2403,7 +2403,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			update->reflog_info);
 
 	new_update->parent_update = update;
 
@@ -2893,9 +2893,15 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		    update->flags & REF_LOG_ONLY) {
 			if (files_log_ref_write(refs,
 						lock->ref_name,
-						&lock->old_oid,
+						update->reflog_info &&
+						update->reflog_info->old_oid ?
+							update->reflog_info->old_oid :
+							&lock->old_oid,
 						&update->new_oid,
-						update->msg, update->flags,
+						update->reflog_info ?
+							update->reflog_info->msg :
+							NULL,
+						update->flags,
 						err)) {
 				char *old_msg = strbuf_detach(err, NULL);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5220d1980d..782cf5fa78 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -104,6 +104,19 @@ enum peel_status {
  */
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
 
+/*
+ * When using refs_update_ref() to copy or rename a branch, the old-oid
+ * for the new created branch is null_oid, but the old_oid for the new
+ * appended log entry for the reflog file which is copied from the
+ * original reflog should be the same as the new_oid for the target
+ * branch. Use "reflog_info" to hold log message and old_oid for the
+ * new reflog entry.
+ */
+struct reflog_info {
+	struct object_id *old_oid;
+	char *msg;
+};
+
 /**
  * Information needed for a single ref update. Set new_oid to the new
  * value or to null_oid to delete the ref. To check the old value
@@ -133,7 +146,7 @@ struct ref_update {
 
 	void *backend_data;
 	unsigned int type;
-	char *msg;
+	struct reflog_info *reflog_info;
 
 	/*
 	 * If this ref_update was split off of a symref update via
@@ -174,7 +187,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
-		const char *msg);
+		const struct reflog_info *reflog_info);
 
 /*
  * Transaction states.
-- 
2.36.1.25.gc87d5ad63a.dirty

