Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9BC4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57042613BF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFEBJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEBJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:09:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17589C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:07:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so1531473wmq.5
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/jUqJ73rZCt9LIqpBDJpkrdS//kXGAx6J+fidYAZOcQ=;
        b=AWUCzuSrnFHq9g30FG1S0LyimLzEpJ8re3omCLmtnF713XEcF7cXSnSFrg7DOeiX2f
         7BZxOcTyHaQ9fIVby/d4XD6lJfHvs5nEPFX4XcflmBrphGXKSxqKNuj+pOPrU5mD/+Rl
         /9Q2C27UHY6RO9WhIJ8mvTbULHPG3C/FUaeXxruoN6aXJKq36daZSq2QU7tJlw3ttJMe
         tO7Ux8IZzcTXPlgAXdEFrU5CdsYijrV+Bkswqdw7Wt70nxVit5SO20QLhyo36PREwICf
         PoO3qufv4J7M0PjhUg5E7Qus+il3iqkefRmgfpTeu6Sou13gbp/TljthKumXoHkxzSaY
         fQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/jUqJ73rZCt9LIqpBDJpkrdS//kXGAx6J+fidYAZOcQ=;
        b=k6yqCOFGhhYFF2udsH/AprpIdx/fWmPYoDGVqYfM7vLr819S7aZYvF0zR3AEqYol7j
         4kxZ1FPHF3x6xscK/HyOlcQZii4fgw8x0JsHrk++0s36UUvq/F8uytDeU4cq2TKZBMQq
         sd4Qgg4KF723JsUefTLMeFKc/voJRjPGb+dD0Ya98PKF+hFsVBPvCrCczgSlD5Er7LtA
         HYMIXwj+5sbmFbBC7JJPT+qqstsqtgJ2Qb9F9AXOxePOx6HcXTQh8zUdQxLOzRauXnDL
         tamxRw3CLNCbcYO49H+5014hcyTC4Qam8k0340wFliXvL2iYT3MoHWw0WY3WvGIoCBql
         WYug==
X-Gm-Message-State: AOAM533YGrG0TySKeW43WfTpb1DDbQ1gz61agl9eVwFiD1QcJPefWJMu
        hAtZABASIzQEE+JgQ150yBB0/Qlh5gePAV/0iF4=
X-Google-Smtp-Source: ABdhPJwTpAHlcXjrVT11Nd2MBaKNzNPGhkYX82nBsBI70oJ7W9m720KO/0DSWa52/ta25OYjz2VLxUfsy+SCAic0MBI=
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr5782457wme.173.1622855253511;
 Fri, 04 Jun 2021 18:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com> <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
 <60b93a264cb7_39da0420855@natae.notmuch> <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
 <87lf7p5msj.fsf@evledraar.gmail.com>
In-Reply-To: <87lf7p5msj.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Jun 2021 20:07:22 -0500
Message-ID: <CAMP44s2FrZkbPbi+vFxD1dLfZPtKeJ2QZk5Gk0HgQjMgE_3Rbg@mail.gmail.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 4:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> On Thu, Jun 03 2021, Jeff King wrote:

> I have some incomplete work somewhere to slurp up all the package
> sources I could find in the wild (SRPM's, Debian recipies etc.) and
> their patches, the aim was to submit it into contrib/ so we could see
> what monkeypatches to git.git existed in the wild.
>
> Last time I looked at those (and this is from memory, and it was a while
> ago) many of those patches / build recipies were simply blindly skipping
> or otherwise working around test failures.
>
> So we can't assume that failures in the wild are reported to us, and I
> think many packagers are not running any of our tests at all. If it
> compiles and seems to work they're probably just shipping it.

Arch Linux boasts of following upstream as closely as possible, I
looked at their build instructions for the umpteenth time to see if I
could find anything interesting. While they don't have patches, they
do have NO_SVN_TESTS=3Dy (plus a bunch of `cp contrib/*`).

So I don't think any packager can just blindly trust the Git project
to do the sensible thing here. Who uses subversion anymore? And who
that still uses subversion wants or needs git-svn? And why would
failing any of these break the release?

Maybe we need some "test-packager" target that limits the tests to
something sensible. Ideally it should be the other way around:
packagers run `make test`, and developers `make test-developer`. But
that's a bigger discussion.

Cheers.

--=20
Felipe Contreras
