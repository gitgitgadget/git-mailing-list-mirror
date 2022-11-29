Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB6BC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 10:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiK2KDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiK2KDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 05:03:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F65B590
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:03:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so18991832edc.12
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDcFHQNDXkzcspLWRMMoyy7omZ9yx1ZuQLjtIYmYwF4=;
        b=MOTDkNb4TY1LEHL4cSpDUilxvSCWkjCOIU0N3wXSg104ViCI5pUi5B/SzRpK62pkBZ
         bxBL6GNfCCdOMvnxhcgjdSZuwIHnaJDvtOEwCJFQYvEnmAUMApFyzKynpm1onKgOLLqb
         8BFM9Ky2PyBz3q7LfXGQGJjWlb89zSuCdZkJdbKHwAMUrwEV5yQSGaZ4yTuwCkrwyvLJ
         PA6BL9ispNcj8vSIizqCfs/+tUveOVmAw2u3JVf1K/MzXrxliGl8VnaEU+C1mqu5B4yz
         OflTRAY/JF2uO2xLzD6hOwnRE6KqTbwMnPSXnFnMoVJoIWhpnHm4nAj4LC6EfAvlFzDS
         cVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDcFHQNDXkzcspLWRMMoyy7omZ9yx1ZuQLjtIYmYwF4=;
        b=bXOaTI7VHbBYzkBtw6f+Z/cPBqLyA3A9jXxz2W4WobXDxtiELxb936XIgNd4EOMgTn
         QGfhFxvEOfDtOBfXe1E/qeh6hoq9s8ULazyJ9+M8U2FBe3AwyEAQnP1P7yJjOlJn7cSE
         cPcMvb4J1akdsyEduVjfQZDojL2fvwaRTkPIVyp5lLEGZuKqv5LHtEZrMaFRTmM7Sj7k
         +bIY6rHHXrr+ngw5bOsjegybmLDmFpv80HsE5/Ipbk4tV471r6tIACt6RTE6AbY8YndX
         THr+YvpicN7CEDfnS51Rl+6fEoPnEPQbDAASlCrBhzqF0vi/4k0xFgDFt9FJTyTZrEdL
         7XRw==
X-Gm-Message-State: ANoB5pmVDnbZHf9Do93vk5z1FBdSNd/UTB58+mu5VqbNecFOLZ1eqeG+
        QAVXA0SbApCJuA2FOITU3KU=
X-Google-Smtp-Source: AA0mqf6eyJ88ujgQV9MGp+D0xFxOLhaAyUPrL/j00lnKGncZHYUUVMtRHD39snk208xLKM8dC1XB2g==
X-Received: by 2002:a05:6402:298f:b0:468:f142:3040 with SMTP id eq15-20020a056402298f00b00468f1423040mr50609448edb.107.1669716224914;
        Tue, 29 Nov 2022 02:03:44 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i25-20020a056402055900b0046730154ccbsm6076324edx.42.2022.11.29.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:03:44 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:03:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3] am: Allow passing --no-verify flag
Message-ID: <Y4XY/tUT+vKOrabX@orome>
References: <20221128174825.1510407-1-thierry.reding@gmail.com>
 <xmqqv8my4kvu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ss3KFi2SiaJ/DaBg"
Content-Disposition: inline
In-Reply-To: <xmqqv8my4kvu.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ss3KFi2SiaJ/DaBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 10:20:05AM +0900, Junio C Hamano wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
>=20
> > +test_expect_success 'am with failing applypatch-msg hook (no verify)' '
> > +	rm -fr .git/rebase-apply &&
> > +	git reset --hard &&
> > +	git checkout first &&
> > +	test_hook applypatch-msg <<-\EOF &&
> > +	exit 1
> > +	EOF
> > +	git am --no-verify patch1
> > +'
> > +
> >  test_expect_success 'am with pre-applypatch hook' '
> >  	rm -fr .git/rebase-apply &&
> >  	git reset --hard &&
> > @@ -374,6 +384,16 @@ test_expect_success 'am with failing pre-applypatc=
h hook' '
> >  	test_cmp_rev first HEAD
> >  '
> > =20
> > +test_expect_success 'am with failing pre-applypatch hook (no verify)' '
> > +	rm -fr .git/rebase-apply &&
> > +	git reset --hard &&
> > +	git checkout first &&
> > +	test_hook pre-applypatch <<-\EOF &&
> > +	exit 1
> > +	EOF
> > +	git am --no-verify patch1
> > +'
> > +
> >  test_expect_success 'am with post-applypatch hook' '
> >  	rm -fr .git/rebase-apply &&
> >  	git reset --hard &&
>=20
> These two tests will still pass if you change the implementation to
> run the hook and simply ignore its exit status, but I recall you
> making a good argument against that alternative implementation ,in
> comparison to "not running the hook at all".
>=20
> I think these tests should make sure that the hooks did not even
> run.  Perhaps by creating a marker file before running "git am",
> adding a "rm" that marker file in the hook, and making sure that
> the marker file still exists after "git am" returns, or something
> like that.

All good points. I've updated both tests to check that patches have been
applied correctly and that the scripts haven't been run.

Thierry

--Ss3KFi2SiaJ/DaBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOF2P4ACgkQ3SOs138+
s6GS3A/+OBObJfeasgO7UP5zfxiJzXX2jK7xCzlWoiqTycHESLMHObCPuNQz79oH
hcnQBWGFKqkPldIg8I61Mg/Uw8J6ThbyjhlWP9luKxGSkxIYm2Ej2MDQ/z31eCe8
AeoRp9X5jtLehK9rU09ksKRXagWO0/k8+pPkFLLBsR8gJywil5Xk6BiFitmZyC/Y
+rv+InZHFy9snATdTfIDW6FyYnGKSl6I5pHP8EHt4Qb0x4QV1Aw4Yj5yZaS53Jr5
lhxTPU3FJMLHh+YSZkRaVJEXpcK/SFReDbk44aKpbDajQSKWb5ku2R/3abWSKdWr
HWKNfPofvDPu8PbbfDXcNnnJ0dZWEzSX+dVce7gZ9O17RIagOaWkXonm0ZaF4I+c
lCxof14Kvvmu3ZJW6V4ulYPHNe/wD6rhgi7DRXzdbUbutDK6v0m0kULRJ9Ag6I1K
RouCJiGXjnzM887hJDZG/oRfXswciXjAgwDTPrNPEMr9BL72Eh3AVgXk/6u20krR
Ob56x55Mn4bQ/j7uuBt3Airpklww+hhH+bJ3Fnhzhpd0d1A/PjSje6uRUcYSxWLm
3EsttBKF9PhQ08mwUw9Dn9VGs+O0JjovWaz1ZIUzlINZypcGYKThUY51j0bVGnPz
h+PyzoYdUB1Ex7qd2loxDGVu6UyQMD5sS17BcKef2btcSr+AVws=
=P7pa
-----END PGP SIGNATURE-----

--Ss3KFi2SiaJ/DaBg--
