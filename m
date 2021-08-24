Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A1C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C061214
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhHXJke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXJkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:40:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53FC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:39:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y11so17838348pfl.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XK5bclPShTPLcf5KHCdDSZ7Lzu6MGks9zZpnVx9hT68=;
        b=SR0QUZYi7VPVek3FsNLtyibJu/31/xyP/l6uYUA0tPCAwvxbNfFnj3ydQbf8Y1fn1p
         09qhyzhQYUF/2bZ8aivGlk181xUodwknjXCyTedlH07woj6XJKrd0/DDqQavK0rQ3JIM
         cAr9vIZXZLXITo/yuyHcKh0DFyW3BF3pSJMvv/K37gQu2Bf86v24G7OB2KEKUYqWqhB/
         EuaRVVOflwSM3LJEtgnST38Dh1M7XId/YXFW77SrQ25Uq/tKwb+KZ8NjzTITcivz96IQ
         5tO6i4E7BEe9yHbtV19T2anNlbkwN0OOm1fRyJLJ6Zkat169SUsV/SA47gKCwDBKdsiA
         2Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XK5bclPShTPLcf5KHCdDSZ7Lzu6MGks9zZpnVx9hT68=;
        b=qoT+txZWcxkY1Mg4eCr8J+TCzkzbyciyfuDpFn1Ayc6X1avV8A7be8VR870iICDxy8
         6gcx0dKjcaJA5+pEPTacNtTn9yZoEimpuBmLkcLx6LaYRWqMIXQy9yyBMu3xDlxvFM2j
         rUMuL34bbwaSFK4UZPhEIFu0NMbr3oqizR+MP1Vy+2pyrpYg7/XxGj/PsX6NUzcLonG5
         Mp97RHVB0wJqjxzSuQw36PG011iYie5ukLi8RlJNdoHnZS4SMXaISsVWmxEV6PUg7+TC
         SVK5jYNVvsQtTW130+vNYHBcXM4O3BIliaCeT1pd/AsDr4ZyjB/fI+/txhtoCls2ev3o
         1ksg==
X-Gm-Message-State: AOAM533tJU+TKQKMBjxWtlTeGdQnXGJnXrQ2QPJ0dIsJpFeqt39/5PY4
        b+VUrMOPErKBgpxFiW5ROHs=
X-Google-Smtp-Source: ABdhPJw6C9B3yVbORBa5VT43P2n00zIhxvLDrH17rdK3HfDLKYAATvKBZTWIsgE31YBCORg8l1hjWg==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr37754476pff.13.1629797988408;
        Tue, 24 Aug 2021 02:39:48 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id t12sm22965872pgo.56.2021.08.24.02.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 02:39:48 -0700 (PDT)
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210820105052.30631-1-bagasdotme@gmail.com>
 <YR+Tp2AGeeKyRKoC@danh.dev> <xmqqwnogt20q.fsf@gitster.g>
 <YSBhPdK8jYIQUNhP@danh.dev> <xmqq5yvwrw8s.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6e0ef7f2-3dd0-09e4-5a1d-7e59b979d624@gmail.com>
Date:   Tue, 24 Aug 2021 16:39:44 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yvwrw8s.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/21 22.55, Junio C Hamano wrote:
> Perhaps.  One bad thing with the current "strip" arrangement is that
> it is done in the built directory, and because "make install" would
> blindly install whatever in the built directory, if you truly care
> that you install unstripped binaries, you need to see if they are
> stripped and rebuild them as needed, because "make strip" may or may
> not have been done.  From that point of view, getting rid of the
> current "make strip" and introducing either "make strip-installed"
> ("we've installed things earlier---go strip them") or "make
> install-stripped" ("we've built (or if we haven't please build them
> first), now install them and strip them in the installed directory")
> may make more sense.  And for that, any idea that came up in this
> discussion that relies on the current "strip" target would not help.

But often the installed directory (install prefix) is owned by root,
so one has to `sudo make install-strip`, right?

-- 
An old man doll... just what I always wanted! - Clara
