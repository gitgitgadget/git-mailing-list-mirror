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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C3C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BE96144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhENScb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhENSc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D74C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so182615wrx.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=iVhb01muPrs8Po4zHYEovwlFGbDUCkRZr+qjURvmQEnOVYWCP0+MyAMYwPulBkCbpl
         0VVFw54JpWptMq0tP9/peEzFajQssHDrb/tZxDjbQm+Z/GOfBYd4eyTwZZKBr8pWRb4J
         hn5F3r1dll0KflHtl8pi8VWyGuGo0rKDPEN6DkuOEifpRvlzcLKdEYjd9fRbB9lya7YP
         yind4eAg9SAO4RbJCf0QP5/wJG91DxWRupJSB4sSS4t2YlkndP4EdBb6//CiCHKRuZ6U
         l+zJnkUbfmLsBo63/8upVKJe9Dk0RdfPcLwDNiZkzF3nIwp1z2x7ufVf6FvVbsdLceIo
         nHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=gQXbOzdYh1TQaTJTVmQdA426sB5kLt0+n/hmLEeeaXD+gTO76hlXpuh517jwI/6LiS
         ftDaX37HVW6q8NYVI+WCcnhEr8H7A3YVgH/LOCLB00djoG7JT1TCYLrXfXwGyYMj8GYt
         QFtqhCN/5+KHvCQF25L2Bt7ImV5ZUxpgPatmUJJ3D2xgJ1d7k786hFi0Y1iGiOeKloRX
         +kbzrHS1Lt/TnQN/2qChaMGjdTZf30h+FMsq/ZZ+p91sxWhYk/xxgAy7ZvVef8TtbhTH
         cEl08n6h4DrJRZeb28coT1jpwxL18yDxr5pq2che/bCqMYRxkE5gPc6jp4n9pEFkPoI9
         MTIQ==
X-Gm-Message-State: AOAM5318s+iai5bWef/GMhd2MCvC0GdfW+EouwzJ50q+TCJVXoJ7ZZ07
        E9sjTPROThOAZO10JyCWHYk6T/zq3pI=
X-Google-Smtp-Source: ABdhPJwwgCL8ePyfSm5mx5WaL1MYyqdDp2lAJAeYdoi79DpOByZIzLdvYmgZseBKdSP63JXXefBf+A==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr13710481wro.254.1621017075650;
        Fri, 14 May 2021 11:31:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm8439123wrx.9.2021.05.14.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:15 -0700 (PDT)
Message-Id: <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:01 +0000
Subject: [PATCH v3 02/12] sparse-index: include EXTENDED flag when expanding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a full index from a sparse one, we create cache entries
for every blob within a given sparse directory entry. These are
correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
correctly written to disk in the case that the index is not converted
back down to a sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 1b49898d0cb7..b2b3fbd75050 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -222,7 +222,7 @@ static int add_path_to_index(const struct object_id *oid,
 	strbuf_addstr(base, path);
 
 	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
-	ce->ce_flags |= CE_SKIP_WORKTREE;
+	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
 	set_index_entry(istate, istate->cache_nr++, ce);
 
 	strbuf_setlen(base, len);
-- 
gitgitgadget

