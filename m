From: Keith Packard <keithp@keithp.com>
Subject: rebase from ambiguous ref discards changes
Date: Thu, 06 Sep 2007 14:48:28 -0700
Message-ID: <1189115308.30308.9.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2SO4dfltkxowG92yH9Sb"
Cc: keithp@keithp.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPOX-0003RL-NV
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbXIFWAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbXIFWAH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:00:07 -0400
Received: from home.keithp.com ([63.227.221.253]:2700 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489AbXIFWAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 18:00:05 -0400
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2007 18:00:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 355401141EA
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 14:49:01 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jUUVQnVl52aN; Thu,  6 Sep 2007 14:48:58 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 66D161141E6; Thu,  6 Sep 2007 14:48:58 -0700 (PDT)
Received: from koto.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id D25DB1141E0;
	Thu,  6 Sep 2007 14:48:57 -0700 (PDT)
Received: by koto.keithp.com (Postfix, from userid 1488)
	id 9B3CE76C187; Thu,  6 Sep 2007 14:48:28 -0700 (PDT)
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57934>


--=-2SO4dfltkxowG92yH9Sb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So, I started with a very simple repository

---*--- master
    \
     -- origin/master

=46rom master, I did

$ git-rebase origin/master
warning: refname 'master' is ambiguous.
First, rewinding head to replay your work on top of it...
HEAD is now at 2a8592f... Fix G33 GTT stolen mem range
Fast-forwarded master to origin/master.
$

Note the lack of the usual 'Applying <patch>' messages.

checking the tree, I now had

---*
    \
     -- origin/master
        master

with my patch lost.

recovering my patch (having the ID in my terminal window from the
commit), I named it 'master-with-fix'

---*--- master-with-fix
    \
     -- origin/master
        master

Now the rebase from 'master-with-fix worked as expected:

$ git-rebase origin/master
First, rewinding head to replay your work on top of it...
HEAD is now at 2a8592f... Fix G33 GTT stolen mem range

Applying Switch to pci_device_map_range/pci_device_unmap_range APIs.

Adds trailing whitespace.
.dotest/patch:225:     =20
Adds trailing whitespace.
.dotest/patch:226:      if (IS_I965G(pI830))=20
Adds trailing whitespace.
.dotest/patch:446:
dev->regions[mmio_bar].size,=20
Adds trailing whitespace.
.dotest/patch:449:   =20
warning: 4 lines add whitespace errors.
Wrote tree cd373666254d56a137d282deeb15a2ccaf8da22b
Committed: 286f5df0b62f571cbb4dbf120679d3af029b8775
$=20

And the tree looks right too:

--- origin/master --- master-with-fix
    master
      =20
Seems like there's something going on when 'master' is ambiguous, or
perhaps some other problem.

This is all from version 1.5.3, but I think I've seen this on 1.5.2 as
well.

Git made me sad today; I'm not sure it's ever disappointed like this
before.

--=20
keith.packard@intel.com

--=-2SO4dfltkxowG92yH9Sb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4HWsQp8BWwlsTdMRAhskAKCvEvKNpglTfhLOOMnp0W0oqlDhmwCfUX0Z
WRD/8tcuat3iNz6hINxOCus=
=WItP
-----END PGP SIGNATURE-----

--=-2SO4dfltkxowG92yH9Sb--
