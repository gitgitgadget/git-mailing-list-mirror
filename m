Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7136FC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3540F610F7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDHOlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:41:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D0C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 07:41:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u10so2562716lju.7
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NBrh6nXc8/QH9isCMkzAd9cubXuWk0mmclTiZ2933Fs=;
        b=AEZTBYyJYfRgeH711XrhSF9M6kKbbHlMdKx6c4RIb7S0qwWtQbpezD5JS8s1bFrpcy
         Z0TJXF/+DKx1Nc6spbuZQsF003/LSjwyemIPANcphehYrHEiAxv6P7YWFCpOalyFITKf
         37BkQ0KoG0P9y5IoF0mkVckM7f5OVsR1iCbrZjP7J/Xm2IBXlhldUFzDDf8hAxphIw+Z
         Y+uy6matIm/jTRTnArtIXKo04nSp7E4DUNLr4URTo9YjcaZL4NtSZHFpy3pGLPdZ4rBl
         GkWecEH5s1Gcq1+Z5yA0DLumWUJtWU5p2oh4UFCQkFzKUnfgk8E+VviIRWdubnb0LqUS
         GzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=NBrh6nXc8/QH9isCMkzAd9cubXuWk0mmclTiZ2933Fs=;
        b=s2+fnJZP0itqQ4T2nd+58bipN3Viy+G1V2HO16pstxY4S0cuahhBE4codC53NxucGJ
         uq/yJKkThu0lSMOAIpF/P2NCJ8K80BHmzyYJaQDfzy0OIG7lKz2cmLBIecVn/xQcxSL9
         ZtuzGU1bpUh9lnYgA4JapFHie9egs4mM1AZz8KMeRDtEx2r+UH+gSehWu1WvWIe4ckEE
         hVHrDU47icshtfrjYc1poI/tSmEsOX2fBkGMW8K/rtAUVbUSFD3a1sRztLWlk3CgM8he
         68v4bIgPMLZPMXtUE5CrgtiODLXFvdDV3PSO0VNHbmPnye4rsJtr0kWqzN2CdD3FR9tl
         2V6A==
X-Gm-Message-State: AOAM530HQ9QCjWmXOaZLRwn9VLPtWmPrYmMIF/B8zgX/4CCQuZDQFULQ
        nvYwZhBzpbgQvnCHVZbmAtfgfKNY+88=
X-Google-Smtp-Source: ABdhPJzYFZjIYcKZaXO4jQ/Cb37/O6/vhHpaO4afmcxBAoHwfZ+wFLE5nu6J/Giu2p0iCbBKnjG0cw==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr5991764ljp.479.1617892865895;
        Thu, 08 Apr 2021 07:41:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x3sm2840915lfu.69.2021.04.08.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:41:05 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] t9902: fix completion tests for log.d* to match
 log.diffMerges
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-8-sorganov@gmail.com>
        <87y2dtitlp.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 17:41:04 +0300
In-Reply-To: <87y2dtitlp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Apr 2021 01:05:06 +0200")
Message-ID: <875z0wdekf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 08 2021, Sergey Organov wrote:
>
>> There were 3 completion tests failures due to introduction of
>> log.diffMerges configuration variable that affected the result of
>> completion of log.d. Fixed them accordingly.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  t/t9902-completion.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 04ce884ef5ac..4d732d6d4f81 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>>  	test_completion "git config log.d" <<-\EOF
>>  	log.date Z
>>  	log.decorate Z
>> +	log.diffMerges Z
>>  	EOF
>>  '
>>  
>> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>>  	test_completion "git -c log.d" <<-\EOF
>>  	log.date=Z
>>  	log.decorate=Z
>> +	log.diffMerges=Z
>>  	EOF
>>  '
>>  
>> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
>>  	test_completion "git clone --config=log.d" <<-\EOF
>>  	log.date=Z
>>  	log.decorate=Z
>> +	log.diffMerges=Z
>>  	EOF
>>  '
>
> Commits should be made in such a way as to not break the build/tests
> partway through a series, which it seems is happening until this
> fixup.

Yep.

Could these tests be somehow written in a more robust manner, to be
protected against future additions of configuration variables that are
unrelated to the features being tested? If so, I'd prefer to fix them as
a prerequisite to the series rather than adding fixes to unrelated 
existing tests into my patches.

> Having read this far most of what you have in this 9 patch series
> could/should be squashed into something much smaller, e.g. tests being
> added for code added in previous steps, let's add the tests along with
> the code since this isn't such a large change.

In general, I try to make commits as small as possible, but if you
prefer tests to be included with the code in the same commit, – that's
fine with me too.

Will meld new tests into code commits for the next re-roll.

Thanks!

-- Sergey Organov
