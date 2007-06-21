From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Thu, 21 Jun 2007 10:00:00 -0500
Message-ID: <1182438000.4031.11.camel@lt21223.campus.dmacc.edu>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com>
	 <4679EE45.2080605@midwinter.com>
	 <20070621141415.GA21065@magnesium.roaringpenguin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7UUsUYoD/sEW+jhI3X4d"
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Dave O'Neill <dmo@roaringpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1O8n-0001pq-KQ
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbXFUPAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754397AbXFUPAI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:00:08 -0400
Received: from homer.isunet.net ([63.175.164.9]:41856 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbXFUPAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:00:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 1AAD9388357;
	Thu, 21 Jun 2007 09:08:25 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 18234-05; Thu, 21 Jun 2007 09:08:22 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 7993B388290;
	Thu, 21 Jun 2007 09:08:22 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1I1O8l-0006Sx-RG; Thu, 21 Jun 2007 10:00:08 -0500
In-Reply-To: <20070621141415.GA21065@magnesium.roaringpenguin.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50632>


--=-7UUsUYoD/sEW+jhI3X4d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-06-21 at 10:14 -0400, Dave O'Neill wrote:
> On Wed, Jun 20, 2007 at 08:19:33PM -0700, Steven Grimm wrote:
>=20
> > Any chance of applying this to git-svn instead? There has been talk of=20
> > deprecating git-svnimport since git-svn now does everything=20
> > git-svnimport does, and more. (If you believe that's not the case,=20
> > please describe what you're doing with git-svnimport that you can't do=20
> > with git-svn.)
>=20
> Sure, I can probably apply it to git-svn as well, but based on the
> testing I've done, git-svnimport still works better for what I'm doing.
> I'm trying to do a straight conversion from SVN to git, so we can do
> away with our Subversion repositories, so I won't need the bidirectional
> support of git-svn. =20
>=20
> If git-svn had a --one-way option that could=20
>   - know that I'm converting, and import my SVN tags and branches to
>     local tags and heads rather than remotes

This quickie Python script should convert the "tag branches" to regular
Git tags:

        import os
        refs =3D os.popen('git-for-each-ref --format=3D"%(objectname)%00%(r=
efname)%00" refs/remotes/tags')
        for line in refs:
            [sha, ref] =3D line.split('\0')[:2]
            os.system('git tag %s %s' % (ref[18:], sha))


>   - turn off the git-svn-id: tags in the commit

git svn fetch --no-metadata

>   - avoid preserving a .git/svn/ directory (a git-svn conversion was 50%
>     larger than one from git-svnimport because of this)

Once you are done importing, you can delete that directory.

>   - convert svn:ignore attrs to .gitignore (like the -I option of
>     git-svnignore)

git svn show-ignore

> then I wouldn't need git-svnimport.  Alternatively, if there's some way
> to postprocess my clone to do all of the above, that would probably be
> good enough.


--=-7UUsUYoD/sEW+jhI3X4d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGepJrrtk7xyyIQRERAlWMAJ9Fj0FyoGoGzsVa9ospIfkKInFoEgCeNTFJ
Vc6lSEeJvVCFLTd5IIoVZqU=
=4rP8
-----END PGP SIGNATURE-----

--=-7UUsUYoD/sEW+jhI3X4d--
