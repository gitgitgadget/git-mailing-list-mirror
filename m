Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1FD1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbcIDQME (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:04 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45874 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754378AbcIDQLx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:53 -0400
X-AuditID: 1207440c-217ff700000008d5-df-57cc475bf108
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 94.1A.02261.B574CC75; Sun,  4 Sep 2016 12:10:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5x026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:10:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 37/38] refs: make lock generic
Date:   Sun,  4 Sep 2016 18:08:43 +0200
Message-Id: <21555b1c09974a58972940745c5778a119b0a0fa.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBvtfibcYNcWaYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVrizNvGhkdOD3+vv/A5LFz1l12j672I2we
        z3r3MHpcvKTssX/pNjaPxQ+8PBY8v8/u8XmTXABnFJdNSmpOZllqkb5dAldGz4Z+toJmlYrN
        hyewNDA+leli5OSQEDCR+LJ5AjOILSSwlVHi32XuLkYuIPskk8SRxXeYQBJsAroSi3qawWwR
        ATWJiW2HWECKmAV+M0lc2PqcHSQhLGAo8Xn5FaAiDg4WAVWJn3fzQMK8AlESa1tfsUAsk5O4
        tO0L2DJOAQuJM7vnMoOUCwmYS7S/yJ7AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6h
        Xm5miV5qSukmRkgI8uxg/LZO5hCjAAejEg+vhfaZcCHWxLLiytxDjJIcTEqivLMOngwX4kvK
        T6nMSCzOiC8qzUktPsQowcGsJMKr7QJUzpuSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpa
        kFoEk5Xh4FCS4I1yA2oULEpNT61Iy8wpQUgzcXCCDOcBGt4HUsNbXJCYW5yZDpE/xagoJc77
        0hUoIQCSyCjNg+uFpYhXjOJArwjzKoK08wDTC1z3K6DBTECD1+0+DTK4JBEhJdXAaPFsquja
        5vZbR/UOMrJxTtwrcpOd40xJvBbXwgAF9yNmrWq909+c5E1cMEviUv2VFQ/fzvrlKXsq4m/d
        7kOGF/w+Wh42VJ3/SJ9VNCvHU4pXQ//rtntbTn+qCD1c8743rXfvTLlP7GlPrxiXT7W9MP3G
        gUnu25slGySyHGr3mcXzb4l1fPRgqhJLcUaioRZzUXEiAGmRpdjsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Instead of including a files-backend-specific struct ref_lock, change
the generic ref_update struct to include a void pointer that backends
can use for their own arbitrary data.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 25 +++++++++++++------------
 refs/refs-internal.h |  2 +-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7cc4191..0714c3f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3552,9 +3552,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
 			   affected_refnames, NULL,
-			   &update->lock, &referent,
+			   &lock, &referent,
 			   &update->type, err);
-
 	if (ret) {
 		char *reason;
 
@@ -3565,7 +3564,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		return ret;
 	}
 
-	lock = update->lock;
+	update->backend_data = lock;
 
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NODEREF) {
@@ -3613,7 +3612,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		for (parent_update = update->parent_update;
 		     parent_update;
 		     parent_update = parent_update->parent_update) {
-			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
+			struct ref_lock *parent_lock = parent_update->backend_data;
+			oidcpy(&parent_lock->old_oid, &lock->old_oid);
 		}
 	}
 
@@ -3634,7 +3634,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The lock was freed upon failure of
 			 * write_ref_to_lockfile():
 			 */
-			update->lock = NULL;
+			update->backend_data = NULL;
 			strbuf_addf(err,
 				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
@@ -3752,7 +3752,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct ref_lock *lock = update->lock;
+		struct ref_lock *lock = update->backend_data;
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
@@ -3765,7 +3765,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 					    lock->ref_name, old_msg);
 				free(old_msg);
 				unlock_ref(lock);
-				update->lock = NULL;
+				update->backend_data = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
@@ -3775,7 +3775,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			if (commit_ref(lock)) {
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
-				update->lock = NULL;
+				update->backend_data = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
@@ -3784,17 +3784,18 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		struct ref_lock *lock = update->backend_data;
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
+			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				string_list_append(&refs_to_delete,
-						   update->lock->ref_name);
+						   lock->ref_name);
 		}
 	}
 
@@ -3810,8 +3811,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++)
-		if (transaction->updates[i]->lock)
-			unlock_ref(transaction->updates[i]->lock);
+		if (transaction->updates[i]->backend_data)
+			unlock_ref(transaction->updates[i]->backend_data);
 	string_list_clear(&refs_to_delete, 0);
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c598cb1..681982b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -162,7 +162,7 @@ struct ref_update {
 	 */
 	unsigned int flags;
 
-	struct ref_lock *lock;
+	void *backend_data;
 	unsigned int type;
 	char *msg;
 
-- 
2.9.3

