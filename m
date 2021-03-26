Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F90C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C97761A27
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCZPdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZPdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:33:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2AC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:33:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dm8so6808526edb.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7n5l6ZqMn604BPcHHs3VdjC32y2cbDUHwLusuJ9Kbss=;
        b=srf5uR2l9Tg5rLV80D5hpLOtaMbivy5O8nRRgeuYYfM1OXgrUEA8IKEObiCsw4sxTc
         QL6Vbcg1f5FahVyoAvxMQ1h82rnAXEMoijAsDb7buKe/Yf8aBqI1KmksM3X4FX+07YXg
         j5gIGNMIux//R/GfVN0ephXi6jxxdKtYn0Q3guUn6b/lDDmQlWlS593KBwYpiAbkZyoB
         hDhMjJWKEdhYX5WfQjsnBivZ7LE4b5SMPr6VX0gjhVCiShZtKxEyfoxKbAtVvKEVoRx2
         GcgQhscC4TxeI7M+VaZC3Tbr7IZyhr6sZkyGYlrl7eAz/iGWNH5XdGKhsCS/N1unjFoM
         p+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7n5l6ZqMn604BPcHHs3VdjC32y2cbDUHwLusuJ9Kbss=;
        b=Qw9Q5Gl1+EhzQ4iL09gUsU/DdO5NsEDBrX/w5qsUOFZt6sHDxE63tK1ggJ1E/888cN
         VWcKoH+QawavSbe6m7FmVJgI1hgaMKLNvClyLGYt2MVbDDXItdRA90/lfZsZmq3iVkZ8
         X3LLkLDPD1A8bYLJWyxXyyj+zigOrkblWVaWPV+xq4gwKAbZMLBqUuOVt7hNrne4CnjW
         Da2pxcc52ly6K/iniwqpsmHKcgyUgL4gqlzCN/rOc4K1gnG2djLfPS/hExu5ew96DbX3
         4Fla0483ymdCgNGNx2Dw2BQPNMnkXb5y0Gcyi/RmrU7rnhBKVXSebzZR7MzsQ9cOckio
         +rlg==
X-Gm-Message-State: AOAM530XpGclEl5yhagn1KE+SXQB4rtqCxNcLKtPsG1QGYAq6mD3/tiY
        t/3wD8VYGtEl9VyH81Un4M4=
X-Google-Smtp-Source: ABdhPJycMrs6Q1M+rfwCUjEyLXHiYyqXqV2jInKaKuhcFOK1w2Arbk0HUahA14LHtkPr4hycuq+e1A==
X-Received: by 2002:aa7:c654:: with SMTP id z20mr15709869edr.377.1616772779672;
        Fri, 26 Mar 2021 08:32:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ak20sm3973198ejc.72.2021.03.26.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:32:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
 <YF2/xPMvwhm+OOVz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YF2/xPMvwhm+OOVz@coredump.intra.peff.net>
Date:   Fri, 26 Mar 2021 16:32:58 +0100
Message-ID: <87pmzmnd5h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Jeff King wrote:

> On Fri, Mar 26, 2021 at 11:36:50AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Lint for and fix the three manual pages that were missing the standard
>> "Part of the linkgit:git[1] suite" end section.
>
> This is a definite improvement. Two thoughts come to mind, though:
>
>   1. Do we need a separate script for this? Couldn't the existing linter
>      script check this while it is reading all of the files (it knows
>      which ones are supposed to be manpages because they are annotated
>      with the --section option).

It's not needed, but I think it's better, one is iterating a
line-at-time, one slurps all lines, they have different sorts of error
reporting (one quotes the whole line).

So I thought about joining them into one, and also make them and
check-non-portable-shell.pl some general lint-line-ish checker.

Obviously all of that fits in one script, but I think for something like
this that's a one-off script with global variables it's much harder to
follow when a large part of your script is some if/else or
keeping/resetting of state simply to work around the script doing two
things instead of one.

I mean, the whole scaffolding is basically:

    use strict;
    use warnings;
    sub report { ... }
    my $code =3D 0;
    while (<>) {
        ...
    }
    exit $code;

We'd spend more lines effort trying to consolidate them than just
copying that around.

> That would be more efficient, and probably a little less code.

This thing takes ~5ms to run on my (and most) boxes, by comparison the
whole asciidoc dance takes some eons...

>   2. Instead of linting, could we just be automatically sticking this
>      boilerplate in as part of the build (either through some asciidoc
>      magic, or even just a plain old "cat")? Even better than being
>      reminded that you forgot something is making it impossible to
>      forget it in the first place.

Whenever I take an aborted effort at the docs I end up with some aborted
effort to migrte them to texinfo, so I'm sympathetic to the automatic
generation part of this.

But for something trivial like this I think there's more value in having
a 1=3D1 match between WYS and WYG, not adding magic blurbs by the build
system for something so trivial.

That being said I wouldn't mind it much, just seemed like an obvious
thing to add a lint for as it stands now...

