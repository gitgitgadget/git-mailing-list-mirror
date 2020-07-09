Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FFC433E2
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FD620720
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjyjF1c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGIXpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIXpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:45:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6FBC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 16:45:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so1789254qvb.9
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tfdTkZZjXK9/jTRKh28CzkCNERO/E8dF0Cq/dTNrn/Y=;
        b=KjyjF1c31+r8L1UUVC2uEgtMMbSPzIBe4BVqHapt15L3wej84gdMWz75bw2tpORP0m
         Kqlnrjy5fSx1eB/ORHbPOnu9A5yYPCAkbMre9aUcY0v4wb0nAa5otTd7Ke+YqvGZL2uv
         svh3RfcTdhu2bVjrmJw/Nikp4vBPq6wEC9USqU+epFyGxPAzlBNOcVp4OfWMcLoNR6ga
         4eUSMflBpL1Te1J9OMSGRiJIvzinMRgC8x+hreQ7iUaDyINiiRn2Gj4SDoO01KV+Hr+e
         ar2Nfdi3iZnjwAPE/0OgRh4ovjJXqvahdClXdANo9dvkKXvqo4ZT26bZl4nYTteKJgFf
         nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tfdTkZZjXK9/jTRKh28CzkCNERO/E8dF0Cq/dTNrn/Y=;
        b=RpvuEJxzz9TtBNLp2cQfTd4GsUm9I7ffQWXxwd2pGyX1r1rNES5+xSqVqhtcylhqkf
         PDkjcuX5OfrFSq/IVcq/scyyEWybx9XFeRL09Rvi7YGw7gn9DNzJL3sWe8GyZHeahqgm
         8WQVfMOI+kQRR93JiNH9nlL4z4NYMzgRZQh/sRSDi34Iuqpbam0XoiH8aLyBgcX8W3nx
         ulRfO7Z8Oiq8NM7ZewxYlXSSxkBdQL5A5kq5dGwYdnqq/8eTBacATWnI+xpATYcX3gAL
         48AMFn1YjAZQH4TDRcvmRTycORzBkeYw4D8XiyOhehyso48FD4DwNQDc9RW/fT2KyyFY
         Pbbg==
X-Gm-Message-State: AOAM530sTJ7xkK0K9dhwAmQRrpSCKE1uPILFE++KpAdhsOURDCVHadNA
        IIyXWycA2aYuedHQ21kcqAY=
X-Google-Smtp-Source: ABdhPJyCRkz71lZ9Y0x9uEgTy21GdKMddNI8KQ5+jTkjlL1BpvtGgsOCw5He6seNOh1zzTwUUCQWFA==
X-Received: by 2002:a0c:be08:: with SMTP id k8mr66120168qvg.123.1594338348350;
        Thu, 09 Jul 2020 16:45:48 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b22sm5196077qka.43.2020.07.09.16.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 16:45:47 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
 <20200709231624.GE664420@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28c72d69-f524-7c4f-4cc3-847ca91cad33@gmail.com>
Date:   Thu, 9 Jul 2020 19:45:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709231624.GE664420@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 7:16 PM, Jeff King wrote:
> On Thu, Jul 09, 2020 at 08:43:48AM -0400, Derrick Stolee wrote:
> 
>>>> Is it infeasible to ask for 'git maintenance' to learn something like
>>>> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
>>>> config like "maintenance.targetRepo = /<path-to-repo>"?
>>
>> Sorry that I missed this comment on my first reply.
>>
>> The intention is that this cron entry will be simpler after I follow up
>> with the "background" part of maintenance. The idea is to use global
>> or system config to register a list of repositories that want background
>> maintenance and have cron execute something like "git maintenance run --all-repos"
>> to span "git -C <repo> maintenance run --scheduled" for all repos in
>> the config.
>>
>> For now, this manual setup does end up a bit cluttered if you have a
>> lot of repos to maintain.
> 
> I think it might be useful to have a general command to run a subcommand
> in a bunch of repositories. Something like:
> 
>   git for-each-repo --recurse /path/to/repos git maintenance ...
> 
> which would root around in /path/to/repos for any git-dirs and run "git
> --git-dir=$GIT_DIR maintenance ..." on each of them.
> 
> And/or:
> 
>   git for-each-repo --config maintenance.repos git maintenance ...
> 
> which would pull the set of repos from the named config variable instead
> of looking around the filesystem.

Yes! This! That's a good way to make something generic that solves
the problem at hand, but might also have other applications! Most
excellent.

> You could use either as a one-liner in the crontab (depending on which
> is easier with your repo layout).

The hope is that we can have such a clean layout. I'm particularly
fond of the config option because users may want to opt-in to
background maintenance only on some repos, even if they put them
in a consistent location.

In the _far_ future, we might even want to add a repo to this
"maintenance.repos" list during 'git init' and 'git clone' so
this is automatic. It then becomes opt-out at that point, which
is why I saw the _far, far_ future.

Thanks,
-Stolee
