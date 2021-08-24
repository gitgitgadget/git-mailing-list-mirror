Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B3EC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C147611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhHXVwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhHXVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE9C0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so33361004wrn.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=odmU7NgB1ACRlSceIxyK1EcqD7Mo50/XC06Fcs7zjso=;
        b=XyaSo/QgO4RrX2yFb0GXQj1Y1qA+xdXUpBlvgL9FCxQaPCTW4UirJW1F3qumPgzmPj
         NZQ1BjhwWnkuaA5NrWKZ5nztmUX6c+0XQX4Qpxj+ohXRn2QD27XqqUIX6rjW6u8hxNd2
         p5dpPPj5+2vSEy+icYsMnecu3/cnZ0zvpaiQod9OYoFA1qyVfiXa1jTbRcdpyrB7j0Jc
         tyTjJtVlzLHBhVKszHoTrnICFrKOZwl0xOUUAcVHIJD6i7MntXibEY+9c553f1DBoHQD
         7+x2nTy1FH/LrfCGbwHmJ4PTGqK1N9orw7nxdL0g2QWBxnjqao+TUMCfO+T8nBUxV5fG
         3xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=odmU7NgB1ACRlSceIxyK1EcqD7Mo50/XC06Fcs7zjso=;
        b=HfAhWhF3m3zYzOYE+3+T2ocgk+XM7FTu3/60a1ub8l14ujHLf/ir8nKFW3Ck8P5iYW
         aMXEglIi7FF+hMKQUQNiX7VG88dfWpUhG7zGENP3h9POAFwZIk+3Ic7Ukq9Qxa4ngKV+
         nuM0fepzBJ4UgteBwDclZ4KzC331+OAxnpr5XYvOnIZkiBSXaOpbyP/alQYWe9Ilnkhv
         o93Ays/tJMCX7GJu0pSBmgMx7L5S444Hh0co59U/Tv1l4NmSNegj2LAwkZRYhSztc1tn
         x9Zg2N7bRPqAMrTt2GGkYvBnI7/lcIKu+j4HpTAR/1SaPzKPisjKDr1/B5E5tWOLnVil
         msRA==
X-Gm-Message-State: AOAM531iMPVkFdeVS0FYvLwfXCor7UVge++NPl3tAvM2/iR3jTvL9OsF
        o4X1mS1g2DTuNSYWDNDPybOHq5f7+5w=
X-Google-Smtp-Source: ABdhPJzZlr7Wpo8IG8zatmDqDMfRTGCzfdB3GIBk1c/GesBuwG1zz3LfjuaaFeKpSDyOJbdv5F4oxw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr20266066wrw.415.1629841908897;
        Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm3480421wmi.22.2021.08.24.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
Message-Id: <acdded0f762800392515c83aec2b276c62ad691c.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:39 +0000
Subject: [PATCH v4 05/10] unpack-trees: fix nested sparse-dir search
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
 unpack-trees.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f315..47ef0cf4c53 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1255,7 +1255,8 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
-	struct cache_entry *ce;
+	const char *path;
+	struct cache_entry *ce = NULL;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
 
@@ -1283,7 +1284,9 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	while (pos >= 0) {
 		ce = o->src_index->cache[pos];
 
-		if (strncmp(ce->name, p->path, p->pathlen))
+		if (!skip_prefix(ce->name, info->traverse_path, &path) ||
+		    strncmp(path, p->path, p->pathlen) ||
+		    path[p->pathlen] != '/')
 			return NULL;
 
 		if (S_ISSPARSEDIR(ce->ce_mode) &&
-- 
gitgitgadget

