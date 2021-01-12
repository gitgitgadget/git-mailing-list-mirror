Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5DAC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C8A22CBE
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbhALRkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbhALRkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:40:20 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD7C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:39:40 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id i18so774119ooh.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlStIJXzJ8u7wdrqsW6L19T3Eb0IQsI60dX5yHd6tqY=;
        b=jViW3ApEMQKnRDj3xwnhBGVjnpqFoxLeuYSVeUcJVOws4+FK/bu4lA1CJ74Gv6eGak
         DjOGw8snCBfl9DWjPvfzfEYAihGgrLnYdsiy5b/mNZ0upzzjxdNDIwSfU7atzpeqOunf
         ZiiBCqd6C6tFaTDyyCmNVXFLTrvEVlNSLiFONOHNXQAUeU0c3534qQp7B6UNEfa8PcjB
         T64ilHbNaIeS6iEuHef03rdEurHPLjyFlaysoi5tFJszHsXhOY8wqlBLRLl1L+qTrb+c
         qxoHYuW8ikVFg/+aSxE6nF7OPqyyQjxkXGRcet2h7Z+hMXp1c/ugTSzqnm31AT+m748L
         Rnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlStIJXzJ8u7wdrqsW6L19T3Eb0IQsI60dX5yHd6tqY=;
        b=egFDNeZeoMP9+usn9qf53SznMuuVOChW7O2iG2Qqnhy6EVqmuVSHFwwE1aoF0XyXk5
         DTJLdixTXOOAbb5T2ZSzDzsryAtAA7wmHzMLGMgAWnb2DPDpB+wegN103vzhnhzLM0WW
         Fi+pAzIW40bIgJXRPEsMithL9qgy3/p6or61IOJwDD3LyyLsuLcxLwJKAzsuCe94zIfU
         6gcaWeAGXc5lze+ERklZAzPBkr+WPA6L6nhny7NlZJcXt26OCJdDHkif2MNdIjHUGpL7
         rW5kn7YzjQj6IAwNI/B1PBQObLcOYQoj9WQ3iJWknoHFkqThCZL5q7SJ/aivoAFhvUyl
         tMGw==
X-Gm-Message-State: AOAM530mAdUomY26ho126nNYKJYwufs6AteDtbKPYkcWfnKN1AP4JjZ1
        jTTWyqRRW7nMi4AgG57SHMk=
X-Google-Smtp-Source: ABdhPJyivM04sk59F7T0PLbMHcKpg2zYUbJ+dZ9DMlEA+jNGsgQgIdZbH99iQXecHB7j3UMMEDK+IA==
X-Received: by 2002:a4a:e963:: with SMTP id i3mr109416ooe.37.1610473179232;
        Tue, 12 Jan 2021 09:39:39 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id j9sm697766ooq.1.2021.01.12.09.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 09:39:38 -0800 (PST)
Subject: Re: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
References: <cover.1610129989.git.me@ttaylorr.com>
 <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
 <875z425b17.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <077f1a42-f37a-c7b4-b05f-fba424ac7f17@gmail.com>
Date:   Tue, 12 Jan 2021 12:39:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <875z425b17.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2021 12:18 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jan 08 2021, Taylor Blau wrote:
>> -	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
>> +	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
>> +		rev_index = 1;
>> +	else
>> +		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
> 
> Why not make an explicit GIT_TEST_WRITE_REV_INDEX=false meaningful? It's
> also sometimes handy to turn these off in the tests.
> 
>     rev_index = git_env_bool("GIT_TEST_WRITE_REV_INDEX",
>     	!!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV)));
 
This will cause tests that explicitly request a rev-index to fail when
GIT_TEST_WRITE_REF_INDEX=false. I'm not sure that's a good pattern to
follow.

>> +#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
> 
> Micro style nit: FWIW I'm not a fan of this macro->string indirection a
> few GIT_TEST_* names have had since 859fdc0c3c (commit-graph: define
> GIT_TEST_COMMIT_GRAPH, 2018-08-29).
> 
> Most of them just use git_env_bool("GIT_TEST_[...]") which IMO makes it
> easier to eyeball a "git grep"

In the case of GIT_TEST_COMMIT_GRAPH, there are multiple places that
check the environment variable, and it is probably best to have the
strings consistent through a macro.

For something like GIT_TEST_WRITE_REV_INDEX, this macro is less
important because it is checked only once.

Thanks,
-Stolee
