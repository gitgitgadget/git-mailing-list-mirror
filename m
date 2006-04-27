From: Peter Hagervall <hager@cs.umu.se>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 22:51:56 +0200
Message-ID: <20060427205155.GA26856@brainysmurf.cs.umu.se>
References: <20060427101254.GA22769@peppar.cs.umu.se> <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain> <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain> <20060427194559.GA26386@brainysmurf.cs.umu.se> <Pine.LNX.4.64.0604271257010.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 22:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZDT7-0004TW-Hs
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 22:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWD0UwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWD0UwG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 16:52:06 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:25300 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751611AbWD0UwF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 16:52:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 85BEC2BB7;
	Thu, 27 Apr 2006 22:52:04 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 21261-02-4; Thu, 27 Apr 2006 22:51:56 +0200 (MEST)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id DDB572BA3;
	Thu, 27 Apr 2006 22:51:56 +0200 (MEST)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id 349FF73C; Thu, 27 Apr 2006 22:51:56 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604271257010.3701@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19243>

On Thu, Apr 27, 2006 at 01:07:27PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 27 Apr 2006, Peter Hagervall wrote:
> > > 
> > > To avoid appending the filename to the path before each lstat() I'd 
> > > guess.
> > 
> > Yes, that's pretty much the reason.
> 
> It's a bad reason, though.
> 
> For one thing, it just doesn't work. You'll have to chdir() back, and you 
> can't use ".." in case the user has set up some symlink thing. So you end 
> up doing other really strange things.
> 
> You can do this much more efficiently with something like this:
> 
> 	const char *obj = git_object_directory();
> 	int len = strlen(obj);

<snip>

> 				continue;
> 			strcpy(prefix + len, de->d_name);
> 			fd = open(prefix, O_RDONLY);
> 			.. check if it's ok, perhaps.. ?
> 			if (ok)
> 				nr++;
> 			close(fd);
> 		}
> 		return nr;
> 	}
> 
> and you're done. Efficient, and it's easy to add the endign to the 
> pathname, because you're passing in a buffer that is big enough, and 
> you're telling people where they should put their suffixes..

Thanks, I'll make a third stab at it tomorrow, if anyone is interested
that is?

	Peter
