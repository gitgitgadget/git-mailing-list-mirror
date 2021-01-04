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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA912C4332E
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0A420E65
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbhADDKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbhADDKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE4C061798
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so30744155wrm.11
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1cXbZJPHh6PbIf9iSugyF98nzI72FppH2Gn56ddappw=;
        b=C4xTA0joJFj15cLJ5D+OsYN30FXloWJvLM+tchf3e9U+gXyGZwQ7z5Fx6RKWM/rp3d
         hMXN8SnQtJDzvDxHf+RTnyzTSaUQ4Uz6JHQIdDoNKjSykoCXysqVg/wyMn/vIb4d8/6C
         ox74pxeGrHKjTrciYzzBUDI00VbGks726TKJYYYMeLKIBs4G9w3lWqhlKtWH+l543KeD
         O1jt7zsUC3PLYo69ONiDmujeRe1uYZHaIZ33GVGLKymhKvYacjxBUO/F8TVQORIpuMwi
         jFXVijcvVRJdkBg4KaGziGBBIg0j/fTNxgc9gwrBBL/MKxL88lgp0PGEWBba39y3lSE0
         89OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1cXbZJPHh6PbIf9iSugyF98nzI72FppH2Gn56ddappw=;
        b=qfRs73nix6+LrbszjaQCnW9W96rryZU+IUMIOfD5R31Gg2YiCTHJ58BoQ9pYpJd3My
         yv5sMoWJDFwK4od+3QZCkFiG0CvVqKJbwfsw69HZbCEQkNaFEQ/DJOwsbomxfam9UWMO
         R+uaSsYWFUFOWRpvCiPC4GmhM0dqq5LKPmDTUjy8SM49aPFZ81DqZ/DaBImYXKcxY+tt
         69EQ3B55HxnB/TVDxXqK4k/eVyC2j0runHTs5J4sAGnZrNVfOdOrrvp7dHV4gJ2fznhW
         S3IP4pBRaCmIpDftJwQdw8xuSajcilbcvllEB2+oN0Ymki/0igoESkG+tQ2A7zFsEwwY
         ilbQ==
X-Gm-Message-State: AOAM532UYnA+vqIxcOuttXikfm/OHUuCw144uKMx5vN3/+pyeiydWUvX
        CkDoqcX1Ber2SORMLOXEdTTSjJpDm1o=
X-Google-Smtp-Source: ABdhPJyD0/mUdKddUh+mCnIUT8/NxLJzaKO+pnRuJ6yKtBkyRTJoFtahrdvzJtp1CWlQpgJaEkpgpQ==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr76333508wrl.85.1609729764426;
        Sun, 03 Jan 2021 19:09:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c190sm30716078wme.19.2021.01.03.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:23 -0800 (PST)
Message-Id: <2b2e70bb77c8dafbf2cfedd9e68f834f02deb4a2.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:14 +0000
Subject: [PATCH v2 5/9] cache-tree: trace regions for prime_cache_tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Commands such as "git reset --hard" rebuild the in-memory representation
of the cached tree index extension by parsing tree objects starting at a
known root tree. The performance of this operation can vary widely
depending on the width and depth of the repository's working directory
structure. Measure the time in this operation using trace2 regions in
prime_cache_tree().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 45fb57b17f3..7da59b2aa07 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -744,10 +744,13 @@ void prime_cache_tree(struct repository *r,
 		      struct index_state *istate,
 		      struct tree *tree)
 {
+	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
+
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
+	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
 }
 
 /*
-- 
gitgitgadget

