From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 19:05:36 +0200
Message-ID: <4720CCE0.2090007@op5.se>
References: <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 25 19:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il69e-0008G4-1P
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 19:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbXJYRFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXJYRFp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 13:05:45 -0400
Received: from mail.op5.se ([193.201.96.20]:38559 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbXJYRFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 13:05:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5F2711730719;
	Thu, 25 Oct 2007 19:05:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfFAxj1yJ82s; Thu, 25 Oct 2007 19:05:38 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 84981173071D;
	Thu, 25 Oct 2007 19:05:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071025152159.GB22103@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62336>

Theodore Tso wrote:
> On Thu, Oct 25, 2007 at 04:58:13PM +0200, Andreas Ericsson wrote:
>> Correct. I'm working on optimizing it right now though :)
> 
> We await your patches.  :-)
> 
>>> Another would be to set up a wrapper script for "git-clone" that
>>> creates a separate local working directory for each branch.  So for
>>> example, it might do something like this:
>>>
>>> #!/bin/sh
>>> # Usage: get-repo <URL> [dir]
>>> ...
> 
>> Not really, I'm afraid. Apart from missing out on the auto-download of
>> new repos you get with "fetch = refs/heads/*:refs/remotes/origin/*",
>> it seems inelegant.
> 
> You mean new branches, right?
> 

Yes. The few topic-branches that require input from several people are
distributed this way for peer review and trouble-shooting. It's nifty
if they're automatically downloaded, but not so much of an issue that
it matters.


> And of course it's inelegant.  You just told us we were dealing with
> CVS-brain-damaged corporate developers who can't be bothered to learn
> about the fine points of using things the git way.

No, they're just surprised that what they thought would be automatic
isn't, and the curse about it when they put themselves in trouble by
forgetting about it. I've done it myself, and I've been using git since
may 2005.

>  And I thought you
> said there were only a few branches, "master", maint", etc. and all
> the developers worked on were the tips of the branches of the
> corporate mothership repository.  
> 

It depends. For small bugfixes we sometimes commit directly on the
checked out branch. For larger issues we usually create a topic branch
and hack away, creating nicely ordered patch-series and such, but those
topic branches must be created from the tip of the upstream tracking
branch. What Dscho suggested would definitely work, but that would
mean I'd have to tell my co-workers to use 'git branch -D', which I'm
quite reluctant to do. One solution to that particular problem is
ofcourse to hack the delete-command of git-branch to honor remote
tracking branches when calculating dependencies, so the local branches
can safely be removed when they're done with them.

However, there's still this issue:
$ git checkout -b foo origin/pu
Branch foo set up to track remote branch refs/remotes/origin/pu.
Switched to a new branch "foo"

git checkout will say that every time a branch is created from a
tracking branch, unless one tells it --no-track (which people don't
learn about unless they're really into git), so it's quite natural
that people think git will actually make sure, within reasonable
limits, that 'foo' is kept in sync with refs/remotes/origin/pu.
That's not the case, however.

So we could either change the message to be:
"Branch foo set up to track remote branch refs/remotes/origin/pu,
provided you only ever issue git-pull while having branch foo
checked out."

Or we could make 'git checkout -b' default to --no-track, perhaps
giving annoying messages everytime someone "git-checkout -b"'s a
remote tracking branch.
Or we could make git-pull keep git checkout's promises.

I'm opting for the latter, since that's the one that makes a piece
of machinery do some work for me. I'd happily call the command
"git-update-all-local-branches-tracking-remote-tracking-branches"
and only ever make it actually do any work if I pass it the option
"--I-bask-in-the-glory-of-local-vs-remote-confusion", but I need
some sort of solution that
a) Doesn't normally present error messages.
b) Doesn't involve routinely using "git branch -D"
c) Doesn't require more than one or two commands per repo to get
the locally checked out copies of the remote tracking branches
(the ones git has "set up to track remote branch remotes/x/branch")
up to date with their remote counterpart.


> It's like complaining that a car with manual transmission is too hard
> to drive, and then when someone points out how this could be done with
> an automatic transmission, and then complaining that that you don't
> have the fine control of a manual transmission.  Well, of course you
> don't!  Having that fine control requires that you *learn* how to use
> that fine control correctly.
> 

Or invent the sensatronic transmission system and get the best of both
worlds. Engineering solutions so they fit humans? Good gods, that's a
novel idea! ;-)

> The solution I presented is more elegant than what hg does with
> separate repositories, but sure, it does require disk space.  But this
> disk space is cheap, even when compared with the salary costs of
> CVS-damanged developers.  :-)
> 

It's not so much CVS-damaged developers as it's conflicting messages.
I'm quite confused about it myself at times, but for me there's
nobody to harrass since I was the one vetoing in git as the scm to
use for all our corporate needs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
