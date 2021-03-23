Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CBC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 12:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4BC6197F
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 12:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCWMVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCWMUl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 08:20:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A5C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 05:20:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt15so17252399ejb.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wPm0zxL+reP9DUkBoEjnoD7ABG9mrwzSOqWzCcv9PJs=;
        b=Nb0HiJ99DxjJC9e0Bey2ApAOYjn0/jFKnjC+HqHL+Na/B3Rq8m87XeTTJrveiwRGx/
         Smm4HtgP5uiVnFD3s7mGkLt84PBKJiiqZr/QkKimF+jKNGtQEKnYbRTHTLHTQIrJt72q
         ZrUo6oj1ekqtLw9+i7KKtGK+6Y1Zj7e5rmh6dg1wmc+EdzJglfc1Q7YJAbPUkqWx/BKX
         LVMyEJn5LW3l75LMnW4CTv1QlPwwPSkHV6uOJvcFG6JfKc3h/bp/9oYJKarx920LsQv3
         Mnd8QqhS+SPNqw6pjlvfNzSNXum1saM9Lq5gIBINCJh1qwOpeTuh3Al/lk8Nnou0E532
         /mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wPm0zxL+reP9DUkBoEjnoD7ABG9mrwzSOqWzCcv9PJs=;
        b=Gfnhf8b5QUdj027E7TA7VwX2OmfaCFVw/YIqCx0rJU9JYV2Oz+YcJgTxLNYBzMv8gM
         Vy7FIjXdWdeMAWkSHCzidZFZsyALvvRfOhU2/eN8ISWQAfkCqPAmz3MN/RcKhx+pHXtj
         4G65HBMVa91bWZivVDCjzr9rw/GjjPqB2IkMyK0tMVibFpMjlN4v3KZQA6TBM+uA7lL5
         PSZrh9nlvCQHZIlYEiwWSMeVR5Jnfmrwr4VR+ipu/EUID9o+ZloJs6cAz0R8oMqmjJ4T
         D+ca5KHoOddSW9h3ujtVWXfD0ksX3DhtgVJa8m07hyB8SQg2HHXsPZRkmy3N115OFMz+
         adfw==
X-Gm-Message-State: AOAM5302h0pa3J/8a1g69iQh8PPsZJZKAjVZFn9rBexksDDm7dO3Th9S
        BQ2b6MqGYGJ7a68iKIPPxYgrk3A7ofU=
X-Google-Smtp-Source: ABdhPJzzY0TCyscQtwBJ178WEHsPmOWlLoTCUqHdxpQC0x50JwQVn9zIwNtOfO+w6flYtICqLNABLw==
X-Received: by 2002:a17:906:da0e:: with SMTP id fi14mr4822668ejb.188.1616502039779;
        Tue, 23 Mar 2021 05:20:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p27sm10731684eja.79.2021.03.23.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:20:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 13/15] Reftable support for git-core
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
 <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
 <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com>
Date:   Tue, 23 Mar 2021 13:20:38 +0100
Message-ID: <8735wmqcx5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 23 2021, Derrick Stolee wrote:

> On 3/12/2021 3:19 PM, Han-Wen Nienhuys via GitGitGadget wrote:
>> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
>> index 4e23d73cdcad..82c5940f1434 100644
>> --- a/Documentation/config/extensions.txt
>> +++ b/Documentation/config/extensions.txt
>> @@ -6,3 +6,12 @@ extensions.objectFormat::
>>  Note that this setting should only be set by linkgit:git-init[1] or
>>  linkgit:git-clone[1].  Trying to change it after initialization will not
>>  work and will produce hard-to-diagnose issues.
>> ++
>
> I noticed while resolving conflicts with my series, which also edits this
> file, that the "+" line above should be removed. That likely munges the
> fact that the config entry below should be its own list item, not a
> continuation of the previous one.

I haven't tested this patch, but just a plug for the very useful
Documentation/doc-diff for discovering any such formatting errors when
making non-trivial doc changes.
