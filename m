From: Victor Porton <porton@narod.ru>
Subject: Bug report: stdout vs stderr
Date: Wed, 15 Jun 2016 15:19:42 +0300
Message-ID: <1465993182.24741.3.camel@narod.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 14:25:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD9sR-0004RV-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 14:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbcFOMYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 08:24:55 -0400
Received: from forward6o.cmail.yandex.net ([37.9.109.52]:39352 "EHLO
	forward6o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752685AbcFOMYy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 08:24:54 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jun 2016 08:24:54 EDT
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward6o.cmail.yandex.net (Yandex) with ESMTP id DF2CE21417
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 15:19:51 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 077271E3C06
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 15:19:49 +0300 (MSK)
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id olIWo5W4Bk-JmdGfs3N;
	Wed, 15 Jun 2016 15:19:49 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1465993189;
	bh=cJG74EDUVmyl7nIdYVGlbCL2zw48Y2WNOn0EHKMKJ0I=;
	h=Message-ID:Subject:From:To:Date:Content-Type:X-Mailer:
	 Mime-Version:Content-Transfer-Encoding;
	b=TxEDNKe0yMCOSx8N3GgnEm+q6+skMDyZX7ApnpKjUl/csAm3ZWS3eD+F37yvwrN5X
	 2CJg7u8nfPL79Bq0xYo8JgdLhYlDz++OpgLzdfH3UvpVCnVWaWzDaWPSKOJDL348iW
	 kffVAQ57LvkbKyixzv0bMOD3ecIBcMvwx4QCa6ik=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@narod.ru
X-Yandex-Suid-Status: 1 0
X-Mailer: Evolution 3.20.2-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297368>

Why half of Git output goes to stdout and half to stderr? I suspect
this is a bug.

Below I call `git pushbug` alias defined it the below presented config
file.

$ cat .git/config=C2=A0
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "origin"]
	url =3D git@bitbucket.org:portonv/algebraic-general-topology.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
	pushurl =3D git@github.com:vporton/algebraic-general-topology.git
	pushurl =3D git@bitbucket.org:portonv/algebraic-general-
topology.git
[gui]
	wmstate =3D normal
	geometry =3D 1680x957+0+27 189 177
[alias]
	pushbug =3D !git push && git checkout prerelease && git merge
master && git push && git checkout devel && git merge prerelease &&
git push && git checkout master
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master
[branch "prerelease"]
	remote =3D origin
	merge =3D refs/heads/prerelease
[branch "devel"]
	remote =3D origin
	merge =3D refs/heads/devel

$ git pushbug 1>$HOME/t/1.txt 2>$HOME/t/2.txt
$ cat ~/t/1.txt=C2=A0
Your branch is up-to-date with 'origin/prerelease'.
Updating ac492a4..c55d1b5
=46ast-forward
=C2=A0chap-sides.tex | 15 +++++++++++++--
=C2=A01 file changed, 13 insertions(+), 2 deletions(-)
Your branch is up-to-date with 'origin/devel'.
Updating ac492a4..c55d1b5
=46ast-forward
=C2=A0chap-sides.tex | 15 +++++++++++++--
=C2=A01 file changed, 13 insertions(+), 2 deletions(-)
Your branch is up-to-date with 'origin/master'.
$ cat ~/t/2.txt=C2=A0
To git@github.com:vporton/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0master -> master
To git@bitbucket.org:portonv/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0master -> master
Switched to branch 'prerelease'
To git@github.com:vporton/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0prerelease -> prerelease
remote:=C2=A0
remote: Create pull request for prerelease:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
remote:=C2=A0=C2=A0=C2=A0https://bitbucket.org/portonv/algebraic-genera=
l-topology/pull
-requests/new?source=3Dprerelease&t=3D1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
remote:=C2=A0
To git@bitbucket.org:portonv/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0prerelease -> prerelease
Switched to branch 'devel'
To git@github.com:vporton/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0devel -> devel
remote:=C2=A0
remote: Create pull request for devel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
remote:=C2=A0=C2=A0=C2=A0https://bitbucket.org/portonv/algebraic-genera=
l-topology/pull
-requests/new?source=3Ddevel&t=3D1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
remote:=C2=A0
To git@bitbucket.org:portonv/algebraic-general-topology.git
=C2=A0=C2=A0=C2=A0ac492a4..c55d1b5=C2=A0=C2=A0devel -> devel
Switched to branch 'master'
