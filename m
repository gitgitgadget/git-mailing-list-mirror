From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Sun, 19 Mar 2006 20:12:44 +0100
Message-ID: <20060319191243.GB18185@pasky.or.cz>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu> <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com> <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net> <44056BF1.6000109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 20:12:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL3KT-0007fI-TB
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 20:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWCSTMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 14:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWCSTMi
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 14:12:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28817 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750709AbWCSTMh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 14:12:37 -0500
Received: (qmail 21136 invoked by uid 2001); 19 Mar 2006 20:12:44 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <44056BF1.6000109@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17717>

Dear diary, on Wed, Mar 01, 2006 at 10:40:01AM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> It already does. The search order is this, for a ref named 'foo':
> 	$GIT_DIR/foo
> 	$GIT_DIR/refs/foo
> 	$GIT_DIR/refs/tags/foo
> 	$GIT_DIR/refs/heads/foo

Actually, I've hit this recently when supporting an unhappy user on
#git, and I didn't manage to find anything in the archives (but perhaps
I missed it). Is there a particular reason why tags are checked first
than branches?

Why not:

(i) I _think_ that it would be less of a surprise if a branch would be
checked first.

(ii) E.g. Cogito output (cg-status -g) is very confusing when you have a
naming clash - cg-object-id foo will show tag commit ID, but cg-status -g
will say that the "foo" branch has a different commit ID (and it is
_right_).

(iii) Many operations will stop making sense (cg-merge foo, and even
cg-fetch foo will be confused), while in case of the opposite way I can't
think of any command still not making sense.

(iv) A security hole when you auto-fetch tags from remote repositories
- you could then be misled to merge something totally different when the
attacker will introduce a naming clash to your refs hierarchy.

Actually, I'm almost inclined to suggest making Git fail violently in
case of an ambiguous name.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
