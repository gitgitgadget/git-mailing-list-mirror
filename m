Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F942C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA05610D2
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGUWBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhGUWBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:01:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04668C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:42:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a80so3653724qkg.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TAP46GrSsYcyqXz/3VJGpLBov42P1u62493MEzlQko0=;
        b=KPz/kDGlSXTTybR+X6j5vUNA8yDHbdNn7tPsteZqKcQ8oizaTtZn7Ko8BmBNt3i6lx
         MLrq8HIR6PQd7zvInAVvshjslK4ecOq0nqina0Fw3551wdvHR8aRPJ6Vg6I/4Iot0V4B
         otusPo+7FT+fRlmVCsR87Ye3XmYC6YkFDyM4G1kN/hmjBc5T/mAzYqzWAw7gqDIOV9xw
         3KcJegpwQzNQS2k0vhnJ7GYTNpjbne5RXjCnJ/WSKm4GgSdInB37DwXDFQQzeHpIwqa0
         cAveYNxbPo4bFnpf44Jd0ISxtOmK2U/wnBOEgaprJDkb7oo71xXT/Ys+GRmGXZgy8s7F
         G/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TAP46GrSsYcyqXz/3VJGpLBov42P1u62493MEzlQko0=;
        b=OB+l/rIf2dUNIYURaUJhoZH6QVo+TdnYRqgFYQbqpBFuLs/wlcCQIg5RbpZ6NN7PcH
         pQPVGmH7ZO7bnmeyIU2V3J226PWE2VbUDHjSpv9Iewt3RG1PdCPP+U1XqjJXztB4RGlL
         SNwtgRqI/jruL7RBQUa865nLCa4XkIjFLs40Ylt1SlB6P4oEovRnoIZeqzGE68NJUXfQ
         j+Wp34Drnjww8PMA6I/fOfYPcFWOd4s1HKu+y2CeNCOSIXfu8RdWn8ORzr4IvTrAHneU
         /O5iDFzlA6tf9CK1YUJyINiSladomgZkDi49IJPKpmc0nNyh8oNXIEJv9cqAlZwu0xyx
         nHiw==
X-Gm-Message-State: AOAM530HMHpXVgEX/Bu8kOiqautEBKOM6s7mQGHKhh6OJaslP2HQRa3u
        gihsKyO/f7wK7ayBnz/xYkDJTcAeq356PN8d
X-Google-Smtp-Source: ABdhPJx+OMp9R4c9ol96ZHozf7YUrXUd9ps9CYF8CCJhpRSffVpWEeMywGHAf60ovYLgFs22RYQhZw==
X-Received: by 2002:a37:a8e:: with SMTP id 136mr35835674qkk.498.1626907348934;
        Wed, 21 Jul 2021 15:42:28 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s81sm11638931qka.82.2021.07.21.15.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 15:42:28 -0700 (PDT)
Subject: Re: Why do submodules detach HEAD? (was Re: Incorrect and
 inconsistent End-Of-Line characters in .gitmodules ...)
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Rostislav Krasny <rosti.bsd@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
 <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
 <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9d39da2c-1450-d462-5d80-13112a529c2e@gmail.com>
Date:   Wed, 21 Jul 2021 18:42:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

Le 2021-07-21 à 03:26, Atharva Raykar a écrit :
> On 18-Jul-2021, at 02:52, Rostislav Krasny <rosti.bsd@gmail.com> wrote:
>>
>>
>> [...]
>> I would like to take this opportunity to ask: why cloning a repository
>> that contains submodules sets this repository branch to its default
>> (master, main, whatever) but all submodules are set into a detached
>> HEAD mode instead of their default branches? This is actually the
>> reason I started to check what happens with the .gitmodules file. What
>> is the point in such an inconsistent behavior? There are a lot of
>> questions about that in Google and it seems most of the users expect
>> different behavior.
> 
> Submodules are cloned along with the parent repository only when
> 'submodule.recurse' is set to true, which I assume is the case for
> your configuration.

Correction: no, 'git clone' always needs to be given the '--recurse-submodules' (or its old
alias, '--recursive') for submodules to be cloned. It does *not* honor
'submodule.recurse' (that's documented at [1]).

Should it honor it ?
Some people think yes, but others think no (mostly people that deal with repos with a huge number
of submodules which are optional, and thus would not want *all* submodules to be cloned
even if 'submodule.recurse' is set) . This has been discussed before,
and several tries were done to change that but for now the behaviour remains.
I personnally think that marking some submodules as optional should
be something that can be tracked in '.gitmodules', and a future version of Git
would clone all *non-optional* submodules if 'submodule.recurse' is set (some think
it should do so even if it's not set.) The most recent discussion about that, I think,
it at [2].

> 
> -- 8< --
> 
> I hope that makes sense.
> 
> (Anyone more knowledgeable than me in submodules, feel free to add
> to what I am saying and correct me if I made an error!)
> 

The rest of what you wrote is perfectly clear and correct.
Keep up the good work on your GSOC project ! :)


Cheers,

Philippe.

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-submodulerecurse
[2] https://lore.kernel.org/git/0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com/

