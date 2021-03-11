Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39EC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ECD64F15
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCKTXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCKTXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:23:06 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B9C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 11:23:06 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 6so2010871qty.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ap/GF7c06FBtF07207IKW3BVNrPLuSYuOZIN+GWk5Zs=;
        b=X9QSc/3vx50c/MxuDMtayi4oQQpoHBZAn9ilfMiBQm51v7LpFHKzkC/3tgXhulpkX8
         rWhXwgocOld1thW9bDINUqOknwBJGeuRJ4uJBQ46Avi0NM+ktB0QpdUwdeZ2BT3UFn7u
         QqrtfJu9hunwwMVniFRFA0x7aPffEZEZg48dCNKJ9d2lX3WnEjBnYIfdVLHhpdWvO15j
         IvewLhYJb5HOUT6J4Tg46Tp0DZ0ayAnAJgoM+zjxlelKDeTdkpih0alSOa7JfbFcCpCH
         pAFBkOXoGe9NP5UwDeI3tikDbn6jkIC8ldEzyOD0t9LPzHrluA6dRUJLkOEgId1oaKVa
         LLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ap/GF7c06FBtF07207IKW3BVNrPLuSYuOZIN+GWk5Zs=;
        b=DlO9t4ElSDIMj+/qfXqyrXWcF0147s148ofyFWhsTqfq7BuezpS1AWAH84lf70SnD0
         Ex3dL+eXZy2nOJ4FHiVPVMK+Olb4ca98tVExEu6aIGddcWijIDgmM+h+5PR2DNt/gCF8
         A+Nc0glRGwp0XqsZw0JcjZOA0XApbL1brQI8qlBUmIERJVhRWVk6xG4gsKguUkmG/cmM
         HcXdu/NHANXPCMZhCxChT6YGRKB2QVTwkL3AEiKvshye4db+LVGGmchFTRxWAIBAkQdv
         OPCxqQ1u7oO1YMts6hYLY1nZBllTxDo9W+kQ1Lb+IGusL7hkVs29NMmthbzBaqSO9JML
         xwng==
X-Gm-Message-State: AOAM531j/JI18EH14fSVkwhFzyzrARHS4bqWA9dnTn6B2BeNnj5Ied15
        hJI7L8FQhe7b7HSTVwZdeDI=
X-Google-Smtp-Source: ABdhPJwlWBS4wCDp9Y5WPLdHeKm1M8zPnyzdOE8G5SfDvhzJTOGoibodYt4Z9a4wAGrYcwaRitk3kQ==
X-Received: by 2002:ac8:5905:: with SMTP id 5mr8723202qty.129.1615490585449;
        Thu, 11 Mar 2021 11:23:05 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id h67sm2649966qkd.112.2021.03.11.11.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 11:23:05 -0800 (PST)
Subject: Re: What to do with fsmonitor-watchman hook and config-based hooks?
To:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
References: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
Date:   Thu, 11 Mar 2021 14:23:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2021 1:42 PM, Emily Shaffer wrote:
> Hi folks, I grabbed a bunch of CC from 'git blame fsmonitor.c' so
> sorry if you don't care about fsmonitor-watchman anymore... :) Note
> that this whole conversation has to do with the series proposed at
> https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com.
> 
> When I was looking through the remaining hooks in
> Documentation/githooks.txt I noticed that the fsmonitor-watchman hook
> is implemented somewhat differently than most other hooks. As I
> understand it, to use that hook someone needs to:
> 
> 1. Configure core.fsmonitor with a path to some fsmonitor-watchman
> hook. The documentation in 'Documentation/githooks.txt' claims that it
> needs to point to '.git/hooks/fsmonitor-watchman' or
> '.git/hooks/fsmonitor-watchmanv2', but I don't see that constraint
> enforced when the config is read (config.c:git_config_get_fsmonitor()
> and fsmonitor.c:query_fsmonitor()), so it seems that core.fsmonitor
> can point to wherever it wants. (Plus
> 'templates/blt/hooks/fsmonitor-watchman.sample' suggests setting
> 'core.fsmonitor' = '.git/hooks/query-watchman'...)
> 2. Configure core.fsmonitorhookversion to 1 or 2, to indicate the arg
> structure for the executable specified in core.fsmonitor.

This is correct.

> Because the executable doesn't necessarily live in .git/hooks/,
> fsmonitor.c:query_fsmonitor() completely skips the "API" for running
> hooks (run-command.h:run_hook_le()) and just uses
> run-command.h:capture_command() directly.
> 
> Interestingly, this is really similar to the way config-based hooks
> (https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com)
> work - but different enough that I think it may be awkward to
> transition fsmonitor-watchman to work like everything else. So, some
> questions, plus a proposal:

You'll want to get Jeff Hostetler's perspective first, but I'm of
the opinion that we'll want to stop recommending the Watchman hook
when the Git-native FS Monitor feature lands, with some time to
let things release and simmer before we remove the core.fsmonitor
config option. We would also need a Linux implementation, but that
is planned.

If we think that the plan of "eventually, FS Monitor won't use hooks"
is reasonable, then how much do you want to spend time unifying it
with your config-based hooks? Can they live together temporarily?

(Naturally, deprecating FS Monitor through the hook might not be
a reasonable plan.)

Thanks,
-Stolee
