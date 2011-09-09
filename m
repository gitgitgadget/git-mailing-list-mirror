From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git repository size / compression
Date: Fri, 09 Sep 2011 10:23:13 +0200
Message-ID: <1315556595.2019.11.camel@bee.lab.cmartin.tk>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ZnvhipWoJRm7YYvTyAjU"
Cc: git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 10:23:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1wMv-0006cH-Dt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644Ab1IIIXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 04:23:18 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43530 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757534Ab1IIIXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 04:23:16 -0400
Received: from [130.149.85.236] (dhcp236.dcaiti.tu-berlin.de [130.149.85.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B21C146156;
	Fri,  9 Sep 2011 10:22:58 +0200 (CEST)
In-Reply-To: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181033>


--=-ZnvhipWoJRm7YYvTyAjU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:
> I have a test git repository with just two files in it. One of the
> file in it has a set of two lines that is repeated n times.
> e.g.:
> {{{
> $ for i in {1..5}; do cat ./lexico.txt >> lexico1.txt &&  cat
> ./lexico.txt >> lexico1.txt && mv ./lexico1.txt ./lexico.txt;  done
> }}}
>=20

So you've just created some data that can be compressed quite
efficiently.

> I ran above command few times and performed commit after each run. Now
> disk usage of this repository directory is mentioned below. The 419M
> is working directory size and 2.7M is git repository/database size.
>=20
> {{{
> $ du -h -d 1 .
> 2.7M    ./.git
> 419M    .
>=20
> }}}
>=20
> Is it because of the compression performed by git before storing data
> (or before sending commit)??
>=20

Yes. Git stores its objects (the commit, the snapshot of the files,
etc.) compressed. When these objects are stored in a pack, the size can
be further reduced by storing some objects as deltas which describe the
difference between itself and some other object in the object-db.

> Following were results with subversion:
>=20
> Subversion client (redundant(?) copy exists in .svn/text-base/
> directory, hence double size in client):
> {{{
> $ du -h -d 1
> 416M    ./.svn
> 832M    .
> }}}

Subversion stores the "pristines" (which is the status of the files in
the latest revision) inside the .svn directory. I wouldn't call this
copy redundant, though, as it allows you to run diff locally. The
pristines are stored uncompressed, which is why you half of the space is
taken up by the .svn directory.

>=20
> Subversion repo/server:
> {{{
> $ du -h -d 1
>  12K    ./conf
> 1.2M    ./db
>  36K    ./hooks
> 8.0K    ./locks
> 1.2M    .
> }}}

I don't know how the repository is stored in Subversion, but it may also
be compressed. You may be able to reduced your git repository size by
(re)generating packs with 'git repack' and doing some cleanups with 'git
gc', but the repository size is not often a concern.

   cmn



--=-ZnvhipWoJRm7YYvTyAjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOaczyAAoJEHKRP1jG7ZzT4+EIAJABPl2shyAssuS3YwQcWIxx
2TVaz2rp/3UOWmttr81DIaYr9TX9gilk6SiCNC4Fh8YJIYRVzmtDyxYtovL0CUEi
kzfuOlh+2p365wCqLoftwJj5YrXwOPBlGdB708ZdxAsVB9X3KJNI8j3fl/nnaK1X
JDG/Y/qJbzKKs7ujmFnfP6i+gvVN2PLFgN0s6M8yg8O+liZsf2UCPZRXfKeuEq9S
oXpZCcPG/IkqN9eEH3QnV+AMG/wLvfBXwPuu73YjoRf9VvxChDGWy8agorHwCd8w
MapOLyPP6xejmF2CaG3f+BisTrN10sQm+BmI85OYR9gmbOmupme4rbHZBa6yAgo=
=3AlF
-----END PGP SIGNATURE-----

--=-ZnvhipWoJRm7YYvTyAjU--
