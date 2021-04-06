Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D4C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D9613C3
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhDFJuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhDFJuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 05:50:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22848C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 02:50:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so14887379iof.7
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gytC150PVNi5bDeSrwBgIdraavLUH+krqw7JUvBRNqE=;
        b=uBORYmyETvMu6uq5TWYHQN7O/XdkLWblZ8iEU7oL8C0PkQZ6kCGZPKldi62vX0Mz8/
         fo3J9sIYJjhdZvBk7W0YR3x/Uj1Kfr/lpapcPF5pfr5zk40nVrxVxnIPfmKr53jABloY
         TVHr+1x1phtrqcZCfr+eDsfaatIvuEETG3RBvWGljGoGR2GpWUqenyN7VZogIvGQ73UC
         q0x4sL4/u2klteShXPwZZVLbP00WLl2W1NwqCUHkSiMIYZeGY2xH61ZaaxiB9uhQcFXC
         zzBoHv9A4QDe2p7OAqsSeQrvexo2bcoiWBifWhqz97fu0gAOr4uSFlTM7ib9bVlrH9cU
         8YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gytC150PVNi5bDeSrwBgIdraavLUH+krqw7JUvBRNqE=;
        b=ZBvoGUE/DJo87xBUTCb4/pQtxYOKRdIjS0vWqfKM/kCyZDoPPR4FuHQfew07Wssqel
         yw3dGevnchJAqZMMghPVS6XbMQGDznA0bKXVRq2IakB0Cno5BU2Qct+7BpB7z9wZGzW5
         lraeD/QE7vjULr0hmc3nudGhSeoaVe3uSkt7awUtx2fHtxrQ9v14y9NXh+j+vOYzy7vB
         qskT0ymZQDRYZk5fWABvYfN9eKvQIiv+1/Uhqto3KfV+A3UwTL3QKjM5e5I3RvTCwTF8
         o2JRzl0+PB/A3jKnSnf6+LEL5NbiHmObSzGF3DXRBuZKwPNYvC4yKz4MTmDGDxY4XXJ1
         Ec3Q==
X-Gm-Message-State: AOAM5325ITX3B5eA5IRW5QbQv0dtAd+4U/5sMLiW8hmYZB42aSzFKYM8
        jIZnUziyq927PSTbu3JOhSev3GLdz3QxPrlmzGOLgQ2fIMdCifpM
X-Google-Smtp-Source: ABdhPJy6+FjNltDlh58rR75oXWscTZ52lfHAemLF85ptVv9TEBmcN3BY7LBZZK8EPOH9hHjKLURRj16/ap38bD2aYxI=
X-Received: by 2002:a02:8801:: with SMTP id r1mr28533737jai.51.1617702603629;
 Tue, 06 Apr 2021 02:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com> <YGuMaxoYgRkUR1sa@coredump.intra.peff.net>
In-Reply-To: <YGuMaxoYgRkUR1sa@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 17:49:47 +0800
Message-ID: <CAOLTT8TwjRyT6MK_ekEx9APBv7jn17JRKj=mJQMO5Sk-DgHA-A@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 05, 2021 at 02:01:19PM +0000, ZheNing Hu via GitGitGadget wro=
te:
>
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf
> > and error strbuf. Instead, we can provide two single strbuf:
> > final_buf and error_buf that get reused for each output.
> >
> > When run it 100 times:
> >
> > $ git for-each-ref
> >
> > on git.git :
> >
> > 3.19s user
> > 3.88s system
> > 35% cpu
> > 20.199 total
> >
> > to:
> >
> > 2.89s user
> > 4.00s system
> > 34% cpu
> > 19.741 total
>
> That's a bigger performance improvement than I'd expect from this. I'm
> having trouble reproducing it here (I get the same time before and
> after). I also notice that you don't seem to be CPU bound, and we spend
> most of our time on system CPU (so program startup stuff, not the loop
> you're optimizing).
>
> I think a more interesting test is timing a single invocation with a
> large number of refs. If you are planning to do a lot of work on the
> formatting code, it might be worth adding such a test into t/perf (both
> to show off results, but also to catch any regressions after we make
> things faster).
>

It makes sense. A lot of refs can be convincing. Just like the number of
objects measured in `cat-files` is large enough.

But this is the first time I use `t/perf/*` and there is a little problem.
It seem like whatever I run single script like `sh ./p0007-write-cache.sh`
or just `make` or `./run ${HOME}/git -- ./p0002-read-cache.sh` , these
tests will fail.

> >     This patch learned Jeff King's optimization measures in git
> >     cat-file(79ed0a5): using a single strbuf for all objects output Ins=
tead
> >     of allocating a large number of small strbuf for every object.
>
> I do think this is a good direction (for all the reasons laid out in
> 79ed0a5), though it wasn't actually the part I was most worried about
> for ref-filter performance. The bigger issue in ref-filter is that each
> individual atom will generally have its own allocated string, and then
> we'll format all of the atoms into the final strbuf output. In most
> cases we could avoid those intermediate copies entirely.
>

Yes! In `ref-filter` we set object info in `v->s` and then append them to
current `stack` buffer, and finally set in `final_buf`, the copy of the str=
ing
is expensive. I don=E2=80=99t know if the optimization should start by remo=
ving the
stack buffer?

> I do think this would be a useful optimization to have in addition,
> though. As for the patch itself, I looked over the review that Eric
> gave, and he already said everything I would have. :)
>

I think it should be optimized, It will reduce the overhead of malloc and
free, but it is not obvious enough.

Yes, there is a lot of bad code in my patch.

> -Peff

Thanks.
--
ZheNing Hu
