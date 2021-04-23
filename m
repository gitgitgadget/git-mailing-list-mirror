Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE57AC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39B96101D
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhDWUMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWUMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:12:40 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43DC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:12:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gv2so15107103qvb.8
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpbADszSCeSMnv+n5nb7CHDmc4+g4A0ilj2aXyD74m0=;
        b=o+voE1ZdXehOszTAhub34Y5paTWsCsE3xOfshVPXqUoDfl/EVE2jqlJC9AbO13+6wn
         EpXH3nzeElweU3mW6dK6d822XzpCnwsXnBUqwExgUQt3yPVv7OpGBZvL7IKoMoKLsw2w
         dt3SPyMdYZ4LEr0B8oluqq5uQ6A3QkgE8f/mmjZ+8BiXqE0sCcNt8WiAA5UTsRAe+RZd
         AA7IVD4MIg7N4gHioeW8gZqGiPs8g8SwlRaxexHM/+nQ4LK3LE9rTt9D1xuhYmKSoriR
         cgqMmCEzxGzf8Zfgqk3199fkqUxOpM4S7Z5f29WOybBZ0+SxJwUkXtY7Rycx3DMg7KsB
         xYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpbADszSCeSMnv+n5nb7CHDmc4+g4A0ilj2aXyD74m0=;
        b=tnYf5QpWsZCx9k3aOry+czmrSJEPQTTI7M0jHRB3C/mi2OM+uAVSQur3AvWqSaabIB
         KZypK9y20RwI6/OcleDw5ibWt2scH3yD7V4kcSlQW7JgjgGRGYSbeOHlM1RPefhsBc+1
         cF2Ben0rbooj/92Nlqoo8DKjsFZE1NRwOs3pKZfkPJpC2hcCJ8xQ1Yn+nLt2DF7dZFSS
         4Dt0MCPWTVKJwXHQL69CTdiOBnUPr9iFdb0UAXRczoUb7sjjJT7NA/5rrE59KxepL12/
         CBhm9bkmr5ntise+l6SA4UsaiIxJNo8zv6YutTKOObI+pjmX1UjyHgs92JBklVg+sVIO
         YjEw==
X-Gm-Message-State: AOAM531PPvy1AaRf/VjxsH5/znY/qqBoxmXUQ9/KSfFIJKgVCjqq1FX+
        OYmE/By9os8CQn13icCeAIM=
X-Google-Smtp-Source: ABdhPJwLm8ReXHyIBDgSRPZ1lmMht/xnL819TLm/g+WdlFgRFjHyHmlPztRfWqD91D2f6xPPf2f7Fg==
X-Received: by 2002:a0c:de03:: with SMTP id t3mr5962710qvk.58.1619208721613;
        Fri, 23 Apr 2021 13:12:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id x4sm4974030qkp.78.2021.04.23.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:12:01 -0700 (PDT)
Subject: Re: [PATCH 01/10] t1092: add tests for status/add and sparse files
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
 <CAHd-oW4wq6T1kmBGXUfEO4R8h0dfUAGudKvO0xLgCgm2bQt=qA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94a175eb-8b1a-638e-df85-2d33713ab4fb@gmail.com>
Date:   Fri, 23 Apr 2021 16:12:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW4wq6T1kmBGXUfEO4R8h0dfUAGudKvO0xLgCgm2bQt=qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2021 11:14 AM, Matheus Tavares Bernardino wrote:
> Hi, Stolee
> 
> You already said you will make changes in this test to make sure
> git-add's sparse warning is kept on a sparse index (BTW thanks for
> that :), but I just wanted to give a couple suggestions that came to
> my mind while reading the patch.

I appreciate the suggestions! More tests always help me from
making mistakes, and you are definitely more of a 'git add'
expert than me.
 
>> +       test_must_fail git -C sparse-checkout add folder1/a &&
>> +       test_must_fail git -C sparse-index add folder1/a &&
> 
> To make sure the output is the same, could we collapse these two lines into:
> 
> test_sparse_match test_must_fail git add folder1/a ?

This is elegant. I'm sad I didn't think of it earlier.

> And additionally, I think we could repeat this check with `add
> --refresh` and also after removing `folder1/a`. The reason I'm saying
> this is because the check currently succeeds when `folder1/a` is in
> the working tree (maybe because `fill_directory()` ends up expanding
> the sparse index in this case?), but not under the two other
> circumstances I mentioned (as we've discussed in [1]).
> 
> [1]: https://lore.kernel.org/git/CAHd-oW7vCKC-XRM=rX37+jQn_XDzjtar9nNHKQ-4OHSZ=2=KFA@mail.gmail.com/

Can do!

>> +       git -C full-checkout checkout HEAD -- folder1/a &&
>> +       test_sparse_match git status --porcelain=v2 &&
> 
> Hmm, shouldn't this be `test_all_match`? IIUC, we've resetted
> `folder1/a` on the full repo to make sure the status report is the
> same across all repos, right?

Yes!

Thanks,
-Stolee
