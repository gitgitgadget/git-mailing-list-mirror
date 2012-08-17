From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 03/12] git p4: gracefully fail if some commits could not
 be applied
Date: Fri, 17 Aug 2012 07:58:57 -0400
Message-ID: <20120817115857.GB29214@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
 <1345160114-27654-4-git-send-email-pw@padd.com>
 <502DF10A.2040306@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 13:59:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2LCl-0006ax-4D
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 13:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab2HQL7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 07:59:01 -0400
Received: from honk.padd.com ([74.3.171.149]:41815 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab2HQL7A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 07:59:00 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id D838AD27;
	Fri, 17 Aug 2012 04:58:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7A703313FD; Fri, 17 Aug 2012 07:58:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <502DF10A.2040306@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203612>

luke@diamand.org wrote on Fri, 17 Aug 2012 08:21 +0100:
> On 17/08/12 00:35, Pete Wyckoff wrote:
> >If a commit fails to apply cleanly to the p4 tree, an interactive
> >prompt asks what to do next.  In all cases (skip, apply, write),
> >the behavior after the prompt had a few problems.
> >
> >Change it so that it does not claim erroneously that all commits
> >were applied.  Instead list the set of the patches under
> >consideration, and mark with an asterisk those that were
> >applied successfully.  Like this example:
> 
> I could be wrong about this, but this change doesn't seem to help
> out with "git p4 rebase", which for me at least, is where the
> conflicts usually get picked up first.

Right, this is only about the submit path.  I wasn't thinking
about rebase when I worked on this code (or read your message
about rebase ORIG_HEAD).

> I modified a file in p4, and the same file in git, and then did 'git
> p4 rebase' and it just failed in the rebase in the usual way with a
> big 'ol python backtrace.

The backtraces are not pretty, and should be fixed.  I confess I
never use git p4 rebase, because it should be only git p4 sync +
git rebase @{u}.  There's no conflict handling at all in the git
p4 code.

> If this patch series is intended to sort out conflict handling, then
> it needs a bit more work.

This patch series tries to fix the conflict handling in the
submit path only.  Have to start somewhere.

What do you think we might do about the rebase path?  It feels
like a situation that belongs to native git.  Are there
p4-specific things like $Id$ tags that need help?  We could
just catch the errors from git rebase more gracefully, or exec
directly into git rebase.

		-- Pete
