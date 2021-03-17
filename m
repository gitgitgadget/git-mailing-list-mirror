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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D6C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFD664F26
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhCQQAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhCQP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 11:59:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649EEC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:59:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j18so2364349wra.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c7nPrSxh3Qez9KqS0xiYCkVagBtRGfzCe+Mfl8Z+SY0=;
        b=ldUVJwqCL+ej0BkmvKVNTlHFVCuzHBJntp6iUHkciY5CWVatcNDs+5jtrjw1FcgSoC
         Z0tDmRO5UE0Pv4YqsrGNt27M7HiltmyznqxpG6r7J4rd14UYkz90wF7hv97mGYiAo3qy
         mM39n6R3Sb+bh+ZG/wf/5Oo40606K28tOuneqlzCR2LFjpzAlPvDHtvu8IyZjevFVikA
         jEzEMYkNAd6RCJ9JgrA5pRKEAVPBd5dNfEHBcJJByrBZ6FuQEbp9H2zOTBk3Xmiw/NfF
         Spbfs+n61mqFqaGTghK+S6nCcG2JwT59FiPCibHUCIDgrEUYHEHWhdNSeTcvgLfN6/cc
         4r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c7nPrSxh3Qez9KqS0xiYCkVagBtRGfzCe+Mfl8Z+SY0=;
        b=t0YVvXiP5rPIP/G2PibTHLoS49C0i5KKcHsR4HXc1uiJph6jROeK5R/mOpJ7wmHFI0
         /VcpXe0hnO7cLfK+YIG/CVauqXNQuUWS4uJjiw/8gwePsqfwlx3edw0PVPQqStimBs/S
         0TbIxOglRT6rFLS3N1sHjmU3K/+dvw2oV0xTzPXe5zzQ8fZTjZ7DaHbllQT35cluXFh4
         bt1sLr9z4E4Cwrhub1B3npH7CI9X5pRR9kjHZG93Xese+zN3MaJ7fQ/TF28A2uoTp+mG
         joUnhZgqlC0/XPtyduKycxwk4t9ai9cezkH/GzahUiyiZnNZxa1ol1fT5oB2cwaQKfHW
         vNBw==
X-Gm-Message-State: AOAM530dSfRvTSGosYFgHoNkXZgrK6n8SeW6sSlFbDAR3yAb9Gldx8EG
        yT2FwoVzuuRPRPYA9cC543Izw34CFCI=
X-Google-Smtp-Source: ABdhPJyM1OvUDyCsLllwRymUTyqG6LlWHM6c9T1E64Nea0C6LP0f+QjhO6T/RLX2/YA+MB9LotC0yg==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr4970660wrx.215.1615995051790;
        Wed, 17 Mar 2021 08:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g202sm2754863wme.20.2021.03.17.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:30:51 -0700 (PDT)
Message-Id: <e194809e547eb5bc8e8d1ad09d874ebfde0efe4f.1615995049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.891.git.1615995049.gitgitgadget@gmail.com>
References: <pull.891.git.1615995049.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 15:30:48 +0000
Subject: [PATCH 1/2] fsmonitor: fix memory corruption in some corner cases
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
index_state to opaque token, 2020-01-07), we forgot to adjust the part
of `unpack_trees()` that copies the FSMonitor "last-update" information
that we copy from the source index to the result index since 679f2f9fdd2
(unpack-trees: skip stat on fsmonitor-valid files, 2019-11-20).

Since the "last-update" information is no longer a 64-bit number, but a
free-form string that has been allocated, we need to duplicate it rather
than just copying it.

This is important because there _are_ cases when `unpack_trees()` will
perform a oneway merge that implicitly calls `refresh_fsmonitor()`
(which will allocate that "last-update" token). This happens _after_
that token was copied into the result index. However, we _then_ call
`check_updates()` on that index, which will _also_ call
`refresh_fsmonitor()`, accessing the "last-update" string, which by now
would be released already.

In the instance that lead to this patch, this caused a segmentation
fault during a lengthy, complicated rebase involving the todo command
`reset` that (crucially) had to updated many files. Unfortunately, it
seems very hard to trigger that crash, therefore this patch is not
accompanied by a regression test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818be6..63e3d961b378 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1544,8 +1544,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
-	if (o->src_index->fsmonitor_last_update)
-		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
+	o->result.fsmonitor_last_update =
+		xstrdup_or_null(o->src_index->fsmonitor_last_update);
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget

