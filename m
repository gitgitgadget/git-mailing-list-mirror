From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
	a pack file
Date: Tue, 09 Dec 2008 01:02:19 -0800
Organization: Slide, Inc.
Message-ID: <1228813339.18611.35.camel@starfruit.local>
References: <20081209093627.77039a1f@perceptron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L77nzp0zWQHRTddpjw3n"
Cc: Git ML <git@vger.kernel.org>
To: Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Dec 09 10:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9z6X-0000GZ-NS
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYLIJkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbYLIJkq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:40:46 -0500
Received: from mx0.slide.com ([208.76.68.7]:48501 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYLIJkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=W
	qryX7r/eyHEf/whJjQs3lQ5XmlSqi05YCPMX+6g9oU=; b=iQzTzdpHTSbQU41nx
	nd97kG5u63JzhKnsV4rZ/DeGHQS9c2svLgLYyvjiKUOyc8EACA2nosGOjYW0uU/0
	L6gS0TKjQWs/V721HPLKEjye5jfaZHtTIho8/QTpKSuLLTqZR7UfJLpp2eYFNwEp
	pELWx4u4kZJ6JhhIBIU/3NVFXs=
Received: from nat3.slide.com ([208.76.69.126]:49876 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1L9yU1-00037P-Kv; Tue, 09 Dec 2008 01:02:21 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 9707EA6F0002;
	Tue,  9 Dec 2008 01:02:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.159
X-Spam-Level: 
X-Spam-Status: No, score=-3.159 tagged_above=-10 required=6.6
	tests=[AWL=-0.660, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YHF6P8ModiO; Tue,  9 Dec 2008 01:02:21 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 1CC48A6F0001;
	Tue,  9 Dec 2008 01:02:21 -0800 (PST)
In-Reply-To: <20081209093627.77039a1f@perceptron>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102614>


--=-L77nzp0zWQHRTddpjw3n
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 09:36 +0100, Jan Kr=C3=BCger wrote:
> For fixing a corrupted repository by using backup copies of individual
> files, allow write_sha1_file() to write loose files even if the object
> already exists in a pack file, but only if the existing entry is marked
> as corrupted.
>=20
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
>=20
> On IRC I talked to rtyler who had a corrupted pack file and plenty of
> object backups by way of cloned repositories. We decided to try
> extracting the corrupted objects from the other object database and
> injecting them into the broken repo as loose objects, but this failed
> because sha1_write_file() refuses to write loose objects that are
> already present in a pack file.

Figured I'd chime in here with some anecdotal evidence with the error
condition that I hit shortly after Jan sent the email.

        xdev3 (master-release)% git pull --no-ff . master
        From .
         * branch            master     -> FETCH_HEAD
        error: failed to read object
        befd9bc4d184b4383569909e4d245f3337c1f8ed at offset 1415784644
        from .git/objects/pack/pack-f7eb06e39f01b528c1d1a2c413ac51b31b8515a=
a.pack
        fatal: object befd9bc4d184b4383569909e4d245f3337c1f8ed is
        corrupted
        Merge with strategy recursive failed.
        xdev3 (master-release)%

I ran that command a couple of times to make sure it wasn't a fluke, I
repeated the error numerous times (without switching branches or pulling
from a remote). This pull was done with a slightly modified internal
version of v1.6.0.4
        xdev3 (master-release)% git --version
        git version 1.6.0.4-kb1
        xdev3 (master-release)
       =20

After consulting with Jan, I tried running the same command with a
modified version of v1.6.0.5 with Jan's patch
        xdev3 (master-release)% ~/basket/bin/git pull --no-ff . master
        From .
         * branch            master     -> FETCH_HEAD
        Merge made by recursive.
         ** TOP SECRET MERGES! ;) **
       =20
         13 files changed, 51 insertions(+), 21 deletions(-)
        xdev3 (master-release)%
       =20
       =20
Purely anecdotal as I'm not entirely clear what the hell is actually going =
on here :)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-L77nzp0zWQHRTddpjw3n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+NBsACgkQFCbH3D9R4W/1CwCeLFbJBW/7PH7RpnjllkQzQjV0
n+QAnR+hIFbwD1ryHxMct3qxwSooHZEe
=ZC2Q
-----END PGP SIGNATURE-----

--=-L77nzp0zWQHRTddpjw3n--
