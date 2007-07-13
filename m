From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with no
 names when Email::Valid is present
Date: Fri, 13 Jul 2007 18:28:18 +1000
Message-ID: <20070713182818.fd37372f.sfr@canb.auug.org.au>
References: <20070713041749.GA28824@kroah.com>
	<7vr6ncrh22.fsf@assigned-by-dhcp.cox.net>
	<20070713063414.GN24317@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__13_Jul_2007_18_28_18_+1000_f2aF3VL4gsCs/cnQ"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 10:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9GVq-00030g-N0
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 10:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761132AbXGMI21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 04:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761026AbXGMI21
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 04:28:27 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:39049 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760895AbXGMI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 04:28:26 -0400
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 69AF036803B;
	Fri, 13 Jul 2007 18:28:23 +1000 (EST)
In-Reply-To: <20070713063414.GN24317@kroah.com>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52372>

--Signature=_Fri__13_Jul_2007_18_28_18_+1000_f2aF3VL4gsCs/cnQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jul 2007 23:34:14 -0700 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jul 12, 2007 at 10:47:17PM -0700, Junio C Hamano wrote:
> > Greg KH <greg@kroah.com> writes:
> >=20
> > > When using git-send-email.perl on a changeset that has:
> > > 	Cc: <stable@kernel.org>
> > > in the body of the description, and the Email::Valid perl module is
> > > installed on the system, the email address will be deemed "invalid" f=
or
> > > some reason (Email::Valid isn't smart enough to handle this?) and
> > > complain and not send the address the email.
> >=20
> > That appears to be the case.
> >=20
> >         bad foo
> >         bad <foo@bar.baz>
> >         ok  foo@bar.baz
> >         ok  Foo <foo@bar.baz>

This would be a bug in Email::Valid as it complains that the second
address fails the rfc822 check, however rfc822 says that the "display
name" before the '<' is optional.

> > I'd probably do:
> >=20
> > 	if ($have_email_valid) {
> > 		$address =3D~ s/^<(.*)>$/$1/;

	$address =3D~ s/^\s*<(.*)>\s*$/$1/;

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Jul_2007_18_28_18_+1000_f2aF3VL4gsCs/cnQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlzenTgG2atn1QN8RAiQ3AJ9p3KRQrl2esNfOPfp8PG+eH33VeACfQb6I
05V/ZTfcw70oE7HCrT/NkNI=
=U42p
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Jul_2007_18_28_18_+1000_f2aF3VL4gsCs/cnQ--
