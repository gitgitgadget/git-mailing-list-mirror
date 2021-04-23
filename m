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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02714C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D462961468
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbhDWVfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbhDWVfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E10AC06138C
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so34438wmg.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=RZDgNae2n49g/nvAEhmQ+mdun7q/i5/+f5zRA+RZ/VTD6SukZxqf3CF4/fsHKD+/n0
         CAdFHNZ4sxZQ/HhLN0fzdFhF8z84DQql/zdO2cjMf6y/TWjCvuItZEdqUmoji44/XfHn
         UhsAUxmxDj+AEG0W2D8YhAk6lSTL1BzkmofzObGYN8fcF4/xogRQdcauEePhtVaYIuIM
         ZXLCxHqSLTCXsKD2DDWIls6OHatHKSYwC4RFuU83ICQBx17W1M5lE8C9qYYxwrUDQ2Ta
         3xAMxaR6Gecm3k2lYyB5KDu/yuwUqDzknSWKFT9HQHB6jgSKldN9CAho1tTu4EkWnxvI
         KAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=btDKRVdrnS+s2CGzH+faoh1iJNBFOWNO8F4JKAwnWxnhnxm1gGXpEdCPlaOaEO14ER
         KqvF6NTLLc7HaCJ2ycms1nVfE8TqrDluutg2yeescrg03s+gcE8av63qTRVDA7LG4t8c
         IdxlPUlikArk3QtjLbAWfdEHBgClsjQe+IltbSE3MU5ItxvEeVwO1GX3h2oc9W4TZ0ry
         3TrMVweRCmxhhUUA2QmDeGZ44l8gwSWbfXV5ILILgFwpH2hjO/m972Sz1OHAuhaPP8Bh
         Hc42Vtwj2D8aAKFdaZ986sIU47SDy3yS5C55wQyvaMHZwMX39ehgMjNCsLB7kC/LM2AF
         mU2A==
X-Gm-Message-State: AOAM532ySTDDcTIJ24e6MgOdGnxNBH899y5LPjKpaRa8WaNQyl6ScbDG
        6AyWAKyIq1ADzjzPk8n2l6PaxfB+EhU=
X-Google-Smtp-Source: ABdhPJwcR6ILhJ96ySEvXXzVJeE9eEe8IWr/V/s5bFvu88DJdAMCmHxNLPFU7XZaSxwjY54xpwyhsA==
X-Received: by 2002:a05:600c:35cf:: with SMTP id r15mr7490748wmq.183.1619213669887;
        Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm10737015wrt.13.2021.04.23.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Message-Id: <fd96b71968b69a357d2a427b990150bc090e3073.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:22 +0000
Subject: [PATCH v2 5/8] dir.c: accept a directory as part of cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
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

If path_matches_pattern_list() is given a directory, we can add a fake
filename ("-") to the directory and get the same results as before,
assuming we are in cone mode. Since sparse index requires cone mode
patterns, this is an acceptable assumption.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dir.c b/dir.c
index 166238e79f52..ab76ef286495 100644
--- a/dir.c
+++ b/dir.c
@@ -1378,6 +1378,17 @@ enum pattern_match_result path_matches_pattern_list(
 	strbuf_addch(&parent_pathname, '/');
 	strbuf_add(&parent_pathname, pathname, pathlen);
 
+	/*
+	 * Directory entries are matched if and only if a file
+	 * contained immediately within them is matched. For the
+	 * case of a directory entry, modify the path to create
+	 * a fake filename within this directory, allowing us to
+	 * use the file-base matching logic in an equivalent way.
+	 */
+	if (parent_pathname.len > 0 &&
+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
+		strbuf_add(&parent_pathname, "-", 1);
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
-- 
gitgitgadget

