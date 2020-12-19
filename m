Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FCC3526D
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E876723B08
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLSV7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 16:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgLSV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 16:59:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA14C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so6844379wrt.2
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HpkuCdZdB85B+BmA/yqCf+ZFXqMotDFtVn4WR/mIu+E=;
        b=YmaPwN60jLJZshmTwhGpxfTv2L5vlywaCoTXZu4PuFOafAZx5B1aqLucAyBNQZt7k1
         j25uTxLMBWG5+jiM43iOY69TGpU3LAeDKcXznd0MT1Y62QjN21EOCsXjwdeaaM0UQMSQ
         3ihgZLOfYg3CkUJ1Ahj5d8LaFQdsKgZFKBSF2jbGdTXfNySWBG21VDAn77myXdf3p64v
         xj6U7DFPHZQfPOigomtP795cmroOoTsxKMJluQgE8Pk1x90P/yAlpRvs5+gAwvFE8lL3
         Cgl5VsVp29Wlhd8ybOVf8E2nx1gIKXgzFYNgH/NkohVRmthVZzeKN1IkyclADufdCAx1
         +u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HpkuCdZdB85B+BmA/yqCf+ZFXqMotDFtVn4WR/mIu+E=;
        b=a4WkNud7r0HOdDot9Gyzaon6hYKeHMcNnCyHUlv/LgP67hcPaJb8VW/lk3XlNQifK+
         OspO1vMXNUkXFM6B24tnmpMxuvh4aod9bWPeHKisF9vvE8FchwfUxDtZxzFSGet6dWMO
         aaTA+gh6CtobRpKTilDEk/7QPf447SOfY2CrB57Ul1dzV+sDBMu3otKfgssc+OyAqsn8
         lHXOsEIoaQHKFGhZPUIWYLm9SplF1zivD91DSY+aICtqR3fbkgbxiqOX1+KDjUz9ep5m
         Uh6JjJWwQBQ9wZyoe3bAvqnkPRkO8Bzmsq+Jpb/GUPCbdcL+LBcOS1gkCH+LHwawdssh
         f/Iw==
X-Gm-Message-State: AOAM533R3s7pO2B5yxkP6lfIgDTn34kLpHMKjuWsdTJX3MfxRj19ceq8
        XDjnPFHXrvRnpo+ByyaylqScWugx5I0=
X-Google-Smtp-Source: ABdhPJyzgK5NQa5U7JGtexdGuDAX2v7k2GUfxgUtDE7SsNICXbM2CKQ59IFjG1SV6GmKU1Ag1SCxqg==
X-Received: by 2002:adf:9567:: with SMTP id 94mr11112708wrs.394.1608415120453;
        Sat, 19 Dec 2020 13:58:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm18150875wrw.75.2020.12.19.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 13:58:40 -0800 (PST)
Message-Id: <8da8d9cd1c5230aa3a62f1d339c5006d33630edd.1608415117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
        <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 21:58:37 +0000
Subject: [PATCH v2 2/2] negative-refspec: improve comment on
 query_matches_negative_refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Comment did not adequately explain how the two loops work
together to achieve the goal of querying for matching of any
negative refspec.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/remote.c b/remote.c
index cbb3113b105..6cdaa8da75a 100644
--- a/remote.c
+++ b/remote.c
@@ -736,6 +736,12 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	 * item uses the destination. To handle this, we apply pattern
 	 * refspecs in reverse to figure out if the query source matches any
 	 * of the negative refspecs.
+	 *
+	 * The first loop finds and expands all positive refspecs
+	 * matched by the queried ref.
+	 *
+	 * The second loop checks if any of the results of the first loop
+	 * match any negative refspec.
 	 */
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
-- 
gitgitgadget
