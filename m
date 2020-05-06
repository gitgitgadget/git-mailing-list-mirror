Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47127C47257
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E120708
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEFHgpQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEFQgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730065AbgEFQgu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 12:36:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C3C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 09:36:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so2665224qkg.1
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=STXP6291zQKRynyx2j7lZCFHfKpmsviRx/yhG9Y3RDE=;
        b=IEFHgpQScnndhMR2MIMN5VNZvuqTWcsfr7HnBeUcvcNVs5AAxlHMsGYjNHfrTjLm8H
         w7s4T+ifu37g0HoZc3UHwzLeLDzkwEmFohf5v6wxDHMw7Dn9gMgszuMD4cSJKfgMj9qx
         RyU1gBh3vuNlkHgjsctELkY90GDlcHRF4ffHSB2Q4iBac8UYasveisoqRgDnTTQ7QoAL
         +YBWOqNGWiJhPHAE9s0gqf5DH4lQ/YJbl5WQlNt1zlGglINCUToavYvJ4B5G7IuA1kBG
         ehoTGPCQnDwiz31BJPf0v7DCKZzHxwsms2yb+qokSBvvUJ94a02Az5TYDE2ICXxaEgwo
         9Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=STXP6291zQKRynyx2j7lZCFHfKpmsviRx/yhG9Y3RDE=;
        b=NKx8bYB5dlow8R29Ed5xd7snMkc+e/+f54ZWjxc1AG+TVC8iRwetL/sUKT5v/6nmgT
         RrKSwXEHlDu3+uDAfz+LC7Evz57SkZG3lQY+zt5qU06A+BRXPFaiTdGwezP3Rp+mLIE/
         lrBS5Np5RYCStklV9jCf7xcQSjrOjLpPn+dRHHJgfc3k0arqbZGZJIxaFJfX/7gGlfZk
         9mp+h50lv9UKsqL1/JUmcCO890LznHE18gSEPmWWeM5qivoGU51qVF6psgLjCq/Lp3g0
         f+w76BQw0JHVGr1OAw8y4ojOMixKHelA/+cI1VURuVLRkslf/1/kQv1GrhAf/mM1YSEF
         U0UA==
X-Gm-Message-State: AGi0PuYUftl3EjSfiwCUBSjverSnOV4MVamkljfjMapJxteB9xL8WaXF
        jyQHi0j7nd2QKKZIbiiLo4I=
X-Google-Smtp-Source: APiQypJXOQ5qAqPr0NVt5K4K+NPkkvs15F7C1sKD3AEc/Ox+iTay5HC840MsI+PsXSQ9tUXDMqMsGg==
X-Received: by 2002:a37:94d:: with SMTP id 74mr9598930qkj.479.1588783009751;
        Wed, 06 May 2020 09:36:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x24sm1934547qth.80.2020.05.06.09.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 09:36:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] multi-pack-index: respect
 repack.packKeptObjects=false
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <3d7b334f5c6a89f438bba34cf91259cb67aebcd0.1588758194.git.gitgitgadget@gmail.com>
 <CAPig+cSBBVjBs6ypcpk=s+j2Vu4OXbhUnrJPq8tyoCDr+hX4rw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9ceac1c-8609-74b3-f40a-6d9e68574cd8@gmail.com>
Date:   Wed, 6 May 2020 12:36:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSBBVjBs6ypcpk=s+j2Vu4OXbhUnrJPq8tyoCDr+hX4rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/6/2020 12:18 PM, Eric Sunshine wrote:
> On Wed, May 6, 2020 at 5:44 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> @@ -538,6 +538,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>> +test_expect_success 'repack respects repack.packKeptObjects=false' '
>> +       test_when_finished rm -f dup/.git/objects/pack/*keep &&
>> +       (
>> +               [...]
>> +               THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
>> +               BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
> 
> Taking jk/arith-expansion-coding-guidelines[1] into consideration,
> perhaps write this as:
> 
>     BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&

Thanks for pointing this out. This line is repeated in the test
after this one. That should be fixed, too.

Thanks,
-Stolee

