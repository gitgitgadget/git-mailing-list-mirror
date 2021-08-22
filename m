Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40317C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1A2610A3
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 12:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHVMQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhHVMQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 08:16:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66093C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 05:16:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso10294810pjb.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFxixbIWYKZkfjN4lf9PcAzLR22c2/sk95dfUIPElq8=;
        b=rZDEhuT4I/R1kyltuoHIslQ+vDFBd5pw7ouxVNc9YDvpDrXJUIb0SON9d8oaVUZVCe
         mR+1aiZrI0DErr5I0eAy5ZzJLYQNxO/RqBe9RXtVtecMq5KrlHhCey+ZlgdvBAPOj35C
         EqLNgorMk4sv7uV/F6tX7Ifw97tXfGnKRZJ0Nyl5atnxQZoxuM8x7UtzSMRAbbrOIUrv
         zELUbWUkGPxQ/mn5hoPbK+L/Mijloxdd4ombNtcX+v4SwudwzinNay0QbluqDSUEzEiq
         hl2qSiqM6jEjoAUgBUDQBiZoCj3JRPgjul5pwlGI+Stfl786k23MnTb3iIiofslNa17Z
         6/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFxixbIWYKZkfjN4lf9PcAzLR22c2/sk95dfUIPElq8=;
        b=iS52YYMt4YqwkHF858SoGxUaUON+dWrJLl8rO5nWXGBiOWlNqzHCflBgV8p4tryj7Y
         0Tq6qajIX+DGViiV5XqGLEZjPZw3Ab/oX5WszCTKEn1eq1AXUGqpiY90KoB+NBSAQJSR
         TqdGgjQTtwRz++gy0PrvREWOylScK7e3udk/9h5MNRkLJqqvy4+xV8ptVS+pSMtWM/MH
         TYKFwvE08fRPtDlnXGINmNnkpHXqbCm91qWEqgLG70Yor+dBf/EGDrvSZRs2LFPojpFR
         D9q0+IFqoEedm19lEO+4KpSbXIzaVxY33YEJaYaQXYHjFxCuXW1YO0t/HQbrPO3Q6HcR
         xOUA==
X-Gm-Message-State: AOAM531vxtRxVlexf6NXO0hclkvrM6TjVzACPyhRYhTUipr80MV7tGv+
        c6FRkKTjrDfGqDnCvWfa4uE=
X-Google-Smtp-Source: ABdhPJyyPnBH7+t0VzKIS1JgF+HThjhMGIm89U3fNj26UVRSVBaHrBxuaKDDv8NydSmXKnpAk6jvSg==
X-Received: by 2002:a17:90a:384b:: with SMTP id l11mr14758146pjf.208.1629634567906;
        Sun, 22 Aug 2021 05:16:07 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.188.255])
        by smtp.gmail.com with ESMTPSA id pc6sm10747186pjb.29.2021.08.22.05.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:16:07 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Shourya Shukla <periperidip@gmail.com>
References: <m2lf4wys5o.fsf@gmail.com>
Message-ID: <b6ba6b44-c5f5-63f4-7fd1-19a1acd34770@gmail.com>
Date:   Sun, 22 Aug 2021 17:45:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <m2lf4wys5o.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/21 8:05 pm, Atharva Raykar wrote:
> 
> 2. Reflections on Working With the Git Community:
>     https://atharvaraykar.me/gitnotes/final-reflection
> 
>     This is a blog post that I wrote mostly for myself, and other people
>     interested in contributing to Git. It covers my personal experience
>     with my time here with the many ups and downs. I also wanted to thank
>     all the people who helped and collaborated with me in these 14 weeks.
> 

Good idea on trying to separate the reflection part of the blog from the
actual final report blog. This way, you didn't have to worry about the
report getting too long due to the reflections ;-)

You could consider linking each of these to the other ones, though. That
would help tie things up.

Some other thoughts:

> This mild dogfooding went a long way into making my work feel far more
> enjoyable and meaningful (if working on a project used my millions was
> already not meaningful enough).

Dogfooding is one of those thing that's surprisingly effective at all times :-)

BTW, s/my millions/by millions/

> CoViD.

Good to know that all are well. I resonate with what Zheing Hu says. Let's
hope we get through COVID-19 smoothly.

> This blog will continue, with a renewed purpose. I will be writing down
> important things I learnt in my time and bugs that new contributors
> could work on. I believe that writing guides and making contributions
> easier has some of the best effort-to-impact characteristics that
> I am looking for.

Very true. They are always helpful. I believe MyFirstContribution is
a testimony for this. It's glad to know you would like to help
contributors in that way :-)

> This won't be the last time you will see me on the list, of course. I
> still have patches waiting to make it to the list, and other work
> undergoing review—the only difference now is that it won't be under the
> GSoC banner anymore.
> 

Great!

> Have a great weekend!
>

Thanks and hope you have a good weekend too! Also, thanks for all
your contributions so far! Hoping to see more patches from you on
the list :-)

-- 
Sivaraam
