Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C8ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ1Vqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJ1VqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:46:25 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B622C838
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:46:23 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7373C5A1FB;
        Fri, 28 Oct 2022 21:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1666993582;
        bh=axA/JZk11XHktHjfVFwlvH6Ibbl4pkGGsLg7iP2Nu6k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sdSW1X8V2qvYxvtsQcJQtfLYD40bP9kwRc31RXPDcBgUrTEj1pw1qOtRdbX60x26M
         5eBNZDkKI9ULhMQOlvPLrxSGdxTReoJQ68dWLaiYnArq4OL5FL/uUp9cJ68WBbWyWM
         +wqnK5jwzNsJjB7CIrQJvqmVdekCVF4JAly8WF4eLS8prZ/1LBgl4+BNATYaFyZSSC
         kW3VrZ+wPr9Y8uPSVlcS79EEeXdEKyCDJ41YIVC3/fPeGQn/X6sBVPpZsxSgUgYCUo
         Qk0YsnF5TmazzBv4c0utwBosKrlKUs/YNtCnZLIqWY/R4iBZqd6uxOWG0BSzS32Iy1
         MUoMRYJhE6sVDcy79l/+0t9bQW0V97ePrf4r/+9X6GL4ltgFfh4h6gZhBGkG5P+Rp+
         0JZKeS/U9dTH5LyYvB/aAZ06yzeGB9xTlWc11l+hVFkINliOoNZYLZUKcdoxwL4LFJ
         ld4CMYRQMhPaky2StP2GqH6zNZfSPP2M90swJmMy7gWqe0nfNOP
Date:   Fri, 28 Oct 2022 21:46:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Julien Moutinho <julm+git@sourcephile.fr>
Subject: Re: [PATCH] adjust_shared_perm(): leave g+s alone when the group
 does not matter
Message-ID: <Y1xNrDB10XEcAa0d@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Julien Moutinho <julm+git@sourcephile.fr>
References: <xmqqr0yrhco6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pYxTs3EChqEbmMCI"
Content-Disposition: inline
In-Reply-To: <xmqqr0yrhco6.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pYxTs3EChqEbmMCI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-28 at 21:16:09, Junio C Hamano wrote:
> Julien Moutinho reports that in an environment where directory does
> not have BSD group semantics and requires g+s (aka FORCE_DIR_SET_GID)
> but the system cripples chmod() to forbid g+s, adjust_shared_perm()

I would personally use a different verb here because I have the
impression it's offensive, at least when used as a noun.  Perhaps
"limit" or "restrict" might be more neutral, or we could pick another
verb which expresses our displeasure at this design (maybe "impair"?)
but maybe is less likely to be emotionally charged or offend.

> fails even when the repository is for private use with perm =3D 0600.
>=20
> When we grant extra access based on group membership (i.e. the
> directory has either g+r or g+w bit set), which group the directory
> and its contents are owned by matters.  But otherwise (e.g. perm is
> set to 0600, in Julien's case), flipping g+s bit is not necessary.

Except for my comment above, I think the patch here addresses the
proposed issue and looks good, and as usual, is well explained.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--pYxTs3EChqEbmMCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY1xNrAAKCRB8DEliiIei
gfFSAP9pqscjFT3YKWf5BjmgMXhx8pZIQVO47OnUVMkyK53TugD/cX8dKvZnXzHm
PvZVdnCZ1iUMwA9yuJ4HT5Q7t0ViNQc=
=WB2Z
-----END PGP SIGNATURE-----

--pYxTs3EChqEbmMCI--
