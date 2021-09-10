Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B1C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EAD611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhIJMAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJMAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 08:00:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD38C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:58:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f22so1598844qkm.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YuYWBRvYdiG9m3Ot8RxV5Asl9TTR55DuA1RGR6MDfPg=;
        b=ExV9ZY0Y6PV5kswcAJskKeP7uWpAAuTlYoWPV+1+ZLMEzRtUpxK6nZMW8KHdzGp6QG
         sld+17ypFaz/60NPkbMwYry1Ht99ufkghnEXEmLvoiNloOx0ZEsHSK9dahVvs8k1NpH7
         XTAqdKZUlZcHnuHtnhJlby4ibPsXAUTq0D/p/xDThSxYcRT6bSTR0yua/6N/jGRZpzJI
         q/Fmg0aPjetJFZk5BInOnlq0c//BOPKOqCO8e1fDtBoO3a0tF1Q9NShv+/zk2wZMeUNA
         vQeqvnPuWCP6SGA7uzGP76veL4+2+pDPn6d+b6D1jBpkea3UJ06SaN5ZJ6kubpPd6QX6
         YG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YuYWBRvYdiG9m3Ot8RxV5Asl9TTR55DuA1RGR6MDfPg=;
        b=8I8+efj5S4p+Nuf9fphHh41Gfue92MNjwALyR6MZAuJdnEWihXZiOmAnfEvhHOP8Ub
         IGvZrEUpmTxue5U6w5qjeSlD5KthYblH1sIV+6SWdozRr9vbH0+5o2R5Ll6rz+2opjwc
         MIMgYsmuj2XD/axleQ7T0XewNmUxYcLrbHrblRiQf5h28HkrnIuxPm3csfRToC9/GDDY
         sclFPdiwX8pwocrGPybwKj0lg/gzgIv4KuVCttN8ZYNyYXfg5SnFDnzzfI53TB+ErBIh
         1WjS2oWe+piUcviGPxlgO38gYWBmw0OR4Q3gAxZB0i5VvObPa2U8/2oP+o27FpwstnyE
         nmNg==
X-Gm-Message-State: AOAM5328AlyxZ38bNL8ybpwCgnoyyIpo4XcndIf9/Ohw05bfExTdEJOn
        9NcIy09OVHLd0XqmOnS6qRw=
X-Google-Smtp-Source: ABdhPJx8nLHPv6aLyp+hi0IoIA2eaEbDAuJqEkQeSSd+wNkzeh2KEJuaYOVcKIHO1uECOX2usMSFLA==
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr7211752qkl.107.1631275132226;
        Fri, 10 Sep 2021 04:58:52 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y12sm3016697qtj.3.2021.09.10.04.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 04:58:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
 <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
 <nycvar.QRO.7.76.6.2109101245510.59@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9d643b71-922e-5b61-b8d5-55b9c30c07b5@gmail.com>
Date:   Fri, 10 Sep 2021 07:58:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109101245510.59@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2021-09-10 à 06:46, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Thu, 9 Sep 2021, Philippe Blain wrote:
> 
>> Le 2021-09-09 à 06:53, Johannes Schindelin a écrit :
>>>
>>> On Wed, 8 Sep 2021, Philippe Blain wrote:
>>>
>>>> Anyway, I'm not saying that we should not do what this patch is
>>>> proposing, but I think caveats such as that should be documented in the
>>>> commit message, and maybe an audit of other configs that might results
>>>> in behavioural differences should be done.
>>>
>>> Since this is already a bug in the `apply` backend, it would be even
>>> better to follow-up with a fix, hint, hint, nudge, nudge ;-)
>>>
>>
>> I'm not sure I understand what you are saying. The fact that 'rebase'
>> does not pay attention to 'submodule.recurse' is not a bug in my opinion,
>> it's just a limitation of the current code... Or do you mean something else?
> 
> I must have misunderstood you. I thought you were saying that Phillip's
> patch introduces the regression where `submodule.recurse` is no longer
> respected.
> 
> Ciao,
> Dscho
> 

Well it does, but only for the initial checkout of 'onto'. But as I wrote in
[1], I think that half respecting 'submodule.recurse' is confusing UX. So
I would think that it is not *that* bad to keep Phillip's patch as-is in the meantime
i.e. while we wait for 'git rebase --recurse-submodules' to materialize. I think
that it would not be good UI either to have rebase respect 'submodule.recurse',
but not having a --recurse-submodules flag like all other commands that honor
that config.

Thanks,
Philippe.

P.S. I did not CC you in [1], should I have? What's the etiquette around this,
i.e. should I manually add CC's for people involved in "parallel" threads in
addition to everyone I get by doing "reply-all" ?

1. https://lore.kernel.org/git/pull.1034.git.1631108472.gitgitgadget@gmail.com/T/#m182b8d5f24b41c2ff8e919819229974d71258cd9
