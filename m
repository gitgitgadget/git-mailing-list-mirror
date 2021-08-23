Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E84CC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E25610E6
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhHWT2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhHWT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 15:28:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96463C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:27:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id eh1so10338794qvb.11
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6VZ628SsHOykZjjaC/DqoGSDf999AVm+i+vLT/uGSI=;
        b=oYWeP06LNKg3fmpztEYJtkcWKCwm/pBCz7t5byqWTRYQn5mZV+LGzDu4SthSSR3OJN
         11uMw5gyBXvfZgJbJoJfCJt6cx4DjABhxRztZm941lTIzMC6DHH9/95ItdgHB080QHYJ
         YQ5ejl6tyikeloIDf9rdGZn1dZKRgXmczt8Iwf/INFFIF+AEEH+XEf5SkYP+mynfZ7rE
         EhLWPRLV6l9nzfSbz5CqZ9NMQcEq2ysHNowFrl2DdTYy7JboTX8PemLuOqS93c62mCWI
         4vsqeCfck/eoqa7UF02TRhssiZfWHGlJCGCHC/OytIV9USKRhHZgpJhTmTS6SL1tQ7pk
         bxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6VZ628SsHOykZjjaC/DqoGSDf999AVm+i+vLT/uGSI=;
        b=fitqjEX5wlvExHe2vO+FfBLArQw0IBJTxvxdyl7ztjm0zZF2jxSZqAG+XSkg5QfCQR
         Eh1bYh7UPVzZ32afNsboa/tvO1NEbjBdBkIpsrmwY78UVtP5EEl5RvpIVlWel0GC2RAa
         JL+//N2Y1idSu22efe5W30AAmg6KH48njPA3jyiISGQubNrGw2kLbkTS+1p5fIUUBSjc
         xz9k6AGZnRSuwbsjW+kBqGd1fYKGysTmgs51qMHhkt4EFYEcJhLHi5HO0oxO7921Ceo2
         bkWM6Gqn2QArP3wegtE0cW62YcWQXs8jZBdE+pSFxWdXXvB5ddlqUSbCnO+nrYs5Bjwy
         vR7g==
X-Gm-Message-State: AOAM532f8Wdp+DPGXABXgDURJ/eLQf8VCZ7BrMmvOzHG7AwWvsd5fZ5v
        wogy/KyC4VjAFQnatX2Mgcw=
X-Google-Smtp-Source: ABdhPJxqwkE2AS2d+oae5npAq1JT4GPJl+3Dk4j77soeXWkFMzqoBc5cw+Hq+9D9ponHJQESSezCFA==
X-Received: by 2002:ad4:54c8:: with SMTP id j8mr34678678qvx.6.1629746878724;
        Mon, 23 Aug 2021 12:27:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id z186sm9119773qke.59.2021.08.23.12.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:27:58 -0700 (PDT)
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
To:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
 <87h7fgfdah.fsf@evledraar.gmail.com>
 <8058589d-f84f-2fdc-6057-8242cde9df61@jeffhostetler.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2431b77d-0d10-0fd6-5ccd-8250db9f7998@gmail.com>
Date:   Mon, 23 Aug 2021 15:27:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8058589d-f84f-2fdc-6057-8242cde9df61@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 2:18 PM, Jeff Hostetler wrote:
> On 8/23/21 10:25 AM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Mon, Aug 16 2021, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Copy the 'index_state->dir_hash' back to the real istate after expanding
>>> a sparse index.
>>>
>>> A crash was observed in 'git status' during some hashmap lookups with
>>> corrupted hashmap entries.  During an index expansion, new cache-entries
>>> are added to the 'index_state->name_hash' and the 'dir_hash' in a
>>> temporary 'index_state' variable 'full'.  However, only the 'name_hash'
>>> hashmap from this temp variable was copied back into the real 'istate'
>>> variable.  The original copy of the 'dir_hash' was incorrectly
>>> preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
>>> the stale version (in 'istate') would be corrupted.
>>>
>>> The test suite does not operate on index sizes sufficiently large to
>>> trigger this reallocation, so they do not cover this behavior.
>>> Increasing the test suite to cover such scale is fragile and likely
>>> wasteful.
>>
>> How large does the index need to be to trigger this? I don't know if a
>> test here is useful, but FWIW if we had such a test then the EXPENSIVE
>> prereq + GIT_TEST_LONG=true might be a good fit for it.
>>
> 
> There would need to be enough directories in the repo to cause
> the dir_hash to grow during an insert into the dir_hash.
> IIRC the hashmap table is initialized to 64 and auto reallocs when
> it hits 80% capacity, so somewhere in the area of 50 directories
> at minimum.

Further complicating this is that the sparse index size matters
relative to the full index size, since the dir_hash has a given
size going into ensure_full_index() that depends on the sparse-index
size and the reallocation patterns.
 
> Whether the error is observed would also depend on free() trashing
> the contents of the memory and/or whether the memory was recycled
> by something else.

Issues like this cause this to be hard to reproduce. We did not
catch it in the performance test p2000-sparse-operations.sh, which
aims to measure how the index works at scale.

This makes me incredibly pessimistic that such a test will be
effective at preventing a regression, let alone catching similar
issues in the future.

Thanks,
-Stolee
