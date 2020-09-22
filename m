Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7CFC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 04:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF9723A1E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 04:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="hNCuBBBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIVEdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIVEdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 00:33:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFFC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 21:33:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so15471964wrs.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fjotU3X6oTWz46B0O4FddFdPX9tx8oXzx/3HksMIIVw=;
        b=hNCuBBBqtn7Q2KwXYOSnkWf9Z7SJC5rw3WNqsuL8KMj+KfltnwAVIFZS/cv/syjSHF
         WsX23la+GCq738HgB1JsdmTLudHC2Da39UFwBO8vr7DnYEOLdmba5Rb6oSLhesXNAPZ1
         e2vlCnIvmkKWnyXB0IvcyZKOSTPPyZ2KncjHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fjotU3X6oTWz46B0O4FddFdPX9tx8oXzx/3HksMIIVw=;
        b=aCHt5fPFX0UWLSAeOL6OiYSnMPkSeOMqTM99XGcxIGLYlskjdq/IGy2qbp/uRm2u0M
         2x8wRo7NjCarYFh8Mf7+8QUdONN13K278tyCrgfiQFRiM1JQtzttkw2ee0Pezq4PNr69
         M9vgdE7o2gK63s9WrTGeQBslZIrhW/kQbqIeBpMX6KwBhtYU9cyO9T9l1u8OfVlH2Q8g
         KB6Vh4WVFu5vWa3rpp73RHLGwY47BOV2ERN9fwrBSMeYU687iuJ8S1UjGedHUA5vNvie
         qnejRCmcT2ly+FaPTW58OesQNWeWkPOfgzgM7brFkKx63gVAwS/XGZIBW3C7xnaTgn/q
         EkYg==
X-Gm-Message-State: AOAM531WAjOH0TZmOem87OZposFrK4ydWd8ANt3NgIaQSDzvKdANNoUH
        vxnGASy2zkqdeuo3bh1j5NSnwJrvy/Kq18o8UV9ARg==
X-Google-Smtp-Source: ABdhPJx1sLs3pJ5DHNWZ5rxvLUvwRr9/GT4iuLoU094j+2Sq5ylDCtPIAzIKw91ePI7ZbrtRZXTOmw7jFKr7jrfW2FY=
X-Received: by 2002:a5d:6912:: with SMTP id t18mr3201673wru.326.1600749187522;
 Mon, 21 Sep 2020 21:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
 <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
 <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com> <FFBB71FD-8D1F-4E86-9E37-813018AFC690@gmail.com>
In-Reply-To: <FFBB71FD-8D1F-4E86-9E37-813018AFC690@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 22 Sep 2020 05:32:56 +0100
Message-ID: <CAE5ih7-PsGpirnPVnCP__11qYBXeuP=tjQ9MC_d6oby-uqJy7A@mail.gmail.com>
Subject: Re: How to checkout a revision that contains a deleted submodule?
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Sep 2020 at 00:14, Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Luke and Kaartic,
>
> > Le 20 sept. 2020 =C3=A0 14:02, Kaartic Sivaraam <kaartic.sivaraam@gmail=
.com> a =C3=A9crit :
> >
> > On 20/09/20 3:14 pm, Luke Diamand wrote:
> >> On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
> >>>
> >>> Maybe this is a FAQ, but I couldn't figure it out!
> >>>
> >>> I have a repo which has a couple of submodules.
> >>>
> >>> At some point in the past I deleted one of those submodules:
> >>>
> >>>     git rm sub2
> >>>     git add -u
> >>>     git commit -m 'Deleting sub2'
> >>>     git push origin
> >>>     ...
> >>>     ... more commits and pushes...
> >>>
> >>> Now I go and clone the head revision. This gives me a clone which has
> >>> nothing present in .git/modules/sub2.
> >>>     login on some other machine
> >>>     git clone git@my.repo:thing
> >>>     cd thing
> >>>     ls .git/modules
> >>>     <sub2 not present>
> >>>
> >>> So when I go and checkout an old revision where sub2 is still around =
I get:
> >>>     git checkout oldrevision
> >>>     fatal: not a git repository: sub2/../.git/modules/sub2
> >>>
> >>> What am I doing wrong?
> >>> What set of commands do I need to use to ensure that this will always
> >>> do the right thing?
> >>>
> >>> Thanks
> >>> Luke
> >>
> >> Replying to myself, adding Jens who added the section below.
> >>
> >> This is a known bug:
> >>
> >> https://git-scm.com/docs/git-rm
> >>
> >>> BUGS
> >>> ----
> >>> Each time a superproject update removes a populated submodule
> >>> (e.g. when switching between commits before and after the removal) a
> >>> stale submodule checkout will remain in the old location. Removing th=
e
> >>> old directory is only safe when it uses a gitfile, as otherwise the
> >>> history of the submodule will be deleted too. This step will be
> >>> obsolete when recursive submodule update has been implemented.
> >>
> >
> > I don't think that part of the documentation applies to your case.
>
> I also don't think this part of the doc applies here.
>
>
> > So,
> > I also don't think this is a known bug. As a matter of fact, I couldn't
> > reproduce this with the following:
> >
> >
> > git init checkout-removed-submodule &&
> > cd checkout-removed-submodule/ &&
> > echo "Hello, world" >foo &&
> > git add foo && git commit -m "Initial commit" &&
> > git init ../submodule &&
> > cd ../submodule/ &&
> > echo "Foo bar" >foobar.txt &&
> > git add foobar.txt && git commit -m "Foo bar baz" &&
> > cd ../checkout-removed-submodule/ &&
> > git submodule add ../submodule/ foobar &&
> > git commit -m "Add foobar submodule" &&
> > git rm foobar/ &&
> > git commit -m "Remove foobar submodule" &&
> > git checkout HEAD~ # Checking out the "Add foobar submodule" commit
>
> Yes. At this point "foobar" would be empty because '--recurse-submodules'=
 was not used
> on 'checkout'. Using `git checkout --recurse-submodules HEAD~` instead wo=
uld populate it,
> and it would work correctly because the Git repository
> of foobar does exist at .git/modules/foobar.
>
> > I also tried with a cloned version of that repository as follows:
>
> here let's make sure we re-checkout 'master' before cloning:
> git checkout -
>
> > git clone /me/checkout-removed-submodule/ cloned-repo &&
> > cd cloned-repo &&
> > git co HEAD~
> >
> > I get:
> >
> > HEAD is now at 25270d8 Add foobar submodule
>
> I get the same thing, with or without '--recurse-submodules'.
>
> However, if I you have the 'submodule.active'
> configuration set to '.', which is the case if you *cloned* with '--recur=
se-submodules',
> and you then checkout with '--recurse-submodules',
> then it fails as Luke describes:
>
> git clone --recurse-submodules  checkout-removed-submodule cloned-repo
> cd cloned-repo &&
> git co --recurse-submodules HEAD~
>   fatal: not a git repository: ../.git/modules/foobar
>   fatal: could not reset submodule index
>
> This bug was reported earlier in May [1], and I suggested a couple ways
> the experience could be improved.
>
> I might add here that maybe a good idea would be that 'checkout'
> be taught to try to clone the missing submodules if it does not find thei=
r
> repository at .git/modules.

I was thinking this myself. I think the code change might be quite
straightforward.

I added a test case for this problem here:

https://lore.kernel.org/git/20200921081537.15300-2-luke@diamand.org/

I think I could probably have a go at redoing this with an attempt at
a fix to get `git checkout` to clone missing submodules.

Luke
