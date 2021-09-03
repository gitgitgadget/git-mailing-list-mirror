Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F6EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 10:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABD860F42
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 10:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349146AbhICKXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349142AbhICKXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 06:23:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E08C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 03:22:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y17so3938561pfl.13
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M122tJMOLq4drk2DPl7hE1iRCRHB94oW3HT6GOyxS6Q=;
        b=T/A6+Jy41wqG4L7hJ5ZG8pVDvqBp/maxmpmipgY4pDbQIAshYBEw2FqeaGezT8iZhb
         N7mWmaFylYRa/r1PzfaVXq37dLyxzFDd7gJvCWSA3vKjb5TJdZ8VHggg19R0Gj0ba5jt
         V/TRJAq66gMQ0HgMONx+R3YrwHuw/OOrK0zJqVrG1CgGVCU4Yp2mCHUQaWBLGVzaFdJK
         2sfYQQugCqE4i1GrnZYMN0+uKugJ2ioPPa3+HkRZhxwNJsEDczLa9zcVTcoZpwEu41Yu
         DK/UFy9zvHhx7hjFd/XV0dlht4CpIOdnM8a+G/kckDtAEjLC/nmRDVwlh0NXwloct6K2
         /A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M122tJMOLq4drk2DPl7hE1iRCRHB94oW3HT6GOyxS6Q=;
        b=Sh0e3ASn0UUgKEYRdxJ883WewxobJ5n9Ktnpk4Movh0d1N8Wd7n4vgbizni2BUSQgy
         L8g6/dsDfxyE+hZ3ORGNfcnH2QxJGa8yh3kE6wzdGdh5zGSowW7G1oIPJsE6p8OcMha8
         Pku1pmJJ93sF26JkhkR7u8XIl+zrJcnVm9KMMJ9qJkBc/e8KGxzYGZTGf4uKPg2D9Saf
         vnAfkLWZOk12DA1D1KQAH6ai83dhPQUbzc+R4YVcxXXJg8/y4dIqETlNDTi4iTDQZecr
         v7X9sm8nK49a8uCJ4ttm5xBs2MyHvhxrj81nhZVZmk+js8AI0TMJNYlAbSRHF5JJpqFt
         V2Rw==
X-Gm-Message-State: AOAM532Vv+oqdXHLOaVWJkXjPfClhz/HQRSGb4zGiE8p/u3+Fu60cAfl
        lNz4Y/YmiCq57O//kP3vZxk1G7hadYfN3A==
X-Google-Smtp-Source: ABdhPJyAtJbWz4XqDLnbCg4C9vN3QIOChB5wB6OlU65FZGcXSrfkQBSRO0NHSy8lSkgn+y/zdGwV+Q==
X-Received: by 2002:a63:111f:: with SMTP id g31mr3001812pgl.80.1630664538376;
        Fri, 03 Sep 2021 03:22:18 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id p4sm6209026pgc.15.2021.09.03.03.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 03:22:18 -0700 (PDT)
Subject: Re: [PATCH] builtin/checkout: track the command use (checkout/switch)
 for advice
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
References: <20210903061120.31897-1-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ee6ce58e-8cd6-edc3-164c-651883f3332f@gmail.com>
Date:   Fri, 3 Sep 2021 17:22:15 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903061120.31897-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/21 13.11, Carlo Marcelo Arenas Belón wrote:
> +enum {
> +	AMBIGUOS = (1<<0),
> +	SWITCH = (1<<1),
> +} checkout_resolution_flags;
> +

s/AMBIGUOS/AMBIGUOUS/g (did you mean ambiguous)?

-- 
An old man doll... just what I always wanted! - Clara
