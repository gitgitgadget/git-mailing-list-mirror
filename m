From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv2 2/2] Add 'git svn reset' to unwind 'git svn fetch'
Date: Thu, 4 Jun 2009 15:38:42 -0700
Message-ID: <20090604223842.GA32010@dcvr.yhbt.net>
References: <1244087152-17002-1-git-send-email-ben@ben.com> <1244087152-17002-2-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Jackson <ben@ben.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 00:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCLaE-0000wV-NO
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 00:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZFDWim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZFDWil
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 18:38:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41897 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbZFDWik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 18:38:40 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF85F1F44D;
	Thu,  4 Jun 2009 22:38:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244087152-17002-2-git-send-email-ben@ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120725>

Ben Jackson <ben@ben.com> wrote:
> Add a command to unwind the effects of fetch by moving the rev_map
> and refs/remotes/git-svn back to an old SVN revision.  This allows
> revisions to be re-fetched.  Ideally SVN revs would be immutable,
> but permissions changes in the SVN repository or indiscriminate use
> of '--ignore-paths' can create situations where fetch cannot make
> progress.
> 
> Signed-off-by: Ben Jackson <ben@ben.com>
> ---
> 
> Update ensures revision input is numeric.
> 
> On Wed, Jun 03, 2009 at 05:24:06PM -0700, Eric Wong wrote:
> > Ben Jackson <ben@ben.com> wrote:
> > > 3.  Without --parent it should probably fail for a nonexistent rev rather
> > > than automatically find_rev_before..
> >
> > Probably best to ignore the --parent flag and just pass 1 as the second
> > argument to find_rev_before.  That's how SVN operations work when a
> > non-exact revision is specified..
> 
> That is how '-r' works.  Passing '1' to find_rev_before *skips* the
> input rev.  The theory is that you may know that r1000 is "bad" and
> so you use 'git svn reset -r1000 --parent' to discard r1000 (while
> 'reset -r1000' *keeps* r1000, analagous to 'git reset SHA').  You could
> get the same effect with 'git svn reset -r999' (and internally that's
> identical).  I looked for a SVN syntax to copy, eg '-r1000^' if it were
> like GIT, but I didn't see one.  I know I am overloading --parent which
> means something else for other git-svn commands, so I'm happy to remove
> that if you don't like it.

Ah, I always subconciously just decremented the revision number
by 1 myself.  Maybe adding "^"/"~" handling to git-svn to handle
SVN revisions would work, too, but --parent is fine, I guess.

This series acked and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong
