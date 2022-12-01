Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A0C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 06:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLAGsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 01:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLAGsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 01:48:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FF5A6E6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 22:48:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so866710pgh.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 22:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGhJ4pvz6kIkLI8NUGqGSPNZs8HVKeMtpbqS7ZiOSqk=;
        b=jJQx4tSqzJlJH/GgEWwuekjCgUAmNQ3Sv7jXr+D38hSWFNTGiiheRKA/2Ead5XoBEu
         P4cMPXRkPaltOI/jYnpRDzeQUtPyFfuomNJSvwmqoppyrzpXZeT9LOPz0PCg2nKIqGNi
         K8hibre+MxWFyI4BVyIpRwHIeofN82ZMCaeAv2L+9Vy3aODA8B4KHdSTaqjhKel1SKhV
         5ngfTRuzmw4aDi4Ln9bhbvI6+t3R0/XW+WblLYzs4UUcI43CcwEVXzKNO29dMblnERLY
         UFN6s93SVtSmxYBN0t6+zwOjDelqht0pJDqxSGMKles0BPQrXT8OQngjXSRReIMP1wpy
         iBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MGhJ4pvz6kIkLI8NUGqGSPNZs8HVKeMtpbqS7ZiOSqk=;
        b=0ri8j1leIt4mlAKlrWbBmCfhOLhnsuvA5KLb84fH0SFkaA08VtGpygC62F4sMdHaYC
         Y3QAlhaEkSGMY0OJ+iQD2epChll+xmtyg5tX/kIUcBrveFmPyV4witQCzRY+sVGUs7kX
         aFBA6sLTEnB0ukCmwlE9jKgzUcVjGVFBuzK2TLu6V6wfhRSzVJ7nKLIsiREUklF61/D8
         t8njIlYk1YQP8MNU5cpFPKKXSuGYV5ffeqrKcDVnwuR0H/qF6S/P1iSWjeUIp47HBvAO
         J+zsNIY/QVuiCNQTTDLVs1wx5waTY18gbWe9S488FeNZ3QUx4ypLJ9yOrOiPk71NmGQ3
         o/ZA==
X-Gm-Message-State: ANoB5pmPVJvu3ygkqyEVn8VAcbW8XEruYwoyXRdEa8YhvPEwwE9RF3q4
        9QwM7lPVlR1zdG3E20phK6I=
X-Google-Smtp-Source: AA0mqf6eycBRscPcdJwehImo4GUpO1EpFrXhFGIRItceDeo7P/UFJqIc1jlHKZ2e47VYcB3xYPO/Aw==
X-Received: by 2002:aa7:81cb:0:b0:56e:1092:1272 with SMTP id c11-20020aa781cb000000b0056e10921272mr47510043pfn.31.1669877282581;
        Wed, 30 Nov 2022 22:48:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902f64600b00186a2444a43sm2700228plg.27.2022.11.30.22.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 22:48:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Subject: Re: [PATCH v9] status: modernize git-status "slow untracked files"
 advice
References: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
        <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com>
Date:   Thu, 01 Dec 2022 15:48:00 +0900
In-Reply-To: <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com> (Rudy
        Rigot via GitGitGadget's message of "Wed, 30 Nov 2022 00:52:16 +0000")
Message-ID: <xmqq4juftyan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Rudy Rigot <rudy.rigot@gmail.com>
>
> `git status` can be slow when there are a large number of
> untracked files and directories since Git must search the entire
> worktree to enumerate them.  When it is too slow, Git prints
> advice with the elapsed search time and a suggestion to disable
> the search using the `-uno` option.  This suggestion also carries
> a warning that might scare off some users.
>
> However, these days, `-uno` isn't the only option.  Git can reduce
> the size and time of the untracked file search when the
> `core.untrackedCache` and `core.fsmonitor` features are enabled by
> caching results from previous `git status` invocations.
>
> Therefore, update the `git status` man page to explain the various
> configuration options, and update the advice to provide more
> detail about the current configuration and to refer to the updated
> documentation.
>
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
> ---
>     status: modernize git-status "slow untracked files" advice
>     
>     Here is version 9 for this patch.
>     
>     Changes since v8:
>     
>      * Improved tests.
>      * The untracked files delay measured is now set to always the same
>        value in test cases. That has allowed to remove all sed calls from
>        tests.
>      * Improved documentation.

Looking pretty good (I thought you were going to update the proposed
log message, too, though).  Let's replace and merge it down to 'next'
to cook during the pre-release freeze period.

Thanks.
