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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A20C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD72964F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhCPVSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhCPVR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FAC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x16so8182891wrn.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QOX1SylDMZ+6fT7XkYVi8iHYwVl542h0Yhiu2bYA6t0=;
        b=Qh+XA3GFXAsCm76lK3To3SiyrjdMLcoAn0zdNisJuKzNjqm6mTvtk4Kh+isPd3mJsO
         Rdpr6AkkCZzEHgd4gf26qc07mZoLGDCYA3omrqUqwMXHOZSfeV805LDoNFv1x0RV+5C0
         J9sk+8FzlZt71S629KJ8568iVFnUDB4qykzuKbvppSgKQeYZVGKNMaCncQctW7/N8atL
         WCP/OmDwrbOBKtKxOwC4cwwguOrhvfQxjbi5O/9FAtMBLKWgcG6nxpvny7PWhaZKBTGJ
         nOGMChtCCfV5V+Mtvh8sJX6fjwIjkZyUV9vRPjqp6BsdRiaq2TlY7/dBtXhSrb5367Qz
         SxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QOX1SylDMZ+6fT7XkYVi8iHYwVl542h0Yhiu2bYA6t0=;
        b=RLareqE77/CV6t3qpV6kmHwvn5DFYzGJuh4Mx+sxmpdCaVBG42BW6GO5GI2MyIx+V+
         rx38duDNFcqLz6VWwEKw6gKFwNPk+E1/i0deQT2fdFM1Lz7tzOKS8sHzBfjY8D1Tblum
         iQIsCzxmk3O6U33HFyJq/zcp4CAomv3tatC4YTH0/u6R5VaVBjyWR5ZvDhl0eXWo7Py/
         9/0Sg6bnfVBBp2UWgL3ioAim83KWRd1/91VZ22UBs/87F9Wbjv/6s1thnrwa57W3OfAJ
         68QCed1Z7ZwcT3rn6l9+fdoodvONDxClECaNEfpkt1HDp2tUfmBmW2dwOZVLHuYLSImR
         GCMA==
X-Gm-Message-State: AOAM531f04n0GaErUVSVGY6e+GSJOi8vttDUdtesCATkTjInQymOtLjk
        gXTxBNt0t182qYyS5viHKedc4/AAxmM=
X-Google-Smtp-Source: ABdhPJwQvj6zvgYYShjYsgCHTXseWuZ2MY5g5BySMt5KCz5T0zbq9O292OgzzFiCcdgMqtpORXvmlQ==
X-Received: by 2002:adf:bac8:: with SMTP id w8mr1023143wrg.68.1615929447379;
        Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y205sm634637wmc.18.2021.03.16.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
Message-Id: <92ccd31dd343c20bad4a6b8d89c50559209e7236.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:03 +0000
Subject: [PATCH 15/27] sparse-checkout: ensure full index
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

When adjusting the sparse-checkout definition, ensure that a sparse
index is expanded to a full one to avoid unexpected behavior. This is a
top candidate for later integration with the sparse-index, but requires
careful testing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/stash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index ba774cce674f..b3d4fe814b6b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1350,6 +1350,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++)
 			ce_path_match(&the_index, active_cache[i], ps,
 				      ps_matched);
-- 
gitgitgadget

