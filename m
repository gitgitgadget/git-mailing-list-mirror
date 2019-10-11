Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700E61F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfJKSlf (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:41:35 -0400
Received: from mail-gateway-shared13.cyon.net ([194.126.200.66]:56676 "EHLO
        mail-gateway-shared13.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728603AbfJKSlf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Oct 2019 14:41:35 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1iIzqz-0006ks-JK
        for git@vger.kernel.org; Fri, 11 Oct 2019 20:41:33 +0200
Received: from [10.20.10.231] (port=40260 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1iIzqy-0004p8-DG; Fri, 11 Oct 2019 20:41:28 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 24FEF18003C; Fri, 11 Oct 2019 20:41:28 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2] utf8: use ARRAY_SIZE() in git_wcwidth()
Date:   Fri, 11 Oct 2019 20:41:23 +0200
Message-Id: <20191011184123.17376-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20191011182448.11420-1-dev+git@drbeat.li>
References: <20191011182448.11420-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro has been available globally since b4f2a6ac92 ("Use #define
ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))", 2006-03-09), so let's use it.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
Brown paperbag fix. Sorry!

It's idle to speculate about why the macro wasn't used in the original
9e83266525 ("commit-tree: encourage UTF-8 commit messages.", 2006-12-22)
or why it hasn't been cleaned up since then. Possible reasons may be the
line wrap within the division or the fact that one sizeof() takes the
variable while the other one takes the type. Either of these would make
a normal search fail.

 utf8.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/utf8.c b/utf8.c
index 3b42fadffd..5c8f151f75 100644
--- a/utf8.c
+++ b/utf8.c
@@ -95,13 +95,11 @@ static int git_wcwidth(ucs_char_t ch)
 		return -1;
 
 	/* binary search in table of non-spacing characters */
-	if (bisearch(ch, zero_width, sizeof(zero_width)
-				/ sizeof(struct interval) - 1))
+	if (bisearch(ch, zero_width, ARRAY_SIZE(zero_width) - 1))
 		return 0;
 
 	/* binary search in table of double width characters */
-	if (bisearch(ch, double_width, sizeof(double_width)
-				/ sizeof(struct interval) - 1))
+	if (bisearch(ch, double_width, ARRAY_SIZE(double_width) - 1))
 		return 2;
 
 	return 1;
-- 
2.21.0.1020.gf2820cf01a

