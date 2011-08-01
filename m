From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 20:28:45 +0200
Message-ID: <20110801182845.GA4303@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:29:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxEd-0002Li-Ov
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1HAS3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:29:00 -0400
Received: from seamus.madduck.net ([213.203.238.82]:38758 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HAS26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:28:58 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 05F3C407D24;
	Mon,  1 Aug 2011 20:28:46 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id D4C401FE00; Mon,  1 Aug 2011 20:28:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110801182015.GA3100@fishbowl.rw.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178397>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2011.08.01.2020 +0200]:
> Hence, if I were to store additional information in the commit
> object headers, this information would by design be correct,
> immutable, and non-redundant. I am going to reply to my own mail
> with some implementation details to feed the curious, with the hope
> to keep this debate focused.

For lack of a better idea (cf. [0]), I am currently toying with the
following approach:

Possibly in addition to the orphan parent pointer to a commit object
suggested in [0], and in order to provide a clear means to identify
said orphan parent pointer (holding additional information), I am
considering storing this orphan parent commit's ref in the main
commit, using a header like x-topgit-top-base [1].

0. http://permalink.gmane.org/gmane.comp.version-control.git/178349
1. The use of the x- prefix is obviously intentional to suggest that
   this is a free-form, non-standard extension.

Whenever the extra data need changing, a new x-topgit-top-base ref
is added to HEAD.

Now, given a commitish, I simply have to walk back in time until
I find a commit object with such a header, and I have the most
recent metadata at my fingertips.

Instead of a ref to the orphan parent commit (which visibily
pollutes the history), I could also just store the information right
there.

This is arguably hackish, but unless I find a better way, it's the
best I've come up with thus far.

And of course, this could go into the commit message body text,
but it being an implementation detail, that's really not the right
place for it.

Thanks for your consideration,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"there are two major products that come out of berkeley: lsd and unix."
 one caused me an addiction
                                                             -- fyodor
=20
spamtraps: madduck.bogus@madduck.net

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONvBdwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xBAW
EAChRHrPsmXsQN/FxInxeNSpubiBmFMkJ09i4Od5xQmP1nNSu9xkFW1MaJ70tr9V
1UrfcPzZjBwbT2idtw5czd8HFlZ3DRP5XxgNkzn4ex8D/8IVZEMYkviKA7DWmlK2
lmA8pKBragfgRD9Jirl3UZFXV3YWAT+5jMFVK+bQtBIo6A4JdKBzAP0PEHpFhesF
KTWUTl15aayXP+RjwTFOc7tTjF2P/2Zvi7GsDdB3ezzz2U470eJpxw2HGvqgksoC
FmegeFIl1L+upCb6bRtFg3idCUw6rOkMKolkRQ2SH69MOJYXGTSd5SS1iyFCnOmB
ZmZZe/TgSh0O6VC9z9y7UbQdEyU6WsqI+6Fxb0COrXcwE4+kZXz4dB0N1JzMdR2H
GxHEDBN+DXt6a8CQkQd4vrohh8mD/0S607NBSFJLwlhnx4YPGhe3z2V78/pa2pZk
UEApKPgmJSeWZ7F/WkDM9hggFFoarvtYDd/ZKGesL5ufcEsLiw87Z4rQfDSWyN6x
gWqZagKQaIypCL7rnpSPm6c9hYMk7qJO26uzpqU0NuxuYszEvyXKQYSw7547ufN7
TWoPobhRZVb25Yupx5rkF5DPMK+XOeMfI+SOWi8cMjZ4g1cW0I1qIFEVHVSlq/5t
Aa9jtVtjrdA4xp2DLQY148O+JmkXkYP7O3npcri51K7B0w==
=AMUk
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
