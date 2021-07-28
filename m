Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319AC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA5861019
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhG1NiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhG1NiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 09:38:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96AC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:38:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h1so3020542iol.9
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nBmIRN/iJsH/hgoA2S3MTh56TW2QjjNTo1FWPzmqEFM=;
        b=DQ7SX0jUCWWNGHagEZJJFCUhtCrV9BEJIcFB05xCMkrdGbtFdP6OoXT3dQALufOW1y
         7C3tpcPhQlw/MaQ3osfb5Vc1n47B9laBTf3/Bvvqih01JDOwHN0fXyLSGNEwLfoJXZt2
         tHW0DPHsI5GLAN6BwU31Ep58Gi51skRxQqw+KW47AMdocDkz9oPOlybNQpIi5zcsEqjn
         VzuwsdO88U2mxtbyr5Rt2h1E9+ySzoT8/3cq5/BvP/jhfd8IfBAbgMJBifkr5NgoCpcH
         Yha//3ffH3sa71oKmBMN74BVG/55vQUQ3cSq1Yc8czBi/yw64GxcWD+PeKHcff1//W8C
         i00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nBmIRN/iJsH/hgoA2S3MTh56TW2QjjNTo1FWPzmqEFM=;
        b=c1aaHgSIRg0Aky71kn5pMcEYiDahXOofmSsNTuRaXr2fHaobPI3A46APqCLIDO+G+Y
         Sqju4XUKuTr1nPxF32XHrXXpjoC3ctXGCHv3Bcpy4ddehSZXkpICdUcej5c5N0Re53un
         PBileNMpDVMu3szDPsO+WbJ1ucnB1XGQ1vphie8oACPx9v1oy6qE/+MxhjHgg5rCp7kp
         33p700inP5Nb1fhY63YIlOax8zXXm7xdHBT5Ty/W6Wf1qBakhziYc8a6oprT1IQOkXea
         s7PSZwpoiIN6vPUNXP0TY8WQh/rhKwomGmpxGmDDKH57AsFwY9T6e9BNezO1nIuficAp
         8j+g==
X-Gm-Message-State: AOAM531CvPGvOH5YrnYP9CaL4CZG+RTa8L6b5gKbJkc7FS3yBBhb4mBr
        Hr+TMzw+KhvSEVwgToCw3rs5VdkX4ednW93Dmko=
X-Google-Smtp-Source: ABdhPJxet0eZaQMFpEAH2LLgJ+Dzb3YgMItQ08UPDK9W6Fnzur+w8tNYULWMRGtRda2UXzhmAFLW7G+24LxldnnjOFg=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr23111168ion.203.1627479480945;
 Wed, 28 Jul 2021 06:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com> <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
 <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com>
 <CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com> <CAP8UFD1WtSX59AqfG=d0Ge2BcK+8LdyZk0mQuftpu=FKX-877Q@mail.gmail.com>
In-Reply-To: <CAP8UFD1WtSX59AqfG=d0Ge2BcK+8LdyZk0mQuftpu=FKX-877Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 28 Jul 2021 21:38:33 +0800
Message-ID: <CAOLTT8QvtJ70X8mQx4K4gD0T=7i-ryd0QL81-QeSTqSWyHuWLQ@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:34=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Jul 27, 2021 at 3:37 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=8826=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:38=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > > On Sun, Jul 25, 2021 at 2:04 PM ZheNing Hu <adlternative@gmail.com> w=
rote:
> > > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E=
2021=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:23=
=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > > Having skimmed it I'm a bit confused about this in reference to
> > > > > performance generally. I haven't looked into the case you're disc=
ussing,
> > > > > but as I noted in
> > > > > https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ t=
he
> > > > > profiling clearly shows that the main problem is that you've adde=
d
> > > > > object lookups we skipped before.
> > > >
> > > > Yeah, you showed me last time that lookup_object() took up a lot of=
 time.
> > >
> > > Could the document explain with some details why there are more calls
> > > to lookup_object()?
>
> Please note that here we are looking for the number of times the
> lookup_object() function is called. This means that to measure that
> properly, it might actually be better to have some way to count this
> number of times the lookup_object() function is called, rather than
> count the time spent in the function.
>

Ok, therefore we need an accurate number of call times about lookup_object(=
),
although the conclusion is obvious: 0 (upstream/master) and a big
number (with my patch).

> For example you could add a trace_printf(...) call in the
> lookup_object() function, set GIT_TRACE=3D/tmp/git_trace.log, and then
> just run `git cat-file --batch ...` and count the number of times the
> new trace from lookup_object() appears in the log file.
>

After adding a trace_printf() in lookup_object(), here is the result:

Checkout to d3b5272a94 [GSOC] cat-file: reuse ref-filter logic

$ GIT_TRACE=3D/tmp/git_trace.log ggg cat-file --batch --batch-all-objects
$  cat /tmp/git_trace.log | wc -l
522710

Checkout to eb27b338a3e7 (upstream/master)

$ rm /tmp/git_trace.log
$ GIT_TRACE=3D/tmp/git_trace.log ggg cat-file --batch --batch-all-objects
$  cat /tmp/git_trace.log | wc -l
1

This is the only 1 time left is printed by git.c, which show that after usi=
ng
my patch, we additionally call  lookup_object() when we use --batch option.
According to the results of the previous gprof test: lookup_object()
occupies 8.72%
of the total time. (Though below you seem to think that the effect of
gprof is not
reliable enough.) This may be a place worthy of optimization.

> > > For example it could take an example `git cat-file
> > > --batch ...` command (if possible a simple one), and say which
> > > functions like lookup_object() it was using (and how many times) to
> > > get the data it needs before using the ref-filter logic, and then the
> > > same information after using the ref-filter logic.
> >
> > Sorry but this time I use gprof but can=E2=80=99t observe the same effe=
ct as before.
> > lookup_object() is indeed a part of the time overhead, but its proporti=
on is
> > not very large this time.
>
> I am not sure gprof is a good tool for this. It looks like it tries to
> attribute spent times to functions by splitting time between many low
> level functions, and it doesn't seem like the right approach to me.
> For example if lookup_object() is called 5% more often, it could be
> that the excess time is attributed to some low level functions and not
> to lookup_object() itself.
>

Maybe you are talking about "cumulative seconds" part of gprof?
it's "self seconds" part  is the number of seconds accounted for by
this function alone.

> That's why we might get a more accurate view of what happens by just
> counting the number of time the function is called.
>

According to https://sourceware.org/binutils/docs/gprof/Flat-Profile.html :

calls
This is the total number of times the function was called. If the
function was never called,
or the number of times it was called cannot be determined (probably
because the function
was not compiled with profiling enabled), the calls field is blank.

Therefore, there are accurate numbers in the previous gprof test results.

> > > It could be nice if there were also some data about how much time use=
d
> > > to be spent in lookup_object() and how much time is now spent there,
> > > and how this compares with the whole slowdown we are seeing. If =C3=
=86var
> > > already showed that, you can of course reuse what he already did.
>
> Now I regret having wrote the above, sorry, as it might not be the
> best way to look at this.
>

Yes, because his previous results are based on a version of my patch set,
and some changes have taken place with my patch later.

> > This is my test for git cat-file --batch --batch-all-objects >/dev/null=
:
>
> [...]
>
> > Because we called parse_object_buffer() in get_object(), lookup_object(=
)
> > is called indirectly...
>
> It would be nice if you could add a bit more details about how
> lookup_object() is called (both before and after the changes that
> degrade performance).
>

After we letting git cat-file --batch reuse the logic of ref-filter,
we will use get_object()
to grab the object's data. Since we used atom %(raw), it will require
us to grab the raw data
of the object, oi->info.contentp will be set, parse_object_buffer() in
get_object() will be
called, parse_object_buffer() calls lookup_commit(), lookup_blob(),
lookup_tree(),
and lookup_tag(), they call lookup_object(). As we have seen,
lookup_object() seems to
take a lot of time.

So let us think, can we skip this parse_object_buffer() in some scenarios?
parse_object_buffer() parses the data of the object into a "struct
object *obj", and then we use this
obj feed to grab_values(), and then grab_values() feed obj to
grab_tag_values() or grab_commit_values()
to handle some logic about %(tag), %(type), %(object), %(tree),
%(parent), %(numparent).

But git cat-file --batch can avaid handle there atoms with default format.

Therefore, maybe we can skip parsing object buffer if we really don't
care about these atoms.

> > We can see that some functions are called the same times:
>
> When you say "the same times" I guess you mean that the same amount of
> time is spent in these functions.

No... What I want to express is that the number of calls to these
functions is same,
see gprof "calls part" with  "patch_delta()", both are 1968866.

>
> > patch_delta(),
> > unpack_entry(), hashmap_remove()... But after using my patch,
> > format_ref_array_item(), grab_sub_body_contents(), get_object(), lookup=
_object()
> > begin to occupy a certain proportion.
>
> Thanks!

Thanks for hint!!!
--
ZheNing Hu
