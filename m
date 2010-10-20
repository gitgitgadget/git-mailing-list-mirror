From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Wed, 20 Oct 2010 09:59:45 +0200
Message-ID: <20101020075945.GD28166@pengutronix.de>
References: <20101019160957.GK11713@pengutronix.de> <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de> <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 20 09:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8TaV-000240-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 09:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915Ab0JTH7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 03:59:50 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44465 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0JTH7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 03:59:49 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8TaN-0007JX-C8; Wed, 20 Oct 2010 09:59:47 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8TaL-00054Q-UF; Wed, 20 Oct 2010 09:59:45 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159400>

Hello,

On Tue, Oct 19, 2010 at 04:48:23PM -0400, Nicolas Pitre wrote:
> On Tue, 19 Oct 2010, Uwe Kleine-K=F6nig wrote:
>=20
> > Hi Jonathan,
> >=20
> > On Tue, Oct 19, 2010 at 01:39:25PM -0500, Jonathan Nieder wrote:
> > > Uwe Kleine-K=F6nig wrote:
> > >=20
> > > > 	ukl@hostname:~/path1/linux-2.6$ git fetch ~/path2/linux-2.6 se=
ctionmismatches
> > > > 	remote: Counting objects: 118, done.
> > > > 	remote: error: unable to find 40aaeb204dc04d3cf15c060133f65538=
b43b13b0
> > > > 	remote: Compressing objects: 100% (83/83), done.
> > > > 	remote: fatal: unable to read 40aaeb204dc04d3cf15c060133f65538=
b43b13b0
> > > > 	error: git upload-pack: git-pack-objects died with error.
> > > > 	fatal: git upload-pack: aborting due to possible repository co=
rruption on the remote side.
> > >=20
> > > Sounds like alternates or workdir allowed gc to be overzealous, i=
ndeed.
> > >=20
> > > Could you:
> > >=20
> > >  1. Make a copy of the corrupted repo, just in case.
> > >  2. Explode all backs with "git unpack-objects"
>=20
> That's usually unnecessary.  If the pack itself is corrupted, trying =
to=20
> unpack it all won't help.
>=20
> > I did:
> >=20
> > 	mv .git/objects/pack .git/objects/pack.bak
> > 	rm .git/objects/info/alternates
> > 	for p in .git/objects/pack.bak/*.pack ~/path1/linux-2.6/.git/objec=
ts/pack/*.pack; do
> > 		git unpack-objects < $p
> > 	done
>=20
> Ouch!  You will end up with a multi-gigabyte repository, which will b=
e=20
> abominably slow.
>=20
> > >  3. Identify the missing object, as explained in
> > >     Documentation/howto/recover-corrupted-blob-object.txt?
>=20
> That's useful when you have only one corrupted object and you want to=
=20
> recreate it from raw material.  But ideally you should simply find a=20
> pack that contains the problematic object in another repository and c=
opy=20
> it with its index=20
> file into the broken repository.
>=20
> > and I'm running git-fsck --full now over night as it's bedtime here=
=2E
>=20
> Given that you exploded your repo into loose objects, it'll take _tim=
e_.
Well it took 34 minutes, which is OK I guess.

I will study the output a bit now.

=46or the interested (all lines matching "dangling" removed):

	22:10:57 I: Started git fsck --full
	22:44:14 O: broken link from    tree 519af383e181399db929823299bbd14c0=
4b4229a
	22:44:14 O: to    tree d58c333c44672cb933df5a353dfb63ac571964e8
	22:44:14 O: broken link from  commit e8f7f6a23979c398249a15fb71b3e52da=
e933fa3
	22:44:14 O: to    tree 7f22979d86cf00c8bd3487feb973353ab5a1beee
	22:44:14 O: broken link from  commit 3164f6598ae44703a89822ced9746c187=
6ba7fab
	22:44:14 O: to    tree 1017bb1f45b8527ee3c7cfc30288b8098bcf0915
	22:44:14 O: broken link from  commit 124dde2ea387dc9509b0a5574c6f44f7d=
348a65d
	22:44:14 O: to    tree e4d0ac236995847e4e1d15c6d0afb47787255703
	22:44:14 O: broken link from  commit 60deff2fffd90b217d90284295d5a910f=
21fe98e
	22:44:14 O: to    tree 18bb32cfd08228820f929d62e63933fe2896b424
	22:44:14 O: broken link from  commit 0b84e651b84dba73772fda15a8a66de8c=
c274af0
	22:44:14 O: to    tree f8939a09d73b78459381b7991423529592e66324
	22:44:14 O: broken link from  commit e0de1d3c3355f9b1e3474417f05657a10=
41e7c8a
	22:44:14 O: to    tree 776ad9ac45dab11f2644151a690e1035789a49b6
	22:44:14 O: broken link from  commit 76d1acb95eef413a2501a63cb7f7f4036=
b71ed37
	22:44:14 O: to  commit f6b6cb2336198913371e66664f28c135df01aea5
	22:44:14 O: broken link from    tree bb473ad85c260b6a1659aa2059cac23b3=
37842e3
	22:44:14 O: to    tree e035bc14698cc3e9abfca1a174feacb25e7e262a
	22:44:14 O: broken link from    tree bb473ad85c260b6a1659aa2059cac23b3=
37842e3
	22:44:14 O: to    tree 8908b2458c1a2c6a6db81e88d96a01aa9a89abe5
	22:44:14 O: broken link from    tree ee35b3a549f45830ed50eb1032836a71a=
b2b7886
	22:44:14 O: to    tree f2f33722af4b5e32ac17f914cf24cc96c6e80077
	22:44:14 O: broken link from    tree ee35b3a549f45830ed50eb1032836a71a=
b2b7886
	22:44:14 O: to    tree 70f0188991b8406ec6ec75a504cf50c778fc1001
	22:44:14 O: broken link from    tree 1772732da7d4751d3c0febd7b0ceee61a=
84702f0
	22:44:14 O: to    tree dc3c1a018fcf2797a860af0cb899fe6be1173da3
	22:44:14 O: broken link from    tree 1772732da7d4751d3c0febd7b0ceee61a=
84702f0
	22:44:14 O: to    tree 2ade2c0731e57fc6b1baddb6faf683847d706179
	22:44:14 O: broken link from    tree 1772732da7d4751d3c0febd7b0ceee61a=
84702f0
	22:44:14 O: to    tree 659f4a6280150b7ae7b8f824257ad3cbb7cd1788
	22:44:14 O: broken link from    tree f29915a03ea5ba8739aacfcbb349d40b0=
19481ed
	22:44:14 O: to    tree b52d608d7743b1e096725d4b8d7c7769b19f6674
	22:44:15 O: missing tree 7f22979d86cf00c8bd3487feb973353ab5a1beee
	22:44:15 O: missing tree 70f0188991b8406ec6ec75a504cf50c778fc1001
	22:44:15 O: missing tree dc3c1a018fcf2797a860af0cb899fe6be1173da3
	22:44:15 O: missing tree f8939a09d73b78459381b7991423529592e66324
	22:44:15 O: missing tree e4d0ac236995847e4e1d15c6d0afb47787255703
	22:44:15 O: missing tree 2ade2c0731e57fc6b1baddb6faf683847d706179
	22:44:15 O: missing tree 8908b2458c1a2c6a6db81e88d96a01aa9a89abe5
	22:44:15 O: missing tree 18bb32cfd08228820f929d62e63933fe2896b424
	22:44:15 O: missing tree d58c333c44672cb933df5a353dfb63ac571964e8
	22:44:15 O: missing tree f2f33722af4b5e32ac17f914cf24cc96c6e80077
	22:44:16 O: missing tree 1017bb1f45b8527ee3c7cfc30288b8098bcf0915
	22:44:16 O: missing tree e035bc14698cc3e9abfca1a174feacb25e7e262a
	22:44:16 O: missing tree 659f4a6280150b7ae7b8f824257ad3cbb7cd1788
	22:44:16 O: missing commit f6b6cb2336198913371e66664f28c135df01aea5
	22:44:16 O: missing tree 776ad9ac45dab11f2644151a690e1035789a49b6
	22:44:16 O: missing tree b52d608d7743b1e096725d4b8d7c7769b19f6674
	22:44:16 O: missing blob 40aaeb204dc04d3cf15c060133f65538b43b13b0

Here is the output for the object bundle and fetch wail about, but
nothing about a tree that would need it :-(  Actually it's the only one
of the missing objects that is not described above (and it's the only
blob).

	22:44:17 I: Finished with exitcode 2

Now I'm running

	git for-each-ref | while read sha type name; do
		echo $name;
		git log --raw --full-history $sha | grep 40aaeb204dc04d3cf15c060133f6=
5538b43b13b0;
	done

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
