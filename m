Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED60FC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14961028
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhEPMBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEPMBe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 08:01:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DAAC061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 05:00:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m124so2756524pgm.13
        for <git@vger.kernel.org>; Sun, 16 May 2021 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kVEFem3Ce+HdP8UfTM+YKnVwk/z1PBTh4+urDpIk5RY=;
        b=cmhap5x5k3DCRcugXSz7qTXcI4vSCFg8GxR2pzLwsU11AjIBLa5KmvHq7yPvHtn5ah
         WzKWDl+djEpXTL2qCs8u61Fu6fLAWkHFABZJtPsAj/TqWyIAKhRKljQA9Ub9zICBZrCp
         tRWHpX5Dfzpb0/m9syP+VWnZnCq78BUUHRevO4uO2PHS29vybXBxZJ/UGeFDhhqpluJ1
         oFclPG9tAjFx9Sujmb9Uc8jYMdcYQhQyRinwg2WIpmvzb2ye0eqZbTunfvVc6jqNvvy0
         o2MRYGVxkRJRiVl/FAPlDUCjqJpZ/PkcwUYv6+6i+exiTdTqhfZDSUG4/8Mo+BJ9wRLV
         JlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kVEFem3Ce+HdP8UfTM+YKnVwk/z1PBTh4+urDpIk5RY=;
        b=iDBP3sb+O7QWEi0eppzxg2TKBPdkOR6uaGAtANxNmZAXcn5r/OnFai2tI04rHfvrO5
         yzeNZWL4xUL25rml8ZGer29mNyoY41E5euqzXrL0WEonhqvWgstjk7Q/GlRjzYgcByfh
         W1IFZ6PtyfZaO3R7c10fZzfyEV6toPzS98OTwP8a+93wQTHkytZE97gTosK3rmenZoc8
         zcSylmzh8wSURxc1zMvXfo3Xcrjp4FFh4TRoJOC40DdRjub1qk+y6aVExu0xnHRxUMGp
         xhB7jem+vTKoSL3VCVUA1EVWScluGbiOt3DyLmSxW9rCp+7UvC4RwSIM2Mnw5q/BPCRV
         apYA==
X-Gm-Message-State: AOAM5318naHPQUXP906JloYMQcBCtHpvIYtXCK5ehZB42bJeWtinoCKl
        TobPROZA90plfRaDPXC//czh3/gk1qCv3Q==
X-Google-Smtp-Source: ABdhPJwALHV0L3R2Liiz3+BV/pZMacMo6KSkJIw1apPfiCjihDa60lKW7/ebBab9UQ61655rKKI13w==
X-Received: by 2002:a63:da55:: with SMTP id l21mr56223933pgj.188.1621166417963;
        Sun, 16 May 2021 05:00:17 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id i197sm7782802pgc.13.2021.05.16.05.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 05:00:17 -0700 (PDT)
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
To:     =?UTF-8?Q?Anders_H=c3=b6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Anders_H=c3=b6ckersten?= <anders@hockersten.se>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
Date:   Sun, 16 May 2021 19:00:15 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05/21 14.32, Anders Höckersten via GitGitGadget wrote:
  >   --abbrev=<n>::
> -	Instead of using the default 7 hexadecimal digits as the
> -	abbreviated object name, use <n> digits, or as many digits
> -	as needed to form a unique object name.  An <n> of 0
> -	will suppress long format, only showing the closest tag.
> +	Instead of using the default number of hexadecimal digits (which
> +	will vary according to the size of the repository with a default of
> +	7) of the abbreviated object name, use <n> digits, or as many digits
> +	as needed to form a unique object name.  An <n> of 0 will suppress
> +	long format, only showing the closest tag.
>   

I think the more correct is the abbreviated hash length is determined
by number of objects.

>   --candidates=<n>::
>   	Instead of considering only the 10 most recent tags as
> @@ -139,8 +140,11 @@ at the end.
>   
>   The number of additional commits is the number
>   of commits which would be displayed by "git log v1.0.4..parent".
> -The hash suffix is "-g" + unambiguous abbreviation for the tip commit
> -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
> +The hash suffix is "-g" + an unambigous abbreviation for the tip commit
> +of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
> +length of the abbreviation scales as the repository grows, using the
> +approximate number of objects in the repository and a bit of math
> +around the birthday paradox, and defaults to a minimum of 7.

What is the birthday paradox then?

Also, better say "... and by default the minimum length is 7.".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
