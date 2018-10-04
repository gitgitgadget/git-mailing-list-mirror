Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1BF1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJDRAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:30 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60722 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJDRA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:29 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80Y0gOCEn; Thu, 04 Oct 2018 11:07:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647676;
        bh=ghX78PGv63ad6NzpAsz/DcaCyjPmLEM6/Grrsl8s76U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=n8P0eGBnlzu+C9PIfa2Cc6uB+FaRHxgjkp0gUbCVeM7TOSMtFK7XrwbWtSAbIE8GR
         fyO0staLcoxihAjB8OVGtiQOhox/vBFWrTfmTc9naP0rf0GXi3WrF+9HTJER6di7U5
         zXSx44M8jQ9ttoOGtlksTFjT3nH+8D5QJDnz6QV8=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=n8RbOExCk_JQ8I0cbEoA:9
 a=dpDMFQPqx-khGISw:21 a=nnnCPuPLab-uMWSV:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/5] diff --color-moved-ws: fix another memory leak
Date:   Thu,  4 Oct 2018 11:07:44 +0100
Message-Id: <20181004100745.4568-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004100745.4568-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAZx2l4lbTh1Jk2qF9SzuZyEifBkLZ6CfUvkg+MB72BJmQzzwpCb696/YgW4ZjnnDqnbkMzSPx9EIwV8DJjDhsyNvBHtyqExVHkP+L1mEaoEqYowghjd
 uZG0uWgqVWuAsb2C0fLlwEUAQc1iYl4QvaYLAkFCyVBdq/Kjq3yHW4vprqW1aONqwzJsQpPA8ec0OLYTd6WIKz+AhSSQd1TPrjW+uS25Mq7sh9jxp+cH/zfA
 NO6I1FytjgOBOZQZUkavm0awgLqcZhy7e6dzqMxSlSgOwMcgAf2k1d1sKh8oExu25KZ3tgPsccPA9nppyA4e5w==
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
index 9bf41bad0d..69f6309db6 100644
--- a/diff.c
+++ b/diff.c
@@ -969,6 +969,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 			moved_block_clear(&pmb[i]);
 		}
 	}
+
+	free(got_match);
 }
 
 static int shrink_potential_moved_blocks(struct moved_block *pmb,
-- 
2.19.0

