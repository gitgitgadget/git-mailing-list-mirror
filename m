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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED311C11F68
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D819C613B9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhGNNPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbhGNNPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B0C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so3872503wmb.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ety81XM5lUpz7BNNk0XX/4/Cau8dRM1r2U9XdOAMldo=;
        b=K3qHvab85FD0Aik7ha3TGD+tkEfvHEFISeLY8WSVdsU3GWpNROfmtD94koys7QxWRE
         Ub88ail4iqxtvNDRQ7MTa533KyeXF8DAj9ri3UR5ciZId9O6sirSLUv4AkBf54wj8A7s
         qBcyB6cxPc6F38FEhQsDN++0VmO0WNaRms46uqCSYttoM6nvPa/kU2Xq7fPkJyE6uwPb
         y/9/SXjL5rJCEgk9ugYZDf+AANep2tQV3EIxmHiNO5LIhOpvykIWmzijvRjkPfj0EWRl
         rEYFpnnTmyIwx7P4YHIXcnlynk8L95Va6xruWuRW0Ggjz4q0eCPFXGrYIunhwe5wYQ/i
         IP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ety81XM5lUpz7BNNk0XX/4/Cau8dRM1r2U9XdOAMldo=;
        b=MMgKknvx8XyBwkp+AhTqnSdAwJLbXa7kTG4LLRPRqAl2YIdZyOM0cJv6//27H/E/I2
         30rBa0B6MqpbUo83rCIqLXEQPkoV59RBsANszcBm/ZdjTdAb6ecIYAMooKQR/+LT4tg2
         XdDCy67nmEYqitQl3BInJj75S7zE+7/cCJfVRHsV4n/wfVCHlZqm+6aleA/iPyOuHlhb
         p7kN0ZCmAzJKXQEsLnIkgP8sjt61gf2/xJW6wfFFpqHwFAd6MxpXi2lbmcR4nE3XZj0d
         jMJLZM0o/1JXwyPg+teDEUCO2eRVuN7TrwlEynntKxOv6D0zI9H83/jkH9JNn1W5B9T7
         MGIA==
X-Gm-Message-State: AOAM531Ruh7rGWV3tqK9K9lwAgevKypICn4lIzTnbgwvjWPVANjQRBwH
        gOqC0pHnnzjqWCTTa9pblnLesnoI37E=
X-Google-Smtp-Source: ABdhPJwe2/KSLVqYT7wbXXZhDmgxnpvbDvQ4dLW4QYfKT1kLKC8SFg400ojv3rkchNlP3dcpjrakAQ==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr10945948wmj.122.1626268371664;
        Wed, 14 Jul 2021 06:12:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm5013440wmg.16.2021.07.14.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:51 -0700 (PDT)
Message-Id: <b051c0847a53eed206493a296ef5c24718c7eb51.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:34 +0000
Subject: [PATCH v9 10/16] dir.c: accept a directory as part of cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index ebe5ec046e0..0c5264b3b20 100644
--- a/dir.c
+++ b/dir.c
@@ -1376,7 +1376,7 @@ enum pattern_match_result path_matches_pattern_list(
 	struct path_pattern *pattern;
 	struct strbuf parent_pathname = STRBUF_INIT;
 	int result = NOT_MATCHED;
-	const char *slash_pos;
+	size_t slash_pos;
 
 	if (!pl->use_cone_patterns) {
 		pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
@@ -1397,21 +1397,35 @@ enum pattern_match_result path_matches_pattern_list(
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
+	    parent_pathname.buf[parent_pathname.len - 1] == '/') {
+		slash_pos = parent_pathname.len - 1;
+		strbuf_add(&parent_pathname, "-", 1);
+	} else {
+		const char *slash_ptr = strrchr(parent_pathname.buf, '/');
+		slash_pos = slash_ptr ? slash_ptr - parent_pathname.buf : 0;
+	}
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
 		goto done;
 	}
 
-	slash_pos = strrchr(parent_pathname.buf, '/');
-
-	if (slash_pos == parent_pathname.buf) {
+	if (!slash_pos) {
 		/* include every file in root */
 		result = MATCHED;
 		goto done;
 	}
 
-	strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
+	strbuf_setlen(&parent_pathname, slash_pos);
 
 	if (hashmap_contains_path(&pl->parent_hashmap, &parent_pathname)) {
 		result = MATCHED;
-- 
gitgitgadget

