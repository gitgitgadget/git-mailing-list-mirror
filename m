Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E1C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2658206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 23:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0noGHPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgFEXCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgFEXCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 19:02:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7249C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 16:02:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so3425644pjv.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3WTTaUpdK9DopZsyargDgyjQYNddHbSAQDbSVNt63Ag=;
        b=j0noGHPQAxeM8l7IuEjgQ+CVxRWRuPlj5q13COcZya3lqvJ+AoV935NQwbaSOOBlCl
         tGlruJ8QgJ3c0fUOzRVCtEYIcazF6Kf/GGtk0UIwrmkhkCLZjoKvOkXJ3B7OlIJW0hKB
         kZ8+Tt39ZrlbMOUe9F/wKVBqMRCYb5gl6TSnBx5epSZsx7O7B1fpVTyv0GFU327ltUGk
         od9hKpVdtZBbUwsacI3JuFwGmlB/qXSIdTX12yHIavQ8v8+MGt8JLme/rF2Vkw9Oj0vZ
         iCndcS9wggLn4s1YSB6h/hvHiPn4xMO4Pds2yRT6EN28VPsscM3gajkzwsf5h5nzJ40x
         pxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3WTTaUpdK9DopZsyargDgyjQYNddHbSAQDbSVNt63Ag=;
        b=WXNw2wZtj6T7hI3K9v8v9dXjzrIPA5RmgUdzjLDOfi/9euM1WzgvgnPDL66KD04mBV
         Zo1hC3iBg6D7+MgIrXkNWwpNxcCr8QNtmSshMDKwYY25Z/EhLMcu7JHMzA+MNBMi2vHk
         0Vp7/ZwDfuYyDE4bROYP+epkcSc8bctMOrKIArQASX0ypys2BlPTW/3v0ny1JF6nQCEk
         gvrFlbG98JZ4mAh+Hl2HOswW96G9iewypl8abrucPrHkv12w593QUF10Ld7eWZA08UPQ
         +jhOgIv7JGSYvt2UGPpI37YRUjuWY5emldsOE7GwGPvYzx5h1BLON3xtPN4p1mP2At14
         hthg==
X-Gm-Message-State: AOAM5300CYby9lIAvj74ugRDJYO7b/hSgcgdhj0jFPc2FMG/WrHtkMLh
        CogTuO8rX7BO5o9bN0nGhAU=
X-Google-Smtp-Source: ABdhPJw/Io0Bbl2RRsrHBRn4xJuXYGr5G32epvCSVDNekkKvh7evTCP3sKA6gId0g+80RdEYKOsxAA==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr12115940plt.242.1591398156074;
        Fri, 05 Jun 2020 16:02:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id nl5sm9628607pjb.36.2020.06.05.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:02:35 -0700 (PDT)
Date:   Fri, 5 Jun 2020 16:02:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fuzz-commit-graph: properly free graph struct
Message-ID: <20200605230233.GA167014@google.com>
References: <35063a0ab4edbaa5bd5b0138e6a6a5b36a8664c5.1591397562.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35063a0ab4edbaa5bd5b0138e6a6a5b36a8664c5.1591397562.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> Use the provided free_commit_graph() to properly free the commit graph
> in fuzz-commit-graph. Otherwise, the fuzzer itself leaks memory when the
> struct contains pointers to allocated memory.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  fuzz-commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

How can I reproduce this?

> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> index 9fd1c04edd..430817214d 100644
> --- a/fuzz-commit-graph.c
> +++ b/fuzz-commit-graph.c
> @@ -12,7 +12,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>  	initialize_the_repository();
>  	g = parse_commit_graph((void *)data, size);
>  	repo_clear(the_repository);
> -	free(g);
> +	free_commit_graph(g);

In any event, the patch itself is sensible, so
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
