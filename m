Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0871AC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5AE22D2C
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 23:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLOXFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 18:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbgLOXEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:04:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A82C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:03:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b9so5124322ejy.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3EuazkXaNnmRiNYbnroCJ3gwNZc0BWpZXP3j25bUljc=;
        b=b9XO/FdcPU+UENBeyhxvaKVi6PA6RsHKRLyAfXDMSWZUY/2Hi4YjMADoV3153N27lf
         wmkNbZkCAOyJTVFXPcmmM7JZhFp/SXhrR+YnP4AjyHTEIXD3HkBb/bfFZOHlmlQx9iYy
         OWjaCNvXX8QoRZN6WYtScTGek8CBNu00c2rWqTt4L3/EFz9OH2JUminCi45vbWAd0RK8
         9fN/p5pePTMXwmFRG1IHjA2wIobLJDzTKGFRAaMDJI/K+uKBNvaCIc9hYQxgUCED1Hfu
         PRfKtRws98sNvfFuPKylYowVbY1hmnO+OaZeUKM81vKmn/57Z0dSB084cOoI6mlzy0QT
         HPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3EuazkXaNnmRiNYbnroCJ3gwNZc0BWpZXP3j25bUljc=;
        b=IISuzK/G7kcUIz5/RJMdo92GPYhR5LxzTNOXrDnXRK0Hkoe+vDbiw/Pu0u6kk703tH
         9f3CREn31tWHyK8EfG9gWE1MEMpaMbgSdeytnfndow9a6B51gMMRmJ4Oycp82N3rQ5Vr
         LLB4/E/JiVulUM4996ltWjJcD5AmyaJuyh+7z1aaF0yd0hZi89sLHOgPivXJ1fYU7V7N
         8j54EbKgWTMBtiKsWtitfigWyc1zjoMNFxYufjZimKujEGCdUjXcjTItebZUE0wr4zHk
         hf7MaQuRuc43D2wOvXxf0ewj5Tpl6gtaPIPNT2r+njM0Ame0hhNgz8XdhmQ0BtTNrHD4
         p/7w==
X-Gm-Message-State: AOAM5318A4LH94P6i5PAnLis8EotCrVpSGlSHwAPKck8dOuZ1nRlHL/X
        axLP78HxoQ+QYUQqskNl6fQEBU50vj6U6A==
X-Google-Smtp-Source: ABdhPJxsdUu1AY+uJFxIW0c9cdbfODtM3d8X8uF75OeL5gcbekD7U4vj5XM4zzRX0MrBqRfytIAyOQ==
X-Received: by 2002:a17:906:7090:: with SMTP id b16mr29149032ejk.76.1608073423584;
        Tue, 15 Dec 2020 15:03:43 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id e19sm20239186edr.61.2020.12.15.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:03:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stuart MacDonald <stuartm.coding@gmail.com>
Cc:     git@vger.kernel.org, Raphael Stolt <raphael.stolt@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
        <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
        <20170511234259.gnbr6aiu26oqysxo@sigill.intra.peff.net>
        <CACBZZX7-Gw7G7yY=ah6AQCJKzWKB002iAo6RNJwZmvMRe4Pd+w@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
Date:   Wed, 16 Dec 2020 00:03:41 +0100
Message-ID: <875z52wu2a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 15 2020, Stuart MacDonald wrote:

> Hello,
>
> I've seen this thread:
> https://public-inbox.org/git/F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com/t/#u

[I took the liberty of CC-ing the original thread participants & adding
the Message-Id's to the "References" header, hopefully the archive will
thread it and this together for future spelunking]

> and respectfully disagree with the conclusion. Conditionally included
> configuration can contain items like core.sshCommand that are required
> for git clone while in a normal non-git directory. These should be
> displayed properly so users know what configuration they are operating
> with.
>
> Also, conditionally included config is acted upon despite not being
> displayed. This makes tracking down problems much more difficult.
>
> Further, most complaints online are about user.name and user.email not
> being displayed correctly. If those items are in ~/.gitconfig, then
> they are displayed in a normal non-git directory by normal git config
> commands. This makes conditionally included configuration display
> inconsistent with regular configuration display. Inconsistency is bad
> and should be fixed.
>
> See 'git bugreport' attached for further information, reproduction steps, etc.

As the person with the last reply in that old thread & only a vague
recollection of it until I re-read it now: please don't take a "why
would you want this" question as dismissive of the use-case, but in
invite to tease out some of the nuances.

It's often easy to vaguely conceptualize a feature, but the hard work is
dealing with all the edge cases & emergent properties of something like
new IncludeIf semantics.

There's two interesting questions here: Is the current feature buggy (or
just has surprised but ultimately consistent & correct semantics), and
could we have some new IncludeIf use-case that covers use-case Y, where
now we can only do X?

Junio covered that in more detail in his reply.

Neither you nor anyone reading this from the archive later should read
that thread (or this one) as some refusal of a feature that does Y.

Whether we can have that ultimately depends on whether someone's going
to invest the time in coming up with patches for it, and in writing
those patches will either figure out all the expected & unexpected edge
cases involved & get past them, or not.

But it's not a "no" until that point (and not even then, maybe we can
keep the general idea of Y, but have Z which is mostly the same & works
for most people), it's just "nobody's really worked on it yet".
