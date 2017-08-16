Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D380E1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbdHPUQ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:56 -0400
Received: from vie01a-dmta-pe02-2.mx.upcmail.net ([62.179.121.158]:27614 "EHLO
        vie01a-dmta-pe02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752572AbdHPUQv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:51 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kE-0005Ld-DE
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:50 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGg1v00U5BuuEg01wGhL4; Wed, 16 Aug 2017 22:16:41 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 4779E45D4621; Wed, 16 Aug 2017 22:16:40 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 04/19] delta: Fix offset overflows
Date:   Wed, 16 Aug 2017 22:16:16 +0200
Message-Id: <1502914591-26215-5-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Prevent generating delta offsets beyond 4G.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 diff-delta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff-delta.c b/diff-delta.c
index dffbab1..4489b79 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -453,6 +453,9 @@ create_delta(const struct delta_index *index,
 			moff += msize;
 			msize = left;
 
+			if (moff > 0xffffffff)
+				msize = 0;
+
 			if (msize < 4096) {
 				int j;
 				val = 0;
-- 
2.1.4

