From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 20:32:47 -0700
Message-ID: <7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
	<20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 05:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4qBR-0004eM-Dh
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 05:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbXGADct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 23:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXGADct
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 23:32:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42349 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbXGADcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 23:32:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701033248.PJVG6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 23:32:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J3Ym1X00E1kojtg0000000; Sat, 30 Jun 2007 23:32:47 -0400
In-Reply-To: <alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 30 Jun 2007 20:01:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51272>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 30 Jun 2007, Junio C Hamano wrote:
>> 
>> The current scripts that largely use "git-foo" do not have to be
>> changed.  Your --no-alias and Linus's "git - foo" would be a
>> "solution", but both require changes to the scripts
>
> No. I didn't (and wouldn't) _remove_ the "git-xyzzy" thing.
>
> I'm just saying that it should be considered a secondary thing, and we 
> should have the long-term *option* to remove it.
>
> And in order to do that, we should start removing our dependency on it 
> earlier rather than later.
>
> Your whole alias argument is bogus, since we don't _allow_ aliases to 
> override the command (as you yourself did admit).
>
> So changing the current scripts from using "git-xyzzy" to using "git 
> xyzzy" changes nothing at all - except it gives people the _option_ to 
> stop installing the git-* links if they don't want to.

People who do not want to have git-xyzzy in their PATH had that
choice for eternity ("make gitexecdir=$(prefix)/libexec/git");
your patch is not needed to satisfy that.

What it buys us is that they do not have to have
$(prefix)/libexec/git/git-xyzzy for all xyzzy that git.c knows
about as built-ins (obviously non built-ins are still needed).
I do see value in not cluttering $(prefix)/bin/ quite a lot, but
does it matter if we have 140 links or 70 links (the differences
are 70 or so built-ins we currently have) in $(prefix)/libexec/git?

I would not be objecting to it if this was about $(bindir).

> With my patch, it's a _choice_, rather than a straight-jacket.

But that is a different choice.  Choice of having only 70
git-xyzzy in $(gitexecdir) vs having to have 140 (among which 70
are hardlinks).

Your patch _closes the door_ for us to implement overriding
aliases later if we wanted to; we would need to go back to the
scripts and say "git --no-alias xyzzy" again.
