From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 16:53:01 +0100
Message-ID: <20111125155301.GC10417@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <Pine.GSO.4.63.1111251629500.22588@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Fri Nov 25 16:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTy5x-0003o5-6c
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 16:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab1KYPxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 10:53:37 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:40735 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab1KYPxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 10:53:36 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 27DB04619B;
	Fri, 25 Nov 2011 16:52:56 +0100 (CET)
Received: (nullmailer pid 32525 invoked by uid 1000);
	Fri, 25 Nov 2011 15:53:01 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1111251629500.22588@shipon.roxen.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185935>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2011 at 04:43:41PM +0100, Henrik Grubbstr=F6m wrote:
> On Wed, 23 Nov 2011, Henrik Grubbstr=F6m wrote:
>=20
> >Hi.
> >
> >My git repository walker just got bitten by what seems to be a
> >reasonably new bug in convert.c:cascade_filter_fn() (git 1.7.8.rc3
> >(gentoo)).
>=20
> After some tracing, the problem is triggered by the variable "remaining"
> being set to 1 in the beginning of the cascade_filter_fn() loop,
> which causes filter "two" to be called with an output buffer size of
> 1.
> Filter "two" in this case is lf_to_crlf_filter_fn(), and the next
> input character is a "\n". lf_to_crlf_filter_fn() wants to convert
> this to "\r\n", but that doesn't fit into the buffer, so it breaks
> out and returns zero. Upon seing the zero cascade_filter_fn() thinks
> all is well, even though nothing has happened, and loops.
>=20
> The bug is probably that lf_to_crlf_filter_fn() should return
> non-zero in this case (ie o and/or i being zero).

non-zero? That would cause the filter to abort, which definitely not
what we want. Have you seen my other e-mails regarding this? I'm
trying to figure out which is the best way to go about this. The
solution is to keep track of the fact that we're missing a LF in the
output buffer.

   cmn

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOz7ndAAoJEHKRP1jG7ZzTdpYIAJ+kbsHSh1kf4y4p3L0RY6BR
vTH5aIZTXGY1R9CddtHw5lq2TIR8YRd1D5lYvBP7XkO+9tSRWCl5ogY2vpD9GZSd
A5RztFi7BqVy2vWtH73nuux/YrLyc1QRfiB5b5OPrVMVcL2RaKyUAQF87dZa3yBN
8F5cjQH0ICUhmF7uqtZHLF4S5XD2qR76Tasn9XpE2mwcdvrVVepYDuxDp1U0NEfD
kwtnAf1gBl+hE//FyL9caf9228TVVnL/06WBCaY86+HzHr1tlDmiWJquaX/Br3yR
fUnvJLEEVEI4vMi9H9WQPFYE0lobFBACAMJ0r8QuZ+VRO1ILWm1rl3TE1oEoTao=
=pzJZ
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
