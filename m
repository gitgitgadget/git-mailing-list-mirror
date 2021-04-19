Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F87C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5457F611CE
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhDSMun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhDSMum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 08:50:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28EC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 05:50:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so13625877pja.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7TKvJmzsH9D20DGAdvhIQlM6oKsR35aTwHy8EHHhxYI=;
        b=DN3uVmYtNtmif3eYXUp9+z4n7D9bHdEf40n5lE+p+apmPzQPofoDU1tDBJiPwB8Isq
         q4/ebEVv0OSlqpqn5ZUNQCwoT8a0MVvbcn9dLblz9DQqDsa5pu61FGsdedG4kGGGkUwK
         Z1cNXJJZb9HuzdnhBvg1COWcSMZzzkgtu33P41dYW/DJZc59m18BXxcP8exRXpRzr3A0
         lNg3s3UAHMqSGgtcK0QvxWWSpkaU1/RTALwzP/c83cVCp6okDBJ4/3TUDongAi1YSr6L
         E6rhYevMgEeGXLsaWCCTwg0nFP83jawR1wdAvkDXL+e+wM4/eCc96NImDf23+OjiqL94
         4fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7TKvJmzsH9D20DGAdvhIQlM6oKsR35aTwHy8EHHhxYI=;
        b=OwxinJABn2P7B9t3W7TvZ6/V1qKKOOGZ5obGIEJRk6eD39Wcp2+XjTtkIkkp7qElxF
         3xKzfhlXIEbAcnhVVMTO4IFRlS01joUL7abaK9mOCczwJ+VPMLjvyb8iyYM3cQNT9/oS
         9TmQX1YSQ+taTJdUXibdpcoU6vUb2tRWV7CW2RCKmgn1Zyso0GRRkYAR9blnCIskeeH9
         eKzJXFLhz+drQEwby5nqfk6GE2iDqYBei2F03Dqk24zPbMabH1UONDQVHh3Kdd0eHq7k
         +wRBjseIht8O1Zr6XQAI4QjB7KMUwqX9FtrEg3ZYrjg173jB9Cv6fDc4s04QoGlaE92w
         3gJQ==
X-Gm-Message-State: AOAM533l7jBcdVLd5aaWLpMWPLz8JZvC/wxEc/Sv6rcIxJsYjtJpUN46
        Nik+16U+I6ueZNFMwy2P/+s=
X-Google-Smtp-Source: ABdhPJxZB1SOgeDPvQFFYSb+y9Jn/SUVDdL/xTlio5jaNjJ2WDZ5wY1c93D41jM+9QY4SnxCcH0ZHA==
X-Received: by 2002:a17:90a:a589:: with SMTP id b9mr20832668pjq.80.1618836611179;
        Mon, 19 Apr 2021 05:50:11 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-75.three.co.id. [223.255.225.75])
        by smtp.gmail.com with ESMTPSA id z5sm4449831pff.191.2021.04.19.05.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 05:50:10 -0700 (PDT)
Subject: Re: Using --term-* with bisect breaks skip
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Miriam Rubio <mirucam@gmail.com>,
        Jeff King <peff@peff.net>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20210418151459.GC10839@aaberge.net>
 <c29ef929-4744-a498-540d-1b7df0afa0a0@gmail.com>
 <20210419083926.GD10839@aaberge.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f5368d12-81d9-8591-53f3-44e2e31a89dd@gmail.com>
Date:   Mon, 19 Apr 2021 19:50:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419083926.GD10839@aaberge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/04/21 15.39, Trygve Aaberge wrote:
> Right, the issue persists with those commands here too. So it apparently
> happens as long as you don't use good/bad, but with good/bad it works as
> expected.
> 
Seems interesting, git bisect skip only works on good/bad terms but not on
other terms (and not even on old/new)

I saw similar test on t/t6030-bisect-porcelain.sh (hint: find test
that test for skip) , but I don't know whether that test will pass.
I CC'ed Christian Couder for now.

-- 
An old man doll... just what I always wanted! - Clara
