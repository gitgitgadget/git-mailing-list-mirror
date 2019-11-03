Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386681F454
	for <e@80x24.org>; Sun,  3 Nov 2019 00:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKCAWB (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 20:22:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKCAWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 20:22:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id x4so1851111wmi.3
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jUe3ofIhsxlK/fq3XA5Oj8OTe8XeR2oLshAXoILfUeU=;
        b=tKzdyeN/JQ6zOKfKYChqsDcHN6LStV7LZt9hAl68/P/vDyn9nTIwW2FWSx+HzU0X9B
         hUrDfLwq/wxdL/TgbxBWQ1VxmAjMBHL0QKDVJKIAvnfN/60YKDdbIbS09uwWSk7JXKYQ
         tfnz5X8xgIT3ZnyYZ4oDPgnN3DmKriigD5F9jYMLHEMZZ0FHm+yaPzRb6jR5uipmMAzY
         gPvCnM5KToqdujoQEJ9QwB91hXTHYtpInyuIz3KNAGc+FbEXN76sPjcXiFCIHAqhLgZB
         uEBweHlJfIbN+PDGEwDApk3a6dM25zfCG9/FZhJWcciyOX9/y6CMLKM/zJH/muDG5+Hq
         a68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jUe3ofIhsxlK/fq3XA5Oj8OTe8XeR2oLshAXoILfUeU=;
        b=pP4UZvdT30gwpIDQ4yD4tGvwcLRM1Hw5IZ37xqckhj9NZ47wm6f+ObfO3K6Yg9z9ph
         nztiA0/Hrzjj+jkT6kK2zifYWlkGa7GMN9BDosnlyKzzSKfpLhFRg2qIiSDOGNw+ik8+
         xt2Oehx7SSd4ohkKQc8qDfZnPD4TzpxdlxQj/L3U8eKXMaKvPFX683KJ4iXv0I9txfg0
         usXzjMTWDQUJbCXuXb8oacb43VUPuvthKUk7EMDY0d1+BMPDZcWOqLQpboFfb6nVyXga
         9Xp8N3MxEs8enSAZWnBh9outTU1MpebC2p4LYBDbLDFwKVUOiipWtfnIkMRzh+r1+Mr9
         zCyA==
X-Gm-Message-State: APjAAAUxR4+Q4xtDLZSykdckj94Pa7kCeKpnRNrdJTxNaLmEgHIckby7
        JHDS4w+OR1qoAR7s9aW08o0R65Xa
X-Google-Smtp-Source: APXvYqxKcph/XosjVhKYLhuvq+nuiOcXAAX8ansUBs7a2UXJyOhNIsOl83AWq6IFKajzLr+ZPV3dAg==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr9752234wmi.64.1572740519214;
        Sat, 02 Nov 2019 17:21:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm191663wmd.26.2019.11.02.17.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 17:21:58 -0700 (PDT)
Message-Id: <pull.443.git.1572740518.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 00:21:55 +0000
Subject: [PATCH 0/2] Fix locking issues with git fetch --multiple --jobs=<n> and 
 fetch.writeCommitGraph
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git fetch command recently learned to extend the --jobs=<n> option to
cover the --multiple mode: it will run multiple fetches in parallel.

Together with the recent support to write commit-graphs automatically after
each fetch by setting fetch.writeCommitGraph, this led to frequent issues
where the commit-graph-chain.lock file could not be created because a
parallel job had already created it.

This pair of patches first introduces the command-line option 
--write-commit-graph (together with the --no-* variant) and then uses it to
avoid writing the commit-graph until all fetch jobs are complete.

I don't think that we will want to rush this into Git v2.24.0 because that
release is imminent, and this is quite a corner case that I am fixing here.
It's more of a FYI that I send this before v2.24.0 is available.

Johannes Schindelin (2):
  fetch: add the command-line option `--write-commit-graph`
  fetch: avoid locking issues between fetch.jobs/fetch.writeCommitGraph

 Documentation/fetch-options.txt |  4 ++++
 builtin/fetch.c                 | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: efd54442381a2792186abc994060b8f7dd8b834b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-443%2Fdscho%2Ffetch.writeCommitGraph-and-fetch-jobs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-443/dscho/fetch.writeCommitGraph-and-fetch-jobs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/443
-- 
gitgitgadget
