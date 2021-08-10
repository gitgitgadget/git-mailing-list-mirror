Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D18C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EA161008
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhHJXFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhHJXFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 19:05:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2CC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:04:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s132so259759qke.9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LoB+WKPaWrwZBNiPWUjk7KMBBoq8fq+x+1GWiDzTaJI=;
        b=CmAu7zFQWMOp7QRPDnO9oCLDZ3QK9GpsgMHC3zBTr/xRoBSab5dPZG+inZpxGUd9qT
         5l4sSeASk/jJk+U25SjXs6EfgHCPIHA/4AMsZruFIeJYejmWOWDY9BvLphZPZIGmqLSZ
         0qKmCMH4Dhhqt8ts5YOsiKZlkP/x7geSv7t0dSvTEwwlCCBaLXBviBcI5bSTxbAxNQiL
         sljBN5ZCSMMID3hJTB3uhFtrYYRTF3zq2UuEAiIrrWI/nho1SH7aFITnpFf2/N2aPmIF
         KvPtL74VtwMp7HIeD2ckukkZwvkjtQ1iKPMwh/m+SJpoitQNK+E0ZAFN13PU18cw3vpg
         2b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LoB+WKPaWrwZBNiPWUjk7KMBBoq8fq+x+1GWiDzTaJI=;
        b=NknHBGBXu/zr8Vr0uZiG4TntUHpcm4AgihHze1oTML+UI6ssaRW0r5vKwiagJ4CJzo
         Y/Rzu5ubvptDZUdFtMvdUTMX8kcBNJD+LBXLVJ43R2HrRTogugTZSgrDAnWiyzjmH/OK
         gVxeT1CRqcJm3e9wxND0Y+bk7SBSep+uc24h7JvboTuSQcKBLt1P5Uuj/t55xd3X2L8X
         hYg0egrCxQ/q12f0mOh1GMHpk9B+RQ4xcS4OSV7xesYJPAMAMtEm2KEcrxxClxTS0JT4
         z2lx39CFL+LwVhf+bEN/a/shGUqleAdLNsCuk/tffYnKgeyPIFSqSuy7h4Mk2iWagEd1
         Alig==
X-Gm-Message-State: AOAM533x45mXMlLGqmaiHFn/hbtSfvly28Ffizp8WDfX9X7ue5g66yPk
        /LDFRYTfpFmM7doC/7oJ/nE=
X-Google-Smtp-Source: ABdhPJwpj+br0mPtGwlqJo7B5BgnycQpuUG7fz6EEFs2005e5U81hkzfbj5Gb1zjb06AuO0fkDDv6Q==
X-Received: by 2002:a37:e303:: with SMTP id y3mr31232525qki.45.1628636694035;
        Tue, 10 Aug 2021 16:04:54 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id c14sm6541504qtp.83.2021.08.10.16.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 16:04:53 -0700 (PDT)
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using
 --recurse-submodule
To:     Junio C Hamano <gitster@pobox.com>,
        Mahi Kolla <mahikolla@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
 <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <xmqqzgtqe2w6.fsf@gitster.g>
 <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
 <xmqqa6lpdu4z.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8f24d532-b021-2a96-415b-467f715cb1ec@gmail.com>
Date:   Tue, 10 Aug 2021 19:04:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6lpdu4z.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-08-10 à 14:36, Junio C Hamano a écrit :
> Mahi Kolla <mahikolla@google.com> writes:
> 
>>> Is it possible to avoid changing the behaviour unconditionally and
>>> potentially breaking existing users by making it an opt-in feature,
>>> e.g. "git clone --recurse-submodules" would work as the current
>>> users would expect, while "git clone --recurse-submodules=sticky"
>>> would set submodule.recurse to true, or something?
>>
>> As mentioned, the `submodule.recurse=true` will only apply to active
>> submodules specified by the user. Setting this config value when the
>> user runs their initial `git clone` minimizes the number of times a
>> developer must use the `--recurse-submodule` option on other commands.
>>
>> However, this is a behavior change that may be surprising for
>> developers. To ensure a smooth rollout and easy adoption, I think
>> adding a message using an `advice.*` config setting would be useful.
> 
> It may be better than nothing, but that still is a unilateral
> behaviour change.  Can't we come up with a way to make it an opt-in
> feature?  I've already suggested to allow the "--recurse-submodules"
> option of "git clone" to take an optional parameter (e.g. "sticky")
> so that the user can request configuration variable to be set, but
> you seem to be ignoring or skirting it.  

The '--recures-submodule' option in 'git clone' already takes an optional
argument, which is a pathspec and if given, only submodules matching the given
pathspec will be initialized (as opposed to all submodules if the flag is given without
an argument). So, it does not seem to be possible to use this
flag as a way to also set 'submodule.recurse'.

When Emily (CC'ed) sent her roadmap for submodule enhancements in [1], the enhancement
that Mahi is suggesting was explicitely mentioned:

> - git clone 
...
> What doesn't already work:
>
>    * --recurse-submodules should turn on submodule.recurse=true

I don't know if Mahi is part of this effort or just came up with the same idea,
but in any case maybe Emily would be able to add more justification for this change.

> Even though I am not
> married to the "give optional parameter to --recurse-submodules"
> design, unconditionally setting the variable, with or without advice
> or warning, is a regression we'd want to avoid.
> 

In my opinion, it would not be a regression; it would a behaviour change that
would be a *vast improvement* for the majority of projects that use submodules, at
least those that use non-optional submodules (which, I believe, is the vast majority
of projects that use submodules, judging by what I've read on the web over the past 3
years of my interest in the subject.)

As soon as you use submodules in a non-optional way, you really *want* submodule.recurse=true,
because if not:

1. 'git checkout' does not recursively check out your submodules, which probably breaks your build.
    You have to remember to always run 'git checkout --recurse-submodules' or run 'git submdule update'
    after each checkout, and teach your team to do the same.
2. 'git pull' fetches submodules commits, but does not recursively check out your submodules,
    which also probably breaks your build. You have to remember to always run 'git pull --recurse-submodules',
    or run 'git submodule update' after each pull, and also teach your team to do so.
3. If you forget to do 1. or 2., and then use 'git commit -am "some message" (as a lot
    of Git beginners unfortunately do), you regress the submodule commit, creating a lot
    of problems down the line.

These are the main reasons that I think Git should recurse by default. Setting 'submodule.recurse'
also brings other niceties, like 'git grep' recursing into submodules.

If we can agree that the behaviour *should* change eventually, then at least
'git clone --recurse-submodules' could be changed *right now* to suggest setting
'submodule.recurse' using the advice API, and stating that this will be the default
some day.

Even if we don't agree that the behaviour should enventually change, I think
having this advice would be a strict improvement because
it would help user discover the setting, which would already go a long way.

Thanks,

Philippe.


[1] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
