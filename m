Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C4CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F155464E2B
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhBPLnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBPLlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:41:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F552C061786
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:40:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y199so10906751oia.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OCTTAbErsv6MX+anopRgvblZNauEH/0v/r3HYYnxFFI=;
        b=ksvsIEckpOYEsQTXrwVs7ukgB3WcgR35t3CqYHvZjgCMjkwsaR6JWqaIF8XXea2Z27
         RClJCrMePJZI4NlH2dtGFqnzzVJR8C8eZL8dNFPLvI40byoXykK/JpLzySOFWnJIhTQu
         qX2zQAvek80Ez5+pbY+qdCGxJ0/oZtITNviCOSykSb6ejZ/elUxbGPvOC6WRpqAOJcOE
         3i1d0Bu3+Dq8OhUmI5HqcFdFZLGXJwzkPcaoNjQQirk1nUEO1T87AbGCR5tuy059fQVe
         swerAGiEvVrxJ88hXFzKg7JeAuy+0SgRBvYa6RIMCMJNqOZo+9hrrhSDMp+0V5zXoSu5
         wtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OCTTAbErsv6MX+anopRgvblZNauEH/0v/r3HYYnxFFI=;
        b=LpdsrgcYJ9+Avuf2/Lx7p5ZiTX0iWWoVvBthWUpRNddBjYH7eVuKua3I7ZDV2BsbKu
         eUWsm70orIE6JNkdp7Hac5V0UswiVSF5Sg7mImBS59OYRVdZ7nOX6/R3UMSI3MI/2/zr
         OymGhuOtbMV6CFunpuuyLiErsSONFg2GPTaX4r7VT2zVWgVS27HiMyPlNXH5ZO373GLY
         jEEjf8wVjQO5F9Z9N+zuhR4i0Qh5uDAiSSoc32oQ2hqgZRPBKAnwo9eki3Svg/ir4+yd
         cT9s0ARhlc2fMmeOYrkC8eGrUBS+tmsnJd5cgRzy6uQ8vrmXFOP7gakyHRxCka+LOzR3
         YOBQ==
X-Gm-Message-State: AOAM530uWB+jpmGZncS+H+4zKw1YwrSgQKq4Lq5blVyw9kobc+kSVQa4
        Cn3L2q5+ZnrdTp+fnMvmsVE=
X-Google-Smtp-Source: ABdhPJwXz3BN976oZzYTQ8kPhXCs2sKxweVwM0DwH4hKnZzu/OGLZ+AOmpsIz+TtQUepjTVSOinBrw==
X-Received: by 2002:aca:d587:: with SMTP id m129mr2268766oig.77.1613475641049;
        Tue, 16 Feb 2021 03:40:41 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id 7sm1214221otd.46.2021.02.16.03.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:40:40 -0800 (PST)
Message-ID: <4d0bd095-5593-33cc-4eec-24f06cc3cf2e@gmail.com>
Date:   Tue, 16 Feb 2021 06:40:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 4/5] commit-graph: refactor dispatch loop for style
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-5-avarab@gmail.com> <YCrDGhIq7kU57p1s@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YCrDGhIq7kU57p1s@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 1:53 PM, Taylor Blau wrote:
> On Mon, Feb 15, 2021 at 07:41:17PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> I think it's more readable to have one if/elsif/else chain here than
>> the code this replaces.
> 
> FWIW, I find the pre-image more readable than what you are proposing
> replacing it with here.
> 
> Of course, I have no doubts about the obvious correctness of this patch;
> I'm merely suggesting that I wouldn't be sad to see us apply the first
> three patches, and the fifth patch, but drop this one.

I agree with all of your points here. I think that compared to the
current code at-rest, the new version might be preferred. It's a little
dense, which is my only complaint.

The issue comes for the future: what if we need to add a third verb
to 'git commit-graph'? Then extending this new option looks worse since
we would check 'argc' three times.

The other patches solve real readability problems or reorganize the code
to use other concepts within the codebase. This one is much more optional.

Thanks,
-Stolee
