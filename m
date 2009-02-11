From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add automatic git-mergetool invocation to the new infrastructure
Date: Wed, 11 Feb 2009 14:11:16 +0100
Message-ID: <20090211131116.GA30272@diana.vm.bytemark.co.uk>
References: <20090210141157.28782.10027.stgit@pc1117.cambridge.arm.com> <20090211092028.GC26136@diana.vm.bytemark.co.uk> <b0943d9e0902110248n7aa14743p19079e3d967f77a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 14:12:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXEtT-0008WE-D9
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 14:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbZBKNLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZBKNLU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 08:11:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:54188 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbZBKNLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 08:11:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LXEs0-0007ur-00; Wed, 11 Feb 2009 13:11:16 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0902110248n7aa14743p19079e3d967f77a9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109413>

On 2009-02-11 10:48:00 +0000, Catalin Marinas wrote:

> 2009/2/11 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-02-10 14:14:07 +0000, Catalin Marinas wrote:
> >
> > > I'm still not entirely sure where the check for stgit.autoimerge
> > > should be done. In the classic infrastructure, it is done in the
> > > merge function. With this patch, it is done in
> > > Transaction.push(). Should we push this even further to
> > > stgit.commands.push? My opinion is not since by having it in
> > > Transaction we get the advantage not listing the conflicts if
> > > the mergetool succeeds and we don't need to abort the
> > > transaction.
> >
> > Yes, one advantage of having it here is that if the user resolves
> > the conflict, we can just continue. I'm not sure I personally like
> > that mode of operation -- you might have guessed by now that I
> > like noninteractive mechanisms -- but I can see how it's useful to
> > someone who does.
>
> I find it useful when I prepare a kernel release and pick patches
> from many branches, it saves some typing with having to run the
> mergetool and restart the pick or push command. It's also useful for
> "sync".
>
> > Another advantage of having it here is that it automatically just
> > works for all commands, not just "stg push".
>
> It works for commands that use Transaction.push_patch(). Other
> commands that use IndexAndWorktree.merge() via some other function
> would not work. Will there be such functions? I suspect a "sync"
> implementation would need additional support in Transaction.

Yes, you're right.

> Any thoughts on calling mergetool from IndexAndWorktree.merge()
> (with an additional parameter to explicitly enable this rather than
> just reading the config option)?

That could very well be a good idea -- I can't think of anything wrong
with it. (And it's a good idea to make this a parameter rather than
making it read the config option.)

> > The disadvantage that I see is that we ask the user to put work
> > into resolving conflicts before we've made sure that we won't roll
> > back the whole transaction. If this is to become a dependable
> > feature, we need a way to make sure we'll never throw away the
> > user's work.
>
> Maybe push_patch() can receive a parameter on whether to invoke
> mergetool. The calling code should know the behaviour for aborting
> transactions and only ask for interactivity if the command is
> expected to leave conflicts in the index.

That sounds like a plan.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
