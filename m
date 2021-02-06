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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C466C433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E4664E34
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBFWxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 17:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBFWxB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 17:53:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B40C061756
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 14:52:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b3so12515823wrj.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 14:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Z3xowqJGcAVTcCt9pLILej9TBFmNpMdDHO/l+AiqLI=;
        b=kkwlsMFnSSROu0l4a3ixbPAii/W3SB3R7aSrjXV0K+A1aekMlvrzZNvHwSNNrsSNaf
         Ir4woqZkuiXUsqnpPkd+GWx8m28kRYSbPGhFY6W1vWXF2a2xsPWLP/XlI2+3ba0TP7kH
         PgZMhFdy9VwA2pJ8fiEWSfhl2h1e1RhgX+E/pg8/801T5VZxyjia4sxRlCTVC8KAZtyT
         HABbcmPC+xQ+5FO7NJOogGeJwiVO+R3lJy+NA2hXVgNH15y4JNyppJcZTOrsgpXza0jJ
         0ZjGg+ulF73uYKcvs7KgwJHZWL0daYNcDcSeFN6+zKp2hkdpkqtN4UE+lLovZV0OMolv
         DGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Z3xowqJGcAVTcCt9pLILej9TBFmNpMdDHO/l+AiqLI=;
        b=CzaauW/2OCMl86jHkMe39umPxVHtYjtUUGvr0k7XwZtH1MM3AWntIpxYLH4YJ1J4uI
         Mg1rF3gCfWs8RRS1tPkq8a/K2efRuvMEtXM6CP/mEQHxWL1Huezumkfp5n2oCfgh6Ggk
         MhWSL+56KBNWb7Hss380Ysk6klFn2GiPqFrlORvwnGbD6KVTKKaec/GtKDIgmByhtB02
         3oZ8YwAUGFTeC2XImggChZKNKiB5r2+I17UxI8C5/Yyy1ibk9FO0FcH/2ezrWCqwL7gv
         Ey3p02gswmB1C5AvxCK6a2PZL2nndYP5V2AL3rsSsMnDZJDCWW06k/flFYzDmQaIYYJd
         UPSg==
X-Gm-Message-State: AOAM533uZwE0oJAUCoJAHZxUjepREKS0RYx2pd8ytwxNOIQKuKRnr7W3
        xpGhgkRqsXtRcZu2M1DniZLJy8NF1CM=
X-Google-Smtp-Source: ABdhPJwYudP8xa5+Mpttv5cv4vDtEtZTYrpXlRaDDsYDVFX+MRe+oa3TaaXP9mlSngiFoiQnZjZqFg==
X-Received: by 2002:adf:decf:: with SMTP id i15mr12126047wrn.405.1612651940121;
        Sat, 06 Feb 2021 14:52:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm19090110wrn.29.2021.02.06.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 14:52:19 -0800 (PST)
Message-Id: <377a4a39fa864a09eb1d90e1addcc5d61d6b026c.1612651937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.git.1612651937.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 22:52:15 +0000
Subject: [PATCH 1/3] diffcore-rename: compute basenames of all source and dest
 candidates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to make use of unique basenames to help inform rename detection,
so that more likely pairings can be checked first.  Add a new function,
not yet used, which creates a map of the unique basenames within
rename_src and another within rename_dst, together with the indices
within rename_src/rename_dst where those basenames show up.  Non-unique
basenames still show up in the map, but have an invalid index (-1).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 74930716e70d..1c52077b04e5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,59 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+MAYBE_UNUSED
+static int find_basename_matches(struct diff_options *options,
+				 int minimum_score,
+				 int num_src)
+{
+	int i;
+	struct strintmap sources;
+	struct strintmap dests;
+
+	/* Create maps of basename -> fullname(s) for sources and dests */
+	strintmap_init_with_options(&sources, -1, NULL, 0);
+	strintmap_init_with_options(&dests, -1, NULL, 0);
+	for (i = 0; i < num_src; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		char *base;
+
+		/* exact renames removed in remove_unneeded_paths_from_src() */
+		assert(!rename_src[i].p->one->rename_used);
+
+		base = strrchr(filename, '/');
+		base = (base ? base+1 : filename);
+
+		/* Record index within rename_src (i) if basename is unique */
+		if (strintmap_contains(&sources, base))
+			strintmap_set(&sources, base, -1);
+		else
+			strintmap_set(&sources, base, i);
+	}
+	for (i = 0; i < rename_dst_nr; ++i) {
+		char *filename = rename_dst[i].p->two->path;
+		char *base;
+
+		if (rename_dst[i].is_rename)
+			continue; /* involved in exact match already. */
+
+		base = strrchr(filename, '/');
+		base = (base ? base+1 : filename);
+
+		/* Record index within rename_dst (i) if basename is unique */
+		if (strintmap_contains(&dests, base))
+			strintmap_set(&dests, base, -1);
+		else
+			strintmap_set(&dests, base, i);
+	}
+
+	/* TODO: Make use of basenames source and destination basenames */
+
+	strintmap_clear(&sources);
+	strintmap_clear(&dests);
+
+	return 0;
+}
+
 #define NUM_CANDIDATE_PER_DST 4
 static void record_if_better(struct diff_score m[], struct diff_score *o)
 {
-- 
gitgitgadget

