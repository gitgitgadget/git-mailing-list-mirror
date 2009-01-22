From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CR codes from git commands
Date: Wed, 21 Jan 2009 23:47:39 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
References: <18805.64312.289059.660023@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 05:49:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPrV4-0000aR-OG
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 05:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610AbZAVErm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 23:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756555AbZAVErl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 23:47:41 -0500
Received: from iabervon.org ([66.92.72.58]:56328 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756519AbZAVErl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 23:47:41 -0500
Received: (qmail 19805 invoked by uid 1000); 22 Jan 2009 04:47:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2009 04:47:39 -0000
In-Reply-To: <18805.64312.289059.660023@hungover.brentg.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106718>

On Tue, 20 Jan 2009, Brent Goodrick wrote:

> 
> Hi,
> 
> I am considering converting from CVS over to using git. I'm currently
> using git version 1.5.6.5 on Debian Linux "testing". One of the first
> things I ran into was having to set PAGER to "cat" to avoid the
> problems when running git from anything other than a terminal.  The
> second thing is that "git pull" (and possibly other commands) are
> emitting ^M (octal 013) codes on output, possibly caused by the same
> assumption as causes the problem that is fixed by setting PAGER to
> "cat".  This is not a big deal on small repos, but on larger ones I
> actually do want to see status line output (or be given some option to
> see them), so that I can then run "tail -1lf" on the log file that is
> written during a long "git pull" operation.

It's kind of unclear what you're trying to do here. I'm guessing that 
you're trying to run git with stdio directed to a /dev/tty device, where 
isatty() is true, but which doesn't interpret ASCII control characters as 
such. We're not detecting that you can't use a pager on this, and so you 
have to use PAGER=cat (which might not be a bad idea for things like 
"man", either). With some clues about the environment, we should be able 
to do something about this.

You're also trying to send the progress output to a log file that you can 
look at the end of (presumably in a more capable terminal). It should be 
possible (with an option) to get git to output progress info to a non-tty, 
and not use the CRs if the output isn't a tty.

Or do you want to use a tty that can't handle CRs, and get newlines 
instead of CRs? (If I'd git on the first computer I used, it would have 
printed the progress bar over and over in place and probably torn a hole 
in the paper, but I haven't used that one in over 20 years.)

	-Daniel
*This .sig left intentionally blank*
