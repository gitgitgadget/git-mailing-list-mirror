From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's in git.git (stable)
Date: Sun, 29 Jul 2007 12:40:01 -0400
Message-ID: <20070729164001.GA9597@thunk.org>
References: <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> <85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz> <20070729031612.GB17204@thunk.org> <85ir83zijd.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 18:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFBot-0001Kt-N5
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 18:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763385AbXG2Qkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763122AbXG2Qkh
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 12:40:37 -0400
Received: from THUNK.ORG ([69.25.196.29]:37341 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761554AbXG2Qkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 12:40:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IFBx6-0002BN-Dg; Sun, 29 Jul 2007 12:49:10 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IFBoI-0004ui-19; Sun, 29 Jul 2007 12:40:02 -0400
Content-Disposition: inline
In-Reply-To: <85ir83zijd.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54123>

On Sun, Jul 29, 2007 at 11:05:42AM +0200, David Kastrup wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > So I really am beginning to think the right answer is to give up on
> > using git-mergetool to support anything other than basic emacs users
> > (who just use emacs as an editor, what a concept),
> 
> In contrast, you are trying to support only people by using Emacs
> _not_ as an editor, but as a mergetool under the control of git.
> That's a mistake.

The whole *point* of git-mergetool is to automatically call merge
tools so you can do three-way merges under the control of git.  

If you just want an *editor* then you can just edit the files that are
listed as being in conflict after a failed merge or after running "git
status".  You can do that today without using git-mergetool at all!

> Sorry, but you are way off here.  The normal, standard use of Emacs is
> to start it once and do everything in it.  Its startup time is such
> that other uses are not feasible.

Huh?  The startup time of running emacs for me is well under a second
(and I have a 20k ~/.emacs.el file that loads a number of other
files).  I'm sure if you put enough *crap* into your .emacs.el file,
you can make it take a huge amount of time, but I suspect your idea of
what is "normal" for emacs is more than a little skewed.

> So git's mergetool philosophy is currently _straight_ set against the
> way Emacs is designed to work.

So don't use git-mergetool.  Like I said, I suspect the right answer
is contrib/git-mergetool.el, and do everything inside emacs.  If you
are as extreme as someone who pulls in gazillions of emacs packages,
and you are using emacs as a desktop, a shell, and a window manager,
then you can probably do much better using a pure emacs lisp merge
system.

Git mergetool is fundamentally designed to work with tools like meld,
kdiff3, xxdiff, tkdiff, etc.  These are all merge tools, and they work
a certain way.  They expect, and need, to be driven a certain way.  If
you insist on following a fundamentally different paradigm, then past
a certain point git-mergetool is not going to make you happy no matter
what I can do.  The point is, git-mergetool does *need* to do know
when you are done doing a merge, and it needs to know if you've
decided to abandon a merge.  Right now ediff doesn't fit well into
that paradigm.  And that's fundamentally ediff's fault; we can do some
kludgery on the git-mergetool side, but the end result will always be
unsatisfactory, and will require that the person using it to *know*
that it is done.

I, personally, don't feel like trying to twist git-mergetool into
doing the right thing depending on whether you have emacs21, emacs22,
emacs23-snapshot, whether or not the desktop package is in use,
whether or not the user is using emacsclient or not, yadda, yadda,
yaddda.  If you want to take a crack at doing *all* of that mess, and
provide a complete solution, send me patches and I'll look at them.

I think it will add a huge amount of *crap* into git-mergetool in
order to support all possible use cases (I'm not interesting in
putting in hackery just for your favorite use case, if it causes other
users to scratch their heads in befuddlement and confusion), but feel
free to prove me wrong.  

As someone who has used emacs for over two decades, and have written
very sophisticated emacs lisp code during nearly all of those 21 years
(1986--2007; my first use of emacs was on a Vax 750 running BSD 4.3
--- if you want to talk about emacs taking a long time to start up, I
remember what it was like 20 years ago), I'm pretty well aware of what
you can and can not do in emacs, and I think I can say with fairly
good authority that for the amount of effort it would take to try to
get git-mergetool to hack around all of these different cases, writing
git-mergetool.el will probably be easier, and result in a cleaner,
better integration with people who like to live their entire lives in
a single emacs session.

					- Ted
