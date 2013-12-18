From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 14:16:48 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131218191648.GA4533@thyrsus.com>
References: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
 <20131218162710.GA3573@thyrsus.com>
 <20131218174615.GA5597@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtMc5-0002I4-N9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab3LRTQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:16:51 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46137
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043Ab3LRTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:16:49 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 30315380488; Wed, 18 Dec 2013 14:16:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131218174615.GA5597@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239469>

Jeff King <peff@peff.net>:
> In git, it may happen quite a bit during "git am" or "git rebase", in
> which a large number of commits are replayed in a tight loop.

That's a good point - a repeatable real-world case in which we can
expect that behavior.

This case could be solved, though, with a slight tweak to the commit generator
in git (given subsecond timestamps).  It could keep the time of last commit
and stall by an arbitrary small amount, enough to show up as a timestamp
difference. 

Action stamps work pretty well inside reposurgeon because they're
mainly used to identify commits from older VCSes that can't run that
fast. Collisions are theoretically possible but I'm never seen one in
the wild.

>                                                       You can
> use the author timestamp instead, but it also collides (try "%at %ae" in
> the above command instead).

Yes, obviously for the same reason. 
 
> > And now you know why I wish git had subsecond timestamp resolution!  If it
> > did, uniqueness of these in a git stream could be guaranteed.
> 
> It's still not guaranteed. Even with sufficient resolution that no two
> operations could possibly complete in the same time unit, clocks do not
> always march forward. They get reset, they may skew from machine to
> machine, the same operation may happen on different machines, etc.

Right...but the *same person* submitting operations from *different
machines* within the time window required to be caught by these effects
is at worst fantastically unlikely.  That case is exactly why action 
stamps have an email part.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
