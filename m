From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 16:01:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506281535340.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 23:00:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnNBh-0002r4-SM
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVF1VGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVF1UEF
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:04:05 -0400
Received: from iabervon.org ([66.92.72.58]:61444 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261261AbVF1UDL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 16:03:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DnMGb-0008CU-00; Tue, 28 Jun 2005 16:01:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Linus Torvalds wrote:

> On Tue, 28 Jun 2005, Linus Torvalds wrote:
> > 
> > I can certainly add an option to git-pack-file that disables writing of
> > the index file, and just writes the pack-file to stdout.
> 
> Done.

What I actually meant was that it would be useful for git-ssh-push to be
able to pack stuff as a function call rather than execing an external
program, because just sticking git-ssh-push at the end of a pipeline
doesn't work if you don't remember what the remote side has.

> >						 I'm not sure I
> > want to write the "parse incoming pack-file" thing, but git-unpack-objects
> > comes _reasonably_ close (but right now it seeks around using the index
> > file to resolve deltas, instead of keeping them in memory and resolving
> > them when possible).
> 
> I'm still thinking about this one. I think I'll just do it.

One possibility would be to put a special type tag (like '\0') before the
hash, so that the format is more deterministic.

> One problem here is that since we don't know how big the incoming
> pack-file will be, in a streaming input environment the receiver needs to
> either make the pack-file reception be the last thing it sees, or it will
> have to live with the fact that "git-unpack-objects" will read some more
> than it needs before it notices that it got it all...

In a completely streaming environment, yes; but the receiving side is the
one sending commands, so you don't run into the next thing unless you're
overlapping requests. Failing that, we can just keep a 4k buffer of stuff
we've already read around; we don't have to worry about reading into
something we won't want to read at all.

	-Daniel
*This .sig left intentionally blank*
