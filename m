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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF0C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7EA8613DA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEUMB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhEUMBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289AFC0613CE
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so20897764wrm.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=maEYn8ggn8Hp5Pi8yXz1kVDITi+znkoOdSOu2if1IB7oAYApdssdonSJpQ+Qe1OakX
         cIE7axx5/TmSnmDpiuHg+zEjqX+pHW7f8qJ+J23yNUPEGQltEpOsQ0b2DPVwTSyv9NTf
         OadH9fyF2J0yYUTRfpu1aXY2FRP8b7XOfmVxnNkrx6vmc+oCKfO09GkezdqHaLqX+Vg5
         TsXqIduSYjowCp7M8q2QqSK9U6Z4qL6FHLE6OAu1aUG0KAemCMR80ps8gq+WS80E86SC
         ju4nRHvElxC6In9wTxqwhEPcX1US3aZh3QKhL8TpPCcFbycRJ8Rnc7HD3rxeNUQGKuEZ
         CzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QTzuOgoXGKpn026RiRL8qt8jaloUIGodP1E75w97/mM=;
        b=soD1sZ7bZ4UNkQDF15yrLtnErdBogYkBKuJj00Cjqeo84DDljCsVD4HOSmnYW5Ox7n
         dP2bfWSKLVakf/DmKcAa3OfBlzooCfouA8TNlvitOQZFMSf8IviXPOVTEpnTO25z6xbh
         /3dLsutUxQWN3PD4Yj5OjZu7Vq5vNEP8KVFP3cLn2cgwLddU2Te7EUqbIuDWA1Ts8O/C
         8gLydmZLTbBr5YQpHYLdNhJ4+pBLNQN6LTTqhkPGexLWfCf/AmKS63mr15x7k2ANVtf5
         Fdn0x1nJDhRsenrTLIX/ud+ubcbvK1L9vxa9L6/ek0srCtvQJxbU9lcxJNegYV4YM1g9
         X0qQ==
X-Gm-Message-State: AOAM530K5SzhIi0w8SR8j8krjUKm2pxdP/i5jYrgHSJOYJVJTyExgFgX
        2Rsmq6z5cKi9owqUvSSrKIamKhT5R7U=
X-Google-Smtp-Source: ABdhPJxEvSHA0dlSud+jbn9j2mAsLLGgXP41G+rSkO9eSWcGZYtOn8CoSfF95W78mSI8rrDPp5VQog==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr9369627wrc.292.1621598384862;
        Fri, 21 May 2021 04:59:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm5410172wmq.27.2021.05.21.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:44 -0700 (PDT)
Message-Id: <8aa41e749471df3bd9d593b8f55db6506eafea12.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:31 +0000
Subject: [PATCH v4 02/12] sparse-index: include EXTENDED flag when expanding
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

