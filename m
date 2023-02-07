Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA96C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 20:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBGUhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGUhC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 15:37:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BEEC5E
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 12:37:01 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p26so45705020ejx.13
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+YHuVinq2W+VUpnKIF/OqtrZzHroQXDL3eJAYQMXl2c=;
        b=l+/+2nzJLHbhGSgNQn9ykrQGuPlfQXIg+qNHNp2Gd5kiH0/6mnQ3OLgZEYMLXtDHQE
         U2xU7sv/zvSc9Qw3B0lqzws37i6Xc9IR/7DMEBDIG2w5mG85/p43JjkvjhivOs7SkHZE
         YYVugids2ze5EqBFZmPNcnuSs8bradby2xAZPf7Z2S6gfdscY8J2lP6ac/94og252Pz9
         ogu1uUmwOTpkqwolStudoKz2OvIshMdQyLwBTchGfFj+L+PqEPxj1DoJYHWDcjUKjcv2
         kXRV5BdOGuh51uOorD+cQMOaMpuvKo/9SkT/78J/SW1eCaVVmt+aUVTscZxwO6NjFQb6
         bpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YHuVinq2W+VUpnKIF/OqtrZzHroQXDL3eJAYQMXl2c=;
        b=s0P14tY8FcyrdY9uY3yUG6UWMS1PV+5GZQ0ZfxvASMl+hUaEJ25OeiaWrULx8ZBm/o
         2Mw6/af2+pdZxigHmVC7uY9+EvWGkBEMv07PT/Ocpu/deQsmFgapqLJWZBxKKABxvDQQ
         MGtdp/fCFmA2TaKzz6Y1bZLY2stTduvwGjN4uX2Mv6bC+xCMjqlX/n8csFSeVWRBmosP
         yTVKgaGNb8bc5bTmG7Y2Aj2vDXTT0LdzOtbNXVjgXEsqz5IDLEDckPIv8t3/z+0kZqzg
         9CSlQxNxmYG2BxisHWoc3U32UWeq24j9huwxOmENU/gebb/dQHd/dlRQwxeRhHlQNpf1
         SqLg==
X-Gm-Message-State: AO0yUKVoK+7xjMkmG1YgNsFaSczkHfoyIcSesKQ/2UBm4os0E6/kCRq4
        KBZl0eClsB4zNEk9TwBVsV+p5jYcP9t2y9fB
X-Google-Smtp-Source: AK7set9qvp7jrDP3G5VX6vZduop5yMR37fVO9/OkK0SmVusEyPp7n31xR+HDNBGRtJoNTzi7W6QnjQ==
X-Received: by 2002:a17:907:8810:b0:8a9:e031:c4ae with SMTP id ro16-20020a170907881000b008a9e031c4aemr4244306ejc.2.1675802219534;
        Tue, 07 Feb 2023 12:36:59 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id gu8-20020a170906f28800b008aabe1ae0d4sm623415ejb.9.2023.02.07.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:36:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPUi1-000zyl-2r;
        Tue, 07 Feb 2023 21:36:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 07 Feb 2023 21:18:33 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
Message-ID: <230207.86k00t2owm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Jeff King wrote:

> On Sun, Feb 05, 2023 at 03:46:21AM +0000, John Cai via GitGitGadget wrote:

> From the user's perspective, this is weirdly inconsistent with the
> existing diff attributes, which would be more like:
>
>   # in .gitattributes
>   *.json diff=3Djson=20
>
>   # in config
>   [diff "json"]
>   algorithm =3D histogram

That does look more elegant.

> I know why one might choose the scheme you did; it kicks in if the repo
> sets the algorithm, without users having to set up any extra config.
> Which is sort of nice, if we assume that malicious actors don't have any
> incentive to pick the algorithm. In theory they don't, though I saw =C3=
=86var
> mention possible DoS elsewhere in the thread.
>
>   Side note: It's also possible that algorithm selection could be
>   required to trigger a separate security bug (say, a buffer overflow in
>   the patience code or something), so restricting that works in a
>   belt-and-suspenders way. But that somehow feels like like the wrong
>   side of the paranoia-vs-feature line.
>
> So I dunno. I recognize that this scheme fulfills your immediate needs
> better, but I fear that we'll be stuck with a weird split between "diff"
> and "diff-*" attributes forever. In the long run, having a way for the
> repo to say "and here is some config I recommend to you" would give you
> the best of both, but that is a challenging topic that has been
> discussed and punted on for many years.

If (and I'm not taking a stance on whether this is the case here) we
think that a hypothetical .gitconfig in-repo combined with
.gitattributes would be more elegant for this or other cases, I don't
see why the path to some very limited version of that where we read
literally one whitelisted config variable from such a .gitconfig, and
ignore everything else, wouldn't be OK.

I.e. the more general in-repo .gitconfig discussion (of which there was
some discussion this past Git Merge in Chicago) includes potentially
much harder things

Like what to do with changing genreal in-repo config, if and how to
compare that against some local whitelist of what sort of config we
should trust (or none) etc. etc.

But if we agreed that we'd be willing to trust the remote with some
config-by-another-name unconditionally, as is being proposed here, we
could easily read that one thing from an in-repo .gitconfig, ignore
everything else, and then just document that interface as a
special-case.

We have several such "limited config" readers already, and the relevant
bits of the config parser already have to handle arbitrary "git config"
files in-tree, due to .gitmodules.

We even have special-snowflake config in the configspace already that
doesn't obey the usual rules: The trace2.* config is only read from the
--system config, as it has an inherent bootsrtapping problem in wanting
to log as early as possible.

The advantage of the limited in-repo .gitconfig would be that if we
think the interface was more elegant this would be a way to start small
in a way that would be future-proof as far as the permanent UX goes.

If there's interest the read_early_config(), read_very_early_config()
and gitmodules_config_oid() functions are good places to look.

The last one in particular could be generalized pretty easily to read a
limited in-tree .gitconfig.

Although plugging it into the "config order" might be tricky, I haven't
tried.

Even a minimal implementation of such a thing would probably want a "git
config --repository" (or whatever we call the flag) to go with
"--local", "--system" etc, to spew out something sensible from
"--show-origin" etc.
