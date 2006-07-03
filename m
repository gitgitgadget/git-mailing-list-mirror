From: Keith Packard <keithp@keithp.com>
Subject: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 11:02:44 -0700
Message-ID: <1151949764.4723.51.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Pu54426/ZiekQRABAw7Z"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Tue Jul 04 00:56:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxXKr-0004mv-Am
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 00:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWGCW4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGCW4G
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 18:56:06 -0400
Received: from home.keithp.com ([63.227.221.253]:25605 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751178AbWGCW4E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 18:56:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A238413001F;
	Mon,  3 Jul 2006 15:56:03 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2wCNABBJZSzj; Mon,  3 Jul 2006 15:56:02 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id C6D86138097; Mon,  3 Jul 2006 11:02:46 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8843D14002;
	Mon,  3 Jul 2006 11:02:46 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 5F718542A7; Mon,  3 Jul 2006 11:02:44 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23222>


--=-Pu54426/ZiekQRABAw7Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, so maybe X.org is using git in an unexpected (or even wrong)
fashion. Our environment has split development across dozens of separate
repositories which match ABI interfaces. With CVS, we were able to keep
this all in one giant CVS repository with separate modules, but git
doesn't have that notion (which is mostly good). As such, we could use
cvsup or rsync to update the entire collection of modules.

With git, we'd prefer to use the git protocol instead of rsync for the
usual pack-related reasons, but that is limited to a single repository
at a time. And, it's painfully slow, even when the repository is up to
date:

$ cd lib/libXrandr
$ time git-fetch origin
...

real    0m17.035s
user    0m2.584s
sys     0m0.576s

This is a repository with 24 files and perhaps 50 revisions. Given
X.org's 307 git repositories, I'll clearly need to find a faster way
than running git-fetch on every one.

One thing I noticed was that the git+ssh syntax found in remotes files
doesn't do what I thought it did -- I assumed this would use 'git' for
fetch and 'ssh' for push, when in fact it just uses ssh for everything.
This slows down the connection process by several seconds.

--=20
keith.packard@intel.com

--=-Pu54426/ZiekQRABAw7Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqVvEQp8BWwlsTdMRAiHhAKDeRrdubiWBliUHCCmgpddWBRe2zwCgnbun
iVcf5Io0LqWkNIrULq40iD4=
=FXYi
-----END PGP SIGNATURE-----

--=-Pu54426/ZiekQRABAw7Z--
