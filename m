Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ECCC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D7761606
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEKXDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:03:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEKXDD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 19:03:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 372BA60456;
        Tue, 11 May 2021 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620774115;
        bh=siQ6U7RVEW2iBwIZ2p43Jx/VA6xQX+Fy+G9jk4WsUiA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bX1xba3IC4mI0coJtN/NyIUjRx6V+puYHmhQPWMb9XMpi6E67EHnBF0vNTZNo28Ur
         QgxGAu4K8c/4SFUqgKF8iBLgbu+WTSc5OZ3upidpt8rXZtIDkk6mJ4IQkzbMeICXBQ
         O0UvbIbLx60EMwNKMCQR+kilK7BQkrSxcW32duxx9pxTzNwRmr8RKIG2kWRw7o5AxC
         xZLDlj/UUG8WA3Lu6ZniF3RcHPB056K5kMkwgSbxp2wWoOXOfi5CqBattB2q+eCndg
         jiM/N1M9EfopnwfbPsHFL0XO9U9k/yQBXXEvHkZmsUCM/mws9G9Lf3ZQnJbFXT7hpB
         yMloihQHtSJwKsbtXeJnmF0u9hugaGzkQ5WezQdYj1qHAGSoBtNvBysiQqKyY6rWho
         aZNupa/l9P4v85514ZkTTTM0M+SN2rTdnAXtWnhAvJX6llNme0GqHkOECQH+5QP6kr
         UVqU4j4DDirJZbILgQB+1/a0lVYiBe21td0P/ZfQ5NpJXmUYCxm
Date:   Tue, 11 May 2021 23:01:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <YJsM3sUXRYjJiwZG@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210511103730.GA15003@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMA7BT7LNdAtmKNE"
Content-Disposition: inline
In-Reply-To: <20210511103730.GA15003@dcvr>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gMA7BT7LNdAtmKNE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 10:37:30, Eric Wong wrote:
> I'm not very familiar with the way some of this stuff works, but
> the patch below seems to fix clone for me.
>=20
> I originally tried changing the cmd_main->set_option code path,
> but value is always set to "true" for object-format because
> it only sees "option object-format" with no arg
>=20
> 		} else if (skip_prefix(buf.buf, "option ", &arg)) {
> 			char *value =3D strchr(arg, ' ');
> 			int result;
>=20
> 			if (value)
> 				*value++ =3D '\0';
> 			else
> 				value =3D "true";
>=20
> 			result =3D set_option(arg, value);
>=20
> So when set_option gets called, hash_algo_by_name isn't:
>=20
> 	} else if (!strcmp(name, "object-format")) {
> 		int algo;
> 		options.object_format =3D 1;
> 		if (strcmp(value, "true")) {
> 			/* XXX this branch is never taken: */
> 			algo =3D hash_algo_by_name(value);
> 			if (algo =3D=3D GIT_HASH_UNKNOWN)
> 				die("unknown object format '%s'", value);
> 			options.hash_algo =3D &hash_algos[algo];
> 		}
> 		return 0;
>=20
> So I'm not sure if the above is incomplete or dead code.
> Anyways, I arrived at the following and it works for me:
>=20
> -----------8<---------
> Subject: [PATCH] remote-curl: fix clone on sha256 repos
>=20
> The remote-https process needs to update it's own instance of
> `the_repository' when it sees an HTTP(S) remote is using sha256.
> Without this, parse_oid_hex() fails to handle sha256 OIDs when
> it's eventually called by parse_fetch().

This seems fine as a solution for now.  I tried to keep the transport
code mostly independent of the local repository settings, but in this
case because the HTTP walker mucks around with the internals of the
local pack files, I don't think we can avoid this without some major
restructuring, which I'm not interested in sitting down and writing this
evening.

I'll clean this up in a nicer way once I get interop working.  Thanks
for sending a patch for this.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--gMA7BT7LNdAtmKNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsM3gAKCRB8DEliiIei
gSXGAQC2hr3Rtty8/GcSP3ZBeQi3HrGJ7YhlRkfaa5oZbVGb4AD+NugIMIbVJyVm
cPXJxki8i7XwbG9xmxqZrW9sLbWn+AI=
=AVWt
-----END PGP SIGNATURE-----

--gMA7BT7LNdAtmKNE--
