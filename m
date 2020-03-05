Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C74C3F2D2
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5720848
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 19:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5TADn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCETtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:49:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35033 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCETtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 14:49:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id v10so93003otp.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=56gMTsbj+p3RWx8gkQl7qHAyQVS/XNQX+mSUcIq9XvA=;
        b=GT5TADn/Bscc3Od4nWMbQ+Fi2imKcO50kb3gEHFHW8xo+2BxwA4Y9uXpsIEM1EL+eN
         hbx0h5w2RMTuFENp++/h+E9XZyk1XGv196bEUPPkagsSScmXVtmkyfMdU/d5MiDcVp+U
         nLxWS1GqMkVrV3+mUHvvRx6AVUCvkvnBshCD/20or3dRJV/gG2A+O+cHDjw73+w2LSRQ
         4U9/R78OtRl48hSyZXSuh2mmYurqvoY0ZwV38tG/M090g9e53OrsHMcBLh4f8FCSLsrq
         RkXVdQ+S8823gp9/o5ydh3r5vl8ClPqvFzwjz/gqvTzU/CQJeP1RaD9YHPYQyNEn3tsq
         gR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=56gMTsbj+p3RWx8gkQl7qHAyQVS/XNQX+mSUcIq9XvA=;
        b=WZo1IqhrJLOhpnSd4ew+S6EqLY8DuGA8u7iBmsoLU+oU5XszcH1f5wKVYzTyOKkxAm
         BGXskiQFAkNKKvXj7ZzrlkkXCSwBVAM0vYcMYO9LGXReQ6E7A6J1wqCoZZmpYWHptz2M
         cLtFVaYEXoQz01fLlYns1rVZfreiMXCnuLg5TDYtGm+9lmRQCf6O7Cu1hLEg6YjEdJr+
         4j66n3n8A9dpeXoFv/8I6tx8ctlj5Ag2dOzgdXEVqJ3xvycx7ZY5Pz1ltelWhI8ECOiY
         w8r/NMaL32C0Hm0IvR4fF4sddHdkxjVZtlc17S3f/VQ3hS9bgWZXlUujTh3dIFCgp/0I
         B6aQ==
X-Gm-Message-State: ANhLgQ1uGG83ERNt8rOcNZC8YQhypVLH5MzS7iL4tDsbZyAZXfbAMCki
        Av06BJQhIR5E59maSPYgodA=
X-Google-Smtp-Source: ADFU+vvItdDP2YCgyFHhuL861W6uvs5g4fLsdwX6dSwlkpHTGOOgz0IJUc1WtIuITYXrz/Io8Nxrjg==
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr60262oto.367.1583437781241;
        Thu, 05 Mar 2020 11:49:41 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:6c60:df2d:bd3c:13ea? ([2600:1700:b00:7980:6c60:df2d:bd3c:13ea])
        by smtp.gmail.com with ESMTPSA id n16sm10529492otk.25.2020.03.05.11.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 11:49:40 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <e52a50f5-d050-3fd1-5014-4893375e2d7b@gmail.com>
Date:   Thu, 5 Mar 2020 14:49:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My apologies that things have been quite on this series for the past
week or so. An unexpected high priority task at work demanded all of 
my attention and will continue to do so through the end of this week. 

Hopefully I will be able to pick this up again early next week and 
have v3 out soon! 

Cheers!
Garima Singh

On 12/20/2019 5:05 PM, Garima Singh via GitGitGadget wrote:
> Hey! 
> 
> The commit graph feature brought in a lot of performance improvements across
> multiple commands. However, file based history continues to be a performance
> pain point, especially in large repositories. 
> 
> Adopting changed path bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
> presents an updated and more polished RFC version of the feature. 
> 
> Performance Gains: We tested the performance of git log -- path on the git
> repo, the linux repo and some internal large repos, with a variety of paths
> of varying depths.
> 
> On the git and linux repos: We observed a 2x to 5x speed up.
> 
> On a large internal repo with files seated 6-10 levels deep in the tree: We
> observed 10x to 20x speed ups, with some paths going up to 28 times faster.
> 
> Future Work (not included in the scope of this series):
> 
>  1. Supporting multiple path based revision walk
>  2. Adopting it in git blame logic. 
>  3. Interactions with line log git log -L
> 
> This series is intended to start the conversation and many of the commit
> messages include specific call outs for suggestions and thoughts. 
> 
> Cheers! Garima Singh
> 
> [1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.com/
> [2] 
> https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/
> 
> Garima Singh (9):
>   commit-graph: add --changed-paths option to write
>   commit-graph: write changed paths bloom filters
>   commit-graph: use MAX_NUM_CHUNKS
>   commit-graph: document bloom filter format
>   commit-graph: write changed path bloom filters to commit-graph file.
>   commit-graph: test commit-graph write --changed-paths
>   commit-graph: reuse existing bloom filters during write.
>   revision.c: use bloom filters to speed up path based revision walks
>   commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag
> 
>  Documentation/git-commit-graph.txt            |   5 +
>  .../technical/commit-graph-format.txt         |  17 ++
>  Makefile                                      |   1 +
>  bloom.c                                       | 257 +++++++++++++++++
>  bloom.h                                       |  51 ++++
>  builtin/commit-graph.c                        |   9 +-
>  ci/run-build-and-tests.sh                     |   1 +
>  commit-graph.c                                | 116 +++++++-
>  commit-graph.h                                |   9 +-
>  revision.c                                    |  67 ++++-
>  revision.h                                    |   5 +
>  t/README                                      |   3 +
>  t/helper/test-read-graph.c                    |   4 +
>  t/t4216-log-bloom.sh                          |  77 ++++++
>  t/t5318-commit-graph.sh                       |   2 +
>  t/t5324-split-commit-graph.sh                 |   1 +
>  t/t5325-commit-graph-bloom.sh                 | 258 ++++++++++++++++++
>  17 files changed, 875 insertions(+), 8 deletions(-)
>  create mode 100644 bloom.c
>  create mode 100644 bloom.h
>  create mode 100755 t/t4216-log-bloom.sh
>  create mode 100755 t/t5325-commit-graph-bloom.sh
> 
> 
> base-commit: b02fd2accad4d48078671adf38fe5b5976d77304
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/497
> 
