Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537A9208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbdHJSNY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:13:24 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:54580 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752807AbdHJSNX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 14:13:23 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dfrxQ-0006MK-HJ
        for git@vger.kernel.org; Thu, 10 Aug 2017 20:13:20 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id vWDG1v00y5BuuEg01WDHGg; Thu, 10 Aug 2017 20:13:17 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 4D02145D4513; Thu, 10 Aug 2017 20:13:16 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH 4/4] Fix delta offset overflow
Date:   Thu, 10 Aug 2017 20:13:09 +0200
Message-Id: <1502388789-5775-2-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502388789-5775-1-git-send-email-martin@mail.zuhause>
References: <1502388789-5775-1-git-send-email-martin@mail.zuhause>
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
index 3d5e1ef..633883e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -454,6 +454,9 @@ create_delta(const struct delta_index *index,
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

