Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B80C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbjDEPzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjDEPy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:54:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E6119
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:54:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E4AD1F1C16;
        Wed,  5 Apr 2023 11:54:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=qxHfqchS1jjQcXo0Cy/OmGbdIvGf86ZECE5Gkjq
        +Y4g=; b=bA41qrU9gL/QQDfFwTjYJvB8FIuUvTqmTblS6gR7W2YNH9sqeQzs6sU
        99tkBPXmwYUsS404jfahRCNnH/Hsp1oqvCJTf2mLKpDcg+dBnPNpOpcju9/7MPlR
        DXE2P5g7iO0rmcIHFjC00MBq73Ad0Uky4oGYbeDEEAgU+OZRVTMs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 671AE1F1C15;
        Wed,  5 Apr 2023 11:54:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 743D41F1C13;
        Wed,  5 Apr 2023 11:54:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 5 Apr 2023 11:54:49 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2ZyTTZFbd_gNtw@pobox.com>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OX7MKnrpSUV5QuvN"
Content-Disposition: inline
In-Reply-To: <ZC2LOAwycdaUawxM@ncase>
X-Pobox-Relay-ID: 33ED1AD2-D3CA-11ED-AD8E-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OX7MKnrpSUV5QuvN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt wrote:
> On Wed, Apr 05, 2023 at 10:42:52AM -0400, Todd Zullinger wrote:
>> Is there a reason to not set PERL_PATH, which is the
>> documented method to handle this?  From the Makefike:
>>=20
>> # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/per=
l).
>=20
> Setting PERL_PATH helps with a subset of invocations where the Makefile
> either executes Perl directly or where it writes the shebang itself. But
> the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
> and that path is not adjusted by setting PERL_PATH.

Ahh.  I wonder if that's intentional?  I haven't dug into
the history, so I'm not sure.  It seems like an oversight,
as an initial reaction.

> I'd be happy to amend the patch series to only fix up shebangs which
> would not be helped by setting PERL_PATH. But if we can make it work
> without having to set PERL_PATH at all I don't quite see the point.

It's certainly debatable whether using /path/to/env perl is
better than hard-coding it at build time (forgetting about
the usage of RUNTIME_PREFIX). [Debatable in a friendly
sense, of course.]

As a distribution packager, I prefer to set the path at
build time to help ensure that an end user can't easily
break things by installing a different perl in PATH.

The Fedora build system will munge /path/to/env perl
shebangs to /usr/bin/perl and it won't effect us much.

That may not be true for other distributions and they may
care more if they want to keep using a hard-coded path to
perl.  I don't know how it may affects the Windows folks
either, who are further askew from our other, more UNIX-like
targets.

I don't know what the right choice is for upstream Git, it
can easily be argued in either direction. :)

Cheers,

--=20
Todd

--OX7MKnrpSUV5QuvN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIGcjzoxKnTmf/7jnQyWTi76vDOMFAmQtmcMACgkQQyWTi76v
DOMoRAf/dto99w5VRrnkXPndep6l9JsBIS5LgZFFNCTMzIRboUHWui0rACP0lK+H
H5W2TzpvGD42CVhNMRu2pKAdQPm5EZeaZ7TfH+4g9nvOMha/Qg3B4EmnRbg7YGkA
1/OuRK23QaRkvKUIeFLe7Av0JzkJVyO6ZYX6dz5eQFx50sequaBcRse8apuTg9yq
mnEukO/QFzCo7uFEnrqzC/wYb5X5y/OMiJsMPavdM1ELH/rF5mQBU/TZfitWQ0Bc
0g5WVimCqyvUpEwFVeHi+OjYKKbxyoJ7gg9BvrKOkHV0YHBKQDvKcH+oitRygOLd
iAv+IAB1J/FrTq051s6J8qd/Il0fPw==
=m5DK
-----END PGP SIGNATURE-----

--OX7MKnrpSUV5QuvN--
