Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41250C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 22:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiLVWBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLVWBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 17:01:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C4DEBD
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 14:01:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y16so2984666wrm.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W21fIF9hEVBSUj6ZpMoAYYrlg9Rl00aLRwXMNsZm/J8=;
        b=pvWipQDjMsBrbofySMioNFzPTKTXO8ir10G95Gl6LRycn42rKqlF30SAqpL6rappxS
         BL9qhXnW6X2Z1woJgQB3F6xcr0jyoZjajES1e8zXx8eAmdIrTvxzXiCzX2AtsB1VmUgz
         bPaZ3/XcRc5x76BPRYcTmqCEfxAV2dyXxq1OBE3+2SKMwFgzVVuCkm6wG35SGxGwcP6d
         gq0XMx5mdrtffL5RZgfoTPU9BEnvk4rg47qqAkcDsG4PleSd8GC7Vt/IaOWtPU6T8Ml8
         d+eM/G7hpmKEKmpJSQ0cJFOFspKo7OPvKQUCethzIjnylgA9rcuZ0R/S6Nh0GEhyGvjb
         cq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W21fIF9hEVBSUj6ZpMoAYYrlg9Rl00aLRwXMNsZm/J8=;
        b=GSKq+1uQSThG7g71TjPC+lU8xVsAgMvKIQYfk8o8yACZ2pLuGmYd/CY6P2hUxIpvBn
         rXSMcfjCgjedql3QRE0gjnM0ijYLjf6ou4FTtXxzESmFTeFtniqhFXodVL0+2BuE1/rY
         LokqJzgTxUVzhHy/1Vm9fgKCPjw/nYMAzPUkEgUzBM9A7wm9r6QPX5MTKwcB4mYFbPhZ
         hFILRNiuHHWp4y4j/ZGU57edwZlQh1iivyEW/g5RVx8GVJnF91cr2miJ3r4TkBLt6V3Y
         NhDrtRyaOvDm4Fn4IZqP5KySWR3j10H0FlC2lxb/CLDq9J0VQQC/GNXlZFTC8EtrtM98
         1rdQ==
X-Gm-Message-State: AFqh2koRCWlKomI+CobR7uBl4ES+362nq+fqzp9xOHuJGcJMhJ+r/6KA
        EFwzLZWL2jqFoo+yVPCJ+Gdw1cBSffA=
X-Google-Smtp-Source: AMrXdXvDWZnxAWCMGah7cFL0SQsoAua0n+QRMBVaGLtrh9fqDM0TurUP7naWagbJ7uMYgaPQESUKuA==
X-Received: by 2002:adf:fa8f:0:b0:269:13b:b6f with SMTP id h15-20020adffa8f000000b00269013b0b6fmr4855435wrr.30.1671746465506;
        Thu, 22 Dec 2022 14:01:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00236883f2f5csm1535363wrq.94.2022.12.22.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:01:05 -0800 (PST)
Message-Id: <pull.1415.git.git.1671746464482.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 22:01:04 +0000
Subject: [PATCH] range-diff: heck for NULL over comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Although at first it may seem easier to
check for the same comparison that
determined whether a_util or b_util is NULL
or not, checking for null directly
would make more sense for developers
and static analysis tools, which false-flag
this area specifically as having potential NULL
pointers.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    range-diff: heck for NULL over comparisons
    
    Although at first it may seem easier to check for the same comparison
    that determined whether a_util or b_util is NULL or not, checking for
    null directly would make more sense for developers and static analysis
    tools, which false-flag this area specifically as having potential NULL
    pointers.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1415%2FAtariDreams%2Fmore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1415/AtariDreams/more-v1
Pull-Request: https://github.com/git/git/pull/1415

 range-diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8b7d81adc1b..a5f5996c0ec 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -506,11 +506,11 @@ static void output(struct string_list *a, struct string_list *b,
 		b_util = j < b->nr ? b->items[j].util : NULL;
 
 		/* Skip all the already-shown commits from the LHS. */
-		while (i < a->nr && a_util->shown)
+		while (a_util && a_util->shown)
 			a_util = ++i < a->nr ? a->items[i].util : NULL;
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
-		if (i < a->nr && a_util->matching < 0) {
+		if (a_util && a_util->matching < 0) {
 			if (!range_diff_opts->right_only)
 				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
@@ -519,7 +519,7 @@ static void output(struct string_list *a, struct string_list *b,
 		}
 
 		/* Show unmatched RHS commits. */
-		while (j < b->nr && b_util->matching < 0) {
+		while (b_util && b_util->matching < 0) {
 			if (!range_diff_opts->left_only)
 				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
@@ -527,7 +527,7 @@ static void output(struct string_list *a, struct string_list *b,
 		}
 
 		/* Show matching LHS/RHS pair. */
-		if (j < b->nr) {
+		if (b_util) {
 			a_util = a->items[b_util->matching].util;
 			output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, b_util);

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
