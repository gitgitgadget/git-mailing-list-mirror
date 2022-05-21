Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6465C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiEUQzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiEUQzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 12:55:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884E5F5C
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:55:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rs12so9039860ejb.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Tisdl8RAwJ0Emr8AQXwnQWLg1glae50phYzmwJCKB8M=;
        b=UYkldC1dPzG7FVWb4wghsHrwSO6ir5D4kM9V6JM7xvuK/CgD1g2hrWBHUcyeB3BlJt
         episZ4nWHreYrapBCiONpqFWqdzDWOhOQqXew8rw1GM934yumdN5TJ2fka6hRKDrFw+X
         tPmb5XMY3yAeK3wdeS1qAXkXK9WzsorV8Drct+kI3kODHOpts42QRH8s+PrfAKsKwYO6
         Ag7UYYvdNEHl6c80FZsZAJkNnO/rCZghdl+RySpRzzYw53Ik9yOep/gYzfhtCGUVTbiR
         M/OYTSeYLV6OV12UYRljEIqVg9kN7h81JqWXWtGYPSq/a70uL1Gcm29CxSjd0BDN5sjo
         TCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Tisdl8RAwJ0Emr8AQXwnQWLg1glae50phYzmwJCKB8M=;
        b=tgtKt1TbGv6Hykg7K6BE0Tvgs0+NpLFiyzPbgK+WOmM8ns9E6rq/nCGQg2fbE/hoPP
         nUAN4jzIfeSvqMGHNKavcqirSNQz5SsETTsjkrNftxwqaR73Pyzeg0u+AU1Ct/Hcet6y
         wxSoawUGpVw0SWvVTOA214w9Ks4kdrPkm+1iUdSgvlGzaG5Hm47fPnqpuYlAlYSU2LDe
         5K8JCYNco28HInaFDgPQdTClDi2Syqgq6iuyWvovArdFt9nlGybTrEzF+NM5BmLp7Qxt
         3S0zJ6OlDWknCcBZOvMvxvT/EIHfUQEXHV1RpyxlWY4NSp8AsBZYj0xaxIdRCvXkiyR9
         4RQQ==
X-Gm-Message-State: AOAM53270biJ3w4Bq0K/WMy5qOhUukTWOGHXn8I/26nR8yEJJwgHyzLA
        niSwjyl3Y1KbPVeCiVjo4v4H9FuQFU4=
X-Google-Smtp-Source: ABdhPJx8mn8XIxcw8/gG5Q+JgyaUSII9s3GiIf0/kZYEYquK9GtX9mdcbscUbsJAM6JJGhzKT3gXYA==
X-Received: by 2002:a17:907:dab:b0:6fe:b379:ad3f with SMTP id go43-20020a1709070dab00b006feb379ad3fmr6554516ejc.223.1653152149267;
        Sat, 21 May 2022 09:55:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bf15-20020a0564021a4f00b0042a9fcd7c73sm5807340edb.46.2022.05.21.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:55:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsSOJ-002foP-KJ;
        Sat, 21 May 2022 18:55:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 11/15] bisect: move even the command-line parsing to
 `bisect--helper`
Date:   Sat, 21 May 2022 18:52:22 +0200
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
 <4ae78d37d04789b2cadb059088e59af80a850c15.1653144546.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4ae78d37d04789b2cadb059088e59af80a850c15.1653144546.git.gitgitgadget@gmail.com>
Message-ID: <220521.86zgjazuy4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 21 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On our journey to a fully built-in `git bisect`, this is the
> one of the last steps.
>
> Side note: The `parse-options` API is not at all set up to parse
> subcommands such as `git bisect start`, `git bisect reset`, etc.


It seems that since v2 you fixed the bug of "-h" starting a bisection
session, as noted in :
https://lore.kernel.org/git/220225.86ilt27uln.gmgdl@evledraar.gmail.com/


But that problem seems to still be with us in other forms, e.g. just one
thing I tried (the very first thing) was the command I was testing in
10/15, and:
    
    ./git bisect--helper  --bisect-terms 1 2 ; echo $?
    You need to start by "git bisect start"
    
    Do you want me to do it for you [Y/n]? ^C

so that's buggy too.

> Instead of fighting an up-hill battle trying to "fix" that, we simply
> roll the same type of manual subcommand parsing as we already do e.g.
> in `builtin/bundle.c`.

This is particularly confusing because that would be a good approach (as
I pointed out in a previous round), but the end-state here isn't at all
like builtin/bundle.c. I.e. in that case we have a top-level strcmp()
chain dispatching to parse_options() for the sub-command, which would
solve your problems here...
