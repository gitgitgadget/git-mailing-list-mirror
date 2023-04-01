Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DC8C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjDAAub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDAAua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:50:30 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31B1287A
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:50:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5416698e889so446609847b3.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680310228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM8nt0ItQXrBqGeVniIo9/vrTj/dTL8txh1UlkA/Hso=;
        b=lrRPGrPoONLRisktg2E5mtl66jhFxinItsBwf+t8lIlQYRG2mhY4QJhSU3bVcLyN5/
         2QusDIc0AhMzqXLyHzrwXEOzo3bow8dn+gJ0si9DSR2e68oYYHUPb01r1VVL52VJZLmC
         nkNn5V2rfbhNTEt2d/Ki0/hWUuFUw8IkPMYUH6rz6v3LNBm4hgOWBPnF7igQ8G7jwYr7
         T4ElMhGpsWpsgA7cP4/fxBvaxUVOchOnS+/ETJ/alDrV4kTmLq4nE3JfbhyCDU5/VE5j
         Dh/kzOgIF1bAtdmPBpNC45Sl6+pjMn3Bxi0Eu5CygKSl1h4NzNFeCpfvDx+9oYRo4zy6
         TpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680310228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM8nt0ItQXrBqGeVniIo9/vrTj/dTL8txh1UlkA/Hso=;
        b=QcZZCte6Xul2xY99PS4H/iTOuTIrOu/dk7dnDMr8KMA/qv9enze+n+9XTwd2UikkX8
         rXR/v56HkYpU1/xMhdKw8ZUNZKkX0HS5mxMMOWTU4MNxl350yueZTPhS1m426N3zSQ/u
         kxFhCyLSUQg3t2ml2n5KmdPJdvhz+49ekraPd+mN7MQJxgmsWgGCpQtlU+fp/aZhIFMt
         M7wH6cRauNdI9zkfP3S1LUmLHaNxWsu3MHPYw4tipglMT2ny/U4kGsCFUYL1Iul/iGlL
         gCEW3wrgeVWhZMNbjyuH8/6LLSHgErWKU5Qtfn18ZkzYCSudxB5QsOCf4MFScNpa/gSI
         Dlhw==
X-Gm-Message-State: AAQBX9eKBNPbJoeJQJgM5CoXv0fkPHRUgmvO72MUpvzUkC4Co0ia5m7K
        +YYNP/mn5wzU+KFxoJFMBnU+oQ2p3Aj21Hd5xJs=
X-Google-Smtp-Source: AKy350Z5Az3wEQyqv4L/cHkQnabvhBlbWFCiuI5IG7hKFjsc1ff0Q001HrRqxYBGjhHAHZHYHW2qTqC47ntZ3DvAuXc=
X-Received: by 2002:a81:b388:0:b0:545:8202:bbcf with SMTP id
 r130-20020a81b388000000b005458202bbcfmr13721244ywh.9.1680310228648; Fri, 31
 Mar 2023 17:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
 <xmqqa5zu4ka3.fsf@gitster.g> <ZCd0MyieHOZDQeVM@nand.local>
In-Reply-To: <ZCd0MyieHOZDQeVM@nand.local>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 31 Mar 2023 18:50:17 -0600
Message-ID: <CAMP44s3MSSAC9dEDo23dJw=G1X31xJgNQJZEDYEoEheeEX9JSA@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 6:00=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Mar 30, 2023 at 03:15:48AM -0700, Junio C Hamano wrote:
> > > In truth all the patches regarding shell portability have been along
> > > the lines of: "this code makes $x shell work, doesn't break other
> > > shells, and isn't against POSIX". In some cases even when the Austin
> > > group disagreed on what POSIX actually said, we did whatever worked i=
n
> > > most shells.
> >
> > One aspect that is missing in the above is the extra burden on our
> > developers.
>
> Well said.
>
> Having to remember that we need to write "$ARGZERO" instead of "$0"

When have you ever used "$0" in the test suite?

A quick grep shows zero results (`git log --author=3Dme@ttaylorr.com
-S'$0'`), so I think you are talking about a hypothetical, not
something that would actually happen in reality.

Sometimes preemptive optimization pays off in the future, but other
times it doesn't, and it's just wasted mental effort.

This is one of those times when worrying about a future that will
never happen in reality does not pay off.

> Is that a big deal? Probably not. But it's a slippery slope, and a weird
> gotcha to remember when dealing with our otherwise POSIX-y test suite.

You won't have to remember that because you'll never use $0 in the
test suite. Nobody does use it, and nobody ever will.

*If* for some weird reason somebody needs to use $0, we can worry
about it *then*.

---

But this is a red herring. The reality is that developers do not have
to worry about every little aspect of the test suite. When somebody
uses `seq`, somebody else reminds them to use `test_seq` instead, and
if for some reason a `seq` slips by and it breaks the test in some
obscure platform, the test is updated to fix that. It's not a big
deal.

Why are many tests using `chmod` instead of `test_chmod`? Did the
introduction of `test_chmod` imply an extra burden to "our developers"
to remember using that instead of `chmod`? No, *in reality* what
everyone cares about is that the test runs on the platforms of the
real world.

If we could run the test suite on 100 hypothetical platforms that
don't exist in the real world, it would break all over the place.

In reality all the portability considerations of the test suite are
geared towards certain platforms that exist in the real world. Nobody
cares that the test suite doesn't run on some hypothetical platforms.

So no, nobody needs to remember to use test_chmod, or test_seq, and
nobody will ever have to remember to use $ARGZERO instead of $0, and
if some hypothetical person does use that in some hypothetical test
and that breaks the tests for zsh in native mode, nobody will care,
except the person running those tests (likely me), which would
promptly fix that single hypothetical instance of $0.

Nobody will die if a instance of $0 slipped by (which will never happen).

This is simply not a real consideration.

Cheers.

--=20
Felipe Contreras
