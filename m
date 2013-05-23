From: John Keeping <john@keeping.me.uk>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 17:41:14 +0100
Message-ID: <20130523164114.GV27005@serenity.lan>
References: <20130522115042.GA20649@inner.h.apk.li>
 <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
 <20130523090657.GB23933@inner.h.apk.li>
 <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 18:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfYa0-0006CK-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 18:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759210Ab3EWQlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 12:41:24 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:54515 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EWQlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 12:41:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5B0B01980E8;
	Thu, 23 May 2013 17:41:23 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYFsicKOwFOS; Thu, 23 May 2013 17:41:22 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 14213198102;
	Thu, 23 May 2013 17:41:16 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vd2shheic.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225265>

On Thu, May 23, 2013 at 09:01:15AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I've been annoyed by this at $DAYJOB recently.  A lot of people seem to
> > blindly "git pull" without much thought about how the history is ending
> > up and what they actually want to do.
> 
> I think these two are essentially the same thing, and having an
> option to flip the heads of a merge only solves a half of the
> problem.
> 
> A merge that shows everybody else's work merged into your history
> means you are the integrator, the keeper of the main history.  And
> the first-parent view of the history is useful only when the keeper
> of the main history takes good care of the main history.
> 
> When you are using a "central shared repository" workflow, if you
> had and used an option to flip the heads of a merge to record what
> you have done so far as a side branch of what everybody else did to
> do the merge, or if you rebased your work on top of what everybody
> else did, the first-parent view would make a bit more sense than
> what you currently get.  At least, everybody else's work will not
> appear as a side branch that does 47 unrelated things, and your work
> will appear as a side branch.  That is a big plus.
> 
> But the other half of the problem still remains, i.e. "what they
> actually want to do".  People tend to do too many "pull" when their
> work is not ready, only to "catch up", and that is the real problem.
...
> One obvious way to solve it is to use a topic branch workflow (the
> first picture above; 'x's are built not on local 'master'), and you
> do a "git pull" from the shared repository while you are on your
> 'master', which is free of your 'x's until that 6-commit series is
> complete and ready.  Then you locally merge that topic branch and
> push it back for everybody to see, which will give you the first
> picture in this message.  Incidentally, this does not need the "flip
> the heads" option.

Yes, I don't think this is as much of a problem when using a topic
branch workflow, because it's clear what the history should look like
and users are expected to get it right.

Where I see this is when people are aiming for a linear history but
don't get that because with "git pull" to catch up they end up with
these backwards merges.  In these cases, I think what users really want
is "git pull --rebase".

I have to wonder how often "git pull" with no arguments actually does
what users really want (even if they don't know it!) when it doesn't
result in a fast-forward (and pull.rebase isn't configured).

Hence my suggestion to error when "git pull" doesn't result in a
fast-forward and no branch name is specified.  We could give some advice
like:

    Your local changes are not included in the local branch and you
    haven't told Git how to preserve them.

    If you want to rebase your changes onto the modified upstream
    branch, run:

        git pull --rebase

> Solving half a problem is better than solving no problem, and
> especially because not all changes need to be multi-commit series
> but can be done directly, perfectly and fully on the local 'master'
> (i.e. 2+3+1=6 split would not happen for such changes).  For these
> reasons, I personally am not strongly opposed to a "flip the heads"
> option, if implemented cleanly.
> 
> But people need to realize that it is not solving the other half, a
> more fundamental problem some people have in their workflow.

Yes, but some users don't realise that their workflow is broken, and
perhaps we can nudge them in the right direction.
