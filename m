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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E30C4363C
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01752610A2
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhDABul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhDABuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F2C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p19so247886wmq.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cwy0/DFLfwxmnrNn1jvtNHYmLs4yYZjayHJKnh4xlfU=;
        b=pyQoLIEImAwiQ68TTjrWuXg7jTNmGjElZol7PnopIjJ6oUr4MaHsvQl3FP/aW97tNl
         p2rcXk9vZidXN8DxJBRk0FuRgRvYTmERX6HCaZgi0eHPASjDZK9P0t3EozF+fw7b5zqj
         ZKLyE88EIpwzPD1ItvlRjf02PWybQeryUfypSwpPzHv/LvgzN225VvSwB6LZIZmS6/gQ
         EX0azO4egfUgfr9oaPxoxpz7PMiJv1tWEdvjL0XDwthqFzLCjkLLiN4xLGz8BCOHY3q7
         bgMECkGVXumx8l6E6imyR3Wz+ug1UhQK91mEH9ZcuzEYSbeKNP2wx5qi1ncce3iaXc1b
         wNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cwy0/DFLfwxmnrNn1jvtNHYmLs4yYZjayHJKnh4xlfU=;
        b=X1HVE28w8q0g/re35j8nMmhD6efKw6sgSeFKFlNKsn90rlKkVC8azJZ7oNQ21LtqEa
         BH/UAVr2qnT4aoFD2Z6fXn3tK6J9mUxc3fVxU/dTvvCc7v1nb7MiNj5wURLAwDnMhfnq
         d1T0QGyE6ICKGgW0O+JqMzicGQOVSDZWXArV0W1CtCJ0aAbcFvSEyjhTCthkKoFW+V6u
         +T+DERu9JtIgJ7OenPP/+Wr3SI5YC6eGGJV9CL2K12BPXUKnvXNquT16mY9FsrOkwsDk
         D2nPeSxyK63Jwx4EOsHNlAEyPJsDERjfQoX++vBB2ArXfMHdWut4eGJikDjnxauuSb71
         PlcQ==
X-Gm-Message-State: AOAM5328ZgTcBAUTgBv9FcnkHmcIQmev8xtUe9Ixt3fopOZVdI1I0Y0e
        wousyR/O9VihUs5Fx1PJOeKbN5JE2Vk=
X-Google-Smtp-Source: ABdhPJxKt7nyVRLopyYpgL+GkqPZY1yq/5UD1F4qGUeCfsSukB+XeNnSw1QOclvFIVex2538ALjXtQ==
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr5671303wmc.134.1617241815057;
        Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm5846202wmq.29.2021.03.31.18.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
Message-Id: <1e3f6085a405aa39692f3100790a596cc7b6fbfd.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:56 +0000
Subject: [PATCH v2 19/25] merge-recursive: ensure full index
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
 merge-recursive.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8de7a704eae..91d8597728c1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -522,6 +522,8 @@ static struct string_list *get_unmerged(struct index_state *istate)
 
 	unmerged->strdup_strings = 1;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-- 
gitgitgadget

