From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 7/11] Avoid git-fetch in `git-pull .` when possible.
Date: Thu, 28 Dec 2006 03:17:01 -0500
Message-ID: <20061228081701.GA18029@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org> <20061228073517.GG17867@spearce.org> <7v8xgsxx1r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 09:17:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzqS8-0004TU-SR
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWL1IRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWL1IRH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:17:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46626 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964960AbWL1IRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:17:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzqRI-0000w3-S9; Thu, 28 Dec 2006 03:16:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A21720FB65; Thu, 28 Dec 2006 03:17:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xgsxx1r.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35538>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Users may also now use `git-pull . foo~3` to merge the early part
> > of branch foo.  This was not previously possible as git-fetch does
> > not know how to fetch foo~3 from a repository.
> 
> I personally think this is not an improvement, but rather a new
> source of confusion.  If the user wants a local merge, there is
> 'git-merge'.  And the distinction between the commands makes it
> clear that local merge can merge any commits exactly because
> they are available locally, while remote fetch+merge needs to
> choose from what the remote side offers so not arbitrary commits
> like foo@{3.days.ago} cannot be pulled.

True.  But you know you are doing a local merge with `git pull .`.
So why should you be restricted from using the capabilities of a
local merge just because the frontend you prefer to use is limited
when its doing remote merges?

I didn't really do this change for this feature, I did for the
performance (see below).
 
> Also I thought there was a configuration variable that talks
> about "remote = ."  (didn't I merge that patch -- I do not
> remember offhand) and I wonder how that interacts with this
> change.

I must have missed that discussion on the list.  Not sure how as
I read everything.  Oh, its that grey stuff upstairs not recalling
history as well as Git does... ;-)
 
> How much performance gain are we talking about here?

It halves my 'git pull . foo' times on my Mac OS X PowerPC 64 system:

  Without: ~900 ms
  With:    ~440 ms

-- 
Shawn.
