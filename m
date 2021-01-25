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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C88C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C3722B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbhAYR4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbhAYRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF2C0611C3
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c127so49766wmf.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D9S1QwP7ENCfvG4pg2hrsdrzIOeCzOYkZSdS4yAEx3o=;
        b=N3uI11TZPM4pDDTjogH96xXG6shSh+Yv1YFvuZPq3AxTtfHdskHGUPWSIgybWkjnP+
         veKQu28Ubkcy6nZpmqOhQm24WXlYH3Dvxu13J4hGqPhuh/duZqcVgeYGfywbFZw2Yk5+
         +BxGGwn1s7qBqZvgb9unkBfrhPLEfBexWg8hpNZU075sR7FRenCgc/CKpvl6BUBs9spz
         IFW8cAH2PZnEobznHW25PiB/geZ4nbORWYsm7oB9m7Z75T8WBpRyCQrQFfulUuMS3hza
         rpuThE9gtrC3J4Uqj29KqWizMPJy6t/RhNiS5v4AGb530c6UttTreo4iRlo4xciccj1P
         gVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D9S1QwP7ENCfvG4pg2hrsdrzIOeCzOYkZSdS4yAEx3o=;
        b=C3J/iGetGR7Cge7JIzvLz+23XxdQjYeeCWoHYiYUq2UNI1+HOtTFv6XC9K9acOjjxj
         8J04A0pDYFfry87V8zSDBtnYMTeERzzcsofJXKFYd8kEQoGNnFoSKPjDhuFMSFCB+lLw
         XV2HUXDHeckcveTnnLe66MHLYbzDtD6Z9SrgLCAKrVJJsPpaebpiJmRMjGsnqHk39tOE
         WrWrABelcQ0ZzbNxQybYTyppUTBWSf5SfS4Dm1WchHZqfc2Qd+jPEMe/Rdssm/eiM5zv
         uE++71S74dnF2UeNxJepS7veKDGw6/uyFOlIhpdzSYC6hl27qFTgLjth+T99udy1niZM
         Nsgw==
X-Gm-Message-State: AOAM532joneUGpBMZbrgouq2lJ4GwvQD8DfOagGdSIqyiqAxft56AmdT
        kKIEQrzzt3MxqKPw6JGXn9RH//zFQA8=
X-Google-Smtp-Source: ABdhPJy1mi2hDVsHRY9V1iy/03aryYYE7HP2gmU+CdO5mnwjOJnCOPLIPkWsy0NnNtRaL4p2MsWqOA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr1153031wmh.47.1611596558430;
        Mon, 25 Jan 2021 09:42:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm23654785wrq.29.2021.01.25.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:37 -0800 (PST)
Message-Id: <5f53b08225771adc0be12c39e7be169d8620f146.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:12 +0000
Subject: [PATCH 26/27] pathspec: stop calling ensure_full_index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_pathspec_matches_against_index() focuses on matching a pathspec
to file entries in the index. It is possible that this already works
correctly for its only use: checking if untracked files exist in the
index.

It is likely that this causes a behavior issue when adding a directory
that exists at HEAD but is outside the sparse cone. I'm marking this as
a place to pursue with future tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 9b105855483..61dc771aa02 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -36,7 +36,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		ce_path_match(istate, ce, pathspec, seen);
-- 
gitgitgadget

