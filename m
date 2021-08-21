Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A105C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDD4611C8
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhHUIRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 04:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhHUIRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 04:17:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD99C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:16:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w5so25027779ejq.2
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EluVCbDESSdoJIOAZef6MyKWkYI0YKZET94rCv/F+tE=;
        b=p4Keh6nTICxs2F/WZNSea4C1kLF3v/DRvJBvYg7RMhvX5OcfB3hRexeaJs3ZH18WMi
         3b20C4gBNnDLbuAXysMfHtm8YC8aiUuLiembCJLMWBi8BHlqPNEXXxkgP3OSZo2muBoj
         +cCnxCfV0PRcL65Bep8pURcfSian6WwGNvM0fSHyI99YVoFZJf5G/mPtlT7OHLMmX7he
         WB3S9x7LHhDNF/DO/wS5OFfNcXD33Mvr+B455f8VyhBcu/VJbrOi5fl3fj0Ngd4nq0ob
         DnnzMHCZyKGfCnWjdRKCtrDF+Nl8enVMeNpezQ4ZUI/h7bthS/pkYjsfFPw5XSHtNP0f
         dO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EluVCbDESSdoJIOAZef6MyKWkYI0YKZET94rCv/F+tE=;
        b=G/V8iRJrcNYXpqUeHJeg5Rf7jGVLpmzd9p/zYnd9nqWcYgP2dqlePBzRbJ87prePEu
         bdP0CpZhT93GCWNNRDJXnQ4wwtLHHhP9+FSAJQFUO1RRLuIhgyRdyvm8i5o4FsERwUxK
         /Gia9YlFS9hV2GMHq+7uKbZJyvNixkJMwYIvxJcY3CbskLan0mS0ZqGLDs9a57tAhPBO
         V1XCBHqCcwSrVOyMNsx6JD4CUxyMMlQp20dQXLeELUpzZe2K0MAsHhf1d5X0Pb9aecdC
         Jwp2Qr3Gmt/+AaEIKkCviJRlvAQ87VhnaZIKsn/6PeErGMbzAC9Nlf2diXX3yjPdUfKk
         RR0Q==
X-Gm-Message-State: AOAM5300dT+EvuNsAJAzGjkei0dV2xV3nokcFdLkGbwh4XGK3p2keeWY
        mJpp7dsH29ScjFHK8lJdab4=
X-Google-Smtp-Source: ABdhPJw8cNga2Q+NN4e/duYvVBlBrX9MF/qHGQuj2zNh3mBXbpl+gPZEDc2MbZeAZeJVKFLgXH1xAQ==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr25381263ejb.544.1629533786059;
        Sat, 21 Aug 2021 01:16:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t19sm3953307ejs.32.2021.08.21.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:16:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v1 0/3] packfile-uri: http and https as default value of
 `--uri-protocol`
Date:   Sat, 21 Aug 2021 10:10:42 +0200
References: <cover.1628845748.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cover.1628845748.git.dyroneteng@gmail.com>
Message-ID: <87czq7gqli.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 13 2021, Teng Long wrote:

> The origin is from the reply by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>     https://public-inbox.org/git/87a6m9ru85.fsf@evledraar.gmail.com

Thanks, I left some comments, see in particular the one on 1/3,
i.e. maybe I'm confused about the goals here.

I think the goal here makes sense, but that a better way to do this is
to simply add a transfer.packfileURI setting, a boolean that defaults to
true. See a similar transfer.bundleURI in a related series of mine:
https://lore.kernel.org/git/RFC-patch-07.13-f0e4052de4-20210805T150534Z-ava=
rab@gmail.com/

I.e. in that series I also make use of fetch.uriProtocols to configure
bundle-uri, so if it lands it'll be confusing to have a know to tweak
bundle-uri, but not packfile-uri.

But even without it I think it's a lot less confusing to start
introdudcing client-specific settings for things we enable/disable in
the protocol explicitly, rather than implicitly by (in this case)
setting the allowed list of protocols.

So that transfer.{bundleURI,packfileURI}=3D[bool] suggestion, or perhaps
even a more generic setting for directly turning on or off capabilities
without having to introduce config handling for each
one. E.g. transferCapability.{bundle,packfile}-uri.disable=3Dtrue. I.e. have
serve.c and friends loop through transferCapability.*.disable and handle
things accordingly on the client.

