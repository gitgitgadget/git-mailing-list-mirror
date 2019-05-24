Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAEC1F462
	for <e@80x24.org>; Fri, 24 May 2019 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391482AbfEXMXt (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:23:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34494 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfEXMXs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:23:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so14173829eda.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=e3fUcmI2wRxCsr1hmzNrwhMoEyiPjpeyRJYuwYxa7GM=;
        b=milam3PLoEFObg2Dw7b2dx57b6Lh4poXgHLyVqgUFk/VbLJja50MXhRCo3xO7tv8xU
         nsDTZA4jX9Hia9jM4fN2q62i6SBALNSPJsX8fOIiIPdXZaGCq8kR08VY8ZgSUDhjVrC+
         e+ikp1Who8zIg3njDNxI6uOZ5M31HSlaHnPbj/1gXk06h59R6d4FZj9PVrIujUsvAu12
         4XvGV6t3kaoOjDUEiP/QyxYckfUhI/bcRsPCvFqxG4BfaHDW1vXSlM7Uq1t6qvY6TPjs
         oaV3bH28UnWLei5B6B4BBySMBc5IjY/4DgxVJlT7HIpB3y4GxjKsCvojCrUvOKEnbFvN
         5WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e3fUcmI2wRxCsr1hmzNrwhMoEyiPjpeyRJYuwYxa7GM=;
        b=daCFWIFlkZXA9JpM0nGx86xtkL3w1jiIpQx0fkItfpdGWm3hC62qmuYVVDYYRl2zWd
         xJ1pMkZRZD/8LmIR/4KZcF2yr/rYwLD4l1KDEFBZnqFc/XVdDyvPZBeVG5hfbHxeLzuC
         7wx09/8+YIAsy+GKVTwRJZKwFmByb6JRJZlCPhOSeiVx6rntsED1hwdC/lEmWo9OshsZ
         wUIAUx05spuShZ/619e0IZ29/+o5GAkrh2qbC0ExI6VZf6hMYla+jQReTL6+NCQjo8df
         ebqev584P8XJkJFKQGQhsw96yJM0Cu0y/l1vNyER3KpPsi87WESPuLyQ78SLA1E447Ga
         /fXg==
X-Gm-Message-State: APjAAAUlrNGvMknYT9JyTm0xrRmp6cxxvmeRspAHsi1/pW4LeckGN7i/
        YAGIaVI9UU3opMnwRlLfJlshsDcZ
X-Google-Smtp-Source: APXvYqwZyRs8um9jHdS9JAqRMGqCJzCdTBmXND6TR21yS4trJr1ah1SxePzxBdAnLG0JI91f/q59hw==
X-Received: by 2002:a17:906:830d:: with SMTP id j13mr41690089ejx.151.1558700626999;
        Fri, 24 May 2019 05:23:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm355569eju.5.2019.05.24.05.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:23:46 -0700 (PDT)
Date:   Fri, 24 May 2019 05:23:46 -0700 (PDT)
X-Google-Original-Date: Fri, 24 May 2019 12:23:43 GMT
Message-Id: <pull.223.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix racy fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t7519-status-fsmonitor.sh tests became a lot more flaky with the recent
fsmonitor fix (js/fsmonitor-refresh-after-discarding-index). That fix,
however, did not introduce the flakiness, but it just made it much more
likely to be hit. And it seemed to be hit only on Windows.

The reason, though, is that the fsmonitor feature failed to mark the
in-memory index as changed, i.e. in need of writing, and it was the 
has_racy_timestamp() test that hid this bug in most cases (although a lot
less on Windows, where the files' mtimes are actually a lot more accurate
than on Linux).

This fixes https://github.com/gitgitgadget/git/issues/197

Johannes Schindelin (2):
  fill_stat_cache_info(): prepare for an fsmonitor fix
  mark_fsmonitor_valid(): mark the index as changed if needed

 apply.c                |  2 +-
 builtin/update-index.c |  2 +-
 cache.h                |  2 +-
 diff-lib.c             |  2 +-
 entry.c                |  2 +-
 fsmonitor.h            |  5 +++--
 preload-index.c        |  2 +-
 read-cache.c           | 10 +++++-----
 8 files changed, 14 insertions(+), 13 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-223%2Fdscho%2Ffix-racy-fsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-223/dscho/fix-racy-fsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/223
-- 
gitgitgadget
