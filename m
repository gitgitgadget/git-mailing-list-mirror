Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9BFC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0838960F3A
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJLVPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:15:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbhJLVPH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 17:15:07 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F07060734;
        Tue, 12 Oct 2021 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634073154;
        bh=93j1s/Wg/33kWYE5fDRa9oe+HftRjR7CZP3GdgrCuE8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h5RV+/fSWOlamEdG5gkwi6hQ2tn2XkKjfJtyGl1x7mHiE+js3zHEZ6g5KyOHK+ag9
         S4vnyzz4QbQpjgVGSGQhIIDlC1MMW+QheV0wW+DzeQHiHfQk0OutVd5cE964W7CY2x
         UZpITnz3oZOjgZMMuURWVB/39BZr4AitYsh79LZ5ltAQgaebZedmhr6rZWc8nTzCBw
         a2qb4CcjKdp46DpY1UHEi6AA//KhUbEar8NzczjN7xBko8M4CpMwz2VpLDAwfalnb3
         OcLn7WUjljIX1s+EODIsubK+n0NnmNgOIh/2xUe0VsantFoBlFf4q8CznqW324GbsQ
         +b2TWYsfE9ptQlADEWEKQKy0bVt1kDSSF8Xjm/YS7gaqJf6Tt3Xq3vIP/f1NbW8kFi
         HtFyFvKDTtLGtJm7ULKZaKxyTXXFG0f6BvfWjSzOC94a1ndEYkH/Jx40rEPlWALsZr
         Y6fqB7tmBTS1+DzQ3UxyfLtyBBm1cfDPHRgu2vb7/PLUi/GS8hq
Date:   Tue, 12 Oct 2021 21:12:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alex Waite <alex@waite.eu>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWX6PJrjgp6rHZu/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZVbrM09na4WSAw6X"
Content-Disposition: inline
In-Reply-To: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZVbrM09na4WSAw6X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-12 at 14:25:04, Alex Waite wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
>   I configured my ~/.gitconfig so that git credentials invoke a helper fo=
r a
>   subdomain using wildcards. For example:
>=20
>   [credential "https://*.example.com"]
>           helper =3D "/usr/local/bin/custom_helper"
>=20
>   This works for all tested subdomains /except/ for those which contain an
>   underscore.
>=20
>   authenticates without prompting:
>     git clone https://testA.example.com
>     git clone https://test-b.example.com
>=20
>   prompts for authentication:
>     git clone https://test_c.example.com
>=20
>=20
> What did you expect to happen? (Expected behavior)
>=20
>   I expected the pattern matching to work for all resolved URLs.

As mentioned below and elsewhere in this thread, this isn't a valid
hostname, and as a result, this isn't even a valid URL according to RFC
3986 unless you intended it to be resolved in a system other than DNS.

I don't personally see a reason to accept locally specified hostnames
(e.g., in a hosts file) which don't conform to RFC 1123 or which
otherwise don't conform to the DNS standards for hostnames, but perhaps
others can see a good reason to do so.

> Anything else you want to add:
>=20
>   If I don't use pattern matching, and instead state the URL explicitly in
>   ~/.gitconfig, it works as expected. For example, the following works:
>=20
>   [credential "https://test_c.example.com"]
>           helper =3D "/usr/local/bin/custom_helper"
>=20
>   As part of writing this bug report, I learned that underscores are not =
valid
>   DNS characters for hostnames (but are valid for other record types, whi=
ch are
>   largely irrelevant to git).
>=20
>   What is notable is that git pattern matching enforces the spec more str=
ictly
>   than without pattern matching (and more strictly than the OS and every =
DNS
>   server between my system and the authoritative DNS server).
>=20
>   At minimum, git should be consistent with itself.
>=20
>   As for which behavior is "correct", the question is whether git wishes =
to
>   follow/enforce the spec tightly, or not get in the way of a real-world =
oddity
>   that everything else seems to tolerate.

There are a variety of systems which won't accept such a hostname, so I
think at best we should reject such hostnames altogether and prevent
this from working at all, since they are likely to be subtly broken in a
variety of ways and we won't want to try to fix all of the cases in
which things are broken.  To me, this appears to be simply a case where
we should improve error handling.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ZVbrM09na4WSAw6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWX6OwAKCRB8DEliiIei
gWJdAQDCmTO0UFSd/LDZvTtf4lew6qSS1hu/kCIujLnHBEWLlAD6AlG6ri4KtCWH
dDxS8Qi0dLU43TnpEdiRJid0h5tImAA=
=DaWf
-----END PGP SIGNATURE-----

--ZVbrM09na4WSAw6X--
