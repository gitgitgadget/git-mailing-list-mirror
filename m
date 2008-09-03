From: Kai Blin <kai@samba.org>
Subject: Directory renames without breaking git log.
Date: Wed, 3 Sep 2008 23:38:28 +0200
Message-ID: <200809032338.35359.kai@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38146153.M9GXFv20Po";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 00:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0RX-0003Hk-OI
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbYICWCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 18:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYICWCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:02:09 -0400
Received: from mail.samba.org ([66.70.73.150]:35584 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbYICWCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:02:08 -0400
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Sep 2008 18:02:08 EDT
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id 36C9E163921
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 21:38:32 +0000 (GMT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94861>

--nextPart38146153.M9GXFv20Po
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

in an effort to make Samba development easier, we're trying to merge the=20
Samba3 and Samba4 branches into a single branch. In order to do so, we need=
=20
to rename the "source" directories both Samba 3 and Samba 4 have (we're=20
planning to use source3 and source4).

Unfortunately, the directories are big enough that git log stops to track t=
he=20
renamed files, so e.g. git log ./samba3 does not show the samba3 history. T=
he=20
history is not lost, of course, but it's way less intuitive to get it.

Here's how we merged the two branches:

$ mkdir samba-merged
$ cd samba-merged
$ git init
=2E.. (create COPYING, README and other top-level files, git add them)
$ git commit -m "Initial commit of merged samba"
$ git remote add git://git.samba.org/samba.git samba
$ git remote update
$ cp -a ~/samba3/source source3
$ cp -a ~/samba4/source source4
$ git add source3 source4
$ git write-tree
$ echo "merge branches" | git commit-tree <sha1 git write-tree retured> \
      -p <sha1 of the initial commit> \
      -p <sha1 of the current samba3 head> \
      -p <sha1 of the current samba4 head>
$ git reset --hard <sha1 returned by git commit-tree>
$ git log
=2E.. history is there as expected
$ git log samba3
=2E.. history is just the merge commit
$ git log samba4
=2E.. history is just the merge commit

Is there any way to fix this that doesn't involve changing the history with=
=20
git-filter-branch?

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart38146153.M9GXFv20Po
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIvwPbEKXX/bF2FpQRAhRtAKCKQ2bX18rcsaP7akxoldtAKGJQewCfYk2T
XSlrPfKVyfLTcJ3EAXQ0TTM=
=RZ82
-----END PGP SIGNATURE-----

--nextPart38146153.M9GXFv20Po--
