From: Tomasz bla Fortuna <bla@thera.be>
Subject: Probably a GIT bug..
Date: Tue, 22 Apr 2008 16:43:11 +0200
Message-ID: <20080422164311.67c3d02b@Vorago>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/auB0i7MwGpAGcc5HU_nanbb";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 17:18:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoKF3-0006Lr-EO
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 17:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbYDVPQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 11:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbYDVPQW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 11:16:22 -0400
Received: from afdns.sownet.pl ([195.82.188.30]:50223 "EHLO af.gliwice.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbYDVPQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 11:16:19 -0400
X-Greylist: delayed 1974 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 11:16:19 EDT
Received: by af.gliwice.pl (Postfix, from userid 218)
	id 91634117763; Tue, 22 Apr 2008 16:43:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on thera.be
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=8.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from af.gliwice.pl (localhost [127.0.0.1])
	by af.gliwice.pl (Postfix) with ESMTP id F213E117727
	for <git@vger.kernel.org>; Tue, 22 Apr 2008 16:43:23 +0200 (CEST)
Received: from Vorago (Vorago [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by af.gliwice.pl (Postfix) with ESMTP id D66FD116F57
	for <git@vger.kernel.org>; Tue, 22 Apr 2008 16:43:23 +0200 (CEST)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80130>

--Sig_/auB0i7MwGpAGcc5HU_nanbb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

Testcase: http://temp.thera.be/gitbug.tar
Contents:
gitbug/
gitbug/prep.sh
gitbug/fail.sh
gitbug/init.sh
gitbug/README


#v+ init.sh

#!/bin/bash

export GIT_AUTHOR_EMAIL=3D'test@test.be'
export GIT_AUTHOR_NAME=3D'gitbug'
export GIT_AUTHOR_DATE=3D"Mon Apr 21 16:40:08 2008 +0200"
export GIT_COMMITTER_NAME=3D'gitbug'
export GIT_COMMITTER_EMAIL=3D'test@test.be'
export GIT_COMMITTER_DATE=3D"Mon Apr 21 16:40:08 2008 +0200"

rm -rf ./.git
rm -f test test2

git init
touch test
git add test
git commit -a -m "first commit"

## prep.sh:
#!/bin/bash
mkdir .git/objects/a2
chmod a-rwx .git/objects/a2=20

## fail.sh:
#!/bin/bash

touch test2
git add test2
git commit -a -m "second commit"

echo -en "\n\n\nSee the result of git-fsck:\n"=20
git-fsck

#v-

Execution:
#v+
[16:39:14] bla@Vorago ~/my_tmp/gitbug $ source init.sh=20
Initialized empty Git repository in .git/
Created initial commit 2231f53: first commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test
[16:39:16] bla@Vorago ~/my_tmp/gitbug $ source prep.sh=20
[16:39:17] bla@Vorago ~/my_tmp/gitbug $ source fail.sh=20
error: sha1
file /home/bla/my_tmp/gitbug/.git/objects/a2/2c62298732a162ab9aa64c31b24c4c=
87cf8cd9:
Permission denied

fatal: unable to read destination tree
(a12d0088c0e538480a1586a9ac2d5de3b54b2759) Created commit=20


See the result of git-fsck:
broken link from  commit a12d0088c0e538480a1586a9ac2d5de3b54b2759
              to    tree a22c62298732a162ab9aa64c31b24c4c87cf8cd9
missing tree a22c62298732a162ab9aa64c31b24c4c87cf8cd9
[16:39:19] bla@Vorago ~/my_tmp/gitbug $=20
#v-

As I understand such behaviour shouldn't have place; one can fix it by
fixing attributes and then doing git-reset+commit. Maybe with fsck also.

I guess that GIT should check if he can create a tree link before
creating a commit.

See you,
--=20
Tomasz bla Fortuna
jid: bla(at)af.gliwice.pl
pgp: 0x90746E79 @ pgp.mit.edu
www: http://bla.thera.be

--Sig_/auB0i7MwGpAGcc5HU_nanbb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkgN+YQACgkQT6wvGJB0bnm1MgCg5Wsue2eRFgp2angtHIVJXUYc
y2IAoJh4hsEVap4Qgs834tahiGa5JhNw
=Dwub
-----END PGP SIGNATURE-----

--Sig_/auB0i7MwGpAGcc5HU_nanbb--
