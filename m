Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A0C19437
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4392923B04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgLHUzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHUzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:55:21 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0CC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:54:40 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id t23so4353331oov.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iqam+DpYSj1L62zYa9l+MgS9oYYeiAKrO5lNLsQXXMw=;
        b=OIkTsP4uKNTj9s3DntoCFC1xoCswmLNtH6t39FGptJFCyhgaeI0Ey9gKZE3HY/b0wc
         zOiB4yE6CpFZMl8WM32g2NOSFs148MdKDRG2seIayxL+R3mdzjJq7sLE7P7a5DqfWrSE
         6XA9RiwB/EA06YZ5LvVRpe9xftNnA8kqhlNb9ySPtDxDy98XdzthwGSdxcW7Zxc5fs2t
         5pspzrBt2sHWKlSgZelG+iX79yp/hT6oFaF/O0WqjE7FSxpwMa8oz6La1funBGv8fLAL
         ihJaZnmvFa7HCFEVNLSokzW0QqmrmdIlZECTm3KyI3YPl0GFmN1wf8qUs5kSVEc4bWT2
         sxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iqam+DpYSj1L62zYa9l+MgS9oYYeiAKrO5lNLsQXXMw=;
        b=WqNAs9+Wh+xKZzk8d78Tjk/jqZkQYDq+FIljvyYh1/Z+se3x/OVEXLKQv11V5FBIl1
         KvNRMf6Fkjr/yN8QZX3/cGLIC3/5f8eF9LmyhUDoJuzwT4bjsIZjnAXI9dS0/0g8qOh5
         aQZQPhyEl0Y2/1qZ4w4JzbCG6+GwwC7CNLvCFldRfPjmpq1q6QBeqsfhk4FBamTbCmCF
         iBWNs91Qko389z8IJhpNYEYdXb6pE5gsei6jUtdMykkNTRBsvz6oeEQfn8qPjUIpFSa1
         mBvEGeLSs2rGZP63TKkXDBQITt2O02jNL1dSafFZpv4LY1ndEqepgEq6AEHPw6SZfbhq
         CYyQ==
X-Gm-Message-State: AOAM533WGwyxZRRvuVDUvO0zNALVOIP7/hkrJdH/KR8DszUXvw52g2Aj
        7gZMIhNrXb+MWJGC3fo6P8GC5LpPV+l3/xf5
X-Google-Smtp-Source: ABdhPJySGYKtL3eUouhPh9rZg9its/TyTLETo6hIF/ReC2RTW1+ZrSP/iZNX7lO2IBT7P/q1Yz+BKA==
X-Received: by 2002:a9d:67da:: with SMTP id c26mr10960825otn.321.1607453132327;
        Tue, 08 Dec 2020 10:45:32 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y84sm1176752oig.36.2020.12.08.10.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:45:31 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:45:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/15] chunk-format: create write_chunks()
Message-ID: <X8/JySnLxR2DaO4V@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <03f3255c8f4a953065b2ff8e61816f83534c23ed.1607012215.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03f3255c8f4a953065b2ff8e61816f83534c23ed.1607012215.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 04:16:51PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph and multi-pack-index files both use a chunk-based file
> format. They have already unified on using write_table_of_contents(),
> but we expand upon that by unifying their chunk writing loop.
>
> This takes the concepts already present in the commit-graph that were
> dropped in the multi-pack-index code during refactoring, including:
>
> * Check the hashfile for how much data was written by each write_fn.
>
> * Allow write_fn() to report an error that results in a failure
>   without using die() in the low-level commands.
>
> This simplifies the code in commit-graph.c and midx.c while laying the
> foundation for future formats using similar ideas.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  chunk-format.c | 23 +++++++++++++++++++++++
>  chunk-format.h | 13 +++++++++++++
>  commit-graph.c | 13 ++-----------
>  midx.c         |  3 +--
>  4 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/chunk-format.c b/chunk-format.c
> index 771b6d98d0..a6643a4fc8 100644
> --- a/chunk-format.c
> +++ b/chunk-format.c
> @@ -24,3 +24,26 @@ void write_table_of_contents(struct hashfile *f,
>  	hashwrite_be32(f, 0);
>  	hashwrite_be64(f, cur_offset);
>  }
> +
> +int write_chunks(struct hashfile *f,
> +		 struct chunk_info *chunks,
> +		 int nr,
> +		 void *data)
> +{

Serves me right for thinking that a function like write_chunks() would
be a good addition to this series without... actually reading the whole
series first ;-).

I'm glad to see that you're adding such a function, but I think that I
prefer my version which moves these four parameters into the chunkfile
struct. That allows for other functions to be created which can, for
e.g., manage the chunks themselves (like my chunkfile_push_chunk()).

Thanks,
Taylor
