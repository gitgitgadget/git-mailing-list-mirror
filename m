Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51DC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7502261151
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhEXKTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhEXKTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 06:19:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A10C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:18:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b9so5737818ejc.13
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=d28IOY7atVHw+1ouDFBjL8DzWvxg4BFVJKMnOoVeSpY=;
        b=caG6eHhssUW//nU6AhcUg4RpM3KTs1r5VIfOhONrWfQj3KQY4FVtzV2jnk626mQtkY
         fk5Xsy0J/WdRUbDTcTpu9/JIIolAXLLNdwQiD6khbtfkfplv6NOGwfktRWIJd8xeOipZ
         BlU54UkyZGxXAEMRxoMxrH4Z7xp/wrC5AWRHpdHL5Z68ofX+vCC3rFq3maMo20yJxqp/
         3BARl1pMrbWpATGfCxxeLUV7tQj3z6rR/oOWJ1hAEVY69fzsANPcvIWqkVio3UUg0ar+
         17M0XQCjVT78V6sirf9XbmcWt09OlT11JF/YOhUuvjPJWmfUq66g7rKp0tHRpkN4C/Pp
         0q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=d28IOY7atVHw+1ouDFBjL8DzWvxg4BFVJKMnOoVeSpY=;
        b=bPFlJWSwfV4826i1ih2mV7q4r5BLHKOytDaryt31TjABcM+ffwkGXC0ORdOf92/oFc
         kw0RAc6W8s9btkXes83P0Mg126Ga90RQqXt6WZUplcRwRsNaJgGAvogh8BzWRe0SO8SF
         O11wrv6TDWOSfRVyi7Pi0m+Ywe92mpb1/y8l9Aq0JPAkBueLgp4CnyJt8vhhKqdNSRrQ
         QQz8DUraPyJnWOXwIdYgIBXId8xaLCcttS8aa3gVKqujVZ9UI7f18CFQ7nTj3besWMm1
         mdmWq5vCg46LvrM/0yT30lkb+G11EZOC6r6tzrvnpnnWQq8DcRfzOw7/0/k7diNcPTlu
         K+SA==
X-Gm-Message-State: AOAM5332fYKNFxNVCanQEzw1XGSfGV2j0jEihw28f2fuqxXv94Fa7FI1
        82SLGOzAmsKbCguhoTwetw0=
X-Google-Smtp-Source: ABdhPJwMK2l1TdYvfJ7UxmJE6WZb6q27UosR1HbEZPf2wmOs7iVmDnnBC2xRLsEH9sagUl8fMvHB4Q==
X-Received: by 2002:a17:906:90c9:: with SMTP id v9mr22326984ejw.102.1621851493973;
        Mon, 24 May 2021 03:18:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id df8sm9024749edb.58.2021.05.24.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:18:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Date:   Mon, 24 May 2021 12:05:34 +0200
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60ab17018efee_1691c20832@natae.notmuch>
Message-ID: <87o8d0o2or.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 23 2021, Felipe Contreras wrote:

> Jeff King wrote:
>
>> I suspect that just opening a bug report against distro packages might
>> get some traction (especially if it comes with a patch to create the
>> extra package).
>
> I have tried that; do doesn't work. If git developers have $x in
> "contrib" it's for a reason.
>
>> I do wonder if packagers are hesitant to reach into
>> contrib/,
>
> Of course they are! The word "contrib" has an obvious meaning.

[Minor edit to the quoted text to inline the link]:

> This is precisely the reason why I tried to graduate
> "contrib/completion" out of "contrib" to no avail:
> https://lore.kernel.org/git/1399607587-14127-1-git-send-email-felipe.contreras@gmail.com/

Seems like that patch just got no replies at the time. FWIW I'd very
much be for it and would encourage you to re-submit it.

I'm not sure s/shared/contrib/g is the best naming though, but maybe I'm
contributing to needless bikeshedding by mentioning that.

You apparently named it like that to match where distros usually install
it (/usr/share), but we also have docs there, locale, and the perl/
directory usually (well, at least on my distro) ends up there.

I wonder if just a top-level completion/* wouldn't be best, or if we
want to group them all together something like
optional/{completion,credential}/ or other name suggesting that these
are meant to interact with not-always-present 3rd party software. Maybe
integrations/* ?

For some of these names a general re-arrangement of contrib/* would be a
logical thing to follow, e.g. I think it would make sense to carve out
various ci/, contrib/coccinelle, Documentation/doc-diff,
check-builtins.sh etc. and other "only for supporting git.git
development" or "only called by our own Makefile(s)" into some
consistently named pattern.

I'm also very much in favor of building and testing all of this software
by default, to the best of our ability. We've had some avoidable bitrot
e.g. in subtree and mw-to-git in the past, some of that is a pain to
test (e.g. requiring an installed MediaWiki), but we can usually
build/test some part of it (e.g. in that case, does it even compile as
Perl code?). In other cases we could compile/test things by default on
certain platforms if they're platform-specific.
