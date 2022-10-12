Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D4C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJLVcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJLVcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:32:20 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5715120BC0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:32:17 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4E9265A39A;
        Wed, 12 Oct 2022 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665610336;
        bh=0DIjWITnX0xFg7woFFPjIIqdEMY1kDROFJH9fKgCrao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Q3IjHN+w21/JrE/PYwnSflAoTu7z3Z/yGZT+0hmX15/NowOfwXfDw5HInNsuixtdw
         fwRv/+dznlvHkeDDOrSJjwQQjpRHnADjVNhmZ/0aaB7PgMNd0mlC14PH4X7afE0r8v
         kuRXPXZtgkIKtIRhRZLoGwCUNd+Vsm43GU6BMOgd7gGj1ykVldOEiF3SZK2JL2/Atf
         X7PqC2bsaAYPkePkbzTqaGoIwsP7U1q7QSze2xbdv4uKOm4J0VeARU1fh3hSpG3KYj
         bsCt9r4HR71Ffb31fvLdzfVcHW0rsXhWAK8DvqSUOYmDjGzcwXjqATqWCrIbTx0FFP
         U1Hw/pa+pCc7nHyA3NxFJd+jmgsO4f3GMZMp6EPe9qftvQ4Pf9q/VecAHnmd+PzNpS
         HpJ1XjyhzkUksshuakdAzNIRwFB7H9uwAYggRlbIhb4nWCzGP8IgW3mqxd1i9n+EB2
         +D48mH3TgYRWspAHSNsUrbYKcyRNo7+TsmxWQORCcd6BxoD0kV0
Date:   Wed, 12 Oct 2022 21:32:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ignacio Taranto <ignacio.taranto@eclypsium.com>
Cc:     git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Message-ID: <Y0cyX8Ggp+dkgAjX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7OdKKKU1TKXsVOUk"
Content-Disposition: inline
In-Reply-To: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7OdKKKU1TKXsVOUk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-12 at 21:17:04, Ignacio Taranto wrote:
> So, both git diff and git show display "\ No newline at end of file"
> for symlinks.
>=20
> I think this is related to how Git renders diffs, IMO it shouldn't
> display a warning about
> newlines for symlinks.
>=20
> Am I making any sense here?

What Git shows for a symlink is the destination of the symlink.  On
Unix systems other than macOS, path names may contain any byte other
than NUL, including a newline.

While it obviously is not a good practice to include newlines in your
paths, it is possible, and Git would not be able to round-trip symlinks
where the final character of the destination is a newline if we didn't
handle trailing newlines properly.  As a result, we're not likely to
change things here because it's required for correctness.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--7OdKKKU1TKXsVOUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0cyXwAKCRB8DEliiIei
gQVnAP9hsVtht2AI6Sxb9CBorPjA0hv9reQS5gXy9aTzC3yuIQD/a92SZCjLz7kj
prPMnWaeY/aS8x47L/zhsQq5K203TQQ=
=wOxT
-----END PGP SIGNATURE-----

--7OdKKKU1TKXsVOUk--
