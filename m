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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D088C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6B64FA5
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhCPVSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhCPVRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD666C061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so141772wmf.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GcgVq9D0WJp2irecxL+BYQvHP4e45tY3nVXbkIeJp6k=;
        b=ASl0Umvt2uGtfIT68aLM1/3Y8SOjBZWm0cpTHlgF9ESq9aHz58dBoTvhK2nz6TfZou
         lrdXrc7qEbtMxb2jCcOphKltpMz2pj6ZqeD2Qgj8sCqwLF41Yebcj9UsllV5agcX6+Dz
         xt6IhSEJVoGm3aZrXl2q+oCfyyjO2JYgGmIJYbeqrfZCwqZGfRBfEIRZHhuEo6yzwXa6
         BqBcbswEjrcU7nPja6AljT7eDvgZbJG7aVxzwbYujKHd1aMhS1KMP0yNOX/R5DvZ/WkN
         329IYCQmutAhO19PIrDkbFrukIBhMKg1nAbB7gSlSj/qSlSIK8M3KKqTuWqXdanr7o+p
         D13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GcgVq9D0WJp2irecxL+BYQvHP4e45tY3nVXbkIeJp6k=;
        b=dxxtNFSHvQeE1Y/qMwqIDESJuUpUTQvyBBxqYYidxtKjW+4DTZb1qDVH5HWo2m7C01
         aGv33ht00UG28ldVVC6jpsMCUC3hj1pZcGhwdHaALck7OeIQlJSk6AMSRB2ANYk6JY/K
         vlOMLw1MB8mz/Zku+2gWpeziwiFnSbw6LWHwmHgvUzB5C893FENRFFI4iR/rL7LnJ7Jo
         306RVEkHqmNGCUGJ3wkuShkKuWhwDqpD2xRCYpHvAxBO6X4YPqalhXd/DNzgLmFTpszY
         eIXb2ZV980lnGYBc/XdRgmpHD01W0n1mXWd4HUbZjybJVVnK/1WIsaVsic4hOuW6r+lp
         iyfA==
X-Gm-Message-State: AOAM531eNuui1wrh/PhX+Lk0eatt8mCLJ66+XhaXtZUbSQOifQ5pF7PA
        4N07qYMAMrq7P34U5zVGei8cJH535n0=
X-Google-Smtp-Source: ABdhPJzXGSTxOEhFpCoPUEqqzd2kQN7zjUsfOJyHfEiRlwwN2MDx9izkwQmh+Bo/ZhgOIb/93cN6UQ==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr663898wmg.7.1615929443686;
        Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm583431wmi.23.2021.03.16.14.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
Message-Id: <83040e7558f3effac91e76352f259a5a7d367ed8.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:57 +0000
Subject: [PATCH 09/27] difftool: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index has
been expanded to a full one to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/difftool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6e18e623fddf..1d62f77efa61 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -584,6 +584,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
 	rc = run_command_v_opt(helper_argv, flags);
 
+	ensure_full_index(&wtindex);
+
 	/*
 	 * If the diff includes working copy files and those
 	 * files were modified during the diff, then the changes
-- 
gitgitgadget

