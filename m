Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFEEC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9663F208FE
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OimeP8iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIOEEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 00:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOED5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 00:03:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780FC06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:03:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so1958286wmb.4
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eMzBwudMGkVabCyMbJosW/5O5Wjvhzy0eMN8v30O1Pg=;
        b=OimeP8iTTiAcGJy5fdFLourgJ+o21MwW/4zV9XXVQkmd4AP1+alXFKaDFVKBOsyj/h
         LE8sHDsOwO6MzQRf4M3K+tAJ6P3U5M8R7bJOz0SKxv7oRPFOh9ihXUJ2PPqhWdYnTV1R
         d+hWn2IBB0Ceze2Pw+gTViEg/CeYxpweAqMKJ53mNnPbJfj06xLdnQ9cQKlPuw1xzkbC
         v5aoo9EDZvG7N4CnWko6Q8Xbhq9abBRdWZOGnlVkyAMyHax8wWLhsoWBIgwMRKBkbPYD
         6Y+xPgEMlsgYwfdqII8wjS5A4TWO8PTRtGYIHzm2ABGTBqfqNtUe4nvqiYUKlQDSF4gC
         0wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eMzBwudMGkVabCyMbJosW/5O5Wjvhzy0eMN8v30O1Pg=;
        b=hYvJd7vAbXtUbeQXo5296aMbDASusNTm5Eu+Xhf8yTeIGgjsnbi4NIkbCzbzwDLfZ8
         lKZh2t7aDT6D6Nr5jFc1o1POFMEK/R4m1MKVrKTS3adzgJcJ7Wgp8SZyXXR3BUJQpvbj
         zo30H5xblpPbZiRzP27MIb6eaOIjdqTxO5jpg24AvxagmP3fMxPbD8gyxBoNTSCHzJgw
         uAFOoiS/MBB943sgcvQorIB4rT23pe4eWZ+no2LCxNbZ9YQuwD5/sQtGa6X7k9KaVdoR
         8hilSe0RqngMbc6XId3yc4ExwnJ2hLFxE97KjZcBahgLpfSHy4tf8XdR1AZ6YXQXTvjA
         TBiQ==
X-Gm-Message-State: AOAM531Smkb5EZUXKa4ElwN+RR3juP7usoRZT83LUU93VqqTOGH5yYRa
        oVcX33cL7OoAKEY+srlL/8ihewHeQq8=
X-Google-Smtp-Source: ABdhPJzUt6G/UUcCUuwyrl2NlXO1vx8d0jo/WEh2eiVq56/beYHZo2XZBLL6J0GseK6N6pBWWVVAnA==
X-Received: by 2002:a1c:8115:: with SMTP id c21mr2457842wmd.153.1600142635522;
        Mon, 14 Sep 2020 21:03:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm23413940wrv.94.2020.09.14.21.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 21:03:55 -0700 (PDT)
Message-Id: <pull.733.git.1600142634326.gitgitgadget@gmail.com>
From:   "Conor Davis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Sep 2020 04:03:53 +0000
Subject: [PATCH] commit-graph-format.txt: fix no-parent value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Conor Davis <git@conor.fastmail.fm>,
        Conor Davis <git@conor.fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Conor Davis <git@conor.fastmail.fm>

The correct value from commit-graph.c:

    #define GRAPH_PARENT_NONE 0x70000000

Signed-off-by: Conor Davis <git@conor.fastmail.fm>
---
    commit-graph-format.txt: fix no-parent value
    
    The correct value from commit-graph.c:
    
    #define GRAPH_PARENT_NONE 0x70000000
    
    Signed-off-by: Conor Davis git@conor.fastmail.fm [git@conor.fastmail.fm]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-733%2Favoidscorn%2Fgraph-parent-none-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-733/avoidscorn/graph-parent-none-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/733

 Documentation/technical/commit-graph-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 1beef17182..002a480c9c 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -77,7 +77,7 @@ CHUNK DATA:
   Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
     * The first H bytes are for the OID of the root tree.
     * The next 8 bytes are for the positions of the first two parents
-      of the ith commit. Stores value 0x7000000 if no parent in that
+      of the ith commit. Stores value 0x70000000 if no parent in that
       position. If there are more than two parents, the second value
       has its most-significant bit on and the other bits store an array
       position into the Extra Edge List chunk.

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
