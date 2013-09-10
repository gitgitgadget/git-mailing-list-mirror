From: Ximin Luo <infinity0@gmx.com>
Subject: push.default=upstream doesn't play nicely with remote.pushdefault/branch.*.pushremote
Date: Tue, 10 Sep 2013 14:10:57 +0100
Message-ID: <522F1A61.3010805@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2QHVERMXHNMUIFDHJUHVO"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 15:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJNil-0005dn-N4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 15:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab3IJNLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 09:11:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:53658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3IJNLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 09:11:00 -0400
Received: from [192.168.1.101] ([86.164.40.57]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MDW9x-1VBQAJ1ZNd-00Goql for <git@vger.kernel.org>;
 Tue, 10 Sep 2013 15:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130821 Icedove/17.0.8
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:8W0QDwG26gU0R39jaXadynWA1u1G+LP4iL85LuUQaZg26xGgJBS
 P5D/HkLMXPmuj3/mdyatnSuVP0HI4fzyS8ScAU8/RtV4pm9dNeQmC61x0tYUSO5GCpPgF1G
 HbJjCbl3kk03Rfu9RvteRiN1ZB8inHFRx6Hv0yPma9G6M/lNUFA6rOCJ4TyiSLUO+OonjlL
 +NJ9rkg5NQP4MA2a9nrsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234433>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QHVERMXHNMUIFDHJUHVO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

(Please CC me as I am not subscribed.)

$ git config -l | grep '^branch.master\|^push.'
push.default=3Dupstream
branch.master.remote=3Dupstream
branch.master.merge=3Drefs/heads/master
branch.master.pushremote=3Dorigin

$ git branch
* master

$ git push
fatal: You are pushing to remote 'origin', which is not the upstream of
your current branch 'master', without telling me what to push
to update which remote branch.

push.default=3Dupstream means "push back where it came from (*)". However=
, if I specifically define remote.pushdefault or branch.*.pushremote, thi=
s clearly means I don't want to do (*) in this case.

The question here then is, what remote branch should git push to - since =
pushremote only specifies a repo? I can suggest two options:

- A: push to branch.*.merge if it's defined; otherwise push to <current b=
ranch> (like push.default=3Dcurrent)
- B: push to <current branch> regardless

B is probably simpler and means you can amend the push.default manual ent=
ry more easily:

upstream: [..] This mode only makes sense if you are pushing to the same =
repository you would normally pull from (i.e. central workflow). <INS>If =
you are not pushing to the same repository, acts as "current".</INS>

(Note again; that this is a special case when push.default=3Dupstream bec=
ause of the "this mode only makes sense" semantics. The other values for =
push.default are simpler and do not result in a conflict.)

Alternatively, an even more simple behaviour is to adjust the error messa=
ge to communicate the root cause:

$ git push
fatal: branch.*.pushremote is not compatible with push.default =3D upstre=
am

X

--=20
GPG: 4096R/1318EFAC5FBBDBCE
git://github.com/infinity0/pubkeys.git


------enig2QHVERMXHNMUIFDHJUHVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iQIcBAEBCAAGBQJSLxphAAoJEIYN7zuPZQt5Fn8QAKfgRH5crhKfrPXW9g9PHOaW
DFtQ4HmLrzK6yVFCiOEv0lkzNZzQ/o+9eFI9X1wivqOVX21dbqy4ZVWkDVX5nnit
D3GrQ5Pm1/O4tmo1oj6puZ6GOlijH97+9vur8UA4L37sXxMwqahelrYDe84L0042
zRU074Tvo4rUx3KDanmqv0NSqZbiLz54HWRCrwnqV4lUCWCCh04UxoffB1dB0poX
dLxt9LDU+Q3mDCpAi4SfR9BIZWrRySwPArf211/0mA9eDNvF36/mFWu1fuAALvUz
pwA82gGEn5DRK44P5FnNMqEr3lz3yMTGyxVwANFL0lbkFcpKU9xDZq5SZCIHTcKS
+ztdqGTCT3Dl4SyzqXin/7FT8LwNlrhz1TLLOKTJZKOl+CTKgr8rFogBoNSY8SpC
4Rx/kNOjBTLcaDYBaDLld9HupbzJzieK4f2H99Y9sRvnqJ+ybIEbu2GnYUDP/iXu
ULFd2ZP5ir8tdm3zjy094kUV0WTt1l74twQUzaar1aMa/4h31eAkgwZF/Kuw5v8P
0xG3QQ3mHLQeJfjnRBBKZBP/M5+agZTQ/q6R5ID68nf3MlOO3mbK5Wtw91h9DIiv
W31BSsW8jb7gFSWWWXrf3zmd5rbkoswcf3XxK/T3b0CXu3dYePGQfXj+kGc7O1sG
fszmWRvG5ENUbkT7qG+c
=r59w
-----END PGP SIGNATURE-----

------enig2QHVERMXHNMUIFDHJUHVO--
