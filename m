Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9674C1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 00:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKAJsu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 05:48:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52896 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbeKAJsu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Nov 2018 05:48:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:293f:cdba:df65:a13e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CEE9261B73;
        Thu,  1 Nov 2018 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541033289;
        bh=zTu2HJEXbslzKuRJ3NMdlp/OhoJ6IN41IPd9v66yzoE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x5Wq5ibWlHAJQsG07+OIsseVQsYtliWakQ1tv6vVwM4O3HfzDiaMcwJ2AUER+GAtj
         WQeDOcZBXWJVIKPhrryIp5vjFbV0e1ovI0qQ31SSfFANVeq+dHMSJNKTd835njFbRt
         0AO045YF3hLT88D8/iuel7quO1Sdl8ec96Qb4kGzXsgC6/JUe2E6xgTNYAdaJ1czig
         hHRw4HwfVSrb2NT5bEjIrtC+NhKYPwuBujLqzO4KEucxnel9FG0xjNznWUy/qt3HBs
         6J1bBi+DqLqW3N5NePvAxWqS6q04HCaYH9MbVRTJDt1W+nBMUYvSzJsuP8pAIEhcJN
         7qOvlG/wX8cuMGCndCF9SAGBvo2mxtmU4QUt6bNaaNsF91049AI4oaCzopH/E2MDk/
         9ogXIQINzAvI1jb570ToNZHzvlsqEV3Y/FZC6E+OV5ugVzpA4/Ci492eznGUiEFOMg
         tlIfEeZhFqP7FBHSpBUQGJuGsgWF0oXFJKNG5bMvGHAhLaVaUFy
Date:   Thu, 1 Nov 2018 00:48:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jon Simons <jon@jonsimons.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [BUG?] protocol.version=2 sends HTTP "Expect" headers
Message-ID: <20181101004803.GA731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jon Simons <jon@jonsimons.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20181031160353.GA17267@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20181031160353.GA17267@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 12:03:53PM -0400, Jeff King wrote:
> Since 959dfcf42f (smart-http: Really never use Expect: 100-continue,
> 2011-03-14), we try to avoid sending "Expect" headers, since some
> proxies apparently don't handle them well. There we have to explicitly
> tell curl not to use them.
>=20
> The exception is large requests with GSSAPI, as explained in c80d96ca0c
> (remote-curl: fix large pushes with GSSAPI, 2013-10-31).
>=20
> However, Jon Simons noticed that when using protocol.version=3D2, we've
> started sending Expect headers again. That's because rather than going
> through post_rpc(), we push the stateless data through a proxy_state
> struct. And in proxy_state_init(), when we set up the headers, we do not
> disable curl's Expect handling.
>=20
> So a few questions:
>=20
>   - is this a bug or not? I.e., do we still need to care about proxies
>     that can't handle Expect? The original commit was from 2011. Maybe
>     things are better now. Or maybe that's blind optimism.
>=20
>     Nobody has complained yet, but that's probably just because v2 isn't
>     widely deployed yet.

HTTP/1.1 requires support for 100 Continue on the server side and in
proxies (it is mandatory to implement).  The original commit disabling
it (959dfcf42f ("smart-http: Really never use Expect: 100-continue",
2011-03-14)), describes proxies as the reason for disabling it.

It's my understanding that all major proxies (including, as of version
3.2, Squid) support HTTP/1.1 at this point.  Moreover, Kerberos is more
likely to be used in enterprises, where proxies (especially poorly
behaved and outright broken proxies) are more common.  We haven't seen
any complaints about Kerberos support in a long time.  This leads me to
believe that things generally work[0].

Finally, modern versions of libcurl also have a timeout after which they
assume that the server is not going to respond and just send the request
body anyways.  This makes the issue mostly moot.

>   - alternatively, should we just leave it on for v2, and provide a
>     config switch to disable it if you have a crappy proxy? I don't know
>     how widespread the problem is, but I can imagine that the issue is
>     subtle enough that most users wouldn't even know.

For the reasons I mentioned above, I'd leave it on for now.  Between
libcurl and better proxy support, I think this issue is mostly solved.
If we need to fix it in the future, we can, and people can fall back to
older protocols via config in the interim.

[0] In some environments, people use SSH because the proxy breaks
everything that looks like HTTP, but that's beyond the scope of this
discussion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvaTUMACgkQv1NdgR9S
9os6ig//eWWgWvhUXmTnYsMh3V8bVHecgoOE1sZRQgp2Fqb6tBFiwGeqCaPWL0Ih
BNzKAd9/c3FRDHZppO9DseqlEo63dejF3YaJuEVtWh4zVZix/QTDw7dmKTomon9P
07TMuLj+MSCLU0u4rMxsgNNG5CTLgUvcQyjrmK8+K7y8QSy7QK4s5njZHVnMzDFx
Iitfo6oUIc3oMV7IqQqoD8VW3x31rpiu/x17RSUeArD9y73QKSY7oh0iwUgSlLNy
d0ci2Ld/Z5vIpaoSIkYnU/EBwWwh5JjEgEm6/3YUyfOo8ovkSOjTFz6msy2p/jfA
rLmbzuLvfISFUu305jShg02ALWtob2cSAGqNzskYWSavmNGknCiddAfwDywHptz0
HHP6X9jCxHZg6YDv/Ot/Aepn83xUYaE4iKhNB0E+VUN2FUZ3cIvM6K7i92s1mb7B
rznLsjyzwEu2ILY5uNJkIis/hlBhb1t6yuh5h9ZinwF8Mq6gySS6IwVk+QGl9v6Z
93rZFf2hRb53eLKkrCrvWsjazXiAXlYgWDkVM2LD0v2JjXHCY6HXWqUgIzxlhNW5
u2KyjVwknxHOIB40GZla2LTxN4m7Y5vVks6IGhATlm2zL4IoGHRapFe7CQbQTnTd
VjQKo2+mxwaxQuYRb95c1cbZg6ZYzReXbP+xrr1bXTwcxz1/dO0=
=/vMP
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
