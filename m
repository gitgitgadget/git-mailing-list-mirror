From: Eric Blake <eblake@redhat.com>
Subject: Re: Are the patches used to build git on cygwin available in a git
 repo somewhere?
Date: Thu, 01 Apr 2010 14:59:17 -0600
Organization: Red Hat
Message-ID: <4BB50925.9070006@redhat.com>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com> <20100331025626.GA13501@progeny.tock> <20100331025856.GB13501@progeny.tock> <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com> <20100401023526.GA20916@progeny.tock>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA740F490B7A2D5CDE8E3C8F"
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 23:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxRVP-0006cB-3I
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0DAVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 17:00:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab0DAVAh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 17:00:37 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o31L0XCj023349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 1 Apr 2010 17:00:33 -0400
Received: from [10.11.10.93] (vpn-10-93.rdu.redhat.com [10.11.10.93])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o31L0VAn027871;
	Thu, 1 Apr 2010 17:00:31 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b1 Thunderbird/3.0.3
In-Reply-To: <20100401023526.GA20916@progeny.tock>
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143749>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA740F490B7A2D5CDE8E3C8F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2010 08:35 PM, Jonathan Nieder wrote:
> I just fetched the packaging.
>=20
>   http://mirror.mcs.anl.gov/cygwin/release/git/git-1.6.6.1-1-src.tar.bz=
2
>=20
> gitk - work around stderr redirection on Cygwin
>=20
>   The description of this patch suggests it is meant to work around
>   the old Tcl/Tk version.  In that case, maybe stock gitk should learn
>   a workaround.  I don=E2=80=99t think it is supposed to require more r=
ecent
>   Tcl/Tk than 8.4.
>=20
>   Unfortunately, I cannot find a relevant changelog entry.  Maybe
>   this is a Windows-specific bug?  http://wiki.tcl.tk/2620
>   describes a similar problem.

More of a problem of the fact that cygwin tcl is _still_ stuck with a
bastardized implementation that is not quite a true cygwin app, and
therefore doesn't handle file redirections as gracefully as it could.
Mark Levedahl proposed the patch upstream on 14 Jun 2008, but it was
never accepted.
http://marc.info/?t=3D121346288300001&r=3D1&w=3D2

>=20
> gitk - convert gitk-path to Windows if on Cygwin
>=20
>   This patch seems reasonable, and it only affects Cygwin.  I think it
>   looks reasonable for inclusion in stock gitk, though others might
>   disagree.

OK, I'll find time to re-submit it upstream.   It was modified from this
original post, also by Mark Levedahl:
http://marc.info/?l=3Dgit&m=3D121349005001446&w=3D2

>=20
> Documentation/Makefile
>=20
>   Adds --unsafe to the asciidoc command line.  Why?

Because VPATH builds of the documentation make asciidoc fail otherwise,
due to a complaint about an unsafe use of ../ referencing to find the
source dir outside of the build dir.

>=20
> Makefile
>=20
>   Stops disabling so many features, since Cygwin has come a long way.
>   This looks worth applying upstream.  The conservative thing to do
>   would be to test $(uname -r), but since it is easy to bring a
>   Cygwin installation up to date and hard to figure out the appropriate=

>   versions, it might make sense to make this change unconditionally.

Most of those defaults cater to cygwin 1.5, which was released several
years ago.  Cygwin 1.7 is the only supported version now, but it was
only released late 2009.  I'll try to find time to submit the
less-controversial of these upstream.

>=20
>   A worrisome one is NO_MMAP.  Was that problem ever understood?  Maybe=

>   v1.6.3-rc0~133 (MinGW: implement mmap, 2009-03-13) contains some clue=
s
>   (just a hope).  The message for v1.5.0-rc1~182 (Set NO_MMAP for Cygwi=
n
>   by default, 2006-12-27) indicates that it=E2=80=99s filesystem-specif=
ic,=20

No one has ever demonstrated to me why NO_MMAP was needed on cygwin.
I'd rather get mmap fixed on cygwin, if it really is a bug (and if it
still exists; it is highly likely that the bug was against 1.5 but has
been fixed in the meantime).

>=20
> Makefile: all:: perl/perl.mak
>=20
>   Should be unnecessary. The scripts should pull it in already.

It made a difference for me when packaging for cygwin.  But if there's a
way to make it work without that line, I'm all ears.

>=20
> Makefile: setting INSTALLDIRS=3Dvendor in the perl/perl.mak target
>=20
>   Should be unnecessary.  Make passes on variable settings from the
>   command line to submakes already.

Again, I could never get it to work without this patch; but I'm all ears
if there's a better way.

>=20
> git-gui/Makefile:
>=20
>   Change to Cygwin-specific part.  Probably applicable upstream.

OK, I'll try and find time to send an upstream patch submission.

Meanwhile, I'm trying to package git 1.7.0.4 for cygwin, so this is a
good chance to review all of those patches in the cygwin port.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigFA740F490B7A2D5CDE8E3C8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku1CScACgkQ84KuGfSFAYCpPQCfbS7FwJeScHfQq43xZ17+oQ+w
bhIAnift93O6P8Xul2J9xyazV5oV4T8M
=nF5P
-----END PGP SIGNATURE-----

--------------enigFA740F490B7A2D5CDE8E3C8F--
