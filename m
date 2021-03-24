Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E20C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F461A05
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhCXMeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCXMdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 08:33:33 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C901C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:33:33 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x27so12144588qvd.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RNKfl7i4DCKbAB0GeAXME1+vJmR1UypBjMldISEzOkU=;
        b=lpS+A5ZJWzC6nQkcqgXbnb+X/2HgsuMeUyrB5ooh7m8jmHJEtIkBKiJ8LePQZZK84h
         jRlUj8xAs3loeS08MBltkzO8CqzlLYV5uqZ+ClPvgtklPGLX1LHjSNFmwaDwaNn8Pois
         XXEwoVOcv4a4wghec9/cWcMdwpDNG5hJ97NBmBQh6IMp2DXAFdFMM7FSoSZKZoqahbUJ
         O89G4a4nazcGltGrbEBUcP14Pypi/LEzmFVchADMu5qXTsBzoedcFfQfgbuS2I+2Zgw5
         xP9Gu1XWzg8TDcRb41TevW7hMD2QbjLZ2kztfSRRo66gzuUqZaI8lwSZraN8SNn+S20Z
         ksSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNKfl7i4DCKbAB0GeAXME1+vJmR1UypBjMldISEzOkU=;
        b=OJ7vGgK6KCXT8he6b1ech9TWFcNtePJOsDrewS0/21jNIfL0IpIpsFNSsRnTrJlIBn
         SN+7+CkOW9yMk+//Zz9gyv3DD+kRWw3xLBIUmWDN5+j1Bb3G7nS3ubIgMy5PeRROqXRC
         xs0rX6Lqucd3jrq1wD79wJjIBBylnyhJkWctUTaulypt4ZJtsQJtQWsaNoge/Vn6mBUA
         nfGwljquodpqRuTJz1ufBH+yHEBc80wlqUFu4HBRv2y+hARVTYpcko59P5c43gmITY2u
         cCqN9PVxP+76X3hft0Xi/T92lslKAn/myqrq6M9yUy3DbVaAZBGaqOcCuhSmMKVrhyUi
         9X6w==
X-Gm-Message-State: AOAM530PEsJxLGmXNPa821VuDQr/vDXgqsyLbI0Le62rGpZT+98fXLXy
        FMb22K9T/bEF53Kx5G5eDZ8=
X-Google-Smtp-Source: ABdhPJxJIUZk5bFRz4NwzhoUnZQds1tNMJWCjMWkz5poohuC0VZvdKjtDKejqMVJvv32HYv3NbnkDA==
X-Received: by 2002:a0c:ed2c:: with SMTP id u12mr3054867qvq.30.1616589212392;
        Wed, 24 Mar 2021 05:33:32 -0700 (PDT)
Received: from US0059EMPL003.northamerica.corp.microsoft.com ([2600:1700:e72:80a0:e99d:c770:cc27:1f6f])
        by smtp.gmail.com with ESMTPSA id 66sm1562748qkk.18.2021.03.24.05.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:33:32 -0700 (PDT)
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with
 --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
Date:   Wed, 24 Mar 2021 08:33:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87r1k5pcmx.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/21 9:24 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 23 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> This table is helpful for discovering data in the index to ensure it is
>> being written correctly, especially as we build and test the
>> sparse-index. This table includes an output format similar to 'git
>> ls-tree', but should not be compared to that directly. The biggest
>> reasons are that 'git ls-tree' includes a tree entry for every
>> subdirectory, even those that would not appear as a sparse directory in
>> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
>> separator for its tree rows.
>>
>> This does not print the stat() information for the blobs. That will be
>> added in a future change with another option. The tests that are added
>> in the next few changes care only about the object types and IDs.
>> However, this future need for full index information justifies the need
>> for this test helper over extending a user-facing feature, such as 'git
>> ls-files'.
> 
> Is that stat() information that's going to be essential to grab in the
> same process that runs the "for (i = 0; i < istate->cache_nr; i++)"
> for-loop, or stat() information that could be grabbed as:
> 
>     git ls-files -z --stage | some-program-that-stats-all-listed-blobs

The point is not to find the stat() data from disk, but to ensure that
the stat() data is correctly stored in the index (say, after converting
an existing index from another format). This pipe strategy does not
allow for that scenario.

> It's not so much that I still disagree as I feel like I'm missing
> something. I haven't gone through this topic with a fine toothed comb,
> so ...
> 
> If and when these patches land and I'm using this nascent sparse
> checkout support why wouldn't I want ls-files or another not-a-test-tool
> to support extracting this new information that's in the index?
> 
> That's why I sent the RFC patches at
> https://lore.kernel.org/git/20210317132814.30175-2-avarab@gmail.com/ to
> roll this functionality into ls-files.

And I recommend that you continue to pursue them as an independent
series, but I'm not going to incorporate them into this one. I'm
not going to distract from this internal data structure with changes
to user-facing commands until I think it's ready to use. As the design
document describes the plan, I don't expect this to be something I
will recommend to users until most of "Phase 3" is complete, making
the most common Git commands aware of a sparse index. (I expect to
fast-track a prototype to willing users that covers that functionality
while review continues on the mailing list.)

Making a change to a builtin is _forever_, and since the only
purpose right now is to expose the data in a test environment, I
don't want to adjust the builtin until either there is a real user
need or the feature has otherwise stabilized. If you want to take on
that responsibility, then please do.

Otherwise, I will need to eventually handle "git ls-files" being
sparse-aware when eventually removing 'command_requires_full_index',
(Phase 4) so that would be a good opportunity to adjust the
expectations.

Thanks,
-Stolee
