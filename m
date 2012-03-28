From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v5 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Wed, 28 Mar 2012 09:58:47 -0400
Message-ID: <20120328135847.GB3525@odin.tremily.us>
References: <20120326191418.GB9041@odin.tremily.us>
 <201203280031.38011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 16:59:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCuLP-0006AE-DH
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 16:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab2C1O7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 10:59:18 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:65118 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab2C1O7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 10:59:17 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2012 10:59:17 EDT
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L00ABILI05RA0@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 08:58:53 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id BB41143AB0E; Wed,
 28 Mar 2012 09:58:47 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203280031.38011.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194125>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 11:31:37PM +0100, Jakub Narebski wrote:
> On Mon, 26 Mar 2012, W. Trevor King wrote:
> > Because snapshots can be large, you can save some bandwidth by
> > supporting caching via If-Modified-Since.  This patch adds support for
> > the i-m-s request to git_snapshot() if the requested hash is a commit.
>=20
> "if the requested hash is a commit" means here "if we request snapshot
> of a commit", isn't it?
>=20
> > Requests for snapshots of tree-ishes, which lack well defined
> > timestamps, are still handled as they were before.
>=20
> s/tree-ishes/trees/.  Commit is tree-ish but not a tree; it is tree
> that lacks timestamp that commit has.

Right.  I'll fix those in v6 ;).

> > +	if (%co) {
> > +		my %latest_date =3D parse_date($co{'committer_epoch'}, $co{'committe=
r_tz'});
> > +		print $cgi->header(
> > +			-type =3D> $known_snapshot_formats{$format}{'type'},
> > +			-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
> > +			-last_modified =3D> $latest_date{'rfc2822'},
> > +			-status =3D> '200 OK');
> > +	} else {
> > +		print $cgi->header(
> > +			-type =3D> $known_snapshot_formats{$format}{'type'},
> > +			-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
> > +			-status =3D> '200 OK');
> > +	}
>=20
> This can be written shorter, and with less code repetition using ?:=20
> conditional operator:
>=20
> > +	print $cgi->header(
> > +		-type =3D> $known_snapshot_formats{$format}{'type'},
> > +		-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
> > +		 (%co ? -last_modified =3D> $latest_date{'rfc2822'} : ()),
> > +		-status =3D> '200 OK');
>=20
> ...or something like that.

Ah, that's much better.  I'm not particulary familar with Perl, sorry ;).

I'll wait until I here back on Last-Modified timestamp generation, and
then submit v6.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcxkWAAoJEPe7CdOcrcTZ3EgIAIFMQTbhJp0nyyzvt31GuqAq
Yfs29jcoWhSFCcF3e7uYjiRcZb6TnOotV2e0be7fA8y9hfjb4iEZMxgG15ASzS4J
S5H5C7JqK+PBgm3pVkYucvNNS74ZmenZmjWgf0EsTAxXfSi9pQgo81xCEXAmusZ4
wUjLilYKZR0pEcoO82ki5W3bc1CxAxUaKJ/YIU1dKxb0cpBHIQz2pOA0XjQG9DeR
GiGfqTMgiuK/cvJYZT3Qs4aAsNYZcxuiG+kSqE+D6NfBZqBKlCFJuV3MaXcw2Ylp
lCcaqTpzc+jfpY1eXzOgGlrbCE8Hm57al7+wdmhEVTxM1gWlLlhMuuWyd/vu2js=
=nB8B
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
