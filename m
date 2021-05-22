Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4AC4707E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB33610A2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 19:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEVTlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhEVTlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 15:41:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05AC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 12:39:25 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c10so17808705qtx.10
        for <git@vger.kernel.org>; Sat, 22 May 2021 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LtskkJC0eWcSzzNtpKTlx/Na8AzuwL1mAqzXbM8YlQ4=;
        b=XedksOYfMURmoBzz3JdmzMPw1qqco0NB71o5HLfQwmiUs35JxRuyK9aAEMAqzZ+orP
         oFEMMscDpsbT/xxsj19V3fiS7RcY2ZO29XIHMHAkRKxxhpzXu8bUFTVQ2I6rGdjDln2w
         HhYOhHX7G9dez8fvMAhGzon4Rzr6J5cVDofjCaF1pSdrtpC2SnO77LioDPBXYYtgJO7P
         eyX9v/b5umUYoRaQ+TYr9IoMyyCWy8u1aZFftgOHe+YwEg9gu7Nv2UvrKtiWxF7Gp35r
         39tBcF3KTnrUKj7g+12m3Dl6Xga1lSM6njQ/5uUR5UbNQIRt4cDCYXw9AfBuIdyIQ+iU
         XZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtskkJC0eWcSzzNtpKTlx/Na8AzuwL1mAqzXbM8YlQ4=;
        b=lFEdBuux4lcqH3NP/p5NvKdHH2bX0IKcSsGBhtJjjDZc+lwS312LfMmLG/icHGZHrB
         1ytpUBVGOMe+5CA0/2rzYiUXFhl6SZk5N/tMFxBbGmqYdPBvNg676YdVKPBySOaO0hoX
         IPovLVGfPjPozxWEdwQBKGCPrALsBWBC/f0e87CDx/xlx0jJRaelGNMsqrUcpgpOmlOV
         EcVmse/b+jYbzCyVrUIlQdSZomWIsu9HEjEK0COdYp/pcs+cWcDkol0Qwf7go63d1d4D
         Ff0CAKqF5jkGGcPK03Etll3pYBEtWmD8iRrjf35xfCfyPtYUIZ1iClFf2d/XGWGszGWz
         y37A==
X-Gm-Message-State: AOAM532eE6q2Hxvnc95LGoYNrKRSgiXr5b2SszDJ8sY9TxMxkzi+vo33
        hHq+OOr9Nge3+BiE9aY4oCU=
X-Google-Smtp-Source: ABdhPJyzR1QD+TpmyVfCvQUaXmsddZdd/gcyfjJjs4Dq/r8UljWncfHAqXiJ1af8OvZvZDEqgxk3Ig==
X-Received: by 2002:ac8:730d:: with SMTP id x13mr6459038qto.86.1621712363899;
        Sat, 22 May 2021 12:39:23 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l4sm7033031qkp.48.2021.05.22.12.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 12:39:23 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ee246d04-4ae3-1697-0f63-13012c95ed49@gmail.com>
Date:   Sat, 22 May 2021 15:39:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

Le 2021-05-22 à 12:42, Atharva Raykar a écrit :
> Hi all,
> 
> As is tradition, I have started my weekly GSoC blog :)
> 
> Here is week 1: https://atharvaraykar.me/gitnotes/week1
>

I enjoyed reading your first post. About gettext, note that
if you do not want to hardcode a specific version of gettext
in your LDFLAGS/CFLAGS, you could use '/usr/local/opt/gettext/{include,lib}',
or rather, the equivalent for M1 Macs, which I guess would be
'/opt/homebrew/opt/gettext' ? Can't test as I'm on Intel...

On a second note, for your information
the 'configure' build approach is not as well maintained as
the Makefile-only approach, so it's good to make it work with the plain Makefile.

Cheers and good luck for your internship,

Philippe.

