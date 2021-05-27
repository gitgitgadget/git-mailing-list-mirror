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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0FC4708B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA914613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhE0IjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbhE0IjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:39:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D63C061761
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so4670501wmc.0
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AAhC2SD+HHcObf7qc+SmjKN88DhPbGlfJOHemGfoooI=;
        b=JydjFhD4+JogLSDgkVpvtYIOddKiYI/iFeZe2SejGQwvi1/psv6fACDYHQQtLfdORV
         RQR3IvP+ywuogeU6GRG1BPUEKyQ+50qrfjDXyY1C2NZ6tPzCJgyf5JBl18qgHF2lnCUK
         dVvu0cbG9wEFXYxwCfBfUmZtwoP/gj6l63TFNGA61RlEi5XTdIAf9N7EdVwwV4RxjtHh
         BQpeA9+i3w/W0cFf0FKaJICfx9U9u3DyZW+cx8/UyApdLJn3RsU4bGJ7iIpjOOBhG6AJ
         FqCcO7arcwcFuT3Rw+jWkYBBaH7HQqz7ZXRRg51U0PO8GF5Hy/gIv/etf5hxR0i+TtHD
         24Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AAhC2SD+HHcObf7qc+SmjKN88DhPbGlfJOHemGfoooI=;
        b=gIJvj8Derrwkov86OIDgYrurEEwMx9LOOb0jq2Dqmgrahljb1v8Uq7SrBJd2+bVhmk
         odBXtxQbgabLZQ2ISqcwEPB+VjfWqC/4Bjpw/fK0i3zp3H51ByvG9tNhUY6xOZi/FqcG
         aKkdYetsKyZL28CcJWvFXK6rkLpLRV106GK3b+wzd1ZYPduaIUsiEr8afwwsVjOtU35H
         pEnEVY0x1PuY7mAVoJGzagmU0Gi9tagMYNSAlFSnDNuyHymJHBI2nIcJyyalybwG/kre
         5XMoBoyN220YH2hNZqJOW2W6sWLcgbhH8agCvUhrg81OptlwofJQRkl7EyzLWQag41sL
         S5bw==
X-Gm-Message-State: AOAM532wK/3daYHeYX0tde4rS43yQc3jX9CiaZNPW+KClW1z7dmt2SZO
        6Mzc0fMasjvg0Eg61GzSl2Q4QVAZ/sI=
X-Google-Smtp-Source: ABdhPJyTM5TymO5Z3KTTQYJV6nsU5QiDfMcB3cseGP2+WZ4solIgkf3u1JhzNWXv29iogkzGw+5Tuw==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr2312096wmb.45.1622104646830;
        Thu, 27 May 2021 01:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm8948381wmq.16.2021.05.27.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:26 -0700 (PDT)
Message-Id: <e85dad887f95b6cee8df6a4452cb3b10198368f3.1622104642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:21 +0000
Subject: [PATCH 5/5] merge-ort: miscellaneous touch-ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add some notes in the code about invariants with match_mask when adding
pairs.  Also add a comment that seems to have been left out in my work
of pushing these changes upstream.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 6cb103c8e855..e174a8734a41 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -765,6 +765,7 @@ static void add_pair(struct merge_options *opt,
 	int names_idx = is_add ? side : 0;
 
 	if (is_add) {
+		assert(match_mask == 0 || match_mask == 6);
 		if (strset_contains(&renames->cached_target_names[side],
 				    pathname))
 			return;
@@ -772,6 +773,8 @@ static void add_pair(struct merge_options *opt,
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
+		assert(match_mask == 0 || match_mask == 3 || match_mask == 5);
+
 		/*
 		 * If pathname is found in cached_irrelevant[side] due to
 		 * previous pick but for this commit content is relevant,
@@ -3470,6 +3473,8 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+
+	/* Record metadata for ci->merged in dir_metadata */
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
-- 
gitgitgadget
