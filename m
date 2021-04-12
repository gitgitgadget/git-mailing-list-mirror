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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF269C43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9665E60C3E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhDLVJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbhDLVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D793FC06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so1588402wrx.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DN0bJRJEdqZFG9ILPnNiBkEoj0NZzXfi9k5Yav8/FLY=;
        b=piDnghmgtJmQgFm3sh1ePGzKYMAxeknLFfb2VIs9Sii7OaDOZNxG1POa+D1b7tgm00
         Fg/gX1/MQbpBO4KpZCFXl0nElFwazJ8z3UFQv5Nl/epdsSm7MJ+oWCHp1vvXSLbrenEK
         9SrUOnbIb1eWo2irCzJ7nd1+u6jV8cRbfHQBTJ5BY5jh4jIPN+N8QaGLoBcvwwaN953t
         I5FYKHu9eXEcKUs5pxvU2WdGAUzTWoRBMvWh68jsTWqzAAsbW6whubDZ09yDHlFJjoY/
         IVgSy+qNSkOcuF288DxtnrIxKZIbkvA6Fe6wa+/+ynz18IsYttPCxLXsKuPrcDgovKJj
         BVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DN0bJRJEdqZFG9ILPnNiBkEoj0NZzXfi9k5Yav8/FLY=;
        b=WpEuTXaQOk0XyeE8KhlIEREa/BS80rlUeNyXEg40vX1gz9D5SUdnDB+hOFjwqYwRVa
         HSIngcwu3HweUzUK0GaUzyVa+gZpzaUy3EqEom24ogLJQISOJejlX0JqgCIdrhK2HVfc
         CMYn+sLBQiZKuJEY2MfPUunnnW6gR47Ts6pQT+PUz8YdtpmT+xBWtKo6lgMKq9+pPd4Z
         IynHuWqZVkGvdDEAcB70o0QYfYg/RF/Y0SQbIPZbvGNGgUJci8mZGOEU2IR/iLIuOR5G
         3zj5q9cETHeHop0cwxVS7blQ8RgtHFkS2nriP5vK8rQfplxD47PIdgHK9OS7Zrqu/+RE
         hJhg==
X-Gm-Message-State: AOAM531HDf4Qjx8ltWmfAB8eYoyOEzzUNJHBlFmZnN8FvAOV/ccsYRV5
        hdAt+8GUi3866rBfMQne6TrF88o5t3U=
X-Google-Smtp-Source: ABdhPJzjBxGTN36dTmTmBTZTiFEo5dgMDbyr/7wemsw4zvmP3DmnP4Qlx7IJAewvkjQhyKZB83CoEQ==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr33952195wrw.284.1618261710723;
        Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm506381wmb.32.2021.04.12.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
Message-Id: <825ebceee508bd5a00e5113bd43ccf82421ec5e2.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:09 +0000
Subject: [PATCH v3 18/26] entry: ensure full index
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
 entry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/entry.c b/entry.c
index 7b9f43716f76..891e4ba2b45a 100644
--- a/entry.c
+++ b/entry.c
@@ -412,6 +412,8 @@ static void mark_colliding_entries(const struct checkout *state,
 
 	ce->ce_flags |= CE_MATCHED;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(state->istate);
 	for (i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
-- 
gitgitgadget

