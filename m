Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFEDC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EE56124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhDGTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhDGTi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:38:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C80C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 12:38:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so1855275pjb.4
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3N/NNSbo4w8NV3lgsadnfcpo5p/ut5yrX+VHHpBFjT0=;
        b=ULT/L4D1gVz+W4c9RssdG7eZxh2ldIGesN+HIse4hpVvSLmLkm55wtSbs+evraNS5W
         k1KcCyUuW2TpCbJLIUDs2RQh4DCnUZjbYQHYdSyUdEfNBKjvC/pTTlW0gr85iddE0EmN
         VPlgXEsby3tiGdhGXRxFRBn1vmU/yOwQ9jeIOVR5j8aQxbjuvJFGeAWF+dIvRbr8E+qs
         eWNWdRCn9pG7sNEGEpZALmwWvW5WNqhDDEpfyqu/fewAp56qOCQ1Gv6yyTfLCUIT1H2j
         as3x0x+BU7iPZT1mE5y7FbUFWwBNtBHWAQcdBSieYquP48SWGsUks73hIsP/mUP9nS9u
         w7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N/NNSbo4w8NV3lgsadnfcpo5p/ut5yrX+VHHpBFjT0=;
        b=hox/UwT5jmdldkz/wNHLpQIABpO8Y9zxb3Fxbn6pD0FV6HIeCAflM3yDuDO7JkHo8M
         Ag/0Ey1HIeWaFrgYE1VFNxISIx1lRKIG+1nt+lbEhtwEdw4ZFl07ijaEv9ddu3vseGRc
         X1Qy1H9MeDx4++BrDwckn7fYEzIajsANoLiilX6d3AeqClDAF/XXFLbhwca/duoGaxay
         SqmPQu9UTJ2QIBkhduHgBhh+H0GR8YP3W6c/9NCQWSeZSFHX40KzZLIn//xwBNx6mmaG
         4iIB4eRzDVSSbsW7pMPrLWbNL/uhnwJ3J2se8iBHaeISCCXiMRCSQPyZhTwzQ86/Mhg0
         TZJw==
X-Gm-Message-State: AOAM530kwYrS+JD51pzW2H4CTZNqWOYCpknTFhUcRVBcL0ZW/R02/7RV
        JRSUgXZjMu1Nu0JzCs45vVC8LWypvCr9mLGIB/M08w==
X-Google-Smtp-Source: ABdhPJyd8CqO3LKNhpVIyvyWrI65CeJCwBlxxT+ySfOykGVUlo853GlAwruGkd8RaULlXlQScRYK3m8QfSawbaxHj58=
X-Received: by 2002:a17:903:2306:b029:e7:1c8d:63fc with SMTP id
 d6-20020a1709032306b02900e71c8d63fcmr4379959plh.35.1617824328783; Wed, 07 Apr
 2021 12:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
In-Reply-To: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 7 Apr 2021 12:38:37 -0700
Message-ID: <CAGyf7-GQ_1JV6X3Z0h4c3+Qy1eZ30RW-Mni=72p007md5NLKMg@mail.gmail.com>
Subject: Re: There should have be git gc --repack-arguments
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 7, 2021 at 5:10 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> I request that git gc should have --repack-arguments option. The value
> of this option should be passed to git repack.
>
> The use case is when I have very large repos (such as GCC and Linux kernel)
> on a server with small RAM (1-2 GB). When doing gc on such repo, the repack
> step may hang because git-repack have to create single large packfile which
> can be larger than available memory (RAM+swap), so it must be necessary to
> do git repack --window-memory=<desired memory usage> --max-pack-size=<desired
> pack size> to create split and smaller packs instead.

I can't speak to the feature request, but since there are
configuration knobs already for both of those, that implies you can
use git -c pack.windowMemory=... -c pack.packSizeLimit=... gc and
those configuration settings will be propagated to the git repack
process that git gc runs.

>
> There should also git config item gc.repackArguments, which have the same
> effect as git gc --repack-arguments, with the option takes precedence over
> the config.

Passing configuration settings as I show above would already take
precedence over any config file, since config from the command line is
higher priority.

Hope this helps!
Bryan
