Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9126201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753465AbdEQMGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:23 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58675 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753380AbdEQMGS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:18 -0400
X-AuditID: 1207440f-719ff700000004e5-fc-591c3cb801d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 43.78.01253.8BC3C195; Wed, 17 May 2017 08:06:16 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg2000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:14 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/23] files_transaction_cleanup(): new helper function
Date:   Wed, 17 May 2017 14:05:34 +0200
Message-Id: <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqLvDRibSYON+OYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGj8cTWQs2ClTM33KPpYFxGW8XIyeHhICJ
        xPO9b1i7GLk4hAR2MEnsfPwDyjnBJHHg/2R2kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCj5kk
        /i7rZgFJCAu4S+w9toERxGYRUJVY/fMjUDMHB69AlMSdDjWIbfISu9ousoLYnAIWEvffPwIr
        ERIwl9h+vXICI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCGBxr+D
        sWu9zCFGAQ5GJR7eCVzSkUKsiWXFlbmHGCU5mJREefc/AArxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4b1pKhMpxJuSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4J1iDdQo
        WJSanlqRlplTgpBm4uAEGc4DNJwLpIa3uCAxtzgzHSJ/ilFRSpz3AEhCACSRUZoH1wtLBK8Y
        xYFeEeZdDVLFA0wicN2vgAYzAQ1uBvmIt7gkESEl1cAoe9dW54KR9uv/2Yzp0t2Tkqp+1M89
        JqOU3ev+Yds5xyinh2xqtU9Pa6dMrj7ocavVaiVj25xZTRXrk+85FjwJmrhPTlbR9XChTn+Z
        9uyg5PIiK1PXpKdZ+p8fsD9jPLWHLzkpI/S0bOC/49XPb2i+v7hL7eknX4+67S+mbgrtVjQw
        XKfWPlOJpTgj0VCLuag4EQAu9TQS3wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract function from `files_transaction_commit()`. It will soon have
another caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ba0ad0aa44..7ddd4f87d5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2846,6 +2846,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	return 0;
 }
 
+/*
+ * Unlock any references in `transaction` that are still locked, and
+ * mark the transaction closed.
+ */
+static void files_transaction_cleanup(struct ref_transaction *transaction)
+{
+	size_t i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct ref_lock *lock = update->backend_data;
+
+		if (lock) {
+			unlock_ref(lock);
+			update->backend_data = NULL;
+		}
+	}
+
+	transaction->state = REF_TRANSACTION_CLOSED;
+}
+
 static int files_transaction_commit(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -2868,10 +2889,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
-	if (!transaction->nr) {
-		transaction->state = REF_TRANSACTION_CLOSED;
-		return 0;
-	}
+	if (!transaction->nr)
+		goto cleanup;
 
 	/*
 	 * Fail if a refname appears more than once in the
@@ -3017,15 +3036,11 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	clear_loose_ref_cache(refs);
 
 cleanup:
+	files_transaction_cleanup(transaction);
 	strbuf_release(&sb);
-	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct ref_lock *lock = update->backend_data;
-
-		if (lock)
-			unlock_ref(lock);
 
 		if (update->flags & REF_DELETED_LOOSE) {
 			/*
-- 
2.11.0

