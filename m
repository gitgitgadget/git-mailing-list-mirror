Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6235202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJ1JuP (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:15 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62660 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751286AbdJ1JuH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:07 -0400
X-AuditID: 12074411-f95ff70000007f0a-e9-59f452ce50b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 56.4B.32522.EC254F95; Sat, 28 Oct 2017 05:50:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqZ016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:05 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/7] ref_transaction_add_update(): remove a check
Date:   Sat, 28 Oct 2017 11:49:53 +0200
Message-Id: <dc062014fca792d183d29847ef3b2937ab1d3667.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqHsu6EukQfc0C4uuK91MFg29V5gt
        bq+Yz2xx5k0jowOLx9/3H5g8Ll5S9lj8wMvj8ya5AJYoLpuU1JzMstQifbsEroz7Bx8xF6wV
        qLh39TN7A+Mq3i5GDg4JAROJOQfduxi5OIQEdjBJLLiwnAnCOcUk8fbxC8YuRk4ONgFdiUU9
        zUwgtoiAmsTEtkMsIDazQJHE1/VnweLCAo4S+xvmgNWzCKhK3Ny7lw3E5hWIkmie8Z4VxJYQ
        kJc49+A2M4jNKWAhcXfZWjBbSMBc4u2bBawTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtL
        LdI11cvNLNFLTSndxAgJEcEdjDNOyh1iFOBgVOLhlcj9HCnEmlhWXJl7iFGSg0lJlHff+U+R
        QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4L/p8iRTiTUmsrEotyodJSXOwKInz8i1R9xMSSE8s
        Sc1OTS1ILYLJynBwKEnwTgkEahQsSk1PrUjLzClBSDNxcIIM5wEavgekhre4IDG3ODMdIn+K
        0Zij4+bdP0wcz2a+bmAWYsnLz0uVEud9AVIqAFKaUZoHNw0W568YxYGeE+a9AVLFA0wRcPNe
        Aa1iAlqlIQm2qiQRISXVwLhDcXt6Umy4/VyXR18/7Lj0PGLiNVeza3oe/NfnvXp7NHCHGHvD
        9nZNxj2fHiw/bdGlvqXEWSvtclbwSu0DjoZxsoE680uUnmwLSOvJ4I9+fURWukpCsyPKVbn1
        e/C3i0qCyvyXbvi/f3WAb25Q79KFwvd/vXVYfd156YX1oazKU3qkj5qLtCixFGckGmoxFxUn
        AgCwfZVYzgIAAA==
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

