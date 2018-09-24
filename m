Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E551F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeIXQHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 12:07:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:51361 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbeIXQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:40 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 4NkrgLWW7VlGZ4NkzgJ4su; Mon, 24 Sep 2018 11:06:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1537783582;
        bh=WUDfebNobvVfgzl7CmJxqgHRH6qyNOAMalxpXTn4dJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=JoAD4KgG5CSU/ULR7Tb9vsbD3RzwTIxTHZHfX9CHY9crkqVyvUTL5g9SgY1fp6Ups
         gdBdr/YhKMPuIquKOmfYmhDBqdNTWhjbfHrH/2FyrFFk8ZztFGBRA1ifnyqg2VbbuW
         MStSm+0vvtpD/2p3MNTgOHcnLr8kLdy45jRMIVSA=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=30r_6wDvDLaDDSgIxuMA:9
 a=99yrcnEXu3fBX6qS:21 a=2psp2rGW2c9tThR_:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 2/3] diff.c: remove unused variables
Date:   Mon, 24 Sep 2018 11:06:03 +0100
Message-Id: <20180924100604.32208-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFQw2RXYyzMW0EfUXpufrwp8z+4Aj+3RRUwG3LNInHNHYVSQU3Gy4z+TJm3EqUFf2jnDtBfNV6YjTEoWzuwtYGirpPg/jP84VXk2wthEwqkgF3SgYEp1
 pBtT9LPSl9YWvPOX7ZYKOb5RqtxL/VPdu7yagl30P2BKBl8DCB7FkVI7rHdH42qVcoee7x6i2my0kcvbmXndEOhSgd8rHB598PsKk7BxDK9xlQ7i4YsBTx+Z
 sOa7XKNZKgEr/VawxC/iEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The string lengths are not used in cmp_in_block_with_wsd() so lets
remove them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 9393993e33..0a652e28d4 100644
--- a/diff.c
+++ b/diff.c
@@ -789,7 +789,6 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 int n)
 {
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, cl = l->len;
 	const char *a = cur->es->line,
 		   *b = match->es->line,
 		   *c = l->line;
@@ -823,13 +822,10 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 */
 
 	wslen = strlen(pmb->wsd->string);
-	if (pmb->wsd->current_longer) {
+	if (pmb->wsd->current_longer)
 		c += wslen;
-		cl -= wslen;
-	} else {
+	else
 		a += wslen;
-		al -= wslen;
-	}
 
 	if (strcmp(a, c))
 		return 1;
-- 
2.19.0

