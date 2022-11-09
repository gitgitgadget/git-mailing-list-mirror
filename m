Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D7BC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIXRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKIXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:16:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779402FFC9
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:16:46 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 904925A1FB;
        Wed,  9 Nov 2022 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668035805;
        bh=X+ugfngvVk1c33Z5sZRorOlfie4GBf+yRQEaw02/Y7k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tNK2s5qIyw8KAzWalHsmUKPY/knOHFJWyB1kG1lcqPZoV3SOsdildtoog5wXo0D16
         +BTY1mGsu6gITRcJfTo8rNnAyRMN6gav6/yytRNAYKPGtgKoerXy3UeloBuXBJ/kYU
         LUHERzC6MH+8vtbY5QHMqW1Jc9jq5oA0Ln+ykqRweH9UVWrf8AsQktwqzdBz12w3q0
         3FvM7J6Q5IgKQ/QDwgkunGFiJRRH3pyID/8ZZwJbmGFTwZUET0CvR1i4Ae0PcH93C5
         AOpOizsQSwNxogtflp4lKOr4VwdlT4Cvl1MstJumQksev4CqMESPnEAxr1Wl1vT5k7
         Zv7i5SV1weEB7iWPNxIPYiGxv1ZdfGqXpq3KcpUBjmJi16dIs7Y4hVNpojjTQw1p83
         e3uxIMMjTMSrB8dgRpKW6QyLYiy77IFljYNnQmlPbY8wHfsMh7sroswbCVpFGBFiTB
         QNSgdWfuy2laPNVglZ5UPPm1Wk5F+tomKXLP90CvdZ8B6A6+bTQ
Date:   Wed, 9 Nov 2022 23:16:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH] Change git-send-email's sendemail-validate hook to use
 header information
Message-ID: <Y2w023Vi3Wt4J7se@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20221109182254.71967-1-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NFaKOQ6mMtrILcmP"
Content-Disposition: inline
In-Reply-To: <20221109182254.71967-1-michael.strawbridge@amd.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NFaKOQ6mMtrILcmP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-09 at 18:23:06, Strawbridge, Michael wrote:
> Since commit-msg and pre-commit git hooks already expose commit
> contents, switch sendemail-validate to use the header information
> of the email that git-send-email intends to send.

I have a couple of thoughts here, and maybe you can explain them a bit
better in the commit message for v2.  First, I'm not sure why this is
valuable.  What do we gain from this that we don't have now?  Why is the
current state inadequate?

Also, how does this handle encoded headers?  I'd like to see some tests
before and after here, especially some including non-ASCII user.name
values so that we can test that we do the right thing here.  If there's
some beneficial improvement here that results in a behaviour change,
then of course we'd want to test that as well.

Finally, since we move the validation code farther down instead of first
thing, is there any place that this would result in a different
behaviour?  For example, --dry-run mode?  Is there any way we could send
data that isn't validated but should be?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NFaKOQ6mMtrILcmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2w02wAKCRB8DEliiIei
gaeaAQDcgOMtiOlKJhu2nphyzEcj0jZgXvsVAgmUK1Gct/SDdAD8Cb2QSM9vj1Cu
3lmvJTDapOhW9Zr4yqcqtFEI5MamRQg=
=ckzh
-----END PGP SIGNATURE-----

--NFaKOQ6mMtrILcmP--
