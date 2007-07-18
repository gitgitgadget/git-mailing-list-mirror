From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 12:24:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181218090.14781@racer.site>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707181121520.14781@racer.site>
 <86tzs2m1h7.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 13:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7ee-0008CT-TA
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536AbXGRLZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbXGRLZL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:25:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755821AbXGRLZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:25:10 -0400
Received: (qmail invoked by alias); 18 Jul 2007 11:25:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Jul 2007 13:25:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FY48Xg5iF90zxZx0V7chYne550aOqjoZTUcoRJz
	jWv7u0k/etXfHq
X-X-Sender: gene099@racer.site
In-Reply-To: <86tzs2m1h7.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52853>

Hi,

On Wed, 18 Jul 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 18 Jul 2007, David Kastrup wrote:
> >
> >> The FAQ answer is weazeling on several accounts:
> >> 
> >> a) No, git only cares about files, or rather git tracks content and
> >>    empty directories have no content.
> >> 
> >> In the same manner as empty regular files have no contents, and git
> >> tracks those.  Existence and permissions are important.
> >
> > We do not track permissions of directories at all.
> 
> Ok, this seems like something that should be done as well, even if we
> can stipulate at first that a directory should have rwx for the user
> in question if you hope to track it.

No, no, no.  It should not be tracked.  It is the responsibility of the 
_user_ to set it to something sane, be that by a umask or by sticky 
groups, or by setting the permissions of the parent directory.

It is _nothing_ we want to put into the repository.  That is the _wrong_ 
place to put it.

> > This is because Git is primarily meant to track source code,
> 
> Tell that to the man page.  It declares git to be "a content tracker" 
> right at the front.

Why don't you?  I have no problems with the title.

> > and most "permissions" (i.e.  restrictions) do not make any sense
> > there.
> 
> So why are permissions for files being tracked, then?

This question is invalid.  Git only tracks the _executable_ bit.  And 
again, it is the users' responsibility, by setting the umask, to have the 
appropriate bits set for group and others.

> >> b) The problem is not just that empty directories don't get added 
> >> into the repository.  They also don't get removed again when 
> >> switching to a different checkout.  When git-diff returns zero, I 
> >> expect a subsequent checkout to not leave complete empty hierarchies 
> >> around because git can't delete any empty leaves which it chose not 
> >> to track.
> >
> > I _like_ the behaviour that Git does not remove a directory it
> > added, when I put some untracked file into it.
> 
> But it does not remove a directory it _refused_ to add when there were
> no files at all in it ever.  You probably have not read the problem
> description carefully.

I have.  But that does not apply here, because I used the term "to add a 
directory" in the sense of "mkdir".

> > And switching back to that branch, Git has no problems, because it 
> > sees that the directory is already there.  In case of a file, it would 
> > complain, and rightfully so.
> 
> And if you switch to a branch where the directory it did not remove now 
> is a file?

Git already throws an error, and rightfully so.  I am pleased by the 
current behaviour.

> > See the fundamental difference between a file and a directory now?
> 
> Condescension is not really solving a problem.

Hey, I only tried to help clarify things.

But since I seem to be unable to, I'll end my efforts with this 
suggestion:

If you want to track empty directories, the best thing would be to

- teach git-add to automatically create an empty .gitignore (and error out 
  if that already exists), and

- teach git-archive to not put .gitignore files into the output by default 
  (but the directories).  This might be a sensible change regardless if 
  you want to add empty directories to the repository or not.

Ciao,
Dscho
