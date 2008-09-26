From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Help with merge and git-svn
Date: Fri, 26 Sep 2008 19:23:31 +0200
Message-ID: <20080926172331.GA7879@atjola.homenet>
References: <8384c2b90809260936m21c14e0dve5b08b021da4a342@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Craig Tataryn <craiger@tataryn.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 19:28:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjH6r-0005rp-NM
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 19:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYIZR05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYIZR04
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 13:26:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:60750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbYIZR04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 13:26:56 -0400
Received: (qmail invoked by alias); 26 Sep 2008 17:23:33 -0000
Received: from i577B87BF.versanet.de (EHLO atjola.local) [87.123.135.191]
  by mail.gmx.net (mp026) with SMTP; 26 Sep 2008 19:23:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+eTbMHOF+eBflyT1kIfZ0rXNxJ9/R6hse3XzXcuA
	WeUwDqdKeyCA8l
Content-Disposition: inline
In-Reply-To: <8384c2b90809260936m21c14e0dve5b08b021da4a342@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96878>

On 2008.09.26 11:36:48 -0500, Craig Tataryn wrote:
> Hi, first time poster to kernel.org mailing lists, so if I commit a
> taboo, please be kind to me :)
>=20
> I have the following scenario:
>=20
> [remote deveoper]<=3D=3D=3D>[shared git repo]<=3D=3D=3D>[me]<=3D=3D=3D=
>[client's svn repo]
>=20
> So my remote developer and I push and pull to/from the shared git
> repo, and then I sync changes to and from the client's svn repo using
> git-svn.
>=20
> My problem is, when I am ready to merge changes from my local master
> branch to trunk-local, if I do a "git merge master" and then try to
> issue any git-svn commands I get the following errors:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ git merge master
> Updating d88106e..77b86ae
> Fast forward
>  community/pom.xml |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> $ git svn dcommit
> Can't call method "full_url" on an undefined value at
> /usr/local/git/libexec/git-core/git-svn line 425.
>=20
> $ git svn rebase
> Unable to determine upstream SVN information from working tree histor=
y
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The only way I've seem to be able to remedy this is if I add the
> "subtree" merge strategy to the merge command:
>=20
> git merge -s subtree master
>=20
> Then git-svn doesn't get confused about it's repo, but when you look
> at the repo using gitk, you see something like:
>=20
> [trunk-local]--[remotes/trunk]  Merge branch 'master' into trunk-loca=
l
> | \
> |  \
> |    [master]--[remotes/origin/master]  "Some commit message from the
> last master commit"
> |    |
> |    |
> |  /
> /
>=20
> When I use the normal merge strategy then gitk shows all branches at
> the same level, but git-svn is of course b0rked.
>=20
> So I guess my question is, am I stuck using "-s subtree", is this the
> right course of action??  Or can I get this to work with the default
> strategy?  Is this symptomatic of a messed up or disjoint history
> (i.e. early on I did some --squash merges).
>=20
> I have full control over the shared repo and I don't mind blowing it
> away and rebuilding it based on what's in SVN if that's what it takes=
=2E

The original merge you did ended up as a fast-forward, ie. no merge
commit was created. I guess that your history is so, that somehow the
remotes/trunk stuff is reachable through the second parent of some merg=
e
commit that exists in your history. But git-svn uses --first-parent to
find its upstream, so it cannot find that in your scenario. I guess it'=
s
best if you use "git merge --no-ff master" to force the creation of a
merge commit. Subtree happens to work because it implies --no-ff, but
I'm not sure whether there might be downsides to using the subtree
strategy, so I'd rather go with the explicit --no-ff and the normal
merge strategies.

Bj=F6rn
