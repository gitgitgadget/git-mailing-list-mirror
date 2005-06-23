From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 12:45:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506231149460.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506222258290.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:41:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlUle-0004sS-Au
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 18:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVFWQru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVFWQru
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 12:47:50 -0400
Received: from iabervon.org ([66.92.72.58]:47622 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262629AbVFWQrc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 12:47:32 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlUpl-0008TD-00; Thu, 23 Jun 2005 12:45:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506222258290.11175@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:

> On Thu, 23 Jun 2005, Daniel Barkalow wrote:
> 
> > > In fact, you could probably replace every run of contiguous whitespace
> > > with a single space, and then you'd not have to worry about whitespace
> > > differences either. That would be very simple to do, and quite workable: I
> > > certainly think it sounds more reliable than just hoping that people
> > > always pass on a "patch ID" in their emails..
> > 
> > That's actually quite plausible. The only case it wouldn't handle is when
> > you actually discard parts, and I'm not sure at this point what other
> > people should see there.
> 
> Yes. One small note of warning: different "diff" algorithms may under some
> (mostly unlikely) circumstances result in different patches for the
> difference between the same two files. So when comparin SHA1's of diffs
> this way, you should also hopefully have the same diff generation
> algorithm.

I think that, if we care much about the hashes of diffs, we should hash
the diff that's being applied, not hash a regenerated diff (unless, of
course, the diff that's being applied has been modified in hash-relevant
ways, in which case it's not going to match anything anyway).

GNU diff sometimes generates patches which are really terrible to try to
read, because it finds some line of punctuation from a removed block that
matches a line in an added block and interleaves unrelated content. It
would be nice to not have to worry about confusion if there's a mismatch.

Wouldn't the only case where this would be a problem be if we had the
committer apply the patch, generate a diff, hash it, and stick the hash in
the commit? The no-cache version has the diffs for hashing done by the
same person with the same program, and the hash-the-applied-patch version
has the hashes done on the same patch.

> > > Yeah. It probably works well in 99% of the cases to just do a simple
> > > "export as patch" + "apply on top with old commit message, author and
> > > author-date".
> > 
> > I think that you'll get better results out of "merge with top" + "commit
> > with old commit info, but not listing old commit as a parent".
> 
> If I understand you correctly, that assumes that you followed the whole
> chain, though, and that there was no cherry-picking.

I think that the whole-chain case is sufficiently common to make special
and extra smooth; developers will be making their history forwards every
day, and only cherry-picking on occasion.

This is also still in the developer's messy history, and I don't think
those commits are really worth much as history or organization (although
they're wonderful as checkpointing). The cherry-picking there will
generally be content-based rather than commit-based, and will mostly be
picking out hunks to form a clean patch sequence to replace the history.

	-Daniel
*This .sig left intentionally blank*

