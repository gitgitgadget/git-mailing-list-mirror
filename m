Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D721F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJCAkM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 20:40:12 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:62214 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJCAkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 20:40:11 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 7OtMgc0MNVlGZ7OtUgNKnz; Tue, 02 Oct 2018 18:55:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538502937;
        bh=tLbqlNKt4ecjPvcJYjA2crvJ9IZwFZKQHVGMWgFvQRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ZNyf+Goko2a2g0wFxdncAsXMpeXJ2d05H2oAaG5UiOLQEO9UnMXiFZAdl735APO8W
         lS3FFWIRsI1pwquZx2EuGd01zQKa1qAtddq0CxvE7mUOhoAn7ntmKZ5QlnVWvrHmAO
         wJP4H9YeTy4GTa5xE8HacS7w8p1nh+S6VSsKJZPw=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=n8RbOExCk_JQ8I0cbEoA:9
 a=dpDMFQPqx-khGISw:21 a=nnnCPuPLab-uMWSV:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/5] diff --color-moved-ws: fix another memory leak
Date:   Tue,  2 Oct 2018 18:55:13 +0100
Message-Id: <20181002175514.31495-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOOkg9HYAapcoquWW4oBMdDY6JJcDZMQPDUyiM8c9C6CIO+EQ3Q5ZCIimSrRTe6OU4T02ziGZIEZs1szFHdFz7PzwxY0VRCKWJhYgeGFUeTLx1ItvhVn
 tWAPJ6CQssNufdM2+vOLZ1iFWSFg+XsyzuNJw8BFAgEvUfWCFLkSi3EGIhEoYed1ELIN1LVzKoZHPGgkwU9tV5Gd4N93cRT5MhkcR6gicmiHhaHXVISVpp4x
 OlHYl5ZNO7jD+o90kNx6pKOLInqmDr3YSeo6tg5Oj2Yg7YNkR97d4V6Bie9PkvN1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is obvious in retrospect, it was found with asan.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff.c b/diff.c
index efadd05c90..4464feacf8 100644
--- a/diff.c
+++ b/diff.c
@@ -971,6 +971,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 			moved_block_clear(&pmb[i]);
 		}
 	}
+
+	free(got_match);
 }
 
 static int shrink_potential_moved_blocks(struct moved_block *pmb,
-- 
2.19.0

