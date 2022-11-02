Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ADC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 21:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKBV2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiKBV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 17:27:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F0E0C9
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 14:27:45 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D1FDE5A1AC;
        Wed,  2 Nov 2022 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1667424464;
        bh=vb3l/WsNWdaxh03Pe0EKrZRimKEHQdVwXBg8XoW01xc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XF/Y3967fkM+JNQayE68C9jC5E7X8MeDVHWcS0gAwBidzY3mKAV9NTzZDbvikpjfd
         KQVt+GiUWYCpWmqumb0D3yDfGm/GBKc5/5m7MLoQ7AWuB0exXwz23XHmYCAm3/VAd0
         aAETTAhhHhT9yvqHvJ7eOkV4rE7fsOIrc3vrPD8Sdw2QEShLvy2EF5o1czQMr0safy
         QYcBRUfNDt+xj1KeXjSfkdD8at6xwLU1HcO9hg50hc4AKwOZlr+6T98U69tNymjRnf
         Q+VAjpNiDGjQw8vCTitEFIcXiWmK0zFZpOTuC7tWRDbWmMxpgdZakiF8FM3t2lj1F8
         XeSl30S/hBPCL2Fz/sx8hfcpLOSNjOqAZpR5++467TRRKnuAmpthO87NbqMAUIhO1X
         ctQ7Pry4kS6irqCOX9QS/dX3pMgAwYV6c2ZHQJlECgtzBrVkagAMmUgeFKPGdzCINd
         zgV1kx6r8WV3IrENmtuIxzRw0S5lPHhpZ4Q7sTvv/Yt9LM/eYrX
Date:   Wed, 2 Nov 2022 21:27:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Soo <johh.soo@arista.com>
Cc:     git@vger.kernel.org
Subject: Re: safe.directory and ACLs
Message-ID: <Y2LgzmTvElmRTsoe@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Soo <johh.soo@arista.com>, git@vger.kernel.org
References: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sn5QuwnigJ/cWnJa"
Content-Disposition: inline
In-Reply-To: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Sn5QuwnigJ/cWnJa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-02 at 15:18:25, John Soo wrote:
> Hello git!
>=20
> We have some build processes that would like access to repos in /home
> directories that are 0700. We had done this already:
>=20
> $ setfacl --recursive --modify group:<build users
> group>:r-X,default:group:<build users group>:r-X /home
>=20
> Should this ACL be enough to consider the repos "owned" by the build
> users? Should *any* ACL be enough to consider the repos "owned" by the
> build users?
>=20
> Currently:
> $ sudo -u <build user> git config --get safe.directory
> $ sudo -u <build user> git -C /home/<non build user>/repo rev-parse HEAD
> fatal: unsafe repository ('/home/<non build user>/repo' is owned by
> someone else)
> To add an exception for this directory, call:
>=20
>         git config --global --add safe.directory /home/<non build user>

No, the permissions of a repository, whether standard Unix permissions
or ACLs, are not relevant to ownership.  The question here is whether
the owner of the .git directory (that is, the value of the `st_uid`
field when calling lstat(2) on it) is equal to the effective user ID.

When you the path in `ls`, you can see the owner and group of the file
specified, and that owner is what matters here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Sn5QuwnigJ/cWnJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2LgzgAKCRB8DEliiIei
gfeCAP9SCQGLnaP1lEjPqPdfDJgnUjQEI4FiUy25PDSmyJ2URQD/S8m0eF/nNfzW
WW9XISdRk2EbnY2E2KFz4usTD65PAgM=
=cvXW
-----END PGP SIGNATURE-----

--Sn5QuwnigJ/cWnJa--
