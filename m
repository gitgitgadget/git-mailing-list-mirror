Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E4C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B888061428
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhDUTZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDUTZd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:25:33 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:25:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso25874381otm.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IS6h+X12QrRRLw26XjFaRVMCSwZgjreDt2+5arF2DAo=;
        b=ZDVdP6Eg/i6tr9joho4eDSydp7lBSwW9wrEuVwvMIwwn4PJRJmw1YEGCo84C7fSlPM
         2yeMeYanD/iVh+nsC01QgxxlkTXqual8h7CnwcgH3g+irs+k/vMRTsNFnvxg//5JDYsm
         xSOv4JWp9jD0IMlN2veYwJGevYUJ9kwbaVC2OsebjZb5XGoJTTX1SREepgh89KJwbQEk
         HXgqJq8TccKzF7AfSkOYfOMaNFUJKiHCok/n1djV58bAIkjETOpRcqu/M/pPfKKJz/S1
         ssSeGYNaYphNQWDstOKUwZGAB7XFClecNZTpVq9CqbUDsPvgbKzRXQZZLl9CxW6aRAwN
         8HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IS6h+X12QrRRLw26XjFaRVMCSwZgjreDt2+5arF2DAo=;
        b=mbjoKbETnUA1kdGm4PMEIIVIto5WYJphC16z2O7KnbMx5Zq4NoaCJJeyy9RcdRNy6O
         XLr89Q9MJOpD9gYuCcxqC8Fr0cNm1g1m1z2hLTn2Q5VNL60RRkjzMFlz81spn+H//QrJ
         ixeSschz9lf4gMoMNekygznx3B3bFCS5A+45T15wQ7nPRO8XnCbqh9bQdubY47fsDfXh
         pUSmVvt591PpPOyp+gT2Xo9mhOly1oSJi5d5R30/SMEZCwCuTyXhxJcvQB3hBR3EUjM3
         yp0A1cJs4sSAEDA+8mXqibztJQ8PuXwzlF04lGexddZrM/H3zGh9T3dX3/UTFgRp1oql
         NI1w==
X-Gm-Message-State: AOAM533RsTSBgIRGTmYWRDqjXeB1NzksWAC4bO0Dg3tiPsfNdC64SScw
        HGfGpRkcu0duc1E553HALFzANR3X9eSSNSyHsulhi6xJ
X-Google-Smtp-Source: ABdhPJzvjdF0FXQmUdMLWGdx/2kywCCGbKV6bU8R2KwHyQqZgzH+pLOoO5VOOboXpvcOyERHWb2A0NT+0mcyQvdzOjg=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr24577315ott.345.1619033099513;
 Wed, 21 Apr 2021 12:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <xmqqa6ps4otm.fsf@gitster.g>
 <87zgxs2gp9.fsf@evledraar.gmail.com> <CABPp-BFY65wddHHw2Uhortcux+TzMYBZS1wwfnsasYeishXa-w@mail.gmail.com>
 <87h7jz3248.wl-lukeshu@lukeshu.com>
In-Reply-To: <87h7jz3248.wl-lukeshu@lukeshu.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 12:24:48 -0700
Message-ID: <CABPp-BGmztuoKgCgqYGOW9fR=ae0u5p=GupF=n0k9JS2Zy7iwQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 11:50 AM Luke Shumaker <lukeshu@lukeshu.com> wrote:
>
> On Wed, 21 Apr 2021 12:34:26 -0600,
> Elijah Newren wrote:
> > On Wed, Apr 21, 2021 at 1:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > > There's also perfectly legitimate in-the-wild use-cases for this,
> > > e.g. "archiving" tags to not-refs/tags/* so e.g. the upload-pack logi=
c
> > > doesn't consider and follow them. Not being able to export/import tho=
se
> > > repositories as-is due to an overzelous data check there that's not i=
n
> > > fsck.c would suck.
> >
> > Not would suck, but does suck.  I had to document it as a shortcoming
> > of fast-export/fast-import -- see
> > https://www.mankier.com/1/git-filter-repo#Internals-Limitations, where
> > I wrote, "annotated and signed tags outside of the refs/tags/
> > namespace are not supported (their location will be mangled in weird
> > ways)".
> >
> > The problem is, what's the right backward-compatible way to fix this?
> > Do we have to add a flag to both fast-export and fast-import to stop
> > assuming a "refs/tags/" prefix and use the full refname, and require
> > the user to pass both flags?  How is fast-import supposed to know that
> > "refs/alternate-tags/foo" is or isn't
> > "refs/tags/refs/alternate-tags/foo"?
> >
> > And if we need such a flag, should fast-import die if it sees this new
> > "name" directive and the flag isn't given?
>
> Elsehwere in the thread, I responded to some feedback by suggesting
> that perhaps I should flip it around, and instead add a 'refname'
> sub-command, and have it default to 'refs/tags/{tagname}'
>
> So the stream
>
>     tag foo
>     ...
>
> would create a tag at "refs/tags/foo" that says "tag foo".  And the
> stream
>
>     tag bar
>     refname refs/alternate-tags/baz
>
> would create a tag at "refs/alternate-tags/baz" that says "tag bar".
>
> Grepping for "refs/tags" in fast-export.c and fast-import.c, I think
> that would fully address this concern.

Ah, I missed that while skimming and trying to catch up.  Sounds good!
