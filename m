Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A0C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 17:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhLaRQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 12:16:28 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:41914 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhLaRQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 12:16:27 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 918A419F5B4;
        Fri, 31 Dec 2021 18:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640970986;
        bh=tV7McLoQSvwF/oBE7s2E8P+54tsjtMcYn1kcdMenSBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpVW8IX8DO2g9DDMVWwleTXgXYyDF4C6AOfjHrE+rxtbYaz1wRxDq0d0X0PmzdTW5
         XrPYIUvekutM75nFGRWJfRlLa8Cb0h46GRt2E5j5tZuR2gQr5iebZUTCWiPVCx/HLh
         cgKAB250X03lnUzjTy3jJuiJfd+1NJZ2RnyLqcdkOluHh87eiPeaic0we46YXMUp5n
         +6LgyqATaY1I8vgYNPBkfcD5SBTZFh9U0JXTaHdVqOyLI1zWRmgjCHzWnIBE5EF3rn
         WdfV6u1uKnGMUxUq46DXwK1p7VwzUnO9HHwLLZxKrHstOSswVBb7Gz0l51Jpo9dJ/S
         1/wsAVswUNQYQ==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 11/11] i18n: turn even more messages into "cannot be used together" ones
Date:   Fri, 31 Dec 2021 18:16:13 +0100
Message-ID: <1726995.HyZKkVmFqF@cayenne>
In-Reply-To: <xmqqy241oh36.fsf@gitster.g>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com> <12c5da8108752cd70b5b0147fd58c7280ebb3099.1640804108.git.gitgitgadget@gmail.com> <xmqqy241oh36.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, 30 December 2021 23:36:45 CET Junio C Hamano wrote:
> "Jean-No=EBl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>=20
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >
> > Even if some of these messages are not subject to gettext i18n, this
> > helps bring a single style of message for a given error type.
>=20
> Makes sense, but ...
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 067ec53d69f..dcaa3b5f395 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -566,7 +566,7 @@ int cmd_add(int argc, const char **argv, const char=
=20
*prefix)
> > =20
> >  	if (pathspec_from_file) {
> >  		if (pathspec.nr)
> > -			die(_("--pathspec-from-file is incompatible=20
with pathspec arguments"));
> > +			die(_("'--pathspec-from-file' and pathspec=20
arguments cannot be used together"));
>=20
> Don't we want the literal `--pathspec-from-file` outside the format
> string to prevent it from l10n?  Or have all the changes in this
> series to turn _("use '--concrete-option-name' in message") into
> _("use '%s' in message") with '--concrete-option-name' as an
> argument done only to reduce the number of distinct format strings?
>=20
> I just skimmed the rest of the patch but the above comment seems to
> apply to all the hunks.
>=20
> Thanks.
>=20

The idea was to apply the '%s' shifting only to strings that can be=20
factorized,
in order to curb the number of translatable strings.

Anyway, swiching from=20

    die(_("use '--concrete-option-name' in message"))=20

into

    die(_("use option '%s' in message"), "--concrete-option-name")

in a more generic way fits perfectly in the spirit I had for this series.

On the other hand, the patch list is already quite large and this logic won=
't=20
be extended to every other candidate strings that are not already changed=20
here. That may be the object of another series.

JN



