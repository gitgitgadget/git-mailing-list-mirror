From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Strange git-show-branch behavior.
Date: Sat, 3 Nov 2007 19:22:24 +0100
Message-ID: <20071103182224.GA16345@atjola.homenet>
References: <871wb79q80.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoNef-0002H9-Tc
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 19:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152AbXKCSWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 14:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758136AbXKCSWa
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 14:22:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:51099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756269AbXKCSW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 14:22:28 -0400
Received: (qmail invoked by alias); 03 Nov 2007 18:22:25 -0000
Received: from i577BAA93.versanet.de (EHLO localhost) [87.123.170.147]
  by mail.gmx.net (mp056) with SMTP; 03 Nov 2007 19:22:25 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Zp3c3dJRZT/+zFpkoeTMwZV9rIezhv5RRexkgTk
	2d9bSwEId9d0PU
Content-Disposition: inline
In-Reply-To: <871wb79q80.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63297>

On 2007.11.03 20:46:39 +0300, Sergei Organov wrote:
> Hello,
>=20
> I need to ask about git-show-branch once again as I really can't
> understand its behavior myself. Could please anybody either confirm b=
ug(s) in
> git-show-branch, or explain why does it work this way.
>=20
> Consider its invocation in a toy repository that has total 6 commits,=
 as
> can be seen from this output:
>=20
> $ git branch
> * master
>   mybranch
> $ git rev-list master mybranch --pretty=3Doneline
> e9217caffebd6311073867d410f0c6e46910a13d Go to sleep
> 5f19837be87493e9b284fe7db03f00f23d006d2e Merged mybranch
> 2e2a4956db9737faf5f4f296b895500fafab7350 Some fun.
> 6478a15c48b0a7ce28069310ff5e51f95b250c7c Some work.
> 48d3660dc2005471c27f1d5b09d334885b612380 Commit message
> 2c14c05709bde3c1a7bbdd7effbf73a5667fa265 Initial commit
> $
>=20
> Or, using git-show-branch itself:
>=20
> $ git-show-branch --more=3D9 master
> [master] Go to sleep
> [master^] Merged mybranch
> [master^^2] Some work.
> [master~2] Some fun.
> [master~3] Commit message
> [master~4] Initial commit
> $
>=20
> [NOTE: the format of this output contradicts the manual page, but it'=
s
>  not the topic of this post]
>=20
> Now comes the confusion:
>=20
> $ git-show-branch --more=3D9 master mybranch
> * [master] Go to sleep
>  ! [mybranch] Some work.
> --
> *  [master] Go to sleep
> *+ [mybranch] Some work.
> *  [master~2] Some fun.
> *+ [master~3] Commit message
> *+ [master~4] Initial commit
> $
>=20
> In this output, why git doesn't show the merge commit having "Merged
> mybranch" commit message?

Because you didn't pass --sparse.

>=20
> Yet another confusion:=20
>=20
> $ git-show-branch master mybranch
> * [master] Go to sleep
>  ! [mybranch] Some work.
> --
> *  [master] Go to sleep
> *+ [mybranch] Some work.
> $
>=20
> Why does it stop at "Some work." commit? The manual page says: "Usual=
ly
> the command stops output upon showing the commit that is the common
> ancestor of all the branches.", so I'd expect it should go down to
> "Commit message" commit that is the fork point.

Common ancestor means, that the commit is reachable through all refs.
Let's take a look at your history:

         .-F-.  mybranch
        /     \
   A---B---C---D---E  master

There you can see that mybranch can of course reach F, and that master
can reach it, too. E -> D -> F. So the output stops at F, not at B.

Bj=F6rn
