Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D78C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CC0611CE
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFWRvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWRvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4EAC061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m3so2192704wms.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgNk/YUBlFXDe6iAi0JySM1VYe25zSxChufa3lpMG6g=;
        b=PsRZBYMbkQe9J+onihDw8MzU7s2YA9HDybYk2MnOGxmHwp21Tynr4Ql2sQNT76wfQX
         9YI12WvzgGm2cRrVqOUs8sHFlf4uQAaw4YTUjqEyAWqDIMRPt3qPxt0xn16L3Rnrog+Y
         tmVf7ofk1bYRLzqonrDXJvAc3LFVl1PdniR5Z5gLCVC86jbVBNuuv6LWSxvifyeQ6SG2
         M4YZuojC8USEWcSR5PJXdzjl+8DSp3uxBypoCmoua+S+818GtvCAKAW6Ht1qu0wtmksB
         yfA/nZGyVZptEf1Mesz7XQ3mVhKZSqF9Jv7ubnNgzuwLfpehaDd4xmmACq0xovhmLv5F
         PI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgNk/YUBlFXDe6iAi0JySM1VYe25zSxChufa3lpMG6g=;
        b=duW2ubrwIsFwC11DWVvmzWm3cMPpcQIxqENYlKve+YaElwE9oWsQ1eO4HgpaXPF1KU
         wQ/JnAKWHv5xt5BwCnX4+f8nuoPGEpenrt891fZrlaS8q/CsW4+3W9cQ3xP2DIaNvBav
         9M/L3vH+iJQ8xywi1dhv7C8+yQOzwcNFh6rRp/mwUTW+AM4iV0W9dscD+qdOcN+5GkIC
         AZWTuWz14RXd0Rgeztu/n26dvNNFRwy41weiqMWCbDbTcAQwHYCvID3okGUbj/t/tRkC
         i2WL4o1BU6ELyHg5xO9br0bA5Ep7H2xq2ndSzAlgikp6SlJWhZjSkf0lhVCyrmm643zz
         FVsw==
X-Gm-Message-State: AOAM532POzt7YTd3ila3myGXpBEPHWSAjFjG48Nmcnqj1gjuQo6Up4wN
        lkKTD5MlsLpji5zYmTjwXj3J75D3wt8Tsw==
X-Google-Smtp-Source: ABdhPJzGcOYlxS+TJbuIvzSEZApkcHnBuiz/ZzaSu8+KwcilYDRW3tNIBOto/Ck9mZNOxwgfimHEmQ==
X-Received: by 2002:a1c:b306:: with SMTP id c6mr12177182wmf.37.1624470523712;
        Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/25] midx: don't provide a total for QSORT() progress
Date:   Wed, 23 Jun 2021 19:48:20 +0200
Message-Id: <patch-20.25-80a991d019a-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The quicksort algorithm can be anywhere between O(n) and O(n^2), so
providing a "num objects" as a total means that in some cases we're
going to go past 100%.

This fixes a logic error in 5ae18df9d8e (midx: during verify group
objects by packfile to speed verification, 2019-03-21), which in turn
seems to have been diligently copied from my own logic error in the
commit-graph.c code, see 890226ccb57 (commit-graph write: add
itermediate progress, 2019-01-19).

That commit-graph code of mine was removed in
1cbdbf3bef7 (commit-graph: drop count_distinct_commits() function,
2020-12-07), so we don't need to fix that too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 midx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index d80e68998b8..9f1b4018c1c 100644
--- a/midx.c
+++ b/midx.c
@@ -1265,8 +1265,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Sorting objects by packfile"),
-					  m->num_objects);
+		progress = start_progress(_("Sorting objects by packfile"), 0);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
-- 
2.32.0.599.g3967b4fa4ac

