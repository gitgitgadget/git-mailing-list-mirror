From: martin f krafft <madduck@madduck.net>
Subject: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 15:26:32 +0200
Message-ID: <20070915132632.GA31610@piper.oerlikon.madduck.net>
References: <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: "Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 15:26:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWXfj-0005m8-0G
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 15:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXION0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 09:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXION0v
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 09:26:51 -0400
Received: from clegg.madduck.net ([82.197.162.59]:56343 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbXION0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 09:26:50 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 1D684BA3A3;
	Sat, 15 Sep 2007 15:26:33 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 8D1219F161;
	Sat, 15 Sep 2007 15:26:32 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 52E23B3106; Sat, 15 Sep 2007 15:26:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de> <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4278/Sat Sep 15 12:40:46 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58241>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Thomas Harning Jr. <harningt@gmail.com> [2007.09.14.1931 +0200]:
> > No, and I did not look anywhere, but I know of no other VCS that can
> > adequatly track permissions.
> Has anyone checked out metastore?  http://repo.or.cz/w/metastore.git
> ... there's an XML error in there somewhere, so its not loading the
> 'main' page, but http://repo.or.cz/w/metastore.git?a=3Dshortlog should
> work.

This looks interesting, though I guess getfacl/setfacl and
getfattr/setfattr can pretty much do the same job, especially if you
can call them from shell scripts/hooks (except for mtime). Or did
I misunderstand something?

The problem with metdata getting corrupted, which Nicolas reported,
may well have to do with the use of a single file. It may be worth
to consider using a shadow hierarchy of files, each containing the
metadata, e.g. for a project with foo, and bar/foo and bar/baz
files, you might have

  .metastore/foo
  .metastore/bar/.<uniqueid>.dir
  .metastore/bar/foo
  .metastore/bar/baz

and each file could just be an rfc822-style file:

  Owner: root
  Group: root
  Mode: 4754
  Mtime: 1234567890
  Fattr-<key1>: <value1>
  Fattr-<key2>: <value2>

This would be my approach, which should probably be a little better
at preventing corruption.

Anyway, this *really* should go into git itself!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"i like wagner's music better than anybody's. it is so loud that one
 can talk the whole time without other people hearing what one says."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG692IIgvIgzMMSnURAjTBAJ4sAHMIwEW0a19ryXb3JA3cGLOyVACgzUxA
peN5H8IROngt1xZ1A167TmA=
=qEa5
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
