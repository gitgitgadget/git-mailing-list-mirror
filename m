Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA80C43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37C46135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbhDLVJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhDLVIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13169C06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so14339685wrr.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y3kBuuE1kqkzlxpCDekvhONE9z9UoTHKBwBc33s5cD4=;
        b=O5MO2C3AYS+X5iehYFLyxk8+Nq9ObLhm5RrcSglwAngzvF4UdvogbeEtnkqpam5xHL
         bG6fEsZXVt2dlziZx7gPpiS0QOVbEB5iORGh7mOSjgEBIIZAItSCFhtnzzLMzjbEotm7
         n0Jh22tyY2jpmHmC6X3x1nruRpW0GEC8abvIZID0PndTdq+642p/MDoYvmSvXqFtPzVt
         Ln2CDUXPq1tTFgD6JQlZ62m3NcVBJX9iT7+P3K7pmqrdstfUAlTvV5bXTHecXDVHIevg
         gJ6rsyC2PC5hwc/BUvbSjtbvdWCJ8jLE4UalhcTvT4zeJzk9ZumJFcpPl+dnm5S5cw17
         5uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y3kBuuE1kqkzlxpCDekvhONE9z9UoTHKBwBc33s5cD4=;
        b=mJDiEaS76s0yV889B2XmE4BMLV8rF7VqESm3D2TAmtwER4GGc4Du77ZCiRNbjlZb3t
         lJgR/3A23B2IpRQn5NZqX8pEQrBrTBGjxOIUXOLC6BdiD9xTPGmC0Hr3ZJpn7vqyGGG1
         wFOFJi39QAcs8iAylyRrjZDhpQREqZ2gz24Z79u73Hnqo9NYy1v1wrKBN+EaZHOFu9WY
         5bQha+5vLEVnnS39EvBO88uZwG+CssPBawZhXNfOH3p0fTV3w9z7mBaxYpwWxIw5VT3B
         d1biA0b3nreRQtZSQIIezDvIA3cgOxcJN+F3L5eCsdP/1gvtdhI4g6N+C5gajxoKSEkr
         MzKw==
X-Gm-Message-State: AOAM531oieIy/Yg6jb5zsojJI6OjddY1Pdt0Hacr1W3jLFNWwXNq3HdY
        giIXwOsJzbwD9PpFq3/3e3Ip8ZVyqN0=
X-Google-Smtp-Source: ABdhPJznyGBd0xjM9bxJeIeog+ddV2qiNqzCaFdzNAOAaUCsL+ZR5yvfv+pWGrHIAPlD/d0rzYEpwA==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr25431940wrt.27.1618261708926;
        Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm17068522wrp.96.2021.04.12.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
Message-Id: <daa77e84e0e23ec675aef6805e7c2df7dedbb6bb.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:06 +0000
Subject: [PATCH v3 15/26] stash: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/stash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index ba774cce674f..6fb7178ef2fa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1350,6 +1350,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++)
 			ce_path_match(&the_index, active_cache[i], ps,
 				      ps_matched);
-- 
gitgitgadget

