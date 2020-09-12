Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB6C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FE321D40
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgILTxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 15:53:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58422 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgILTxD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Sep 2020 15:53:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CD6DE60489;
        Sat, 12 Sep 2020 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599940382;
        bh=/qqQD0HwNz23o45Sgiq+8AqE9Bzg9x7MDFAmZ61f6y8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BftDiK9TMrJnMiv4REAttQgqflb1Sgc9eOwGp3yAlcY5cum5M70L4Jp9zFDaPFdUb
         Yx6biOtrBbbWn7HjuZUO2A4SP9RIzgbQSxf1ejifFS8FJyPZ4+MSFQiUzeFWFfCOk+
         CAOIsUA7ihHna3WfNrhllnqvxoOybbI/AHAct+jueH0L3zBud1sXb2/ZErYpha7sGR
         47t/rWRnZKtYfMotbOC5uWDznKP0INa0EKCxwmDgxPrQjgiRSzkPTe9nex+lJFWLz8
         NiMkOaFP2TIHmG8hHtjxEbsAaddTAG9QVK4AZYYv5p8O5YWG0caZVQbteMJpMvWtlP
         th/+CcbHI3CAUTosAMudY/HFf29Gfw6Fm6OtKkItoD3gGD1mHMtMCTj21gL4fYOj4Y
         0yElckkRlpewXrihLn/jutYqsfhM122H5qh8JK/Orkfol6iCJr4sZ6oLccjkd+CD71
         Lqs/OVoOmDS+H4FNeFImHq4DnQAkeCDkjS41HZ3KIVmZxCr14s8
Date:   Sat, 12 Sep 2020 19:52:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Message-ID: <20200912195256.GN241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
 <20200911233815.2808426-1-sandals@crustytoothpaste.net>
 <20200912032448.GB1988@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aSnC4ZPPfhCvD8sN"
Content-Disposition: inline
In-Reply-To: <20200912032448.GB1988@nand.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aSnC4ZPPfhCvD8sN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-12 at 03:24:48, Taylor Blau wrote:
> On Fri, Sep 11, 2020 at 11:38:15PM +0000, brian m. carlson wrote:
> > -void initialize_repository_version(int hash_algo);
> > +void initialize_repository_version(int hash_algo, int reinit);
>=20
> I'm not a huge fan of adding a 'reinit' parameter to a function that
> itself begins with the word 'initialize' (why wouldn't you call
> 'reinitialize_repository_version()' instead?), but seeing as there are
> only a couple of callers, maybe it is OK.
>=20
> Alternatively, I certainly wouldn't complain if you did introduce a new
> function and updated the call-site that passes reinit as 1.

I thought about introducing a new function, but since it would share
almost all of the code, it seemed a bit wasteful, even if the function
is small.  We do have only two callers, I believe, since I recall
making this function non-static and calling it from clone, so I think
it's okay.

> > +test_expect_success 'clone with GIT_DEFAULT_HASH' '
> > +	(
> > +		sane_unset GIT_DEFAULT_HASH &&
> > +		git init test
> > +	) &&
> > +	test_commit -C test foo &&
> > +	git clone test test-clone &&
> > +	git -C test-clone status
> > +'
> > +
>=20
> This test looks very reasonable, and certainly demonstrates the bug and
> fix. Thanks.

This is essentially Matheus's testcase.  I considered using env -u to
avoid the subshell but POSIX doesn't specify that, so we have a
subshell.
--=20
brian m. carlson: Houston, Texas, US

--aSnC4ZPPfhCvD8sN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX10nGAAKCRB8DEliiIei
gaMkAP9tYVChxAnWvoEfDVZX6FtTK+fAhV+lTU6Dwt1bbXhqYwD+KEv07RCwwqzu
mvLb7rIV6MjjKFHKy/iSlIqi7x0U4wE=
=CDLR
-----END PGP SIGNATURE-----

--aSnC4ZPPfhCvD8sN--
