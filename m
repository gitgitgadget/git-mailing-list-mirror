From: Junio C Hamano <junkio@cox.net>
Subject: Re: git cherry-pick feature request
Date: Thu, 24 Aug 2006 00:36:19 -0700
Message-ID: <7vhd02bn64.fsf@assigned-by-dhcp.cox.net>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
	<7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
	<17644.21269.128308.313284@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 09:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG9lN-0000BJ-Fp
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 09:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHXHgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 03:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHXHgV
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 03:36:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28292 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750751AbWHXHgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 03:36:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824073620.DUKH29796.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 03:36:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DjcK1V00A4Noztg0000000
	Thu, 24 Aug 2006 03:36:19 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17644.21269.128308.313284@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 23 Aug 2006 23:07:33 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25943>

Paul Mackerras <paulus@samba.org> writes:

> While I'm asking for features, another one that would be really useful
> for another tool I'm writing is a 3-way diff for a file between the
> working directory, the index, and the current head commit, something
> like what git diff-tree -c does for merges.  That is, it would have
> two columns of +/-/space characters, one for the current head and one
> for the index.  A '-' would indicate that the line appears in the
> current head or the index but not in the version of the file in the
> working directory.  A '+' would indicate that the line appears in the
> working directory version.

The combined diff (-c and --cc) comparison works by comparing a
single post-image (merge result) with multiple pre-images, so I
think it is reasonable to compare the working tree files as the
post-image and cached and HEAD-tree versions as the preimages.

I am not sure how useful this would be though -- I am guessing
that in most people's workflow the index and the HEAD would
exactly match most of the time, since that is the way Linus
encourages (and I follow that myself).  So for that extreme use
case, the difference between "diff-index HEAD" and the proposed
command (I am thinking about calling it git-diff-status) would
be that the latter always has two plus or minus signs instead of
one, and lines with a single plus or minus would be an
indication that HEAD and index have drifted.  In other words,
the largest benefit of "combined diff" which is to simplify
trivial "The result took this one not that one wholesale"
differences would not be felt.

I have to visualize the result a bit before coding this.
