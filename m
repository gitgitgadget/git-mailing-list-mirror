Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1256C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C090613BC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhEEN6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhEEN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:58:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C21C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 06:57:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i17so1539686qki.3
        for <git@vger.kernel.org>; Wed, 05 May 2021 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxWTYWlwxuhMb7r7eK9v2doeU+ZwJ6vFgmTm36N9WYw=;
        b=MMZlP4vLdwEZjY3SRRKbrTYMmcHDJPMvIhzQdQn4bMP8tZoSYre6QBszkQROIpDxe4
         /uQF9NPZ4XPRVm8JJIhwQx9WdRnGCCglf2Rniy4I5UszxHRw8VyqaADzQkyvsGulZWM+
         EaAoaWyv2tIPUU4LTR/Y9d4ZtdA5aq21okHW9CeU1XPjGw7CXRNqjXmNBLDWK4KpgCxD
         RdDeUZXcXjgn3ppiDZjM+2+kJlEA3zO9t2081KerE2LLogILUdPP3RtzfZyNXoDA07L5
         WhOELUgE5d4rQ0ATd3BO1YT3J4VnBLPbkeTyA4eVZT69hAZ42JrTP5S6Z00nZdwrwPRI
         wzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxWTYWlwxuhMb7r7eK9v2doeU+ZwJ6vFgmTm36N9WYw=;
        b=jFk9KU8yOeT/XLsO9i0xosemlYL24mI1PzvXhGRBdvMjfHqLsANB1ALqmaXBFDCCYE
         TgFV8i7Rm9gh9eE9DOGjyqIxZg5AipaC7wF4CpJJk+UqgPTGpXH1D2Q9PUtWy7Ts7LrL
         i2ReS/bLso1xN+ErH0NMPz5/TSsAZTGDvhNE3P7+o0naSoKa3FaZ2O049uP3J+KDps9Z
         /nfnbQEDxksHiSOKCGUM2XR+7+31tg2iooBeYYDIfdluHPB8W4HW24WYTvISM/3rygRV
         8lUf/kLBGihi4Wnuwkv3Y+SV+cXBwGo/iAA1MluQ245jQ1IdeKJ07gMlNHmnaGAVVyB2
         HiHw==
X-Gm-Message-State: AOAM533EZLrTn9wdr+9v9tJApq94i+XnkkdsbgXKE4yuhoEpSZJ3rp8F
        6zw+NU8fYpr6DC/Gq+4TI7A=
X-Google-Smtp-Source: ABdhPJyt82XBkSoFDm/B2LE8QDefcq1w8gdA+ePN0I4Vd5SpdmV50sqLMxO5nHTKCYc9sukt/Ctk0A==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr29993585qkg.238.1620223030261;
        Wed, 05 May 2021 06:57:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60? ([2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60])
        by smtp.gmail.com with ESMTPSA id f26sm1373031qtg.17.2021.05.05.06.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:57:09 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Parallel Checkout (part 3)
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, tboegi@web.de
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <cover.1620145501.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <273c4f16-60b6-5635-b95a-17192cf4d5de@gmail.com>
Date:   Wed, 5 May 2021 09:57:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2021 12:27 PM, Matheus Tavares wrote:
> This is the last part of the parallel checkout series. It adds tests and
> parallel checkout support to `git checkout-index` and
> `git checkout <pathspec>`.
> 
> I rebased this version onto `master`, as part-2 was merged down to
> `master`.

I read the range-diff and gave the patches another pass. This version
looks good to me.

Thanks,
-Stolee
