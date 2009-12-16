From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone just stops
Date: Wed, 16 Dec 2009 00:15:14 -0800
Message-ID: <20091216081514.GB26038@dcvr.yhbt.net>
References: <1260915555.6475.8.camel@mark.engr.acx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Jerkovic <mjerkovic@aconex.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 09:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKp2d-0004wy-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 09:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761794AbZLPIPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 03:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbZLPIPT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 03:15:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57846 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934679AbZLPIPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 03:15:17 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC311F449;
	Wed, 16 Dec 2009 08:15:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1260915555.6475.8.camel@mark.engr.acx>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135324>

Mark Jerkovic <mjerkovic@aconex.com> wrote:
> Hi all,
> 
> I am new to Git and I am attempting to clone a SVN repository
> (containing approximately 60,000 commits) to Git.
> 
> Using Git v1.6.0.4 with the following command:
> 
> git svn clone https://path/to/svn/repo/trunk project.git
> --authors-file=svnauthors.txt --no-metadata
> 
> the process just ends without any messages and the Git repository is
> empty.  I have attempted this four times already, and each time it has
> stopped after a different revision, so I can't pin it down to a
> particular commit.

Hi Mark,

Any chance you're OOM-ing (extremely large file) or running
out of space somewhere?  What exit code do you get when it exits?

> Has anyone experienced this before?  Is there a log anywhere that
> records what is happening during this process?

Not without error messages of some sort.  git svn was designed with poor
network conditions in mind and clone is resumable, so you can just
resume like this:

   cd project.git && git svn fetch

I wouldn't use --no-metadata at this point, though, as it makes it much
harder to debug/fix things or recover from errors.

Once you're comfortable with it, you should be able to write
"git filter-branch" invocation to remove the metadata lines.

-- 
Eric Wong
