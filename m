Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06FFC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8124C610FB
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhHBPg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhHBPg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 11:36:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A21C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 08:36:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gs8so31486732ejc.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wyEfNXH7LsDnArZ1uTZ4LnAB5SEH2Fq49xs0UPU2oII=;
        b=hHhs7FyoZPcQ76No/Fiv+twnvkbnbTwyj018HgXRaFMkBdxowbDbO9Dh49ncuMzLgc
         xlbl+DI1UA/UEwIzVchb7oqD+lPm1bRUUynIo4VI1ahdHeVB3OeaXMVW7aWVm03m6p8h
         rVr2TLkGcwbFfinEl1jB63M9oz2QojPQLL2+3E4AAoeHyhksIEJXHcTewaLlhOJUmS1+
         WZ9bP/V3wRi2Sxciw/PWb4N5tgYeJ5Doulht9xqMr/tp9zdMm31w3KZO3dEMcJ0sKUqM
         GNySk9P/iOGZYU67nH5ovqoIunEOrsrd8jswlmxlrDI9mMQw5UpSjs/fzSiE0odqE5R9
         ntjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wyEfNXH7LsDnArZ1uTZ4LnAB5SEH2Fq49xs0UPU2oII=;
        b=Ih4Nx7o0dgNVGnIQlb0E2wRBkf7CND8USRKtwYPfbKEW3Fkg+wMZjFAR/lkSGl5H3R
         hibfWzkFiNEigIFOo/pzi3oViUZKemSC7evFpgXS39oWCkr3zZjBRDtqu5vqQU9E5Xpt
         8q0i9OiAwOmwVxXShcotGnu9uPwP3LoliSvdeFYx/FvZUGo0mbBOwAbKJsuuGa4OJ/H6
         1t1v1DA9CSujDc2qD9ZejAfHDGOZU8bj30515vDK+3q637+In9gMLZThrx7WRa1HXQMG
         m9gYIZIhJ62Qz/45515WPvB/14Xqoi7EV39o4vHUgGgj1S2JKntGp2oO7glUzIfKmeiY
         h+DA==
X-Gm-Message-State: AOAM531OtgyTPDNMjXNjSsiezy3KTWGVTSyHs+4cMiQca4/wm0ZDj1oZ
        CwDJ0BCyRJ6HBLY5DHdU8Oi9Vknmc23YTg==
X-Google-Smtp-Source: ABdhPJzXGFG++FWsQu5E+tCMrJg6e4FQqiJwLPEfeUwAOGvWnR5QkbkRJ1HVjTf8Y7n6d0MsClwzCg==
X-Received: by 2002:a17:906:5292:: with SMTP id c18mr15671300ejm.308.1627918605158;
        Mon, 02 Aug 2021 08:36:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f26sm3175581edu.4.2021.08.02.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:36:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup
 upon branch creation
Date:   Mon, 02 Aug 2021 17:20:01 +0200
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <20210729020125.746206-2-mathstuf@gmail.com>
 <87sfzsngad.fsf@evledraar.gmail.com>
 <YQfwJOxlBOUWiH1V@erythro.dev.benboeckel.internal>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQfwJOxlBOUWiH1V@erythro.dev.benboeckel.internal>
Message-ID: <87k0l3oo38.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Ben Boeckel wrote:

> On Mon, Aug 02, 2021 at 15:02:41 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>> On Wed, Jul 28 2021, Ben Boeckel wrote:
>> > The `branch.autoSetupMerge` works well today for setting up tracking a
>> > local branch, but there is no easy mechanism to automatically set up a
>> > remote tracking situation for workflows which use a single set of
>> > branches for integration without specifying `--track` to every branch
>> > creation command or branching directly from the remote ref. This patch
>> > adds the following configuration values:
>> >
>> >   - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
>> >     otherwise given;
>> >   - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
>> >     otherwise given.
>>=20
>> Not a new issue per-se, but what if you've got a branch called
>> defaultRemote? It seems to me that any new branch.<name>.* config closes
>> the door for a <name> we squat on.
>
> It doesn't seem that shadowing is actually a thing:
>
>     % git init
>     Initialized empty Git repository in =E2=80=A6/git-shadow/.git/
>     % git config foo.bar true
>     % git config foo.bar.baz true
>     % git config --get foo.bar
>     true
>     % git config --get foo.bar.baz
>     true

You're right, I was misrecalling (or mis-imagining) some edge case there
that doesn't exist. I also tested setting branch.defaultRemote=3Dtrue and
moving a branch.defaultRemote.* branch with "git branch -m", but it also
does the right thing. Nevermind.

>> Given that we have checkout.defaultRemote and this also affects
>> switch/checkout it seems better to continue in the checkout.* namespace
>> even if it wasn't for that, but given the config squatting issue
>> especially so....
>>=20
>> For what it's worth I usually use the checkout.defaultRemote option
>> (which I added) and:
>>=20
>>     git checkout master &&
>>     git branch -m master <topic-name>
>>=20
>> See 8d7b558baeb (checkout & worktree: introduce checkout.defaultRemote,
>> 2018-06-05). It seems to me from that patch diff that you could modify
>> some docs / tests for this, no? E.g. how it interacts with git-worktree.
>
> I think it would be weird for `checkout.*` to affect `git branch` which
> does no checkout at all. I want it to set up for simple branch creation
> as well, so this would be a hole in my use case.

*nod*, although your approach has the opposite problem of making branch
creation with "checkout" and "switch" (and presumably "worktree")
impacted by "branch.*' config.

In a way that's more sensible, in that we can imagine those commands
calling "git branch" under the hood (which msotly doesn't actually
happen, except I think in the worktree case, but it's the same
underlying APIs).

..

>> I like this direction, but just have a concern that this is a place
>> where we need to consider all the UX in the area overall, and that any
>> options/config don't overtly interact in a bad way.
>
> I'll have to look at adding test cases as to how it interacts with
> `checkout.defaultRemote`.
>
> Thanks,

....right, none of that mess is a showstopper, I'm just prodding you to
look at if any of those edge cases are made better/worse by these
additions. Thanks!
