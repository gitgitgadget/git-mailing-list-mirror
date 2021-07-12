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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BA6C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E8461154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhGLR7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhGLR6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA07C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n4so1559102wms.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KMWoXCHAUCRcXSFT+haQKKmCiVf5GcUjw8ICiM/EavY=;
        b=TZYml90NEwXHceI1TvtaChZBI+QMhnlXTyHeSVDRPWGwzkMK6nu0HAUfaG2j8bggy4
         XledFukIJH99JL/qyLjcbBqIuNm5OFZ63tMMO/pSj3tw86kIAyrpEyhXSlpkUUzl74zJ
         fB0xrGApTnqp3QyjbEe+i7hjHggNBX8awf6rpXv60L0uUGG8uwlcjjbSx4oNKFF/b6Ou
         kvGwRQ9v31g9MohkZE0lh+PBiYthIbWXGJFJ7upfGO/DwDgSkGpT/+QSLycLe2n07g9f
         fQ9C3x2jsASJNWzHpjzY62mC7VGrJ/xyoZK6rZP4UQO2YBeKwTAr6I/skVsH2W3UY8SZ
         qvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KMWoXCHAUCRcXSFT+haQKKmCiVf5GcUjw8ICiM/EavY=;
        b=OKCJKiwRcf23/EBI4IjeNPaNcAueubtZVk5Z1fcdqK1yar34fOr23/T+p2l1HvLW7m
         KTSbz4igIe7jNum0tqIrensC4bci1KRhJb1y2ix3D3iZjqbakc82z4CBPDXphcFjFLLq
         Hju4XRtqfs3UkEyVCmQEOtM/xFT5Jtfx+K6IR/7nwfYUQceCjF9oWVJGwVTu/XGsCWz2
         yR7+nsgKphXzagBd+0Z63ZextZsr5sZk/iPKRinOoZiec3UktwaJNu9ORU1yhvbRloX7
         XA+DWqTZNvcD2hjul+cd9Eu/eKJf3daS9jfkNAngZscQ4bOk4V/QmjXVVnXqToSoxI2a
         KNnA==
X-Gm-Message-State: AOAM530bo+Km5FAIXX1XKOfNTDuRNA/4jy9Nalxtc6l9b4Mpg7b0Uc12
        iZf2HDT3ngxQYc33i5FHWisDpXDySZQ=
X-Google-Smtp-Source: ABdhPJziIa43uS8/wKNdYgAvCZuSU96YhApB0v8Lhvir/KHuiu/Qfk3DpTbS9UpEgWcKu/64Vm+IvQ==
X-Received: by 2002:a1c:59c9:: with SMTP id n192mr426244wmb.81.1626112564513;
        Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3sm133112wmi.14.2021.07.12.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
Message-Id: <76c7528f78f0be2ed0a9fc0428f715b36fd451ba.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:51 +0000
Subject: [PATCH v8 10/15] dir.c: accept a directory as part of cone-mode
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

