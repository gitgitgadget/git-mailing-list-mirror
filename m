Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03ECC64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4036A22203
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLBLCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLBLCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 06:02:41 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D3C0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 03:02:01 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id x4so684798vsp.7
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 03:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IdPbQOnquebnuuviEDdD8SnEuDyhCrjrc6Uu/elflsw=;
        b=du9u/UFJ4VZA3OrG58Sv7gEx0zrkvOsi/IEa9AytSuBxeW1d55hgC6eHmhkccG6dSd
         EZewjWSrSfTg6QIDNkMR4dLtIzNXjYcPDGpzoN+djsxdItWnmGfUCLVaGvG3icEdiTGp
         Ej9p09iMpc+3NmwkfzMRETCLiZZ5wzmx4sIduXwjf8cbgaP7qRFjXyC6aB0Tc3JKhfae
         8xUa5zBJD00LdCKyj+CG8v0LvgGK3waEfip8NG2AabZ4zaCqQ0WC2oWjcgF+pR0dO+I1
         +owQuptxOR1Lgu2/ntGrqCGkKwzZYPgdvzhA6bD0VqaG5/0Nc/Ni55dzsodTG/em5YPJ
         ZFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IdPbQOnquebnuuviEDdD8SnEuDyhCrjrc6Uu/elflsw=;
        b=aYPDm3xq+1ifu+HDbny4p+j+cFo0pbTuN8BhBIuumZypIW06T4s6ZP9zC63NE34AsK
         HhXo5dlyCjo+KZIP1kNHwiuFyeJZ9JHE15K07SRCYBtbCXU0uue2jsRKF+igTKrBmjPs
         ubKunBukajanrnrz+h9uBzvhbDm4yLUJZeXwhihq1L3+mIw4OplDbnDP19lgE8iUAg4e
         XemSEm7DiYYzgFBBhxZCS5aIqj5nSJNAucnkRTv3xnmdsRFVJ5QiX+aY+svsPgxiBpfh
         YU6bdD1e/vmmHY9JI8qNLQBgWKGmoockh6on6YgFwVldFcxJcnLOlZdCTrSKUfHOcDoM
         UDCw==
X-Gm-Message-State: AOAM532viY3Hi+IJe9EZIifI0vyd0QsBBU8fCrMp9gVbzFwuH2YqLkY+
        hCzbOlG7hL2RORF3ky4S+Uf4I8QJGITn7QeI+jQXfw==
X-Google-Smtp-Source: ABdhPJyEZQzmeG1LxTeXOchk+3898KXvE159zWtgDpdYWkw7+3VcmWu8yNapyQaw6cuUKIJ4qNA/xqX2TTOhAd1kfrU=
X-Received: by 2002:a67:f7c8:: with SMTP id a8mr1069320vsp.54.1606906920415;
 Wed, 02 Dec 2020 03:02:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
 <X8Ya24TJd87hRq7H@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2012011519340.54@tvgsbejvaqbjf.bet>
 <X8by+j24ccvt0F04@coredump.intra.peff.net>
In-Reply-To: <X8by+j24ccvt0F04@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 2 Dec 2020 12:01:49 +0100
Message-ID: <CAFQ2z_P3WmSyBJvhCQi-rOQRvUwbK9RH6CGvS2Br0zW-=xwa4A@mail.gmail.com>
Subject: Re: [PATCH 6/6] fixup! reftable: rest of library
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 2, 2020 at 2:50 AM Jeff King <peff@peff.net> wrote:
> > > I don't see it being invoked anywhere,
> >
> > It is invoked in `t/t0032-reftable-unittest.sh`:
> > https://github.com/dscho/git/blob/reftable-on-windows/t/t0032-reftable-=
unittest.sh
>
> Ah, thank you. I was looking at what Junio has queued in hn/reftable.
>
> > > but presumably if we were to add support to our test suite, we'd have=
 a
> > > script which invokes it within a scratch directory.
> >
> > I agree that it would make most sense for t0032 to prefix the call to
> > `test-tool` with `TMPDIR=3D$PWD`.
>
> Yep, that would be fine.
>
> I'm not sure if the long-term goal is to have this opaque unit-test
> program or not. If it is, I was likewise going to suggest that its
> ad-hoc output be replaced with TAP. But it looks like on your branch
> that "test-tool reftable" does not produce output at all. So I may be a
> bit behind on what the current state and forward plans are...

The most important requirement is that something fails if the
unittests don't work. I surmised that that meant running tests from
test-helper in some way, so this is what happens now. Looking for
"unit.?test" across the git codebase didn't turn up much info. Happy
to explore other solutions if you can give me pointers.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
