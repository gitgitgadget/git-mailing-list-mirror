From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Tue, 17 May 2005 23:45:33 +0200
Message-ID: <20050517214533.GP7136@pasky.ji.cz>
References: <20050517201436.GC7136@pasky.ji.cz> <Pine.LNX.4.21.0505171645130.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 17 23:52:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9yY-00059j-QQ
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVEQVue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVEQVqx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:46:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51940 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261990AbVEQVpp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:45:45 -0400
Received: (qmail 28396 invoked by uid 2001); 17 May 2005 21:45:33 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505171645130.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 11:20:54PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Tue, 17 May 2005, Petr Baudis wrote:
> > Anything that gets eventually wound up in the info/ directory. (The name
> > of the ignore file saved in info/ignore is the current hit.)
> 
> Hmm... maybe the right thing is to make the implementation-provided
> transfer code handle arbitrary things in GIT_DIR, but have code for
> updating reference files atomically and using a reference file to start
> from use "refs/"? Certainly, there's nothing special about reference files
> in transit.
> 
> Certainly the things in the info/ directory shouldn't be treated a head
> that you're going to pull, so that has to be different above the protocol
> level anyway.

*confused* :) I'm sorry, I have trouble understanding this. Could you
rephrase, please?

> > Well, it'd be again nice to have some generic mechanism for this so that
> > the user could theoretically push over rsync too or something (although
> > that'll be even more racy, it is fine for single-user repository).
> 
> Hmm; I'm not sure what would be good for interfacing with rsync.

I've been thinking about writing some FTP-like client for rsync, where
you could "interactively" tell it what files to download etc.

> > I think the remote file to write the value inside should be porcelain
> > business.
> 
> Certainly it's porcelain business what remote file to write; but I think
> it has to be core business doing the lock, test, and update. I think it
> would be inconvenient to go back to the porcelain layer in the middle of
> the operation, particularly since it would have to go back to the core,
> which is what has the connection to the remote host.

Of course. The porcelain file would just provide the filename.

> > What you should always check though is that before the pull
> > (and after the locking) the value in that file is the same as the "push
> > base". This way you make sure that you are still following a single
> > branch and in case of multiuser repositories that you were fully merged
> > before pushing.
> 
> So the remote receiver should get an instruction: change X from OLD to NEW
> and pull NEW. It should:
> 
>  - lock the file against further updates
>  - check that the current value is the provided OLD
>  - pull the necessary objects
>  - write NEW to the file
- unlock the file ;-))
>  - report success
> 
> On failure of any step, it should unlock the file without changing it.

Sounds right.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
