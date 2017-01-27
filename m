Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC021FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 06:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbdA0GVw (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 01:21:52 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:57224 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753954AbdA0GVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 01:21:49 -0500
Received: from localhost (x55b3aa69.dyn.telefonica.de [85.179.170.105])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 0AA6016C87F;
        Fri, 27 Jan 2017 07:21:43 +0100 (CET)
Date:   Fri, 27 Jan 2017 07:21:42 +0100
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] urlmatch: allow globbing for the URL host part
Message-ID: <20170127062142.GA760@pks-pc>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
 <20170125095648.4116-5-patrick.steinhardt@elego.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20170125095648.4116-5-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 12:43:31PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <patrick.steinhardt@elego.de> writes:
>=20
> > The URL matching function computes for two URLs whether they match not.
> > The match is performed by splitting up the URL into different parts and
> > then doing an exact comparison with the to-be-matched URL.
> >
> > The main user of `urlmatch` is the configuration subsystem. It allows to
> > set certain configurations based on the URL which is being connected to
> > via keys like `http.<url>.*`. A common use case for this is to set
> > proxies for only some remotes which match the given URL. Unfortunately,
> > having exact matches for all parts of the URL can become quite tedious
> > in some setups. Imagine for example a corporate network where there are
> > dozens or even hundreds of subdomains, which would have to be configured
> > individually.
> >
> > This commit introduces the ability to use globbing in the host-part of
> > the URLs. A user can simply specify a `*` as part of the host name to
> > match all subdomains at this level. For example adding a configuration
> > key `http.https://*.example.com.proxy` will match all subdomains of
> > `https://example.com`.
>=20
> This is probably a useful improvement.
>=20
> Having said that, when I mentioned "glob", I meant to also support
> something like this:
>=20
> 	https://www[1-4].ibm.com/

The problem with additional extended syntax like proposed by you
is that we would indeed need an escaping mechanism here. '[]' are
already allowed inside the host part to enable IPv6 hosts of the
form 'https://[2001:0db8:]/', so the syntax is now ambiguous. So
we have to be cautios which characters to enable for globbing
syntax. As of now, I think we can only safely include '*' and '?'
here without escaping mechanisms.

If additional use cases come up we might still extend the syntax
later on to allow for more special syntax.

> And when people read "glob", that is what they expect.
>=20
> So calling this "the ability to use globbing" is misleading.
> The last paragraph in the log message above needs a bit of
> tweaking, perhaps like this:
>=20
> 	Allow users to write an asterisk '*' in place of any 'host'
> 	or 'subdomain' label as part of the host name.  For example,
> 	"http.https://*.example.com.proxy" sets "http.proxy" for all
> 	direct subdomains of "https://example.com",
> 	e.g. "https://foo.example.com", but not
> 	"https://foo.bar.example.com".
>=20
> Fortunately, your update to config.txt, which is facing the end
> users, does not misuse the word and instead is explicit that the
> only thing the matcher does is to match '*' to a single hierarchy.
> It is clear that even http://www*.ibm.com/ is not supported from
> the description, which is good.

I agree that globbing is the wrong word here. I'll swap in
"wildcard" where applicable.

I'll send a version 4 later on. Thanks again for your feedback
and improvements.

Regards
Patrick

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYiub2AAoJEBF8Z7aeq/EsQqcP/0mGIflcb/x8KIjAsiUIEwVV
4Nz1yJb0jU4TfyvZPXQ3evKfpn/xSACAJvRClOw/K8eyPqHDvCjA8ISSfgXt4sUE
c5GLHUB1CX1Ip3+Wpfyj+kDSoRn+9DJo/i48y6u5MViaw3nHQ8UQkgkwCAvu7cwM
leliC6ZmRyNPXXAmHwWVh7mCAr3OTsGWtJJezP4/r489pCAwGG3g3+zcdpNGsDcp
P7b1MTVKKXSHSkDDQFcL3i72VlSWtS5Y6wWT0cYSnaOJJzSv0Ma6iws7cOTDZKhs
SlUbY8BLcHomyL94JEWavHlG/d5QSkQj8qTyjMhzBRmGKXemzjcTD4e0z349R69B
NP2Pdlzrp4amBHHAVDaJZGXIeudGSjY7ZMtMtikBddoTrkmcye7Ho0vkhrHtL+rv
B2OPhdS0BumVydKt1Rf56+4QRxPIF9Y4Wrs+WgqQ6mZ7djmcK9BnL+cZa+y+7OWM
XHtsNORYvD9aERhvCEY8hn66LjpVK23HD4ZRXTi9JkwYQqbEqhlCITKHwLUV6ZYQ
Gqu8XlIWAoTYKb3pBZJI2w4s5/gtgnx67fUbztWZGqD/bfFXHJxlutXzd1Im4EES
qka5P0SlDkXxD0V1xD6/Hqm2LI5kLkJkvsL0h+cDy01vKfox7W+7VV2TVHc6euC5
k6TLcC3bVr8xPXhpj0/O
=24Kt
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
