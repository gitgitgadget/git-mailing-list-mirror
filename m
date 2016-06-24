Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CDC2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcFXSRN (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 14:17:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41226 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750997AbcFXSRN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 14:17:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8A01A2809F;
	Fri, 24 Jun 2016 18:17:10 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466792230;
	bh=aBpW3FXrEblB57dLgzKBG2VGhPWmBfOoS/WkFQr9GYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SltE6TQVPLmFivJsGzZvvz4Tm3jL2anp+PwsKyEIKeCl14y/GyG1qkglyoqshEkdd
	 aXZjszE7iaBVXA9t4LOElV6+TAV3vphwCHlsQZ1umnfRGRUpvGg3kbwDOdzUAKNPem
	 9SK+4FgqnOZqCtBeO6yoSY+goeiSJuPDArwk9sph2KnTYXNlla60t1hFSjQrvj/3ZC
	 ZklbsS93kYPgflrUfkpEkCBhiTDwhn9OsP4z08H8rALdzK+uCSqolG0n07F80VLQ9f
	 26tJEW58Ge3C3JYrP6CP1ziib+fMXRHqITLuDEzaSIy7HL5n21WBvmna8w5NDMCSbz
	 rTdtqybsGhu8fRsxwybiRLxc2wSYKx/MUDMa7mNLdi578EH1RyDCmMDNg4imjfQ+rv
	 9xtQVolm3vIZqT0eb+b08TzUwMtjOeB5tloPmICjNVuInwjgdvIfFmF0g8yWEfsQ7b
	 kCQsBqSBWMz4pzUE3dV5ePuwDhaBAuQtRWYceNqRhqlkdDbzdqG
Date:	Fri, 24 Jun 2016 18:17:06 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Leo Gaspard <leo@gaspard.io>
Cc:	git@vger.kernel.org
Subject: Re: Migrating away from SHA-1?
Message-ID: <20160624181705.GA7035@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Leo Gaspard <leo@gaspard.io>, git@vger.kernel.org
References: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-1-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2016 at 03:10:27AM +0100, Leo Gaspard wrote:
> First, sorry for not having this message threaded: I'm not subscribed to
> the list and haven't found a way to get a Message-Id from gmane.

Sorry it's taken so long to get back to this.  I've been at a
conference.

> So, my questions to the git team:
>  * Is there a consensus, that git should migrate away from SHA-1 before
> it gets a collision attack, because it would mean chosen-prefix
> collision isn't far away and people wouldn't have the time to upgrade?

I plan on adding support for a new hash as soon as that's possible, but
I don't have a firm timeline.  This is a volunteer effort in my own
limited free time.

>  * Is there a consensus, that Peter Anvin's amended transition plan is
> the way to go?

I'm not planning on changing algorithms in the middle of a repository.
This will only be available on new or imported repositories.

My current thinking on proposed algorithms is SHA3-256 or BLAKE2b-256.
The cryptanalysis on SHA-256 indicates that it may not be a great
long-term choice, and I expect people won't want to change algorithms
frequently.

If time becomes extremely urgent, we can always add support for a
160-bit hash first (e.g. BLAKE2b-160) and then finish the object_id
transition later as it becomes convenient.  I'd like to avoid that,
though.

>  * If the two conditions above are fulfilled, has work started on it
> yet? (I guess as Brian Carlson had started his work 9 weeks ago and he
> was speaking about working on it on the week-end he should have finished
> it now, so excluding this)

It takes a long time to get a patch series through.  I'm rather busy and
don't always have time to rebase and address issues during the week.

>  * If the two first conditions are fulfilled, is there anything I could
> do to help this transition? (including helping Brian if his work hasn't
> actually ended yet)

You're welcome to send patches if you like.  I try to avoid areas I know
are under heavy development, like the refs code.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXbXkhAAoJEL9TXYEfUvaLKpEP/0LWUUi0vQOHnQohUBZBysh7
jBz4UpnSl8QfCPADtDW9Ft8OCBp+kbvsq/pHgKUo0MiDQVxyF67ZF5+1YOlSaFuM
/jiQiDQPP6I/21YCpoLALuFMIAXQ2IG8sWa+B6sTrTeXVx/biUTeMPeJKjVVJVJu
jD2UGiV0OLvrKDxkmnwaHCq+dTWy6RHuRmUmV1wWB+iES/L/bzF3sprfKjIFFRp7
erWM0Wedv3VaAiYM+WC5zAx28lcoleNtibbuAnxAiGuibrLRzEr1tbA2/yiEcN0r
J/wQeLHXctg3r3lpNuthXZVTLlyQvEukho4lIJMecFMtNwQHrSClExsAtnb9fH2p
bUn8R2KRinKddDqhPRDeVAERPYbiSt5vLmwcwFVwPuqdDztXFq/YgRvSiOQehTDe
luHKSVIxhAniQ6S0Kk5WvsPADMQ68Vs9uwjks0IPE01Cfsz3lKCWxCnT6N1HR8Ck
3he1/41O7m2uX6wD6j4rPw/A/mZ8A5OSaqJXjTxXIywSB5RvmufdtsgDdr/fGPp0
HGG2epUVa+MOrbrjf3enPh+LjTaJWFT2roVzlLtv2qUel4TaLu8ROd11xhq+3Mx+
ldilAuvREibJ2GunfGwerlzNSv6etDB9JBhf3a0wMFk+Gs/TrT4eHR5s5o2Hv9iA
AIRIQM/DN+Ud0z4zOdoA
=/Yxk
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
