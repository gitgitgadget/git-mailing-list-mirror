Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C76C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E8D2073E
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbgFSSuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:50:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51659 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbgFSSun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 14:50:43 -0400
Received: by mail-pj1-f66.google.com with SMTP id ga6so4423751pjb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 11:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6d38XBrU0G+1Z5p6GaJHDOVkw192sN1JkSLyNwOzzaE=;
        b=JjhLVzUx21xWqrJZF/1ivQY6vSNkCHoj0DMH3lUnKk+qTNc7NNYYpyoHPPJ6TTj5Pu
         MUy7wJN8NggiHZQbvqpoMq8/Fug+eM6bgoRnZDrpNLp/fR/gUoUUCCX139uRfemyJN61
         iy0hF1LgEeGhJ/Z3uHSYUK3r6ebslzsodtPo40ki6TMNRqvVSfdYfMUREt1JfPT4yof/
         1CxAIlgVnvIsxR76anRxXOiHQHCiZ2HOgRZU/7+rMiUKzTrS/qW2lHSnl7ITXLEAelod
         ZulbFFvFgaB/VUT0f0NzFqVr4GI/LcmPaGNbuAWp9Ny+dfKYOwfdm9taovWS5oyq2t+n
         pgmw==
X-Gm-Message-State: AOAM531dfCQX+iVTaYPho3dy1zS7s6DtCq64ydibfoQ84sqY1RxAEI98
        o1lhRnGs+XkHggCsCJeHGeo70fVSkHI=
X-Google-Smtp-Source: ABdhPJxM4pWlSekwKaLNWOlq8x8BcrSPg6qcMDWqunUT/4ZEeVFairXzh+nRq9mcuKnRU3RR1v1AMw==
X-Received: by 2002:a17:90a:8c4:: with SMTP id 4mr5347022pjn.64.1592592642358;
        Fri, 19 Jun 2020 11:50:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4902:640:b0bb:40c9:8489:859e? ([2601:647:4902:640:b0bb:40c9:8489:859e])
        by smtp.gmail.com with ESMTPSA id a17sm6503431pfi.203.2020.06.19.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:50:41 -0700 (PDT)
Reply-To: pss@acm.org
Subject: Re: git config not following include paths by default
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <6aab7843-7ece-5499-c074-a5fa8ef68beb@acm.org>
 <b9f47155-e6ef-5868-898d-f5a703e2fd94@acm.org>
 <20200619115859.GA1835585@coredump.intra.peff.net>
From:   "Paul S. Strauss" <pss@acm.org>
Message-ID: <3b4585dd-1d45-0631-f422-dfe13cc38a10@acm.org>
Date:   Fri, 19 Jun 2020 11:50:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619115859.GA1835585@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for your help.

I was trying to set up a dual-platform git configuration with a common (synced) 
home directory structure.

I created gitconfig-linux and gitconfig-windows files that both include 
gitconfig-common. (I would have done it the other way around if there was a 
platform-based includeIf). Then I just set GIT_CONFIG to gitconfig-<platform> on 
each system, which led to the problem.

I worked around it by linking ~/.gitconfig to the the platform-specific file on 
each platform, but that is not ideal, IMO.

I didn't realize that using GIT_CONFIG was deprecated (or that it was equivalent 
to specifying a file); there didn't seem to be a better way to do what I wanted.

    - Paul


On 6/19/20 4:58 AM, Jeff King wrote:
> On Thu, Jun 18, 2020 at 01:40:11PM -0700, Paul S. Strauss wrote:
>
>> The problem is related to my having GIT_CONFIG set to a file other than
>> ~/.gitconfig - when I unset GIT_CONFIG and copied my config file to
>> ~/.gitconfig, the include worked as expected.
> That's working as designed. From git-config(1):
>
>     --[no-]includes
>         Respect include.* directives in config files when looking up
>         values. Defaults to off when a specific file is given (e.g.,
>         using --file, --global, etc) and on when searching all config
>         files.
>
> The reasons for that are historical. Includes were added much later, and
> you would probably not want "git config --file=.gitmodules" against an
> untrusted input to be able to include from anywhere on your filesystem.
>
> $GIT_CONFIG works the same way (as it's equivalent to using --file).  We
> generally discourage the use of the environment variable (and its
> existence is yet another historical compatibility thing). If you tell us
> more about what you're trying to accomplish with it, we might be able to
> suggest a better solution.
>
> -Peff

-- 
Paul S. Strauss                                  pss@acm.org

