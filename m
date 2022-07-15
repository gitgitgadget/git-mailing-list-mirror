Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E2C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 09:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGOJff (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiGOJfe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 05:35:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476D7B7BD
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 02:35:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf4so8018428ejc.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ULYXZWinK37+HTk8RI5f92xLpN5E6FIUUa8Tbcdb140=;
        b=hHKpP3+xJUDX0jRT+gKgd2AbMR6pGK34Hr5xZYNrVYQaDeNLNj3TNdnTGFr2lQru/e
         cEIPvrGDBJbJvKK+K9NvAnFZYsZplansojFAYH8rppW0wFqHqjk2QJMwsCaQcTh8ZBiF
         VNewr5SZVtz9jcL2RvZGuzxhg6xuogzNOwQd70ED7zDwNhR1KNvyjDvD0sTgpZVq6qTf
         Ndpkl8dRpudcKoqAY1fOzoY2GYoJjSjtDBGMhtfbn7TkTBZ3bhKLK4yYnD3bQ4R+NPW2
         GLodkNNH4p/diOqld/5+NoVVCdE4T6z5W1SKSIN/oYWKXYJVzjQG5cVKaAkLoe9spyPj
         jrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ULYXZWinK37+HTk8RI5f92xLpN5E6FIUUa8Tbcdb140=;
        b=bvAgAlTTZum9pnQMcydSXj/tXto1l4q9yrUitGjl4MyNNG8vP0gC2RACe3xS8VEZAD
         qg72KwKwC2eWV1uIOhjlT+KlCV55UeF7VbnQwgednvwmsLaoaarHC2+4lID031y82eNN
         vWAD4SpWRQ9mgt0/XLX2u7SFEWG6QIiqhVJpoH5nqh2pjhBQiqNYS9GqFKyPCZbQltvb
         CBqA3MyIJV7iRxfeTwULXUlxmy4ZppJ0DLpWFTGjmr2qRn902+p0TgGMZ6vhbjDrV593
         QIr6XcpEDQwvr/ExtBfwC+sXw62T6U+7NWAACr1F8rKLE4tQwUVgTk5JO0cam033se3i
         EaFA==
X-Gm-Message-State: AJIora9mPmITYqkUm9ZCZJCxxWAjYwsrrmrEvTAMsH2DtvEUmw6HUTG8
        pT9tEqNf/1ydUhK84DYzwMrt/OGqSnq+5g==
X-Google-Smtp-Source: AGRyM1sm+w1ga82XF9DmbMAl1LtHsR4mfAMG0uwk3Erc7DzQZTzjehTvQLehgFugMiWRS0NmBl6jDw==
X-Received: by 2002:a17:907:75e3:b0:72b:198a:b598 with SMTP id jz3-20020a17090775e300b0072b198ab598mr12967209ejc.401.1657877731848;
        Fri, 15 Jul 2022 02:35:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b007263713cfe9sm1827577ejh.169.2022.07.15.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:35:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCHjN-002cjh-I1;
        Fri, 15 Jul 2022 11:35:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
Date:   Fri, 15 Jul 2022 11:25:23 +0200
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
 <xmqq35f38yeb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35f38yeb.fsf@gitster.g>
Message-ID: <220715.865yjy1zxa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>>     Unfortunately, I noticed this regression no earlier than when I needed
>>     to validate Git for Windows v2.37.1. Since v2.37.1 was an embargoed
>>     release, I could not use GitHub Actions for the CI testing, so I had to
>>     reinstate Git's Azure Pipeline.
>
> I wonder if it would make your life easier if the same GitHub
> Actions CI stuff were available for the Cabal repository we use for
> embargoed work, by allowing you to use the same validation for usual
> releases and the enbargoed ones?

Isn't it. Looking at
e.g. https://github.com/git/cabal/actions/runs/2284056293 (private link)
that's the CI run for the latest push to "master" (same as
https://github.com/git/git/commit/e8005e4871f130c4e402ddca2032c111252f070a).

So I didn't get this idea that we must have Azure to resurrect for
"private CI", don't we have that already, and anyone can use it by
re-pushing git.git to a private repo (the limitation being that on
GitHub you can't make a private fork of a public repo)?

