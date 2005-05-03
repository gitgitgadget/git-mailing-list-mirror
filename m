From: Petr Baudis <pasky@ucw.cz>
Subject: Re: More problems...
Date: Tue, 3 May 2005 03:48:16 +0200
Message-ID: <20050503014816.GQ20818@pasky.ji.cz>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com> <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net> <20050429221903.F30010@flint.arm.linux.org.uk> <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk> <20050502193327.GB20818@pasky.ji.cz> <Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0505021509530.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 03:43:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSmQP-0008Py-5S
	for gcvg-git@gmane.org; Tue, 03 May 2005 03:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVECBsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 21:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVECBsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 21:48:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25784 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261289AbVECBsW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 21:48:22 -0400
Received: (qmail 7605 invoked by uid 2001); 3 May 2005 01:48:16 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505021509530.3594@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 12:19:16AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> But for "normal" situations, where you have a tree or two, the hardlinking 
> win might not be big enough to warrant the maintenance headache. With 
> hardlinking, you _do_ need to "trust" the other trees to some degree.

As long as the trees aren't yours and you aren't doing something really
horrible with them...

$ time git-local-pull -a -l $(cat ~/git-devel/.git/HEAD) ~/git-devel/.git/
real    0m0.332s

$ time git-local-pull -a $(cat ~/git-devel/.git/HEAD) ~/git-devel/.git/
real    0m4.306s

And this is only 13M Cogito objects database. I think one of the
important things is to encourage branching, therefore it must be fast
enough; that's why I really wanted to do hardlinks. The disk space is
important, but the speed hit probably equally (if not more) so.

BTW, the object database files should have 0444 or such; they really
_are_ read-only and making them so mode-wise could help against some
mistakes too.

It's clear that Cogito should have a way to choose whether to hardlink
or copy; the question is which one should be the default one and how
should it be specified.  I thought about using file:// vs. just local
path to differentiate between copy and hardlinking, but that'd be
totally non-obvious, therefore bad UI-wise.

BTW, I've just committed support for pulling from remote repositories
over the HTTP and SSH protocols (http://your.git/repo,
git+ssh://root@git.nasa.gov/srv/git/mars) (note that I was unable to
test the SSH stuff properly now; success reports or patches welcome).
Also, the local hardlinking access is now done over git-local-pull,
therefore the cp errors should go away now.

I'm not yet decided whether locations like

	kernel.org:/pub/scm/cogito/cogito.git

should invoke rsync, rpull, throw an error or print a fortune cookie.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
