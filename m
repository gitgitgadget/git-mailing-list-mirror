From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/3] Support config-based names
Date: Mon, 11 Jun 2007 23:31:34 -0400
Message-ID: <20070612033134.GS6073@spearce.org>
References: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxx73-0000Er-VS
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbXFLDbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbXFLDbj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:31:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33188 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbXFLDbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:31:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hxx6J-00022t-Dx; Mon, 11 Jun 2007 23:31:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6FDC220FBAE; Mon, 11 Jun 2007 23:31:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49916>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> It can be useful to refer to commits in remotes based on their configured 
> relationship to local branches. For example, "git log HEAD^[push]..HEAD" 
> would, when pushing is set up, show what hasn't been pushed yet.

Interesting.

What about `git diff master^[push]@{3.days.ago}^{tree} master` ?

Can anyone even understand that?  Can Git even understand it?
As I follow your code I don't think it would, as the ^[push]
operator seems like it needs to be on the very end of the string,
and it assumes everything to the left of the ^[ is the branch name.
So I also couldn't phrase that as:

  git diff master@{3.days.ago}^[push]^{tree} master

More interesting is just what do you want going on here with the
reflog query and the ^[push] query.  Should the reflog operator apply
before the ^[push] translation, or after?  Or should it depend on
the order of them in the statement?  I can see where you would want
to look at your local tracking branch for the current branch 3 days
ago, which might be "HEAD^[push]@{3.days.ago}".  But I'm not really
sure what the meaning of "HEAD@{3.days.ago}^[push]" is.  Is that
the branch that HEAD was on 3 days ago's push branch?  Huh?  ;-)

Food for thought.

In general it seems our "operators" are ^{foo} or @{foo}, so I wonder
why not ^{push}.  push is not a valid object type, and probably
never will be, so peeling the onion back to get to what ^{push}
means (even though its not an object type) is probably OK.

-- 
Shawn.
