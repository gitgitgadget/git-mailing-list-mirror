From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 09:16:42 +0200
Message-ID: <48521EDA.5040802@op5.se>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:17:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K73Xg-0005A3-Iv
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 09:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbYFMHQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYFMHQt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 03:16:49 -0400
Received: from mail.op5.se ([193.201.96.20]:60864 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946AbYFMHQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 03:16:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 50B4E24B0004;
	Fri, 13 Jun 2008 09:13:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bj65i2QVXp3q; Fri, 13 Jun 2008 09:13:21 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 2A1D01B80088;
	Fri, 13 Jun 2008 09:13:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080613055800.GA26768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84843>

Jeff King wrote:
> On Fri, Jun 13, 2008 at 06:26:28AM +0200, Andreas Ericsson wrote:
> 
>> Why are branches better and more appropriate?
>> Is it because the developer who first thought of stashes didn't think they'd
>> be used for any halflong period of time?
>> Is it because there are actions you can do on a branch that you can't do on
>> a stash?
>>
>> Who's to say what's appropriate and not? If I explicitly tell a system to
>> save something for me I damn well expect it to be around when I ask that
>> same system to load it for me too.
> 
> I think we are getting into circular reasoning here (on both sides):
> 
> Branches are better, because they don't expire. Stashes expire, because
> branches are a better way to do what you want.
> 
> Stashes shouldn't expire, because the user told the stash to save
> information. The user considers it a "save" because stashes hold things
> forever. Stashes hold things forever because they shouldn't expire.
> 
> In other words, yes, the developer who thought of stashes didn't think
> they'd be used for a long period of time. That's _why_ they were
> designed as they were. The status quo argument says "this is what a
> stash is, because that is how it is implemented."
> 
> So I would expect people in favor of the change to say "here is why
> long-term stashes are useful." And I would expect such an argument to
> address the fact that we don't simply want to recreate branches (badly).
> In other words, what is the compelling use case that makes people want
> to stash for months at a time?
> 

Ah right. Thanks for clarifying and putting me back on a useful track.

To me, long-living stashes are useful because I can all of a sudden be
pulled away from something I'm working on and set to work on something
entirely different for up to 6 months (so far we haven't had a single
emergency project run longer than that). It doesn't happen a lot, but
it *does* happen.

When that happens, I just leave everything as-is, because that's the
most useful state for me to find it in and serves as a nice bump to jog
my memory as to precisely it was I was working on. When I get back it's
possible that someone else has committed design changes or some minor
bugfixes, so naturally I always fetch to make sure I inspect the latest
changes.

I sometimes have stashes around for a day or two if it turns out I
absolutely have to fix some bug or add something to an API before I
can finish the feature I just started working on and the minor change
turns out to be not-so-minor (or if it requires a day or two of testing
to verify).

Sure, I could probably benefit from starting a topic-branch immediately
and then rebase it later, but I also have a git-daemon running so my
co-workers can fetch the latest from me (I work with back-end stuff
usually, and sometimes they need mockups of soon-to-be-real API stuff
which we'd prefer not to get into the central repository), and I don't
want them to get the stuff I *know* is incomplete. It leads to confusion
and unnecessary work. Stashes are handy there.

This workflow works fine for me, but I'd be appalled if I all of a sudden
got back from a period of being away, did a git-fetch and had git-gc
remove my stash(es). I rarely have more than one or two.

Come to think of it, I think it has actually happened once, and I spent
two days trying to find the changes I knew I had made before I gave up
and wrote it down to the changes having been done on a testing system
and overwritten at a later time.

I think these are the options we're faced with:
1. Never expire stashes (don't shoot the user)
2. Don't treat stashes specially (shoot the user)
3. Don't purge stashes when auto-gc-ing (let the users shoot themselves)
4. Make the behaviour configurable (let the users shoot themselves)
5. Double the expiration time on stashes and warn for them when they should
   normally have expired (during gc, that is) (shoot the user, but warn first).

I'm all for #4 and will cook up a patch for that next week when I'm on
vacation unless #1 gets applied before that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
