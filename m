From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Wed, 21 Jun 2006 03:01:38 -0700
Message-ID: <20060621100138.GA15748@localdomain>
References: <1150599735483-git-send-email-normalperson@yhbt.net> <7vd5d63k7f.fsf@assigned-by-dhcp.cox.net> <20060619213951.GA6987@hand.yhbt.net> <7vbqso95f3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 12:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FszWp-0005oD-1R
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 12:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWFUKBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 06:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFUKBk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 06:01:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:5020 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751462AbWFUKBj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 06:01:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 55BD07DC022;
	Wed, 21 Jun 2006 03:01:38 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 21 Jun 2006 03:01:38 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqso95f3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22251>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >
> >>  - You kept the original "format-patch piped to am" workflow
> >>    optionally working.
> >
> > I left it as the default, too.  I figured that it's best not
> > to change the default (and most likely faster) behavior of
> > something people rely on.
> 
> I should have said: "You kept ... working, which is good".
> 
> >> I think the three-way merge you would want here is not between B
> >> and G using E as the pivot, but between B and G using A as the
> >> pivot.  That's how cherry-pick and revert works.  I would
> >> leverage the interface that is one level lower for this -- the
> >> strategy modules themselves.
> >> 
> >> 	git-merge-$strategy $cmt^ -- HEAD $cmt
> >
> > Changing the 'git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt"'
> > line in call_merge() to this seems to have broken more tests.
> 
> Oh, that is to be expected if you changed git-merge -s recursive
> with git-merge-recursive without other changes.  The former
> makes a commit (which your original patch later used to create a
> separate commit chain and discarded); the latter does not make a
> commit but expects the caller to create a commit out of the
> resulting index file.

Oops, *smacks head*

> > I'm not an expert at merging strategies by any measure, I've just
> > trusted merge-recursive to Do The Right Thing(TM) more often than not,
> > and use rerere to avoid repeating work.
> 
> I was originally hoping that rebasing would just be a matter of
> listing sequence of commits to be ported onto a new base and
> running "git-cherry-pick" on each of them in sequence.  Now
> cherry-pick does not use merge machinery (hence does not use
> git-merge-recursive), but if we change that then updating rebase
> would be pretty much straightforward.  It just needs a UI layer
> to guide the user through recovery process when the merge does
> not resolve cleanly in the middle, no?

Sounds workable right to me. But then again, a cherry-pick is also a
case of rebase on a single commit, so we could be using rebase (and its
recovery code) in cherry-pick, too, right?

-- 
Eric Wong
