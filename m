From: Andreas Gal <gal@uci.edu>
Subject: Re: More problems...
Date: Tue, 3 May 2005 08:00:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505030757440.29716@sam.ics.uci.edu>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
 <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
 <20050429221903.F30010@flint.arm.linux.org.uk>
 <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
 <20050502193327.GB20818@pasky.ji.cz> <Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0505021509530.3594@ppc970.osdl.org> <20050503014816.GQ20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:56:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSynu-00019S-C5
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVECPBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVECPBd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:01:33 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:1690 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261572AbVECPBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 11:01:25 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j43F0lPV029742;
	Tue, 3 May 2005 08:00:47 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j43F0gMl029738;
	Tue, 3 May 2005 08:00:42 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503014816.GQ20818@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I am just soft-linking objects/ in the branched tree. I can live with 
dangling objects, branching is extremly fast, and diskspace is cheap 
anyway. The only downside is that it doesn't work too well with rsync as 
network protocol, but I use only http-pull and rpush anyway.

Andreas

On Tue, 3 May 2005, Petr Baudis wrote:

> Dear diary, on Tue, May 03, 2005 at 12:19:16AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> > But for "normal" situations, where you have a tree or two, the hardlinking 
> > win might not be big enough to warrant the maintenance headache. With 
> > hardlinking, you _do_ need to "trust" the other trees to some degree.
> 
> As long as the trees aren't yours and you aren't doing something really
> horrible with them...
> 
> $ time git-local-pull -a -l $(cat ~/git-devel/.git/HEAD) ~/git-devel/.git/
> real    0m0.332s
> 
> $ time git-local-pull -a $(cat ~/git-devel/.git/HEAD) ~/git-devel/.git/
> real    0m4.306s
> 
> And this is only 13M Cogito objects database. I think one of the
> important things is to encourage branching, therefore it must be fast
> enough; that's why I really wanted to do hardlinks. The disk space is
> important, but the speed hit probably equally (if not more) so.
> 
> BTW, the object database files should have 0444 or such; they really
> _are_ read-only and making them so mode-wise could help against some
> mistakes too.
> 
> It's clear that Cogito should have a way to choose whether to hardlink
> or copy; the question is which one should be the default one and how
> should it be specified.  I thought about using file:// vs. just local
> path to differentiate between copy and hardlinking, but that'd be
> totally non-obvious, therefore bad UI-wise.
> 
> BTW, I've just committed support for pulling from remote repositories
> over the HTTP and SSH protocols (http://your.git/repo,
> git+ssh://root@git.nasa.gov/srv/git/mars) (note that I was unable to
> test the SSH stuff properly now; success reports or patches welcome).
> Also, the local hardlinking access is now done over git-local-pull,
> therefore the cp errors should go away now.
> 
> I'm not yet decided whether locations like
> 
> 	kernel.org:/pub/scm/cogito/cogito.git
> 
> should invoke rsync, rpull, throw an error or print a fortune cookie.
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
