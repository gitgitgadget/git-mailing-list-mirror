From: Patrick Steinhardt <ps@pks.im>
Subject: Re: git segfaults on older Solaris releases
Date: Tue, 12 Apr 2016 12:21:24 +0200
Message-ID: <20160412102124.GA1914@pks-pc.localdomain>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
 <5706C0D4.9030707@jupiterrise.com>
 <5708A90E.1050705@jupiterrise.com>
 <20160409173904.GA5127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 12:21:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apvRr-0005ld-Do
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 12:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbcDLKV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 06:21:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35612 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932223AbcDLKV0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 06:21:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E08B521D06
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 06:21:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 12 Apr 2016 06:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=qHIVOQR/J9HwrVA1c7/VYBgiK5o=; b=SK9AT
	bQz2BuxTsmO3dbeLZEwIs0sciGxSO8wQfh/wYZI5clGyeNW05WjKDynuJaqchW4C
	7ZIzAqQgZfxmY5Hlyu3w6Cl+svbgNjdQfwBZe4lEXBTqXauAgOcvlHS04D4hUyJ6
	7gDst+UOQQiJnlFKjVCVB3MAoBbs3d8ohyUKgQ=
X-Sasl-enc: /JKi2JEbgvnyAi7ZNjZg17LKrrGH8TDSnOoA70Z9yFFy 1460456485
Received: from localhost (x55b3823e.dyn.telefonica.de [85.179.130.62])
	by mail.messagingengine.com (Postfix) with ESMTPA id 744EA68023A;
	Tue, 12 Apr 2016 06:21:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20160409173904.GA5127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291254>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 09, 2016 at 01:39:05PM -0400, Jeff King wrote:
> On Sat, Apr 09, 2016 at 09:02:38AM +0200, Tom G. Christensen wrote:
>=20
> > I've finished testing 2.8.1 and I found one more case where a null is b=
eing
> > printed and causing a segfault. This happens even on Solaris 8 and 9.
> > The failling test is t3200.63.
>=20
> Oh good, this one wasn't me. :)
>=20
> It's just a normal "oops, we feed NULL and nobody on glibc noticed
> because it silently replaced it with "(null)" case. I did find a few
> other oddities while fixing it, though. +cc Patrick, who worked in this
> area most recently.
>=20
>   [1/3]: config: lower-case first word of error strings
>   [2/3]: git_config_set_multivar_in_file: all non-zero returns are errors
>   [3/3]: git_config_set_multivar_in_file: handle "unset" errors
>=20
> I think we may want some additional improvements. While doing 1/3, I
> noticed that many of these error messages could stand to be marked for
> translation. As other people are already looking at mass-conversion,
> I stopped short of doing it here (and merely contented myself with
> throwing a conflict into their patches ;) ).
>=20
> The other thing is that 2/3 notices the error return from the
> config-setting functions is weird. It's sometimes negative and sometimes
> positive. I fixed this caller, but I think it's possible for the
> negative values to leak into our exit codes:
>=20
>   $ touch .git/config
>   $ git config foo.bar baz
>   error: could not lock config file .git/config: File exists
>   $ echo $?
>   255
>=20
> I seem to recall some systems having trouble with negative error codes,
> so we may want to make that more consistent.
>=20
> -Peff

Oh, yeah. Those patches look good to me, thanks for cleaning up
my error.

Patrick

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDMwkAAoJEBF8Z7aeq/EsLkEP/3Jda2BLE9Yz3x7SNOApdJGc
hfEOZ1iQ8uzj4KLTGMhQ8pLbojoElmO1le8uPV7NsU4ovKvn5hehP79yw+YIenVQ
QtiIwnfvZy5K9oUK9pFG5mPUWZ30XVnCxyHjwpRYB6AgGFSz6+g/2vy1+Zv6ZTmy
3OZQe2+Ju24MkD0RQPpJU/vHQD9OgtVVnzYh5W10HXSoNDlWbQOZI5IyrXvS7p8m
8XLr8C1J/I7ZGs7PUSOGsUNrOX//9ESQbV3XvulAEh2bnXRiObxJtEEuOZ3tniFD
3vibEql9N0tqQS4snVG0Kx5bfQ72paS6/T5d43IMj2rtENhbOlXNLnUeHqYWX3gU
q95Y4WHRFQiwQ9c4wJEk3WvJ10MQmdLA/OWT/k/QXFVl5TvDMo50P2k0T7uKI7Ly
oy/zdJFCjioqcDZMNwofawFVZZWDjvHLNNrOetTm9yXxTY2FvRXtH91ydKKnk/02
W5Kwpymny43fVAWoN2M5fbltNavWak2aeW6kWWIZQkeawXOujSfgzKq1R+OnMpDa
ONP5eTfZuMsd+sXi4lO3YWksLjjrmcp025vKc7j4jfi5Qhq5qGqL7qcHINgIOziD
yRj+q21DjlhpISikuSRhKXLQkHHzRFFlFAWgodacjEOf7P2EDt9aYTQTEN0mNGR4
kiTzHeXe4OHYBdo+yoE2
=jR+j
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
