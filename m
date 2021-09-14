Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE57C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69040610FB
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhINKlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhINKlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:41:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2DC061760
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:39:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so2406399pji.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fociOl+EybRsLUBvXxtJjLWNOSMNN2Wb2JfdAMOw71A=;
        b=MujfiBdlmJ0vMHLmLHRkDM9sVCJhfy48N65uHKxAWInVJ9z0L3Gm8AAKfTe+n2mJz5
         mtzo2gTNMQ56/+qTTT2xLOsAKW3hx3uScOlRKXQjHDBcIv972cY9L9qkJwph3JP7ucB/
         E74zB7xNe0GWjHHWYJj4llgHCOmdh9ebzo1FczaCjNEIg5/Fr0EP90/2lMjuEQL/GpCO
         RP9yRcVBrmdXOpXEjglSUWWRvTTSBwyFBEoA7hYnVwQZ992j17AGg+71AX7Bvnigxh9e
         OnASMIl/7PPIlBfNkwY88vmvaHcPi91Nez9fdvHblGwvQveo6pMDIZHSZsC4hOq5jwKJ
         qmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fociOl+EybRsLUBvXxtJjLWNOSMNN2Wb2JfdAMOw71A=;
        b=zTCgunZhi/MjqkKLjb96+5jGxP1Pna3y9P+KcGeergCRP+TH4uZCJkIFIkhnrFQPwX
         Pr/d8pbHkYVDbwIDmX0glRRAeXu9VWsRLs0Gi8wNU03KcNWgVx9R8uFlfrLTHf/OzHFL
         z1cTnW31w91tkGI63WL5DeY/lGW5fK8srFZIk7O8nRGIrrMXgGmCv1SH3GFQfvyox21/
         HBBTwLbJMMdk2MK/8HmqJe5SmBuNyPymZ5/JVZiTdAg08SEKu9mPC1eVlVXwot3MHdp6
         XzKm4aaNNCyl3e6Wl0ONqVwvum8dRox8jYuwA3BEFfkCS5ssm+7Y7XdiaxjvBGXOAcBR
         0idA==
X-Gm-Message-State: AOAM532FielrRkdKjK7CFhsI8kH4muF8AheV2vHZyhdRQMFeFyTZQBe6
        H3Q2uqdTJCjtV/CXPg4mRNs=
X-Google-Smtp-Source: ABdhPJxIE8aWz2JYPCOKJIdm7p5F11T5b4I5bQNh4lsJXYqp4DwVysBJ/Vb1hFB0I5mJeJPz+e3y4Q==
X-Received: by 2002:a17:90a:5894:: with SMTP id j20mr1380514pji.82.1631615989795;
        Tue, 14 Sep 2021 03:39:49 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id e19sm9643760pfi.139.2021.09.14.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:39:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] core.fsyncobjectfiles: batched disk flushes
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b992c83d-747f-55b2-cf58-f39f4ef734aa@gmail.com>
Date:   Tue, 14 Sep 2021 17:39:45 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/21 10.38, Neeraj Singh via GitGitGadget wrote:
> _Performance numbers_:
> 
> Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
> Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
> Windows - Same host as Linux, a preview version of Windows 11.
> 	  This number is from a patch later in the series.
> 
> Adding 500 files to the repo with 'git add' Times reported in seconds.
> 
> core.fsyncObjectFiles | Linux | Mac   | Windows
> ----------------------|-------|-------|--------
>                  false | 0.06  |  0.35 | 0.61
>                  true  | 1.88  | 11.18 | 2.47
>                  batch | 0.15  |  0.41 | 1.53

Interesting here the performance.

You said that core.fsyncObjectFiles=batch performed 2.5x slower than 
core.fsyncObjectFile=false on Linux and Windows, why?

-- 
An old man doll... just what I always wanted! - Clara
