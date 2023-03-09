Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F53C6FD1C
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCIW17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjCIW1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:27:55 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE344B7
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:27:54 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8F5765A45F;
        Thu,  9 Mar 2023 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1678400873;
        bh=5l5ZmMKkDEbOZMEFNxIQqRjYFjDTMV5s/PtQPyJsSLU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fqZ1jTxmEDac9Q6b9J7nZGD17V5L0VffPSMfo0nS9QxxHbiaszNFI8PGe1NebpS1Q
         adV7CyMU00zVY2c6iqt9hmf0bZBZGCVer3Q4mR+BJP42Mx/Tizc6hG3rbhvkd9SDx4
         opNL0vVhVU3NgUUQBzckiS+ICmIwJPoqhVQFtFMsQ5eKjW4M+dic7TiOIq+1Iq9M79
         q5puEXG/Ns9x+9//ZPNyHELR3reMrgAiDuC8mqY/HyhMp/I34GBznWKE5dhUUy4Pmg
         PmoYKtRH8cQnnRnXjHfW2XIsuLsm8uiOk8HeqaOd+A+Crf6Lvsr/MC1RnOL0F6HHC/
         ZgLDFPk4OawZr2fwmEDvHKKFqvwQGIbWpjWvYzMtoT1JOm/C7e6D34FwB/z0DrhAvT
         cx6Q3Ag5MNY6wYdCZghNS22LHdnVteIIM8LbfW58U/N4bCGaHJjb10ts0pCvIC/Vgy
         o013ano5q6YqcJi/fp/LOFg8XhQuStuIJijUy8qWzGQS3BOF841
Date:   Thu, 9 Mar 2023 22:27:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emir SARI <emir_sari@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request - Better i18n support
Message-ID: <ZApdaAMrkmFcxarq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emir SARI <emir_sari@icloud.com>, git@vger.kernel.org
References: <ZAnXddDN7v0AOBdm@mbp.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wYc3Y6VID5L8pZyn"
Content-Disposition: inline
In-Reply-To: <ZAnXddDN7v0AOBdm@mbp.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wYc3Y6VID5L8pZyn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-09 at 12:56:21, Emir SARI wrote:
> Greetings,

Hey,

> Git is translated into many languages, but as far as I can see, it does n=
ot
> take localisation formats into account nor it allows them to be translated
> into localised formats.

Thanks for the report.

> For instance, in Turkish (and in French AFAIK), percentages are indicated
> in different formats. In Turkish it precedes the number like %54. However,
> all the percentages use the standard 54%. By marking these as translatabl=
e,
> we could easily provide the correct formats.

I think this should be relatively easy to do.  I didn't know Turkish did
this (and I suspect nobody else did or we'd have fixed it), but I
haven't personally seen this in French (which doesn't mean that it isn't
done in some places).  We've already done human-readable byte values,
which do vary in French (due to it using o, for octet, instead of B), so
I don't see any reason why this couldn't be fixed.

More specifically, I think it could be fixed for progress output, but
there are a few places in diff output where it couldn't because it might
be parsed.  Would you be willing to try a patch for this?  I think the
code you're probably thinking about is in progress.c (search for "%%"),
but there might be other places you have in mind as well.

> Another thing is the decimal signs. In many languages, a comma (,) is use=
d to
> indicate decimals, however Git does not allow another formats. I am not s=
ure
> how to achieve this in C, but it would be great to have this in order to =
have
> an errorless professional look in Git outputs.

Can you clarify what places you're thinking about?  Is this printing
decimal values, or is it parsing decimal values?  If we know what
specifically is affected (for example, an affected command or message),
it's a lot easier to fix this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wYc3Y6VID5L8pZyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZApdaAAKCRB8DEliiIei
gQPYAP9ZbGLsWwEDQD9Kw+zE47ApQpxKVr2+7h9UMLK7M5m/sAD8Cd8cu4TdDgpF
sHz9S8nIQwYGyeq4UvR+vypX6ppbUgA=
=zSQY
-----END PGP SIGNATURE-----

--wYc3Y6VID5L8pZyn--
