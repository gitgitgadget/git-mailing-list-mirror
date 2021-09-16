Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3BC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638C561212
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbhIPKhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbhIPKhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:37:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF81C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:36:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i19so4225278pjv.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jKTs7MyEIk+w0rwAmIiL/ZJwxV6+pAsHet1dkws7de0=;
        b=dJ4w+4wAUsdFUy1AlFOmUTwbMdla3avA0Zt4RNflC77ed6dqE/iVv0hPjtBEhLPQBI
         PzHGy4+Z8sglULDny2EnnDcIc+hpE5UHNq6PZ/2yqmYJ32gPG/XnG9iR2SyHSOri23oz
         Yo7nj8xsXoBHYn1GZ+j1HvF8ETXUtOy2w6pEiJa6RkqnGW4hWTeV5Q6c3mCU9IDaC3u0
         P3EnVXU4YVtbEAAr8lzS4XfHt2dLgCkXXz2GHvRDqMzCB2fZhVtkkbWGJBGGfJoBsR1w
         gJUFNtfPtOHqleIOT6Ib3/doGON+TcQU726wPuZU8pyzvg3uUtahapKWsuHH52Bs3SCR
         rF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKTs7MyEIk+w0rwAmIiL/ZJwxV6+pAsHet1dkws7de0=;
        b=kPswSZKDMWw3VmdzoVeTEUFfnU6UJFk63sLsKnCNBhrbbiuSJvb0zAnS8GL4lY5PP9
         27V/5kF3xYOOptXRP9fttBEMd3zCBN8zsasxm6Dg71I3VLY/1YHL5cvpVCCzLLL3CS3n
         CU0B4ZPb67uC9Jyy5UoUF8RswNvtpwJjgxmsNe5rYALYPay157TlMNQMuFnSjqUlhXWu
         +6JY5KJPr428EJN3R7MGfhhuBUibuAI0zzBCwJOY0dTaks/wxQit5AoWspCTvVdigbaV
         lO9tycZocqRb2xFZY+nGcF1DHfkDRfEp2seshKAfPhHwDLjTSMTwnJML3IMGuolWWc+/
         Q6Yg==
X-Gm-Message-State: AOAM530q5V8iw6yQYmw68QfrdEvFniKkRdD0UopW/hdGLBnwsMqYfLUV
        H+8R9LbMbwV9R1tS2lELwz0=
X-Google-Smtp-Source: ABdhPJwFMD8wlNrO8MafjXxFkePzBsk2ZpttnS+7AF0Q99NUH6AsC0aNW8bija3y3I2SzhEeSvg9KA==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr5306775pjb.206.1631788582340;
        Thu, 16 Sep 2021 03:36:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id h10sm7047610pjs.51.2021.09.16.03.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:36:22 -0700 (PDT)
Subject: Re: [PATCH v3] make: add INSTALL_STRIP option variable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBE?= =?UTF-8?Q?anh?= 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <20210902121104.14778-1-bagasdotme@gmail.com>
 <87a6kchlqc.fsf@evledraar.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e5e9848b-4378-8478-6ade-8e5f97295181@gmail.com>
Date:   Thu, 16 Sep 2021 17:36:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87a6kchlqc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/21 16.50, Ævar Arnfjörð Bjarmason wrote:
> ...this really is not an INSTALL_STRIP but (using some combination of
> your own naming) a "INSTALL_XPROGRAMS_OPTS" or "INSTALL_XOPTS". I.e. you
> can supply arbitrary options to "install" with this, but only for
> binaries.
> 

I think it should have been "INSTALL_STRIP_OPTS". This could haven't 
been issue if we add global (applicable tobinaries and scripts) 
"INSTALL_OPTS".

> Also doesn't this misbehave under MSVC when combined with *.pdb files?
> See dce7d295514 (msvc: support building Git using MS Visual C++,
> 2019-06-25) and a8b5355d808 (msvc: copy the correct `.pdb` files in the
> Makefile target `install`, 2020-09-21) , i.e. the code at the start of
> your diff context.
> 
> Does stripping the main binary while having a *.pdb file error or MSCV,
> or make the *.pdb file useless, or is *.pdb an unconditional equivalent
> of INSTALL_STRIP=-s on MSCV that we should disable if this
> hopefully-then-boolean INSTALL_STRIP option is enabled?
> 

I'm not familiar with MSVC, so I can't tell further except you can pass 
null ("") to INSTALL_STRIP.

-- 
An old man doll... just what I always wanted! - Clara
