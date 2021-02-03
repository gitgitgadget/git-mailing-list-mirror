Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56161C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1749064F41
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBCOOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 09:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhBCON7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 09:13:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C8C0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 06:13:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w2so1632749ejk.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 06:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=txLX5JhkRgO9NXevP9Kn8XYLobehpLB/ZWeKRoR28gM=;
        b=q/Q1hRqzxk4nFh/8vDPqfcZfaAH6dkxkgsGlQ3xnlZx77iKDxrRwTYaox6dtT9Uri0
         NZax9iAF+S4PxeEOK9B7Qt+o49KZIiLyQlzvJzIJJV4Q/b2LkRl8UFdkH8pjzNkp/KDM
         bwYTgntYIe0w7XFRMqLecKacmLMIlHNokaLxQlaPtFaLopF/YKlPYuUw8UsAl9gDDdLR
         faY7HES0mgbEBuSOiSPSex1TP0pHsHmQKVxs23kbpxo1KjT8tjzvrcmYmcFCWBa1UHtA
         I8PrXUkDRF5STBscNKZq4GSuLXY0hDf/x6JXEec6jWAaURH4upfnGic7JCFR2lnC5i2l
         TCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=txLX5JhkRgO9NXevP9Kn8XYLobehpLB/ZWeKRoR28gM=;
        b=oPlfafYyuci5qE8qj0+4w+XKvQh3R6le/oCeKOPOC1rprCDSG13WAd5GzZhe4p1XQ1
         xJsu0qWuwRjdz47ANR3iGH1FqDl5XiwlYqkVnUf1IyA9I5N/L5a9YjcqAoexG2/ATu50
         UTblhnr7bwSLmHmsxqY9+IJsuvvkq0hXjseHmYHd75iHttSDlLJP0ofJaWNA41VBH00U
         ayN2F2h2naMRgfhijd5hijXDaj+d636xVOGSjldhlBPjecku+wYUu0HkBwXK4UPY2YXH
         kSkzebUU/gLlyVb52ELXmcF17sbOW9uO1tgjRqwNkuQYBkvv1FfWGSJp6V+2+2tazz97
         0eEg==
X-Gm-Message-State: AOAM530nC2oWorgVQQuKoY3EwqKpz73Dlg9u+wxvH5kXOmlstzYvpkiV
        UH9O0GOByOmdoqcs5NREoNUNBIgkrLDk0Q==
X-Google-Smtp-Source: ABdhPJw0xl2UaAznfgCr3VQjHs2cWV/iLM34eD2CZbOeVc5o/KQ4COuSDFN88tJulHDL6QsTpYzHZQ==
X-Received: by 2002:a17:906:9588:: with SMTP id r8mr3451725ejx.167.1612361597831;
        Wed, 03 Feb 2021 06:13:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id p21sm906555edx.90.2021.02.03.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:13:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 22/25] Remove unused kwset.[ch]
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-23-avarab@gmail.com>
 <CAPUEspgBmuTBHVZWY9fRtjbHWBRr0zHravLL1Czepc6jmib4HA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPUEspgBmuTBHVZWY9fRtjbHWBRr0zHravLL1Czepc6jmib4HA@mail.gmail.com>
Date:   Wed, 03 Feb 2021 15:13:16 +0100
Message-ID: <87a6sldytf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, Carlo Arenas wrote:

> this is still being used in Linux without Glibc (ex: alpine or void that
> use musl), and other OS that rely on the compat layer by default for legacy
> reasons (ex: macOS and Windows) or where PCRE2 is not widely used/available
> (ex: OpenBSD, NetBSD)

Are you perhaps confusing kwset with NO_REGEX=1 and compat/regex/*? I
just say that because that's a common "Linux without Glibc" && musl
fallback.

The kwset is not a fallback, we use it unconditionally on all platforms
regardless of libc etc., until this series.

Anyway, as far as PCRE v2 and compatibility go there's no compatibility
concerns here we didn't address already & have in in-the-wild git
releases since Since 48de2a768c (grep: remove the kwset optimization,
2019-07-01) and b65abcafc7 (grep: use PCRE v2 for optimized fixed-string
search, 2019-07-01).

I.e. we haven't used kwset at all in the more commonly used grep code,
just C library regex + PCRE if it's available.

FWIW I think the commonly used packages on Windows and MacOS build with
PCRE v2, but that's just from memory, I don't use those myself.

> PS. hadn't yet tested this series, but thought it was a good idea to at
> least mention this as a FYI to make sure tradeoffs are well known and
> testing done as well.

Indeed, and a glance at the log & past list traffic shows we had a lot
of such portability fixes around pcre2 in the past.

But in this case we're just directing the pickaxe to use the existing
grep codepath, so I think we should be fine, sans small stuff like (sent
a reply to the cover letter about this) me screwing up shell portability
in the v1 etc.
