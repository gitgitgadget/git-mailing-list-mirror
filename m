From: Eric Wong <normalperson@yhbt.net>
Subject: Re: following untracked parents in git-svn
Date: Tue, 22 Dec 2009 10:38:29 -0800
Message-ID: <20091222183829.GA7412@dcvr.yhbt.net>
References: <20091222102815.GA12259@sigfpe.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9cx-00059T-AK
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbZLVSia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZLVSia
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:38:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38978 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbZLVSia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 13:38:30 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC041F4F1;
	Tue, 22 Dec 2009 18:38:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091222102815.GA12259@sigfpe.ibm.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135592>

Robert Schiele <rschiele@gmail.com> wrote:
> Hi Eric et al.,
> 
> While using git-svn to work with a repository with a very complex history I
> discovered a very unfortunate behavior:
> 
> In general when a branch was derived (copied) from somewhere else git-svn
> follows this parent branch and imports it.  If multiple branches do that
> git-svn detects that the corresponding parrent branch already had been
> imported and reuses the imported data.  Unfortunately when the parent
> directory in the svn repository is not tracked as a branch in the svn-remote
> section of the config file (for instance when it is just a subdirectory of a
> tracked branch) this situation is no longer detected and this parent branch is
> imported multiple times with the same result.  In a large repository this can
> increase importing time drastically.
> 
> My analysis (as far as I understand the code) is that this is because the map
> files in .git/svn are indexed by their ref name in the git repository.
> Untracked branches are indexed by the name of their following branch ref name
> followed by @XX where XX is the revision number of the branch point.
> Obviously with that scheme the index name for two branches following a common
> parent tree is different and thus an already imported tree is not correctly
> detected.

Hi Robert, I'm aware of this problem.  It's not hit too often, but
occassional repositories I follow tend to hit this.

> My thoughts where now that this could potentially be fixed by not indexing
> those map files by their ref name in the git repository but by their location
> in the original svn repository.  Given that my understanding of the git-svn
> code is not good enough to decide about all the consequences of such a design
> change I'd like to ask you whether you think this change would be a good idea
> or whether I might have overlooked a fundamental problem that makes it
> impossible (or at least hard) to implement this idea.

Your idea sounds like it should work.  Unfortunately the code is a mess
and I've been lazy and lacking time/sufficient motivation to clean it
up, but I'd be glad to accept patches since the test coverage is pretty
good.

-- 
Eric Wong
