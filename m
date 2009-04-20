From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 23:04:29 +0200
Message-ID: <20090420210429.GC17241@atjola.homenet>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302> <20090420184746.GG25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0gv-0005Nf-Jy
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbZDTVEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbZDTVEj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 17:04:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:52044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754985AbZDTVEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 17:04:38 -0400
Received: (qmail invoked by alias); 20 Apr 2009 21:04:36 -0000
Received: from i59F55CF3.versanet.de (EHLO atjola.local) [89.245.92.243]
  by mail.gmx.net (mp003) with SMTP; 20 Apr 2009 23:04:36 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19SXtAnk11S6mPCsRDtBW8ZVQhtU7QL0qDc04+uWf
	dlHxSf6ZhGFNEp
Content-Disposition: inline
In-Reply-To: <20090420184746.GG25059@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117034>

On 2009.04.20 22:47:46 +0400, Dmitry Potapov wrote:
> On Mon, Apr 20, 2009 at 04:25:38PM +0200, Johannes Schindelin wrote:
> >=20
> > On Mon, 20 Apr 2009, Dmitry Potapov wrote:
> >=20
> > > When you create a new commit, it is always belong to _one_ branch=
 and=20
> > > never to two or more branches.
> >=20
> > Certainly you forgot about detached HEADs?
>=20
> I suppose it is a branch without any name given to it,

Strictly, you don't give names to branches with git. But if you do, tha=
t
has some "interesting" consequences. Let's say you have "master" checke=
d
out and do:

git branch foo
git checkout -b bar

You now have a single line of development and three names that referenc=
e
it. So your branch would have three names, right?

git commit --allow-empty -m 123

Now, your previous branch only has two names left, and you have a new
branch with a single name.

git reset foo

And now, you again have three names for the original branch and the new
branch is unnamed.

So when you go and say that branch heads provide names for branches, yo=
ur
actions become pretty weird. "git branch <name>" gives new names to
existing branches, and "git commit" is what actually creates the branch
(this is always the case), plus it might remove a name from an existing
branch. "git reset" removes a name from one branch and gives it to
another branch. "git rebase" does the same, and it's in general not
valid to think of rebase as rewriting the branch's history. For example=
:

git checkout -b for-v2 for-v1
git rebase --onto v2 v1 for-v2

That would create a new branch, add for-v2 as a name for it and remove
the for-v2 name from the old branch (so the number of names for it is
reduced by one, but it's still called for-v1)


So, IMHO, if you think the whole "branches have names" scheme through,
using the "a branch is a line of development" definition and keeping in
mind how git actually works, using branch heads, things do get pretty
confusing.

> but it is an advanced feature. I don't think many beginners know abou=
t
> it, so it is something that can confuse beginners.

But it should not. In my experience, telling someone how HEAD works
often leads to some kind of epiphany. And a detached HEAD is probably
easier to grasp than the "normal" situation where HEAD is a symbolic
reference to some branch head. Btw, writing those emails, I can now
understand _why_ the explanation of HEAD and how it controls which
reference gets updated upon e.g. "git commit" might be so helpful to
some users. It might just be the fact that they suddenly realize that
git does not have a true directly user-accesible notion of branches, bu=
t
just branch heads. I can imagine how users that think in branches that
have a start and an end might get confused.

Bj=F6rn
