From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: rebase--interactive in C vs. sequencer
Date: Sun, 6 Apr 2008 17:44:54 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804061724210.19665@iabervon.org>
References: <20080405122230.GC14565@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JicgB-0006U1-VI
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbYDFVo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYDFVo4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:44:56 -0400
Received: from iabervon.org ([66.92.72.58]:36803 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbYDFVoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 17:44:55 -0400
Received: (qmail 21316 invoked by uid 1000); 6 Apr 2008 21:44:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Apr 2008 21:44:54 -0000
In-Reply-To: <20080405122230.GC14565@leksak.fem-net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78932>

On Sat, 5 Apr 2008, Stephan Beyer wrote:

> Hi Daniel,
> 
> in [1] you have told that you are working on porting rebase--interactive
> to the C programming language.  In reply, Junio pointed out that a
> consolidated "git sequencer" is desired.
> 
> The sequencer became a project idea for Google Summer of Code and I am
> currently applying for that project.  But I had your mail in mind and 
> do not want that any work of yours is thrown away. ;-)

It's at git://iabervon.org/~barkalow/git/ builtin-rebase-int

> So... what is the current state?

I was mainly working from rebase--interactive, and a lot of what I have is 
the code for the particular steps that uses.

> Are you still working on it?

Not at the moment. I've been busy with a new job recently, and my git work 
has mainly been on builtin-clone.

> Is there a code stub or even more code which could be used for the
> sequencer task?

I haven't actually looked at it recently, so I don't entirely remember how 
far I got. I think my most recent code is based around the idea of having 
a sequence file and a file of saved options, but it's just kind of a 
sketch and most of the stuff isn't actually implemented. IIRC, the last 
thing I ran into was trying to decide where to leave the line for the step 
in progress. I think I'd settled on a set of operations that a step should 
define:

 a) try doing the step, which either works and you go to (c), or it 
    requires user assistance and you exit now and later start at (b)
 b) apply the stuff the user did to help
 c) finish up anything common

For example, merging would be:

 a) try an automatic merge; if it works, succeed, otherwise, write out 
    conflict files and exit
 b) check that the index is merged
 c) make a merge commit

IIRC, for some operations (b) was more interesting, because the case that 
didn't have user assistence generates the final state differently and 
there's less in (c).

	-Daniel
*This .sig left intentionally blank*
