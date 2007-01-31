From: Theodore Tso <tytso@mit.edu>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 17:51:21 -0500
Message-ID: <20070131225121.GC20514@thunk.org>
References: <87odognuhl.wl%cworth@cworth.org> <20070130231015.GB10075@coredump.intra.peff.net> <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net> <20070131032248.GA17504@coredump.intra.peff.net> <Pine.LNX.4.64.0701310932320.3021@xanadu.home> <20070131170752.GA19527@coredump.intra.peff.net> <7vhcu7uewe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 23:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOIg-0003im-GI
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 23:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXAaWvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXAaWvb
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 17:51:31 -0500
Received: from thunk.org ([69.25.196.29]:50576 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbXAaWva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 17:51:30 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HCONT-00047R-R2; Wed, 31 Jan 2007 17:56:32 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HCOIT-0001Z1-Jc; Wed, 31 Jan 2007 17:51:21 -0500
Content-Disposition: inline
In-Reply-To: <7vhcu7uewe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38301>

On Wed, Jan 31, 2007 at 12:20:33PM -0800, Junio C Hamano wrote:
> I think you (and others in the thread) are forgetting that
> moving to a particular state by resetting can create a state
> that you may want to keep a pointer to, but you do not have any
> existing ref.  That's one of the reasons why we do not merely
> check if the detached HEAD is not reachable from any of the
> existing refs when coming back.  Instead, we check and warn if
> the detached HEAD does not exactly match one of the existing
> refs.

Is that an important distinction?  The way the user got there was by
manually specifying the SHA-1 shash of the commit to git-checkout.  So
if the user could get there once, the user could get there again a
second time.  Just because we don't have a name to that precise commit
inside the git system doesn't necessary mean the user can't get back
there.   In fact, the user probably could via "history | grep 'git checkout'".

> So "until you make commits" is not sufficient, which means that
> covering all the way you can make commits isn't, either.

My personal belief is that covering all the way you can make commits
is where you want to be putting the check.  If I say something like

git checkout f00b51b8

There's nothing dangerous about that statement.  To argue that this is
dangerous and the git needs to warn me because I might not be able to
get back to it seems silly.  Of _course_ I can get back there; the
same way I got here in the first place --- By simply saying, "git
checkout f00b51b8" again!

And if I tell a user that they should try out a particular version of
the code, issueing a scary message right then there is pointless if
they are only going to be doing a read-only browse of the tree, is
just a Bad Thing.  The best place to warn them really is when they
modify the tree.

Otherwise, we'll be educating users to use the -f flag, or telling
users to "ignore the warning, git's being silly", neither of which is
desirable.

						- Ted
