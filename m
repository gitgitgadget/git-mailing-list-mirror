Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C17C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C8B60EB6
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGVWCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhGVWCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:02:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A04DC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:42:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q15so6998483qkm.8
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTBjU7Qau7/0RU4kH/jChsIpeVuH++m2axoce4kpePg=;
        b=A2tqUaRiQK6wrD/i6b+LRyWRRmhjf0P9pm4INNgwm9PWPXVF0Y59s1rg5FF0xiRDju
         TcvgPr+QcslCKKo59j9PIy6pBWs7QEXcspaAicGor0QB2baRZkj3o3SwVKk4Q38NzG07
         Gi6I1Ebcl0uaru35A00lSSn5DkcsQ1WWiZrSClGSP/IDAqJE9JpeyO8k6tNVljZC+yeB
         lMctvc3xMhHalAq14oD1ipI/kRSpX5NzhirQcvVrZwX5+JnpuD5hc6RYCdRxUQ29Bk3N
         NCNDaBmIuw7relFvWek0di1RtzvrmI8d6JkHBGD8XUjLkmciV9+clg80bV7Eg2/U6Hpn
         lL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTBjU7Qau7/0RU4kH/jChsIpeVuH++m2axoce4kpePg=;
        b=OwAG+Jzf6yMdVYK2xNXXJKCt6fey4aCsrbha0Bc0I8Ud1mTJegYxHZA+NUoRy2OsoW
         faA+SsMcPF5yVYa7HMam6VWHVDPDXXBW/WMcV/+RE7yEOmPjNYL1vrDUIlC4N3Msh8Yn
         5p4TeS86j5RWbChjZGgpppt1JOeKvrHp0DDyIn9DtxmdAe8Zfd4MpfOVs3pk53z9c9WW
         VdedqQmNNpdVM1rzHq21alGVL7uDOxL+RX1u5aFtXpqcGqKfRMkDgGbnqkVVr+TiihNl
         rlws6+bd4DFcS+aXFDuplPCGmemNhgd90ST5y7fYNs8LX6KmZn+Kzub8riOA0Y1c+EIS
         WmiQ==
X-Gm-Message-State: AOAM531fjw8SScg2clNV9xK9c5UWFUdP0769owjZCqvKF4uwcuVmyAi7
        c5XPPYCLA8YCXSsaBsOK+cGGl89+/SzjFQ==
X-Google-Smtp-Source: ABdhPJwwcbWbpIRUWHFER4PbzR5u8MVXD7XhbF/8VW9B7EzbYGkt5QrtmlT/BKI8HOGajT7hulFSxA==
X-Received: by 2002:a05:620a:311:: with SMTP id s17mr2094021qkm.266.1626993754965;
        Thu, 22 Jul 2021 15:42:34 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u3sm11042827qtg.16.2021.07.22.15.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 15:42:34 -0700 (PDT)
Subject: Re: 'git range-diff' does not detect submodule changes if
 'diff.submodule=log'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>
References: <e469038c-d78c-cd4b-0214-7094746b9281@gmail.com>
 <nycvar.QRO.7.76.6.2107221516240.55@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <98bdd571-e4f1-a9a5-d7e6-81b1b6c89b45@gmail.com>
Date:   Thu, 22 Jul 2021 18:42:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2107221516240.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2021-07-22 à 09:19, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Mon, 19 Jul 2021, Philippe Blain wrote:
> 
>> I noticed that 'git range-diff' silently "drops" submodule changes if
>> 'diff.submodule=log' is set in the config. This is because the 'diff --git'
>> header is not shown in that case, and the code in range-diff.c::read_patches
>> expects that header to be found to detect changes.
>>
>> If 'diff.submodule' is instead set to 'diff', the range-diff outright errors
>> with
>> (at least in my case):
>>
>> error: git apply: bad git-diff - inconsistent old filename on line 1
>> error: could not parse git header 'diff --git
>> error: path/to/submodule/and/some/file/within
>> '
>> error: could not parse log for '@{u}..@{1}'
>>
>>
>> I think it would make sense to force '--submodule=short' for range-diff,
>> something like:
>>
>> diff --git a/range-diff.c b/range-diff.c
>> index 1a4471fe4c..d74b9c7a55 100644
>> --- a/range-diff.c
>> +++ b/range-diff.c
>> @@ -54,7 +54,7 @@ static int read_patches(const char *range, struct
>> string_list *list,
>>
>>          strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>>                       "--reverse", "--date-order", "--decorate=no",
>> -                    "--no-prefix",
>> +                    "--no-prefix", "--submodule=short",
>>                       /*
>>                        * Choose indicators that are not used anywhere
>>                        * else in diffs, but still look reasonable
>>
>>
>> What do you think ?
> 
> Sure. I never thought that `range-diff` would be useful in the context of
> submodules. But then, I am an anti-fan of submodules anyway, so don't put
> too much stock into my opinion about anything submodule-related.

OK. I'll try to find the time to send a patch for that.

> 
>> P.S. As an aside,
>> I'm  not sure why you chose to skip the 'diff --git' header with
>> '--submodule=log'
>> (I did not search the list), but I think that in general 'git diff' and
>> friends,
>> it would be nice to be able to still see this header even with
>> --submodule=log...
> 
> I don't remember the details. It might be that `git-tbdiff` did it that
> way, and I copied it without questioning.
> 
> *clicketyclick*
> 
> Yep, that seems plausible:
> https://github.com/trast/tbdiff/blob/047d1c79dfada57522a42f307cd4b0ddcb098934/git-tbdiff.py#L48

I meant when you implemented '--submodule=log' back in the days, why did you choose
to skip the 'diff --git' header. In fact I dig up the thread and keeping that header
is something Jens Lehmann actually suggested [1] (near the end of the message).
I for one would find it useful; it's easy to miss submodules changes among a sea of other
changes if the submodule is updated with just a few commits... yet another thing to
add to my list :)

Cheers,

Philippe.

[1] https://lore.kernel.org/git/4AC9D6EB.8090002@web.de/
