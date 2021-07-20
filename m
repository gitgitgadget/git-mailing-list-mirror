Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05227C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 01:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FC6610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 01:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbhGTAVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 20:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356602AbhGSX76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 19:59:58 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C83C061768
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 17:40:35 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y17-20020a4ae7110000b0290262f3c22a63so4925733oou.9
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yCehnXZ23kcCrAKHT5RpiqUnrqbpcVvkHmEQg3WqpCc=;
        b=lJXitGkpE334Rsqu7YxEMA09DQphsR5xpPQrp3LdAqf3huWktLJBPiudnuC5UnbVZD
         soLQ1SMvHaGkTtymj5gvicc1DxdMGMCDop8dh4s0KhP+3luFsj2JDosKIXVcw8SCh8Hx
         88ZKXQ3aQRgO05wCeSthPmECgdm27iyjqii1WXXoPRO0RLzJ4AlJmKWr0VBwNzdTaGZ2
         ne0sX5MqMojER2Q6qA/t+qbtEiMqstgOxFniPyId0pFKhIJqiQfzOfaFjH7LcJcaDE/G
         Q01kz1k3y6J2R6Ui1e7ZS80hwn6IX8HBYJSiGxgZ4QHcpxaoAaRkCn8+DBNSADPuB82W
         CUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yCehnXZ23kcCrAKHT5RpiqUnrqbpcVvkHmEQg3WqpCc=;
        b=OI/M2Y+vEvcFLj53fCufOTNnYkU/vBgIx2UmHRW2/ToXPXhsX5pt8cmPR9TijeqFIZ
         AP9NwN4o36DILAhTcS/GjRYme0ZZTh0O87gE1Ggl04XgXkBIc0XoVvT5OpJ0dBos5ceD
         JIj14Ka1MqY7hSETFh9JfFOxXGFyEWZ5DCP7ouB3uz/3FC11WySsMHEEHlBjvzSZzBSc
         eggexSosQIePNh8/P3xv9uNA8wm/4zs2ZVtl165/EdpLboyOXGU3clzd06DKaoKvvc2Y
         Hy2YSgOpc+/0jtgfz20icdqftwq0N3dCCJI/5kDcj7SanRgHd3wfqv1ozPnBmoxYTA/2
         wJEg==
X-Gm-Message-State: AOAM533c8swryAxcQilnyEt8+vvEEvyPmW1bkx+PAnZA1JkjH4n3IONQ
        QdVoEoMasLIejkNy2RQBAJM=
X-Google-Smtp-Source: ABdhPJxSLXTttjEHnRxArNgJf73VKGHa9iQdYFylOrRIpIoSSFMHfm7LMnKn+3r1kAxdPe3Rrbp/Jg==
X-Received: by 2002:a4a:6b12:: with SMTP id g18mr19309322ooc.27.1626741635373;
        Mon, 19 Jul 2021 17:40:35 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 45sm2921437oty.16.2021.07.19.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 17:40:34 -0700 (PDT)
Date:   Mon, 19 Jul 2021 19:40:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <60f61b81a3b74_14781320816@natae.notmuch>
In-Reply-To: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
 <60f5c7b867941_141e5c20886@natae.notmuch>
 <60f5d3ac6ce_14538820823@natae.notmuch>
 <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
Subject: Re: progress test failure on fedora34
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Mon, Jul 19, 2021 at 1:34 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Felipe Contreras wrote:
> > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > >
> > > > On Wed, Jul 14 2021, Alex Henrie wrote:
> > > >
> > > > > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason
> > > > > <avarab@gmail.com> wrote:
> > > > >>
> > > > >>
> > > > >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> > > > >>
> > > > >> > Hi,
> > > > >> > The test t0500-progress-display.sh in current master fails o=
n latest
> > > > >> > fedora34.
> > > > >> > The break was introduced with:
> > > > >> >
> > > > >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> > > > >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> > > > >> >
> > > > >> > Kind regards,
> > > > >> > Fabian
> > > > >>
> > > > >> I have not been able to reproduce this, it seems the below E-M=
ail was
> > > > >> word-wrapped by your mailer, which is especially bad here sinc=
e getting
> > > > >> to the bottom of this requires looking at the whitespace.
> > > > >>
> > > > >> Is there a way you could tar that up and send it (to me person=
ally is
> > > > >> fine, or some pastebin or whatever).
> > > > >>
> > > > >> I am able to reproduce something that looks like this if I
> > > > >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that =
we set it to
> > > > >> 80, and that the progress.c code just ends up with an
> > > > >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no o=
ther fancy
> > > > >> logic) in progress.c, I'm not seeing right now how this could =
happen...
> > > > >
> > > > > This test also fails for me when using QTerminal or Konsole, bu=
t it
> > > > > passes on XTerm and LXTerminal.
> > > >
> > > > I tried this on Debian 11 with QTerminal 0.16.1 and can't reprodu=
ce it,
> > > > resized the window etc., always get COLUMNS=3D80 if I add some pr=
intf
> > > > debugging.
> > > >
> > > > Do you mind testing with an ad-hoc patch like this on top? It wil=
l fail
> > > > right away, but should say COLUMNS =3D 80 in the output.
> > > >
> > > > The only thing I can think of right now is that some terminals ar=
e doing
> > > > some evil trickery to LD_PRELOAD or whatever and intercept getenv=
() for
> > > > COLUMNS and the like, but that's an entirely unfounded hunch.
> > >
> > > I'm able to reproduce this. The test fails when running directly wi=
th
> > > bash, but not with prove.
> > >
> > > And it seems to be a bug in bash:
> > >
> > >   export COLUMNS=3D80
> > >
> > >   echo "COLUMNS: $COLUMNS"
> > >   cat > /tmp/expect <<EOF
> > >   foobar
> > >   EOF
> > >   echo "COLUMNS: $COLUMNS"
> > >
> > > I get:
> > >
> > >   COLUMNS: 80
> > >   COLUMNS: 115
> > >
> > > Even directly in the console.
> >
> > Hmm, from man bash:
> >
> >   checkwinsize
> >     If  set, bash checks the window size after each external (non=E2=80=
=90builtin) com=E2=80=90
> >     mand and, if necessary, updates the values of LINES and COLUMNS. =
 This  op=E2=80=90
> >     tion is enabled by default.
> >
> > Seems like since bash 5.0 this is on by default.
> =

> Indeed, running `shopt -u checkwinsize` right after exporting COLUMNS
> in test-lib.sh fixes the tests. Great work!

Yeah, this fixes it, but it doesn't seem we are setting any
bash-specific options right now, and additionally I don't think bash
should be doing that in the first place. If the shell is
non-interactive, why is checkwinsize being honored?

Moreover, why does it work with prove? I'm investigating that right now,
but so far I haven't found any reason.

-- =

Felipe Contreras=
