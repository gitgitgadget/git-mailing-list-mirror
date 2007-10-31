From: Johan Herland <johan@herland.net>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 13:43:54 +0100
Message-ID: <200710311343.58414.johan@herland.net>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se> <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se> <Pine.LNX.4.64.0710311059020.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1250356.KC47SMdzCU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 13:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCwX-0006eN-AS
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXJaMow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755850AbXJaMow
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:44:52 -0400
Received: from sam.opera.com ([213.236.208.81]:56147 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797AbXJaMov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:44:51 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l9VChwnd032400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Oct 2007 12:43:59 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710311059020.4362@racer.site>
X-Virus-Scanned: ClamAV 0.91.1/4646/Wed Oct 31 10:41:08 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62824>

--nextPart1250356.KC47SMdzCU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 31 October 2007, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 31 Oct 2007, Peter Karlsson wrote:
>=20
> > Johannes Schindelin:
> >=20
> > > Why should it?  This would contradict the whole "a commit sha1 hashes=
=20
> > > the commit, and by inference the _whole_ history" principle.
> >=20
> > Does it?
>=20
> Yes!  Of course!  If what you want becomes possible, I could make an evil=
=20
> change in history long gone, and slip it by you.  You could not even see=
=20
> the history which changed.

Well, technically, if the grafts file was part of the repo, you wouldn't be=
=20
able to change the (in-tree) grafts file without affecting the SHA1 of HEAD=
=2E=20
In other words, given a commit SHA1 sum, you can be sure that someone else=
=20
who checks out the same commit (and has no local modification to their graf=
ts=20
file) will see exactly the same history as you do.

To a certain degree, this is actually "safer" than today's (out-of-tree)=20
solution, where one can change the grafts file _without_ affecting the=20
current HEAD (SHA1 sum), and thus will not see the same history as someone=
=20
else who checks out the same HEAD. This is of course _intended_ to a certai=
n=20
degree by the current implementation, but can easily cause confusion if=20
people lose track of what's in their respective grafts files.

Of course, this is both a blessing and a curse: Say, for example, we have=20
three commits:

=2E.. --> A --> B --> C

and commit B changes the (in-tree) grafts file. Now if I have HEAD @ A, I w=
ill=20
see a different history than if I have HEAD @ C. Worse: If one person has=20
HEAD @ A, and another person has HEAD @ C, and neither is aware of the graf=
ts=20
file change in B, there is _plenty_ of room for getting confused if the two=
=20
persons start discussing the repo history. Note, however, that similar=20
confusement can be achieved today if one of the persons forgets having=20
changed his out-of-tree grafts file


The grafts file concept is very powerful, but can also be extremely confusi=
ng.=20
Adding in-tree versioning of the grafts file will make it more powerful=20
(since we can now easily share and update "errata" to the repo history), bu=
t=20
it might also make things _orders_of_magnitude_ more confusing (as=20
demonstrated in the above example, although to be fair, similar confusement=
=20
can be had in today's out-of-tree solution). At some point things may becom=
e=20
so confusing that we'd rather drop the feature instead.


=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1250356.KC47SMdzCU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBHKHiLBHj4kl4fT1wRAgDVAJ0dsIAed8peoSKXJ2b8/EYOAzQzyACgjg8f
/tb5xQBFCI2/MQh/mFB9H20=
=zMK6
-----END PGP SIGNATURE-----

--nextPart1250356.KC47SMdzCU--
