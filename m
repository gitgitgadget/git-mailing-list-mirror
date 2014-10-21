From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/15] refs.c: add a new update_type field to ref_update
Date: Tue, 21 Oct 2014 12:24:11 -0700
Message-ID: <1413919462-3458-5-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:25:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf3N-0000Yv-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbaJUTZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:25:00 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:62265 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbaJUTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:35 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp4so282458obc.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lrfXdgJ0FmKVHxO+74a4fKUBPnc1x/DUp+yxMMNMo8Q=;
        b=ABoXSFsOLX/uARBySRAscKv554rd39WZT/wrIVra1SzukfZLhoY/VA0Pq9BiB+32G8
         BJdUTOj6wk/JvAI41D42qnhpyfnrAtLxDLFA1RDjMNEcV9YH8yEmoBsTf7v4tuxhu5Pz
         NfLqlN6dCKbDF/Xrg3QMFX9TgZLpvRrXQ8fkAgNcRtLiFOE2DOUZNPSqK6eb8xoQFnQN
         f/deqsNYTVKrwrNWG3KMXf2u6f4o3+OxzL0ydumpj11NKZe5dxxXDgWftlILS67NBzvt
         E1j/hWbfrSeJJtF2EDbGg3DsBAV9uXaH27z8nv53i+cl7TQsHXiCaZJQteo660rqCtEs
         mTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lrfXdgJ0FmKVHxO+74a4fKUBPnc1x/DUp+yxMMNMo8Q=;
        b=geSMiZr85Sl1JXJ8pUJTiAS2NVDBq0kwLmH7MUP+B1jsXnEctz56/UF0V2x3080pIi
         3Dt5RgywNzum76WPrDy1/eWbAoDfwOV5kQjFAhCg33hYUYenxQCTPaOgdXYyDaH/Bu3e
         4GodocAA4Mmj7vsNyHy3lGWkqiOudyrcWMQqtn3ryrkMfNTBThyzP/t+IlOIx2AMAgCL
         BJFrU3EFEZYa/dnKtAGvBN1+gAwVU/sXURFOiTf5T2Fi5G+VSe1p/efNBp0R019jU+VU
         ObmG6nyopDWRby4+yGvp2zr8U6FUesNdy8MUFVY94s6LQi0JkEsYFu6+TCCHsAX/f9RM
         AKcQ==
X-Gm-Message-State: ALoCoQlL3VjcK0sSJ+asSUykMDDThoKqUQIWT+FLxIuTAzGB6jrEOyL7bky7xqD4Qj1vyucAqBsu
X-Received: by 10.182.27.244 with SMTP id w20mr10115860obg.46.1413919474913;
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si585435yhd.1.2014.10.21.12.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id MKyYQcWp.1; Tue, 21 Oct 2014 12:24:34 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1CBCEE0952; Tue, 21 Oct 2014 12:24:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 1bfd3091a3d95a6268894182117eed823217dd9d upstream.

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Change-Id: I9bf76454d1c789877a6aeb360cbb309971c9b5c4
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a1bfaa2..8803b95 100644
--- a/refs.c
+++ b/refs.c
@@ -3504,6 +3504,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+	UPDATE_SHA1 = 0
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3511,6 +3515,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3571,12 +3576,14 @@ void transaction_free(struct transaction *transaction)
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
@@ -3606,7 +3613,7 @@ int transaction_update_ref(struct transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3684,13 +3691,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
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
 
@@ -3722,13 +3733,17 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3750,6 +3765,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
@@ -3767,6 +3784,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
-- 
2.1.0.rc2.206.gedb03e5
