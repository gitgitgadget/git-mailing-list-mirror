From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Better error message when we are unable to lock the index file
Date: Sat, 12 Aug 2006 13:16:26 -0400
Message-ID: <20060812171626.GA18401@spearce.org>
References: <20060812073756.5442.5498.stgit@c165> <7v8xluqt24.fsf@assigned-by-dhcp.cox.net> <7v4pwiqss7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Aug 12 19:16:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBx6D-0002c8-Jn
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 19:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWHLRQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWHLRQe
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 13:16:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33488 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964928AbWHLRQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 13:16:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GBx5x-0006Wa-VT; Sat, 12 Aug 2006 13:16:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A7E320FB77; Sat, 12 Aug 2006 13:16:26 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pwiqss7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25261>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Looking at output from:
> >
> > 	$ git grep -A 3 hold_lock_file_for_update
> >
> > I wonder if it might be more consistent to do something like
> > this instead.  It removes more lines than it adds ;-).
> >
> > Most of the callers except the one in refs.c use the function to
> > update the index file.  Among the index writers, everybody
> > except write-tree dies if they cannot open it for writing.
> >
> > diff --git a/refs.c b/refs.c
> > index 28a9394..564f8a7 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -319,7 +319,7 @@ static struct ref_lock *lock_ref_sha1_ba
> >  
> >  	if (safe_create_leading_directories(lock->ref_file))
> >  		die("unable to create directory for %s", lock->ref_file);
> > -	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file);
> > +	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file, 0);
> >  	if (lock->lock_fd < 0) {
> >  		error("Couldn't open lock file %s: %s",
> >  		      lock->lk->filename, strerror(errno));
> 
> Looking at this part further, it seems that this one could
> simply die when it fails -- after all it dies when leading
> directories cannot be created, so dying upon failure of
> hold_lock_file_for_update() would be consistent ;-).

Agreed.

-- 
Shawn.
