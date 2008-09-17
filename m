From: Michael Radziej <mir@noris.de>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Wed, 17 Sep 2008 13:17:29 +0200
Message-ID: <20080917111729.GD16687@noris.de>
References: <20080909231009.GD10544@machine.or.cz> <20080915080131.GA30396@noris.de> <20080917101111.GR10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfv3Q-0006Uw-RC
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYIQLRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYIQLRc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:17:32 -0400
Received: from mail01.noris.net ([62.128.1.221]:49432 "EHLO mail01.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbYIQLRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:17:31 -0400
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail01.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1Kfv2H-00044u-QH; Wed, 17 Sep 2008 13:17:29 +0200
Received: from mir.office.noris.de ([10.2.6.66])
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1Kfv2H-0004XM-MV; Wed, 17 Sep 2008 13:17:29 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 6E400158E5; Wed, 17 Sep 2008 13:17:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080917101111.GR10360@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96093>

Hi Petr!

Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Sep 15, 2008 at 10:01:31AM +0200, Michael Radziej wrote:
> > I wonder about the .topmsg and .topdeps files. Why is this information
> > within the topic branch? It tends to get into the way even though a special
> > merge driver is provided. For example, you cannot do octopus merges (which I
> > found very confusing as first-time user).
> 
>   what do octopus merge have to do with that? If these files prevent
> octopus merges somehow, I think that'd be a Git bug. (TopGit making
> octopus merges whenever possible is deep on my mental TODO list.)

Hmm. Is there a way to to the octopus merge? If I do it straight away

  git merge b1 b2 b3 b4

then git does not use the "ours" merge driver for the .topfiles, since the
attribute setting is only used for 3-way-merges. Then I get conflicts, and
git cannot handle conflicts during octopus merges.


> > And it might also confuse people
> > cloning a TopGit repository and want to use a topgit branch. They might not
> > be aware of these special TopGit things.
> 
>   They need to be properly educated by whoever gives them the clone URL.
> Using TopGit branches outside of TopGit is still dangerous - they have
> *unholy* history and they are not really suitable for non-TopGit merging
> etc. If TopGit users want non-TopGit users to use their work, they
> should tg export.

With *unholy* you mean the lots of merges? I usually avoid them by doing
"tg update" only when I get conflicts. Are there other problems?

> > I'd rather have a dedicated branched named e.g. 'TopGit' which includes the                                                           
> > information that is currently in .topmsg and .topdeps, but for all branches
> > in a repository.
> 
>   This was indeed a difficult design decision, perhaps the most major
> one I had to make. Both approaches have their pros and cons, and in the
> end I chose the .top* files mainly to keep the changes atomicity - if
> you revert your branch to older version, your .topmsg and .topdeps are
> rewound appropriately as well, and if you change something in your
> branch that affects your topmessage, these changes are connected
> appropriately. Also, you do not need to use special tools to edit your
> top message 

Yeah, you're right about git-reset on branches. I tend to see the patch
description independent from the patch, so I don't see this as a big
problem. But how often does one really change the .topfiles?

> and merges are much simpler than if you had to merge two
> people's work on a single branch (besides, the merge semantics of the
> TopGit branch would be really, really nasty, perhaps downright
> impossible to specify properly)

I don't use the merge result as a TopGit branch - it's like a regular git
branch for me.

I use merging in different ways. I merge all topic branches to get a testing
branch, which I throw away later. And I also temporarily merge the upstream
branch with all the topic branches just to check for conflicts. If I get a
conflict, I use tg update for the conflicting branches. I'll probably script
this sooner or later :-)

>   Hmm, well, oops. Merging of two people's work on a single branch is
> broken right now anyway, because we unconditionally use our 'ours' merge
> driver in these cases. I wonder how to fix this best... swapping two
> gitattributes files in .git/info/attributes during tg update seems like
> the only solution to me.

I don't have enough insight into TopGit to really think through this, at
least for now. Does it make sense at all build a TopGit branch on top of two
other TopGit branches from different repositories?

Michael
