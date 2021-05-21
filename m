Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C8DC433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1952B6135C
	for <git@archiver.kernel.org>; Fri, 21 May 2021 01:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhEUBVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 21:21:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47352 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236106AbhEUBVx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 May 2021 21:21:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 24F3D6043F;
        Fri, 21 May 2021 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621560030;
        bh=ERHny+TRGAawd++vue5+aAAlFe8BstrG8p1hipRGTJc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZACOEivZt3rWPOM4LmQPk21k0BRzN6mMeVBf/mwW6I2IduJGe3zlAz6MCjC+6yxut
         ON7/BLf+88GjzYDQk5MQWAH1kIgZK2nrFotk2AhUuJMD569koW2bwEZjxlVv1IvdA7
         dZb+APdO68wnPDtfb0pdSNpQYeVLeAePGfBgRR0d4xrkEEru89wO4YWFyMoRxtHx+O
         5TorQc1V9zSb/+mduskmqKugYHA2yS6awTpIaABidOcwCzRoJg8VsoWtEqr9oQ3PNI
         9FddTXP43Jeayyvf58hzoDq5QeT0yYZaKx5u9BppCXKVatkgRjfpHuEe7Z1otXJ51u
         AiG93ymPPHZli4qvmYy9RuoSK7n+43wsaXLKZxaRXyBsJVjIfKOboFb1D2cSepPZgK
         /2eOMch3S/teylQ5eGZoFs2xl+auy1MMrNcLHDfKz2lhqrU/Y5hAhrq6BjHrJw1bbD
         QMiXpQRsbJjqwZmT26zIxeyiDpaJRsDStz4qPOuFJfAP/MG48m6
Date:   Fri, 21 May 2021 01:20:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKcK2elWqBQ+IVDt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F3GzvytIwQH4bG3D"
Content-Disposition: inline
In-Reply-To: <YKWggLGDhTOY+lcy@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F3GzvytIwQH4bG3D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-19 at 23:34:24, Jonathan Nieder wrote:
> Hi,
>=20
> (Danger, jrn is wading into error handling again...)
>=20
> At $DAYJOB we are setting up some alerting for some bot fleets and
> developer workstations, using trace2 as the data source.  Having
> trace2 has been great --- combined with gradual weekly rollouts of
> "next", it helps us to understand quickly when a change is creating a
> regression for users, which hopefully improves the quality of Git for
> everyone.
>=20
> One kind of signal we haven't been able to make good use of is error
> rates.  The problem is that a die() call can be an indication of
>=20
>  a. the user asked to do something that isn't sensible, and we kindly
>     rebuked the user
>=20
>  b. we contacted a server, and the server was not happy with our
>     request
>=20
>  c. the local Git repository is corrupt
>=20
>  d. we ran out of resources (e.g., disk space)
>=20
>  e. we encountered an internal error in handling the user's
>     legitimate request
>=20
> and these different cases do not all motivate the same response.
> (E.g., if (c) affects just a single bot but produces a high error rate
> from that bot, we shouldn't be alarmed; if (d) is happening on a bot,
> then we should look into giving it more disk; if (e) is increasing
> significantly during a rollout then we should roll back quickly.)

In general, I'm in favor of adding some sort of error code here.  Even
though I don't normally use trace2, I think there's a lot of benefit to
having a standardized set of error codes, and this seems like as good a
place as any to introduce them.

A future iteration of this might look like us returning a negative error
code from a function instead of -1 for us to signal to the caller that a
particular error case occurred.  We need not implement that now, of
course, but I bring it up in case we want to accommodate that in our
design now for future us.

I do agree with Peff that this may not necessarily provide all of the
insight you want, since it can be hard to distinguish why the error
occurred.  For example, in Git LFS, we sometimes will pass objects we
don't have to git rev-list (with --missing) and that's completely
expected, whereas a missing object with git fsck would generally be
cause for alarm.  Provided you're comfortable with some ambiguity, I
think this would be a nice improvement.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--F3GzvytIwQH4bG3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKcK2QAKCRB8DEliiIei
gdk3AQCJKeIg/7bgsQ0LUbOp5kbsrG0/vW+h4X07Xp8ghe0vBgD7BetHuw7Ggtzp
43m2FhfYimQeL9wvfKDsmrt3WcUePgw=
=Pyfd
-----END PGP SIGNATURE-----

--F3GzvytIwQH4bG3D--
