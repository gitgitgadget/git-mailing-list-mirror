Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFCC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKYRln (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 12:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYRlm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 12:41:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A41F60F
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 09:41:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ha10so11853826ejb.3
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwdNDc+UQ9US/KzHtK/PCwKMOEiuRu7RJc9b+yC/ZpA=;
        b=ogHlW6dduVjA4sxCoqUqVoMuIEEitZ+gjQB9JjpcpNP7GamMWNDFIHCD7KNVtxU4zH
         ndcvZVGlI1mp5eCYovvohe72dAXJIBULpbOEWcLbv1sw8neOqmrIDy/tecdOkrNEiSZS
         6qNPezszKeX1WKawm++WRPlCuONNC7ZE2Mro1eBKFMv50rLq26XNKI3u/WUdgiWsdTWK
         gy1CcNCZL2g74QQt610dQx0DqBy/6KIg5JNxBhnpB2qiiFO3n3/Ig5NpINJ8tc9R5wWI
         nIX2/yPUsFHtk1F9wQi7hRaq4Dbd9pR85Bq5U8qkAAmgadorZ7TbkMnEPj/ybTr7oed6
         2hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwdNDc+UQ9US/KzHtK/PCwKMOEiuRu7RJc9b+yC/ZpA=;
        b=MNC+MrdyvCQCSoquk8JuFF7UH64RqMxDTegm6V4Pu3tOhPpgYOum8Is2g2T2s2H3Uz
         7LcsoL/ISEw1npia6uMcFOmgvldaVZ01wy867ojhPGyWIWJ2pXuBZag5bPMJX7JzaIcc
         n//fu4JHRAV8nU0140DFhCw0p3dbXvt7HyNpfNopOvufWhGgYNs+Gyv6hAYQ179oBLuY
         A8LUcS5kPmhtVkxwCYk66oQNUAMdFNGV1X/srLJb4eXNYMUX4VPNUGDPSekv4bLMJ9gk
         CdtI0RfX2OrdeQPeqT1tW8bAibYUHKlypi3XM9ekNcTYOLNwsKOQV82YMEP+1FWh2OQc
         FG6g==
X-Gm-Message-State: ANoB5pm1dysk1EF1GJaduIJVi01yC4622IWf1il4UCCUEaPJRyVOgLDa
        e1aDOFcHsov2jlxoFwalnls=
X-Google-Smtp-Source: AA0mqf7HKvYmbgbccZdRE+33j5aAs61BU998G75X3NOdqr3NW/MZllbJ6wT6YChvy1Pw8ETpv9j8Wg==
X-Received: by 2002:a17:906:2c10:b0:7ad:d051:538f with SMTP id e16-20020a1709062c1000b007add051538fmr33685976ejh.401.1669398099771;
        Fri, 25 Nov 2022 09:41:39 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kx20-20020a170907775400b0078194737761sm1784996ejc.124.2022.11.25.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 09:41:39 -0800 (PST)
Date:   Fri, 25 Nov 2022 18:41:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] am: Allow passing --no-verify flag
Message-ID: <Y4D+UU6l3YN9r9Xn@orome>
References: <20221119005031.3170699-1-thierry.reding@gmail.com>
 <xmqqilj8yir1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LR0ECY7jCJRpSZEp"
Content-Disposition: inline
In-Reply-To: <xmqqilj8yir1.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LR0ECY7jCJRpSZEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 02:33:06PM +0900, Junio C Hamano wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
>=20
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The git-am --no-verify flag is analogous to the same flag passed to
> > git-commit. It bypasses the pre-applypatch and applypatch-msg hooks
> > if they are enabled.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - add test to verify that the new option works
>=20
> > +-n::
> > +--no-verify::
> > +	By default, the pre-applypatch and applypatch-msg hooks are run.
> > +	When any of `--no-verify` or `-n` is given, these are bypassed.
> > +	See also linkgit:githooks[5].
>=20
> I think the goal of this topic is to allow bypassing the checks made
> by these two hooks (and possibly future ones that validate the input
> to "am"), and there are at least two possible implementations to
> achieve that goal.  You can still run the hook and ignore its
> failure exit, or you can skip running the hook and pretend as if
> hook succeeded.
>=20
> As it is documented that applypatch-msg is allowed to edit the
> message file to normalize the message, between the two, running the
> hook (to allow the hook to automatically edit the message) but
> ignoring its failure would be a more intuitive approach to "bypass"
> the check.  If the option were called --no-hook or --bypass-hooks
> then it would be a different story, though.
>=20
> >  	assert(state->msg);
> > -	ret =3D run_hooks_l("applypatch-msg", am_path(state, "final-commit"),=
 NULL);
> > +
> > +	if (!state->no_verify)
> > +		ret =3D run_hooks_l("applypatch-msg", am_path(state, "final-commit")=
, NULL);
>=20
> And it seems that this took a less intuitive avenue of bypassing the
> hook completely.  I am not 100% convinced that this is the better
> choice (but I am not convinced it is the worse one, either).

Thinking a bit more about this, if we let applypatch-msg run but ignore
failures and continue on to commit the result, wouldn't that potentially
allow committing garbage? I'm thinking about cases where applypatch-msg
may attempt to normalize the message and fails badly, leaving a partial
commit message or none at all.

The primary use-case where I'd like to use this new option for git am is
when the pre-applypatch hook fails and that has less of the risks
associated with applypatch-msg, so perhaps --no-verify should only apply
to pre-applypatch?

>=20
> > diff --git a/t/t4154-am-noverify.sh b/t/t4154-am-noverify.sh
> > new file mode 100755
> > index 000000000000..fbf45998243f
> > --- /dev/null
> > +++ b/t/t4154-am-noverify.sh
> > @@ -0,0 +1,60 @@
> > +#!/bin/sh
> > +
>=20
> It is surprising, and I am not enthused to see, that this needs an
> entirely new script.
>=20
> Don't we already have a script or two to test "am", among which the
> invocation of hooks is already tested?

I can move the tests to the corresponding sections in t/t4150-am.sh.

Thierry

--LR0ECY7jCJRpSZEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOA/k8ACgkQ3SOs138+
s6HALBAAmsH5/GOi4Zw+jhyO00SVMyqgrwbPepYTVtNNx6dCfOBtD9l0tf9Tm1hU
BOQzk0w0dpfHT42zM0Q4kxnAvD6SoGof/tUdOvSehYaubeTUGkXDm4TI55I1O1vD
HYw6fqSyVyPwQH6IU81lwloVgQzyICESsRlcJhxLBIzZni08NGowLB8Ho/VMVKzy
Ef7imT4IUY4LqrV0Xq3WNA3Psd7r+/J1B96ZMCO2AfHKRtI5PLMj6neCPnskQqSd
P0ZnL/8i2g+bb0/sFhReNSVIah67dsuD27SXsy/lmxAdB8L9EqVH3yOW4NAoEnuA
EcsSKF8FKSs0Co3uCJKqgws0qfZDE6mdjnI0YARRl6lCaxr37HqnHBprbz+k0D+9
WeGjmK13xMmm88W8k6B/tRNJbnj16YUQk8yfVA/HzXIe2TPw/wPH5pNlMdelyzPN
Y+a4PEAaXfcmMifWFSUhzphCgLQa/C7Mb9UP90ygIzfnNyJGRVeqYYoZCKCuQNJn
f27JR7DYmCYvHTdqsi52JjoxS2zSy48UsvMHdclbac2p6+/QG2GV3XdHy73eDNMd
usUiCqK8S4DLZCDkBaAxIXH1W5ov08L7U4m3qGoF3P7jB2PVq2+Wca3JxawWzn07
5VL2RPR4yK6d1qBo5Bryut5T0t3YSkmQcK77bafNrFhT/X3jL34=
=Fpz8
-----END PGP SIGNATURE-----

--LR0ECY7jCJRpSZEp--
