Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF013C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654E023A57
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbhAUQ7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbhAUQ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 11:59:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB0C061756
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:58:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m1so1754993wrq.12
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ObzTnA63EWqZOEV5WKMne6Z3hKbeHg6IBaKJIaLBJp4=;
        b=OEfZx5kS3bc0QKfJApoofp8OVDgQMRkBD9CtkgEW4G2ZOxTrly5RQwOiyIyI0c8aqr
         jswkSUIJ228Is/neWylIxp/y7hQ+ZMGopR/zrU5KYiPUKzIPGhoBtxidaPIrhOg/4rap
         +Hhuv/fFCqiwIEVf7VSF2wNWLNxeAhogqk0cIU3s7cxY4xrupNxUa1LZHZ1lIdw/3kIe
         AxOS6CXBPig4b3YPMKX1Z9Ds95b6hWVlFEcBqesi/YVL7idbuQ5/+/DKQWK0oP4SkZMN
         v0erYYn75BlDrmi2Otc7uMZOIJ2HqdSzsqeqDCLfQKBz/WOPfrn2sgwPN4FO+Y+aZPg3
         g/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ObzTnA63EWqZOEV5WKMne6Z3hKbeHg6IBaKJIaLBJp4=;
        b=oR30ZmDECIDa1t4/38mMW2fLD5KXu/RgjKz7iKBEMr9siQC6lb3gw0i7hPf7xDX9QD
         5d4jrmzY2WB/nZEimifbX6srcOX0YO2tp0cG+rumbFDdI/cjnys568ZaK3KOdzzYNZW7
         qTd9FP6aik1uYXRMpoeq+rXIM1zOUYuredp2qajNzCwJhNais1lpdeg3epGBag/4Lr04
         9CD4FAwt4L60+rKpqcGLo+jcbxu7HZh2vle7Lrfbrn7jFRnuHMJsiAb45GgEodQWsWmT
         xcAmWvIp/Fo6CmB9LvPBEzeGaMeeFpCf/n1x9kycb/u6Wnpi52ev0q3K/uM0eF4ySyUK
         T1Zg==
X-Gm-Message-State: AOAM5310UgLE51tLAAilLruWP2a+O6uNta3cUp5Ykg+z5KGmj6mRYbXX
        KULJY7ONNu+QX5ezWWB5fUA=
X-Google-Smtp-Source: ABdhPJy+Zk/h1MEGtTyT5HnaFiW6S5suV8jAVNC82a/k4Hv9Ff8CLE7K7VEBhe5XMbdLuuvD8igMLg==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr366842wrw.59.1611248292952;
        Thu, 21 Jan 2021 08:58:12 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id n11sm10554441wra.9.2021.01.21.08.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 08:58:12 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Christian Couder <christian.couder@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210119074102.21598-4-charvi077@gmail.com>
 <xmqqmtx3dq83.fsf@gitster.c.googlers.com>
 <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
 <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3853a4a0-dca4-4d8c-a9da-6608a9385f38@gmail.com>
Date:   Thu, 21 Jan 2021 16:58:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian and Charvi

On 21/01/2021 15:21, Christian Couder wrote:
> On Thu, Jan 21, 2021 at 3:02 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
>>
>> Hi Junio,
>>
>> On Thu, 21 Jan 2021 at 07:08, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Charvi Mendiratta <charvi077@gmail.com> writes:
>>>
>>>> +static size_t subject_length(const char *body)
>>>> +{
>>>> +     size_t i, len = 0;
>>>> +     char c;
>>>> +     int blank_line = 1;
>>>> +     for (i = 0, c = body[i]; c; c = body[++i]) {
>>>> +             if (c == '\n') {
>>>> +                     if (blank_line)
>>>> +                             return len;
>>>> +                     len = i + 1;
>>>> +                     blank_line = 1;
>>>> +             } else if (!isspace(c)) {
>>>> +                     blank_line = 0;
>>>> +             }
>>>> +     }
>>>> +     return blank_line ? len : i;
>>>> +}
>>>
>>> I cannot quite tell what this loop is trying to compute at the first
>>> glance.
>>>
>>
>> Oops, I think Phillip and Christian also pointed in the last revision
>> to look for alternatives to make it easy. I mistook that point and
>> forgot to look at it.
> 
> Yes, please take a look at find_commit_subject() in "commit.c".

That looks like it is taking the commit header and finding the start of 
the message. We have just the message, I think we probably want to use 
format_subject() in pretty.c which does what my hard to follow code does 
with the option to replace newlines in the subject with another character.

Best Wishes

Phillip

>>>> +     grep "extra para" commit >actual &&
>>>
>>> I can tell that you want the "extra para" to still remain, but how
>>> does the grep that is not anchored guarantee that?
>>
>> .. but now I think to remove this `grep -v "squash" commit` as also
>> discussed with Phillip earlier that in this test script we are not
>> checking for the commented commit message.
>>
>>> Perhaps look for
>>>
>>>          grep "^extra para" commit
>>>
>>> to ensure that you are not seeing a commented out but somehow failed
>>> to get stripspaced out?
>>>
>> I am not sure, what does failing to get stripspaced mean?
> 
> I think this refers to:
> 
> https://git-scm.com/docs/git-stripspace
> 
> Best,
> Christian.
> 
