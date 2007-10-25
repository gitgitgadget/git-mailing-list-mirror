From: Junio C Hamano <gitster@pobox.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 11:33:43 -0700
Message-ID: <7vejfj11tk.fsf@gitster.siamese.dyndns.org>
References: <20071024212854.GB6069@xp.machine.xx>
	<05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
	<Pine.LNX.4.64.0710242258201.25221@racer.site>
	<008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
	<Pine.LNX.4.64.0710250021430.25221@racer.site>
	<47204297.5050109@op5.se>
	<Pine.LNX.4.64.0710251112390.25221@racer.site>
	<472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org>
	<4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org>
	<4720CCE0.2090007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:34:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7XQ-000794-Io
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbXJYSd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXJYSd6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:33:58 -0400
Received: from rune.pobox.com ([208.210.124.79]:56508 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbXJYSd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:33:57 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8A57414FEE0;
	Thu, 25 Oct 2007 14:34:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1661F14FD7F;
	Thu, 25 Oct 2007 14:34:06 -0400 (EDT)
In-Reply-To: <4720CCE0.2090007@op5.se> (Andreas Ericsson's message of "Thu, 25
	Oct 2007 19:05:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62355>

Andreas Ericsson <ae@op5.se> writes:

> However, there's still this issue:
> $ git checkout -b foo origin/pu
> Branch foo set up to track remote branch refs/remotes/origin/pu.
> Switched to a new branch "foo"
>
> git checkout will say that every time a branch is created from a
> tracking branch, unless one tells it --no-track (which people don't
> learn about unless they're really into git), so it's quite natural
> that people think git will actually make sure, within reasonable
> limits, that 'foo' is kept in sync with refs/remotes/origin/pu.
> That's not the case, however.
>
> So we could either change the message to be:
> "Branch foo set up to track remote branch refs/remotes/origin/pu,
> provided you only ever issue git-pull while having branch foo
> checked out."
>
> Or we could make 'git checkout -b' default to --no-track, perhaps
> giving annoying messages everytime someone "git-checkout -b"'s a
> remote tracking branch.
> Or we could make git-pull keep git checkout's promises.

The thing is, if you have 200 local branches (because you
interact with 50 repositories with 4 primary branches each), you
do not constantly check all of them out anyway.  And the only
place that staleness of the local tracking fork matters is when
you check it out (that is, as long as you train your users that
the way to check differences with the upstream 'pu' in your case
is by doing operations with 'origin/pu' not with your local
'foo').

With that in mind, how about making "git checkout foo", after
foo is set up thusly, to show:

	git log --pretty=oneline --left-right origin/pu...foo

if (and only if) they have diverged?  Then you can deal with the
staleness of local tracking fork 'foo' in any way you want.

You could even go one step further and make this "checkout foo",
in addition to or instead of showing the above left-right log,

 - automatically run "git merge origin/pu" if it is a
   fast-forward, and say it did _not_ run that merge if it is
   not a fast-forward;

 - automatically run "git merge origin/pu" always, even if it is
   not a fast-forward;

 - automatically run "git rebase origin/pu" always;

Would that make your life easier?
