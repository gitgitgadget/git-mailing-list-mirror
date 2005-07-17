From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 12:57:59 +0400
Message-ID: <200507171257.59384.snake@penza-gsm.ru>
References: <20050717084053.94D603525D1@atlas.denx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X2h2CtYsYP8KbBY"
X-From: git-owner@vger.kernel.org Sun Jul 17 10:59:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4zR-0006Be-I5
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVGQI64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGQI64
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:58:56 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:55997
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261227AbVGQI6D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:58:03 -0400
Received: (qmail 5224 invoked from network); 17 Jul 2005 08:58:02 -0000
Received: from unknown (HELO snake-modem.penza-gsm.ru) (192.168.5.2)
  by fileserver.penza-gsm.ru with SMTP; 17 Jul 2005 08:58:00 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20050717084053.94D603525D1@atlas.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_X2h2CtYsYP8KbBY
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=F7 =D3=CF=CF=C2=DD=C5=CE=C9=C9 =CF=D4 =F7=CF=D3=CB=D2=C5=D3=C5=CE=D8=C5 17=
 =E9=C0=CC=D8 2005 12:40 Wolfgang Denk =CE=C1=D0=C9=D3=C1=CC(a):
> Is there a way to make "git cvsimport" create branches in git for any
> branches it encounters in the CVS repository?
Heh. I was just preparing mail about the same problem.
It seems that git-cvsimport-script really don't likes branches in CVS.
I have attached simple script that demonstrates this.
On my machine it gives:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
snake@home2:/tmp$ ./testscript
cvs checkout: Updating project
cvs add: scheduling file `a' for addition
cvs add: use `cvs commit' to add this file permanently
/tmp/20050717125452/cvsroot/project/a,v  <--  a
initial revision: 1.1
cvs tag: Tagging .
T a
/tmp/20050717125452/cvsroot/project/a,v  <--  a
new revision: 1.2; previous revision: 1.1
cvs update: Updating .
U a
/tmp/20050717125452/cvsroot/project/a,v  <--  a
new revision: 1.1.2.1; previous revision: 1.1
cvs rlog: Logging project
New a: 2 bytes.
Tree ID 2ce1eef76631e82282e0f7f0cf9e6f3e9a4a0b1e
Committed patch 1 (origin)
Committing initial tree 2ce1eef76631e82282e0f7f0cf9e6f3e9a4a0b1e
Commit ID f7030e1c361f94b8847ef6ad88248a675c7ce5a9
Update a: 4 bytes.
Tree ID 9d3d025fff2e43c6a7b837056632b436c8e31dfe
Parent ID f7030e1c361f94b8847ef6ad88248a675c7ce5a9
Committed patch 2 (origin)
Commit ID 67889434ca9623ad91f8e81e6143fed9c4115a86
Switching from origin to branch1
usage: git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])
read-tree failed: 256
snake@home2:/tmp$
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Is it a planned behaivoir or cvsimport script were just recently broken?

=2D-=20
Respectfully
Alexey Nezhdanov

--Boundary-00=_X2h2CtYsYP8KbBY
Content-Type: text/plain;
  charset="koi8-r";
  name="testscript"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="testscript"

#!/bin/sh
dirname=`date +"%Y%m%d%H%M%S"`
mkdir /tmp/$dirname
cd /tmp/$dirname
mkdir cvsroot
declare -x CVSROOT=/tmp/$dirname/cvsroot
cvs init
mkdir cvsroot/project
cvs co project
cd project
echo 1 >a
cvs add a
cvs ci -m 1 a
cvs tag -b branch1
echo 2 >>a
cvs ci -m 2 a
cvs update -r branch1
echo 3 >>a
cvs ci -m 3 a
git-cvsimport-script -v

--Boundary-00=_X2h2CtYsYP8KbBY--
