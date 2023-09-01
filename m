Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC4CA0FE6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 13:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349737AbjIANZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349728AbjIANZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 09:25:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA37CD8
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 06:25:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1685278f8f.3
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693574699; x=1694179499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kY+o7PCH2N0cSfcuyOjWtzOQLdGg3Z9oJz6Q6t7iMtA=;
        b=SWwDbmAF05fBayFvhxvN9MfApFY5BION03sHMJAPzG2m8wVc35wYZRuFgva8RihCj/
         4IKRoRTFbmj5uefHWwDtYMCb2udvb3doBrcG0z8TTKUe4jmF9/61/OwoGYns0TSrVCga
         qwGSDlMlU4kyK3tJTtkxxWW0IBBc2yJ+qtlcqV1aGnZ4zaY9shn8OoyFvZXzuJbegU95
         piYEGDVZgitTjvEeAod1JeWhU9Ggcefe3guwYhY2oChFMMuTfc1/rKxxOw8oA9ifZylD
         n/mnLbLdIUnU2diN39Z4WPtC8rD7ztUEgrWeJfQLnGD0YpIoftmJfLlFbkC1cFINLpgQ
         CCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693574699; x=1694179499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY+o7PCH2N0cSfcuyOjWtzOQLdGg3Z9oJz6Q6t7iMtA=;
        b=E3lb4zg+PsI2WGzKKCQY0T5wCLVZZl1XNGo3Zi6fN5cxOdFPb0n54IVgtPsXvBf0jC
         Q7A6lVWu0p0rbdV8yrJQM/UaQZtg01xvEkpFW20ajOI6ke2KQsJeju6/lzvn52a34+CA
         Hl2zH24wHzcsTnRFvKf1hipahVtNFUgfyiyVUTAqxymTN3TSDwZoEeZQ/RfiVLMCnQa5
         6r3GD8z4d/kHZiTq5+eVorF54VRY2Sa3iJ4L2evafQ12EOkFIBMSbOD3hvagGAKnMHqf
         TILbT5V6pYU68Qs7B9MlLtbQgEbNdRoXXvdxTYrEn6dAfU0jpB2q3f2d1NH0e0s1dc0b
         Th/w==
X-Gm-Message-State: AOJu0Ywe5ywc6+0ix3cn4qJG5EXUL1wz5V0SG5WJJXnms3kMMPrBAw5J
        QYgI4V9MxvAANCnKtS4s7UbXJAEDZWf76Q==
X-Google-Smtp-Source: AGHT+IFVpsqIRLAGV893h6wHyROofSoQZ5RBrPZeS4E3QS6QMQKO9BW9009HotA9mdTTT7w06UjFpg==
X-Received: by 2002:adf:de0f:0:b0:319:7788:5027 with SMTP id b15-20020adfde0f000000b0031977885027mr2001902wrm.59.1693574699414;
        Fri, 01 Sep 2023 06:24:59 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k15-20020a05600c0b4f00b003fee6f027c7sm7931668wmr.19.2023.09.01.06.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:24:59 -0700 (PDT)
Message-ID: <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
Date:   Fri, 1 Sep 2023 14:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230830194919.GA1709446@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 30/08/2023 20:49, Jeff King wrote:
> This is a more efficient way to do the same thing that
> ci/config/allow-ref does (which didn't exist back then).

I like the idea of a more efficient way to skip the ci for certain refs. 
I've got my allow-ref script set up to reject a bunch of refs and run 
the ci on everything else. It's not clear to me how to replicate that 
with the setup proposed here. Would it be possible to add a second 
variable that prevents the ci from being run if it contains ref being 
pushed?

Best Wishes

Phillip

> We should be able to do the same with ci/config/skip-concurrent (and
> just use vars.CI_SKIP_CONCURRENT) throughout the workflow. But I didn't
> test that at all.
> 
> After that, the only useful thing left in the "config" job would be the
> "skip-if-redundant" step. I'm not sure if it will be possible to get the
> same behavior there without spinning up a VM.
> 
>    [1/2]: ci: allow branch selection through "vars"
>    [2/2]: ci: deprecate ci/config/allow-ref script
> 
>   .github/workflows/main.yml | 10 +++++++---
>   ci/config/README           | 14 ++++++++++++++
>   ci/config/allow-ref.sample | 27 ---------------------------
>   3 files changed, 21 insertions(+), 30 deletions(-)
>   create mode 100644 ci/config/README
>   delete mode 100755 ci/config/allow-ref.sample
> 

