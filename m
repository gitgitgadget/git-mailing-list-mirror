Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5682EC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E1961266
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhHVROL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHVROK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 13:14:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFBC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 10:13:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a21so13298444pfh.5
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmLa9DEVMeoPZS/T912NUuzU+28/0/27XGFc4JheEU4=;
        b=V7P2ddMr5Eaxiw6d7/2CGCZ8GN1iv7uPyzFfAoc5H+TLZxLAfH/oZCcV93eeeKSjmP
         PXqONgtuc7qgkzpDsqq2YCFGbQOER2xzu1YPWnZeHFCgTC0h7tCX03A3NrI+PswzHVLm
         inEL3hBSeLXVan1OdqtJg7fOgWllOgctigqdhHk6sZL/AwWsJzqJBX+fFMeGvQKKzQom
         20yfk/eDZ0QscaJKQlFiYU/8GPTlTAuGOXCcvtwytOY+ibRlDWJUnlPVCGrowiE0qPyt
         im2u4uY2h7ipXgLz2EBm4uS06s5yGJQ6KbdLBoMQYrMI7sT1mObajs3jybAhioGYj380
         RwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmLa9DEVMeoPZS/T912NUuzU+28/0/27XGFc4JheEU4=;
        b=ITgAn43XO1Fqp0gIn7ACPEh3Uy7rBjHeHmbj/7lb/gab9FSGX2Iw8+puBMDqwAQUYc
         m3LW7Rl7j+h43N5w7g6fo2ch3C/LzzmuPbWYkEO2rzlKsq7MS/hiH1kJ/1C6oNTRfK7E
         nIK9mwqFP3xzbJI+zUsu2wxYPRhPtraHXDaHBKPdJwHSbqX9PX+TH5fc6+NsadA8s+KF
         UDgoPiKaORXdlJ92zq1zyDu2fQdn1Qzkzc2vWEAx4h4/ePCkcfsF1Eg3idEJqk18Bq2i
         z6reBvnTU1Yec8MO01mmIVlRmgL5js4mRedSrhzltlBHy/ghVLYmUANQ1G188KVT9O1R
         sjBg==
X-Gm-Message-State: AOAM5303HDj6gkIbNo08idNdz9p/evQs1Hf40Q8yqzgF/3aPQVvmLn2p
        1pwU0GUBEID6UxJaSbfEVpy+umzvJwrIjN1w
X-Google-Smtp-Source: ABdhPJw5M1YhLPUYrFeN2cXEIT8hV5brp7ZLvcpurz5rUeTdvk6a5UbrOhmgsv7Ylx3LT7MJ/jgNbA==
X-Received: by 2002:a62:8643:0:b029:3b1:a6ee:196 with SMTP id x64-20020a6286430000b02903b1a6ee0196mr29843790pfd.13.1629652408898;
        Sun, 22 Aug 2021 10:13:28 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.190.98])
        by smtp.gmail.com with ESMTPSA id a10sm3410264pfo.75.2021.08.22.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 10:13:28 -0700 (PDT)
Subject: Re: [GSoC] Git Final Blog
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        phillip.wood@dunelm.org.uk, Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <7afd9311-7d12-2459-a171-05dd05173402@gmail.com>
Date:   Sun, 22 Aug 2021 22:43:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing Hu,

On 19/08/21 11:09 am, ZheNing Hu wrote:
> My final week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Final-Blog/
> 
> ## Git Final Blog

Nice blog!

> 
> These patches were staying on the `next` branch and waiting to merge
> to `master`,
> you can view them here:
> [link](https://github.com/gitgitgadget/git/issues?q=adlternative+created%3A%3E2021-05-19+label%3Anext).

Just a suggestion. The above link also lists a patch which has already
been merged to `master`. You could use the following link which explicitly
lists only the patches that are on `next` but not on `master`:

https://github.com/gitgitgadget/git/issues?q=adlternative+created%3A%3E2021-05-19+label%3Anext+-label%3Amaster

> ### Concluding remarks
> 
> This summer vacation, I have gained a lot, also made a lot of friends.
> 
> Thanks to Google and Git.
> 
> Thanks to those people who have helped me!
> 
> Thanks to my two mentors Christian and Hariom.
> 
> Three months ago, at the beginning of GSoC, I cited the example
> of Junio's interview:
> [[GSoC] Hello Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com/).
> As an echo, I will maintain a passion for open source and technology,
> and continue to participate in the development and maintenance of the
> Git community.
> 

It's good to see your enthusiasm for working on Git. See you around on
the list :-)

-- 
Sivaraam
