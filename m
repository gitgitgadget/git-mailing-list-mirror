Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B1C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD7B613E6
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhGORRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhGORRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:17:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE1C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:14:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g12so5067077qtb.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=62MyDqKc0JdaOXtzJCRt5gifJYWmhdhWOZWm2Q7MeFA=;
        b=tnQt1dj0lair4EAjUVNm79xkUTXh076vpQYQHLV6PnQAdCjjJMXhLfUykeSnFvn+UM
         v+spuhHBFHyNtHabbSVltSm3NxTwyUr8MSB96GP50+xXnxgZwp8RgFZ1GWqBM7uLlmtt
         pcgaX1kWCcJSFve4OXy5N5tFWd6b1aPwkiHiyO4vWicCanOSdp2n5rerUsURlux+snRu
         cUkzt9tAp/w6HcwqA7PG8S1rFnx6uh/1w99uZUmJzNQAspad2k/Knnbq4Fj+btd/P5Oq
         pJ1L2+1PhAZp5LCz+mLDSxncbvDodvIEZAnaQ87XcE9poZnJqBP4fMWDD1FZdUeT6Q1F
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62MyDqKc0JdaOXtzJCRt5gifJYWmhdhWOZWm2Q7MeFA=;
        b=JGjn/LnwnqlTLaEEHquMCkJtqtlbsc4pcOJdMEWNuMXlFIsMTGIL+GuvXyNiijVv55
         8xYfrnK/1JBlw/3ayvkY/E20UeUjrXiT6tJSc8oezeHrwF6K0lHJkKTuvYelCF18Xfhk
         QnWeybqOdH2rUqd7kSkM+ExUEOmhb+LtuiBb6ZIEIkdlaoocBXKSYp/PEYckVftMNGci
         9CXjnrPm+rEduQ7ItFa0efWarerihtg6/q7DHouIK22iI626EmErBNNU/RFhdPO5AupP
         Xt3T6BGcAucCVaKvlZAaMqcVRDx+xij7qB3ORwimuEw0c5qS8pfSpJxi92BR1Gzff7G2
         QvWQ==
X-Gm-Message-State: AOAM530zCuPusLHOj9K4iXZK/HephyuYWbjCCquc5pgpZIs9Og3qtEw2
        7IVYPHosX2nJFP5NV2vefXc=
X-Google-Smtp-Source: ABdhPJzHxzMydaiJIfYUYNFnYmw3WsgASCtcAiAwjsEVAc1LYEFhKdZf1O3xjSRXvsPvtqHU8u1NzQ==
X-Received: by 2002:a05:622a:407:: with SMTP id n7mr4871680qtx.60.1626369259203;
        Thu, 15 Jul 2021 10:14:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id x125sm2768712qkd.8.2021.07.15.10.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 10:14:18 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] merge-ort: defer recursing into directories when
 merge base is matched
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <317553eadb68ce162b5ebea24045a9ca75342e91.1626204784.git.gitgitgadget@gmail.com>
 <24a7bea5-6325-289d-8d49-619b5e7ec65b@gmail.com>
 <CABPp-BGX-02M2Aw+Fw-bArNd5tOdp_sgcE_oRGiTDicNsgxdgA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9dedcf3b-5484-89d6-6800-77e18dfa6ea3@gmail.com>
Date:   Thu, 15 Jul 2021 13:14:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGX-02M2Aw+Fw-bArNd5tOdp_sgcE_oRGiTDicNsgxdgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2021 12:03 PM, Elijah Newren wrote:
> On Thu, Jul 15, 2021 at 7:43 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
...
>>> +                 renames->trivial_merges_okay[side] &&
>>> +                 !strset_contains(&renames->target_dirs[side], pi.string)) {
>>
>> Does this last condition mean "this directory is not already a parent of a
>> chosen rename target"?
> 
> I'm not sure what you mean by "chosen" here.  If by "chosen" you mean
> "cached" (which comes from ort-perf-batch-11's caching of upstream
> renames from previously cherry-picked commits), then yes.
> 
> Perhaps it's worth noting that rename detection has not yet been run
> for this merge by the time we hit this logic, so the only renames we
> can know are the cached ones from a previous pick.

I was missing the interaction with the cached results, which now makes
much more sense here.

Thanks,
-Stolee
