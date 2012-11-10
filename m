From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Workflow for templates?
Date: Sat, 10 Nov 2012 08:27:10 +0100 (CET)
Message-ID: <f3537815-e1ea-4242-ac49-9d5a1e4f0511@zcs>
References: <509A863B.4090805@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 08:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX5XS-0005qk-GU
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 08:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab2KJH1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 02:27:13 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:15787 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2KJH1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 02:27:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 96D4E622260;
	Sat, 10 Nov 2012 08:27:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZJDo4ELcZh6; Sat, 10 Nov 2012 08:27:10 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id D7862622259;
	Sat, 10 Nov 2012 08:27:10 +0100 (CET)
In-Reply-To: <509A863B.4090805@ira.uka.de>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209259>


> Let me ask a different question: What is wrong with cherry-picking
> downstream changes to your upstream branch? Without rebasing it to
> downstream.

Naah, dont rebase the upstream ontop of downstream - this doenst make
any sense (yeah, my devs sometimes doing exatly this wong ;-o).

Instead, as you just said, cherry-pick the good commits into your
upstream branch and rebase your downstreams ontop of that. (doesnt
make any difference if this is done by different people or in different
administrative domains).

> That might mean there is a rather useless merge downstream later on,
> but that's the price you pay for not doing the change in a developmen=
t
> branch.

That's one of the things rebase is for: not having your history filled
up with merges at all, but always have your local cutomizations added
ontop of the current upstream.

By the way: I'm also using this hierachy for package maintenance to
different target distros:

   upstream branch
         |
         |----> upstream release tag X.Y.Z
         |
        \ /
   bugfix branch (maint-X-Y-Z) =3D> general (eg. distro-agnostig) fixes=
 go here
         |
         |-----> maintenance release tag X.Y.Z.A
         |
        \ /
   dist branch (mydist-X-Y-Z) =3D> distro-specific customizations (eg.
         |                       packaging control files, etc) go here
         |------> dist package release tags X.Y.Z.A-B


Usually I do quick hotfixes in the dist branch (and assigning new dist =
version number),
then copy the dist branch into some topic-branch, rebase into latest bu=
gfix branch,
cherry-pick the interesting commit(s) into the bugfix branch. When I do=
 a new bugfix
release (from by bugfix branch), I rebase the dist branch ontop the lat=
est bugfix
release tag, fix dist-package version numbers and run the dist-specific=
 build and=20
testing pipeline.

Here's some example for it: https://github.com/vnc-biz/redmine-core


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
