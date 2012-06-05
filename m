From: Tyler Hicks <tyhicks@canonical.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 12:16:38 -0700
Message-ID: <20120605191637.GC25709@boyd>
References: <20120605075614.GE25809@sigill.intra.peff.net>
 <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	ecryptfs@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 21:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbzFL-0003Yi-5r
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab2FETQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 15:16:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54491 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2FETQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 15:16:46 -0400
Received: from ip72-219-180-13.oc.oc.cox.net ([72.219.180.13] helo=boyd)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <tyhicks@canonical.com>)
	id 1SbzFC-0002Jo-3O; Tue, 05 Jun 2012 19:16:42 +0000
Content-Disposition: inline
In-Reply-To: <20120605164439.GA2694@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199281>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199281>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2012-06-05 12:44:39, Jeff King wrote:
> On Tue, Jun 05, 2012 at 09:31:54AM -0700, Junio C Hamano wrote:
>=20
> > >>   setfacl -m m:rwx .
> > >>   perl -MFcntl -e 'sysopen(X, "a", O_WRONLY|O_CREAT, 0444)'
> > >>   umask 077
> > >>   perl -MFcntl -e 'sysopen(X, "b", O_WRONLY|O_CREAT, 0444)'
> > >>   getfacl a b
> > [...]
> > >
> > > Reading the withdrawn posix 1003.1e and "man 5 acl", it seems pretty
> > > clear that if a default ACL is present, it should be used, and umask
> > > consulted only if it is not (so the umask should not be making a
> > > difference in this case).
> > >
> > > The reproduction recipe above shows the minimum required to trigger i=
t;
> > > adding a more realistic default ACL (with actual entries for users) d=
oes
> > > not seem to make a difference.
> >=20
> > Thanks; so combining the above with your earlier patch to 1304 we
> > would have a good detection for SETFACL prerequisite?
>=20
> Yes, I think we can detect it reliably. I'd like to hear back from
> ecryptfs folks before making a final patch, though. It may be that there
> is some subtle reason for their behavior, and I want to make sure before
> we write it off as just buggy.

It is likely a bug in the eCryptfs filesystem stacking code.

However, using the above script, I get the same results on eCryptfs as I
do on ext4 in the Ubuntu 12.04 (Precise) LTS:

# file: a
# owner: tyhicks
# group: tyhicks
user::r--
group::r--
other::r--

# file: b
# owner: tyhicks
# group: tyhicks
user::r--
group::---
other::---

Stefan - can you specify which LTS release you're running as well as the
output of `cat /proc/version_signature`? Thanks!

Tyler

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJPzlsVAAoJENaSAD2qAscKsyAP/jr7Mzcu6cqUFllkBN5WLLnz
1crnbYMqkfHa7KIBlVX0TkEB2WZD8ca64at1wI5UcB2QF27JJflJlD++it0jXN8I
TGYQ/T7hKhLE9XPWFaz/KHZfssdkymf8VaypTx9dMM3FIAtYkXsCs62SMwbce5lA
MOpSgWgHw8EK0BmbOZeHer2mXQHVNHncoadJDZXqEpOL/QYQJSklgyjUnS5w1C1+
cQdhCIxYlsz9DidB8cP0IZzSlTWjH6YYLQ2/iWADPig2mRNPxyaZ0LMAzR5gtfcr
6gceaTlymketv1S6oBA7sHBKzGIuM4KHHd0HLq0xoe5rqJ54baSdoC36RwdlDHIr
2vLWZmf4wXwfXh6H8Mvx8PDH0Lk3z0gyVO8Bomlhm6lPhYQx8JqzO3dXW16vO0eD
rA0BpVBCfp2EgegRtl/HNeNaVKx0E9JcwvzXsG/UyGZKJD0R62UKFd0nWqojdQ8g
clJwckv9uczjA8VBBHEE6+Skkj+mYdNZ2FhYexZ19SrUXoDFotR6FIpibMLvt1sx
JWqk7DoJMOKbugSpbNZQuaMf/DKz5aKqXqVfJET8iIWJ9gPtbFTQzNg+Enp5e30l
q86H2WSo4xibYBg86f7a8bNIQctNdGP84QUg2xTTeHrziKzodC3yjznOJd0VWOHv
oJXqrMHLHXj9BJunwFtA
=RJBN
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
