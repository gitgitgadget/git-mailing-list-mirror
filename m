Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE4EC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BEA610CD
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhFMCwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 22:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMCwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 22:52:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D78C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 19:50:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so7791278pfj.5
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEvYH1O2vdjTGeOhjyCkcwlXG/XVJlS/HOZw/8XCciM=;
        b=vM1dQ3BTjn49RPztdQA8s1R7oA/JMbyCInWNO8YbzVRdmCV5Scv5E3XW8X1faAgamK
         vKJomEHEChWvQ01KUpZ74QfMm+es/9CQXlwpxHCOR2gR4MFj44Qkp4tvXLReLQ3oZoiZ
         GGUaCX2EFl73Gy4u8L8cuSZA9VUVq7WH+n4LngRbZvjKFQD/pdDSnWMrImzh5VN1Z1Gh
         ZpO5PWDfje9fS69gD4pQBpYeqKPce0nc2/jD66J+MkOUrmfJku0AVul9v8phV87YMJPl
         UV0W0J7ckjKWNCTw9yjezyLpnHMexb587IFmnhIL1bQUIL/+/zdg9ueSxPLgDvfZGzN5
         J+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEvYH1O2vdjTGeOhjyCkcwlXG/XVJlS/HOZw/8XCciM=;
        b=A52gvSMQHzedWE2Po4y5zS1pMJ22D/7WRMLd0KYSCC0ZJnFD42+AlaZTleHYOWvMMV
         l5KyDaG5LiSbkFrt5sEo+2kToJq0hKIZFKLMNWM4kEUJ8pFul9SzsXEQAHqZSUFp3DlL
         H6xQ3iThLgLwLa4ea4/Ia4Trn+kyDKATC029IKDJvmAoaFkrEOji3MOEPDgG8xYJ+Qqn
         3QR0gXEGTU0mMB0N33zjGpktg64T+gvDHYigPOmmvrIgDo5ad/LyjmHqL/Vz127sGj2F
         98urDxihdpsW92KRuVZyc5MRK+hGXIRBOxyw3QrLpbYvy1n0ECQBEvkqJ5bYflLX3h2M
         L/hw==
X-Gm-Message-State: AOAM532/ICOnNpejIit87S+Ttl/WZzBxP37GTP32kCaK9NeNZmWoXvtv
        lU/XRDE5FLVc6Zxsv8tJsdA=
X-Google-Smtp-Source: ABdhPJyWrf8oYHMyOHBA+IXsMe/blzwqSTIpNJfUjD6SZUKEibjXHdUwF6I7pVkYcbhu+oYJMH++zw==
X-Received: by 2002:a65:52cb:: with SMTP id z11mr10936291pgp.201.1623552624749;
        Sat, 12 Jun 2021 19:50:24 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id p37sm8505848pfw.166.2021.06.12.19.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 19:50:24 -0700 (PDT)
Subject: Re: [PATCH] doc: revisions: improve single range explanation
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4067f10f-067f-6475-8305-2e10631388c6@gmail.com>
Date:   Sun, 13 Jun 2021 09:50:21 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210613004434.10278-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 13/06/21 07.44, Felipe Contreras wrote:
> The original explanation didn't seem clear enough to some people.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   Documentation/revisions.txt | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index f5f17b65a1..d8cf512686 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
>   
>   Commands that are specifically designed to take two distinct ranges
>   (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
> -they are exceptions.  Unless otherwise noted, all "git" commands
> +they are exceptions.  Unless otherwise noted, all git commands
>   that operate on a set of commits work on a single revision range.
> -In other words, writing two "two-dot range notation" next to each
> -other, e.g.
>   
> -    $ git log A..B C..D
> +For example, if you have a linear history like this:
>   
> -does *not* specify two revision ranges for most commands.  Instead
> -it will name a single connected set of commits, i.e. those that are
> -reachable from either B or D but are reachable from neither A or C.
> -In a linear history like this:
> +    ---A---B---C---D---E---F
>   
> -    ---A---B---o---o---C---D
> +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> +commits, but doing A..F B..E will not retrieve two revision ranges
> +totalling 8 commits. Instead the starting point A gets overriden by B,
> +and the ending point of E by F, effectively becoming B..F, a single
> +revision range.
> 


AFAIK, A..F means all commits from A to F. But in case of branched 
history like

     ---A---B---C---G---H---I <- main
                \
                 ---D---E---F <- mybranch

the notation main..mybranch means all commits that are reachable from 
mybranch but not from main, but the opposite (mybranch..main) means the 
opposite!

So basically the right-hand side of two dot notation specifies from what 
commit I want to select the range, and the left-hand side specifies the 
commit which I don't want to reach.

-- 
An old man doll... just what I always wanted! - Clara
