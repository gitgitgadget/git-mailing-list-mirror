From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn merge helper
Date: Wed, 3 Oct 2007 00:38:13 +0200
Message-ID: <20071002223813.GA3152@atjola.homenet>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com> <20071002211400.GA992@atjola.homenet> <20071002220458.GA21038@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 00:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcqNN-0005e8-3v
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 00:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbXJBWhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 18:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbXJBWhx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 18:37:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:50737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751697AbXJBWhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 18:37:52 -0400
Received: (qmail invoked by alias); 02 Oct 2007 22:37:50 -0000
Received: from i577B85BB.versanet.de (EHLO localhost) [87.123.133.187]
  by mail.gmx.net (mp048) with SMTP; 03 Oct 2007 00:37:50 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19PxW4ytUNPreIIMFCE+Hosa92YuAXZOX/hQ5Nq5k
	xohwiOe6vGJ2wd
Content-Disposition: inline
In-Reply-To: <20071002220458.GA21038@dervierte>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59750>

On 2007.10.02 18:04:58 -0400, Steven Walter wrote:
> On Tue, Oct 02, 2007 at 11:14:00PM +0200, Bj=F6rn Steinbrink wrote:
> > One common pattern in SVN is to have the feature branch following t=
he
> > trunk. In git terms, that would mean that the feature branch is
> > continually rebased onto the HEAD of the HEAD AFAICT (although SVN =
of
> > course cannot represent that). The problem with that is, that git
> > doesn't create a merge commit in that case and git-svn gets confuse=
d
> > again.
> >=20
> > git checkout mybranch
> > git merge master # Creates a merge commit
> > git checkout master
> > git merge mybranch # Does just fast forward
> >=20
> > Is there anyway to force a merge commit or some other work around?
>=20
> When I want to do something like this, I go about it one of two ways.
> The first option is to simply rebase mybranch onto master.  Since my
> feature branches are not usually published, there is no problem
> rewinding them.  That may not be an option for you, however.

Unfortunately not, the branch in question is required to be in the SVN
repository.

> The other option is to have a "build" branch.  By example:
>=20
> git checkout build
> git reset --hard master
> git merge mybranch
> make
>=20
> In that way, I have branch with the latest changes from head and the
> changes from mybranch together.  The downside to this method is that =
you
> may have to repeated resolve merges.  Despite the downsides, I find
> these two methods to work quite well.

Thanks, but it makes no difference here, it stil results in a fast
forward. This is a small test case which exhibits the behaviour and
matches my current workflow with git-svn (except for the dcommits):

git init
echo Hi > file1; git add file1; git commit -m file1
git checkout -b branch
echo Hi > file2; git add file2; git commit -m file2
git checkout master
echo Hi > file3; git add file3; git commit -m file3
git checkout branch
git merge master

# Then I'd normally do the following which causes a fast forward
#git checkout master
#git merge branch

# Now I tried this, which also results in a fast-forward:
git checkout -b merge
git reset --hard master
git merge branch


Anything I'm missing?

Thanks,
Bj=F6rn
