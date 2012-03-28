From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v5 2/3] gitweb: refactor If-Modified-Since handling
Date: Wed, 28 Mar 2012 09:51:46 -0400
Message-ID: <20120328135146.GA3525@odin.tremily.us>
References: <20120326173646.GA6524@odin.tremily.us>
 <7vsjgvnr4x.fsf@alter.siamese.dyndns.org>
 <20120326191242.GA9041@odin.tremily.us> <201203280024.20805.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 15:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCtIQ-0000CS-DM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 15:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893Ab2C1NwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 09:52:13 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:47397 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756Ab2C1NwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 09:52:12 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L0070KL6HAD90@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 08:52:10 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2F14A43AAF2; Wed,
 28 Mar 2012 09:51:46 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203280024.20805.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194121>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 11:24:20PM +0100, Jakub Narebski wrote:
> On Mon, 26 Mar 2012, W. Trevor King wrote:
> > +# --------------------------------------------------------------------=
--
> > +# modification times (Last-Modified and If-Modified-Since)
> > +
> > +test_expect_success 'modification: feed last-modified' '
> > +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
> > +	grep "Status: 200 OK" gitweb.output &&
> > +	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
> > +'
>=20
> All right.
>=20
> What's that date from?  Wouldn't it be better to read it from commit
> object with `git show -s --pretty=3D%cD HEAD` or postprocessed from
> '%ct' timestamp?

That's the date set by the first `test_tick`, which is hardcoded in
`test-lib-functions.sh`.  Extracting the date dynamically seems
unnecessary, since I can't imagine anyone changing the `test_tick`
date.  It's easy enough to do if you think it is appropriate though=E2=80=A6

> > +test_debug 'cat gitweb.headers'
> > +
> > +test_expect_success 'modification: feed if-modified-since (modified)' '
> > +	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> > +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
> > +	unset HTTP_IF_MODIFIED_SINCE &&
> > +	grep "Status: 200 OK" gitweb.output
> > +'
>=20
> I think it *might* be better solution to use test_when_finished:
>=20
>   +test_expect_success 'modification: feed if-modified-since (modified)' '
>   +	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
>   +	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>   +	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
>   +	grep "Status: 200 OK" gitweb.output
>   +'
>=20
> I don't think we need sane_unset here.

Good point.  Sloppy me not reading `t/README` thoroughly enough ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcxdxAAoJEPe7CdOcrcTZiygH/AuLViQ/H2ESBGKMp+w14gw0
GsaVg0zkhx9CktKxmImiL4ZIuqD5S2+OQw5smSmAtBA/AL5ft+r+awjPixbBrvTn
rbPxfue9jpKbwhrPoXyRck/lP6vPVizNXnxnpPZuHvCHRpvXxT9gQdSkEv7zspdr
tc/oPAzpUk/iSTdoUGQlVUDYuXyASGwE/6RIANInh9arA3Pwd1CFzlRBqdlAlEEB
Skw2ytFVqMi20Pqn/fLMNlQVN5LvRClElNXhTYK9wCFEHYDLRKpTgNTsPvarxvqw
M9/gHw43yFmGuiI3oxZRHpBE7AhDun/pW1QUXkolbMRFVM3DF8PV7PCuH8aFkO8=
=kKhT
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
