Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02573C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 07:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352576AbiAYHDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391455AbiAYHAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 02:00:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F2C067A7B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 21:38:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r10so29608995edt.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 21:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lQyyYYS8RYnb02wybd/LxHh/jcyRFn7csLM24TROKe0=;
        b=H2GJ09qHA0LBH+s3rzxmM37gXhwKNDow+UWwhz8YpZrDgdfPVoib3ODGEvywDfMIUR
         l9eyjscSh40RWxq2UDCzX9dxDOkzXyX/iwZHjylFEX6piTji5McX0dLZvySYAEmIc7sP
         lRkG02yDUafCGcRE/kxudrccZfTJXkobK839plbDx09KVV49BFB1JeMkkMkZxVo3BPnh
         b8jz1tCW19I1JFLb9eGMelKiG1l6Ghgg1ZnuCty5DKIdDuTUpscb00zGJpXrI7ac3nKT
         EssjWCC4JoeDqkrf2wSa6ejNA/3idBgmQZOJBnOpRfyufdjCeaPfyizcwaa/i/Q5f+EK
         N5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQyyYYS8RYnb02wybd/LxHh/jcyRFn7csLM24TROKe0=;
        b=UqPjkSx+GnvkGVNKrv8U+6vcFp/oStIC4u1KqUCV2xUf5Boocd4ZNIZJi2wyvULcF/
         GglPEP039mNXosluksP5iUh38UOPzoFe/fI/Had1ZXdicp/FlHMJU97aLfSy6STTFNuC
         ba0GL2P1Cs6qnnO5iC8ut4riEpkM+V4S8FbWW5sPDEWH04v0JEzETM2ropEhhRMckBqN
         Ezy0w/mNlL2Uxfc+l9tVotzw8E7qymQoMDDBJRacVjcjMGEbfvhTdnHYh0tgI+7OpcS5
         d01Y2YZ81sbdsSvRmqGcXDFT1doQuxw0CP4pkK19kIijNjdPccxbc0Q4MDurkAhy8Ifq
         JjTA==
X-Gm-Message-State: AOAM531CBns3y7inZ4mdQH/S5gNZd5YHPLQ3jTF54yjQpt7C89zVQD4n
        vDvSa0YnUMYqTAJXghjETCl08BHAZFpI3+/8bbrnaOvykCY=
X-Google-Smtp-Source: ABdhPJwVw2Ft0Jort/gwmr2XX4sWw5fHNkEF2Wu07lpZfD/tylEAveoAV3QNKqJ4G6AxvsP1tnlGih0dvRrRg8JmUfU=
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr3153120edd.359.1643089091570;
 Mon, 24 Jan 2022 21:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com> <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
 <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com>
 <220122.86tudwht17.gmgdl@evledraar.gmail.com> <CABPp-BG5WzgcEwxnjraEN-SEKxUUvz-wD68afjQd_sWFe6R=Vg@mail.gmail.com>
 <220124.86zgnlgyjr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86zgnlgyjr.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 21:37:59 -0800
Message-ID: <CABPp-BFdv6HsD+YebquoCBNp7KBoZ8i-aVjo9aisx9Qp68VWjQ@mail.gmail.com>
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jose Lopes <jabolopes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 3:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren wrote:
>
> > On Sat, Jan 22, 2022 at 4:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Fri, Jan 21 2022, Elijah Newren wrote:
> >>
> >> > On Fri, Jan 21, 2022 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> >> > <avarab@gmail.com> wrote:
> >> >>
...
> > I think it's a totally different kind of thing and wouldn't belong in
> > the same commit even with an amended commit message.  I'm curious why
> > we're so far apart on this and whether I'm missing something.
>
> I think I'm biased by my initial look at this problem[1], which was to lo=
ok
> at the various "sparse_filename" callers and their non-coverage. In my
> mind fixing & testing for that general problem would make for a nice
> atomic change.

Ah, ok, that link and your other comments below help; I think I'm
starting to see now.  Sorry for being slow.  I was focusing
(pigeonholing?) on the likelihood and feasibility of a user entering
certain states, you were doing whatever was necessary to force the
code into certain states and then testing them.  The forcing into
certain states was tripping me up.  (Perhaps if we had a unit test
framework instead of only a regression test framework, then you could
have suggested multiple unit tests and I wouldn't have been so
confused.)

Thanks for explaining.

....
> >> I'm just saying that it's cheap to add a regression test for this
> >> missing bit of related coverage, so why not add it?
> >
> > So, this is a slightly different issue than I was getting at before,
> > but this feels slightly obstructionist to me.  Now, suggesting related
> > improvements and ideas sounds totally fine; we should point those out
> > -- once.  But pushing it again as though it needs to be addressed as
> > part of the submission just doesn't feel right.  Jonathan's patch
> > fixes a real problem and feels complete to me.  There are always
> > additional things that could also be fixed or addressed for any patch
> > or series.  Expecting folks submitting a series to address every "next
> > step improvement along these lines" that any reviewer can think of
> > seems unfriendly, especially as it has a snowball effect.
> >
> > Granted, if there's a bug with the patch, or it doesn't fully solve
> > the stated problem, then it's a different situation, but I don't think
> > that's the case here.  (Well, modulo the leftover removing of
> > "blank-template" which is a real issue you identified with the patch.)
>
> The first thing I said in this thread is "Thanks. This fix looks good to
> me.". I'd be happy to have just this fix in. This patch resolves a
> blocked of an earlier series of mine.
>
> The rest of the feedback here (aside from the trivial "rm -rf" fix) was
> an attempt to bridge the gap between this & my earlier look in [1].

It helps to know your intent.  The "I'd be happy to have just this fix
in" doesn't appear in your emails until here; to me, you communicated
the opposite by not only bringing up the additional changes but also
following up to the next email by also including a patch when you saw
they weren't included.

Anyway, I think we're good here; we both agree Jonathan's patch
doesn't need the additions, and you've patiently explained to me what
I was missing about your view on the tests.  Sorry for being slow on
that.

One other side point, though, since it came up in this thread...

> >> > (Note that `sparse-checkout init` sets core.sparseCheckout=3Dtrue, a=
s
> >> > explicitly documented.  core.sparseCheckout=3Dtrue instructs git to =
pay
> >> > attention to $GIT_DIR/info/sparse-checkout for every unpack_trees()
> >> > call that updates the working tree, which basically means nearly any
> >> > significant Git operation involving a worktree update now needs that
> >> > file in order to function.  So, your commands told Git that this
> >> > directory is mandatory, and then you nuked the directory.)
> >>
> >> *nod*. But in that case shouldn't the errors say that you've configure=
d
> >> core.sparseCheckout=3Dtrue but you're missing XYZ file?
> >
> > Yeah, it probably should.
> >
> > I just did a little more testing and it looks like commands like
> > "switch" don't even error out; they just treat the missing
> > $GIT_DIR/info/sparse-checkout files the same as all files being
> > included.  Weird.  It seems to come from dir.c:add_patterns(), which
> > appears to have perhaps gotten that way due to assuming the code was
> > exclusively about .gitignore files rather than the sparse-checkout
> > file.
...
> FWIW I don't think it's all that important to focus too much on how
> users would get into this scenario. Sure, for the "init" case it's a
> thing that's broken with --template=3D, so that's more urgent.

Just to check, "this scenario" means core.sparseCheckout=3Dtrue with
$GIT_DIR/info missing (and thus $GIT_DIR/info/sparse-checkout
missing), right?

> But for the rest we're already carrying code for those edge cases (errno
> handling and all), we just don't test for it.
>
> So just adding tests seems prudent.

Okay, but if we're ignoring how users get into this scenario, then
there are more affected code paths than just the sparse-checkout
subcommand.  And it appears that at least some of those do not behave
well (they do weird-ish things and pretend success instead of showing
a reasonable error message, or even any error message).  So there's
probably some work involved to identify the relevant subcommands or
codepaths, so that we even know what to add tests for.
