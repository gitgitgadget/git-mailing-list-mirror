From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 05/14] refs.c: add a new update_type field to ref_update
Date: Mon, 17 Nov 2014 17:35:41 -0800
Message-ID: <1416274550-2827-6-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiD-0000BI-DQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbaKRBgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:05 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:64199 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaKRBgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:00 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so190753igb.16
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVlixMkRkGVSbgXR5OiNU2rY8s2XODlKG5RIAon06CM=;
        b=drVU1o3aV21Z9kF36Ar+/7u5ZCB5Y+EDDkK9Wgf8KTCzCGy6d/RMKumkX/7Z3C+3Mn
         1sQadITGf+32ILtnRExY63Xwbtog6F3zAP+9QZOx0iooe8kas0N7djjBztStyM1iNdiK
         3XMddp5CjLdZgCJO66rEDfBOeNSY5kkSYDrtmHvV2q5iVy140tpHg5gpR3eEbjeDvd08
         IX/KbiAHg8eYtwtN6GEgoIhrE+O/yeX5p7FDBpCKQxVcvDErj7LkGKKKRjRlj1WXVEyG
         uTebuQDt4iRkJ1vtMEUd3fTiXRMV9Li21rBF/JTcv1NiMcDpZrCtkhR5q77SQj5rYLVV
         y2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVlixMkRkGVSbgXR5OiNU2rY8s2XODlKG5RIAon06CM=;
        b=eGX76t66u9AHSodD1aQoPP54+fcZ4unbPDfCNsRaTmJX/5cEiSCRf46iLq0oVcz8P1
         wNKaZLo1bkxI6wOa7/Vgz3krjWYz/jeQ6cb3J++c17hv+wVUA4NEncB/0FazzvxyWNP8
         ce25fPrcjXcl8gOjvmaNmjXXueOm6zabGP2JsR/ulw5crx3ccBcoD75JPAM75HVN4wxj
         p3HB9QPi8CxVYYarinvxVRV5SiDm1C+RAAsQ5N5DRbOc97C/fA1TMPh+lwsEaMAN7jI1
         ZWDITPzuu7yjyKCBbZpZqb/o2nMz15GxilERXEXZvjNKqtJCnUfAJ07+whd1V1NL4V9S
         Hccw==
X-Gm-Message-State: ALoCoQk00t5tjbgpV63axM04tyFwsDjwL0HwsWqY9h/s52+r3yvDGCSnpNi7jkDPe1l5CfuXGV1v
X-Received: by 10.50.98.105 with SMTP id eh9mr30250875igb.31.1416274560201;
        Mon, 17 Nov 2014 17:36:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id b77sm19780952ioe.35.2014.11.17.17.35.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:35:59 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f0f0d23..84e086f 100644
--- a/refs.c
+++ b/refs.c
@@ -3516,6 +3516,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+	UPDATE_SHA1 = 0
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3523,6 +3527,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3583,12 +3588,14 @@ void transaction_free(struct transaction *transaction)
 }
 
 static struct ref_update *add_update(struct transaction *transaction,
-				     const char *refname)
+				     const char *refname,
+				     enum transaction_update_type update_type)
 {
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
+	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3618,7 +3625,7 @@ int transaction_update_ref(struct transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3696,13 +3703,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 	assert(err);
 
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
+		if (updates[i - 1]->update_type != UPDATE_SHA1 ||
+		    updates[i]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			strbuf_addf(err,
 				    "Multiple updates for ref '%s' not allowed.",
 				    updates[i]->refname);
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3734,13 +3745,17 @@ int transaction_commit(struct transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 		int flags = update->flags;
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
+
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3762,6 +3777,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
@@ -3779,6 +3796,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
-- 
2.2.0.rc2.5.gf7b9fb2
