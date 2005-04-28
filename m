From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: suffix array/tree deltas (Was: The criss-cross merge case)
Date: Thu, 28 Apr 2005 00:30:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280016000.30848-100000@iabervon.org>
References: <1114659700.5910.10.camel@thamachine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:25:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR0aa-0004dD-EA
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVD1Ead (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 00:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVD1Ead
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 00:30:33 -0400
Received: from iabervon.org ([66.92.72.58]:18436 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261926AbVD1Ea0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 00:30:26 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR0fR-00006w-00; Thu, 28 Apr 2005 00:30:25 -0400
To: "Zed A. Shaw" <zedshaw@zedshaw.com>
In-Reply-To: <1114659700.5910.10.camel@thamachine>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Zed A. Shaw wrote:

> On Wed, 2005-04-27 at 19:32 -0400, Daniel Barkalow wrote:
> 
> > My plan is to implement multi-file diff and merge with a suffix tree-based
> > algorithm, and then revisit the history stuff once we have a merger that
> > can do sensible things with this information.
> 
> Hey, that's neat.  I've already implemented two versions of this very
> thing with FastCST.  The original used suffix trees, but I found that
> there were plenty of pathological cases which chewed memory and
> processor.  Most of these cases were large (>1MB) PDF files.  Don't ask
> me why PDF drove suffix tree algorithms insane, but they just did.

I'm not too surprised; but can you hope to merge or compare PDFs
anyway? I'd think that you'd just screw up alignment or something. (Note
that we aren't using deltas for history storage, so we're not interested
in the "compressing multiple versions" aspect of diffs.) I think I want to
punt anything too binary-like and try to find an unambiguous history-based
difference (i.e., there was some commit in the past that replaced one of
the versions with the other; therefore, we want the replacing one).

I'm thinking of line-based compressed suffix trees, with the obvious delta
algorithm: make the trees, find the longest prefix of the file, find the
longest prefix of the rest of the file, add an insertion for a line
that doesn't match, repeat. I probably need a few extra things to
stabilize the process (prefer that the next chunk come from the same file,
prefer that it come from next in the file, ignore copied lines without
enough content).

I haven't actually started yet; I'm waiting for a weekend when I'm feeling
inspired and not too fried.

	-Daniel
*This .sig left intentionally blank*

