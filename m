Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6EB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 00:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeA3AZs (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 19:25:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58502 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751417AbeA3AZr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Jan 2018 19:25:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8784609CB;
        Tue, 30 Jan 2018 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517271946;
        bh=lv4yfPAhPw8PBqoFSOxBRmPDSxHnuLJyfhGW7yhnvPI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=R3c19FvD2k9yD5c0YnTqXbFxK6YootrObiUUpr3rbjnYDROesz8XheiVswAVdP1ps
         7BUi8e6rHIB8VVe1D/sP1eyHmJ6ro+CjoLY/ddyhu6J7bP9nO5uhFokMOunR8t7jCJ
         i7sc2wPEJml41wxl2GWsULmO+pyCBwpwHHoSw8kajLXEMOSP66IigCRkHZHnUQoIAi
         9opnJAofE2qnieEaYeMUxf4YY+1KZL6MS8O7U8pviYnxpZZipQMqduAiYWl5wESxuW
         ZAcWiPhdeEiTbmhYrGdgFR4g78Ier0k6g5OE2sAu+x5UfY1rG6z1Ev8ZnaENbo7ITT
         8wbMkolYWDspzaltNCeGsu6IwztO5h2XciYYEN1Pn7hgQE9hNQNdwd83TVxR9JiTo/
         e9b0y1bHRmUcOu0GPvAKK51ln9mTvZHbgy6hnaRiOdUYJyxybk3ifrhFCcct/81CoJ
         T0HNDSSlXUQe54RkLXIda3z5d0D8CXRXf47fX1FagBIUBhSO79x
Date:   Tue, 30 Jan 2018 00:25:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: t9128 failing randomly with svn 1.9?
Message-ID: <20180130002539.GO431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
 <20180129025812.GD1427@zaya.teonanacatl.net>
 <20180129120627.al2xvx4yhhvwn6ih@untitled>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
Content-Disposition: inline
In-Reply-To: <20180129120627.al2xvx4yhhvwn6ih@untitled>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:06:27PM +0000, Eric Wong wrote:
> Todd Zullinger <tmz@pobox.com> wrote:
> diff --git a/git-svn.perl b/git-svn.perl
> index 76a75d0b3d..2ba14269bb 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1200,6 +1200,11 @@ sub cmd_branch {
>  	$ctx->copy($src, $rev, $dst)
>  		unless $_dry_run;
> =20
> +	# Release resources held by ctx before creating another SVN::Ra
> +	# so destruction is orderly.  This seems necessary Subversion 1.9.5
> +	# to avoid segfaults.
> +	$ctx =3D undef;
> +

This may be the right thing to do.  I've seen a decent number of cases
in Perl where global destruction randomly causes segfaults.

>  	$gs->fetch_all;
>  }
> =20
>=20
> I'll be looping t9128, t9141 and t9167 with that for a few
> hours or day.  Will report back sooner if it fails.
> I'm on an ancient 32-bit system, I guess you guys encountered
> it on 64-bit machines?

Yes, both systems are 64-bit Debian systems, one stable, and the other
unstable.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpvu4MACgkQv1NdgR9S
9os9dA/+N19rJHZMVwgiFDX1a5wTU20Ah0S54d2akKIvdJ/492cYUHaomwF4/ZUf
RZvPIikfIwovHIZ1QEfqz98KCOCoge/njjnydiLY36KpY1zMOdLon3XoBQIveOfv
tLxxgch/6gLQrjFuH1lO91F1uqpDJ4jEagTQsimq7vIpSS5HDVnjlivC3kXBy9ta
JVE4lZtN1oGXsGSFZ0ZreqjmoEyPsSslz1TXHbg6N5y0aXJFxmmu99rVVPlL93dd
MUeHvQO9BF4RAF1aXkpXChf6rNcdRBfAGqtYt/QzyzGcboFXGPODsZMbj1WkORfY
nZN6s5VcK68nQ7I9LTQiSDzpAFArtURDTPqPWWUbSa8BUqWigDkTVKjuW6EDyIYa
yU+BBrqNZc1B4qaF9QB/IIDewfidBHoPdP4SUgqJo9f0xoZU6uvIazP2Js+oRPs7
+bqKSN5SIlMc6vLSHz1xVgRemQqQH1ntcYCX4GkO0DGunmCyqwFP+k1lz+HtHFyr
HN7JtAQzmEUXY4gams4/mXcfmrjpvyvP862027bxd0l31NVqJD8FZVDDjsr2liLn
y1wybDeGTfjMXA6+RdG+CaAQ5RDpTGFlkWGtVS2aam1GIH5JnS75/WsfpAtsamVQ
v2AtBeYiuwiOrx36xFu66IyJGt5WqZmWc5mTE1IyUxuK+q27YHU=
=bjEy
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
