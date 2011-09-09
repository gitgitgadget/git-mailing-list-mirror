From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git repository size / compression
Date: Fri, 09 Sep 2011 16:28:54 +0200
Message-ID: <1315578547.4377.2.camel@centaur.lab.cmartin.tk>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	 <1315556595.2019.11.camel@bee.lab.cmartin.tk>
	 <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6rb1OnJVJK+bskvpzkq6"
Cc: git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2253-0006X8-B6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345Ab1IIO3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 10:29:15 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43303 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759240Ab1IIO3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 10:29:08 -0400
Received: from [192.168.0.2] (g226037176.adsl.alicedsl.de [92.226.37.176])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 87AC746156;
	Fri,  9 Sep 2011 16:28:50 +0200 (CEST)
In-Reply-To: <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181072>


--=-6rb1OnJVJK+bskvpzkq6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-09-09 at 09:04 -0500, neubyr wrote:
> On Fri, Sep 9, 2011 at 3:23 AM, Carlos Mart=C3=ADn Nieto <cmn@elego.de> w=
rote:
> > On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:
> >> I have a test git repository with just two files in it. One of the
> >> file in it has a set of two lines that is repeated n times.
> >> e.g.:
> >> {{{
> >> $ for i in {1..5}; do cat ./lexico.txt >> lexico1.txt &&  cat
> >> ./lexico.txt >> lexico1.txt && mv ./lexico1.txt ./lexico.txt;  done
> >> }}}
> >>
> >
> > So you've just created some data that can be compressed quite
> > efficiently.
> >
> >> I ran above command few times and performed commit after each run. Now
> >> disk usage of this repository directory is mentioned below. The 419M
> >> is working directory size and 2.7M is git repository/database size.
> >>
> >> {{{
> >> $ du -h -d 1 .
> >> 2.7M    ./.git
> >> 419M    .
> >>
> >> }}}
> >>
> >> Is it because of the compression performed by git before storing data
> >> (or before sending commit)??
> >>
> >
> > Yes. Git stores its objects (the commit, the snapshot of the files,
> > etc.) compressed. When these objects are stored in a pack, the size can
> > be further reduced by storing some objects as deltas which describe the
> > difference between itself and some other object in the object-db.
> >
>=20
> Does git store deltas for some files? I thought it uses snapshots
> (exact copy of staged files) only.

Yes and no. The data model for git is to always store snapshots, and it
always expects to have the full files available. In a packfile, however,
in order to save space, some objects are stored as deltas to other
objects in the same file.

http://progit.org/book/ch9-4.html

>=20
>=20
> >> Following were results with subversion:
> >>
> >> Subversion client (redundant(?) copy exists in .svn/text-base/
> >> directory, hence double size in client):
> >> {{{
> >> $ du -h -d 1
> >> 416M    ./.svn
> >> 832M    .
> >> }}}
> >
> > Subversion stores the "pristines" (which is the status of the files in
> > the latest revision) inside the .svn directory. I wouldn't call this
> > copy redundant, though, as it allows you to run diff locally. The
> > pristines are stored uncompressed, which is why you half of the space i=
s
> > taken up by the .svn directory.
> >
> >>
> >> Subversion repo/server:
> >> {{{
> >> $ du -h -d 1
> >>  12K    ./conf
> >> 1.2M    ./db
> >>  36K    ./hooks
> >> 8.0K    ./locks
> >> 1.2M    .
> >> }}}
> >
> > I don't know how the repository is stored in Subversion, but it may als=
o
> > be compressed. You may be able to reduced your git repository size by
> > (re)generating packs with 'git repack' and doing some cleanups with 'gi=
t
> > gc', but the repository size is not often a concern.
> >
> >   cmn
> >
> >
> >
>=20
> that's helpful. thanks.
>=20
> --
> neuby.r
>=20



--=-6rb1OnJVJK+bskvpzkq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOaiKmAAoJEHKRP1jG7ZzTFTQH/3xpeeSZq8MXg+35ADZkW8sy
ZqEN3iK2HnHKUC7na/AqgpigC3aAM8IrRhIN74PV0J+qCKTKm+T7AXBFXHQQ1Jyb
DSbJ51ArlCPRiZhAUd9vIKgYdJQHbJZSCMbRrSNHzLbSC+53F8AguKEqUPQahw7x
SUDjqwjQqLTJ2mgZDU2wruaWk46etz5pdXkEPTEmoRreENITDRKgGNgfCH3d1gkl
Nq7bU8TnoVm+OBQZ22ZO1VQlqxxlP3FbaKQuceXaOUSSjfWQI/zn5Af927Ohn/DZ
QayK4VSQFA28ZP/bitGv7SqXrYD9Grm77oPpKp9rl7YttoAXNmcMFnS2K5EBv2A=
=3KqZ
-----END PGP SIGNATURE-----

--=-6rb1OnJVJK+bskvpzkq6--
