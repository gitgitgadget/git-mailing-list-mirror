From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sat, 9 Jul 2005 23:29:55 +0100
Message-ID: <20050709232955.B31045@flint.arm.linux.org.uk>
References: <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 00:31:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrNrI-0002E7-6T
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 00:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVGIWbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGIWbH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 18:31:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26893 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261760AbVGIWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 18:30:00 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DrNpc-0000lj-TZ; Sat, 09 Jul 2005 23:29:57 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DrNpb-0000Nq-Mj; Sat, 09 Jul 2005 23:29:55 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050709225818.A31045@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Jul 09, 2005 at 10:58:18PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2005 at 10:58:18PM +0100, Russell King wrote:
> On Thu, Jul 07, 2005 at 05:23:26PM -0700, Linus Torvalds wrote:
> > On Thu, 7 Jul 2005, Tony Luck wrote:
> > > This is what happens ("linus" is a local branch just pulled from kernel.org,
> > > so it just contains one pack file and its index).
> > > 
> > > $ cg-update linus
> > > `/home/aegl/GIT/linus/.git/refs/heads/master' -> `.git/refs/heads/linus'
> > > does not exist /home/aegl/GIT/linus/.git/objects/04/3d051615aa5da09a7e44f1edbb69
> > > 798458e067
> > > Cannot obtain needed object 043d051615aa5da09a7e44f1edbb69798458e067
> > > while processing commit 0000000000000000000000000000000000000000.
> > > cg-pull: objects pull failed
> > 
> > Ok. The immediate fix is to just unpack the pack:
> > 
> > 	mv .git/objects/pack/* .git/
> > 	for i in .git/*.pack; do git-unpack-objects < $i; done
> > 
> > (or similar - the above is untested, but I think it should be obvious 
> > enough what I'm trying to do).
> 
> This is evil on the bandwidth, since you'll keep refetching the packed
> object (64MB of it) over and over.
> 
> However, I've tried the above, and I get:
> 
> $ mv .git/objects/pack/* .git/
> $ for i in .git/*.pack; do git-unpack-objects < $i; done
> Unpacking 55435 objects
> fatal: inflate returned -3
> 
> so it seems that the pack is corrupt... or something.
> 
> $ md5sum .git/*.pack
> 2be38f2947b99bcd088c1930122aadec  .git/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
> 
> and git-fsck-cache produces lots and lots of:
> 
> dangling tree fae688b62db0b553aae0bf17f0f70e93819dec2b
> broken link from    tree faed7d798b84f107dbb9ff8fa97fb909c9ea5347
>               to    blob 008e19210e66f01fbaef1aba30243850766b8b12
> broken link from    tree faed7d798b84f107dbb9ff8fa97fb909c9ea5347
>               to    blob edae09a4b021e353ab4fbba756e31492fbb8fd2e
> broken link from    tree faed7d798b84f107dbb9ff8fa97fb909c9ea5347
>               to    blob d098b3ba35384fb912989348fd6da59820711ca4
> ... etc ...

Additional information: x86 box, running FC2, cogito 0.12 built from
the src.rpm on kernel.org.  Lots of disk space (blocks + inodes)
remaining.

Pretty please can we stop breaking rmk's git/cogito/repos/scripts ?

-- 
Russell King
