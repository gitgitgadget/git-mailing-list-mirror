From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 17:41:13 +0100
Message-ID: <20071128164113.GA20749@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com> <20071128160410.GB19302@diana.vm.bytemark.co.uk> <9e4733910711280821s3872eff5m95073ca6b1b8a689@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPyl-0008P2-Ei
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbXK1QlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760031AbXK1QlS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:41:18 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3049 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759679AbXK1QlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:41:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxPyL-0005RN-00; Wed, 28 Nov 2007 16:41:13 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711280821s3872eff5m95073ca6b1b8a689@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66377>

On 2007-11-28 11:21:05 -0500, Jon Smirl wrote:

> On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-11-28 10:06:57 -0500, Jon Smirl wrote:
> >
> > > stg repair -- partial repair, some patches empty, half are pushed
> >
> > Modulo any bugs, this should have adjusted the appliedness of your
> > patches to match the new HEAD (patches are applied iff they are
> > reachable from HEAD) and made patches of any non-patch commits
> > sitting between a patch and HEAD. Nothing else. In particular, it
> > doesn't change your existing patches or change HEAD, so those
> > empty patches were empty even before the repair. (Modulo any bugs,
> > of course, but that kind of bug seems really unlikely.)
>
> I don't know exactly what is going one, but all of my patches are in
> commits in front of the rebase. I believe when they were applied
> again, git detected that the changes were already in the tree and
> that why the patches are empty. Normally stg would have popped all
> my patches before doing the rebase.

Ah, yes, if you "stg push" after the repair, that's what you can
expect to happen. And once you've done that, it gets a little messier
to recover. (Basically, what you'd do is delete the messed-up patches,
git-reset to where you were before the git-rebase, and then "stg
uncommit".)

> I have messed the branch up doing manual recover, but the conditions
> are easy enough to recreate.

So I guess "stg repair" is working as intended, and what needs
changing is its documentation: point out in greater detail that you
should

  1. Figure out where you _want_ HEAD to be.

  2. git-reset your way there.

  3. Run stg repair if necessary. (And if you just reset back to where
     StGit thinks you are, you don't need to. But it's safe to run
     repair in that case too -- it'll just do nothing.)

In that order.

The only thing repair does is fix up StGit's metadata to match what
HEAD is right now. If HEAD isn't what you want it to be, then you want
to fix that first. In particular, to just go back to where you were
the last time StGit heard from you, do

  $ git reset --hard $(stg id $(stg top))

We need a proper manual to explain this in. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
