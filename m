Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8987AC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBGWBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGWBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:01:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B9E384
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:01:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so46471536ejc.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4xbUuPTeC0nmoDZRPltjghOg76CpZi/Nsans3i9ryQ=;
        b=BXNqjh0OKi3PLMJXbAIfIhjAx1213ST45g1DAOpaFoS50mNfw0+TdeXfH6dSDgN8Jl
         F7Pu5bin8Ce2GbIAD5Z8MQfREwguH1Bl5UFLcqQxkOSdEC4GXTyzwHN6oHvRXPR+UCZt
         uhYjKDhV71NAEzjFHBKYpN253g/OsR0N/3L+c+pnl1AfwbGzZeZRkdsZKX33/g4Z1c4c
         hQjcQI7IL7doUWtd/vk0LNjiLR8uoy4EQ3rilwc2RajN3vnQtCgTQfTgGxT8EmzUmes5
         0weC2bDzKYcdWUoN+Saf4TwbGKlP3CXjEGtL0x7Bd4P//gKOVi301jCTEns5wW1N0SiP
         TOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4xbUuPTeC0nmoDZRPltjghOg76CpZi/Nsans3i9ryQ=;
        b=e3WrivetlgntlYNdUx5lhjmDQ7pKtmHJe2wR8FrUr0lELOZwC397VlT2U2eKzSd9EM
         gj5n561T4age/FFdq5hwmjvQKq88MZXqaFb/AtiemWDLRuBHGmPfhWBtS2wDDYpjrk8j
         6j+3MjIgG602lerUbSOARmXf6/f2n8xAhivCKOxVHI6CNw72ca5NU06jAwNESU/6YVGb
         hwzSUWpGvhXD5qhXZG7mrrYNZCs+b2Dhf4VEnnL6UzsoKmQQ+AEjhhBkzEjZGZlxwCVH
         vVwl/9xx5VE42dHhhr+sYTP9wS0wA2P4hwrDnz+89SrN6s0OYxsSlYmwR1J3Ddq+Eeq0
         9m0A==
X-Gm-Message-State: AO0yUKVMkdByj3nqLnGlcuYaK1ImArS7Mur7QwEAfRwFR4ORoNcZRv9A
        KfNrTBV7J9vWv6RGJ4RJJPs=
X-Google-Smtp-Source: AK7set+PqXJIcGnLCub2nlyHA39srX9Iin+5TkLKB879GnAf46qVRJPi/QKpLl5Hr7pDo1tpEn9rvA==
X-Received: by 2002:a17:906:e201:b0:7c1:8f53:83a0 with SMTP id gf1-20020a170906e20100b007c18f5383a0mr4667127ejb.13.1675807300149;
        Tue, 07 Feb 2023 14:01:40 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709060f1400b0084c6ec69a9dsm7351263eji.124.2023.02.07.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:01:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPW1y-00128K-1h;
        Tue, 07 Feb 2023 23:01:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 07 Feb 2023 22:44:26 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
        <230207.86k00t2owm.gmgdl@evledraar.gmail.com>
        <xmqqcz6lyzhw.fsf@gitster.g>
        <230207.86bkm52n8x.gmgdl@evledraar.gmail.com>
        <xmqq4jrxyxl2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq4jrxyxl2.fsf@gitster.g>
Message-ID: <230207.867cwt2kzh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> To clarify, I'm not suggesting that we ever read arbitrary parts of the
>> "diff.<driver>.<key>" config space, but that we could whitelist one set
>> of "diff.<driver>.<known-key>"=3D"<known-values>".
>
> When the value names the path to an executable or the command line
> to invoke a program, there is no "portable" value that is useful.
> Whitelisting macOS only program only because its pathname is one of
> the known values does not help me running something else.

We're not talking about invoking an executable of any kind, but a
mechanism to pick up a "diff.algorithm" setting referring to one of our
built-in algorithms, either via the in-repo .gitattributes, as in John's
original proposal:

	*.json diff-algorithm=3Dhistogram

Or via some hybrid .gitattributes/.gitconfig mechanism, where (if I
understand Jeff's suggestion correctly) the two would contain:

	# In .gitattributes
	*.json diff=3Djson=20
	# In .gitconfig
	[diff "json"]
	algorithm =3D histogram

In terms of implementation this would be pretty much what we do with
"submodule.<name>.update", where "Allowed values here are checkout,
rebase, merge or none.".

I don't see where you're getting this suggestion of "[a] diff program
suitable to compare two JSON files" from something I said.

That is a thing we generally support, but I've only mentioned that
arbitrary command execution (e.g. in [1]) as something we explicitly
*don't* want to support in this context.

The "submodule.<name>.update" example is particularly relevant because
it also supports arbitrary command execution with "!"-prefixed values
(the rest being the arbitrary command).

But that's something we specifically exclude when reading the in-repo
version, it's only allowed in the user-controlled config.

I'm not saying that we should be going for the read-just-the-one-key
in-repo .gitconfig approach here, just *if* we like that interface
better the implementation should be relatively straightforward, assuming
that we like the proposal in principle, and are just bikeshedding about
what the mecanhism to enable it would be.

The advantage of that being that it more naturally slots into existing
config, e.g. "diff.<driver>.binary=3D<bool>", this being just another
"diff.<driver>.<known-key>".

And that the way to do that securely is something we're doing for
several "submodule.*" keys, so if we pick that approach tweaking or
stealing ideas from that code should be relatively straightforward.

1. https://lore.kernel.org/git/230206.865yce7n1w.gmgdl@evledraar.gmail.com/
