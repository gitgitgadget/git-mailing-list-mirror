From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Preserving branches after merging on ancestor
Date: Sat, 7 Nov 2009 14:28:40 +0100
Message-ID: <20091107132840.GA9303@atjola.homenet>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
 <20091106010947.GB4425@progeny.tock>
 <20091106021038.GA27206@atjola.homenet>
 <20091106050353.GA8824@progeny.tock>
 <1257520877359-3959325.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Sat Nov 07 14:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6lLi-0000Hk-OD
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 14:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZKGN2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 08:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZKGN2l
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 08:28:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:39012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbZKGN2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 08:28:40 -0500
Received: (qmail invoked by alias); 07 Nov 2009 13:28:43 -0000
Received: from i59F55CCF.versanet.de (EHLO atjola.homenet) [89.245.92.207]
  by mail.gmx.net (mp059) with SMTP; 07 Nov 2009 14:28:43 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+fCMI/prGfDJkeyeZOgDN6f7klFg7jFG3r7Lg2XI
	rSoKc3vGwPCjn5
Content-Disposition: inline
In-Reply-To: <1257520877359-3959325.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132362>

On 2009.11.06 07:21:17 -0800, rhlee wrote:
> Jonathan Nieder-2 wrote:
> >=20
> > Then your response pushed me towards the question of whether --no-f=
f is a
> > good idea in general
> >=20
>=20
> John, I get the feeling from what you say in general that fast forwar=
ds are
> default behaviour for merges for a reason and by using the --no-ff op=
tion I
> am making my workflow and git history uncessesarily awkward and worki=
ng
> against best practices?

As Jonathan already said, there are pros and cons when the merge is
about merging topic branches to some "main" branch. In addition to that=
,
working with git often also involves other merges. For example, you
might have your private topic branch, on which you work on two differen=
t
boxes. So you push your topic branch to some private bare repo, fetch i=
t
from the other box, work there, and push the result back to the bare
repo. And then, in the "original" repo, you of course want to update
your local branch head to reflect the new changes. So you fetch and
merge, but you really don't want a merge commit in that case, but the
default fast-forward behaviour. In some sense, that kind of "merge", is
more like an "update", for which the fast-forward behaviour is simply
better.

> Jonathan Nieder-2 wrote:
> >=20
> >> I guess Richard took the "branch topic1, merge topic1, branch topi=
c2,=20
> >> merge topic2" thing just as an example because that ends up with t=
wo=20
> >> fast-forwards.
> >=20
> > Hmm, I found Richard=E2=80=99s example pretty realistic.  I used to=
 work like
> > that, and I don=E2=80=99t think I am the only one.
> >=20
>=20
> I'm not saying there is any one "right" workflow. But is there a more
> suitable workflow than than "branch topic1, merge topic1, branch topi=
c2,
> merge topic2"?

That order of commands looks like a strict "Start a topic, finish a
topic, merge it, start next topic, ..." workflow. And that severely
limits what you can do, as you're forced to work on only one thing and
to finish it first before starting something else. Such a strict
workflow basically makes branching pointless. I often do things like:

git checkout -b new_feature master
*work & commit*

*get a bug report about the stable version*
git checkout -b bug_fix_foo maint
*work & commit*

*get a report about a trivial bug on master*
git checkout master
*fix bug & commit* # Yes, directly on master
git push

git checkout bug_fix_foo
*finish the bug_fix*
git checkout maint
git merge bug_fix_foo # Merge the bugfix to the oldest branch it applie=
s to
git checkout master
git merge maint # Merge bugfixes forward to the more recent branches
git push

git checkout new_feature
*finish feature*
git checkout master
git merge new_feature
git push

So I could work on multiple things at the same time, and even merged
them in reverse order, compared to the order in which I started the
branches. It's just the strict "start, finish, merge, start next, ..."
order that looks suspicious, but that's totally unrelated to the --no-f=
f
thing. Even when working on multiple branches and merging them in a
random order, you can hit a fast-forward for the "first" merge.

Bj=C3=B6rn
