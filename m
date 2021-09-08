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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A7C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDB6113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbhIHBnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbhIHBnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F158C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso307207wms.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JRS95RVbeDzgbDO/0MMlbbEuXlEVV1AwpA9tdsh+v3Y=;
        b=W+fFeFiwA+DSYtTr8G0KQZEPCfxWez4fUsNScuLFpMUNw4d7JWo0tzF/FoLoZb0PJC
         TZV8lO/vZzkcrV5ihcUPdyJwMznzWF9UfHODdKpNvV4E/7y0DHVVhpkD64FTaIQtC7gR
         Hwmt4iLSjFsM6BtDHh6m/BuWZM9bhXtol7DQpCcg8HfB80RT8miRicDA4ciLkQTiJtyt
         F1d9WeWdtffoXM4qZztTABBlHfro6+2zXrek9gmXDyAfNDiT+lv8030dXcW3CRfAM1zH
         EaeHEauf93SMxapC7SEdqOmKO4tcRqrM3F9xEqwcf7oN7b0sLE7qr9mKNzUSbCXoGFlQ
         JjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JRS95RVbeDzgbDO/0MMlbbEuXlEVV1AwpA9tdsh+v3Y=;
        b=XJ2oFRs81BcvtQZk5FIuGDbYVtWVetLiT004i66uM/YNDjpqrTxsNR9+VQgJ9DvVXS
         GDpwKQTw2jVt5Bt/yG962WGE2avXLAN2IRTjK0QvI7b9rLfF8eIvV8jrrfiqOUuUUNQs
         Uc1MspSuNAzb3KvZwp5bfT2VWJWkARyJi3aVm19X7pEOZeh240a5TzQT68+8orx3tM4u
         9eenteDoqUW/bs2jxX6JXirErXIzhsz9ev8LjKQMdsImrqO3ePrkp5gxjEb0ESs0lFy+
         EuW0FqWTxOFC5UPDLzj1yQLjvddi8YBxzDyI8HBcovPZYg6X/auwyEf+wPgxl17MoNn8
         1l/g==
X-Gm-Message-State: AOAM5304L1q3A8ELN/x+NHqKECdR8FF00xwHuP7lWTwt04Wqy4zypvZM
        KiSnJP4cfioexu0JbWgbTdHx82KzaGo=
X-Google-Smtp-Source: ABdhPJxLLelxYZcKNBjHtTdcEc9+3wJ9/lbkdOAq7mBMVIUfOQe4lMalyXQXNsKAK8NGLHlf03ebyg==
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr936710wmk.37.1631065357068;
        Tue, 07 Sep 2021 18:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm597685wrg.14.2021.09.07.18.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:36 -0700 (PDT)
Message-Id: <edb00d3f9aa68f5021c50a72c8be4bc54dd64ea2.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:27 +0000
Subject: [PATCH v5 3/9] unpack-trees: fix nested sparse-dir search
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The iterated search in find_cache_entry() was recently modified to
include a loop that searches backwards for a sparse directory entry that
matches the given traverse_info and name_entry. However, the string
comparison failed to actually concatenate those two strings, so this
failed to find a sparse directory when it was not a top-level directory.

This caused some errors in rare cases where a 'git checkout' spanned a
diff that modified files within the sparse directory entry, but we could
not correctly find the entry.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f315..b78d7ee6c09 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1255,7 +1255,7 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
-	struct cache_entry *ce;
+	const char *path;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
 
@@ -1281,9 +1281,11 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	 * paths (e.g. "subdir-").
 	 */
 	while (pos >= 0) {
-		ce = o->src_index->cache[pos];
+		struct cache_entry *ce = o->src_index->cache[pos];
 
-		if (strncmp(ce->name, p->path, p->pathlen))
+		if (!skip_prefix(ce->name, info->traverse_path, &path) ||
+		    strncmp(path, p->path, p->pathlen) ||
+		    path[p->pathlen] != '/')
 			return NULL;
 
 		if (S_ISSPARSEDIR(ce->ce_mode) &&
-- 
gitgitgadget

