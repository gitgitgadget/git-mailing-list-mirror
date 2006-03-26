From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 23:09:56 +0200
Message-ID: <20060326210956.GS18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 23:10:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNcUi-00079b-7P
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 23:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCZVJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWCZVJo
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 16:09:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:17056 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751162AbWCZVJn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 16:09:43 -0500
Received: (qmail 6951 invoked by uid 2001); 26 Mar 2006 23:09:56 +0200
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <44264426.8010608@michonline.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18058>

Dear diary, on Sun, Mar 26, 2006 at 09:35:02AM CEST, I got a letter
where Ryan Anderson <ryan@michonline.com> said that...
> Linus Torvalds wrote:
> > On Sun, 26 Mar 2006, Petr Baudis wrote:
> >   
> >>   In [1], Linus suggests a non-core solution. Unfortunately, it doesn't
> >> fly - it requires at least two git-ls-tree calls per revision which
> >> would bog things down awfully (to roughly half of the original speed).
> >>     
> >
> > No it doesn't. It requires one git-ls-tree WHEN SOMETHING IS RENAMED.
> >
> > In other words, basically never.
> >   
> 
> A simple example is the first loop in git-annotate.perl.  (Which was
> basically written by Linus, I just translated it from a
> shell/pseudo-code example into Perl)

One case it does not handle:

         2
      -- b --
  1 /         \ 6
  a             d
    \ 3     5 /
      c --- d

git-rev-list at 6 will (understandably) show

        6 5
        5

and you will never detect the d -> b rename leading to 2.

This is one reason why I'm actually not using --parents and pipe stuff
directly to git-diff-tree --stdin -M and then read its output. This also
lets me merge parallel lines of development based on date and I don't
have to fork per each file deletion.

With any luck I'll have the first draft of my (also perlish) script done
this evening yet. (BTW, it has the same output format as

	git-rev-list | git-diff-tree --pretty=raw -M

so with some tweaking it could also serve as a git-whatchanged backend.
Actually, it would be nice to have it in core Git in the long term so
that it gets all the portability tweaks and such.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
