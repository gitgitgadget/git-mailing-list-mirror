Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF8C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C70208FE
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 06:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gOdA1z+l";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPnovBqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKFGhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 01:37:01 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54535 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgKFGhA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Nov 2020 01:37:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EB28B1446;
        Fri,  6 Nov 2020 01:36:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 06 Nov 2020 01:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=d8JwrJpmCJDAYXvxWSTGHvi0tCg
        lYBtY8F2Zl92lfnM=; b=gOdA1z+lNMpG0ZnoXR4OG0KGYxLyoJgQb8mwT3/t5o4
        Zt9/Q/uqD7hY+1sqrNKRpepFa3wdGxGZd8SEk/xZEaxseIABff67ZCb40QKSg02x
        wSdObdDG2I9pHLgM2++sUCabzz8g4O6sJmaRZGh9Oh1NUDml+hJmd8p9VCnE9JPn
        Ywo56j0CvbUKWPVCFfVPSH/mQ+dgfqxlmwgG/XBJ3lzdPycLPO5snNMkBFtIiTZu
        BPl1NwIiZmQf8Siazx9CUut/OJVt8DwxiNYI24TN5encNeDhE69t2LgzC155SbYn
        MzTDw0uZXQZhUPNLH29EZqSzMJxOJtbpeC12RMF3XJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=d8JwrJ
        pmCJDAYXvxWSTGHvi0tCglYBtY8F2Zl92lfnM=; b=pPnovBqcK/H2urHr8dulGw
        cLPscBdta0SD91LBcduqwpR9w0SGzacCXBsRZ49rnbM7FDnq9zc0hGYPPjeQXfBi
        sK5RBQOa1VfheEU96OlHWRokJpG9nivOiSmQYKC3GUB7MSjWD8rZv7dBRGSps0Wy
        x8+bAikiM10syMtP4yu7F3h2Ro4DcPrSmyQanxncn1IVZwil8+WJMPESAMlj2wDn
        5b6dLY3iqUuAFEtlUVgYb9JNjDKXGAxC5Fn8lDOCxZNKytGm7EkOVd+qJw5UvS9O
        mVg9A2ocxSTBDP/7rC2gUkh67q0wOGc1JUu/jknFRPdKM9ysnv/e3FN8QGpxadhQ
        ==
X-ME-Sender: <xms:C--kX3U6V5iYPT165KOJppe1Uqw9ix6pIkOV3rVJrIGKvaoUNhYHWA>
    <xme:C--kX_kde929ZArgekk6-UdAOMA9bIoqAZ8M-NAi5HJ3lBHohkyC8aTd4zCEgG297
    GjRTlPalH9Rck933w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrdduuddrgeeirdduleefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:C--kXzbRRXHQA1RIdAuWZ7ekitQs8RGQhdu46IRrQJ4czL0huOAAkQ>
    <xmx:C--kXyUEXOvdXtZbng49am94YXSawrgztbw6nTFVDlHYDphYeV9BkA>
    <xmx:C--kXxnGRgYHoc7QGIzJh_5FwYG1yUijo3Y-dNz2D-QNSAJqrz12AQ>
    <xmx:C--kX_S2PXDhzuQ9dUVKwfxBkkVuW_gySC03g20GehAFRAMjGb1ntA>
Received: from vm-mail.pks.im (dynamic-077-011-046-193.77.11.pool.telefonica.de [77.11.46.193])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8C85306005E;
        Fri,  6 Nov 2020 01:36:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5c78bbce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Nov 2020 06:36:54 +0000 (UTC)
Date:   Fri, 6 Nov 2020 07:36:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] update-ref: Allow creation of multiple transactions
Message-ID: <20201106063653.GA3692@ncase>
References: <cover.1604501265.git.ps@pks.im>
 <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
 <20201105192901.GA121650@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20201105192901.GA121650@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 02:29:01PM -0500, Jeff King wrote:
> On Wed, Nov 04, 2020 at 03:57:17PM +0100, Patrick Steinhardt wrote:
>=20
> > While git-update-ref has recently grown commands which allow interactive
> > control of transactions in e48cf33b61 (update-ref: implement interactive
> > transaction handling, 2020-04-02), it is not yet possible to create
> > multiple transactions in a single session. To do so, one currently still
> > needs to invoke the executable multiple times.
> >=20
> > This commit addresses this shortcoming by allowing the "start" command
> > to create a new transaction if the current transaction has already been
> > either committed or aborted.
>=20
> Thanks for working on this. The amount of change needed is indeed quite
> pleasant.
>=20
> > diff --git a/Documentation/git-update-ref.txt b/Documentation/git-updat=
e-ref.txt
> > index d401234b03..48b6683071 100644
> > --- a/Documentation/git-update-ref.txt
> > +++ b/Documentation/git-update-ref.txt
> > @@ -125,7 +125,8 @@ option::
> >  start::
> >  	Start a transaction. In contrast to a non-transactional session, a
> >  	transaction will automatically abort if the session ends without an
> > -	explicit commit.
> > +	explicit commit. This command may create a new empty transaction when
> > +	the current one has been committed or aborted already.
>=20
> Reading this made me wonder what would happen if we send a "start" when
> the current one _hasn't_ been committed or aborted. I.e., what does:
>=20
>   git update-ref --stdin <<EOF
>   start
>   create refs/heads/foo ...
>   start
>   commit
>   EOF
>=20
> do? It turns out that the second start is ignored totally (and the
> commit does indeed update foo). I wonder if we ought to complain about
> it. But that is completely orthogonal to your patch. The behavior is the
> same before and after.

Agreed, that's a case where we should raise an error. Doing nothing
without any indication is a bad way of handling it.

Patrick

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+k7wQACgkQVbJhu7ck
PpQa7g/8CLAwcYLoiKiTFexPtQiyHTB9OxgP6wgnBFexi8ucQmMixMtfncIE/me0
ZVCA18tiDsclL3mL7rOdO0YhkiJ3HR6aM/2+V5g+PvHXQDJPnRgrFeqPg/WGJK5+
xkDXUAfG8nOsybu1YAI0zsfUCFiLjrSXeZTklRFs1N9NlMCfc5jgl2YeIwvqHm0/
ZPJOQv2Tle7k90e+uKTU3T8kX7tYg4hwrem3tujiPrWyl43ucqbXofG/25tPwTlz
aKik3UHlmfTj565wZvntUIlUTlx/z7YbrcidTB4kdGgm9LjUJrE9+vYP7ZTC7C7k
e8eWLUZmV98B40ROC8ljR1fm7ww2mpLzPfFpVg/9GMXB6cBgvISwQTODS7NO9vLW
VXXoNycd81PMfGpHyAJDD8hSHUUlII+aOKZbJpv3YHymRegbEQENNb7Wd1Q9tz8i
sWmnAnbAsLKbD4Z7cVc2n/0IyZo+KT1eQXYq1eha6LdxM2ADqNruh8C6rmdLeWlB
URtcFC+WH+W84RD8Lz5F/h1/OZikwNziiJ4YWX1VEoPkwZ3BiiwQbkGwF6oNxDhe
w0f1bWuyqKA2+KMjWHnI5aXwMVjK/qzbZg6/lyxqpzoW4jDv+LV5L6TMo2EbFCRC
SjDNYFlD2Ez29LToxRXLXmQfTcX0wac9GzkcAmqKUgjbhEcZsPg=
=XsjF
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
