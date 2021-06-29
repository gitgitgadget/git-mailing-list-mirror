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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD9C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF8261CE5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhF2CHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhF2CH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B0C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1272057wmj.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KMWoXCHAUCRcXSFT+haQKKmCiVf5GcUjw8ICiM/EavY=;
        b=W7SlDsAaZN7oQdvmor3CC//lBxVCskBbllRLRgcTkILy7n89LmfOZaOspno5LyILG/
         gEcfk6EmyUO8QMfuZJkHPQ3OKDTbmfgneUVInryEcSnmFoawHVSUMq0K9+8pQmJhx43X
         bVoG4hlMognojAe3SJIwPkSv2knLUwV3elS+JWWKFCNDA5c2oIdMrRb8boQfj45o4yY8
         UMzNsZ9aOTbubWv/6/jVAT1DfSRu9tHJCtseIv3e1vdkjjo9IXsnQxNXvufdzY1K1kWF
         H1KXu/l9Yz+9b/i3p3TJhlhNEdHgafNfzX6ZruEKYbmqz09xXztKQ9LyLrfveUigIhUU
         9qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KMWoXCHAUCRcXSFT+haQKKmCiVf5GcUjw8ICiM/EavY=;
        b=fJNGFOZoMPXoDn5NJHVuJnBiGWnEJpAiFWBN4B24r5Byxc5cifn84cqwyVXvRZTl6t
         DcQwTaDM3TswfkxZbn7YsPx+/lThSdUPlVgRaWOGjrs21G75rJj1w/0Z6uD04/9Hjv0S
         mHI7oY9l0kPKdy252mP26XOCDT23L8nL64yXlkABENXXFEL6CcZzkBv4/eeN1kkt7yFX
         VWoM+/HefCcHZ1GVdxUndjOmX+QgZrW/BG0fW+6uaAfnXz+l6yBHsgz/4klhrjVZFWNV
         Pi9ni5TVekIBrs8x3upc6v2AoKYlK5pE4k28mKav9S+m7GX2XUO2z5MuVDluHJ+Ywvhd
         AeiQ==
X-Gm-Message-State: AOAM533yDmS/sOYm+nyI5aD2MOweaLfimedRXqeMwgj0FHIDsLhX/YNj
        P/p2SI8QbHgjGH0NIzTzhQS+8OvCAHc=
X-Google-Smtp-Source: ABdhPJzSAaNxvP4xNqS+hBieChMydH0puV7pjdL9HPRQie0UhFYg/d8Me8qp+Jv42KVXQ4wh3b1UcQ==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr5778541wmg.117.1624932301476;
        Mon, 28 Jun 2021 19:05:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h21sm7552133wmq.38.2021.06.28.19.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:05:01 -0700 (PDT)
Message-Id: <2a43287c47ed361fcae962d508a8a9354c654fcb.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:48 +0000
Subject: [PATCH v7 11/16] dir.c: accept a directory as part of cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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

