From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 11:13:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:13:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqQMn-0003pf-7I
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 12:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbYD1KNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 06:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYD1KM7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 06:12:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbYD1KM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 06:12:59 -0400
Received: (qmail invoked by alias); 28 Apr 2008 10:12:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 28 Apr 2008 12:12:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nUTs63J8nra4uLFYtS8dQVYFWiX+n2UkHa0I/Pd
	qvQQpSzGXXjtSP
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vej8rgq62.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80520>

Hi,

On Sun, 27 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...  It did not help that I hated the fact that that series changed 
> > the original design without even understanding it.
> 
> Care to elaborate on this point further?  I do not get it.

The original implementation of -p was modeled closely after filter-branch, 
in that it created a subdirectory (dotest/rewritten) containing the new 
commit names for those commits that were rewritten.

Now, whenever a commit was picked, the parents would be looked up in 
dotest/rewritten, and replaced with the rewritten name (or left unchanged 
if they were not rewritten).

In that manner, every commit is identified by the (original) commit name.  
<irony>Surprisingly, this is the way Git was meant to operate</irony>

Now, a mark command has been introduced which is totally unnecessary.  
Commits can _still_ be identified by their (original) commit name.  That's 
the whole assumption rebase -i relies on.

Basically, the output of rebase -i -p is ugly now, because you have _two_ 
ways of specifying things, and frankly, I would have to read documentation 
to find out when to use what.  And I maintain that this was not necessary 
with the old way rebase -i operated.

So I am really unhappy that this patch series made it in, and I am even 
more unhappy that my suggestions (which I made, in spite of moving between 
two countries, and in spite of spending a lot of time with someone very 
special, and therefore having less time for Git than I would have liked 
to) were blatantly ignored.

It would have been easier for me if I would not be so utterly convinced 
that the "new" way is so much more complicated and unintuitive than what I 
suggested.

And now it is already in "next", which does not help me at all (me being 
very busy at the moment to find a job).  I am also slightly uneasy about 
the fact that a few obvious mistakes had to be fixed in the last days.

Formulations such as "deliberately leaves $DOTEST directory behind if 
clean-up fails" make me wonder, too: I sincerely hope that I misunderstand 
the intention of this message.

I have the feeling that I have to repeat my point again, so that it is not 
ignored -- again.  Maybe an example would help:

-- snip --
pick abcdefg This is the first commit to be picked
reset cdefghij
pick zyxwvux A commit in a side-branch
merge recursive abcdefg
-- snap --

I am convinced that this syntax does not need much explanation.

A patch implementing a syntax like this would have won my unilateral 
approval (modulo expr/tac quirks, but that would have been easy to fix).

Ciao,
Dscho who does not like complicator's gloves
