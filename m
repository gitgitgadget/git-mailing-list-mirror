Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D2FC35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3921D7D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khV33sn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgBCQkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:40:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBCQkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 11:40:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so18013971wmf.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EP5hlJOqZXw8gKkK/ij/kRmw22NMDHhS+Y0B8YAIIU8=;
        b=khV33sn+f0INlAy5rdd1wehcHPurfz7DdeS1O6U6oLAinJ3lfKWrdg66ggfdzWM/IO
         wz9QwQ4e/P5ulMdVr4KOt0fEKjSA0ksr9yHrgd/Jd9sXuMvHBKikFvJyZvVGMiy4FNZQ
         KlDEILdi/NVvL2pUFwWcFPXBlkghbPsVSFva0ic4od7PYdFjCHr3squzkKOq4m7jgBCf
         8e5UJembaxfb/XHb+PQrNZuAUfP4TYV4KZ9A3jqaTcZSH3LcZqF8knL/0JgeDsMihnp1
         ZoV5nl/HIAimFiw+YNuLAY5ALh6PuGqLh8FuYOpUxo0hL5L21FUlZnj65Tk9dLQUYs9x
         5CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EP5hlJOqZXw8gKkK/ij/kRmw22NMDHhS+Y0B8YAIIU8=;
        b=XKXdkGpKNQV+3vIM7vMCtdWwfmLucpUwoFyDXGPiWGcRbVPDiMhHrmSueD4TaWOyaL
         Wvve6GeBoFtwlfA+RG4qmTrkBcIvbjEcZzuDQaObZ+DHBr3Q6kldYYbB9R4GksdpXTpz
         9PTFEXNl/kFUIlYygqLrgXyz7w6Se/IV0OXS0NDp96O4/kEoGLq6h1F0+HHDE7n3Tl+i
         p1vuB1uyNM6ey0NEpXNnG1zSnWx31x7CuQ+sT5P273q9eSnmAba7O8gRbXekUU+7XxgF
         LMhR/19LWlzHWzGxlxO+Map3Et2Yvq7sON7CekQtdA5vlJTw+tEvZhiu08rKKLCTQJOf
         SK3Q==
X-Gm-Message-State: APjAAAVqNRYyrihzbOZfhQ8zld2duNwPO9SAU/Mqlfiqo50G4D8sSlg4
        VMmtbqYLt9onifgYNm/ykqBjLxsTAJeyg6D1sz4m1g==
X-Google-Smtp-Source: APXvYqzC8A5gjLvl8UbiRUKF8y+bdGcuDK890cJBp5CQk4BtHTwMF2NLOhCeApdrJS9xafsG/lXOlB6QcM/H7oKEHQw=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr29111906wmb.44.1580748008427;
 Mon, 03 Feb 2020 08:40:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx> <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net>
In-Reply-To: <20200130072122.GC2189233@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 3 Feb 2020 17:39:55 +0100
Message-ID: <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 8:21 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 29, 2020 at 08:50:13PM +0100, Han-Wen Nienhuys wrote:
>
> > > That might be a good enough safety. I guess the next question would b=
e,  would
> > > it be OK for reftable to ignore and entries under the refs/ dir if th=
ey happen
> > > to appear there somehow?
> >
> > I propose to ignore refs/ if it is read-only, and fail if it is r/w.
> > We're not going to look over the files under refs/ . If people
> > actively try to shoot themselves in the foot, why would we stop them?
>
> I'm worried that playing games with permissions is going to lead to
> confusing outcomes. There are reasons one might want a r/o refs/
> directory with the current system (e.g., you could have a repository on
> a read-only mount). Or you might have a system which doesn't implement
> the full POSIX permissions, and everything appears to be r/w by the
> user.

OK, so permissions are out. How about:

  HEAD - convincing enough for old versions to accept
  refs/ - a standard rwx directory
  reftable/ - a normal directory
  reftable-list - the list of tables
  reads/heads  - a file containing "this repo uses reftables. Upgrade
to git vXYZ"

this would prevent people from erroneously creating normal branches.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
