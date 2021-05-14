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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DBC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DAF61440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhENScv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhENSci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72AC061760
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so218752wmf.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=pSB21RPeDgNv9QiLYrSqwohqTkokd+n7t+kdchckQBtqYMLNUtlf0ABeaY4pXAO+qN
         wzChLu+mSOlFrdcoY6JYqG1m327M8KPcixEg91cYZ7niujCIVSwhp9UM4UOEaHylH9KC
         2pPV6/eAn5H001CwtY1aEZSq6a6K2G+aMaSFRJfhWhYgW+r7YrxpyO8zMLRtYmr9aP1e
         v9Fv00QvDTnLVItNyBzngNVvDLN7VvGkOynh7FB8U6Czzbqab0FY/UWE4jok7cpeVchN
         usoIE0AYs3JrMrA9u69q3cUTjZAVOboIZCajzglFMa2WPIit2sjVME3UCr7rJ+KDYzYo
         aMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=DD8KwHi/ovtYbWbXoCzaHcLyYzdix9lYGxDq0Qy89IvblHs+vGd6eDczz3UoIwaKWt
         ld3oMBTYWA+TQJ8GVw/g4gxupujp5V1ZB9/ksE0rQeWr7gvJ8HhoGgf9D3cpGGIxAXNQ
         ifsNczaoVZLjPWU8A1XcKkV9+z3B9ENk8QTcYeOg2wHBD67hrX8i6tMsjFX8Y0FM+2sC
         mjniQ5w0QdXBlVXM9haTurt/+ObCPnz4uWseJIIj3pLREciWpbFloUvs0qiyTnsHQbv8
         vSPRrlK0oMSDGZ10Zxotl1KcxQAFXw7AwLDART8+QTnQxWoi9cvvdSEEoXxnIMRwsM8z
         Q3Og==
X-Gm-Message-State: AOAM533iut/LWJuTPCHZrT99a9DQOVh94URG4HtfsHrgd/8CTJRzT0Jq
        4AGcSIWyn+Zf0pjfjp8LedTLsw8G9ZY=
X-Google-Smtp-Source: ABdhPJzpcvAFORdLbmQSvbRGNEAYgu5u32zQVIldfBvjYaV2DKlD122j1HhpHF1Qal02q+3Nt7tY3A==
X-Received: by 2002:a1c:7711:: with SMTP id t17mr51809198wmi.6.1621017080758;
        Fri, 14 May 2021 11:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm7532729wrx.15.2021.05.14.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:20 -0700 (PDT)
Message-Id: <47da2b317237c4ce8c95ce847e1c65c2d82fcfb7.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:07 +0000
Subject: [PATCH v3 08/12] dir.c: accept a directory as part of cone-mode
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

