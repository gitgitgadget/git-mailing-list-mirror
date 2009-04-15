From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GPG signing for git commit?
Date: Wed, 15 Apr 2009 12:20:54 -0700
Message-ID: <20090415192054.GE23604@spearce.org>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 21:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuAgn-0008Tb-Og
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 21:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZDOTU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbZDOTU4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 15:20:56 -0400
Received: from george.spearce.org ([209.20.77.23]:36167 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZDOTUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 15:20:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EBE5338211; Wed, 15 Apr 2009 19:20:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090415185554.GG23644@curie-int>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116645>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> 
> One of the spots that we're looking for in this, is a model something
> like what follows. Firstly, a "proxy maintainer" (PM) is a developer
> with commit rights to the central repo, that's willing to proxy commits
> by an outside source for some specific package. Think of them as the
> kernel subsystem maintainer, but many more of them. The PM is still
> expected to verify the work before passing it on the central repo.
> 
> So we have a commit with author+committer being the outside source, and
> now we want to record (in an easily reviewable fashion) that a specific
> changeset was introduced to the central tree by the PM.
> 
> Not sure of the best route to trace this data. Signing the SHA1 makes
> the most sense, but need to be able to do that without polluting the tag
> namespace.

Have the PM push over SSH, and don't ever expire reflogs on the
central repository?  The reflog will have the old and new commits
and the user name of the PM.

Downsides are:

- data is in the reflog on the central repository, to access it
  you need to expose that file via some non-git means (e.g. http
  or direct shell).

- one reflog record may cover multiple commits, so looking up a
  single commit is very difficult.  no current tools exist to merge
  the reflog back against the commit history to attach the record
  to a range of commits.

- the reflog is a text file, it will get somewhat large with time.

- the reflog is destroyed when the branch is deleted.  you may need a
  hook to forbid deletion of critical branches, so the reflog stays.

-- 
Shawn.
