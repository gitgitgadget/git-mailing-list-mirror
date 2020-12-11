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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F8C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B725A23F57
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437380AbgLKJKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437328AbgLKJJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:35 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9DC061793
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so6894689wmc.5
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XL0RdMhJCBZ0gxMDc9iKNk8Af4u8BEydSMvvnNYLvbo=;
        b=cZLmAj6F/qCu9wdgsEXXr6BJ4S8o8Q6UZ0l6mNXEbNDXA7jOpvSj2kIiAttV4njvEY
         71BK+4cg6djmt1Dj/DqOerHGFTU8Q+WnDZmL/rBBY1WXCSd6sp+nPwTgXNM+Y/aKyiqc
         6S21Bj9/z8tJ7XDqtPHDgUNNlmfsadxIgMWdwqX20xymNzYUevx7LbuKiVoJmbQ+/SkB
         mUcyhJlSSty7M+Uy/9Ud/7i3CJ9xIx79Lo51++dmlO08Abz7ZQbhKzEzJVY+0s6+/uYt
         EOYwqM58UrzDVV0UNj1N3L8C6DrZPpyhWi/bAZckRUh1yv7L0u4w4MLcDsLN/P5kpPa5
         g2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XL0RdMhJCBZ0gxMDc9iKNk8Af4u8BEydSMvvnNYLvbo=;
        b=CuHVcV7RFhUwYaPNmTfSjZCwC8o6kP/3ADSHeQ/FRAiU5XpW44yyUsmQCEoXOvPySc
         +ePvu2PZb8JIrxPMhHHz0vHR1Tp7c5CnMm2Ud/8Se3DF3x9YU1LpwDXbyMBMBnxdEW/V
         N80SrVdAxj1BB3prmHrHGbCxfRTOWimYqgnW2+cxe9sO2KKRHkb2D/z2eT3qY15dPvrg
         cWFWFWLYb3gWyu7S30Q4TxqtgamHEFlC1VN6vsqsXlASponwHWoXh74eajq9sfyI3Ua8
         vpPuApGy3sVoUrj5Ulav5rjj7ps7nsnbLYK57qxEtJPQN83kllv5kSMctz1+Y7VO04r+
         LwaA==
X-Gm-Message-State: AOAM531sGrSJIEGF870yx4UfpOmr4B4ecNvLY8jmLFx1O9dXh2cfcEXJ
        eaAqreg1f3LWSZGlkMfvE0icea/8L6I=
X-Google-Smtp-Source: ABdhPJzQoodNMMhxa2/q9X18sdEfyQlcsiE4IzlwBPJ/xgakNmGQgvvTEPXvJyJiJqm6BDB7cVNtcA==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr12411954wmm.103.1607677732986;
        Fri, 11 Dec 2020 01:08:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v64sm13235007wme.25.2020.12.11.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:52 -0800 (PST)
Message-Id: <7214fa73fdd13418744903f6c769fdb77c9512ce.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:42 +0000
Subject: [PATCH v2 3/9] diffcore-rename: simplify limit check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore-rename had two different checks of the form

    if ((a < limit || b < limit) &&
        a * b <= limit * limit)

This can be simplified to

    if (st_mult(a, b) <= st_mult(limit, limit))

which makes it clearer how we are checking for overflow, and makes it
much easier to parse given the drop from 8 to 4 variable appearances.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1d6675c040d..16553ab259f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -447,12 +447,16 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
 	 *    num_destinations * num_sources > rename_limit * rename_limit
+	 *
+	 * We use st_mult() to check overflow conditions; in the
+	 * exceptional circumstance that size_t isn't large enough to hold
+	 * the multiplication, the system won't be able to allocate enough
+	 * memory for the matrix anyway.
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_destinations <= rename_limit || num_sources <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)num_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if (st_mult(num_destinations, num_sources)
+	    <= st_mult(rename_limit, rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
@@ -468,9 +472,8 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
 			continue;
 		limited_sources++;
 	}
-	if ((num_destinations <= rename_limit || limited_sources <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)limited_sources
-	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
+	if (st_mult(num_destinations, limited_sources)
+	    <= st_mult(rename_limit, rename_limit))
 		return 2;
 	return 1;
 }
-- 
gitgitgadget

