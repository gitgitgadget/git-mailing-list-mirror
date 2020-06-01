Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8FC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E47D2065C
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC1zMWD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgFAKg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 06:36:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06EC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 03:36:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j198so11769756wmj.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U6Lg2y+k0ZpQm1I8qreT3K0Xia6zKVlnBgoFJ1SzvEs=;
        b=KC1zMWD6nQDx2kQ2Zgez0hFad//nteeV4EfZDelj6h67APuQCydaiEVt87zJeTGQfF
         48Ziwa87rY09U/8yFlWsk3rxR7MDpbKk85oT6WMMu1u8FUb4EKdakgRSpVSIS3+L2KF8
         0kJKcpaQ5MoykEVFAtLL7/XLb2yDYZ3ibpcWw7VutFRLF7nfgmFd5pyDM+6hdPtxkJQC
         87nxWOO4Gm7MvLQ9oUxbfNF9Stpw7ufVOHpzbY9yMImbQKyBSKuz1UnvlTYZ3a1+kdJ/
         XiQQhEKknlGT4Aw9cH6QcFWV3TuYiov7SxceEA7IZk7R4fPLkENN12oC8mWY5YcMIAMx
         SXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U6Lg2y+k0ZpQm1I8qreT3K0Xia6zKVlnBgoFJ1SzvEs=;
        b=FmI0wCw+HMFJ8BlM5IcZL5ryRSvcxbsFbC74pTmdbw1nVSiE4B7Fp0QmA6pqPZfN3C
         3MzMK6gyJTbuEbxQCX+CTWtN8jMA2dxfeTX1UyAer271p9ZTr9eCIzzWIyQKwBD0HEDM
         RpctzULuzfSFfIS6thNxfa4gIQo83y96LJC6RPkt9AxCFiNa/uILjbjnhFJJnmubYOky
         9X7AjPVocz27hSqDAM0NdLXz+t8JOqQ1H33Qp6PuwgvnaFYbJCbXKDIadmNmoXqO9ByW
         tByyEZegUViaGCn3Us5rN9jms5COZzgSX1VgsJTWISp/w41L4lNxbbMQP37favsdW3oi
         ac6A==
X-Gm-Message-State: AOAM532bUcWAvtPU55IwYfRnV9tPh6TrQ7r8FAy1J/D3DvCIWCoqUxe4
        mZ0JlA6IkoK2QoPMMMnkaJayZxh6
X-Google-Smtp-Source: ABdhPJxjde0In9WGAVTswqBoEBLRubXnTkiT1BLI09pqnCOMHbIy1tr0UyG1+tGR4KEsdA16VsKqDA==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr20447417wmh.1.1591007781827;
        Mon, 01 Jun 2020 03:36:21 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id w15sm10646336wmk.30.2020.06.01.03.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 03:36:21 -0700 (PDT)
Subject: Re: [PATCH v4 6/5] fixup! rebase: add --reset-author-date
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200527173356.47364-6-phillip.wood123@gmail.com>
 <20200527175748.54468-1-phillip.wood123@gmail.com>
 <20200528131701.GD1983@danh.dev>
 <nycvar.QRO.7.76.6.2005290456190.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b2c24c50-3e07-55d8-52f7-4573292f6695@gmail.com>
Date:   Mon, 1 Jun 2020 11:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2005290456190.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho and Danh

On 29/05/2020 03:59, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 28 May 2020, Đoàn Trần Công Danh wrote:
> 
>> On 2020-05-27 18:57:48+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Sorry I somehow forgot to commit this before sending the v4 patches,
>>> it fixes up the final patch
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>  t/t3436-rebase-more-options.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>>> index 5ee193f333..ecfd68397f 100755
>>> --- a/t/t3436-rebase-more-options.sh
>>> +++ b/t/t3436-rebase-more-options.sh
>>> @@ -196,7 +196,7 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
>>>  	git rebase --apply --ignore-date HEAD^ &&
>>>  	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
>>>  	git rebase -m --ignore-date HEAD^ &&
>>> -	git log -2 --pretty="format:%ai" >authortime &&
>>> +	git log -2 --pretty=%ai >authortime &&
>>>  	grep "+0000" authortime >output &&
>>>  	test_line_count = 2 output
>>>  '
>>
>> This version addressed all of my concerns, LGTM.
>>
>> Only the last
>>
>> 	test_line_count = 2 output
>>
>> puzzled me at first.
>> Since it's the only usage of test_line_count in this version
>> Turn out, it's equivalence with:
>> -----------8<-----------
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> index ecfd68397f..abe9af4d8c 100755
>> --- a/t/t3436-rebase-more-options.sh
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -197,8 +197,7 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
>>  	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
>>  	git rebase -m --ignore-date HEAD^ &&
>>  	git log -2 --pretty=%ai >authortime &&
>> -	grep "+0000" authortime >output &&
>> -	test_line_count = 2 output
>> +	! grep -v "+0000" authortime
>>  '
>>
>>  # This must be the last test in this file
>> ------>8------
> 
> Good suggestion!

Yes thanks Danh I'll update with that

> I've read through all 5 patches, and rather than repeating much of what I
> said about 1/5 and 2/5 in 4/5, I'll just say it here that it applies
> there, too: less repetitions in the test script,

I'll look at adding a helper for to do the checks

> and I'd prefer the layer
> where the `apply` vs `merge` options are set to be `cmd__rebase()` rather
> than `run_am()` (and `get_replay_opts()`).

Yeah that would make it nicer.

> All in all, it was a pleasant read.

Thanks for your comments on this series

Phillip

> Thanks,
> Dscho
> 

