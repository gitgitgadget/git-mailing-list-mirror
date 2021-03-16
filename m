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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB21C2BA2B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B4664FC0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhCPVST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhCPVRc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69CC061764
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g8so300237wmd.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5S+boZPxZe9aIuGKULqdZDqc05UAmbuh62BruURpn5w=;
        b=VAVn6JncjtQKmdOvlruaicJWQHhTZNxPAisprxr2q0lKIf8oX3OEBqXNl/a1cI7vDW
         cPL5x0pXvjsp6gKVSOlgfjhhQDVSRGXpzDYNQPnYO+jolA4Y2uTz+EVIHdVoYwdaAFd/
         AfZ/9v4G+5m47bQvHkcASdP7B3BNl5b5GX+tEs2+8ccA9/199fAugYAGSKBLGBLlfhHo
         5XoS5Gxqe21IkHk3UqxChCwy7NjeY7fX09IyR9nu06fzX5UQ1Dtz1Srim6rDhPOPQ/dQ
         nyB+d2XoxAMzQkDQdGVYn4wFUZ2cOSdDdGXwekhZoc9USx011fagMJYek3zPA5EyRgad
         D3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5S+boZPxZe9aIuGKULqdZDqc05UAmbuh62BruURpn5w=;
        b=jXeslrfNJH7Visns81oC79zTjSyxk9jbTJqozf1jFvmLOxymqnMOETi5z/ZZNT6Bpo
         kprBPNW9FUdJ9GE01A8Hv4sSKASt/Tz+MM4zasSYazvPJ416XXIbheIrGK9r85e3r457
         7obBGbSxIMJ0dYXFJwUf8e0zbLJnrHeYGqDoAL3mIwgxQXB1gTAAepB4NCZYl2dtEc6W
         hTmfB5x9giWscvwLsnFRiKji8LNPZah/F85tOuhYNCbyjweBfmqjnEtUsRuGosjrAL6m
         NmAdYVVuvP+kj7WESwtBIPbihEArEurv07c7QI37CtkF7T0pjybwy6Gf0uuiApZbSNM2
         tovg==
X-Gm-Message-State: AOAM533vx2tbkuTXJQKmeAfmgy5zsWZKfyNtgEf/u2PxruzFMgTOOCdl
        X3q21TNqxBEx6Xj540KwZVKncpUFmV4=
X-Google-Smtp-Source: ABdhPJwM8H4S7TmBaFLrz7nFhyU3UHbZfe48A7uKXAxRuM29WM1pAp7+4NmnuUaIpAN7w0VYP+kv6A==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr670868wmc.168.1615929450555;
        Tue, 16 Mar 2021 14:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm27202279wrw.63.2021.03.16.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:30 -0700 (PDT)
Message-Id: <fb4c7038b7468c77c4d3c5181f0cb0de85d1149f.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:08 +0000
Subject: [PATCH 20/27] merge-ort: ensure full index
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
expanded to a full one to avoid unexpected behavior.

This is a top candidate for updating later with a proper integration
with the sparse index, since we will likely enable the ORT strategy by
default when the sparse index is enabled. This appears to be the only
place where the ORT strategy interacts with the index in such a global
way, so that integration should be clear once the ORT strategy and the
sparse index topics stabilize.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/merge-ort.c b/merge-ort.c
index 603d30c52170..9f737212555d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3112,6 +3112,7 @@ static int record_conflicted_index_entries(struct merge_options *opt,
 	if (strmap_empty(conflicted))
 		return 0;
 
+	ensure_full_index(index);
 	original_cache_nr = index->cache_nr;
 
 	/* Put every entry from paths into plist, then sort */
-- 
gitgitgadget

