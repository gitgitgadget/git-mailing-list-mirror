From: Pete Wyckoff <pw@padd.com>
Subject: branch tracking: inherit upstream
Date: Fri, 15 Jul 2011 07:09:28 -0400
Message-ID: <20110715110928.GA3425@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 13:09:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhgH4-0007En-CD
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 13:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab1GOLJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 07:09:33 -0400
Received: from honk.padd.com ([74.3.171.149]:55312 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1GOLJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 07:09:32 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 419491FA1;
	Fri, 15 Jul 2011 04:09:32 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E2D7B3148F; Fri, 15 Jul 2011 07:09:28 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177197>

At work, our primary SCM is perforce (p4), but many of us use git
in front of that for day-to-day work.  The build system requires
information about what part of the P4 repository it is building.
I've cobbled together changes to make this work with git, and
have been using "git merge-base HEAD @{upstream}" to find the
top-most git-p4 commit.

But @{upstream} is not automatically inherited by branches.  It
is fine when a local branch is a normal tracking branch of
origin/master, like:

    $ git checkout master
    $ git rev-parse --symbolic-full-name @{upstream}
    refs/remotes/origin/master

But I'd also like this to work:

    $ git branch feature
    $ git checkout feature
    $ git rev-parse --symbolic-full-name @{upstream}
    error: No upstream branch found for ''
    @{upstream}
    error: No upstream branch found for ''
    fatal: ambiguous argument '@{upstream}': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions

I know I can do:

    $ git branch --set-upstream feature origin/master

but that is a pain.  And I know I can track the local master, but
that is not what I want.

I'm looking for something like "branch.autosetupupstream" that
would cause the upstream of new branches to be copied from the
old branch (when it exists).  Does this make sense?

		-- Pete
