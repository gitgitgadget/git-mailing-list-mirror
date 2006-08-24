From: Paul Mackerras <paulus@samba.org>
Subject: Re: git cherry-pick feature request
Date: Thu, 24 Aug 2006 22:54:14 +1000
Message-ID: <17645.41334.9069.267396@cargo.ozlabs.ibm.com>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
	<7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
	<17644.21269.128308.313284@cargo.ozlabs.ibm.com>
	<7vhd02bn64.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 14:54:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGEj2-0006XF-OI
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 14:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWHXMyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWHXMyW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 08:54:22 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:24264 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751230AbWHXMyV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 08:54:21 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8C6E367CD0; Thu, 24 Aug 2006 22:54:20 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd02bn64.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25959>

Junio C Hamano writes:

> The combined diff (-c and --cc) comparison works by comparing a
> single post-image (merge result) with multiple pre-images, so I
> think it is reasonable to compare the working tree files as the
> post-image and cached and HEAD-tree versions as the preimages.

Yes, I think that is probably the most useful way around.

> I am not sure how useful this would be though -- I am guessing
> that in most people's workflow the index and the HEAD would
> exactly match most of the time, since that is the way Linus
> encourages (and I follow that myself).  So for that extreme use
> case, the difference between "diff-index HEAD" and the proposed
> command (I am thinking about calling it git-diff-status) would
> be that the latter always has two plus or minus signs instead of
> one, and lines with a single plus or minus would be an
> indication that HEAD and index have drifted.  In other words,
> the largest benefit of "combined diff" which is to simplify
> trivial "The result took this one not that one wholesale"
> differences would not be felt.

The tool I am writing knows whether the index matches the HEAD or the
working directory, and uses a simple git diff-index -p in those
cases.  The only time when the 3-way diff would be needed is when the
user wants to commit a subset of the changes in the working version,
because then the index (== changes to be committed) would be different
from both the HEAD and the working directory.

I could just do the two diffs and combine them in Tcl; I have done
that sort of thing in dirdiff.  It gets a bit complicated though, and
given that we already have C code for an N-way diff, I thought it made
sense to reuse it.

Thanks,
Paul.
