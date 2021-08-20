Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BCC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C5961102
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbhHTOrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbhHTOrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:47:52 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8BC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:47:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g11so5641316qvd.2
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kh3Bs1OymDUGPemyjNHNfZcdB3DypigT8rcVJZEYctw=;
        b=uSegw7hxZlc5DstdydJlqt2M4/PV3Alz46ZWdXPQUNpgdlI1a8C0a4rMUwYzfwIEzv
         k7ul90hxa1YoDTUABM+Ks0fToqa1o1lLYHv//Fq520c8BreVlnBLRMrMq+9MhLtJ+aS0
         uAf/cRWlZ5VzVlt2aVM/l3pbiD1BcdBQNLLV+Ie1gHuNZVKEfl+blQRyO8QiTT3PZpBl
         e78+zGVzWA7ggwHmJ1L+k04WIpugbYs204yeP86qEXSH6olAFNwN2IZhPNlQ9sbrgjHX
         2Skq1yQ98woM5hc9NTyusAYLVfSnN8/h1zq+Yfgu0nCvLqx8XllnipKtZSImD0APonIL
         mavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kh3Bs1OymDUGPemyjNHNfZcdB3DypigT8rcVJZEYctw=;
        b=bGM7dStTd+63BwOcFcdhjizpRxW0u8WyNNAVJE8PgACWygIwmKJege487XYJ6JlNc2
         Wzivqw99xNSSa4n5iiIVHiUNpG4F7hr289S6XyI0TUuYDisfgYUKbwovwWngckVzR6CZ
         m9JgOY5txKl73akonPNziqp17mSDPR11DHePlqkK/mzofkG8j5ZqmCzvYJWGPybZ/Jn3
         jTttCSqPNYPyFbp67IxSUw0xwwRV0QGxP3LLDZqNL+tDSVWx15hsOmGxkJbMZUklHHl3
         XD2l6xwcHIgYb/DPp8i857WsE9JYps0Jg4RCIWbdtBx94L36f/N3btBYM66lSWqFplhV
         C2OQ==
X-Gm-Message-State: AOAM530j81HJH6b1vFgegN+5PwLJDgEfATAW5OlL3201kD8sxifN+CfQ
        Y3AUPqEdJfeV8NtgBLlh8ok=
X-Google-Smtp-Source: ABdhPJxwoB1Azt8qj2ol0MmX+7SrQLkNw0J9J8MSg3Bo89jF7GhBBZZ4nyRRFWYWm7/5sF6qOB22jw==
X-Received: by 2002:ad4:51c7:: with SMTP id p7mr20561616qvq.15.1629470833420;
        Fri, 20 Aug 2021 07:47:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id 9sm2539162qtz.83.2021.08.20.07.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:47:13 -0700 (PDT)
Subject: Re: [PATCH 6/6] fetch: avoid second connectivity check if we already
 have all objects
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <646ac90e62aab4e4aec595d6848b60233bbe8c77.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1d5ae688-fa08-6c8c-345f-9b0389e21dd7@gmail.com>
Date:   Fri, 20 Aug 2021 10:47:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <646ac90e62aab4e4aec595d6848b60233bbe8c77.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> When fetching refs, we are doing two connectivity checks:
> 
>     - The first one in `fetch_refs()` is done such that we can
>       short-circuit the case where we already have all objects
>       referenced by the updated set of refs.
> 
>     - The second one in `store_updated_refs()` does a sanity check that
>       we have all objects after we have fetched the packfile.
> 
> We always execute both connectivity checks, but this is wasteful in case
> the first connectivity check already notices that we have all objects
> locally available.
> 
> Refactor the code to do both connectivity checks in `fetch_refs()`,
> which allows us to easily skip the second connectivity check if we
> already have all objects available. This refactoring is safe to do given
> that we always call `fetch_refs()` followed by `consume_refs()`, which
> is the only caller of `store_updated_refs()`.

Should we try to make it more clear that fetch_refs() must be followed
by consume_refs() via a comment above the fetch_refs(), or possibly even
its call sites?

Thanks,
-Stolee
