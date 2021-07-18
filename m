Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C9C636C8
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128AC6101E
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGRTWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhGRTWc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 15:22:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02D5C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 12:19:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 37so16659200pgq.0
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOpyfEuuEKOItBkJRyuoB0AplHy8eH7rTarxDjSVX8o=;
        b=juS1xgQCOuBdhMeiZbCbV+Peyr5nboiaueEdIHQAWIKqWpKolmhxN9kffc1WW6FpJ3
         t8j8v7vIDAAj3g07gU/o0I2SkEzR5LtVOogSTUHtxdH1jOn/XHm41mnpBI38gfpxIFDh
         oBIBvoAOKF/lxBphlZ7J1Mg0o2O6rS0RKkfIMJ1uuggiEWIfmeWPyR6PtBMIx545Z7y/
         lZdlEEBXeweqTLq/3Mb6S9Vllzv10i6v3SS2X8KWXEiH/opy97Yqt71xO11NTmNujkPQ
         9fHCLqUPSxg2G1ZKiG5sz2L09t40wQhzBKhD/RaqOfEK/5W5Q4axYDfBZL81IXLbGJgy
         eKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOpyfEuuEKOItBkJRyuoB0AplHy8eH7rTarxDjSVX8o=;
        b=UuvjBZyPY+m1jyhef+X2Fl7dGqXDOSdy4Tvw5lExMCq/IO+5TO1WVSOqG9WNCQ1WUN
         8L240A09JSMEQV/bYCcS50mc/Eme2TT1cBXCpygSkaN8lfxb8LkYCePIfYZK4gqKXCUf
         nJny1MELBqSXwwEGGC1Adb2/UExy3s7XNBw9KuRnoitJ1PsxAkTuPOO4LEwgdOV799It
         QNPJsds1GF6G7FU3YiJVSr7b/eKyZ2MLv0pVF/XwxPZP4FDlFgb6Uy4ZwV5eKi6i9eHr
         1SpRN8Zp8YsFlaT+ry45+aap/Ax1SN1DkIgD/kGwavnMQ8IAOp4IuC8zKo7EVx2NWlZf
         IgBQ==
X-Gm-Message-State: AOAM530+YDNi9f0xdW+ADRaQzAIBsayf4vk3qk+WAjIXypUu6Wrt/kZ1
        r86fdP59fldA1Cc1xL0s/n0=
X-Google-Smtp-Source: ABdhPJx8hEgjhbQPpmk/DKX0G7xvzOH4VCYyA0/jmMYP7kloru5Va5J592u5DEBHojPa83j54ODZNg==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr21816383pgi.385.1626635972336;
        Sun, 18 Jul 2021 12:19:32 -0700 (PDT)
Received: from [192.168.193.232] ([106.195.40.25])
        by smtp.gmail.com with ESMTPSA id v69sm17640083pfc.118.2021.07.18.12.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 12:19:32 -0700 (PDT)
Subject: Re: My Git Dev Blog - Week 9
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <09edd920-e9ef-f8f9-79e6-d27badd2e5a6@gmail.com>
Date:   Mon, 19 Jul 2021 00:49:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva and all,

On 18/07/21 5:29 pm, Atharva Raykar wrote:
> Here's my latest blog post:
> https://atharvaraykar.me/gitnotes/week9
> 

Nice blog!

> A part that may be interesting to list readers:
> 
> - In one section of the blog, I describe the problem of the git
>    submodule configuration not updating properly, when I launch
>    a subprocess that first initialises the submodule. I will
>    appreciate it if someone has a possible explanation for the
>    issue I faced at:
>    https://atharvaraykar.me/gitnotes/week9#launching-the-init-part-as-a-subprocess
> 

Christian mentioned a possible reason. I'll try to take a look
later and see if I could find anything.

> Passing the superprefix explicitly

My gut instinct tells me we could get away without having to go this way but
I haven't yet been able to figure out how. How 'prefix', 'super-prefix' and
'recursive-prefix' is still puzzling me. In case anyone has knowledge about
this please chime in and enlighten us. It would be very helpful.

> I am also waiting on my list patch to land on master, so that I can
> then send the next patch for the submodule add conversion.

I think you don't have to wait until it lands on 'master'. Now that it
is set to merge to 'next', I believe it should be fine for you to send
the rest of the series to the list. Just make sure you mention the
dependency of the series on the one you've already sent to the list.

> Have a great day!
>

Thanks! Hope you have a great weak ahead and do well in your exams.

-- 
Sivaraam
