Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE453C47093
	for <git@archiver.kernel.org>; Mon, 31 May 2021 01:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BF361222
	for <git@archiver.kernel.org>; Mon, 31 May 2021 01:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhEaBQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 21:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaBQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 21:16:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B065CC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 18:14:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id jt22so14123763ejb.7
        for <git@vger.kernel.org>; Sun, 30 May 2021 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oHJISzvPmdCXgtjpowtzPKAi5tJQP3N3Mi8QzCF0jBY=;
        b=Z67npRT1IKI3rWLCNZIxOx5ulGe3GLaT0aXSPtybWJeTM0LXxc88tF6OXETzUSOUrv
         JknHitHPoOsI5199i+N1ZEWiBckhYdb0KK7OuTCTco4yVfUfPvBGayKwzeHzFgQwGl9X
         23yBSOYikn8TpFXQ/dD5rr7fG4Ax9jVvh+BaBUFVw9tZK100A73nN0tBnxi/jaYhdtey
         V+L5PAbUHmS1KhNbFMTSEf7zoQRLE0VIBflvB0QkYYIDUbhZQUv3sxbHjOG/Fgx30vlZ
         DY3rvKwTACAFA0P/YfnCz6G8rrdjSv4+cn44P0Wq4celkx7O/qKALTwCizNYuZSEKbJX
         CtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oHJISzvPmdCXgtjpowtzPKAi5tJQP3N3Mi8QzCF0jBY=;
        b=fjc64huhfhzmopaUT+7r+Vmdt2vCQNmkL2U34t2D11UIDwlpui94uv4ZAtF+HqmE9c
         eRNz/jAmudQPVQ1EKJpSoJKyoIJSDe2jSZpx6Q49huy65qnP1qeLBjEIM2D0QdrjzIU2
         TyUmtvos7OnrmGPG3G14mKjB/5UrhfJJHqIsAojpjkmb/ry5Ptri7cKjkY2Icy2954qg
         hzjWaFBkadB9hhqmlc4UZQ3+mNZnH7lalVTYoi9IgdzmCXP+/heGX99l7EVJXn0YOEUg
         SAM2vBR7vEvPemE5sTKNKfxGlhC8/MoRRbPp/DoSsSD9X+HiSeu1YIlri3qHPW/NkHoZ
         OcwQ==
X-Gm-Message-State: AOAM530Jz4yr4H5MGuswij5btyDGnTA2tbSCCkNa9PgKvF5vZnv62r4V
        Wm+nRcb/LJv9Fh94q3WsmXboBnc6MAcG/dmb
X-Google-Smtp-Source: ABdhPJzKa5Nt80RQTECnkOczogHicrle8A5goJTrMZ+QJAmMDpj569QoxYFkrr64V0DNlGkxVyUtCQ==
X-Received: by 2002:a17:906:d0da:: with SMTP id bq26mr8185341ejb.287.1622423678188;
        Sun, 30 May 2021 18:14:38 -0700 (PDT)
Received: from [192.168.67.200] (dsl-66-36-157-80.mtl.aei.ca. [66.36.157.80])
        by smtp.gmail.com with ESMTPSA id k21sm5296693ejp.23.2021.05.30.18.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 18:14:37 -0700 (PDT)
To:     Yuri <yuri@rawbw.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g> <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
 <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
 <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
 <20210529092752.kifzqt3haddzgsob@tb-raspi4>
 <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
 <481fbc88-3e7d-6b00-0997-1a80b87a637d@rawbw.com>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
Message-ID: <c1afaf46-0425-110b-6303-f68d3f994b7f@gmail.com>
Date:   Sun, 30 May 2021 21:14:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <481fbc88-3e7d-6b00-0997-1a80b87a637d@rawbw.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-30 17:55, Yuri wrote:
> On 5/30/21 2:44 PM, Jeff King wrote:
>> Yeah, I'm not sure how such a check would be done. On most Linux systems
>> I've seen, $LANG will mention "en_US.UTF-8" or similar. But I've no idea
>> how portable that convention is, not to mention that people may have
>> more complex setups anyway (e.g., not setting $LANG but setting some of
>> LC_*).
> 
> 
> When 'locale charmap' prints 'UTF-8' the terminal can be assumed to be
> able to accept UTF-8 characters.
> 
> 'locale charmap', I think, determines this only based on environment
> variables.
> 

Hi Yuri,

Even if the terminal supports UTF8, will it print it properly? The font
used could have no or minimal utf8 support. Even when it's supported,
some characters might look alike and this could have undesired
consequences (ex accidentally switching from a normal space to a
non-break space while renaming a file that has spaces...).

I believe repos with utf8 files are rare enough and it could be left to
the user to select whenever to use utf8 or not... An option like "auto"
or "detect" could make it automatic but I'm not convinced it should be
the default.


Oh, and looking at "locale charmap", it doesn't check the terminal
capabilities at all - it just prints the charmap based on LC_ALL or
LC_CTYPE value, or default if they're unset. It doesn't mater what
terminal you're on...

Regards,

--
Thomas
