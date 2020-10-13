Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F68C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 23:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48BF21582
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgJMXpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 19:45:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49418 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgJMXpL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Oct 2020 19:45:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0EAF6042C;
        Tue, 13 Oct 2020 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602632710;
        bh=0S45ld3NXSnw2D/Fhyfj4ulPJkEpA5Jly04i7ZylzJQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mldNv52XROeIAFqqkeYy2jm3ENPYWZi9baanv5sYiaYMjj9MDTg7rs/R1ZPU7U4sD
         gMBTLXnWK30VEL0mwnsjW5eIbjmbC/8+73HRwgD0/xSPmcTngETRkq+jFZEy6dMFX8
         6b0ZTsS5gIKRXVdNsNOP0tlGs4BUbNHE3y5AOuZr7A3rWB6tsPys/hu+JropJC7fVv
         ghg2Snc+uHDh8r6HtqzhlFJ11Y6HOHMfJS3od8gqkOe4hpMUJkr6Iac9/LtDaTqLQq
         CY9QIqm28QwbAMrzQtw9GQDwYbhdcd+qxVMHWmkQZL2MPwNZosd+rVfatyBVvbLlki
         lEyCXpDrA08IeV2vaAYXGZezKaJaWSrRATZ8QQAcFPp8NoSxvQnkBPakc96q/oIp4I
         vl4n4zzqApTU775EfRMVu31T9LjeYhtz9YuD87l+Re5enczbwTQRr2RksKYxWUSSNh
         qFV3X/RfMofzCbmn3pLJxwoyRzcGt2XoaxIjlv0Au0CiV1byTQY
Date:   Tue, 13 Oct 2020 23:45:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        gitster@pobox.com, masayasuzuki@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201013234502.GB490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Sean McAllister <smcallis@google.com>,
        git@vger.kernel.org, gitster@pobox.com, masayasuzuki@google.com,
        jrnieder@gmail.com
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20201013211453.GB3678071@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-13 at 21:14:53, Jeff King wrote:
> On Tue, Oct 13, 2020 at 01:17:29PM -0600, Sean McAllister wrote:
> >  static int http_request(const char *url,
> >  			void *result, int target,
> >  			const struct http_get_options *options)
> >  {
>=20
> It looks like you trigger retries only from this function. But this
> doesn't cover all http requests that Git makes. That might be sufficient
> for your purposes (I think it would catch all of the initial contact),
> but it might not (it probably doesn't cover subsequent POSTs for fetch
> negotiation nor pack push; likewise I'm not sure if it covers much of
> anything after v2 stateless-connect is established).

Yeah, I was about to mention the same thing.  It looks like we cover
only a subset of requests.  Moreover, I think this feature is going to
practically fail in some cases and we need to either document that
clearly or abandon this effort.

In remote-curl.c, we have post_rpc, which does a POST request to upload
data for a push.  However, if the data is larger than the buffer, we
stream it using chunked transfer-encoding.  Because we're reading from a
pipe, that data cannot be retried: the pack-objects stream will have
ended.

That's why we have code to force Expect: 100-continue for Kerberos
(Negotiate): it can require a 401 response from the server with valid
data in order to send a valid Authorization header, and without the 100
Continue response, we'd have uploaded all the data just to get the 401
response, leading to a failed push.

The only possible alternative to this is to increase the buffer size
(http.postBuffer) and I definitely don't want to encourage people to do
that.  People already get the mistaken idea that that's a magic salve
for all push problems and end up needlessly allocating gigabytes of
memory every time they push.  Encouraging people to waste memory because
the server might experience a problem puts the costs of unreliability on
the users instead of on the server operators where it belongs.

So the only sane thing to do here is to make this operation work only
for fetch requests, since they are the only thing that can be safely
retried in the general case without consuming excessive resources.  As a
result, we may want to add appropriate tests for the push case that we
don't retry those requests.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4Y7/QAKCRB8DEliiIei
gRGZAQD+9dp6DbzxodL5VtGrmdErmb2Ay0vbu/hEvIdUJxYhogD/UfI4smjOELRD
ovIs1TfIBU3m7JVI0QOZDNXiJTbRBwI=
=3JIh
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
