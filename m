From: Pawel Sikora <pluto@agmk.net>
Subject: why git-svn dcommit recreates master branch?
Date: Wed, 11 Jan 2012 17:27:05 +0100
Message-ID: <2397908.s01vAlxMN3@pawels>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3699239.WlzPcTyIkB"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 17:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl1Qj-0000lN-6x
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 17:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab2AKQxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 11:53:36 -0500
Received: from krak.alatek.krakow.pl ([46.170.108.42]:1783 "EHLO
	krak.alatek.krakow.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab2AKQxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 11:53:35 -0500
X-Greylist: delayed 1585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jan 2012 11:53:35 EST
Received: from pawels.localnet (pawels.alatek.krakow.pl [10.0.2.35])
	by krak.alatek.krakow.pl (Postfix) with ESMTP id 14DCF6A442
	for <git@vger.kernel.org>; Wed, 11 Jan 2012 17:21:20 +0000 (Europe/Warsaw)
User-Agent: KMail/4.7.4 (Linux/3.0.16-1; KDE/4.7.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188375>


--nextPart3699239.WlzPcTyIkB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

i'm wondering why the git-svn-dcommit recreates a master branch in my r=
epo.
is it a bug or feature and master is required to cooperate with subvers=
ion?
please look at attached test.sh:


$ ./test.sh

Checked out revision 0.

A         file.txt
Adding         file.txt
Transmitting file data .
Committed revision 1.

Initialized empty Git repository in /home/users/pawels/bugs/git-svn-mas=
ter-issue/repo.git/.git/
        A       file.txt
r1 =3D 464dbae76d675c8c4bdc715e34ebe46691b8bfa2 (refs/remotes/git-svn)
Checked out HEAD:
  file:///home/users/pawels/bugs/git-svn-master-issue/repo.svn r1

branches before dcommit:
* bridge
  remotes/git-svn

[bridge ffffc26] bar
 1 files changed, 1 insertions(+), 0 deletions(-)
Committing to file:///home/users/pawels/bugs/git-svn-master-issue/repo.=
svn ...
        M       file.txt
Committed r2
        M       file.txt
r2 =3D d98723bccdcf673790b55d47a4f345c694a68ced (refs/remotes/git-svn)
No changes between current HEAD and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn

branches after dcommit:
* bridge
  master
  remotes/git-svn


could some one put some light on this?

BR,
Pawe=C5=82.

please CC me on reply.
--nextPart3699239.WlzPcTyIkB
Content-Disposition: inline; filename="test.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="test.sh"

#!/bin/sh

#set -x
export LANG=C
here="$(readlink -m $(pwd))"

rm -rf repo.svn repo.svn.wc repo.git

svnadmin create repo.svn
svn co file:///${here}/repo.svn repo.svn.wc

cd repo.svn.wc
echo foo >file.txt 
svn add file.txt
svn ci file.txt -m 'foo'
cd ..

git svn clone file:///${here}/repo.svn repo.git
cd repo.git
git branch -m bridge

echo "branches before dcommit:"
git branch -a

echo bar >>file.txt
git commit -a -m 'bar'
git svn dcommit

echo "branches after dcommit:"
git branch -a

--nextPart3699239.WlzPcTyIkB--
