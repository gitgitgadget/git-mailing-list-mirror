From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Thu, 19 May 2005 12:00:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505191147480.30848-100000@iabervon.org>
References: <20050519065207.GB18281@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 19 18:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYnRy-0002Hp-3k
	for gcvg-git@gmane.org; Thu, 19 May 2005 18:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVESQBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVESQBc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 12:01:32 -0400
Received: from iabervon.org ([66.92.72.58]:61703 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261418AbVESQB0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 12:01:26 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DYnRz-0006cc-00; Thu, 19 May 2005 12:00:43 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050519065207.GB18281@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Petr Baudis wrote:

> Dear diary, on Thu, May 19, 2005 at 05:19:01AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> >  2) fetching reference files by name, and making them available to the
> >     local program without writing them to disk at all.
> >  3) fetching other files by name and writing them to either the
> >     corresponding filename or a provided replacement.
> > 
> > I had thought that (2) could be done as a special case of (3), but I think
> > that it has to be separate, because (2) just returns the value, while
> > (3) can't just return the contents, but has to write it somewhere, since
> > it isn't constrained to be exactly 20 bytes.
> 
> Huh. How would (2) be useful and why can't you just still write it e.g.
> to some user-supplied temporary file? I think that'd be still actually
> much less trouble for the scripts to handle.

(2) is what is needed if the user just requests downloading objects
starting with a reference stored remotely, and doesn't request that the
reference be written anywhere. It is also useful because the system wants
to verify that it has actually downloaded the objects successfully before
writing the reference.

Note that the scripts see a higher-level interface; these are the
operations that (e.g.) http-pull.c has to provide for pull.c, which builds
a larger operation (determine the target hash, download the objects, write
the specified ref file) out of them. It would be inconvenient for pull.c 
to download to a temporary file and then read the temporary file, which
shouldn't normally be visible yet, to figure out what it's doing. It wants
to have a function that takes a string and returns a hash, getting the
value from the remote host, and it's inconvenient to deal with the disk in
the middle.

	-Daniel
*This .sig left intentionally blank*

