Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F5C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D1B22E03
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbhALOJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbhALOJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 09:09:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1412C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 06:08:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id dk8so2469278edb.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XmoDr4YFXOBudGf/p1qbrAfI6BZyFWJ6xMw09O6o/iY=;
        b=q6E5vLrvlnumLenGfHnYUhnqad4niO94aFXQyPrFpyoL8BhA6EpOctLn8ewgDOWiNm
         vmDItcwgfPCeyJqfZdgCQfu0/zddfVzsdhPBnaUQK/UX5pGkvBu2mZvUR8W7kVcKi9lL
         QgjdlH2iHvCJTGbRBpTMPRO2zK9ev5cMohKk6SAFfzP9qDZZZEaSpSfrctLAf9XiyR3a
         FLDb9roIzfGHZcNQJOd5wXyFLs9RW+3fJ1UTtK010EJ6Ll4ZNWsZy8vQf72c6T4B9gFd
         8x85M4e7gWwe+YLs2LMza2yIH+QnaBYazEUwxeSvb0yAlKP8XiYXHOu6qOmhfWSSJVaE
         wypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XmoDr4YFXOBudGf/p1qbrAfI6BZyFWJ6xMw09O6o/iY=;
        b=iT/krRTxEJFRrxAM9l/EojwA5PyRNSIFxHiKvmzqOl7IX8f73Fpw2CzZXoIcUELIrr
         BRAle5BSLlpCgLH/x3GXPo2lIzr+JWDDt5yGYohk8q+F8IO7BILB7QfLwvG9WbOUNMiF
         EyEjtZTxfhdtELwigSnkxq5XTdSHGRqnwSjRluklJNNNeZFi0rNgr/l5yUQaWiwgSCBs
         6gxmjsEgapPCJZzUxRM3OekUwK1/zfSWS+FykVBaro0sYWK6gpEq3iXvDIghBNeSZQWC
         oSnLjL8w/UihzguH7Bfhi8ZrcetzX735wX5y8iURAlTkoyOK6Fv43ejp4tASuh9m5wcA
         ayCA==
X-Gm-Message-State: AOAM532rSX3FZ6qFEcTlk4FyGMu3BftqpkxxgosW25m/dJaw5TRDG/Kp
        cAp2IowHaMg+V1UJElMaSiw=
X-Google-Smtp-Source: ABdhPJweY/7Gu+qUqPi37PC3T+osWofvPjYIlmIya9hb8ISSq9wg+YehLAmKNiQcJ4IxxLMc+G83eA==
X-Received: by 2002:a05:6402:1748:: with SMTP id v8mr3674062edx.136.1610460530409;
        Tue, 12 Jan 2021 06:08:50 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k3sm1509994eds.87.2021.01.12.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:08:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] mailmap: use case-sensitive comparisons for
 local-parts and names
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-5-sandals@crustytoothpaste.net>
 <87czykvg19.fsf@evledraar.gmail.com>
 <xmqq8s96yjs7.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqq8s96yjs7.fsf@gitster.c.googlers.com>
Date:   Tue, 12 Jan 2021 15:08:48 +0100
Message-ID: <87h7nm5jtb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Jan 03 2021, brian m. carlson wrote:
>>
>> We just have to worry about cases where you're not all of these people
>> in one project's commit metadata and/or .mailmap, and thus mailmap rules
>> would match too generously:
>>
>>     "brian m. carlson" <sandals@crustytoothpaste.net>
>>     "brian m. carlson" <SANDALS@crustytoothpaste.net>
>>     "BRIAN M. CARLSON" <sandals@crustytoothpaste.net>
>>     "BRIAN M. CARLSON" <SANDALS@crustytoothpaste.net>
>>
>> Is that really plausible? In any case, neither of these two patches make
>> reference to us already having changed this in the past in 1.6.2 and &
>> there being reports on the ML about the bug & us changing it back. See
>> https://lore.kernel.org/git/f182fb1700e8dea15459fd02ced2a6e5797bec99.123=
8458535u.git.johannes.schindelin@gmx.de/
>>
>> Maybe we should still do this, but I think for a v3 it makes sense to
>> summarize that discussion etc.
>
> After reading the old discussion again, I am not sure if this is
> worth doing.  To many people, it is a promise we've made and kept
> that we treat addresses including the local part case-insensitively
> when summarising commits by ident strings.
>
> I'd really wish that this series were structured to have 5/5 early
> and 3&4/5 squashed into a single final patch.

Something that I only realized after I sent
<87czykvg19.fsf@evledraar.gmail.com>: Any problems .mailmap has with
Turkish "dotless I" we have already with "git log --author=3D<name> -i".

Not to say that there isn't some problem to solve here, just that if we
do it's a more general issue than mailmap.

As can be inferred from my upthread reply I thought that was ASCII-only,
but it turns out we do set LC_CTYPE based on the user's locale, and it
also applies for English-speakers. E.g. in LANG=3Den_US.UTF-8
"--author=3D=C3=A6var -i" will work.

Of course that doesn't address the point of whether we should be
DWYM-ing E-Mail addresses, just the sub-claim that one reason we
shouldn't is because of impossible-to-solve Unicode edge cases.
