Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799FC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E5960F9B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhJYNJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhJYNJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 09:09:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9DC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 06:07:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso9294651wmd.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OLv+xj7vWgwk3/5A94+n4n/hAqUr511+qk8hPdYhJ/U=;
        b=hohVlVcgDSu4X/woJEjXgZRXb2i5iqd2PU2r6S5FRQjeab/gKWeBMAMCPyVBYDXipk
         t8YBf/dTbJBdUZg1dcBqqsSTvhzOnEi6y53zVMEuCP3o93HS79Rg+bmm9kCRSqFoqG8C
         DGswsoi87mMYEpMztzeEV39KImcSDL9PekQDTXeOKjWSMagVFTwS9p2snC+8RKTa2PQq
         a8RaPuM8ARmvfs3WajXAcPEEo4jYAzgzQfyl/iQQsNN+/xLj/sxVLAWL5ELwkgdbVysi
         ghb69dr6BI2x+tvHH5HHs5oVcoKoiPhzMvYGA1i4RwSS02jkF070dQ5PkMAhJC84f0iX
         90Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OLv+xj7vWgwk3/5A94+n4n/hAqUr511+qk8hPdYhJ/U=;
        b=30dOAImDxj24taLYm+BjlBoJqmOxr37wFlm+funyCZBPGFjOioWxvBbmBVGZutTP1i
         D2hY2EVj92RXE3XHDH4rX5wPwK8dVXsLe+1WctZ0uZVkQEbRM9UgpqMeV2fZhhE9zA/2
         ahVDZCwu8gOXXthHt9Cx8hCIySEOkQHAGeuxQybptgSduImeMewfOwsADV5iXBdCKf2h
         Mviy1na08CSbJhtBViy36Ee0xc2tCqjgQ1jOTi9Pq6QFJMmxMwYyFE1BwtrG1SWVohv+
         ng2YlgmoiVtx9G+7kcjN0KHhs3PtNBjZn7tHsQ0SuqWgBZ5UnrlxeFvgvNSrG+moElYh
         r5eg==
X-Gm-Message-State: AOAM531UmZ2x1btvSACcGoRLOL/x2nPsSMLxJEzUV3fjoVcwMkesWCkT
        FkAOdbR/S+JcnJKcXIMliQhtOXeXW5IbPA==
X-Google-Smtp-Source: ABdhPJxUi7NaTmwyHh6W9y0YTU0UNUj0F4HQAbQfSK7oru5nVLF7/p9ILrZKFHxnoWeno9a40N5FOQ==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr10860889wmk.184.1635167252981;
        Mon, 25 Oct 2021 06:07:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r11sm1802211wrx.79.2021.10.25.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 06:07:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mezhM-001XRM-4Y;
        Mon, 25 Oct 2021 15:07:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Date:   Mon, 25 Oct 2021 15:03:20 +0200
References: <cover.1634077795.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <cover.1634077795.git.jonathantanmy@google.com>
Message-ID: <211025.86lf2hgsmj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Jonathan Tan wrote:

I tried sending the below (sans some last minute spellchecking now)
around October 19th, but for some reason it didn't make it
on-list. Trying again now, apologies for [near-]duplicates, if any (I
elaborated a bit at the end just now).

> Previously [1], I sent a patch set for remote-suggested configs that are
> transmitted when fetching, but there were some security concerns. Here
> is another way that remote repo administators can provide recommended
> configs - through conditionally included files based on the configured
> remote. Git itself neither transmits nor prompts for these files, which
> hopefully reduces people's concerns.

I had some concerns about the specifics of the implementation/what
seemed to be tailoring it a bit too closely to one use-case[1][2], not
inherently with the idea (although I think e.g. for brian that more
closely reflects his thoughts).

Anyway, just saying that aside from this RFC I don't think we were at
the point of really fleshing out what this would look like, and there
being some hard "no", so I think that idea could still be pursued.

On this proposal: this also applies globally to all history, but I don't
have the same concern with that as the 1=1 mapping of remote-suggested
hooks, our path includes work that way, after all.

I think it would be nice if you could think about if/how this and the
"onbranch" include would work together though to serve the general case
better.

Also if you have a repo with N remotes each where "origin" tracks URLs
at git.example.com, and you add a "dev" tracking dev.example.com, will
the config apply if you're say on a branch tracking the "live" server,
if you've said "include this for repos matching dev.example.com?

Arguably that's what you want, but perhaps something that those more
used to the centralized workflows wouldn't consider as being unintuitive
for users who might want to add this config only for their main "origin"
remote. We don't really have a way of marking that special-ness though,
except maybe checkout.defaultRemote.

I'm also still somewhat mystified at how this would better serve your
userbase than the path-based included, i.e. the selling point of the
remote-suggested configuration was that it would Just Work.

But for this the users would either need to setup the config themselves
for your remote, but that would be easier than pro-actively cloning in
"work" or whatever? I guess, just wondering if I'm missing something.

Or if it's a partly-automated system where some automation is dropping
in a /etc/gitconfig.d/google-remote-config-include I wonder if this
whole thing wouldn't be better for users with such special-needs if we
just supported an "early config hook".

i.e. similar to how we read trace2 config from /etc/gitconfig early, we
could start picking up a hook that just so happens to conform to the
config schema Emily's config-based hooks use.

So the /etc/gitconfig would have say:

    hook.ourConfigThingy.command=/usr/bin/googly-git-config
    hook.ourConfigThingy.event=include-config

That hook would just produce a config snippet to be included on STDOUT.

Since it's an arbitrary external command it would nicely get around any
chicken and egg problems in git itself, it could run "git remote -v",
inspect the equivalent of an "onbranch" etc. etc, then just dynamically
produce config-to-be-included.

Please don't take this as some objection to your current proposal, just
a thought on something that might entirely bypass odd edge cases and
arbitrary limitations associated with doing this all in the "main"
process on-the-fly.

The special-ness with that one would need to be that we'd say it
wouldn't have the normal "last set wins" semantics, or maybe we could do
that and just note that we saw it, and execute the "include" when we
detect the end of the full config parsing (I'm not familiar enough with
those bits to say where that is).

Both of those seem easier than dealing with any chicken & egg problems
in parsing the config stream itself, since such a hook could just invoke
"git remote -v" and the like itself, after e.g. setting some environment
variable of its own to guard against its own recursion (or we'd do it
for it for such hooks...).

1. https://lore.kernel.org/git/87k0mn2dd3.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87o8awvglr.fsf@evledraar.gmail.com/
