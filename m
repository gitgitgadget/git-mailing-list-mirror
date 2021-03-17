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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A2C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2264F4D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhCQQBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhCQQB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 12:01:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B5CC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 09:01:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3673840wmy.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jy0/TMfCR9ww4tldkNFzg1vBknGg6pATYebQyLN8IQQ=;
        b=emtS9I7uxlg8yK0SPrfJ3wSTEsVeSFhwtqSPQI4ezF30tR6o1TN08a3C4bDOCUUbOS
         W2zpLYi14t0E8YR+PtLxbY5lI5qOl62xRAMGKgYA8LhLOPvqGTpT0X+Dt8NAHVTQzAIR
         17LM5pBkn2dAZo5cCCBkydMZ5ivsYdRWquauOMRhtgc58s5E9dyOl8J/qrW6goJrqRqz
         z/dWBNz/1/aTZCcRvU3cwhcAtexPR2vWNoEezQm5x4V1d0RKGDAomovvYRQWyrx/8jaS
         QvmgzOqrvWUdOJ5Hvcqs1UBk4Jpa9UlEIQ92k57rFrQDZwD7UlAt5uns9PVW6WpRssUf
         nt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jy0/TMfCR9ww4tldkNFzg1vBknGg6pATYebQyLN8IQQ=;
        b=b1AdwUO5A7cohhCutZz6ZTaOXVAq5HUqba8HXPsHK9RgbSDcKW2m2nDqs8y7i8I+Jb
         2iOh9+pFkVldB9JxIa53s66f57Jx+zq+mpmqfUC3O7VTVC1q/iUXB8eP5LIHqh6DyqH8
         WcJh1FAQ82JGNDwdwbgq7uJDFb6Ijg+bMpZExg7uNjPmb7KH6ZRJUfKLfZSS+bknziik
         H4Vt6FGnATgKWN7uRdJ4E1cV7SEXLTCPl4Xq0plraD/1by8ImTePeT8NtJwRfci5eqR2
         hi/zCcQ1RW9VMXjXeHubKA4COfSg7hmSVJyo2Unnm73LY3uPw0G6eL79uyCSaAXyzIGE
         m8Vw==
X-Gm-Message-State: AOAM530PbLqRYAu25QSTH+Km9lybJUhxvzK2hBXHNrc//plN3DaeOMz0
        7o0+cop/rbClF//PB4eGXkVQfrB2ywA=
X-Google-Smtp-Source: ABdhPJykuys3G7gzUcgYvkaQkJCDm8pN06JbAE7yftjSDoHIui8LoEzJQ/Zc/aDpPmmPoXT/4XWc9A==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr4277711wmq.168.1615995052262;
        Wed, 17 Mar 2021 08:30:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm25967893wrr.78.2021.03.17.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:30:52 -0700 (PDT)
Message-Id: <2b4dd0c9160ebf1d676c63585869f1a35da1a0bd.1615995049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.891.git.1615995049.gitgitgadget@gmail.com>
References: <pull.891.git.1615995049.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 15:30:49 +0000
Subject: [PATCH 2/2] fsmonitor: do not forget to release the token in
 `discard_index()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 56c6910028a (fsmonitor: change last update timestamp on the
index_state to opaque token, 2020-01-07), we forgot to adjust
`discard_index()` to release the "last-update" token: it is no longer a
64-bit number, but a free-form string that has been allocated.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index aa427c5c170f..cf5ff3158550 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2364,6 +2364,7 @@ int discard_index(struct index_state *istate)
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
 	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_last_update);
 	FREE_AND_NULL(istate->cache);
 	istate->cache_alloc = 0;
 	discard_split_index(istate);
-- 
gitgitgadget
