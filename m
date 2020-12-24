Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E0C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D682F224B0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgLXP1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 10:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgLXP1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 10:27:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA9C061574
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:26:56 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j20so2059014otq.5
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wlcrb5FYH2mMlyzF6oLmmPmdEjClDzSbMhMfYAzOiXE=;
        b=L0ZEC/m2RHOR5l57kH7LeG+nwuVCLdrULdU7LmUbclRTZE4OA97nzLeg+tLGpqHvc4
         baskLjctfhNhVqDr+btt7GY/EWMwq4MukBjMTg++PZsh4NDYZHMM/viJ9Ju9T/FIbRqG
         T4bOeAp0lfl1SUwssQ0MlAhAf5owEC2AWhsupxlLI9aeA6J5d2nOVE2wmcZtGsfnc3WE
         6FrIlAlw+lDCmYVuzza26aHavGOJ+EcnTxuFKfs6hbxNBWkwwogcg7h/LaoAIexb5l6S
         XbpgyVqsl40p9ndqUSewwnMvZLTxReB/fLwWgtBDi27HVpX/26WrfATdnWFz83B8TkZD
         aSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wlcrb5FYH2mMlyzF6oLmmPmdEjClDzSbMhMfYAzOiXE=;
        b=P0XS1Hz+JgXnlJ1qvLfaoggfiDRQ6Umt6r+k7WlenHykSCTBCYzqRF53/217D+rrDs
         7ESVPDiP6X7QArcr7n1Mvriq5qD9ar4DaisTN4m3UT6yjFSlvAl50XFS3B0SsTtb1ZdT
         qY/abVS7uQdXFSyjvd57bfqa+Ar9pbeknHpyiKUeXX+YMry3g4Mdahl0Wzi4zTGIVVqe
         ATNpYpY3gHQMePBhcUGP8Wiso01T+vb2Ft9rb1i7EuIHFqskw6S0kQVJ9yx9x8+3uFAs
         BcznirVx6EGnKKMCCCee/1ae95Vq06YjnG2EclUstvPbiWoMM2zpTKytseH3LGQV7bqq
         aADA==
X-Gm-Message-State: AOAM533usSmRziG3q490XZ4yAiLr+/XJI9urNKI/SffLnMh0VFDn3J5z
        JQC1PIeVUb7Ei7OlP8eB02A=
X-Google-Smtp-Source: ABdhPJzDhknBfafi2WAez38AQPf8AUngu0w5OdO2dJHHygVlcYKSbC22vxDngLQgoT9tzxx1ZSHJ5A==
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr23940651ots.251.1608823615707;
        Thu, 24 Dec 2020 07:26:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v3sm3385531ool.16.2020.12.24.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 07:26:54 -0800 (PST)
Date:   Thu, 24 Dec 2020 09:26:53 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe4b33dbc028_19c920834@natae.notmuch>
In-Reply-To: <87o8ijv124.fsf@evledraar.gmail.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
 <5fe36790793ae_2354120839@natae.notmuch>
 <87r1ngufmf.fsf@evledraar.gmail.com>
 <5fe424d0528a2_7855a208d3@natae.notmuch>
 <87o8ijv124.fsf@evledraar.gmail.com>
Subject: Re: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Dec 24 2020, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Wed, Dec 23 2020, Felipe Contreras wrote:
> >> =

> >> > When I express my dissenting opinion I'm not saying nobody should =
write
> >> > a patch on top of mine. Of course they can. Anybody can take my co=
de and
> >> > do whatever they want with it (as long as they don't violate the l=
icense
> >> > of the project).
> >> >
> >> > What they cannot do is add my Signed-off-by line to code I don't a=
gree
> >> > with.
> >> =

> >> I don't think that's what Signed-off-by means, per SubmittingPatches=
:
> >> =

> >>     To improve tracking of who did what, we ask you to certify that =
you
> >>     wrote the patch or have the right to pass it on under the same
> >>     license as ours, by "signing off" your patch[...under the DCO:
> >>     https://developercertificate.org/]
> >
> > Yes, but the DCO requires (d):
> >
> >   d. I understand and agree that this project and the contribution ar=
e
> >      public and that a record of the contribution (including all pers=
onal
> >      information I submit with it, including my sign-off) is maintain=
ed
> >      indefinitely and may be redistributed consistent with this proje=
ct or
> >      the open source license(s) involved.
> >
> > We can narrow down the part I'm talking about:
> >
> >   d. I *agree* that a record of the contribution is maintained
> >      indefinitely.
> >
> > I don't agree with that.
> =

> I don't understand you here. You don't agree that we retain
> Signed-off-by lines indefinitely, or just in the case of amended
> patches?

The DCO requires that I agree that a record of my contribution is
maintained indefinitely.

If I don't agree that a record of a particular contribution is
maintained indefinitely, the DCO says you shouldn't use it.

> > Moreover, the relevant definition of "sign off" in English in my opin=
ion
> > is [1]:
> >
> >   to approve or acknowledge something by or as if by a signature (sig=
n
> >   off on a memo)
> >
> > If I didn't put my "signature" in a commit, then it's not signed off =
by
> > me.
> =

> I think this use of 'signed off" makes perfect sense if you interpret
> the sign-off to mean "I signed off on the copyright eligibility of this=

> work for inclusion" which is what I think it means.
> =

> Not "I signed off on my subjective approval of this patch & what it's
> for etc.", which seems to be closer to your interpretation.

Why does it have to be only one meaning?

Junio doesn't sign off on a patch that he doesn't think is good.

Same happens with all the lieutenants of Linux.

> >> "No Discrimination Against Fields of Endeavor" is an integral part o=
f
> >> free software & open source. In our case it means that when you
> >> contribute code under our COPYING terms someone else might use in a =
way
> >> you don't approve of.
> >
> > Yes, you just have to make the record straight; do your changes in a
> > separate commit without my "sign off".
> =

> We like to maintain "make test" passing for every commit, and sometimes=

> we have patches on the ML with a SOB that don't even compile yet, let
> alone pass tests, because they were provided by their authors as "maybe=

> try this" or other near-pseudocode.
> =

> We also like to optimize patch order/size/splits/etc. for the benefit o=
f
> reviewers. Sometimes someone might send a patch with a SOB that's bette=
r
> squashed into another one, or refactored into N commits spread across a=

> series etc.

Yes. And most of the time that's fine, because the original author is
not objecting to the clause (d).

> >> E.g. I'm sure that arms contractors, totalitarian regimes etc. or ot=
her
> >> entities some might disapprove of are using git in some way.
> >
> > Yes, and you can modify my patch and keep my s-o-b, I'm not going to =
sue
> > you.
> >
> > I just don't think that's right.
> >
> >> That non-restriction on fields of endeavor also extends to individua=
l
> >> patches licensed under a free software license & the necessity to
> >> maintain a paper trail about who their authors are and if they certi=
fied
> >> them under the DCO.
> >
> > Sure, so if you need to keep a paper trail about the copyright of the=

> > code, why would you risk that simply because the author didn't agree =
on
> > the further changes.
> >
> > Just do them on a separate commit. Problem solved.
> =

> I don't understand how the copyright paper trail is at risk just becaus=
e
> we combine N patches into one.

It's not just a copyright paper trail, the DCO clearly states that the
author should:

  d. I *agree* that a record of the contribution is maintained
     indefinitely.

> The important part is that we have a declaration that the sum of the
> work (and whatever it's derived from) is properly licensed, that the
> authors had the right to license it for inclusion etc.

That's the important part, yes. It's not the only part.

Cheers.

-- =

Felipe Contreras=
