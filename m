Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B2C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 07:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiDNHUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiDNHUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 03:20:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA14665C
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:18:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so8286710ejc.10
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qaW5ME81NXd6ixXTR+zePzxaZ7eL/ui8m+dsR9dxEDw=;
        b=BhOHQjacjYz+0h/F2VFP1y7ZiBaQ0x/pw+afa1oW/4W2sweRtIP52lFlCsLk5Eg1QR
         kqH42FQ2QjQmWFMjz8MBpvXSxk9MGn9YBlCSIHniXa/p0vYSw2RJGnKOEVpoc2UkVUp8
         48jZ/wSGYwRRjbZxIuC+q1OCixMXjhiuoYLbT0DNAzX+aa2CBwoXCt0oXMSzyoJBh+nn
         7jpPc6lc2foeTSpSLwdltEkQwDqrRQiEeQIJenS5lH323OFUpP9XOx3ewU4V+eTgZem7
         HCTgWammh7Re88VUvC+RF5GZmRfJxoEGAFNMEnYnMZKde15lTDxXJF3CE8EX9ACCkqwz
         tbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qaW5ME81NXd6ixXTR+zePzxaZ7eL/ui8m+dsR9dxEDw=;
        b=aLV3+n9dLRuQKAwW3z32cN1DUM75aO+OZm0h+jyMlAebL+uW88oHvGGMWWGRoh989V
         fSY+X9rHRtCWts7j8/NntF8YcIquoHdEWm+xsK+AnnZgUShFLW4RupJQIXmXrdoVwbxG
         mXj6fEecVQrq1zB+PE9OFPmicVVPoUFUYKatmIk3rFX/R2yl7dsqnVpssEbm18Y2KotL
         TUV7AFDWufNfK1BTBAb4+/TZkowGubph5j+5RhROl34gIkO9ZGwsX31PUbHdvElnLU1i
         Q8dmEY7Uk2hfhxaEBOiaxjRmcORie/DivUy36xq8D/zoCy9D9ZbbdBfmeXDQQ09LXY3K
         DHeg==
X-Gm-Message-State: AOAM5330w6fk9xX9YfuZcLafGbpf8B3GMMLHHktS5tivPwxxRa2RDhtM
        fzCNMswG3RUgu1Tihn0AxVxOWcDGp0l9lg==
X-Google-Smtp-Source: ABdhPJzSb6R12eM7NA27Q3zSSqgpFpM3rRQ8s8Sd9pQpeB/BTipad2sicw6dQqcvJ15+bjXtqg9dgw==
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id i3-20020a170906444300b006cf6a7d5f9bmr1197840ejp.12.1649920707085;
        Thu, 14 Apr 2022 00:18:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906408600b006e87d654270sm359814ejj.44.2022.04.14.00.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:18:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1netkH-005Ft2-MY;
        Thu, 14 Apr 2022 09:18:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Pathological performance with git remote rename and many
 tracking refs
Date:   Thu, 14 Apr 2022 09:12:20 +0200
References: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
Message-ID: <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> In my day-to-day work, I have the occasion to use GitHub Codespaces on a
> repository with about 20,000 refs on the server.  The environment is set
> up to pre-clone the repository, but I use a different default remote
> name than "origin" ("def", to be particular), and thus, one of the things
> I do when I set up that environment is to run "git remote rename origin
> def".

Aside from how we'd do renames with transactions, do you know about
clone.defaultRemoteName and --origin?

> This process takes 35 minutes, which is extremely pathological.  I
> believe what's happening is that all of the refs are packed, and
> renaming the ref causes a loose ref to be created and the old ref to be
> deleted (necessitating a rewrite of the packed-refs file).  This is
> essentially O(N^2) in the order of refs.
>
> We recently added a --progress option, but I think this performance is
> bad enough that that's not going to suffice here, and we should try to
> do better.
>
> I found that using "git for-each-ref" and "git update-ref --stdin" in a
> pipeline to create and delete the refs as a single transaction takes a
> little over 2 seconds.  This is greater than a 99.9% improvement and is
> much more along the line of what I'd expect.
>
> I thought about porting this code to use a ref transaction, but I
> realized that we don't rename reflogs in that situation, which might be
> a problem for some people.  In my case, since it's a freshly cloned repo
> and the reflogs aren't interesting, I don't care.

There was a (small) thread as a follow-up to that "rename --progress"
patch at the time, did you spot/read that?:
https://lore.kernel.org/git/220302.865yow6u8a.gmgdl@evledraar.gmail.com/

There's doubtless other previous discussions, I just haven't
found/remember them.

I have (briefly) tried hacking on this myself in the past, as anyone
who'll poke at that will no doubt find "branch rename" and "branch copy"
non-ref-transaction way of doing this are basically other callers with
the same problem.

Before I go any further I think it's good to know how far down this
particular rabbit hole you already are...

> I think a possible way forward may be to either teach ref transactions
> about ref renames, or simply to add a --no-reflogs option, which omits
> the reflogs in case the user doesn't care.  I'm interested to hear ideas
> from others, though, about the best way forward.

More generally, probably:

 1. Teach transactions about N operations on the same refname, which
    they'll currently die on, renames are one case.

 2. Be able to "hook in" to them, updating reflogs is one special-case,
    but we have the same inherent issue with updating config in lockstep
    with transactions.

