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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BDC4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9564F9F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhCPVSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhCPVRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9340BC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so8168127wrs.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oJBeNoxpm/TGvI8RBIoAjug82bLPpj6LNmOLCNgg5HE=;
        b=TLHko8lxtScCChPj3F4Zn1GsPichdRgaNqtlIXinelt/vBrIUbGatQAziisbHzX+N0
         ZPIXtyQQBTxc+BTisZG/tmKZMGFL+jLfSM/c2dK5O05axSMzU0gY0Z3g0aHsfrP0q6gW
         im0sG4f5z/vuPEC4MSBk9flptp1fkUTtLHdXFuaianHTotB5EMEQoWAZPHPGuE59A/ou
         RkVl3+af0O//KF/EzWYQts5NffM3HtwGUDSrTT5R9ffQeuCdil6cHdSf/wlnXO2oCagJ
         iH0LZYnWNNo2hJP3ByOGMxtVhRz7rWUxz0zwJgTLi2DGijoFunoxXByhbLqYY/SAFUjL
         1bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oJBeNoxpm/TGvI8RBIoAjug82bLPpj6LNmOLCNgg5HE=;
        b=tl3t/QCQqLFp/0w7Cwd5neNhwEItpmY8x12wjQD5MzDXRuNNwxc+LacFn9elyIt10k
         CxQVvHICarH5UHOAbz4dz9OdVrgajlgCEyFoKOSMjkIXN7PTIe4ZkLdEZBu0Tt2eRKp4
         JUIW2yXbbsQ1pjAj9uP/qjFd3O7IZnwmfy5afcttDoKmc1+VjSnKVbj2gTaW8wuyGkmK
         fBrQOuPBXoSDkWxalLo/Gw4v12jar9v2timItJJz8z2IHSd8TnWNvlnt+UkiBkCgFLTV
         U9YWkW1+7/QsZoymrb39rRr9ARTyWnYZxYN3XyoxV1TUz2chqxuqHo5hRQmSicQs4a1n
         Vi7g==
X-Gm-Message-State: AOAM530ErDdq6A/x+nYoGi3PQIC1IXkNWruFrXIhwOb+MkjGtY6CADnJ
        JWIlGYYLYMEY6t2zgTBZ9JZlhisWd18=
X-Google-Smtp-Source: ABdhPJzn7RV8VzVWj1moaFSky8k2qDLksoozXBlCzMTXpl5pW36FIFeJsk3sK0SXNHvXb6Jd14WKqg==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr1024566wro.200.1615929442396;
        Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm606502wrp.96.2021.03.16.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
Message-Id: <1bb7b6117e41ecf84afc03a29727d65606601be4.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:55 +0000
Subject: [PATCH 07/27] checkout: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries in the checkout builtin, ensure
that we have a full index to avoid any unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6639052001..2e64569d2e13 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -368,6 +368,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 			       NULL);
 
 	enable_delayed_checkout(&state);
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -512,6 +513,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++)
 		if (opts->overlay_mode)
 			mark_ce_for_checkout_overlay(active_cache[pos],
-- 
gitgitgadget

