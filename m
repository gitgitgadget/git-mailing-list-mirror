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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63EC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADDB6135D
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbhDLVIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbhDLVIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE80C061342
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so2331913wrm.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zERwEV3I5iAUQNSYAsx1jxOMzyYF1N8NzKg79Kbu40c=;
        b=DYfb3gigRPxudgkbEs5CqlLeTVoCfjvYRqw8FOiLC0Ek+jFzN8aiM4ZmiGb50mv/F0
         29HdQ9RRbSuzZtGpwTr/BlMY7rc2oeGXJGO++NplgICgpDBUpuQQD1DGhsid6i75qUWQ
         3LCO98s50bepUqEddR6wwZ/0BaIJ2knFOKrT0w7nVbR4TIU38Z1xdhAJx0OlpRTIJTWL
         O9VojX6qqYTxwlK+eTMrlZtox+gKumIQ+L7Iqb4k9FykHqcGU3ekWeDWL3ijjeWItK90
         Jg+COJX/XlfnIUEM18souzVJbqOYq3LD05vfHF7KOgVvsaGm8PYQ/kN8oV8G2fCJHkHH
         xnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zERwEV3I5iAUQNSYAsx1jxOMzyYF1N8NzKg79Kbu40c=;
        b=nM5vNyxMAjxOEHH1/JWlJi2Qf8XTKXbNjXoK9VPBOixUZxO/gcJ0dDm5RVnm6b8o/n
         UzkW4qhb/RjDv+3+4IWf7RPLXEsqcm8SKbp6m9qEXe9blkLcZDb6DEHjwLJ7ebe0ITnY
         r0Cog9evPX4gIyfgkHxnbsxcQPZ5FVfX1c2S11Db0hC6vch4uDTox8ycGMspZAf3PB/U
         kW7UV7tDempiOtoOIVDjlkvNEZbkQD3eQhMRpncNPODLJxKxfcPaEx/bFy/Vs1jkmEw9
         1TUfdxh/XxPcSla3MvY9K/yH4OpkhUOyIwMO9WeGCRPfky+v9TD/iMo2tRhzTDDAqkx/
         t5xg==
X-Gm-Message-State: AOAM533rFiATknxXjpKnX2emY5SglHXPEdakbUL4F0OZRlJOtvjhI4Gl
        X4ec3Bvv6JAOuy0JwEBeX3MLGabAjXI=
X-Google-Smtp-Source: ABdhPJyGgLggZTXQme5fcWF74K0TZMmE0WafZyrghyo2YwMsKyGTESKnsrG7F30PxiQCP4jgSNFSUA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr33063647wrw.172.1618261704495;
        Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm1266851wrh.8.2021.04.12.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
Message-Id: <1a3b51fd3c4bdfc50fa390d04c49b49acc47b90a.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:59 +0000
Subject: [PATCH v3 08/26] commit: ensure full index
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

These two loops iterate over all cache entries, so ensure that a sparse
index is expanded to a full index before we do so.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..cf0c36d1dcb2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -251,6 +251,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		free(max_prefix);
 	}
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		struct string_list_item *item;
@@ -931,6 +933,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (get_oid(parent, &oid)) {
 			int i, ita_nr = 0;
 
+			/* TODO: audit for interaction with sparse-index. */
+			ensure_full_index(&the_index);
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-- 
gitgitgadget

