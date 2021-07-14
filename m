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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037BBC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AAE613A9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGNM2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhGNM2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:28:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA5EC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:25:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d15so1649368qte.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Co1XPGX/JYXXrenH6UuEeBCSDz4tQD39fzKX+HDW/N4=;
        b=uyBYEukA9vh8kHHYBSAEfUSq4aSu1XATS+5AP8QT+m0m+lnTnOfJO/ZgGNoMWzCWZi
         EJ8yGkGv3QBWQ6FPMY3zMXiUVGP11/8dsto8rnhDctHuhi/34elu+Te7v5JeXGPZgEqM
         jmfwGpSit7FFDwfHsM9rPC3+yStHX/j4e5dcYhkdHKi8jVGXQ24+kc08UpaEbdHd8cgw
         bFXk+/yuZm8xawl9WVpTLoBZOTXAESiU3D+KNRdd+EuXZspW69xO0AIHTpUl1q+SxJqR
         dSToRlr8F/KuFcZ7FqUQg4O3XpULG5QTNANYwhzJwQ7rDgwj2l3xi7wRlLK8RCZyF13x
         P5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Co1XPGX/JYXXrenH6UuEeBCSDz4tQD39fzKX+HDW/N4=;
        b=NwOp8nw5YmtShD6LRoyg0pF6NF3WvpyyxTeIjQyIiK+sTCclb2eJ7U9lF4DMW6Ewzs
         nCmtat+hyfGOwzqaxQNHcdmLHNl9B+31hn9ObjbBGbWoQXdI93nEjtbpuWXhFtiyo1Wc
         IS5bJi/KYcrObjLRfmw0tClIVNLQ/GcMcQeWfn1+SvEQT1F4hn8xTv7k5TKCn45hTsXt
         UzEl0Mmkk3pdczuo1Sn0t7wnHBxJF7HmhtjzV813KoON/U/NAUHW2WZQLL5bru8mh425
         7JT7z8CO2A6S041vM7vZ8jTsMe8HTdcZA+x5BILX3QJB4qmxBuhxS5ciskVj/4CikOKd
         eALQ==
X-Gm-Message-State: AOAM532RI06eOh5/7/warZxjUuxr8d2nKKOZbf33AOgUIrRwIbpxOemv
        pi15u71MSaCueDGoQUD56JE=
X-Google-Smtp-Source: ABdhPJw6T5X0fLPm9OeJecmWCrm3mue0MTO76uXs7vdGbYZQZ3ZqvJ8oe2KnMw18gMJd39Ax8hATJw==
X-Received: by 2002:ac8:5314:: with SMTP id t20mr8976005qtn.235.1626265538310;
        Wed, 14 Jul 2021 05:25:38 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t64sm955533qkd.71.2021.07.14.05.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 05:25:37 -0700 (PDT)
Subject: Re: Bug with branches/merges in submodules
To:     Mel Dafert <mel@dafert.at>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ping Yin <pkufranky@gmail.com>
References: <E9E32A45-DA88-47CB-B7F9-F01F9BEC394C@dafert.at>
 <b519a79a-5e35-bb40-71d3-0fb3c65320d7@gmail.com>
 <6502FFC0-E19B-41FA-B152-885B339360F0@dafert.at>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <20c07aef-d3e4-0ab6-e6f4-f9179f3950a2@gmail.com>
Date:   Wed, 14 Jul 2021 08:25:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6502FFC0-E19B-41FA-B152-885B339360F0@dafert.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mel,

Le 2021-07-14 à 07:07, Mel Dafert a écrit :
> Hello Philippe,
> Thank you for your reply, and the points to the mailing list.
> 
> 
> I would thus like to correct myself, and refile this as a feature request - it would
> be very helpful to me to have this as an option, possibly even with one that can be set in the config, similar to
> 'diff.submodule=log'.
> 
> I would be open to implementing this - I might need some mentoring, however, as
> this would be my first time contributing (and reading the git codebase).

That would great! The page "Hacking Git" [1] has several pointers to interesting
ressources to learn about the code and the contribution process. One of these is
the "My First Contribution" tutorial. [2]

Cheers,

Philippe.

[1] https://git.github.io/Hacking-Git/
[2] https://git-scm.com/docs/MyFirstContribution
