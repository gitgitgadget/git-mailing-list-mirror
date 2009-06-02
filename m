From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: gitosis question: identifying/logging remote user
Date: Tue, 2 Jun 2009 13:21:18 -0700
Message-ID: <20090602202118.GD3042@orbis-terrarum.net>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com> <robbat2-20090602T062332-128740789Z@orbis-terrarum.net> <2e24e5b90906020619o1bef150k43eba2870ff4fc4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, tv@eagain.net
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaUW-0000sT-EI
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZFBUVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZFBUVh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:21:37 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40283 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751297AbZFBUVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:21:36 -0400
Received: (qmail 17806 invoked from network); 2 Jun 2009 20:21:35 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 02 Jun 2009 20:21:35 +0000
Received: (qmail 6805 invoked by uid 10000); 2 Jun 2009 13:21:18 -0700
Content-Disposition: inline
In-Reply-To: <2e24e5b90906020619o1bef150k43eba2870ff4fc4e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120544>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2009 at 06:49:22PM +0530, Sitaram Chamarty wrote:
> > 2. At the top, look for RFC822 headers with a leading "# " as padding:
> > =A0 Examples from my own patch:
> > =A0 # Full-Name: "Robin H. Johnson (robbat2)" <robbat2@gentoo.org>
> > =A0 # cia-vc-username: robbat2
> Hmmm... is this a significantly different gitosis?=20
Available here:
http://git.overlays.gentoo.org/gitweb/?p=3Dproj/gitosis-gentoo.git;a=3Dsumm=
ary

> The files in my keydir mostly contain just one line (some have two,
> for people who work from different machines), looking like this:
>=20
> ssh-rsa [long series of base64 type characters]=3D=3D some.one@company.com
Comments ARE valid at the top of the files. Some of files have many
keys (users that keep keys unique to machines rather than use agents).
In the comments, we keep contact details for the user, as well as who
requested adding them, when, and for what purpose. The name of the file
is only for the ACL system. We had one potential conflict in naming
already, I got one of the users to rename to avoid having problems
elsewhere.

> > =A0 The headers are followed by a blank line then further text is free-=
form
> > =A0 and not parsed. Continuation lines are NOT supported.
> > 3. The header field names are transformed to enviornoment variable names
> > =A0 as follows:
> > =A0 - y/[[:lower:]]/[[:upper:]]/g
> > =A0 - s/-/_/g
> > 4. Export the environment variables, named per above, with the full
> > =A0 content of the rest of the line.
> > (We need to export the CIA.vc data, and also send off a commit mail).
> Nope, I'm completely lost.  Perhaps I failed miserably in explaining
> what I want... !
No, it just seems that you aren't expecting the extra level of
indirection. Instead of explicitly exporting values via environment in
authorized_keys, OR in gitosis-serve (like the other patch), I teach
gitosis-serve how to find the keydir again, and extract pre-formatted
data.

Say I'm committing to gitosis.
The entry in the authorized keys is:
command=3D"gitosis-serve robbat2",no-port-forwarding,no-X11-forwarding,...

When gitosis-serve runs, it goes and opens keydir/robbat2.pub.
The following headers are there:
# Full-Name: "Robin H. Johnson (robbat2)"
# Email: <robbat2@gentoo.org>
# cia-vc-username: robbat2

And the gitosis-serve mangles these per my instructions above, and does
os.putenv with them.

Then the following exists in the environment:
FULL_NAME=3D'Robin H. Johnson (robbat2)'
EMAIL=3D'robbat2@gentoo.org'
CIA_VC_USERNAME=3D'robbat2'

Which are thus usable in the hooks.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkolib4ACgkQPpIsIjIzwixdAACg9mBqfg3eZGvetyYAp835D0AV
ffUAnR51hnq6OFNQRj6fHj9pQ2bjUOTU
=GmWR
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
