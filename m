Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DAFC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F93C60F3A
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhGaS3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaS3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 14:29:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD039C0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 11:29:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g11so8875347qts.11
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lN/yluzoDBtagAsBB3VflgpbufCumjBwMkfOXpkRi9o=;
        b=FSQGSnP1cyxb/alv9kWtTH9m2/hBDLHtZPZj1C0yEYfusFGH3hu9S9ejU1NCmxQ+gV
         HX7IUWM44EB3kgQpMxk4JDxHXq30UzZeZIYQotIBQL+IV+RIiQHUorL8NyQ8v9/B0SQc
         vFQG2PBuJ/ExTq/+PLoHvJ52LVzLB8qaXDwUSD5Yrh6Ay1wRuJNjKrv2OY76b5ZG2bgd
         Eov1suG//RrT74hMJkViXd8LyyHuKckjpf1zo/R3zs5FhaJ8Vajc1xLZdlo6jAjRCD2k
         ugRmymTDxKnP8UYK9nCPanmiCzOvgznvsrrCeHDzBgE0ooNG5PDleT2sBN3ESiyYecNF
         JctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lN/yluzoDBtagAsBB3VflgpbufCumjBwMkfOXpkRi9o=;
        b=NbMEyhyNY9ZPv+R+OrEk5+1bcDKJUCVnl8pRAM7BcgtdSoboRgi57aqYHvosRBtkGv
         j+YrQ/9UhvunngKO8fBLzYSEZ/HKYLyqEAAKCP+WxBVk4UCZrrYQb7H/9LIKgJt/aS9j
         6fXoieBb7cYqbIppFOl50MvdQYiw89Y7IXdhYHXhLOHvqcxqFCfxV2OOtINXijhxcttw
         S7LqB/MkkGWYcrDMil1JS7MPlTyPyYciV2Bo0wqEzWkdgwbJN7VcDa79j6U+Twh1BZFD
         oPbNvL/Cg5YbLpKZhO8uSc8LH2aXGri4eV/zmjeAWHRS6wbgt3AWCNaOHFRk3+pabYfz
         qldQ==
X-Gm-Message-State: AOAM531RvlaYImj3JFCGxq+ZO/0Jka147Axsrye+cZuceFmI4Dz+ONyl
        Dqcb5N157p2Q37RFDCujKZM=
X-Google-Smtp-Source: ABdhPJwTNHSlPwsQmUHOzLcisucetvEnQFLpeYnvikzIWFKbX+ZmHEyjdB+lDQzB4+Y8/JzBsFp5GA==
X-Received: by 2002:ac8:5ac6:: with SMTP id d6mr7574482qtd.261.1627756176545;
        Sat, 31 Jul 2021 11:29:36 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d25sm2273726qtq.55.2021.07.31.11.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 11:29:35 -0700 (PDT)
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
To:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        avarab@gmail.com, Emily Shaffer <emilyshaffer@google.com>
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ee679a57-0851-962d-a63a-6a0bdba35b2e@gmail.com>
Date:   Sat, 31 Jul 2021 14:29:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

Le 2021-07-25 à 08:22, Atharva Raykar a écrit :
> Hello all,
> 
> Week 10 of my Git blog can be found here:
> https://atharvaraykar.me/gitnotes/week10
> 
> As for the "survey part", jump to the section here:
> https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow
> 
> ...feel free to reply in this thread.
> 

Quoting your "survey" questions:

> What tools, systems and workflows do you find valuable in your
> day-to-day work? In particular I’d be happy getting insights like:
> 
> * Any strategy or approach to work, kind of like the example I quoted
>   above
> * Any scripts and tools that assist you
> * Opinionated handling of multiple in-flight series and methods to
>   approaching reviews
> * Atharva, you are overthinking this! I just use a straightforward {
>   editor + MUA + git } stack and go with the flow!

I'm a small-time contributor, but I do read the mailing list regularly.

As such, I'm not subscribed to the list; I read it on lore.kernel.org
or public-inbox.org (nicer colors!). The UI of public-inbox is very clear
with respect to threading, and the front page also lists messages in
a way that it is easy to quickly see what's new.

When I want to reply to a message that I read on the list, I import it
into a "Git mailing list" IMAP folder in my Gmail account so that I can answer
using my mail client (Thunderbird for now since Apple Mail has been reliably
crashing at launch for the last months) and quote relevant parts of the message.

To import a thread from the mailing list I use a combination of the excellent
'b4' tool, developed by the kernel community [1], and 'git imap-send'. It's
basically this:

$ git config --get alias.ml-imap
!f() { b4 mbox -o- $1 | git imap-send; }; f

This sometimes does not work if some messages in the thread were not created
using  'git format-patch', since 'git imap-send' expects the "From", "Date"
and "Subject" headers in a certain order. So I created a small Python script,
'git in', for this case [2].

For small and simple reviews, I also simply import the patches into Thunderbird
and reply inline. If I want to do a more in-depth review and browse the code as
modified by a series, I fetch the contributor's branch and take a look locally.
More often than not though people do not provide a 'git fetch'-ready link in their
cover letter. So in that case I use 'b4 am' [1] to fetch the latest version of a series
and apply it locally. Before 'b4' was created I used 'git pw' [3], a command line
client for Patchwork, and the Git patchwork instance at [4], but these days I prefer
'b4' as it's more closely integrated with public-inbox.

For my own contribution I use Gitgitgdaget [5], it handles almost everything needed
for git.git contributions:  keeping track of the CC list for
me, updating the re-roll count,  adding the In-Reply-To header such that subsequent
versions of the series are sent as a response to the cover letter of the previous version,
generating a range-diff against the previous version, providing a 'git fetch'-ready tag,
commenting on the PR when the series is mentioned in Junio's "What's cooking", etc.

Some things it does not support are: sending a patch as a response to some random
mail on the list, which is sometimes useful, reading the commit notes to generate
in-patch commentaries [6], customizing the diff generated by 'format-patch'.
Other things are listed at [7].

Recently I've also been using only the terminal with Gitgitgadget:
I use 'git branch --edit-description' to write my cover letter,
and then use the 'gh' GitHub CLI [8] to open my PR:

$ git config --get-regexp alias.desc*
alias.desc-title !git config branch.$(git branch --show-current).description | head -1
alias.desc-body !git config branch.$(git branch --show-current).description | tail -n+3
$ gh pr create --title "$(git desc-title)" --body "$(git desc-body)" --head phil-blain:$(git branch --show-current)

I hope this provides a different perspective!

Cheers,
Philippe.


[1] https://pypi.org/project/b4/
[2] https://gist.github.com/phil-blain/d350e91959efa6e7afce60e74bf7e4a8
[3] https://patchwork.readthedocs.io/projects/git-pw/en/latest/usage/
[4] https://patchwork.kernel.org/project/git/list/
[5] https://gitgitgadget.github.io/
[6] https://github.com/gitgitgadget/gitgitgadget/issues/173
[7] https://github.com/gitgitgadget/gitgitgadget/issues
[8] https://cli.github.com/
