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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA0C2BA57
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE2C64FC0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhCPVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhCPVRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9C5C0613D7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so8182985wrn.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HEagPIBqKlz8JdRl77MY6+preXIwSsIGVX5BufOQHCs=;
        b=qceenLI3uEht3noV4YcwZVOVD8aLrDf2p3O9YyxCCfB7malb+75H8mua1r9JPCHfmK
         X6mONC2M0VZAW/47JbF9Twkpyj/71kMgapzAdxtRT/uZZc9k7rVtCWkT4DcxNkvQ8Yga
         1yuzdNO9xqJta86f7Xo0IdpKKShIY2pN/+KAbXjpHhJMu99LzofZPwemojfktLf65m3D
         dCBfJPJ/RwjOdTgCIbfHDwhJf0/KYplz2cZ5ZtqwbzSdAGOXTmmlB3NG7yNBsm9Kg/RO
         C2DavS5Zs4XptFpxEYhLBBoiPnS31+zQNWpZBvR/K7etGSNiuAVVScQPs9qjsym0S8tY
         GwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HEagPIBqKlz8JdRl77MY6+preXIwSsIGVX5BufOQHCs=;
        b=TArcsuM1hlUMClmsjSnlO5ADhwqfFsPpRXoL/hQ5StUm8/WbE4f51IY0ALhs94YYym
         9z+QOMYRUv0TA8pU08JjpogDdgmWlXMPbNYaXn23hARXoVYb29laFh5/B8hxC7JZ9/nB
         iIa7O3b7sdZmwjP3nr2kRW3ljZYQC+kr9kVFsqnsfTrjji2uon26DdTPNThLTQOPjUg2
         7/S2paqEKMTCEhA1hfyLDDYVhBpXsxg8VpRRq7BPGZO4FyPOejdmrS3hqoz1Quj4mSwE
         Y4MX/3KPAoFMk6+TcdQc1/X366g7Ep6vE8ZDTlWT/neDhej3FT5C1Bl6WPmUILCeJUNG
         tr6A==
X-Gm-Message-State: AOAM5317xRLqcuD8jKsuI4X4N4ECLa7l883IqcIDeQHVGGLtXNOciUYa
        Xxlk0k9ADqVw5qx8m391VSTevW+N+JQ=
X-Google-Smtp-Source: ABdhPJzhX0gSMqxXFsegQWYOeYWd4KVfc3GwfzXQlxDcrjnd4q88kY1HPiXROaq+Ob0aH8uU6h4DPw==
X-Received: by 2002:adf:9261:: with SMTP id 88mr945611wrj.270.1615929451670;
        Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm602441wme.9.2021.03.16.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Message-Id: <f4c470686b2764a6046c8a8b80f18c882ad8899b.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:10 +0000
Subject: [PATCH 22/27] pathspec: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pathspec.c b/pathspec.c
index b6e333965cb4..08736ab368d9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -36,6 +36,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		ce_path_match(istate, ce, pathspec, seen);
-- 
gitgitgadget

