Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3042023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934724AbdEVOS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44009 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934710AbdEVOSu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:50 -0400
X-AuditID: 12074412-a67ff70000003a21-d5-5922f33ea94d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 27.77.14881.E33F2295; Mon, 22 May 2017 10:18:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24M023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/25] ref_transaction_commit(): check for valid `transaction->state`
Date:   Mon, 22 May 2017 16:17:43 +0200
Message-Id: <5705444f57e334c451f3badd710ee7672b2488a1.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqGv3WSnS4PwtE4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXRuPHI+wFJ7kr
        nhycytTAuJOzi5GTQ0LAROJkzySWLkYuDiGBHUwSk64sZYdwTjFJbHrVyA5SxSagK7Gop5kJ
        xBYRUJOY2HYIrINZYAOzxJvpq8ESwgIREktv9bKA2CwCqhITZvSBxXkFoiR27/nFBLFOXmJX
        20VWEJtTwELi96wDYHEhAXOJ3n+rWSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGum
        l5tZopeaUrqJERKKQjsY15+UO8QowMGoxMPb8FQpUog1say4MvcQoyQHk5Io79E3QCG+pPyU
        yozE4oz4otKc1OJDjBIczEoivNp3gXK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtS
        i2CyMhwcShK8ep+AGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGr/kAMry4IDG3ODMdIn+KUVFKnNcA
        pFkAJJFRmgfXC0sVrxjFgV4R5i0EqeIBphm47ldAg5mABls/kwcZXJKIkJJqYHSsiFy1gylt
        gV6g3JXA9AtMFjV7VhaHnvwwc8JrV8+lZ6zZGh4qr9JZI/2MseP9urNnhdn3MGv/2XB+QV9Q
        zzHR7suVRe46imady1z52hx9ZGTj77MtN8zYsNj+xN6iA6Z6ZidPiDGWpuw+lCQez7OTi+l8
        ILOk5ofWRzcio6ZEt6/PLfpWr8RSnJFoqMVcVJwIABtO02rwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the check that `transaction->state` is valid from
`files_transaction_commit()` to `ref_transaction_commit()`, where
other future reference backends can benefit from it as well.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 12 ++++++++++++
 refs/files-backend.c |  3 ---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 989462c972..f8f41ffb04 100644
--- a/refs.c
+++ b/refs.c
@@ -1694,6 +1694,18 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	struct ref_store *refs = transaction->ref_store;
 
+	switch (transaction->state) {
+	case REF_TRANSACTION_OPEN:
+		/* Good. */
+		break;
+	case REF_TRANSACTION_CLOSED:
+		die("BUG: prepare called on a closed reference transaction");
+		break;
+	default:
+		die("BUG: unexpected reference transaction state");
+		break;
+	}
+
 	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2c70de5209..a4261d4683 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2874,9 +2874,6 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 	assert(err);
 
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: commit called for transaction that is not open");
-
 	if (!transaction->nr)
 		goto cleanup;
 
-- 
2.11.0

