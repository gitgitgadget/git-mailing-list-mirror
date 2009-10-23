From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [bug][bisected] git-svn with root branches
Date: Thu, 22 Oct 2009 23:38:15 -0700
Message-ID: <20091023063815.GA15445@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin> <20091022063036.GA8081@dcvr.yhbt.net> <c376da900910220824g2948dc2sa1156bda59b49405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:41:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Dpz-0003gp-IC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 08:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbZJWGiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 02:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZJWGiM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 02:38:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34108 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbZJWGiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 02:38:11 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 31E831F7A1;
	Fri, 23 Oct 2009 06:38:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c376da900910220824g2948dc2sa1156bda59b49405@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131092>

Adam Brewster <adambrewster@gmail.com> wrote:
> > I'm not sure why Adam decided the leading slash needed to be removed for
> > the git refspec.  That said, the globbing/branching code still makes me
> > want to hide under a rock and I'm generally afraid to touch it.
> > I'll wait for Adam to chime in since he's braver than I am :)
> >
> How's this for brave:  I'm not sure why I did that either.
> 
> Looking at it again it seems correct for the leading / to be ignored because
> it has no meaning.  What's the difference between the above config and
> "branches = *:refs/remotes/*" (besides the fact that one works and one
> doesn't)?  In both cases I think I've asked for all of the top-level
> directories to be branches.  But that has nothing to do with the rest of the
> patch, so it shouldn't have been included.

<snip>

> That is, continue disregard the / on the actual input because it means
> nothing, and add a / in places where the code will crash if it's not there.
> Even better would be to find out _why_ $path and $local_ref need a leading /
> and fix it that way, but that's more work that I don't have time for right
> now.

Actually, SVN 1.5+ does not like the leading "/" and trips on an
assertion failure on all cases except a standalone "/".  That is, "/*"
continues to work since we send "/" to SVN::Ra::get_log().

-- 
Eric Wong
