Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81FC2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE6613B4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhFRAFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFRAFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 20:05:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77577C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 17:03:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t13so6269039pgu.11
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uM/iyl3f6MeOfac4Ro0hSAgYGUNFtxLfbcwcRfB+rqM=;
        b=fkFVEnyOC874i1i4MRhCk8U7hNs/XqfRajnZhDjz9+PPI3LMVZryn9CqIl7FGRuTBc
         P7z5kXhJDtXUBt2uv67+d5968Je0tql2tiJJbSyxDAJJd2ZPotCcUfS3Z4N6uREUxHLx
         T4D9m0+CSwCy3BQDixj3tnoWhxiQV4YcI1yLjudDMz5gVnoCi5IPaSVC32vFxgdtkGKF
         koeypgxFW6l3R0Q4yc12adIfPja93Zn1bnAdRWCMs3vYK2MoXtqiWOVh8Ouk4uMosEMn
         qCnhpNioIincFj0XMNZZpNja6d527JpA+G6WzpZhn/7jvHM5Z5/Mql/URSrJbqxJep7l
         CGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uM/iyl3f6MeOfac4Ro0hSAgYGUNFtxLfbcwcRfB+rqM=;
        b=iR/0i7H2/7bOQCaZcUQYwuuOaxKgf2/CnU1OUEM3M/uqyl0zrvZNZuhXkNjk6e04QS
         /iITMLtJ3Efzni6AzGdvGEazGRU5wOFu/dtnxmWtoq+FheIl+iETLB2VHHzrZt2ieQ2B
         LaroliXtUqYakza4cazdTyPOE8n/4Aoj8Y1lLXl+DFX1I11kr8lMtRCii0OecVHNfnCu
         Q/4eWIad8JChITabdVm2itaPneeZ3V9FFr4vz3wcGr4BrfQxEQWmjXFWnbZ2wmljpNdE
         WCP+CLJ4cI/FotdxHrkjIjMz74/WV4GstHsiuDDDQ6loq/DMOI9gifgT/8XDKP4aMvdR
         md8Q==
X-Gm-Message-State: AOAM531YM9i+rPXSYTfUbF4hB5+iIzhzBaxsAtkvXpV3kbAYypl39P3n
        NkVgrm/RsrCdeqlQ9atLaif2jXwp3HIwiw==
X-Google-Smtp-Source: ABdhPJyXtw8mdNm6D7uT9sU6xq38n4wnm70cloA8X2d1ycm6s6koavbbsuiYuUF1vMxk0V++HjVaJg==
X-Received: by 2002:a63:e407:: with SMTP id a7mr7185876pgi.220.1623974603865;
        Thu, 17 Jun 2021 17:03:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:30e4:83fc:53b6:fa47])
        by smtp.gmail.com with ESMTPSA id q16sm5788859pfk.209.2021.06.17.17.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:03:23 -0700 (PDT)
Date:   Thu, 17 Jun 2021 17:03:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
Message-ID: <YMvixSHYdEJB2qTY@google.com>
References: <20210616004508.87186-1-emilyshaffer@google.com>
 <20210616004508.87186-3-emilyshaffer@google.com>
 <xmqqsg1iqv5n.fsf@gitster.g>
 <xmqqk0muqv0n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0muqv0n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 01:43:36PM +0900, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As I said, I think it is OK for now to stop at declaring that you
> > cannot simply do it without hinting something that may not fully
> > work.
> 
> I'll add the following to the tip of the topic for now.

Just saw this - yes, it looks fine to me. I'll squash that locally in
case anybody has more comments and wants a reroll.

> 
> 
>  Documentation/config/submodule.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git c/Documentation/config/submodule.txt w/Documentation/config/submodule.txt
> index 7c459cc19e..58ba63a75e 100644
> --- c/Documentation/config/submodule.txt
> +++ w/Documentation/config/submodule.txt
> @@ -97,8 +97,5 @@ submodule.superprojectGitDir::
>  	submodules, but is not guaranteed to be present in every submodule. It
>  	is set automatically during submodule creation.
>  +
> -	In situations where more than one superproject references the same
> -	submodule worktree, the value of this config and the behavior of
> -	operations which use it are undefined. To reference a single project
> -	from multiple superprojects, it is better to create a worktree of the
> -	submodule for each superproject.
> +Because of this configuration variable, it is forbidden to use the
> +same submodule worktree shared by multiple superprojects.
