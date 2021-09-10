Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C472C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10617611C7
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhIJRvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJRvq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:51:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432EC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:50:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so5876135ejs.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CEefFnucGHaU2fnEtfNNLrQeMIqm6tod4HtD1UA7u0g=;
        b=C/xhIHY1U4tHhCo4b6kmvY1c7mHzvbxlIOVmawVjFtbH51x3zP7RQiKnOdsoNK0doG
         paknxeB+CZf2rP93Cr2hL7UFe1UHwuo2n5fmhiG85X+HLA7aScRC/NL8azGo3ftPJty2
         b3477Ek5TESA2oA6Gp/q1iKSVdDXKoy5alzONqputZJBiLuulT7jmxkmXkMqCPlMGO9z
         6mbrAwJNCji9hw5pUlSKvBYGOXGshJpLKrnG409kSKAihcy+cwuaI2sYmdOzYVY7Y2V5
         0n1U/wo9dIcPEPrQdOgRp5FTewYr0/ijhED2vjv0LILZ7V4Toem2aOeM9zZCqaK65KEo
         KVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CEefFnucGHaU2fnEtfNNLrQeMIqm6tod4HtD1UA7u0g=;
        b=mIWMSIBkFHuat6hmgBwiOxkKEJRd95KtuE3TwgMiFIEv2KeyAUeWqBfxhgkP6fBEXp
         3N8azgAFANYPusLMb0fDZqarriphk0hnHJAiJpwu+WhMkD+7JNlWrW4n+Wh/nPr7T1Pp
         UXA5m65r3jaNxuiuVrrOPmPWozXJHx2oZo3P1qeEXYfbvizv0UtbHQDDa9lxCn4k0qS6
         ngeRFwKO0mcRIORMqh8SmwUMSBC8HrGM5GSnXLw4eZnYg7+3wQNh/AzobHYCCurTB2K4
         HuT2a0254Oo8/uLaGaAWAh9CfQU7K9pj/hkjWUS33B7v5rVuaPGrrJiDTenB8OW7Xwqk
         PKMw==
X-Gm-Message-State: AOAM531IwLzoEATL3fA/o0goSpk07EvTpjIm7jPmBknpD3ihrjPDdVgR
        qTVLfCucFJZzb2M1Pvj92D0=
X-Google-Smtp-Source: ABdhPJxYmxEcP74K4yawwJ4S+T5SUJ2+qDnfNdwvx1jDe6xu7+qW4AximAwivYnjWD2OaliAboeALA==
X-Received: by 2002:a17:906:d04b:: with SMTP id bo11mr10299173ejb.513.1631296234021;
        Fri, 10 Sep 2021 10:50:34 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s2sm2805766ejx.23.2021.09.10.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:50:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Date:   Fri, 10 Sep 2021 19:47:55 +0200
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <xmqqbl50tkte.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqbl50tkte.fsf@gitster.g>
Message-ID: <87tuisb9qu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is a follow-up to the already-integrated topic for dropping
>> support for older curl versions submitted before the v2.33 release[1].
>
> To which commit are these expected to apply?  I am having trouble
> wiggling 5 and 7 in.

I based this on top of the current master (8463beaeb69) and these apply
cleanly to me on top of that:
=20=20=20=20
    vm git (master $>) 0 $ git reset --hard @{u}
    HEAD is now at 8463beaeb69 The fourth batch
    vm git (master $=3D) 0 $ git am 000*patch
    Applying: INSTALL: don't mention the "curl" executable at all
    Applying: INSTALL: mention that we need libcurl 7.19.4 or newer to build
    Applying: Makefile: drop support for curl < 7.9.8 (again)
    Applying: http: drop support for curl < 7.18.0 (again)
    Applying: http: correct version check for CURL_HTTP_VERSION_2
    Applying: http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
    Applying: http: centralize the accounting of libcurl dependencies
    Applying: http: don't hardcode the value of CURL_SOCKOPT_OK

So, weird, I can't imagine why they wouldn't apply...
