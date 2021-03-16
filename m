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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E1C43142
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CF164FB5
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhCPVSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhCPVRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12781C0613D9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d191so313317wmd.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5C1rmeTZHP1Dom+BXHxQl5q3ACMKAOcfZGQJrPmzVp0=;
        b=XLdLxkk+f0CLYXKteKl+tqR03mGWr+fQvc853kQHksCFnVWBAbMisxXZiObmylA8u1
         uBAjLqHIOt1Mmy3849zJWCn0P56VoehEcpZxSBKCI91dvT0H/dp1LCivvv+6M002W4UH
         jrPWIuN8TjWBb4WDTEVYfm2Nq1r8A8bQGtgVLUs3R96wQ8n6wfd4RhOl4oyYUtoNZCGU
         I0Ie5W9IUIhit+gI2eIVoRcCTDGkJ6YJ4tjbCPA7cPiJ6G9FQvvBcHa/rA0MTmCbj1Fj
         uiO/yRuSAdR9fDvzKUuThvhM7vsQAMF7BAYd0Kr6XP4Eir5ETO1bY8fNrTJFwsvNIDNJ
         cNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5C1rmeTZHP1Dom+BXHxQl5q3ACMKAOcfZGQJrPmzVp0=;
        b=Ge1nBNJACAJi816X9iQPlb1k9xZdUAwDPrleSjXOExGKQdOHNt2GemB/OIkkBwtZcY
         4rAPlCeiwU857vmKYLjw5lDUbkb+mm7Og09az/moI4mDWUfdmfzJ8Qly76ibSejPCpJ1
         2W8AkLbsD1Ffy0/n8wh7yQmz02oHtYpDdCIBT5Cd77Fj9Lo7hVKXvREUPwiigFkX0Lma
         RCIBvORF8L355ps1fQxRO2EALMTMvMziEHJNFGphn97EO8w3JDhVFKTFjx6I1SSI5Hnd
         rDmUT/mVEUsQGYN6SfpJ2c9HLGlU+RVjJIkBoIkAduOVQjKdVwsb8xOrMRBPCbrumb8g
         cGbA==
X-Gm-Message-State: AOAM533xdbfuN9KSxUWUzPOxRWejrMK1kxpgWZve1qsX2DdgD+a9k1mw
        ATIv4YZyHg+FY83yLL+T/jBs3s2RDvE=
X-Google-Smtp-Source: ABdhPJywSCPoGqp5+gjEE6mUKFwp2UMlj8VfPNL7xud6hq66sfaGbV84q6UuyBbLNZDGbOyrcIeTpw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr655938wmh.111.1615929452852;
        Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm505047wmm.19.2021.03.16.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
Message-Id: <39e8bea0c1cadaf2a59760bea13025415569476f.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:12 +0000
Subject: [PATCH 24/27] resolve-undo: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 resolve-undo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179cb..3ccd3f66f80f 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -172,6 +172,7 @@ void unmerge_marked_index(struct index_state *istate)
 	if (!istate->resolve_undo)
 		return;
 
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (ce->ce_flags & CE_MATCHED)
@@ -186,6 +187,7 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 	if (!istate->resolve_undo)
 		return;
 
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_path_match(istate, ce, pathspec, NULL))
-- 
gitgitgadget

