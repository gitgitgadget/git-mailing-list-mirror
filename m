Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75FC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiCAT5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbiCAT53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:57:29 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82E75E4B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:56:31 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso506674ooc.7
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q7ZCGmE6cZTbtl04Wmg3yTARmHbnG2ayuhtE9txqtlc=;
        b=e08dp1Ri2VMh5Hg5Pn8poPkLtqxI+BAVqi7KNjyQFJ860DAqpPSVVIfgtMO2+b9pLD
         cc1wO4Mycon6Z1ZT8bOQduHOKC/720rVx93GY7yoYMosYjp4MqRoflnlOD5+j6ekzq/u
         ksg8h3rUKz50yKB7AncCImzdfxejMkRwHIXyyAjO2QBjHDW6/DgM38sIr4Ho4/wAmu0K
         3KgMrLSUj8UD9umg2qIvzULM4MX3f+ZM8LYfZoGASRk1TAQ4Huukb5kUAKaWvnkP3yZA
         vktAYUzAYbeV/JR/gvXC9PD3y2RPAaQqyvTIP39IAQyF/+KYZ9ASPk+qjm/5y0xp1swp
         vEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q7ZCGmE6cZTbtl04Wmg3yTARmHbnG2ayuhtE9txqtlc=;
        b=pdDZU4JFCw7bcZPYDcoH+b+F1l0QlUe3VkNiFJyjFuRdZX5cEDumevozUxNCB+ADUX
         Ekt282+R/S/vFf/xtf3CKF8C3LpCnVW2to9gjXjhOnoT9Cgw0jcLvYbo7Iwg9s2gUeZC
         aTD0DBGBb0OmH1hvXoyNTL2IHJDWB0vU5V1UskALz+CJwSCKCH79x/fpf59/nLQKsSF4
         Pd4BmiLybONXL4MRUx7M6OldrlO0SjOfF5xAXtlmo6f1m582EdvbCBbukzWl28zpQalg
         Tb/cM3TnzlwSAtJ21znO5cB1e8eUTY1LfyOJrFNghE67CTtElmxZ2tQ0NW9wlYhkEoIY
         H95A==
X-Gm-Message-State: AOAM533bdNgKC//PmPYU+M97nnRp+eQQg351U1svizCcLfGWAhbjUh5S
        BMGyfpSK7MzMMF6mPvs87HSd
X-Google-Smtp-Source: ABdhPJwo8/3c/OSY86HOE6QrkRZ7rasWccv3/PLauZPNW7kLmfiNhEgH7PpjpQ6aVXteZlco5PPOuA==
X-Received: by 2002:a05:6870:8322:b0:d3:a3f7:ad88 with SMTP id p34-20020a056870832200b000d3a3f7ad88mr5057148oae.107.1646164591013;
        Tue, 01 Mar 2022 11:56:31 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y6-20020a4a86c6000000b0031bf43a9212sm6588112ooh.11.2022.03.01.11.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:56:30 -0800 (PST)
Message-ID: <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
Date:   Tue, 1 Mar 2022 14:56:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com>
 <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g>
 <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
 <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 2:52 PM, Keller, Jacob E wrote:
> On 3/1/2022 7:09 AM, Derrick Stolee wrote:
>> On 3/1/2022 2:33 AM, Junio C Hamano wrote:
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>
>>>> On Mon, Feb 28, 2022 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>>
>>>>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>>>>
>>>>>> +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
>>>>>> +     test_config -C non-monotonic core.commitGraph false &&
>>>>>> +     (
>>>>>> +             cd non-monotonic &&
>>>>>> +
>>>>>> +             rm -rf .git/info/commit-graph* &&
>>>>>> +
>>>>>> +             echo "main~3 undefined" >expect &&
>>>>>> +             git name-rev --tags main~3 >actual &&
>>>>>> +
>>>>>> +             test_cmp expect actual
>>>>>> +     )
>>>>>> +'
>>>>>
>>>>> I doubt it is wise to "test" that a program does _not_ produce a
>>>>> correct output, or even worse, it produces a particular wrong
>>>>> output.  This test, for example, casts in stone that any future
>>>>> optimization that does not depend on the commit-graph is forever
>>>>> prohibited.
>>>>>
>>>>> Just dropping the test would be fine, I would think.
>>>>
>>>> Stolee mentioned it. We could also convert it to a
>>>> "test_expect_failure" with the expected output too... But that makes
>>>> it look like something we'll fix
>>>
>>> Neither sounds like a good idea anyway.  What we care most is with
>>> commit graph, the algorithm will not be fooled by skewed timestamps.
>>
>> I'm fine with losing this test.
>>
>> I perhaps lean too hard on "tests should document current behavior"
>> so we know when we are changing behavior, and the commit can justify
>> that change. For this one, we are really documenting that we have
>> an optimization that doesn't walk all commits based on the date of
>> the target commit. If we dropped that optimization accidentally,
>> then we have no test so far that verifies that we don't walk the
>> entire commit history with these name-rev queries.
>>
> 
> I think the "tests should document current behavior" is handled by the
> fact that this specific test fails if you revert the name-rev changes
> but keep the test.

Ah, so this _is_ documenting a new behavior that didn't exist
before the series. That is good to include, then. If it was
"just" testing the behavior before this series, then it would
have less reason to exist.

>> If there is value in documenting that optimization, then a
>> comment before the test could describe that the output is not
>> desirable, but it's due to an optimization that we want to keep in
>> place.
>>
>> Thanks,
>> -Stolee
> 
> What about a test which uses something like the trace system to list all
> the commits it checked? I guess that might get a bit messy but that
> could be used to cover the "this optimization is important" and that
> applies to the commit graph implementation rather than keeping a
> negative test of the other implementation.

A trace of the _count_ of visited commits might be effective,
without being too noisy in the trace logs or too fragile to
future updates (only need to change a number if the optimization
changes).

Thanks,
-Stolee
