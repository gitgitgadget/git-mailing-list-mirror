Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33667C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F06860EB2
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhG0Qhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhG0Qhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 12:37:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7EC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 09:37:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gs8so9596109ejc.13
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eNpMGcypYhmxxJg4bJ+h7G2XnIM+J2t9yFZ8mYFA6rM=;
        b=O5/ADVv+qaK0xU+OGfhLcD9zH7UQIcOyIZV8rRJogt30XpM2zeLm0Eem5IdxjftTKL
         cNxkFOL7o4Wz4lS7ydR8+VswI+RWw6gyY6OW7IbzHAvsVCtfKTu2EUYrgOEXJzq/Erww
         Kh+dwKy4hS1cMZ+mNdtuVsclnuwDEkouonsl1m8TYilU3HzRgA9YiXGsH+3xIRDdnszU
         coY8fz/+FXH8zvZZZgvyNwtPnkGXvzaefNU1YOf+9SP3vy79qF333gwn/9MGNYRTyNzE
         8i3A5PTb+JjRZaa7dQZvya8G3SYm8riAcmLiHWHpYVBk/D06C5tIRzjC///tprX1Cfez
         Iiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eNpMGcypYhmxxJg4bJ+h7G2XnIM+J2t9yFZ8mYFA6rM=;
        b=COjzHOhF45JEyI0fjSyJMQA5FM5tsA78wNo/btRu+80/WwLU8HPOn1eJzpJInobiNF
         MMf0GmmTXqs0KY9b2ECeUevpWm8rnBbBjcOfdJBe50lLj+JE/FXJj+z2lDUZXEU2hwZ7
         OeSO3FsgNWg8/m7kaEjiCyEfpHWk90bH0m4VyYaODdXAiHHEzrh5csKgQ5Kb0o4p+nqx
         SxigB+0P3O0lx2wA4DJq09n/009feiAfT9IrTiA5bGKEVPegfCYjNCnxpdl6wEGf0epi
         K8obkKzn30uPth8HSFsK8YeLvnHgfjItClw+bpxrtVVBjodI5K5/DtKSnZIEX9ZoUX0U
         iR4A==
X-Gm-Message-State: AOAM532lNQ6DQEEYyR9a1XV7qpH034vUw3o15W8Uw+6UvAatVzFkZPZq
        G1bHD2E8LbwmmMH8j3rqkIA=
X-Google-Smtp-Source: ABdhPJy9ySfIMZ6dwST8HVNkpEBWkX1lGeM4ZmdwctQO51sStWzFsRpQEiENDVbia4/Z6rt4igHiQw==
X-Received: by 2002:a17:906:4e09:: with SMTP id z9mr22784930eju.226.1627403853324;
        Tue, 27 Jul 2021 09:37:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id aq24sm1096691ejc.48.2021.07.27.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:37:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
Date:   Tue, 27 Jul 2021 17:56:37 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
        <87sg0xbq9v.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
        <871r7yxkq8.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
        <xmqqr1fkfyh3.fsf@gitster.g>
        <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com>
Message-ID: <87pmv3r9ud.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 27 2021, Jeff Hostetler wrote:

> On 7/26/21 7:26 PM, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>>> Hi =C3=86var,
>>>
>>> On Fri, 16 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>>> On Fri, Jul 16 2021, Johannes Schindelin wrote:
>>>>
> ...
>
>
> I'm not sure that there is a "correct" answer here, but for the sake
> of harmony, in V4 I'll set this to "darwin" and update the name of
> the backend driver source file to match.  So that we are consistently
> using 1 term throughout "Makefile" and "config.mak.uname".
>
> 	ifeq ($(uname_S),Darwin)
> 	...
> 		FSMONITOR_DAEMON_BACKEND =3D darwin
> 	endif
>
>
>
> FWIW, I suspect that it is not worth the effort to directly set the
> backend name from $(uname_S).  For example, on Windows we currently have
> two different uname values depending on which compiler is being used.
>
> 	ifeq ($(uname_S),Windows)
> 	...
> 		FSMONITOR_DAEMON_BACKEND =3D win32
> 	endif
>
> 	ifneq (,$(findstring MINGW,$(uname_S)))
> 	...
> 		FSMONITOR_DAEMON_BACKEND =3D win32
> 	endif
>
>
> Also, since the backend layer is highly platform-specific, it may be
> a while (if ever) before we have universal coverage for all platforms.
> Until then, we can simply set $FSMONITOR_DAEMON_BACKEND to a literal
> value on a platform-by-platform basis as support is added.

Re "harmony": For what it's worth I don't think you should change it on
my accord.

I should probably have more explicitly said (but I've also been trying
to check the general verbosity of my E-Mails), that when I read a series
like this and have some general trivial comments like this, I mean them
as something like:

    Just a thought while reading this through, i.e. a person familiar
    with the general codebase but not necessarily your specific
    are. Maybe this suggestion makes things easier/simpler, but if you
    think not and decide not to take the suggestion that's fine too.

I.e. that along with the general implicit suggestion that I'd say
applies in general on list that if someone is perplexed by a patch by
default that's a comment on the commit message.

That person (i.e. me in this case) could also just be hopelessly
confused & nothing needs to change. When I get comments like that I
sometimes change things, sometimes not. You should do the same.

As noted in another reply on this general thread & what's cooking I seem
to have poked a bit of a hornet's nest here that I wasn't expecting to
poke. I'd not been following earlier rounds of this topic, and didn't
know that it had (seemingly) reached some phase of critical updates only
in the minds of its authors.

