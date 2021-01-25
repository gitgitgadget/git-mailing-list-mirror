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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3369C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F722B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbhAYSBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbhAYRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8DC061220
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so13816140wrt.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lvFlNEHR515oVqS/y4SFBq68nw4FbVcN5LYMHfggzqs=;
        b=t/rHO+a9ovwtnIShrTMBZHXKTTI7sDL0zlAXXPqf79+dMCjOk4Jg8zmdclf24lwaJJ
         LU8pNmUbyMBrLQmNmHXMKuSVE3rGCx9de7TRW0VJxxZOlRRfuDfx8OreT+qrjGdzh+9g
         LSy4wksjw2u0drp6znF3VlO/golJoukP47Sdvmvg2eTth9bdWZTH7Rb/hsomNpfzXFGJ
         83Kd0mINsYnJbf3JqZq3EuzB4QunQSw+cIvaExC2X6pGljJ8E/oy3jyEO7yhxIyvQAF4
         pLvJhGWrW84j9Eidan++s1vEP9Qp7HrmcAN+lmL0BRNRfp6F0jvFSy83OCTE+2KgV2C5
         hbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lvFlNEHR515oVqS/y4SFBq68nw4FbVcN5LYMHfggzqs=;
        b=Jk8AcjcoIK498FfEdXGMj8Me+uaNrfTGzdyJqftouoBA+e72GOtRtj56p1i+AH0tyS
         9vDfEuL7SQ/BmCmeLmZF5Q6yJXRgwVnM+LBdJog74Ab9Z21kL8+IUS+5f1lVG1JLjQcT
         Kv5v3zyUkDgKPhMDb9L/sPcBtb2wS2QXIz5uNfewnduH+Q+YYOuyt3aoZ+qKC1n5CeBZ
         gQUiyx/OpTzSohVGyUI5kMXCRhWT0evphSogLwbQHyPstKdTs8Ztt26PUnfAMQakEVkE
         enqEkNZOhp96nJWS2EVIu6iY+F4qEZpovjz6XiKBPzLKGmCTFLACpK/SqovQ4OkcjKM+
         yo7Q==
X-Gm-Message-State: AOAM533FA7//f/P0UHVSPIfvHBn2jnGmrlpLj5d1QrX2HSX9KxknpKlr
        jC+gCc1tlQdIkzbJ57Sj56orvB1uEuQ=
X-Google-Smtp-Source: ABdhPJxgAoD3CxxL7e2J+hipf+V6ATOigUwUZ5tv8v4RS5MCqhvJYBMShSR1M6V8kW1SVXUGr/Aa8g==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr2200392wrr.69.1611596550777;
        Mon, 25 Jan 2021 09:42:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm14203wmc.31.2021.01.25.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:30 -0800 (PST)
Message-Id: <036653cac368c6c04b439f5352d70a5dcc3c5feb.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:03 +0000
Subject: [PATCH 17/27] dir.c: accept a directory as part of cone-mode patterns
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

When we have sparse directory entries in the index, we want to compare
that directory against sparse-checkout patterns. Those pattern matching
algorithms are built expecting a file path, not a directory path. This
is especially important in the "cone mode" patterns which will match
files that exist within the "parent directories" as well as the
recursive directory matches.

If path_matches_pattern_list() is given a directory, we can add a bogus
filename ("-") to the directory and get the same results as before,
assuming we are in cone mode. Since sparse index requires cone mode
patterns, this is an acceptable assumption.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dir.c b/dir.c
index ad6eb033cb1..c786fa98d0e 100644
--- a/dir.c
+++ b/dir.c
@@ -1384,6 +1384,11 @@ enum pattern_match_result path_matches_pattern_list(
 	strbuf_addch(&parent_pathname, '/');
 	strbuf_add(&parent_pathname, pathname, pathlen);
 
+	/* Directory requests should be added as if they are a file */
+	if (parent_pathname.len > 1 &&
+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
+		strbuf_add(&parent_pathname, "-", 1);
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
-- 
gitgitgadget

