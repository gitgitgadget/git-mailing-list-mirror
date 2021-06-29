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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6B8C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7726C61C99
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhF2CH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhF2CHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBCC061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a13so23679207wrf.10
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=Q7lE5Yu8uwiEe3NZhUui0JoVoiTgw36P65E7+LLzjY0CO41RRKijJzb0V3Fq7FMgjh
         xZ3nZ50j7zkJaLwNh0KJiCJDtyhNdJbI+pevR8l10a4nMuTgx0Ipn5UF0IgA37ZLswxw
         Ilk5+RKXWBbgJfLAv4gw8KkIhgA+ORyminImfLT6EHLYn3KUR4FVVA2IoZ7hpQ9nNo9v
         sqt4B5vfhTTRqQgyKiIByu8R7xrUXh/9hNMssErFThRAyj/xnByxO3tugdG4ksPX+Zn8
         3DGPU4YUeltnVu6NwVwe0mALxOj/bZ04upBThzN8yXKICjuY0Ysm8LjpfT0aPZWpFDP8
         vE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iy9XiTv1ciKF1QkjuiSZgTtadS+h+8sdv46VtmcVxm4=;
        b=XmITuP/WLET0atxN+LRRKmdW7At6PguKOaE/DNvUFus2pIdSxpea3qAHFvyKJgP1XJ
         ndS80zQHpSKjT0i23dn2OY0foxesm7/5Xb+H3wvkcViwn8OV9a99W8sbJgnfKY6OxWUh
         5jiCAJCixhWiVG6MV/hgU3td+JdMiqGsNM6PZXeC1IwFPzmJJrU5Qycw1nio5cyQkUOR
         KwSVoTBt4ZB6Ra26a5mpKaORXxATl3UdpvKNNyzZuGKC4/eJLkSG+IZTx2moN3DzKQPl
         sfKtufuDjgDkWJeJmVOf7bTDV4l0S/1wBOZh8mYC8xDYxrrIJFNxreAFXoWrZJuOb7id
         73Tg==
X-Gm-Message-State: AOAM533iP3LsbvPKQhBsyn5tGPgsPSE59+QRxildZ39kYH1XhgwPrNzP
        quR+S9e60wb6QVFla4yrBTqGBBH6onI=
X-Google-Smtp-Source: ABdhPJzKCUdSLCU1eV12I1e8AOzhXre6ypNOH0hZOc2YuMqd2dTI8+FFdM+wxZ2Prf4R5FWe1KZ/Gw==
X-Received: by 2002:a5d:65c1:: with SMTP id e1mr31607912wrw.196.1624932296236;
        Mon, 28 Jun 2021 19:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x81sm1106212wmg.36.2021.06.28.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:55 -0700 (PDT)
Message-Id: <f5bae86014d0f76e4dc39560a5e73d5911255bd6.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:39 +0000
Subject: [PATCH v7 02/16] sparse-index: include EXTENDED flag when expanding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a full index from a sparse one, we create cache entries
for every blob within a given sparse directory entry. These are
correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
flag is not included. The CE_EXTENDED flag would exist if we loaded a
full index from disk with these entries marked with CE_SKIP_WORKTREE, so
we can add the flag here to be consistent. This allows us to directly
compare the flags present in cache entries when testing the sparse-index
feature, but has no significance to its correctness in the user-facing
functionality.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 2c695930275..ef53bd2198b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -213,7 +213,7 @@ static int add_path_to_index(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
-	ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
 	set_index_entry(istate, istate->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
-- 
gitgitgadget

