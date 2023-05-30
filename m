Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E3C77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 01:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjE3BRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 21:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjE3BRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 21:17:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEE9C
        for <git@vger.kernel.org>; Mon, 29 May 2023 18:17:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53202149ae2so2342466a12.3
        for <git@vger.kernel.org>; Mon, 29 May 2023 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685409436; x=1688001436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2LhFSzZLLUcjtlkcZZGlldmduHyRv6RMHPaWgGhc7k=;
        b=ZnomUpRI22h5HjXX3xQk4xBckjIOmK54s/71s9VRwiA+VzVG7MsAKHgG8Z7k1EGrwN
         gffdPZXy33KxQsFyedMR/v+I4WUZcBQtqXIZZzF2faAiVYoV9Esq8tarX0IlqLDg1Jr2
         T5fQLfKCCEoAebuWHa080Y/LBmOFIYdqGSbxtLBynlPRIVZTWUIlkLbhZaSNLEf/V+ht
         05A6SR1uH/41xB1ZRwvzWBOB32zburB/eHfCDXy91bJC/zcBnPYIx3dxCORRnifGlT0g
         cI4uvwevKH/09HvXUq7VIHxvf1mFcEMbjMvWnoY79A/QcvRarKm4xjsZiAcCQoo3DlbT
         v2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685409436; x=1688001436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2LhFSzZLLUcjtlkcZZGlldmduHyRv6RMHPaWgGhc7k=;
        b=hKLq7TWv17ny835tDIS+i3vCgBB25ckx0CeGNW46gJL85zWQHdJKmhOqZGF08gDqbD
         l18uQW55MkOGuDrwCBdND/NCu0LulAVWfBdoue1Y/39gKlvf8BUQAqJMLZong30CHJ15
         42eyltc+LopjvFMMmjAMiVST/bldkrc38TrVSYHGplOhq5WKpxW6ZNRVkLfBVscg+Ars
         i59J7h79ZP7HPGYMPgMMQwksd0IjBhBfbzADxI2Xh71+YwKqsTATn7muC/nV1+NA2uoL
         x3txnl7boBptWtkE8c0R3FrMTK+l1G5XMP7JrywlrVv4EMxVgOER7tD5HcV9DdaRO/h7
         PdiA==
X-Gm-Message-State: AC+VfDzBHKAH8h1kFsu9XYdelSiAHOOCLxw9YPZKTVxjPLGUrI5lITcr
        lmzjeYdg1zb4FYFVkYofvMU=
X-Google-Smtp-Source: ACHHUZ4RZ81L6BAJyOOCwNRVZskAuAX6OACJ6bQhgD9T5I6J11Ups+6nY2TO6EMhEIurm3wUFtxc8g==
X-Received: by 2002:a17:902:dac2:b0:1b0:46ae:ff8b with SMTP id q2-20020a170902dac200b001b046aeff8bmr796163plx.48.1685409436326;
        Mon, 29 May 2023 18:17:16 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-46.three.co.id. [116.206.12.46])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b00192aa53a7d5sm3586331plp.8.2023.05.29.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 18:17:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2173E1069B8; Tue, 30 May 2023 08:10:01 +0700 (WIB)
Date:   Tue, 30 May 2023 08:10:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Draft of Git Rev News edition 99
Message-ID: <ZHVM6dw4lIHjdLGw@debian.me>
References: <CAP8UFD2zaEPKNj2SpgGQUyFRmNp24E-8n1O9K5Se9=OhXckxGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0DmM9OMtK3+3LOgk"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2zaEPKNj2SpgGQUyFRmNp24E-8n1O9K5Se9=OhXckxGQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0DmM9OMtK3+3LOgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 12:34:17AM +0200, Christian Couder wrote:
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>=20
>   https://github.com/git/git.github.io/issues/643
>=20
> You can also reply to this email.

=46rom the draft:

> After some discussions between Peff, Phillip and Junio, Peff sent a versi=
on 3
> of his patch series with small changes. Especially the new version makes =
sure
> we reject timestamps that start with a character that we don't consider a
> whitespace or a digit or the - character before using strtoumax(3) as thi=
s was
> considered enough to avoid issues related to this function.

I think it's odd to have second person (we) when the text is written in
third-person perspective. Thus, abouve should have been:

> ... Especially in the new version, it made sure that timestamps that were
> started with a character that wasn't considered as either a whitespace, a
> digit, or - character, were rejected before using strtoumax(3) ...

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0DmM9OMtK3+3LOgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZHVM4gAKCRB7tWyQc2rT
CKiKAQC2EVpuS2rT6mtzs4+iWV1uvBrKy9Tz2peqe/23vvGPmQEA6lA6/5npUtYa
smlvflVDLrdhl3ZHuq/5j3q3DtS+jA8=
=hRLG
-----END PGP SIGNATURE-----

--0DmM9OMtK3+3LOgk--
