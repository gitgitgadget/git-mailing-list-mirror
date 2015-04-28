From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: How are submodule conflicts resolved during rebase?
Date: Tue, 28 Apr 2015 21:21:22 +0200
Message-ID: <20150428192122.GA2933@sandbox-ub1410>
References: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
 <20150428164904.GA4477@sandbox-ub1410>
 <CAHd499AMKd4aRfDxraArmBGE5eeAhTHQKPbAhcXC-kfPEJPtYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 21:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnB4e-0001kH-2W
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030960AbbD1TVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 15:21:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:37673 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030911AbbD1TVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 15:21:30 -0400
Received: from [80.135.112.188] (helo=sandbox-ub1410)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YnB4Q-0007Ur-Ki; Tue, 28 Apr 2015 21:21:26 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499AMKd4aRfDxraArmBGE5eeAhTHQKPbAhcXC-kfPEJPtYQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267933>

On Tue, Apr 28, 2015 at 01:19:00PM -0500, Robert Dailey wrote:
> On Tue, Apr 28, 2015 at 11:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Tue, Apr 28, 2015 at 09:34:06AM -0500, Robert Dailey wrote:
> >> Suppose I have a branch with 10 commits on it, 3 of those commits
> >> contain a change to the same (and only) submodule in the repository.
> >> When I rebase this branch onto the tip of its parent branch, I get a
> >> conflict in each of the 3 commits because the submodule also changed
> >> on the parent branch since my last rebase.
> >>
> >> I've seen some cases where I am asked to resolve the submodule
> >> conflict with local or remote. I expect this behavior and it isn't
> >> confusing to me. However, I have also seen cases where rebase auto
> >> resolves the conflicted submodule.
> >>
> >> How does Git know to auto resolve some submodule conflicts but not the
> >> others? I find this behavior unpredictable and I haven't found any
> >> documentation on it (I'm giving the git docs the benefit of the doubt
> >> and assuming it's there, since the git docs are very very good).
> >
> > There is some logic for submodule merges, but to prevent false merges
> > only the straight forward case results in a clean merge. In short:
> > Conflicts for submodules are auto resolved when one side is contained in
> > the other and both changes point forward.
> >
> > I.e. when merging A and B in the superproject and the submodule looks
> > like this:
> >
> >         base---*---*---B
> >         \             /
> >          *---A---*---*
> >
> > It will result in a clean merge in the superproject.
> >
> > If there is a common commit that contains both sides but that commit is
> > not part of any side in the superproject the merge will fail but suggest
> > that commit as a conflict resolution.
> >
> So if I understand this correctly, you are saying that during a rebase
> if it sees a potential conflict for a submodule in the commit being
> rebased, it will inspect the ancestry of the actual commits in the
> submodule logs?

Yes that is correct.


> For a rebase, does this mean that the local (latest SHA1 from the
> submodule in the target branch of the rebase) submodule commit must be
> reachable from the remote (SHA1 contained in the diff of the commit
> currently being rebased) submodule commit?

I does not matter which is reachable from which but yes one has to be
reachable from the other.

> I just want to make sure this is the logic. Thanks for explaining,
> still trying to wrap my head around it.

Yeah submodule things tend become complicated to think about at times.

Cheers Heiko
