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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE7C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265EF60C3D
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRFZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 01:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCRFYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 01:24:16 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:24:16 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso1133186ooq.12
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG+5MQ09VXGNfN5qROG3UQ2t85NgB/ibMJBqbDpscsk=;
        b=YX9aH3qFfT0WWXGR42URwiZW5tFXB/q4nTpt+91FUOnDOg/T8mxfNImXj6KGa8JVes
         gaK0VAF480qpUmsfVW4ATs8Vbp1Bo6tPBuQftP2xdRyemMcQtvx/Kj3J6fAwPhADFund
         IwxdvYJe7yWaAhee376LrKKXNiGxAYMtzmvh591qsKeI4FCJ6VksTu9pLEn2wb4xrxsl
         66qA94GsyTGCzi3r9lomPez9OtCmxVFlcdjSyhlKRwZJ2Pcnr973/HZUj0A4oYD28dGK
         DXPsgFhVkPvn+OAaX/tvlWF94PKBI6DIcIeuWOWUw/skCLLEW8IR2/j2K1feiCKmG36y
         haMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG+5MQ09VXGNfN5qROG3UQ2t85NgB/ibMJBqbDpscsk=;
        b=YhWh3CxAL73Nuh391XpfpQsaqYuTfB/kUhJDA2LCgA+ClxEkCsR427kccoCCxV4lPO
         HDyZgpPwPDIAh0Ro/ltxShQKM6CcCkL6PFKzzvn1SXQMYJQyNkeX6CnjUqSM7My7aySz
         hu1iXGrNLQiioQEooxv8Wz6LzQTx8FLSDGqDjgaF8n/aRc0cPXDUcGBOQdr9bIfkGMhu
         eMuM6UmcBZqVZKeiz/wnWanjqxobqnUi+ir8BQb411eeI+zFc16Id59xkqfA4RifNBrb
         FjQVjs8gHCoUYCf+8bEuNUj2evPZD5NsAWPueDnw9pK5cb2qVU3oVf0Qalw9QKSvBX1I
         MHsQ==
X-Gm-Message-State: AOAM532EgePP9KvoOQcsB6lEURqfsG2nHiJExRhruloHXtg8fz1cpvaJ
        KaErbP8xZAIPPQi00klnVZgRkRHEzrldRh7xqvM=
X-Google-Smtp-Source: ABdhPJw3GtAk6vAv3Nq3l1OsgU/9UU91oZQLf1MmdW7Ymr/ImwZ13KBHYtzREbYtbelfQ+rjwVvwSBoOnTl8Ctgx5k0=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr6052218oog.7.1616045055532;
 Wed, 17 Mar 2021 22:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <45bbed6150a2a9f9e9446edc9a613f027da73957.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <45bbed6150a2a9f9e9446edc9a613f027da73957.1615929436.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 22:24:04 -0700
Message-ID: <CABPp-BHsSpQieOGFPwXJ63qy1JhWcwu-bSvv1w7-yTZ6T4fx9Q@mail.gmail.com>
Subject: Re: [PATCH 17/27] diff-lib: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before iterating over all cache entries, ensure that a sparse index is
> expanded to a full index to avoid unexpected behavior.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  diff-lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index b73cc1859a49..41d6fcec1a81 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -102,6 +102,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>
>         if (diff_unmerged_stage < 0)
>                 diff_unmerged_stage = 2;
> +
>         entries = istate->cache_nr;
>         for (i = 0; i < entries; i++) {
>                 unsigned int oldmode, newmode;

I don't think adding a blank newline will ensure the index is expanded.  ;-)
