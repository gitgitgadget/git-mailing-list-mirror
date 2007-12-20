From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit -n rebuilds revmap w/ 1.5.4.rc0.1187.gc1e8d
Date: Wed, 19 Dec 2007 22:55:13 -0800
Message-ID: <20071220065513.GC17787@muzzle>
References: <784879.48443.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 07:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5FJr-00028C-Nb
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 07:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXLTGzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 01:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbXLTGzQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 01:55:16 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41165 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbXLTGzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 01:55:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1A0E77DC122;
	Wed, 19 Dec 2007 22:55:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <784879.48443.qm@web55007.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68976>

Bill Priest <priestwilliaml@yahoo.com> wrote:
> All,
>   I had been experiencing commit slow downs (> 15
> seconds) so I decided to test it out on 1.5.4.rc0.  I
> use committed a file and it too ~5 seconds which is
> slower than it used to be but much better (I'll need
> to do an apples to apples test to quantify it better;
> e.g. check in the same file w/ a repository in the
> same state).  In the course of using 1.5.4.rc0 I did a
> git svn dcommit -n and observed the following:

Are these slowdowns for commits using git-commit? or for using git-svn
dcommit?

The new rev_map format is very space-efficient, but I haven't optimized
for performance, yet.  It seems to do well enough on Linux that I
don't notice any performance penalty/improvement.  I'm also network
I/O bound for real-world SVN usage, too.

I haven't benchmarked .rev_map much, but the binary search could
certainly be optimized to avoid extra seeks if needed.

> > git svn dcommit -n
> Rebuilding
> .git/svn/mss_release_2.1B3/.rev_map.59aec714-b326-0410-a24e-830352df6fdd
> ...
> r2918 = 992aa04a75fffdbdb65bae815905f96d5e3ef6bd
> r2920 = e68e7f5aead05fc9e7a151e95f43b8283b0ed670
> Done rebuilding
> .git/svn/mss_release_2.1B3/.rev_map.59aec714-b326-0410-a24e-830352df6fdd
> Committing to
> svn://lucille/var/lib/svnrepos/svnMSS/branches/mss_release_2.1B3
> ...
> diff-tree b7cc4c3d32478277c1cdf13e3abdc9dd4a225826~1
> b7cc4c3d32478277c1cdf13e3abdc9dd4a225826
> diff-tree 0bbb656391f5a888d07c98ccce01a4c753ef4997~1
> 0bbb656391f5a888d07c98ccce01a4c753ef4997
> > git svn dcommit -n
> Committing to
> svn://lucille/var/lib/svnrepos/svnMSS/branches/mss_release_2.1B3
> ...
> diff-tree b7cc4c3d32478277c1cdf13e3abdc9dd4a225826~1
> b7cc4c3d32478277c1cdf13e3abdc9dd4a225826
> diff-tree 0bbb656391f5a888d07c98ccce01a4c753ef4997~1
> 0bbb656391f5a888d07c98ccce01a4c753ef4997
> > git --version
> git version 1.5.4.rc0.1187.gc1e8d
> 
> Notice the Rebuilding doesn't seem to be honoring the
> -n "dry run" switch.
> 
> I'm not sure of the implications.  Is this something
> that I should worry about the .revmap being out of
> sync w/ what has actually been dcommit'ed?

--dry-run only means that it won't write to the SVN repository.

There's no need to worry about stuff that's out of sync, .rev_map only
stores information about commits already made to SVN, and is more of an
internal cache for most repositories.

All .rev_map and .rev_db files it replaces are safely deletable
unless you're using noMetadata or useSvmProps with git-svn.

-- 
Eric Wong
