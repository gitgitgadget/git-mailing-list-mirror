Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7A5C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EB2613AB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbhDMMC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhDMMC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:02:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28722C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:02:38 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 2so8374099vsh.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dXlE5bDiiK+S06C1JTWcrrr60+yNRGu5SFzKeGdx4S4=;
        b=LIHoFc7nsxZvN19Vit9zqBxewcYlSi/mciXXofEy3xDJQix0qEjl6V6jLHdKT0AKMN
         3rC6lz7ruVVprfZ0idjg5kxIPg7kI8zckzsCJZy0C9XLhIX0SHrKGK2sP0bnsKx+OTTb
         pnsKtzP0jQKYA8ot2n9kFBaXg+ZtpEJHQoJz6hz9QC62DAljGUl1uAs/UlKhx5TFhk89
         DeOLvP9rieEbXndkmRW6CTWjZG3vd5vQUPAtq2cqtLoCkKAwKrpa0crNGjSzp/Wq86WB
         dlnmV8oPvivrIIYKYq9hfylPeXN/18P5Srh27vnWTOFTb6LL4q43Ruon7fZnvj0WEcrq
         fLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dXlE5bDiiK+S06C1JTWcrrr60+yNRGu5SFzKeGdx4S4=;
        b=Oyz0VFy87vg1w+U48BG0BWyjf49I0UFR8Kt6v2t5erSs+rQARq97dM/xeJDgGqBigl
         v5r28GcvCyGWS0Gkjw/JSOnRAnVr6FBED4bEiarsrTjbuIoJBo95x0S781zkCKbD9DnN
         AAFMATK+AigTw8zlytSaljVveKSm2mSuTCgfQClwxMdsfRzq9aS5A1GUC4o2tIwyeRTC
         8Q5hXNlO3301AwDT1ZKPrDBVP3SrnpeMrJMyKunz85OJ7VJkBKJ/9gjEIkdfjHdqLD54
         AZxXWCGOdMC9Bv1H3D8ANG6cUZpKmQGnLcTXEVHiwgV8Lc3HAxBu3K/QEAdAZB+kAxKM
         Lpqg==
X-Gm-Message-State: AOAM532D85ucJSjcs/TjiPkV0h0MseV1BrrXcFb9bbUofWR4AmkWLvRh
        iAVGFR/eXwrZiT1bv2XI+wcaAWzd8NxPSMf8bCjhTmtw4kw=
X-Google-Smtp-Source: ABdhPJx8kPLs/l7qrAH0irbivd/gmrCBTVuGkgIn9ST7pw9tdKDRElnXKiwXISTN+3452kw7XW+En2DsQFL7wVacNRU=
X-Received: by 2002:a67:e34e:: with SMTP id s14mr5169936vsm.50.1618315357152;
 Tue, 13 Apr 2021 05:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
 <xmqq4kgbb2ic.fsf@gitster.g> <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Apr 2021 14:02:25 +0200
Message-ID: <CAFQ2z_OMUdi4D3Jg3rsPr_Q-VeRptdiEOiYOL2kmyuBuvZLCjg@mail.gmail.com>
Subject: Re: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 1:58 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Mon, Apr 12, 2021 at 11:45 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> > > @@ -251,7 +252,9 @@ static int debug_read_raw_ref(struct ref_store *r=
ef_store, const char *refname,
> > >               trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=
=3D> %s) type %x: %d\n",
> > >                       refname, oid_to_hex(oid), referent->buf, *type,=
 res);
> > >       } else {
> > > -             trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n",=
 refname, res);
> > > +             trace_printf_key(&trace_refs,
> > > +                              "read_raw_ref: %s: %d (errno %d)\n", r=
efname,
> > > +                              res, errno);
> > >       }
> >
> > OK.  Between trace_printf_key() and the return of the call to
> > read_raw_ref() method of the ref backend is only an "if (res =3D=3D 0)"
> > condition and I do not see anything that might clobber errno.
>
> I don't want to bet on that. Let me send a second round.

oh, ugh.  In email, there are two calls, but one is prefixed with '-'.

Nevertheless, a bit of paranoia doesn't hurt here.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
