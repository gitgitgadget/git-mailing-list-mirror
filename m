Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD53C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C095664F26
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBYSU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhBYSU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:20:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B31C061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e10so5970008wro.12
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bqek08PeoblomyV0u2tR+LpmZMlVSMEJNauYyD9ZC4A=;
        b=mEMFEmzqGTWOCX7fC4HfIqSsq/yNgOyHKKYmFXg/WWXLqiBZF/qinBwRpBGDmnSlf7
         nHJ6cQmBo6ixUV+coJz+z+wrxIW9jamYQOikt3So8IlCnF+NQU8FNxtcp241XVvqjiv4
         6FC5I6k/QtnXe9hSfWbL+gNBmKN8An3WVbBsMX1okl/ppt3xFKqvLgSnB93eOFKeSbg6
         vigaFedHa6PrYhTD/oRTGJiQs+5dX9DswuXt0r/qtHriGlWIh0ErRE6tDKlKLFE9P26u
         mlU8tCqP/i9v64c5sMwL+Qwl7NLW2lyJXXDrata72a8WxMTWlBE2bEQRJ0ouVEQzPjB0
         bNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bqek08PeoblomyV0u2tR+LpmZMlVSMEJNauYyD9ZC4A=;
        b=NiE7sBV3zLVg8iSa6mugq1olY+19B1FH1ProW2dSRUep6tYMRJ0gGqhP546gO9X8/q
         LB48EyYFIbVd/cNDbNR5rYKOzzHL6qL4DPMDe9RrNDYquWmzqsw0dybnk7lzTJ3RGySP
         NMmrrWOiKRvNdBwNjzRuong6yxxFaFrN76y+K+RbYKnnPLfdnihY8yXztm9vaYzvWVUV
         NYV42Q+ndSzYEZ4qftadiVhux1ZqyEHeQiUW/nwU8gGLcWsLxTIZpUGc8fOTFUBvFCvd
         KshRvoWAqie/Tg5eEw9jLHUPGbOt7/PoRXmU7RXvHRL1p2EUvlwMTOnbFXc4Nq6qWD/u
         +llw==
X-Gm-Message-State: AOAM530QGOeUwGYj1E8mTQ1e5+2hUQRnlL40/znCUqo7cjfsy3nF4D2q
        xuwW+4jo9bra8gqzv7h3Inoh7DsIjfY=
X-Google-Smtp-Source: ABdhPJxDISobZohY7zs+Uh5tDMtkMtNlpVT/B6Inw8Dnj/GE95gQzz0fcQznhfKrJoylyab3tFuV5A==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr4675017wrw.219.1614277184414;
        Thu, 25 Feb 2021 10:19:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9sm7734855wmq.26.2021.02.25.10.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:19:43 -0800 (PST)
Message-Id: <pull.886.git.1614277183.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 18:19:41 +0000
Subject: [PATCH 0/2] Specify generation number version by config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/chunked-file-api.

Generation number v2 (corrected commit dates) was introduced by
ak/corrected-commit-date. The new data could be opted-out only using the
GIT_TEST_COMMIT_GRAPH_NO_GDAT environment variable.

As this feature gets deployed more widely, servers in particular might want
more control over when this format is used. Add a config option instead.

Thanks, -Stolee

Derrick Stolee (2):
  commit-graph: create local repository pointer
  commit-graph: use config to specify generation type

 Documentation/config/commitgraph.txt |  6 ++++++
 commit-graph.c                       | 31 ++++++++++++++++++----------
 commit-graph.h                       |  1 -
 t/README                             |  3 ---
 t/t5318-commit-graph.sh              |  2 +-
 t/t5324-split-commit-graph.sh        |  4 ++--
 t/t6600-test-reach.sh                |  2 +-
 7 files changed, 30 insertions(+), 19 deletions(-)


base-commit: c4ff24bbb354377a6a7937744fbbef2898243fc7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-886%2Fderrickstolee%2Fcommit-graph-generation-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-886/derrickstolee/commit-graph-generation-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/886
-- 
gitgitgadget
