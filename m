From: Bart Trojanowski <bart@jukie.net>
Subject: git push problem with v1.5.0-rc1
Date: Thu, 18 Jan 2007 16:26:15 -0500
Message-ID: <20070118212615.GO8624@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QmMh2VKaunwcDwPx"
X-From: git-owner@vger.kernel.org Thu Jan 18 22:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7fDt-0001pu-8q
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 22:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbXARVzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 16:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbXARVzA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 16:55:00 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:57216 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932472AbXARVy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 16:54:59 -0500
X-Greylist: delayed 1719 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 16:54:58 EST
Received: from tau.jukie.net ([10.10.10.211]:39579)
	by jukie.net with esmtp (Exim 4.50)
	id 1H7em0-0005Yc-0S
	for git@vger.kernel.org; Thu, 18 Jan 2007 16:26:16 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 70CBB2DC0BD; Thu, 18 Jan 2007 16:26:15 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37141>


--QmMh2VKaunwcDwPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just stared using 1.5.0-rc yesterday, and ran into a problem with
git-push.

I am running vanilla 2.6.19 on amd64 SMP box.  For this project I am
working in a 32bit chroot -- the 64/32bit setup is part of the problem.

There are 3 repositories involved here:

linux-2.6.git     =20
    - clone of a few branches from kernel.org

klips-vault.git
    - linux tree from project upstream
    - alternates =3D /.../linux-2.6.git/.git/objects

working dir:
    - clone of klips-vault.git
    - alternates =3D /.../klips-vault.git/.git/objects

    - I made a new branch
    - applied ~100 patches

    - went to push and...

      $ git version=20
      git version 1.5.0.rc1.gdf1b=20
      =20
      $ cat .git/config=20
      [core]=20
              repositoryformatversion =3D 0=20
              filemode =3D true=20
              logallrefupdates =3D true=20
      [remote "origin"]=20
              url =3D /home/jukie/bart/work/xelerance/klips-vault.git/.git=
=20
              fetch =3D +refs/heads/*:refs/remotes/origin/*=20
              push =3D refs/heads/my-ocf+fsm_v2.6.18:refs/heads/my-ocf+fsm_=
v2.6.18=20
      [branch "master"]=20
              remote =3D origin=20
              merge =3D refs/heads/master=20
      =20
      $ git branch=20
        master=20
      * my-ocf+fsm_v2.6.18=20
      =20
      $ git push origin=20
      updating 'refs/heads/my-ocf+fsm_v2.6.18'=20
        from 0000000000000000000000000000000000000000=20
        to   380541e91358d7a5e2fe37c81c520c92a3094951=20
      Generating pack...=20
      Done counting 727 objects.=20
      Result has 708 objects.=20
      Deltifying 708 objects.=20
       100% (708/708) done=20
      Writing 708 objects.=20
       100% (708/708) done=20
      Total 708 (delta 535), reused 275 (delta 218)=20
      fatal: cannot fstat packfile: Value too large for defined data type=
=20
      unpack index-pack exited with error code=20
      ng refs/heads/my-ocf+fsm_v2.6.18 n/a (unpacker error)=20

There was some question as to why fstat fails in the chroot... I don't
have any 2TB pack files.  The above repos are relatively small.  All
=2Egit directories sum up to about 500M.

I got some help from Shawn Pearce on #git.  He told me to set the
[receive] unpackLimit=3D5000 in .git/config on the remote.  That did
work, and I could push.

The conclusion was that my "chroot is broken".  It's Ubuntu, so it
should Just Work(TM) :D

I have tested a few configurations:

git 1.4.4.4                       - push OK
git 1.4.4.4 w/unpackLimit=3D100     - push fails

git 1.5.0-rc0                     - push fails
git 1.5.0-rc1                     - push fails
git 1.5.0-rc1 w/unpackLimit=3D5000  - push OK

I am not sure why 1.4.4.4 works w/o limit changes.

I will try not to touch anything for a while, and would be glad to help
further if I can.

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--QmMh2VKaunwcDwPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFr+X3/zRZ1SKJaI8RAgLgAKCzdNcioMK3kdSn1ODZarVOimjB8ACeKVNm
IkeSP41nFRlyGfyYbcsVm8k=
=/tW7
-----END PGP SIGNATURE-----

--QmMh2VKaunwcDwPx--
