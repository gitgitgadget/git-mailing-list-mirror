Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF8C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiCGU1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiCGU1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:27:30 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDB77AAF
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:26:36 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o64so3079799oib.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pwGVFiYJTpnxWS65Ut6QYWMcUnnZPMvXR0a/04wJ5jk=;
        b=A2O6rvmrNTW3G1LyfcdKcXdScYsGyPz77WzmONo0PC4rk5/SoGUooirs7dADJW4gFe
         IThkjMhdSZvnXgMZLeVX9tSJXgOvl7ACIMix2JQkIvtUqpwu2Z/g+Qd+nL6jLd8qm2Kq
         G6PsHgsL+Zbadcq+TuvkXFTWVpKccgI1Eg2eKp+O54FvLLCd4kI1MS9Bbt+InMlB+Gco
         oidtxbf1dLfGhuSaOHwShFzdK6I3oPHGlGpK0rZPer/WNbQ7uGFN+XyeWFwrrAbC9FnM
         AwZHukBDFKgGqiFZY2t/2IwyMe0TfnkIRa8aFgEwqmID4TgQLNg/vXR78cyykMCeyKRy
         e7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pwGVFiYJTpnxWS65Ut6QYWMcUnnZPMvXR0a/04wJ5jk=;
        b=tkYpM9zVQZQLD80kex2yLWyhl+w9ST1EoB48ikZUuucgqLzcldmccL8WmpfQKCncK7
         az3O9PrqnygWjP++An/QgGk2VXIBeVLrfS+TBZwvj6htUcdTB77k5WU5YDFYxvVxnhHN
         DmXGa1GFd/bU9z/dmRKqZjgb0ie5Y8QszwRMMnEqWREJyxvG2EY29WCXRLODiuAlfe0o
         g18bDh8XgtDDCCPGooVaMg4wg36M73zj/R1XT3ZX/rc/77PM2eo9eiEFJNOmEncgeajt
         FcEqEWLfoq4BG392NyRA2/4tSz7VN82j/Ai66mAN/fUwbl2jpRurjvi9HlSkd/ceu4h2
         1NIg==
X-Gm-Message-State: AOAM5320yFMqXBMkuB7vbMHQuZ3NR9hNWuTAyN0RwQY1pRpdu8NRIMUF
        0U698q8ocViTJnGvVXW8zA+a0bEXhv+t
X-Google-Smtp-Source: ABdhPJxkhpN1J5Zv0RY02HOL+EAy68SfAhyVPdd5ON7OqXs1pvhd4nBSv4nmDyKXFSO8M8ofZz4Chw==
X-Received: by 2002:a05:6808:114d:b0:2d9:a03e:94a2 with SMTP id u13-20020a056808114d00b002d9a03e94a2mr497940oiu.12.1646684795405;
        Mon, 07 Mar 2022 12:26:35 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id az10-20020a056808164a00b002d9c98e551bsm2210902oib.36.2022.03.07.12.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 12:26:34 -0800 (PST)
Message-ID: <39f08f98-be0f-bba7-c41a-1c9eb6182a67@github.com>
Date:   Mon, 7 Mar 2022 15:26:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
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
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CA+P7+xo=UwUQ422o36_8XGNWoYjROGi5wBT4=jy4ThJBs_z=Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 3:22 PM, Jacob Keller wrote:
> On Wed, Mar 2, 2022 at 5:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>>
>>> Let's clarify. There are two versions of the test in this version:
>>>
>>> 1) test which enables commit graph and tests that it does the right behavior.
>>>
>>> 2) test which removes commit graph and tests that it behaves the old way.
>>>
>>>
>>> test (1) checks the flow with the commit graph enabled, and verifies that with a commit graph the new behavior is used. This test will fail if you revert the name-rev commit-graph support.
>>>
>>> test (2) always performs the way we don't like. (since we disable the commit graph and the new flow doesn't kick in) This is the test I think I will eliminate in the next revision.
>>>
>>>
>>> I will remove the 2nd test, since the first test covers the change
>>> in behavior just fine, and I think I agree we don't need to set
>>> in-stone the implementation without commit graph.
>>>
>>> I will also look at adding a test which performs a count of which
>>> revisions get inspected and makes sure that we actually are doing
>>> the optimization.
>>
>> Sounds like a sensible thing to do.
>>
>> In any case, in the current patch, #2 is not working in
>> linux-TEST-vars job at CI.  You can visit this URL
>>
>> https://github.com/git/git/runs/5400048732?check_suite_focus=true#step:4:68062
>>
>> while logged into your GitHub account for details.
> 
> Looks like this job sets all the TEST variables including
> GIT_TEST_COMMIT_GRAPH=1? The negative test passes because the commit
> graph is enforced on and we then succeed even though we were trying to
> test the negative case.
> 
> I'm going to remove that test in v3 anyways, so I don't think it is a
> big deal. However, I wonder is there some way to mark a test as
> explicitely "don't run if GIT_TEST_COMMIT_GRAPH is set"?

Typically, we try to keep them compatible in both cases. However,
you can set GIT_TEST_COMMIT_GRAPH=0 for the test, if you want. Be
careful to only change it locally to the single test, not "globally"
to the full test script.

Thanks,
-Stolee
