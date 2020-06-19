Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30D7C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 06:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB92420786
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 06:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNbPn9sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFSGMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFSGMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 02:12:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DDC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 23:12:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so3863481pjd.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=qqJK96EUrn837uAJ+KQNflI84kIbM+zayVAM6zN5XLw=;
        b=RNbPn9sRSkbqV5lcmA9cZUFyWkVZS7sgSMNJTVYeYUrwi1TG8qIRxJELRHvuUZB5ou
         5Ejioo2aKRNtYzZUaNcG0HzxKQBCiPYkreCDtKf6FuA7/l72ZmwBNnZKVo0DUbgnkvak
         0f7DK0Jf9PfiPqKJF9VCeMqzJ6SSxLcNJ51MkGm9peJBWQkp9KWF44vvc2ZmsRR9f755
         hpfEUA1Q9hhNbdKbpBJ8aMlqLBxnAc6O3VNnW+knTlqy/UzcHT1gFIsHgxIrZS1H6RMq
         tn3JHPW9csIo9p+I20okfNB21pq3ZdcFJGxK6sFtSQqIBvBS1mIu3jbY0m2oobbARNw3
         VOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=qqJK96EUrn837uAJ+KQNflI84kIbM+zayVAM6zN5XLw=;
        b=CfplzNx4pfw7/LGX8/yUkTyo6JmF3J4uFME98sgbXCnOlph/LrD1CON/7b9zrjlg5F
         AqDVdVyacH1hZBH2XhhtlmovgULbGcTksUkb2IJPKoRGL0DqRJJRsA/0rc7yrjVgysVB
         tCyRgylx2lGdnJ6j32LygLPprt4q0lyc0S1OU/N/wJnqoxZjwQ3riOXP+gEXHnZndPNw
         zuy29lgwpy0dO0+ddI05DNG/KHlrgdtywK+iVvf2iU8vevYkbG6LBV4mDqq00IfNnkps
         PPFVyj3dhS8L5NnKBplOgJsAWTYpuJogkjQf+LJZCCj4ReKafxy1nguFbtbQdZnh0sYm
         xaVA==
X-Gm-Message-State: AOAM5332tvf9PZU+Dta7OvLX5Pi+Ur98tKy1PEy6z5tuiHtSjY53y3a0
        Cu+hNrGT0Zp8saCzPsCOOoQ=
X-Google-Smtp-Source: ABdhPJzIvdXe6LMyhOxvQZHTcY/D0i6NwMhqKM1BSwu4pZYQJztUNqK+a0JYf6FTiQQ13A754Pt8qw==
X-Received: by 2002:a17:90a:ce14:: with SMTP id f20mr1908540pju.115.1592547119791;
        Thu, 18 Jun 2020 23:11:59 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:b07:bcdb:217a:baa1:18af:b5e8])
        by smtp.gmail.com with ESMTPSA id z11sm4785674pfk.141.2020.06.18.23.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 23:11:58 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:40:13 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 0/2] Accelerate "git merge-base --is-ancestor"
Message-ID: <20200619061013.GA10213@Abhishek-Arch>
Reply-To: pull.664.git.1592414670.gitgitgadget@gmail.com
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.664.git.1592414670.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 05:24:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> It was recently [1] reported (and not-so-recently [2] reported) that "git
> merge-base --is-ancestor" can be pretty slow. In fact, it is regularly
> slower than "git branch --contains" or "git tag --contains", which are
> answering a "harder" query.
> 
> [1] https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
> 
> [2] https://lore.kernel.org/git/87608bawoa.fsf@evledraar.gmail.com/
> 
> The root cause is that the in_merge_base() implementation is skipping the
> fast can_all_from_reach() implementation and using paint_down_to_common()
> instead. Note that these are equivalent: a commit A is in the set of
> merge-bases between A and B if and only if B can reach A.
> 
> This fixes the issue, and makes the performance degradation reported by
> Szeder a non-issue.
> 
> Thanks, -Stolee
> 
> Derrick Stolee (2):
>   commit-reach: create repo_is_descendant_of()
>   commit-reach: use fast logic in repo_in_merge_base
> 
>  commit-reach.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> 
> base-commit: b3d7a52fac39193503a0b6728771d1bf6a161464
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-664%2Fderrickstolee%2Fmerge-base-is-ancestor-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-664/derrickstolee/merge-base-is-ancestor-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/664
> -- 
> gitgitgadget

Wow! Thanks for investigating through the issue and following up. The
performance numbers speak for themselves.

By applying this series on the commit-slab patch series, both are now
just as fast (master: 0.048s, commit-slab: 0.050s). 

Regards
Abhishek
