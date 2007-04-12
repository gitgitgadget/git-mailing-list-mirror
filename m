From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Weird shallow-tree conversion state, and branches of shallow trees
Date: Wed, 11 Apr 2007 17:53:36 -0700
Message-ID: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnYw-0008Gl-KT
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbXDLAxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbXDLAxU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:53:20 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:43438 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753759AbXDLAxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:53:19 -0400
Received: (qmail 18832 invoked from network); 12 Apr 2007 00:53:18 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 12 Apr 2007 00:53:18 +0000
Received: (qmail 22854 invoked by uid 10000); 11 Apr 2007 17:53:36 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44298>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was doing some random tests with shallow trees, and ran into two
issues - the first is a shallow tree that doesn't extend anymore when it
should, and the second is some branched shallow tree trouble.

1.
(I was using the kernel.org Git repo for my testing here)
> git clone --depth 1 git://GIT-REMOTE-URL
> # do some local commits
> git pull --depth 1000000 # some very large number, to try and add all the=
 history

At this point, I noticed that my tree still seemed to be shallow, and no
matter what I tried, I couldn't un-shallow it.

=2Egit/shallow contained a single line:
> 9c405082d96ed7a7ed830f9861dbad9a32e4d268

And moving the shallow file out the way, fsck --full gets me:
> broken link from  commit 9c405082d96ed7a7ed830f9861dbad9a32e4d268
>               to  commit bb3e781d7f6259eb414cbecd8bad74cd4a188b41
> broken link from  commit 9c405082d96ed7a7ed830f9861dbad9a32e4d268
>               to  commit 9bfbe261923f4e9d89f65e6755fa6501aa6531b0
> missing commit bb3e781d7f6259eb414cbecd8bad74cd4a188b41
> missing commit 9bfbe261923f4e9d89f65e6755fa6501aa6531b0

Any ideas on why it's not going to full depth?
I don't have a reliable test case for this yet, sometimes it does go deep
properly, sometimes it doesn't.

2.
Again about shallow repos, a development problem I ran into.
> git clone --depth 1 git://GIT-REMOTE-URL
> git checkout -b working-branch
> # do various work, and git-commit the changes
> git checkout master=20
> git pull
> # some time goes by, and you want the latest upstream changes
> git checkout working-branch
> git pull . master

The last pull from the local master fails. This seems weird, because if
working-branch development is done on the master instead, the earlier pull
never complains. So in this case, the working-branch should be able to pull
=66rom the local master branch fine.

This bug basically stops people from being able to take a shallow clone of a
repository with a lot of history, and have multiple working branches on it.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGHYMQPpIsIjIzwiwRAjPwAJ0Y+QIUMNmqRebRPVdbf4PwntMjWQCfQ5AE
dLecSpJAgv5C9CghvknOjPg=
=HVE6
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
