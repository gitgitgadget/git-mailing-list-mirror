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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB58C43140
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F67610A4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhDABum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhDABuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93115C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j9so167015wrx.12
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DN0bJRJEdqZFG9ILPnNiBkEoj0NZzXfi9k5Yav8/FLY=;
        b=BB1NuVv6QsOMAxK0gOhFggd6jXhYYCy2tCDSy1EXKxCIBInaNzxZlOTtoShPVtdlNa
         tD95NM2pouqachIbrMg7oSRH1ndDy3smprNVehKmxGsUlq6zPc/69IkMrH/9/GxnrKam
         V/v8n+RAHQy6cqFaAFNyXmV5bSGNvQc7LzJj1ZqkKhZnTrPULaGqB1uuZPaCTzGn4mzd
         aR+H69EI9spIHAT7XruW8yCKBOLT+DBLBBHQTPlEUdugXk8MCBZo2MXJxMXh8baBaY7f
         2ThkGfarRi7Uta+60RLdiVeGmCGzul4OBN+xXVasH16VqF6CCJYXWkhRXLS1dItQZYKS
         1LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DN0bJRJEdqZFG9ILPnNiBkEoj0NZzXfi9k5Yav8/FLY=;
        b=TbrWlra+IFKXkbGJR2aDfq4PRwaehKP/Lr5a7hrIfq6TUXW7LX+WPWR6SLLZ22/W4g
         cUuR4Re3+73cbewslVSoKBz2k9yArvjb1O619jDCUyRxAH7aDUpwm8GpUQRWYaxydCXm
         ginqI2XAKxMX9oijpH/Rd4XXuQvtMObuwnoOMr3UQI9Ap23W441HUTzfPfmoOdqL50vc
         kuF8TcvYhYR5II1pMNg4yJUFfKHjsVGxFqCFplEAYo3ECUzvQ1kRNQjh+RfO4ZVBKxzt
         y5bKZCksHfApeQ6B/z5OtR+MD9nQAgFL5hX6UwxFITo2TTYi+Lfmf5LCA8nlri+wE/W1
         LXUg==
X-Gm-Message-State: AOAM533za2Zaq9g91Go0LDwzHNkhs1UPvcCrCxSOZCC0TRmJKSInEFq0
        8Mj8gMAQ/hrkiG3oU7KbDBg0hA+i6jg=
X-Google-Smtp-Source: ABdhPJz8oRms8/JHmIVaUQrWCjpCrJdD7BPHnp/TimsdepRvZwDtopa/D/KxVDOCKd/mq+OeDijPZg==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr6684173wrp.264.1617241814457;
        Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm7061629wri.44.2021.03.31.18.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
Message-Id: <2b9180ee77d30c797f58f7e50ff9174e70797069.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:55 +0000
Subject: [PATCH v2 18/25] entry: ensure full index
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

