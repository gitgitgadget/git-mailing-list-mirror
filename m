Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6888C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjHHQkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHHQjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:39:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E96155AB
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:54:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so56003595e9.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510052; x=1692114852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoGiDKKenqFFf/pQxfI1aph1TMthOvBk967vjRNI2vQ=;
        b=S/v8nqlllb1H4OaY7LPD67NyPe4K/M4RMWfy1pwionunH9ygULpk5qTDzvSNkRaz4R
         +CL/1OuSCoZEVhDf05dMBENQY+xRfkIYJGj0fQPGXTb5KA7os3WxngItS7FGToS86Pdx
         eSu5+UI0kjN4SgD/XyErXq1iaecGoLEQcjOFnbuE0aQAGU4fdmQrpzMKo+lVLi54K0Cx
         1EkvOPhcWlSaMFzQomEfBrk17uShtADDJivqca/yP+mUeDfPZzcENqUy6OEmZMiTrX0l
         eMwJljhWLGrw/dv1MQXevhWHeUdKT37H25srNONlxvCv+ota4wwmPmKO5AzcfpjaKt3s
         2DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510052; x=1692114852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoGiDKKenqFFf/pQxfI1aph1TMthOvBk967vjRNI2vQ=;
        b=PtGOWaaziOF97vxAAdD03qJ/IRHj4CmlhsjIg5LgMnp+fkgYoRkLMtULR1tOtTLPfn
         +fW3ZHeeibfM2ax6e23XlfusIeuB2S8guC57g44NumxSrliKqWKnT8dwfRJwdUJ1wMPV
         iQfXYzsoe94/La69e8EAdc3UVr6hIo+rxacB3f5DMM6WM2Opf0jZu4IjgsRXYQTCrDNg
         8NB7tZJsv19mtxBwzDmWwoUF/xl2JbIzuurYqblUM+uDQ2uHe5svQxZ1f7GB/pguOnc7
         /Z8ulXE7+0ZJwmKInb08ZuaCvQs99GmGdQxByf6yLiFkr1mjh6Dn2OzEj9lEyE/1kf7t
         UYeg==
X-Gm-Message-State: AOJu0YyoWQAcLscuJZbhyUzpA0ktXJNVHY+dC6DUuzox+xrGsdx/yHVq
        c5Ko6UzcCe4v/WYb+H5XvIrCTdaIosnRPPbzDiapGyFfQso=
X-Google-Smtp-Source: AGHT+IHYKfRpHrLK7CXUkF1YATmB2ZXFvKT2zepY4p7pk4F0o0HhZvYV6zpJM4Hg9dyJnyxZqsE/7cCH1Qo2qdzY678=
X-Received: by 2002:aa7:cccd:0:b0:523:22d9:6c39 with SMTP id
 y13-20020aa7cccd000000b0052322d96c39mr6623706edt.38.1691483917830; Tue, 08
 Aug 2023 01:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com> <20230724085909.3831831-7-christian.couder@gmail.com>
 <ZMBVzWoFQCUCSTwE@nand.local>
In-Reply-To: <ZMBVzWoFQCUCSTwE@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 8 Aug 2023 10:38:26 +0200
Message-ID: <CAP8UFD1Z3O5Wf8D9dYZdgPuOWgo7NbQsHAWifkPUGE=Eo1U7EQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] gc: add `gc.repackFilter` config option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 1:07=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Jul 24, 2023 at 10:59:07AM +0200, Christian Couder wrote:
> > A previous commit has implemented `git repack --filter=3D<filter-spec>`=
 to
> > allow users to filter out some objects from the main pack and move them
> > into a new different pack.
> >
> > Users might want to perform such a cleanup regularly at the same time a=
s
> > they perform other repacks and cleanups, so as part of `git gc`.
> >
> > Let's allow them to configure a <filter-spec> for that purpose using a
> > new gc.repackFilter config option.
>
> Makes sense.
>
> > Now when `git gc` will perform a repack with a <filter-spec> configured
> > through this option and not empty, the repack process will be passed a
> > corresponding `--filter=3D<filter-spec>` argument.
>
> I may be missing something, but what happens if the user has configured
> gc.repackFilter, but passes additional filters over the command-line
> arguments? I'm not sure whether these should be AND'd with the existing
> filters in config, or if they should reset them to zero, or something
> else.

`git gc` doesn't recognize `--filter=3D<...>` arguments, only `git
repack` is being teached to recognize it in this patch series. So I
don't see how there could be multiple such arguments on the command
line when `git gc` is used.

Also in version 4 `git repack` can be passed many such arguments
anyway. So I think we are good.

We could support multiple gc.repackFilter config options, but on the
other hand using something like
`combine:<filter1>+<filter2>+...<filterN>` should work, as the content
of the option is passed as-is to the command line. So we can leave
that improvement for later if people don't like the `combine:...` and
are interested in it.

> Regardless, I think it would be beneficial to users if we spelled this
> out in git-gc(1) instead of just this patch message here.

I am not sure what should be spelled out. I think we refer people to
the `repack --filter=3D...` option which in turn refers to the `rev-list
--filter=3D...` which contains a good amount of documentation about how
`--filter=3D...` works, including the fact that `combine:...` can be
used and that multiple `--filter=3D...` options can be passed.

> > diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> > index 69509d0c11..5b89faf505 100755
> > --- a/t/t6500-gc.sh
> > +++ b/t/t6500-gc.sh
> > @@ -202,6 +202,18 @@ test_expect_success 'one of gc.reflogExpire{Unreac=
hable,}=3Dnever does not skip "e
> >       grep -E "^trace: (built-in|exec|run_command): git reflog expire -=
-" trace.out
> >  '
> >
> > +test_expect_success 'gc.repackFilter launches repack with a filter' '
> > +     test_when_finished "rm -rf bare.git" &&
> > +     git clone --no-local --bare . bare.git &&
> > +
> > +     git -C bare.git -c gc.cruftPacks=3Dfalse gc &&
> > +     test_stdout_line_count =3D 1 ls bare.git/objects/pack/*.pack &&
> > +
> > +     GIT_TRACE=3D$(pwd)/trace.out git -C bare.git -c gc.repackFilter=
=3Dblob:none -c repack.writeBitmaps=3Dfalse -c gc.cruftPacks=3Dfalse gc &&
>
> Nit: can we wrap this across multiple lines?

Done in version 4.

> > +     test_stdout_line_count =3D 2 ls bare.git/objects/pack/*.pack &&
> > +     grep -E "^trace: (built-in|exec|run_command): git repack .* --fil=
ter=3Dblob:none ?.*" trace.out
> > +'
>
> I think the `test_subcommand` helper might work here, and it would allow
> you to avoid writing a long grep invocation.

Other tests related to gc.reflogExpire above use a grep invocation
similar to this one, while `test_subcommand` isn't used in the test
script, so I think the grep invocation makes the whole script a bit
easier to understand.

Thanks.
