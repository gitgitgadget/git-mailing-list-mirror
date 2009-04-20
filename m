From: martin f krafft <madduck@madduck.net>
Subject: reviving a git-svn clone
Date: Mon, 20 Apr 2009 12:43:16 +0200
Message-ID: <20090420104316.GA11433@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvqzk-0003TI-BB
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbZDTKn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbZDTKn0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:43:26 -0400
Received: from clegg.madduck.net ([193.242.105.96]:53989 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbZDTKnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:43:25 -0400
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:41e0:ff7c:0:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7E7F41D40A0
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 12:43:17 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 3B3F08080; Mon, 20 Apr 2009 12:43:16 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.28-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9259/Mon Apr 20 11:40:36 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116964>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello folks,

The hibernate-script is maintained in SVN, but we've long tracked it
with Git at git://git.debian.org/git/collab-maint/hibernate.git .

Unfortunately, I seem to have lost the repository I always used to
git-svn-rebase and push new upstream commits to the repository on
git.debian.org.

I am now trying to revive the clone, but git-svn remains "unable to
determine the upstream SVN information from the working tree
history". This baffles me.

Here are my steps:


-8<--8<--8<-
alioth:~|master|% git clone /git/collab-maint/hibernate.git hibernate-svnsy=
nc
Initialized empty Git repository in /srv/alioth.debian.org/chroot/home/user=
s/madduck/hibernate-svnsync/.git/

alioth:~|master|% cd hibernate-svnsync

alioth:~/hibernate-svnsync|master|% git branch --no-track upstream origin/u=
pstream

alioth:~/hibernate-svnsync|master|% cat >> .git/config <<_eof
heredoc> [svn-remote "svn"]
heredoc>        url =3D svn+ssh://svn.suspend2.net/svn/hibernate-script
heredoc>        fetch =3D trunk:refs/remotes/upstream/trunk
heredoc>        branches =3D branches/*:refs/remotes/upstream/*
heredoc>        tags =3D tags/*:refs/remotes/upstream/tags/*
heredoc> _eof

alioth:~/hibernate-svnsync|master|% git checkout upstream

alioth:~/hibernate-svnsync|upstream|% git show HEAD | grep git-svn-id
    git-svn-id: svn+ssh://svn.suspend2.net/svn/hibernate-script/trunk@1195 =
c12ee44c-9ede-0310-94ea-d4716f4f7118

-8<--8<--8<-


So the repository is now cloned and the URL is the same as the one
in the HEAD commit message.

But when I try to rebase, I am told:



-8<--8<--8<-
alioth:~/hibernate-svnsync|master|% git svn rebase
Migrating from a git-svn v1 layout...
Data from a previous version of git-svn exists, but
        .git/svn
        (required for this version (1.5.6.5) of git-svn) does not exist.
Done migrating from a git-svn v1 layout
Unable to determine upstream SVN information from working tree history

-8<--8<--8<-
(I get the same result with Git 1.6.2.3)



I've spend a bit of time with the code, but I cannot figure out why
it has these hiccups. I think it's because git-svn needs a rev-map
file in
=2Egit/svn/upstream/trunk/.rev_map.c12ee44c-9ede-0310-94ea-d4716f4f7118,
which is now gone, but that file is now gone.

Does anyone know how I can revive the git-svn clone? I cannot just
reclone, or else all of the commit IDs in the public upstream branch
would be rewritten.

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"alle vorurteile kommen aus den eingeweiden."
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknsUcQACgkQIgvIgzMMSnU9XgCfccLu4E2RAv0v8wYEdcoHqTVs
5KIAoMizJefFjx/E+J/7Egjh/GeTJn0U
=QJIY
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
