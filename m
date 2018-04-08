Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327811F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDHXMd (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:12:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38670 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbeDHXMc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:12:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id i3so12564320wmf.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=OzRmJlx/TIn00SQ4mZmDsf2MAF6yMKQlIkkiJHgxgpc=;
        b=RW5u24zoRj5ntxQbJj+tV3A/mxXxaSsvwoTZWw/WauH0KwMFz692iACNdIvVXMtj0E
         sO9SP8ikrGhDBv5kxUAAxc8WIkh6kEI3H0wijTYOjH69reJuGoM3oUwqjqkFxBeBAzXk
         x2XQQbhcN7ssEV7ZdB/B5SxBsB6HXezN7e1WxftHi4Im/QS25kXSkHr5VLIlsJFEMC5s
         95c1ZxEHfOHJedYeEWUHsPmPsr12ka/X0GT5FVVc+vTljaG1abspy6um1iRJd/sLkCPL
         0kqXAwS6TgR11APmQClFnKAPphqPRs3YFp35lkOZIJaReArdO3lmHUx2o7EhbMOLswSs
         9kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=OzRmJlx/TIn00SQ4mZmDsf2MAF6yMKQlIkkiJHgxgpc=;
        b=f/gBS9t0LjsKf1D4DkSpgk1psBL9ZG70Ykdyk/Ah6hWZsMg206WM4ia7AMQBSICIE/
         WHhi5S56kjoODX4edo+I+LCOwCNdnIvT3MGtw/cNmKDBBm/ku661yWJ2KzBffQOkBOAf
         Ex+7SooB2ba4CBtHRn+p87bSPOTY9ib5+o1duq8KHu0h/7QFj3Wig2IwRgdhYHrKxUUj
         gG8kcpc3ApmUr5/jSLcfYBfgsVAqq/CwjTNG3y+8wtbX4QPtY56RTG/GpwCb+FVatV/c
         4DiFpx/SSiKmW+pHN/uvC1LfaVeJqZmyYRhTiPehooBEeT+bintkgJ0Gr+bKLItkHt3B
         zwLw==
X-Gm-Message-State: ALQs6tAH/QtKXsM4Mvp1Qg2o2uZVBkfn5VNk2r17wRyoYiIU7sU12bls
        I5ZLLD9NocHhM49bpn7gc5o=
X-Google-Smtp-Source: AIpwx48wRbHMisgMIfr8ZBrkx7dfFW+BLn0FijMvhAtI7N7IrbTx+3jgw3ZaSFybj8ppM8kpJ48oXw==
X-Received: by 10.28.16.18 with SMTP id 18mr17769427wmq.81.1523229151045;
        Sun, 08 Apr 2018 16:12:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y191sm30555264wme.14.2018.04.08.16.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:12:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
        <87in9dwsxl.fsf@evledraar.gmail.com>
        <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet>
        <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1804031127400.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Mon, 09 Apr 2018 08:12:29 +0900
Message-ID: <xmqqk1th8f8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yes, it is a workaround.  Making shell faster on windows would of
>> course be one possible solution to make t/t*.sh scripts go faster
>> ;-)  Or update parts of t/t*.sh so that the equivalent test coverage
>> can be kept while running making them go faster on Windows.
>
> What makes you think that I did not try my hardest for around 812 hours in
> total so far to make the shell faster?

Nowhere in these four lines I ever said that I think you did not
work hard to solve the performance issues you have.

