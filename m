Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F99C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiKHPaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiKHPaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 10:30:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32271DE87
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 07:30:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k2so39606917ejr.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9o5lI/ahh+XkjwRV4R1P/D/vJu3c3huHJ4iUIUhpE7Q=;
        b=cwygJ5WWZblG5M6hGEtReH96lEoUQsKuZWj/vxwwPF2b9vwqz/3c4M7u2epXD1OhyO
         igeOxjsRwX9CuVRRINOhQjZ7EIFigihVUbuhAdqqzWdlRnYSHxtCDvcJcXZgsQd7/fKJ
         ILdjFnSWR6BYL8eRLIyrIBZFugEK6baUrBQhY2sIyn6sH4PKWWG/wmgFsQNwwsoQnEAM
         Me4FiAbur3tUgGuThN6xEZWH4RCHJidq6xJ0nZhxiGGuT9rHmYUuhAL03J3z0u6Kexsm
         We/VGcJ8ufdeIu0i5cBR2b1RL5vh1hkNi92dFCJywHRcn3ZniVzA7XKLzDjJNDpZU2vc
         z39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9o5lI/ahh+XkjwRV4R1P/D/vJu3c3huHJ4iUIUhpE7Q=;
        b=6N/vJBwLDfsl5w0CUWhyNAeed7LKwdgu2gobicjoc0TVJPYnJRQvTliqZ3bNaMmMs1
         VgV26g4rapQS2LTm84dZA9AkMRfW91uAE/iJkPWB5VQDY30lWs02y9XVqWtZaItJjgag
         iP99yJfbFjae6LLxltE53TVOYACqT/PblKUbA/UKmy/svRcuB+FwX/5HR5CZlsnAC5la
         HubZE0pOFqWqWDl7hQdoAR0PgADfsM24yRMiJ11ZJ2ojCW2xuYhdWhITDgvJu6rHZFyc
         sz94ElwHxsicqGvYRGQ5TFxQt7VRhXB1uuH682VC70Q7edSNNKVqZbQvuNUUa8/O6CGN
         wDGA==
X-Gm-Message-State: ACrzQf10YjD9xSanEKWDGKYSnfa+RuO61KJGHFP6ySsbF4DFwJzAyKOm
        gziKl28qRndqRkDUw2L1p7A=
X-Google-Smtp-Source: AMsMyM6/d3wPgymwNjQmGkB3akilkDd0/LTrX3vbo3KGbQksoLFvRZUIy0XYg59uciZWOUPIIb+wCQ==
X-Received: by 2002:a17:907:a42c:b0:7aa:97e5:fac6 with SMTP id sg44-20020a170907a42c00b007aa97e5fac6mr52611644ejc.378.1667921404528;
        Tue, 08 Nov 2022 07:30:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v6-20020a50a446000000b00463597d2c25sm5802788edb.74.2022.11.08.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:30:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osQY7-000c0t-1S;
        Tue, 08 Nov 2022 16:30:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in
 read_strategy_opts()
Date:   Tue, 08 Nov 2022 16:26:37 +0100
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
 <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
 <66835bfb-2815-4321-9d06-52f85a0c72f9@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <66835bfb-2815-4321-9d06-52f85a0c72f9@dunelm.org.uk>
Message-ID: <221108.86zgd1qxac.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Phillip Wood wrote:

> On 04/11/2022 14:50, Phillip Wood wrote:
>> On 03/11/2022 17:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> When "read_strategy_opts()" is called we may have populated the
>>> "opts->strategy" before, so we'll need to free() it to avoid leaking
>>> memory.=20
>> Where is the previous value coming from? I guess it may be the
>> config but otherwise I'm confused.
>
> Having looked a bit more at this I think this is the wrong fix. The
> reason we're overwriting the existing value is that we're reading some=20
> of the state files twice. I think the only way to get to this point is
> to go through a code path that calls rebase.c:read_basic_state() which=20
> already populates these options via a later call to
> rebase.c:get_replay_opts(). I think the correct fixes looks something=20
> like the diff below.
>
> I have also looked at the cherry-pick/revert case and I think that
> we're leaking opts->strategy (and probably some others) when running
>
> 	git cherry-pick --continue
>
> after
>
> 	git -c pull.twohead=3Drecursive cherry-pick -s ort <some commits>

Related: My just-sent [1].

For this one though, I have a v2 re-roll prepared, in which I explained
why the leak is happening (I'll send this soon to the list, but for
now): https://github.com/avar/git/commit/243ab74120b

> I'm not sure what your strategy has been with the fixes in this series
> but we're never going to have 100% coverage of all the option=20
> combinations for rebase & cherry-pick so I think it is helpful to
> treat these LSAN reports as a starting point for looking into why the
> leak is occurring and also look for similar leaks.

For this series I'm aiming to solve some common leaks, and increase our
test coverage.

Per [1] the destruction in this area is quite messy, and we should do it
better. But that's a much larger fix. I think in the meantime adding
this free() is the bets way to make incremental progress here, and (an
the commit linked above notes) it's consistent with existing patterns.

1. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
