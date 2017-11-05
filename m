Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B162820450
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdKEImu (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:50 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56717 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbdKEIm0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:26 -0500
X-AuditID: 1207440d-86bff70000000f42-9e-59feceed6c4b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 88.D3.03906.EEECEF95; Sun,  5 Nov 2017 03:42:22 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCt018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:20 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/9] ref_transaction_add_update(): remove a check
Date:   Sun,  5 Nov 2017 09:42:04 +0100
Message-Id: <dc062014fca792d183d29847ef3b2937ab1d3667.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqPv+3L9Ig/MTBCy6rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxv2Dj5gL1gpU3Lv6mb2BcRVvFyMnh4SAicT9n12MXYxcHEICO5gkeuYdY4FwTjBJfPn6
        jxWkik1AV2JRTzMTiC0ioCYxse0QWBGzwFZGib/dzcwgCWEBF4nflx8DNXBwsAioSjy8kQkS
        5hWIkphw7zcbxDZ5iXMPboOVcwpYSPz5OA8sLiRgLvHp007WCYw8CxgZVjHKJeaU5urmJmbm
        FKcm6xYnJ+blpRbpGunlZpbopaaUbmKEBA7vDsb/62QOMQpwMCrx8J7w+BcpxJpYVlyZe4hR
        koNJSZT3yss/kUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeIMWA5XzpiRWVqUW5cOkpDlYlMR5
        1Zao+wkJpCeWpGanphakFsFkZTg4lCR4BYARIiRYlJqeWpGWmVOCkGbi4AQZzgM0/PFZkOHF
        BYm5xZnpEPlTjMYcz2a+bmDmmHa1tYlZiCUvPy9VSpz3GEipAEhpRmke3DRY9L9iFAd6TphX
        HmQpDzBxwM17BbSKCWjVbI4/IKtKEhFSUg2MLG9fuPVVSIjqvrB6tXfFLa29XEcMn8ZdMfwY
        1ZsZ7l4dv0Y11j11ruZpvijpc+5nJfQ4761yMk2/9P/tw8UCGoFB/sqsc/LylXzYWQy3nTBU
        +JSuvc/rwsM7irqusVFz/7qa/m6Oyi1MPna45awXZ9PTDRfvWZZGmh1u150X9mnbx+PPcn2V
        WIozEg21mIuKEwHpWVEA2QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to make `REF_ISPRUNING` internal to the files backend. For
this to be possible, `ref_transaction_add_update()` mustn't know about
it. So move the check that `REF_ISPRUNING` is only used with
`REF_NODEREF` from this function to `files_transaction_prepare()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 3 ---
 refs/files-backend.c | 7 ++++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7c1e206e08..0d9a1348cd 100644
--- a/refs.c
+++ b/refs.c
@@ -906,9 +906,6 @@ struct ref_update *ref_transaction_add_update(
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
-	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
-		die("BUG: REF_ISPRUNING set without REF_NODEREF");
-
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ba72d28b13..a47771e4d4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2518,13 +2518,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * transaction. (If we end up splitting up any updates using
 	 * split_symref_update() or split_head_update(), those
 	 * functions will check that the new updates don't have the
-	 * same refname as any existing ones.)
+	 * same refname as any existing ones.) Also fail if any of the
+	 * updates use REF_ISPRUNING without REF_NODEREF.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 		struct string_list_item *item =
 			string_list_append(&affected_refnames, update->refname);
 
+		if ((update->flags & REF_ISPRUNING) &&
+		    !(update->flags & REF_NODEREF))
+			BUG("REF_ISPRUNING set without REF_NODEREF");
+
 		/*
 		 * We store a pointer to update in item->util, but at
 		 * the moment we never use the value of this field
-- 
2.14.1

