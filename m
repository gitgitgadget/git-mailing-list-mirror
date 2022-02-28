Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BACBC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiB1Qyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiB1Qyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:54:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6D27B10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:54:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so1357393ejc.6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DAZYtKG9VEVR0VogDk9+wRkHx8P6TNJcNMYjghCgEM0=;
        b=Yu8UDAZLhTZcu1uiOqFFF/Mzx5tAOjElMFlsNWEvqeMAxwvoliHpe241hAtfIZ2+FJ
         zbQGGkb5ke1OVFIvvQTA6baYdEU4ST8/lsHZGmI0dXNdDaZikHjlJWDpLQ6U5D3bKdWg
         N6tGBNtx1fKRArofGCn15CZ5eU5yAaXZ1F48SJPK3hOBgS7SLUY1LiwSmSHTgVnxASDi
         xo+hpgkibzTZy3ya9hKIuHmN9fC8kb+wGerM0avP6qBDfgyvy6/xHcKZqjuPKdEDTZtS
         iN6QysJd5CCymN4d0sWVP88De9fVop+3ed2pcLUJzrsUrz0gtD85qAx2E9KoQNNt3Y1O
         K1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DAZYtKG9VEVR0VogDk9+wRkHx8P6TNJcNMYjghCgEM0=;
        b=4rpqahE/albEh6IA1V3vNVX2h8d67ifN0ftPYyUhjkt4nznXn/jt8gqUetpzCUZFv+
         BMKXfpD7ti/MYXUF321XzdfpXLE25tNhEfHkWVjwKN6q8M8jrOJ6vOb+RhaFLMw+xrHT
         PXq1UA4P/CmXR7gC+HNEDVfG9go94W2EH60JKdx6VOD47Vt4yrnVeKX+NJNTpE7jJqfI
         pM1THRQi5agMoQkmijIYTbj5C8e0Ztxc5q7qkii05WQUMqbiovkkco5iReZQN0lGTeCT
         m2dKiBey+j64MjCtNL2AypSjupnD9ajVlQXnOsUhcwFdjSBgQtNBSHxBQ/Ws5fLOhckh
         hHQg==
X-Gm-Message-State: AOAM531kwMPuDsboyaoWgDix5vxL1rYe+wKB7ksyB4y6kQcPLj6Gd7ni
        yynd1uu0cCZH6jmViwTpnspKZ854V30=
X-Google-Smtp-Source: ABdhPJxaBu7oBvId7mR9vacbHnPS4UfgqYHS+HxY1LNtx25wYMh61LXT8uOQ9yVN6f3+RA73Tje03Q==
X-Received: by 2002:a17:907:b96:b0:6d0:ae6:d153 with SMTP id ey22-20020a1709070b9600b006d00ae6d153mr15377703ejc.699.1646067244138;
        Mon, 28 Feb 2022 08:54:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7d50a000000b00412b12a2eeesm6202000edq.67.2022.02.28.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:54:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOjHe-001Tvc-Ui;
        Mon, 28 Feb 2022 17:54:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 0/8] fetch: add repair: full refetch without
 negotiation (was: "refiltering")
Date:   Mon, 28 Feb 2022 17:43:28 +0100
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
Message-ID: <220228.86r17n2aqd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Robert Coup via GitGitGadget wrote:

> [...] While a key use case is described
> above for partial clones, a user could also use --repair to fix a corrupted
> object database by performing a refetch of objects that should already be
> present, establishing a better workflow than deleting the local repository
> and re-cloning.
>
>  * Using --repair will produce duplicated objects between the existing and
>    newly fetched packs, but maintenance will clean them up when it runs
>    automatically post-fetch (if enabled).
>  * If a user fetches with --repair applying a more restrictive partial clone
>    filter than previously (eg: blob:limit=1m then blob:limit=1k) the
>    eventual state is a no-op, since any referenced object already in the
>    local repository is never removed. More advanced repacking which could
>    improve this scenario is currently proposed at [2].

I realize this was probably based on feedback on v1 (I didn't go back
and re-read it, sorry).

But I feel strongly that we really should name this something other than
--repair. I don't care much if it isn't that :) But maybe
--expand-filters, --fleshen-partial or something like that?

So first (and partially as an aside): Is a "noop" negotiatior really
want we want at all? Don't we instead want to be discovering those parts
of our history that are closed under reachability (if any) and say we
HAVE those things during negotiation?

I haven't tested, but maybe that's just more complex, e.g. you have a
filter that's excluding >500MB blobs or whatever you might have the full
history already, or maybe that 500MB blob was added last week, so you
have almost all of it.

But wouldn't that be a lot kinder to server resources + network at the
expense of some (presumably rare) extra local computation?

But secondly, on the "--repair" name: The reason I mentioned that is
that I'd really like us to actually have a "my repo is screwed, please
repair it".

But (and I haven't tested, but I'm pretty sure), this patch series isn't
going to give you that. The reasons are elaborated on in [1], basically
we try really hard to re-use local data, and due to that & the collision
detection will often just hard die early in object walking.

But maybe I'm wrong, have you actually tested this with *broken* objects
as opposed to just missing ones with repo filters + promisors in play?
Our t/*fsck* and t/*corrupt*/ etc. tests have some of those.

And maybe I'm making a big deal out of nothing, but I fear that by
naming it --repair and giving it these semantics that we'd be closing
the door on things that are actually needed for some of the trickier
edge cases when it comes to repairing a bad repository.

Including but not limited to having a loose BAD_OBJ, and needing to
replace it with another loose object (due to the unpack limit), the
branch we're updating can't be read locally, but is at an OID that's
(re-)included in the incoming pack and is hopefully about to repair our
repository.

Or even that we have a SHA-1 collision, but we intentionally want to
override the collision detection because we know our local repo is bad,
but the remote can be trusted.

All of which are much more involved than just the "fleshen partial data"
you're aiming for here...

1. https://lore.kernel.org/git/87czo7haha.fsf@evledraar.gmail.com/
