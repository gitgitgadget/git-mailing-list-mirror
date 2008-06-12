From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 22:32:45 +0200
Message-ID: <20080612203245.GB8057@steel.home>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home> <20080612062309.GA31816@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tUL-0004cE-M6
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYFLUcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbYFLUcs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:32:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45184 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYFLUcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:32:47 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf50S7
Received: from tigra.home (Fab42.f.strato-dslnet.de [195.4.171.66])
	by post.webmailer.de (klopstock mo3) (RZmta 16.42)
	with ESMTP id g06f4bk5CHBxHd ; Thu, 12 Jun 2008 22:32:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 50BE4277BD;
	Thu, 12 Jun 2008 22:32:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6E45C56D28; Thu, 12 Jun 2008 22:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080612062309.GA31816@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84787>

Jeff King, Thu, Jun 12, 2008 08:23:09 +0200:
> On Thu, Jun 12, 2008 at 08:01:52AM +0200, Alex Riesen wrote:
> 
> > Frankly, it started because I wanted to minimize use of Perl on
> > Windows (because I can't get around ActiveState Perl at work, and it
> > breaks almost everything it touches). Accidentally, it is also faster
> > there (maybe just because it's smaller).
> 
> Ah, right. Well, I am not opposed to getting rid of perl in the test
> scripts (there is core functionality provided by perl, so one can easily
> run git on a system with no perl at all).

"git add --interactive" and "git send-mail". The first has a very good
replacement (git gui). The other, even if not that "core", is a very
popular tool. (And I can't use it at work at all: noone to understand
word "patch" there. And even then, noone would care about change
review anyway).

> However, even with your patch, there is still some perl left, so I am
> not sure that it has really bought us very much.

I was forced to carefully check every instance and am positive that
the others are ok with regard to ActiveState Perl and Windows quirks :)
(IOW, I run the testsuite every day and it aint broke yet)

> > But, as was already noted, tr does not behave the same for all
> > platforms (there were even differences in output, BSD or Solaris put
> > out a stray LF?).
> 
> I think those were all resolved by using perl, and your patch replaces
> them with test-tr.

That was the problem. ActiveState Perl always replaces LF in the
output with CRLF, which caused mismatches with template files in some
tests (even the generated templates had LF line endings, cygwins tools
follow that convention). At first, I tried to get by putting
"binmode(STDOUT)" into every test, but this became boring with a time.
Besides, the lines get very long and ugly (and make conflict resolving
harder).

> > In any case, I wont push this change too hard. I must admit, that
> > there is no real good reason besides one "screwed" company using
> > obsoleted tools in a weird way. And it is a maintenance effort (and
> > people will forget to use test-tr instead of perl and tr).
> 
> There is maintenance effort either way; people need to know not to do
> unportable things with tr (and other tools), and the solution to that is
> to run the test scripts on each platform (something we are starting to
> do).

With test-tr they still have to do all that, but also support its
existence. So I'm not sure.

> So I am not opposed to test-tr, I just wanted you to explain it better
> in the commit log. ;)

I already tried.
