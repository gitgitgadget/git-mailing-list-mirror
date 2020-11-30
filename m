Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF05FC64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9734320731
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntd3E6Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgK3Opl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3Opk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 09:45:40 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1779C0617A6
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:44:47 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id e5so2759497vkd.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HJHvzH4mmWWRelIncX3fNaEBtzFCuedBqkZFpd5uAZU=;
        b=ntd3E6VlZ/d+wVRyFx7PQswfoOwNoFgpHK2DUCfCNvd4XI8XDx9PO0M1FMQyZVGLWk
         TVWWXEAUTd+w7IaZndgJXa2hd/gZ7Y16E6R/gUiLCba9mROXs5Qvg+1Yp9VTjnexNBM2
         J9qJ4MegjTiADVsY7l8rFkRS/4B27zqpidItED9zEQBP+LaJ057aTI3m/kwpRtFpOyTq
         HM8JYOENyAVkBeswzZlGXfwaeWw7SFg19meVaeZRlszpocC1l7mXZsokbPNOTx4aAaw+
         YUUfw7EWK5ONb0sU5OZcnXHzFDsIljpOzeY/bSnt9DG+6cbLp1F/Ovo4Q/Q/RQ/j6CHH
         kREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJHvzH4mmWWRelIncX3fNaEBtzFCuedBqkZFpd5uAZU=;
        b=QH0Jk52JrQYekts+2SI0HbHTwUNZmV+55nb4qHhTWu+XFilB759X85Hd7OxiosaqKz
         DCiCCODnZTYM+vkGHXz3jTmgpx+x0AtvZtV6Okti3NcjrlevTXHF/5z0w5oFOkiLLoMZ
         OUGwyPE20XsOuYJXLbXzs5A9zahf/AuezsAX9TO6hRHqxetfFn05iYnJaEkqJwdInZII
         XhfXEq5gjX/P1Ir6GAfahiptcBrgLgNz/eUz8vvUD4pOPJCGOx9AfAFLAC7tYvUQqYRB
         /UWKvuDpKcHuQ/89yPm64sid42U+LPvTjX2Jgj8Hm0kX8mehXdss9r5i+M6XElag8TYa
         Ma7w==
X-Gm-Message-State: AOAM532ACJaaHYkLQV7bT6eYEeykgSmi0dxfeg6sWpiQ4CAaE5veOtYc
        ds/kMAr8hWkIBggk/N6e4gfQT2xOEX10gPvpo8nMHQ==
X-Google-Smtp-Source: ABdhPJz1P8pWyJr/SC6dBOFyU5bL0F4P8Ga0kA7wHk/lMSHJ7TTv8a2zW8cwvA4d2SOV+deQqPSTumCUTejYdNfKpqQ=
X-Received: by 2002:a1f:2ecd:: with SMTP id u196mr15213678vku.19.1606747486711;
 Mon, 30 Nov 2020 06:44:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com> <20201009211300.GA2774782@google.com>
In-Reply-To: <20201009211300.GA2774782@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 15:44:35 +0100
Message-ID: <CAFQ2z_Oz9KZAVwYVWGBGZG4dB7BG0OBwrj+j67qSyNDrtPHiOw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 9, 2020 at 11:13 PM Emily Shaffer <emilyshaffer@google.com> wro=
te:
>
> On Thu, Oct 01, 2020 at 08:58:51PM -0700, Jonathan Nieder wrote:
> >
> > Hi,
> >
> > Han-Wen Nienhuys wrote:
> >
> > >  reftable/reftable.h | 585 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 585 insertions(+)
> > >  create mode 100644 reftable/reftable.h
> >
> > Adding a header in a separate patch from the implementation doesn't
> > match the usual practice.  Can we add declarations in the same patch
> > as the functions being declared instead?
> >
> > We could still introduce the header early in its own patch if we want,
> > but it would be a skeleton of a header that gets filled out by later
> > patches.
>
> To poke a little deeper into what I think Jonathan is trying to say:
>
> Of course, taking a completed project - like your initial reftable
> submission - and then chopping it up into a cute story of commits is a
> pain in the ***. Doing it twice - or more - is just aggravating. So I
> wonder whether we can bikeshed what story would look nice before you
> even pick up your 'git rebase -i'? Doing that bikeshedding here on list

Looks like this didn't happen.  I went with Jonathan's suggestion, and
chopped the public API header in smaller bits. PTAL.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
