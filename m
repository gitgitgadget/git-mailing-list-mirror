Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A3C433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE510207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRjn70T4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgFZMa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgFZMar (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4CC08C5DF
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so9299998wrw.12
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c/zMv9Pl8Px8pPuhdc4kPadMp54xcVAZZhck8gDDyHc=;
        b=qRjn70T4FPrYq+RU2VrowUpgEtN3tjEVgwTEeH6CrRIkXpG4tgidYjg3HT76K+MUcp
         PUaXQWM4vkEyHliuVzVqFqgM7zkQps/EqmPVXpZJcopUIzi14NWJC4oMF045v+zbeFbv
         lTB4JmBQy+JHVPEzqIJ9W+8/bPfN0gtw5cMu/UeACcqheeoUs1hKr5EshYxOoIabXqEy
         3j5+T6YHoz6xZ/cK3MKYDGhZzpgG3GpvRTL+0GJZSQKuthJObD6tcCHYduRpg8N62GBO
         ogTXz39x39Rn01et/Xu8zdILrLlLI0Hbt9/s5ylth6VJJ8Bhbd+3sEcxc1j5IP6O9pfF
         UeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c/zMv9Pl8Px8pPuhdc4kPadMp54xcVAZZhck8gDDyHc=;
        b=DYUDhMdtnG55Nx1e7ZtoZHQMbSHmRpjBS1oz8rRF4nCwnnRgya3g9/2Og2jSC9ujcx
         +/m5uh0s5Igmq63iVQzmodV9N8DxhEMRs1hLM1OKHa9MsJC23q7Cs+XnCzebBHQNbVBW
         PGvZxyCpRapKlUPzGIZihE4fs/20lXJxUa5zXd6odbGKLaxznM1E/7ji+5MsY0vQt7zC
         aAUT91ZgwW3DerlEu5Ff7LlbLGv03yCcLbQLjlcw1wketI+up7ub6mDehQN+zbikwa+H
         KYrOBb9DsqrjmxbJxu5HMLQc01qhVC1d/ebu5r39daiKvXk+e21ih9+me4nQCn9nFlJF
         /RLQ==
X-Gm-Message-State: AOAM5337237mGncGQkCmsRGTITxzv64TYMs7pEQEZOs2vRdVV/qycdMQ
        8ZbvyTvq1f6neXIVMgAe8WlXTtLV
X-Google-Smtp-Source: ABdhPJyPkbREoFIGxhI6wUfuQkcmqe/LjnDi3y3b+kyWS6wxZnfsaOj1Urlzdd8dwln82ja5lZJLMQ==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr3532783wrr.211.1593174645693;
        Fri, 26 Jun 2020 05:30:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14sm36529231wrt.60.2020.06.26.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:45 -0700 (PDT)
Message-Id: <8b6370614124dba15902db43dd1db496ecc62612.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:34 +0000
Subject: [PATCH v3 08/10] revision.c: fix whitespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Here, four spaces were used instead of tab characters.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index c644c66091..ed59084f50 100644
--- a/revision.c
+++ b/revision.c
@@ -697,11 +697,11 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	/* remove single trailing slash from path, if needed */
 	if (pi->match[last_index] == '/') {
-	    path_alloc = xstrdup(pi->match);
-	    path_alloc[last_index] = '\0';
-	    path = path_alloc;
+		path_alloc = xstrdup(pi->match);
+		path_alloc[last_index] = '\0';
+		path = path_alloc;
 	} else
-	    path = pi->match;
+		path = pi->match;
 
 	len = strlen(path);
 
-- 
gitgitgadget

