Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47189C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiK2KDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2KC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 05:02:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E85B590
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:02:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r26so16941714edc.10
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65KHMz7WYrnqPXM8GBSDMVAdlyP6ZXLoeEKZDqI114w=;
        b=YWoLx/GhGWmQSfu8WFt/PnmtIKp4bb1MZ3RivpV5oxHYgOtcjE/wVyHIutRs+VDCdw
         pBnXbYM2MOuYuXoRWWCSOyTtj9wdG5C6qUdKW0AyJSlXIqKPVoPXcs31PHre2wL0if9U
         pank7sDMP7K2T2i9UNm7USklhpuQD6gFS2nTt5XydZjk5Mzi7cWT5slGEeY9yiwOnmtM
         FHJ2EsL0NJkhl4aIfho2lMrbcF7Qr9TK/VuSmcgmJFL2MPWHG2lhiy7b4V1L3i2TYF7d
         uDQVNZELhRE4rJcd2/ZvV3OmTZUK2ybFCivh2pHa+wvFLCeTq75U2sj8rejkHiGzIK2d
         dhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65KHMz7WYrnqPXM8GBSDMVAdlyP6ZXLoeEKZDqI114w=;
        b=Am2yhvNrDXt8NpkWF0UN82jhrJm7OltIjW98H1AFG8a/sHMKY6LskPpG9/qDpfVew+
         6Pjn77nQek4gmeHiY2PTRg8/hKoqQH1P5npad8d2jTeCGfZE6jZLnwV2Zdm9sgSFrTC6
         uVZv30ISnY97kINP9wYrvj4fMI7hUx3i9eK7GxNuj0dvFwrKAqIvPI8O08KLFg4z2sDe
         IFBcf0va6rS/sOEKERdkpy6tMTNCivEqvPCaBtH3TWMO13MP59Dybg/1MMpnaH0+1ulz
         fuSvqwjnFeb3Jgoa6C37NdtvQDB4cn3l/Sq0GbBR79WhBrvkt10fE5/kivqHpeEfxVsI
         yigw==
X-Gm-Message-State: ANoB5pmi6LPdmG4b/1DtcWoNgCPXDEObwrrmcilZHc71nHj3x2eJRtIC
        hOxRS2IJxgHHvcZRefNKPJntBy7TAo4=
X-Google-Smtp-Source: AA0mqf5Wcu6vED1LtBNe0Lec3ttaTXQ6uZEYcajWSiGyay702C7DnHOal7wfGWzl17lhLIRMhjA2Pg==
X-Received: by 2002:aa7:d3cb:0:b0:461:8d98:3d6d with SMTP id o11-20020aa7d3cb000000b004618d983d6dmr37203373edr.116.1669716174619;
        Tue, 29 Nov 2022 02:02:54 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007bd15e582a3sm4649406ejf.181.2022.11.29.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:02:53 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:02:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] am: Allow passing --no-verify flag
Message-ID: <Y4XYzPhZLhmoGzZT@orome>
References: <20221128174825.1510407-1-thierry.reding@gmail.com>
 <Y4U/OhHSg85UV+5L@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UrQ7TDqUuddfI462"
Content-Disposition: inline
In-Reply-To: <Y4U/OhHSg85UV+5L@nand.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UrQ7TDqUuddfI462
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 06:07:38PM -0500, Taylor Blau wrote:
> Hi Thierry,
>=20
> This is looking pretty good. Thanks for pushing out a couple of new
> rounds. I took a look at the discussion and have some thoughts below,
> but they are minor.
>=20
> This will likely not be in the upcoming v2.39.0, since Junio has already
> cut and pushed the first release candidate tag. But you should feel free
> to keep working on it in the meantime and we can revisit it post-2.39.

That's fine. No rush. I've had local workarounds for this for a very
long time, so I can be patient for a little longer. =3D)

> On Mon, Nov 28, 2022 at 06:48:25PM +0100, Thierry Reding wrote:
> > diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> > index 326276e51ce5..0c1dfb3c98b4 100644
> > --- a/Documentation/git-am.txt
> > +++ b/Documentation/git-am.txt
> > @@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> > +'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-ver=
ify]
>=20
> Spelling this as "[--no-verify]" and not "[--[no-]verify]" is right,
> since the option itself is called "--no-verify" (and thus has the
> OPT_NONEG flag bit set), and "--verify" does not exist. Good.
>=20
> >  	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
> >  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
> >  	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
> > @@ -138,6 +138,12 @@ include::rerere-options.txt[]
> >  --interactive::
> >  	Run interactively.
> >
> > +-n::
> > +--no-verify::
> > +	By default, the pre-applypatch and applypatch-msg hooks are run.
> > +	When any of `--no-verify` or `-n` is given, these are bypassed.
>=20
> Should we be more explicit here, given the discussion in the earlier
> rounds? IOW, instead of saying that they are "bypassed" (which might
> lead the reader to believe that they are run and their output/exit code
> ignored), should we say that they are "not run" and be clearer?

I adopted the wording as for git commit and since the behavior is
exactly the same, it seemed best to stay consistent with that. My
interpretation of "bypassed" is equivalent to "unused" or "ignored",
though "ignored" in this case relating to their existence rather than
return value.

Either wording is fine with me, so if you feel strongly I can reword
this. In that case it might be worth updating the git commit
documentation as well to avoid the same ambiguity.

>=20
> The (elided) implementation below looks good to me.
>=20
> > diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> > index cdad4b688078..84e6bebeca7a 100755
> > --- a/t/t4150-am.sh
> > +++ b/t/t4150-am.sh
> > @@ -345,6 +345,16 @@ test_expect_success 'am with failing applypatch-ms=
g hook' '
> >  	test_cmp_rev first HEAD
> >  '
> >
> > +test_expect_success 'am with failing applypatch-msg hook (no verify)' '
> > +	rm -fr .git/rebase-apply &&
> > +	git reset --hard &&
> > +	git checkout first &&
> > +	test_hook applypatch-msg <<-\EOF &&
> > +	exit 1
> > +	EOF
> > +	git am --no-verify patch1
>=20
> Should we verify that the patch was applied with the expected message?

Yes, that's a good point. I've updated both tests to check that the
patch has been applied and the scripts haven't been run.

Thanks,
Thierry

--UrQ7TDqUuddfI462
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOF2MwACgkQ3SOs138+
s6FEtxAAvUWQb9W+5/kiUAo0WeV2O/FbypZtizxwbneDj9ejH5LXLziJWmQ4NCMT
lyzM+A8zWIOzuz7Znft0eGtQ67GeUZ97ksN5zM9JtO+BLjhf/sgWSankeLe7fb+Y
c+KA/VlCy//kq0HEpq9+g65451Zdinu5bY8eh4r0h3gaBOBn1oi0RZYoBKo1II8H
j/9jWjP59KBwxwzvgGUeqS7i4F0PztWlTQuCEXmPc3IEi97DFAeVw28ujoSPlfce
4IwgIwzaAeCRjtsPk2n3csEtufcX9WTQ2QQKp8FA+mlK5mbw8ogN3ERh9vnbcDWu
sAUn0PYh15cIUHAXrnXQ093x7TVYefnIe3A2ieCEY4NHw/sExjBx0XmawfU2xC+0
Cgn15kV0H8sFI5BmPyCdS8Ji8lpqJHqykh+i6BX+IlFEuAwlW6lswJdgej/Hh0EI
rW5rOt71xBGhDghsVll5H6NfgXxCbWhUJEuBTP5a7pD/5/95i5mrJAQSR5g8Ou/Y
yalJRfuHdIMnkMdjwtGEp1/WsPRijhXk4+CJ/OlYKKKWR660ZENs/Dvlwt2yDDTQ
V8nxCxaSf7upl2zdLV2k6MHD1QsPKRMtRHY90OB8T8mS43SPj62d1iV0YlrnhRNz
OLIiVrB98cUm34QH4txcen381LoGg0UOzhgzbJZYKsKYGF29o8M=
=cSPH
-----END PGP SIGNATURE-----

--UrQ7TDqUuddfI462--
