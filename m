Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBAC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiD0V5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiD0V5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:57:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A36B0A7E
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:54:24 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 679205A407;
        Wed, 27 Apr 2022 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651096463;
        bh=IDn61yuniiwNXU+fggJBmpndUzKiC9RM1C4eXO/3KlA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JLDDLKlP6raLSwttpS8+2Y6C7m25BtYSYW/gtRtu66wLI/+DzLQ4SQHeCFq/MB8vs
         fywlLSlZgd4IbjX7zLkgkk2ooWGiSwTgXb4veXlR0Sdz3xrpWEiiblkVa09+weez1A
         zaeGqHhLww3JenK9vTj4CW3RaZ9uvPRXdKZ2dRVv5YskLQW1NeeAcPwpc1Iv18mEqN
         81Vp4R2BvHlA9o+6Ei1qaMdo5sQCv7ACzeylL1qmu+ttef9KuPo8LMxXap0lAg2cjZ
         DFPqhkfqnm6yvxQMbK+TK0Xa4Ay1oswMn6WWVOpAKi8xatwsjt2x8vvGs6InrrZEe1
         O/PQ1fu6hmp64xYeM8AuramSisAnzSQc1da49bWFDEchPvArJbgUbpsUCUD0R8y2/h
         GurEbjS0JtEpw79ILTrk7GvwA6TUlIUaYnBfHsU2xnEV2UpOFDgCKcSCXI7RS45oEb
         jQblSdVAw1bDBLeyoZqLnDAzv/iNeDxk4ADYnTqkCvTBoM+RO1W
Date:   Wed, 27 Apr 2022 21:54:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git stash create with untracked files?
Message-ID: <Ymm7iKKn/1I/YwOk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpoj1pF=FfRg6Rgz6bP2mZaQhApL7QQx9=2U7i4AE4zsJ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V0U/bAv1ywJrgXNh"
Content-Disposition: inline
In-Reply-To: <CAPMMpoj1pF=FfRg6Rgz6bP2mZaQhApL7QQx9=2U7i4AE4zsJ1w@mail.gmail.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V0U/bAv1ywJrgXNh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-27 at 10:42:51, Tao Klerks wrote:
> Hi folks,
>=20
> I'm just checking in case I'm missing something: Is there any way to
> tell "git stash create" to include untracked files?
>=20
> Someone recently brought up a situation where they'd like to take a
> working directory state (incl untracked but not-ignored files), and
> reproduce it in another working directory on another machine; "git
> stash create" seems to be ideal for this purpose, save for the
> (apparent) lack of arguments support.

I don't think there's support for that right now, looking at the code.

> If this is not possible today and we wanted to better support this
> usecase, what would be a sensible way to do it? I can see three
> possible directions:
>=20
> 1) Change the "create" subcommand to treat specific options as options
> rather than the stash message (and make it understand -u /
> --include-untracked)

This seems reasonable.  do_create_stash already takes several arguments
specifying what to include, so it's probably just a matter of parsing
options in create_stash and passing the proper arguments to
do_create_stash.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--V0U/bAv1ywJrgXNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmm7hgAKCRB8DEliiIei
gZ/RAP4jtZPIY8Fs56WdxRJasisIVafvBWGZrsQZZ+Gn+pXNpgD/STSS6Gr4pxh5
Oa5qFQgoIm2xJHMIuDCmsFR8jlL28Ak=
=rO4S
-----END PGP SIGNATURE-----

--V0U/bAv1ywJrgXNh--
