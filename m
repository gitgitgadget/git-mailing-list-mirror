Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0800EC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 21:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjD0VgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0VgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 17:36:04 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B0212C
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:36:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 443155A2B2;
        Thu, 27 Apr 2023 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682631362;
        bh=+jnhkB70wJ/Mhk2iAqcPP1oC30IBgP3PlDr6JDOxbas=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qiwtu4oDPBuEkOodBrI37rh+fkqfm2QKUz8zicIzvfTExeC03+C8gZ9ycfg5YaDpW
         mo0AtAT9yYe+/SNgUPXewhBXAdcS7ghQjVqngiyJaQIbbXlLsQJBarfQnuc17S3k4Z
         c5xzCRHfY0IcYJOQBqxhGBqv9SBHyI48Vljc1P4u35+oK+o2bnNJFPbHgpWaNRUBv/
         oYnf0MnfCJ78+8/Ow3/SQcyqvIIuCJSCD5WKw+kQvV+WR2sLEQrxiqLuoAPk46I/sw
         NNCJrV1XbHmpqZ3FU9+JrT+OL26ARb5+SCo1EkFHD35NBVQTIn2HVLkQ6mys/cuPxA
         S8lMEwAji4nA5NYfa7VTUwqAgvFppFVAbaSp+BrueB/IjDTxotbmCgorS0aEpE4O3F
         Gwg2sb/YdyH96DFx0fuWY0iFAG2evtkEQRAXBduITQkX7BW3TMI9f9t7nKv0aYDzRo
         AgdJ68eV6R4bPYZwfyXCUs3RFqYHoNfAVLhbof4M7YouyneS7n2
Date:   Thu, 27 Apr 2023 21:35:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
Message-ID: <ZErqvkCIkytTCvZr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
References: <20230427175007.902278-1-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSfcrtr+jmfrvVYh"
Content-Disposition: inline
In-Reply-To: <20230427175007.902278-1-calvinwan@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iSfcrtr+jmfrvVYh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-27 at 17:50:05, Calvin Wan wrote:
> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Unit tests additionally provide stability to the
> codebase and can simplify debugging through isolation. Turning parts of
> Git into libraries[1] gives us the ability to run unit tests on the
> libraries and to write unit tests in C. Writing unit tests in pure C,
> rather than with our current shell/test-tool helper setup, simplifies
> test setup, simplifies passing data around (no shell-isms required), and
> reduces testing runtime by not spawning a separate process for every
> test invocation.

I think this is a good idea.  Like Junio said downthread, we need to
have integration and end-to-end tests, and I think those will continue
to compose the majority of our tests.  However, having simple and easy
to use unit tests would be really valuable for testing things like our
hash and HMAC implementations, as well as a variety of other library
functions, including our strbuf code.

At work, I recently ported a project from C with no unit tests to Rust
with unit tests (and in both cases, our existing integration and
functional testsuite) and found that writing unit tests let us have
substantially more confidence in the correct functioning of our code.

I think it's great that we're using existing TAP functionality as well.

If you're looking for some proof-of-concept projects to illustrate why
this is useful in v1, might I suggest some of the subsystems above?
Assuming it lands, I plan on sending some tests for the percent-encoding
in the strbuf code and some more aggressive testing of our block SHA-256
and HMAC implementations if nobody gets to it before me.  (Mostly
because this is stuff I wrote or touched and would like to have more
confidence in.)
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--iSfcrtr+jmfrvVYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZErqvgAKCRB8DEliiIei
gSpWAP9BF0dzjYAhYImh92GNcxTBuUOy7l+31tQVduw3YnjVSgD9ElXj91BsXewF
0wHRzNGfp+eP7oQ27ChNOQIBvsgafQU=
=Unzk
-----END PGP SIGNATURE-----

--iSfcrtr+jmfrvVYh--
