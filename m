From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: git-cvsimport gets parents wrong for branches
Date: Mon, 3 Jul 2006 23:53:03 +0200
Message-ID: <20060703215303.GA24572@memak.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
X-From: git-owner@vger.kernel.org Mon Jul 03 23:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxWLu-0002ds-JI
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGCVxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGCVxH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:53:07 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de ([130.83.48.97]:54471
	"EHLO baerbel.mug.maschinenbau.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S1750991AbWGCVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 17:53:06 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de (localhost [127.0.0.1])
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4) with ESMTP id k63Lr3CS024890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 3 Jul 2006 23:53:04 +0200
Received: (from tacke@localhost)
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4/Submit) id k63Lr3cL024888
	for git@vger.kernel.org; Mon, 3 Jul 2006 23:53:03 +0200
To: git@vger.kernel.org
Mail-Followup-To: Elrond <elrond+kernel.org@samba-tng.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: ClamAV 0.88.2/1581/Mon Jul  3 20:43:12 2006 on baerbel.mug.maschinenbau.tu-darmstadt.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23218>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Just by accident I noticed, that git-cvsimport got the
parents for branches wrong in one of my projects.

To assist in debugging this, I've made up a testcase script
(appended to this mail).
It will create a new cvs-repo, put 4 commits in it,
and finally run gitk to investigate it.

It should look something like this:

    4 [branch-stable-fixes] commit-on-branch
  3 | [master] [origin] commit-master-after-branch
  |/
  2   [tag-branchpoint] commit-first-edit
  1   commit-base

What it really looks like:

  4   ..
  3   ..
  2   ..
  1   ..

4's parent is 3, not (as it should) 2.


I've tested with 1.4.0 and the current git-cvsimport from
8fced61.

I hope the testcase helps tracking the problem down.


    Elrond

p.s.: The testcase script is not nice. It just does the
      job, nothing more.

--huq684BweRXVnRxX
Content-Type: application/x-sh
Content-Disposition: inline; filename="cvs-branches-1.sh"
Content-Transfer-Encoding: quoted-printable

#! /bin/sh=0Amkdir t-$$=0Acd t-$$=0Abase=3D$PWD=0Amkdir $base/cvs-repos=0Ae=
xport CVSROOT=3D$base/cvs-repos=0Acvs init=0Amkdir $CVSROOT/module-1=0Acvs =
co module-1=0Acd module-1=0Atouch file-1=0Acvs add file-1=0Asleep 2 ; cvs c=
ommit -m commit-base=0Aecho first edit > file-1=0Asleep 2 ; cvs commit -m c=
ommit-first-edit=0Acvs tag tag-branchpoint=0Aecho edit in head/trunk/master=
 > file-1=0Asleep 2 ; cvs commit -m commit-master-after-branch=0Acvs tag -b=
 -rtag-branchpoint branch-stable-fixes=0Acvs update -rbranch-stable-fixes=
=0Aecho new on branch >file-1=0Asleep 2 ; cvs commit -m commit-on-branch=0A=
cd ..=0Amkdir git-module-1=0Acd git-module-1=0Agit-cvsimport -v -d $CVSROOT=
 -i -k module-1=0Agitk branch-stable-fixes=0A
--huq684BweRXVnRxX--
