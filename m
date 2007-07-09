From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 09 Jul 2007 15:49:18 +0200
Message-ID: <20070709134918.GT1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091257470.5546@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7tcB-0004bu-Lm
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbXGINtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbXGINtV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:49:21 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:60287 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbXGINtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:49:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKW0046BZQ6SP@psmtp12.wxs.nl> for git@vger.kernel.org; Mon,
 09 Jul 2007 15:49:19 +0200 (MEST)
Received: (qmail 14036 invoked by uid 500); Mon, 09 Jul 2007 13:49:18 +0000
In-reply-to: <Pine.LNX.4.64.0707091257470.5546@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51993>

On Mon, Jul 09, 2007 at 01:57:10PM +0100, Johannes Schindelin wrote:
> On Mon, 9 Jul 2007, Sven Verdoolaege wrote:
> > On Mon, Jul 09, 2007 at 12:56:04AM +0100, Johannes Schindelin wrote:
> > I thought you had to specify the name of the new branch on the command
> > line.  Anyway, I don't really care about the name of this hierarchy.
> > I just picked a name that is somewhat related to "rewrite-commits".
> > Suggestions are welcome.
> 
> How much more explicit should I formulate my suggestion?
[..]
> actually changed.  So even if you _have_ to keep your current behaviour, 
> namely that the results are stored under the original names, you should 
> store the original refs in something like refs/original (overridable by a 

I suppose I can live with "original".

> command line option), but _only if_ they actually changed.

That's what I do right now.

> You will see that both definitions apply _perfectly_ to what you do here.  
> You pipe the commit into the "map" and write it out as a new commit!  
> The _perfect_ example for a UNIX filter.

OK.  Makes sense.
I've always found that naming confusing, but it has a long tradition.
Sorry for the strong word.

> > > - The example you give with "git update-index --remove" can fail, right? 
> > 
> > Yes.  Spectacularly, even.
> 
> Does that mean you acknowledge that the man page should tell about this?  
> And probably also reveal the "|| :" remedy?

Yes.  (Am I on trial, here?)

> > > - The commit filter again deviates from the usage in cg-admin-rewritehist. 
> > >   I can see that you wanted to make it more versatile. However, it makes 
> > >   the tool potentially also a bit more cumbersome to use. Besides, you use 
> > >   a temporary file where there is no need to.
> > 
> > Are you saying I should use two pipes?
> 
> Umm.  Why not?
> 
> > What if the commit message is larger than the pipe buffer?
> 
> You start_command().  Then you write() until it is all written, or the 
> pipe is broken.  Then you get the output via index_pipe().  Which is a 
> single sha1.  I do not understand your question.

Ah, but that is not how my commit "filter" works right now.
It should produce the whole commit on stdout (as mentioned in the documentation).
So the default filter is "cat" (and not "git-hash-object -t commit --stdin",
as you seem to assume).

How about I change that to a filter that accepts a single SHA1 and
produces zero or more SHA1's as output?
A filter for the current rewrite-commits would then be replaced
by "xargs | git-cat-file commit | original-filter | git-hash-object -t commit --stdin"

> To enhance on the above example: you're rewriting the commit messages so 
> that commit names are rewritten to match the rewritten commits.  That is 
> possible by a message filter in cg-admin-rewritehist.
> 
> But now somebody comes along, and says "I have a history I need to 
> rewrite.  All bug fixes.  The commit names were all abbreviated in the 
> commit messages, but they always had 'commit ' in front of them.  I want 
> to rewrite them, too."

The current git-rewrite-commits will rewrite all SHA1's it can find,
irrespective of any 'commit ' that may precede it.
I guess I'm trying to misunderstand you again.

> Are you trying to misunderstand me?

No.

> > > But hey, maybe it _is_ time to rethink the whole filter business, and 
> > > introduce some kind of regular expression based action language. 
> > > Something like
> > > 
> > > 	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \
> > 
> > What's wrong with --author='!Darl McBribe' ?
> 
> It is a very special use case.  Not always will you be able to get all the 
> information from the commit object you need for conditional operations.  
> My example only showed that you can do the same with that syntax.  But 
> imagine what you could do if we just added a small syntactical sugar:
> 
> 	-e '?has-path:README?substitute/v2/v3/'

So you want to introduce a whole language?
Isn't that a bit over-engineering?

skimo
