Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67635C433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 22:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D2920776
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgJKW66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 18:58:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgJKW66 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Oct 2020 18:58:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBE746044F;
        Sun, 11 Oct 2020 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602457137;
        bh=pizv5jhmOyOqcFZaRNawRJN8Oru9GtWKp0ShCmlJQoo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DpmsznlZ5s2sgUwQKmIymq2LFiEfeVEL+0lLWlcihPxjBB9Jz074lPpmFre/NJ3KQ
         rtg9ruu1wSP8Eshcnih7YW/4AusBiN7wopu5NmDhWrmLCgKIqBENOCE/+4Mhjz7LmP
         F6attO03kHoP+Q7+ypQqvyBvR0/YJGFMaw9NA+iw3Rg+RYmvbNrDC0Wq2r+Z27V85G
         3F5JDSQ4a8RbT3yCmEfDXWyEpRvRNT5xxnwGsBaGbdeSqXeE5hmKOJRONsJ+ia2hPO
         Fzc0th+6PfPWQ4/cTO4BuQZO25FCULhr/Dur7BOQdGQOHPIfpqN9DhldNXu58EZs0w
         qqZ+n8grhWWmojIetvx9LsLCD9KkDjx1tcMzgiQ3Xofv9I/CrHG0dzXohpARb24ydf
         CetV6xmeG+LRhokgSlq5qcGOe9f1/9JwLf14DGiRtj/uu/4B7AwL6EM3hVYBSRy8DW
         APWV+8CG9OMwAppYzUWKkuoBELr9UJgrScrXXI/BKWoNlfuaw40
Date:   Sun, 11 Oct 2020 22:58:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
Message-ID: <20201011225850.GA490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20201011224804.722607-1-samuel@cavoj.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20201011224804.722607-1-samuel@cavoj.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-11 at 22:48:04, Samuel =C4=8Cavoj wrote:
> When performing octopus merges with interactive rebase with gpgsign
> enabled (either using rebase -S or config commit.gpgsign), the operation
> would fail on the merge. Instead of "-S%s" with the key id substituted,
> only the bare key id would get passed to the underlying merge command,
> which tried to interpret it as a ref.
>=20
> Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> ---
> It is unclear to me whether I should have based this off of maint or
> master, master made more sense to me. I apologize if maint was the
> correct one, please tell and I will resubmit.
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..88ccff4838 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>  		strvec_push(&cmd.args, "-F");
>  		strvec_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
> -			strvec_push(&cmd.args, opts->gpg_sign);
> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);

Yeah, this seems obviously correct, and it's very similar to what we do
elsewhere in the file.  This will also handle the case where the option
is empty (because we want to do autodetection of the key to sign)
correctly as well.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4OOKgAKCRB8DEliiIei
gY0+APsGWg50M54TW/tcq6L402gLsmEZK7LdlU0aiB3UtO/e/QEAxZegiuiKUubB
SbZHQg+/Y9esjjIyzwZJQwuUfqOm7QI=
=w+ZL
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
