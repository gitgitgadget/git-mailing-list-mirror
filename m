Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E768C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A636113B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhGSWQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhGSSxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 14:53:49 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12971C0613E0
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:25:53 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id t46-20020a4a96f10000b02902618ad2ea55so4743221ooi.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9DQx1TejX/SKJnsI0pR4tywqLHVUkbHPEZH2D24cEsI=;
        b=e6x5rUJth1U85yEZKKIBOYbfl+MjU3/ISsmkiBQFVtn4tO0lBiXXHVLNHURpr7oGoR
         oj4wwr9Q7fI7Xsk50I+aXlmltzixKamkcDZkhumNZ+oeS9Z+6StbPDhcvmjL+Q9nHV22
         5f9D3eZl1bRMbrmAfoqiaNGFE6Eq+scJT+rCgmCu3e4Q/KKXNudOPQyyYHsz18mKtDGj
         fcfUSEkzzwfScTfzN5FrKUx/39rsHJehCjIlOUeNcYHsWRC10J9FBuoIfjqsG7BBcWhx
         XdjNCNnBv+i4vUTJydy7dcOXW3RIVML1MCYuaPmkhtdRUR4ZcIm44Gjfo8njM2AUH9dt
         rzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9DQx1TejX/SKJnsI0pR4tywqLHVUkbHPEZH2D24cEsI=;
        b=rWkWS8fzEUZUruTvGgn99rUwJaPWD0uAbEo/LYtE42qEjjhv9bT3viBOyRiwA9+4QI
         pV56tJGlC2xCBuGgZ1dSSAMxi/Z0xZSs1FGFcI9Tl/TLsUIQyUy87i/cnbY8q/LRttne
         Xf0dy/SAlQMqs+IKwsYxALKrexLRH4QqzVhOQxcOjQfKlvjmA953w6WQUScsev0kAqGF
         YB8mc0TrYIcpi43oi+NGtYBiWAeGtrJHoMbE1JluplCDrqmN0ZvaVXc6Im7y8IcswIfj
         HWa8fqqaOwcPJ4uZBtoe5brTsfsfvj7CwFLO6TSTJ4FZMojiFqZgCryyztsEi4u5NMHi
         l83w==
X-Gm-Message-State: AOAM531Z9Cm9ISh3GDRMXRPQbjqjX/QDpFrr34kkdOLV6ZwV0b+Bpj/2
        2vuNpgjNU3k1UiY/sXPlvL8=
X-Google-Smtp-Source: ABdhPJyqAOmII+K1NY7CQXGl5nMNCBW9f9SES2WT5HDIEv2maJ1QnMf3A4ROyOfe+NxBt3i73TVFwA==
X-Received: by 2002:a4a:4fca:: with SMTP id c193mr18229795oob.33.1626723245524;
        Mon, 19 Jul 2021 12:34:05 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 48sm3735745otf.13.2021.07.19.12.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:34:05 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:34:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <60f5d3ac6ce_14538820823@natae.notmuch>
In-Reply-To: <60f5c7b867941_141e5c20886@natae.notmuch>
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
 <60f5c7b867941_141e5c20886@natae.notmuch>
Subject: Re: progress test failure on fedora34
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > =

> > On Wed, Jul 14 2021, Alex Henrie wrote:
> > =

> > > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> > > <avarab@gmail.com> wrote:
> > >>
> > >>
> > >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> > >>
> > >> > Hi,
> > >> > The test t0500-progress-display.sh in current master fails on la=
test
> > >> > fedora34.
> > >> > The break was introduced with:
> > >> >
> > >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> > >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> > >> >
> > >> > Kind regards,
> > >> > Fabian
> > >>
> > >> I have not been able to reproduce this, it seems the below E-Mail =
was
> > >> word-wrapped by your mailer, which is especially bad here since ge=
tting
> > >> to the bottom of this requires looking at the whitespace.
> > >>
> > >> Is there a way you could tar that up and send it (to me personally=
 is
> > >> fine, or some pastebin or whatever).
> > >>
> > >> I am able to reproduce something that looks like this if I
> > >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we s=
et it to
> > >> 80, and that the progress.c code just ends up with an
> > >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other=
 fancy
> > >> logic) in progress.c, I'm not seeing right now how this could happ=
en...
> > >
> > > This test also fails for me when using QTerminal or Konsole, but it=

> > > passes on XTerm and LXTerminal.
> > =

> > I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce i=
t,
> > resized the window etc., always get COLUMNS=3D80 if I add some printf=

> > debugging.
> > =

> > Do you mind testing with an ad-hoc patch like this on top? It will fa=
il
> > right away, but should say COLUMNS =3D 80 in the output.
> > =

> > The only thing I can think of right now is that some terminals are do=
ing
> > some evil trickery to LD_PRELOAD or whatever and intercept getenv() f=
or
> > COLUMNS and the like, but that's an entirely unfounded hunch.
> =

> I'm able to reproduce this. The test fails when running directly with
> bash, but not with prove.
> =

> And it seems to be a bug in bash:
> =

>   export COLUMNS=3D80
> =

>   echo "COLUMNS: $COLUMNS"
>   cat > /tmp/expect <<EOF
>   foobar
>   EOF
>   echo "COLUMNS: $COLUMNS"
> =

> I get:
> =

>   COLUMNS: 80
>   COLUMNS: 115
> =

> Even directly in the console.

Hmm, from man bash:

  checkwinsize
    If  set, bash checks the window size after each external (non=E2=80=90=
builtin) com=E2=80=90
    mand and, if necessary, updates the values of LINES and COLUMNS.  Thi=
s  op=E2=80=90
    tion is enabled by default.

Seems like since bash 5.0 this is on by default.

-- =

Felipe Contreras=
