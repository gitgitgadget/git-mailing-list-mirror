Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6BC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152FF61108
	for <git@archiver.kernel.org>; Sun, 30 May 2021 17:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhE3RcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhE3Rb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 13:31:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3694C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 10:30:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z4so4031948plg.8
        for <git@vger.kernel.org>; Sun, 30 May 2021 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/jHFwnk3Tcmi+qAdkx9MJK9aoqyaLKDvsN7F0+fpM4=;
        b=eJX16v96ngMp/52gu91LSQuY3V0PsPSgHx5Pslb6VM4a4UlcBYiZppyj5SySykdiEj
         oDAiNZt8vj/HuOrOk5qoEOG7344Z1qeGk7L03khiVY3/FAtbqvgpvcAYPjG+ITJlAQom
         osYptbcWN+kypd/z+JfaTvdoDafkptSXZvpQyCYJsk3r6tFLadsRdU7Lm+Uhj/nq/Tkd
         dLdi1S5AdJ0MOH5I3X6FKhDZ0kIJXYc++ZkYqBxST3Mxgor46fYv5fu1HluSoSlMAuTx
         djHKohlvFlCUFY/7RPh/Q204kOY7lRG+JZdaiBwBS5e3rnoRLVjnbF9A01LeJtvoakKR
         tpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/jHFwnk3Tcmi+qAdkx9MJK9aoqyaLKDvsN7F0+fpM4=;
        b=Q3IkVjOwErCFH8Q4irvG91izQbH54XgrLa7jzHJdO/bfYrke2M5ZVjtKzMmYXKZZeF
         rfLSRA4Q/FZ4QiynqEGQ8w3Z5vvE/uxfo3uG9ekJC3mF3ghk/BweJ6uMclQs0AAYX4ON
         0fA38KEhgm5ZaqFIEWlMVgpwAHf2Bt+EaRSnp7EyG85oqrt1AP7nt6kT6AUcku5yonXT
         a2kI9oU3aZLtaMsnflrVTB/yCDBJ0mAb81Kr83yjzi0RgVZEkoV22xoz/NacZtVLEL7y
         Modj9P4EtEFsCEfOCgWVPdDt9trPWhvC9/4kUBmnWJS3KPvuCEE66ZaqwBAFrzdtBvUZ
         QARw==
X-Gm-Message-State: AOAM532oHwhp614RTu/ncwlNK7WUQVb36+i9nLOhNpksAkNF1UhbOgfT
        gddiGnrGyhQUo0+iFrClk5I=
X-Google-Smtp-Source: ABdhPJxuKzwPjjX0/OJy5O+cClIJ8omc/jSYJ16FKB5sCzQ7IRfxxKKrBv1YjdiRSehdvnv/2lCFJw==
X-Received: by 2002:a17:902:b713:b029:fd:8738:63cb with SMTP id d19-20020a170902b713b02900fd873863cbmr16748933pls.28.1622395820089;
        Sun, 30 May 2021 10:30:20 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.121])
        by smtp.gmail.com with ESMTPSA id z22sm9400750pfa.157.2021.05.30.10.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 10:30:19 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog
To:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <4d51b7bf-966c-c3fc-ce1a-62c0db4af29a@gmail.com>
Date:   Sun, 30 May 2021 23:00:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 30/05/21 12:37 pm, Atharva Raykar wrote:
> Hi,
> 
> On 22-May-2021, at 22:12, Atharva Raykar <raykar.ath@gmail.com> wrote:
>>
>> [...]
>> I will update this thread every week when I make a new post.
> 
> A new blog post is out at: http://atharvaraykar.me/gitnotes/week2
> 

Nice post!

Just one suggestion. While reading, I felt that it would've been
nice if it had a few links. For instance,

> The patch that I ended up sending this week is heavily based on
> the work of two generations of GSoC programmers who struggled
 > over this problem.

The text above could've had a link somewhere to the patch you sent
to the mailing list:

https://public-inbox.org/git/20210528081224.69163-1-raykar.ath@gmail.com/

> I studied Shourya’s stalled patch, parts of which had already
> been reviewed.

... and the above text could've had a link to Shourya's patch
series you mention:

https://public-inbox.org/git/20201214231939.644175-1-periperidip@gmail.com/

> In the spirit of Git being “the stupid content tracker”, I have
> decided to actually live up to that phrase and keep a track of
> my stupid moments in this section of my weekly reports, in the
> hopes that there is something here to learn from.

Good initiative. It indeed might turn out to be very helpful.
I won't surprised if it even turns out to help you, sometime in the
future ;-)

> For whatever reason, I thought of the most convoluted explanations,
> not realising that they actually don’t make any sense. Thoughts like:
> “Is the memory buffer not having tab separated tokens? Are they
> separated by some special whitespace character??”

I could totally feel you here. Things would get better over time.

Hope this helps,
Sivaraam
