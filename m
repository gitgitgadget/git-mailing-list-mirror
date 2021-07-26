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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B783C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6177060D07
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhGZOir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhGZOi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:38:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94247C061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q3so11616277wrx.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sVu7pFKkbkvWdqnDCNoAaVOoPWAajLXV8osQWTlKXmA=;
        b=t+9s0BFot+OEMzWyb75ixedPlHnTg/SxMlWaYE6+9q/0EYUcX3bEARZYMeAWJAf9w7
         qud+V5Lt1D1MGj0ayKwtNuItOGL8gphjuRhWs/2wmW8+LfCG9do++2Zlz1k2yz5WNfC/
         NXtJUZ2aw6qnlC2Mrz5OAwV5yPouBgiYO2pqpjluCZX2tXqCq0aYDmwePcA2FEU0bc28
         LdOvpzg2I08kOtv4UcECLNSPs3p4JwJtcqWO9evvnjwFSiZpgk23dqV17UmtbvXm1m65
         KeatYN+hXlvYk2qvB2+AnmkVj5pRH42fH65lqKcn+zEF+zDBOR/YD2SAcVfU2QNnKcGa
         4deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sVu7pFKkbkvWdqnDCNoAaVOoPWAajLXV8osQWTlKXmA=;
        b=lxoHofNBx5Xx4nYnXX8utIUx2An9qWqWXMitXWpXvZy5AiYRzAagXKFjr3LKBZ8XTe
         AyIZmPJsnF3Hm1X19UVzCMtxcJ4jXhf5hnXDFtrzYbOFRdOxwKbj+C8kSdN4nisPlz6n
         Q+VPPJzlzySKdN/+gxeeH/PvlYGcdouTOh3l0+iVtw6e0VpSl03Puyxc9cnYtp2CtbzO
         sl4HAvWWYZ5d4/CAGI9iYJTi87XzYfqgJVY45tBkyULbQxPQ7J6yaoyzpsVpFOXcuAsM
         drUlH1ahpPM5ELflUnjeevxa2qUAh2apnZwQ18sSFSIRNLeQrsBSyCQ6N5zUYWD6Gl0s
         x5xA==
X-Gm-Message-State: AOAM53170hOKaP+cocLHs2DRA5lDLm/vk8VrE7SxTs/iGRW0JN6b4A6D
        RZ2FpLR7U+yrlED4gZJ3nGvs4TKz8mM=
X-Google-Smtp-Source: ABdhPJx4LJUau5CX/zb0IKEZRRo0ukHPEhr47GcyKL/wyDT/tf+qbo+wEKjCLdFdg0xBUctpxOVm9A==
X-Received: by 2002:a5d:4912:: with SMTP id x18mr20599775wrq.310.1627312733251;
        Mon, 26 Jul 2021 08:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm127984wrc.6.2021.07.26.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:18:52 -0700 (PDT)
Message-Id: <1543550a4e8cc4dda495c08c924034291001386a.1627312727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:18:47 +0000
Subject: [PATCH v2 5/5] add: remove ensure_full_index() with --renormalize
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --renormalize option updates the EOL conversions for the tracked
files. However, the loop already ignores files marked with the
SKIP_WORKTREE bit, so it will continue to do so with a sparse index
because the sparse directory entries also have this bit set.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d512ece655b..c49e179abc3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -144,8 +144,6 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-- 
gitgitgadget
