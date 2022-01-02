Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D464AC433F5
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiABU3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 15:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABU3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 15:29:18 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B33C061761
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 12:29:18 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:a2c7:cc81:4035:77ba])
        (Authenticated sender: jn.avila@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6EE5A780306;
        Sun,  2 Jan 2022 21:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1641155356;
        bh=ODmAadgUYf3VGrVlsVoSk1V4c0ZzLd78F5zY9juF3hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSL6Ey2L6QT5nfoL4AKWZPQ5YIT0Q2TDE+Oxn4d7K65j/cfK+VR019vF2nHMgsxwI
         9zs00xn1Gcj8DWRPT5dE6wKpPI+KasSH4qsXtNe39Q3Fp8UQp45hxIe86AJ3u5r/uD
         04oSk4BqVvgdsI9k8TiGoZT1SIL0kLuBZHStoL+oB1sMsihzVPjzFD2ruVv6ZxycZ0
         LpT7swN+5qnD7M1Ir3l6mqnovGqVD23SZkqWND5vDKlXDAi+1cgDhmCxmtQpgr8QdG
         +mCV6DZg0XlcSqABQkzOAGmjgmxGj3sKLOJLOLpqu9aQ1WrUS+/cMKvWo1/3zjcZyd
         5M/l6GhWlS5IA==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] i18n: tag.c factorize i18n strings
Date:   Sun, 02 Jan 2022 21:29:03 +0100
Message-ID: <38167869.LCjkVZloL3@cayenne>
In-Reply-To: <657377f3-b751-1863-409c-544b439b544f@web.de>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com> <a9d8a50d66676ea10292e8319e3eacbf7bcd83f5.1641143746.git.gitgitgadget@gmail.com> <657377f3-b751-1863-409c-544b439b544f@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, 2 January 2022 18:37:02 CET Ren=E9 Scharfe wrote:
> Am 02.01.22 um 18:15 schrieb Jean-No=EBl Avila via GitGitGadget:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >
> > Signed-off-by: Jean-No=EBl Avila <jn.avila@free.fr>
> > ---
> >  builtin/tag.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index dfdcfd37956..82e09c1b83d 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >  		OPT_END()
> >  	};
> >  	int ret =3D 0;
> > +	const char *only_in_list =3D NULL;
> >
> >  	setup_ref_filter_porcelain_msg();
> >
> > @@ -542,15 +543,17 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
> >  		goto cleanup;
> >  	}
> >  	if (filter.lines !=3D -1)
> > -		die(_("-n option is only allowed in list mode"));
> > -	if (filter.with_commit)
> > -		die(_("--contains option is only allowed in list mode"));
> > -	if (filter.no_commit)
> > -		die(_("--no-contains option is only allowed in list mode"));
> > -	if (filter.points_at.nr)
> > -		die(_("--points-at option is only allowed in list mode"));
> > +		only_in_list =3D "-n";
> > +	else if (filter.with_commit)
> > +		only_in_list =3D "--contains";
> > +	else if (filter.no_commit)
> > +		only_in_list =3D "--no-contains";
> > +	else if (filter.points_at.nr)
> > +		only_in_list =3D "--points-at";
> > +	if (only_in_list)
> > +		die(_("the '%s' option is only allowed in list mode"), only_in_list);
> >  	if (filter.reachable_from || filter.unreachable_from)
> > -		die(_("--merged and --no-merged options are only allowed in list mod=
e"));
> > +		die(_("'--merged' and '--no-merged' options are only allowed in list=
 mode"));
>=20
> What I meant in my earlier reply was: Shouldn't --merged and --no-merged
> be handled like the other options that require list mode?
>=20
> 	else if (filter.reachable_from)
> 		only_in_list =3D "--merged";
> 	else if (filter.unreachable_from)
> 		only_in_list =3D "--no-merged";
>=20

Oh. That's neat! Sorry for having missed that.



