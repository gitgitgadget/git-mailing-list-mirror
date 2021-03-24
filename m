Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7680C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775AA61A0A
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhCXW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhCXW5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 18:57:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B3C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 15:57:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w18so359404edc.0
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M4KvAuVCfVv2dk7FfrKLhbhVjDDTwkqWO8ivUWCyqUY=;
        b=CluHcHAlvhEvRNWXCT6rF/vbyIwy5l7yE0hZS5n3fOuK8Y2CKFNuk/4SJWnCxQVuE7
         jFWwWS3sb5s0Ebcbl0/qDG1belDyH4+sdyI9rLXnKBVlQcdp2XNSVPDF43nxeb8WuGsQ
         I2nex+IRMnBfHKJ2fTNkInjVatDxnSzSlAWqvkGsHtZwfMaFpqh0oODrDQLQlT5Zv5SW
         eoNZl5Pz3GpzDLAUFpbcHlbfIFYViZMc3mJ6CQqcr3S+D1PyMhHYsKx1UQ5M73xo3s1J
         /W+uFmBK1fX1AXgo1Cy/0pkRKEoGhIRisUWEGhFs0rEpUuKPgEdhLdeokM/mhj25Celh
         /McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=M4KvAuVCfVv2dk7FfrKLhbhVjDDTwkqWO8ivUWCyqUY=;
        b=QsDiBhjkLJ6rMtNA1vaQ7kzAMNDAmWhLIlz+2K9C5bLu0cDyx+hf5q/Yn058HL2Mfm
         Qnd7N7lZXqqv8BRVqgtQuSkOXCRWMoLLFsFGRyBsNc602ilZNUeIJ5ivbgnzX65v0+U7
         7A3vaUY2spQJsNF8+U75D6G7B6lWBtwDsHfRwzQDlaTH4N9muo2ZH3Wvaksn1mutYwmG
         UeAF7VEo0vI07c5L30zlUs3nsaSVstue+l1+qL9MRgrPblIpuMRC9nV5FIF4VfKCAd3h
         H+NHp+2F3JQd9f9k3zT1S/6qrO8bHo6T6kOkD54w3YCTENdj70Dyx8I3Hkcxtzsqq90K
         hAJw==
X-Gm-Message-State: AOAM531+IJUDJ5SxmkKONIO/A2BQToV2cxAayeHq+dcFi1BwFRDz/+NH
        z4TJScYCRdBtXK39pY+qt3t8S6xPA13ZDg==
X-Google-Smtp-Source: ABdhPJzkZZpTHVZaKK1xT+hsnK0Frrn6oEu6ZIiBYoNfpv6+UC8Gg2kBGm3p51aKPdqdyG3PZVMekw==
X-Received: by 2002:aa7:cf95:: with SMTP id z21mr5825699edx.76.1616626668013;
        Wed, 24 Mar 2021 15:57:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u15sm1826851eds.6.2021.03.24.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:57:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
References: <pull.31.v5.git.gitgitgadget@gmail.com>
 <pull.31.v6.git.gitgitgadget@gmail.com>
 <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
 <87zgzbgp1i.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
 <87a6qxzocs.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103241257580.50@tvgsbejvaqbjf.bet>
 <20210324212051.GA2271@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210324212051.GA2271@szeder.dev>
Date:   Wed, 24 Mar 2021 23:57:46 +0100
Message-ID: <87lfacp3bp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Mar 24, 2021 at 01:01:49PM +0100, Johannes Schindelin wrote:
>> Hi =C3=86var,
>>=20
>> On Sat, 20 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> > On Fri, Mar 19 2021, Johannes Schindelin wrote:
>> >
>> > >> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
>> > >>
>> > >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > >> >
>> > >> > It seems that every once in a while in the Git for Windows SDK, t=
here
>> > >> > are some transient file locking issues preventing the test clean =
up to
>> > >> > delete the trash directory. Let's be gentle and try again five se=
conds
>> > >> > later, and only error out if it still fails the second time.
>> > >> >
>> > >> > This change helps Windows, and does not hurt any other platform
>> > >> > (normally, it is highly unlikely that said deletion fails, and if=
 it
>> > >> > does, normally it will fail again even 5 seconds later).
>> > >> >
>> > >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > >> > ---
>> > >> >  t/test-lib.sh | 6 +++++-
>> > >> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> > >> >
>> > >> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > >> > index f31a1c8f79..9c0ca5effb 100644
>> > >> > --- a/t/test-lib.sh
>> > >> > +++ b/t/test-lib.sh
>> > >> > @@ -1104,7 +1104,11 @@ test_done () {
>> > >> >  			error "Tests passed but trash directory already removed befor=
e test cleanup; aborting"
>> > >> >
>> > >> >  			cd "$TRASH_DIRECTORY/.." &&
>> > >> > -			rm -fr "$TRASH_DIRECTORY" ||
>> > >> > +			rm -fr "$TRASH_DIRECTORY" || {
>> > >> > +				# try again in a bit
>> > >> > +				sleep 5;
>> > >> > +				rm -fr "$TRASH_DIRECTORY"
>> > >> > +			} ||
>> > >> >  			error "Tests passed but test cleanup failed; aborting"
>> > >> >  		fi
>> > >> >  		test_at_end_hook_
>> > >>
>> > >> I saw this sleep while reading some test-lib.sh code, doesn't this =
break
>> > >> df4c0d1a79 (test-lib: abort when can't remove trash directory,
>> > >> 2017-04-20) for non-Windows platforms?
>> > >
>> > > It does not really break it, it just delays the inevitable failure.
>>=20
>> I still think this is the best answer to this (implicit) question:
>>=20
>> > In any case, your patch clearly undoes whatever canary for gc issues
>> > df4c0d1a792 was trying to put into the test-lib, but didn't say so in
>> > its commit message.
>>=20
>> I was not _really_ paying attention to that commit when I implemented the
>> work-around you mentioned above. At the same time I think it does _not_
>> undo the canary. If the trash directory cannot be removed via `rm -fr`,
>> and if that is an indicator for something fishy going on, chances are th=
at
>> the second `rm -fr` a couple seconds later will _also_ fail, and we still
>> get that error message.
>>=20
>> The only reason why the second `rm` should succeed, at least that I can
>> think of, is that something on Windows blocked those files from being
>> deleted, and it is no longer blocking after a couple seconds, and that
>> usually means that an anti-malware scanned those files.
>
> Both commits referenced in df4c0d1a79's log message fixed races
> between 'test_done's cleanup and a still running background 'git gc',
> and df4c0d1a79 was meant to draw our attention to similar issues in
> the future.  And it did:
>
>   https://public-inbox.org/git/20190602091919.GN951@szeder.dev/
>=20=20=20
> So no, the failure is not inevitable, there are other reasons why the
> second 'rm' might still succeed after the first failed, even just a
> fraction of a second later.  And yes, that 'sleep' added in the patch
> above did unquestionably break that canary,

Having read that thread now I agree, but I also left with a "who cares?"
and "so let's keep the sleep then?".

I.e. is this a problem that any of the software we're maintaining is
going to care about in the wild, it's not like people are expecting gc,
repack, fast-import etc. to behave well in the face of rm -rfing the
directory they're operating on.

So it seems like just an issue that crops up because of how our test
suite manages and removes per-test trash directories. So it seems better
to:

 1. Just keep that "sleep a bit" and retry hack

 2. Maybe on some/most platforms we can use cgroups or whatever passes
    for a reliable "I started a process tree starting at this PID, kill
    -9 the whole thing please" before cleanup these days.
