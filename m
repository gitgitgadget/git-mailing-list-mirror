Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A4DC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbiCGWo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbiCGWo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:44:26 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333A3F30B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:43:30 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w1so14658870qtj.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cHchdDx8WFXDcIs6QALU7HfS39R7eZ26/XsfEV5nGt4=;
        b=f30NjE5ojfKlmme5PkkV2y0iuu0s+Dh/cF/IIXqO/mDSXmKGAirr7wWzzngK8Zc7Kf
         lwdeCjS03rUxB2IkGUVaRwrXdjCmHyIjdCHXDISkJYL9s4GV+5beNzd+s8k2Iyt3JAQY
         m7WB+mloZBCV1wKyKvqHbMyw8EAyahS/5Kts40mPSco3M3NDS7EYIsdUMhdthA99IhXE
         6CNFvI2sfRCs1KcRhBOXUuHDv6eZeXwoUAPKJM7h3RLPAEWMLFQVgtVZxBU7qeYnaNKL
         DGgVXDxoCN/aHEvl/WAnZTJWk7iv/u2Hso3F2AJmSBhisvEXHjKi8sBEH47leTfhwcxe
         yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cHchdDx8WFXDcIs6QALU7HfS39R7eZ26/XsfEV5nGt4=;
        b=cGE2v21i2NXeBIDL/dunsjWWbAcX6WityxNoJD5FY8TKpPZF4IvF9V6zt9OQwPS++c
         qpxZibLgutF410hY8CoWPzfA4ZxzOP73fXCoeNEq4kWemrudDHuQm0mkbjrysmK14kHq
         0fLb14AGmNPoDhySDzjacEAowWiCFcjDEfM/ErhmMneA4fuvMHvRoyvzZkvO+bbZ/7lM
         ny3dd2jY1O+ZxDXjgF6UhcG13fk3ztkeu5mfuHRZkLNlLEjs97OFdVFvIFlnSAItpZO/
         BEbdxP4siVrSLjj6IT/2oD/Z1l7BOsbzVFx8Kw5W6THSyNO1ASBCJnDkq6WsxGui6zf7
         cz8w==
X-Gm-Message-State: AOAM5307XO9WfxPAZFOH8ksEWovYnb0Im+srBkDD+2PgWwt+jYpnK4wk
        6FRZVR67Vy7+31we7yPSsorp
X-Google-Smtp-Source: ABdhPJyuxE+bZF2pZjqo2BuvnZAs390DkZQIAVSBYq6kizcnlro14M3kkRf4cgvD6Iph/nmXC+spzA==
X-Received: by 2002:ac8:7d56:0:b0:2e0:6591:2bbb with SMTP id h22-20020ac87d56000000b002e065912bbbmr6251569qtb.505.1646693010142;
        Mon, 07 Mar 2022 14:43:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w9-20020ac87e89000000b002e039503dc7sm9370367qtj.18.2022.03.07.14.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 14:43:29 -0800 (PST)
Message-ID: <a2117554-9cc9-f7b5-3afb-a9845360bfd1@github.com>
Date:   Mon, 7 Mar 2022 17:43:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com>
 <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g>
 <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
 <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
 <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
 <xmqqfso1pgmv.fsf@gitster.g>
 <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
 <xmqqilsvet82.fsf@gitster.g>
 <CA+P7+xo=UwUQ422o36_8XGNWoYjROGi5wBT4=jy4ThJBs_z=Xw@mail.gmail.com>
 <39f08f98-be0f-bba7-c41a-1c9eb6182a67@github.com>
 <CO1PR11MB508949A91933E83A6BE1194FD6089@CO1PR11MB5089.namprd11.prod.outlook.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CO1PR11MB508949A91933E83A6BE1194FD6089@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 5:30 PM, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Derrick Stolee <derrickstolee@github.com>
>> Sent: Monday, March 07, 2022 12:27 PM
>> To: Jacob Keller <jacob.keller@gmail.com>; Junio C Hamano
>> <gitster@pobox.com>
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Git mailing list
>> <git@vger.kernel.org>
>> Subject: Re: [PATCH] name-rev: use generation numbers if available
>>
>> On 3/7/2022 3:22 PM, Jacob Keller wrote:
>>> On Wed, Mar 2, 2022 at 5:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>>>>> I will also look at adding a test which performs a count of which
>>>>> revisions get inspected and makes sure that we actually are doing
>>>>> the optimization.
>>>>
>>>> Sounds like a sensible thing to do.
>>>>
>>>> In any case, in the current patch, #2 is not working in
>>>> linux-TEST-vars job at CI.  You can visit this URL
>>>>
>>>>
>> https://github.com/git/git/runs/5400048732?check_suite_focus=true#step:4:680
>> 62
>>>>
>>>> while logged into your GitHub account for details.
>>>
>>> Looks like this job sets all the TEST variables including
>>> GIT_TEST_COMMIT_GRAPH=1? The negative test passes because the commit
>>> graph is enforced on and we then succeed even though we were trying to
>>> test the negative case.
>>>
>>> I'm going to remove that test in v3 anyways, so I don't think it is a
>>> big deal. However, I wonder is there some way to mark a test as
>>> explicitely "don't run if GIT_TEST_COMMIT_GRAPH is set"?
>>
>> Typically, we try to keep them compatible in both cases. However,
>> you can set GIT_TEST_COMMIT_GRAPH=0 for the test, if you want. Be
>> careful to only change it locally to the single test, not "globally"
>> to the full test script.
>>
>> Thanks,
>> -Stolee
> 
> Ok. The problem is that specific test does not behave the same. In fact it *cannot* behave the same because we're trying to test the non-commit-graph flow there. Since i'm dropping it in v3 I won't worry too much about it.

You could disable _parsing_ the commit-graph in the necessary
Git command with "-c core.commitGraph=false".

Thanks,
-Stolee
