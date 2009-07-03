From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn producing "invalid author/committer line"
Date: Thu, 2 Jul 2009 21:28:46 -0700
Message-ID: <20090703042846.GA14767@dcvr.yhbt.net>
References: <sbqo45dgejpcnt58cam2tfkeon4is2v4ur@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esskov@oncable.dk
X-From: git-owner@vger.kernel.org Fri Jul 03 06:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMaOY-0005gy-9X
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 06:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZGCE2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 00:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbZGCE2r
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 00:28:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42366 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbZGCE2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 00:28:47 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id BD1DA1F84D;
	Fri,  3 Jul 2009 04:28:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <sbqo45dgejpcnt58cam2tfkeon4is2v4ur@4ax.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122679>

esskov@oncable.dk wrote:
> 	Hi,
> 
> We have an SVN repository with a number of projects in its /trunk.
> Different people have r/w-access to different subsets of these projects. 
> 
> When I "git-svn fetch" this repo's trunk there will be some revisions that
> I don't have access to. In SVN log they show up as empty change-sets with
> unspecified author. 
> In the resulting git repo, git-fsck says "error in commit
> 92cf6ec3a55fbbfbf5aea7f0937e4b49470b9112: invalid author/committer line",
> and - as a consequence I guess - git-gc aborts.
> 
> $ git show 92cf6
> commit 92cf6ec3a55fbbfbf5aea7f0937e4b49470b9112
> Author: (no author) <(no author)@xxxx>
> Date:   Thu Jan 1 00:00:00 1970 +0000

Actually, it's not the author, but the date == 0 that fsck.c
has an issue with.  Proposed patch to {fsck,commit}.c coming.

> I tried to run "git filter-branch --prune-empty -- --all", to simply
> discard these empty commits, but the problem remains. 
> 
> After some googling I found a possible work-around, using the
> --authors-file option of git-svn to map the "no author" into something
> less invalid, but I suppose that would require the list to contain every
> other committer as well?
> 
> Could I somehow make "git-svn fetch" skip these empty commits,
> corresponding to revisions that the SVN user doesn't have access to?

You can pass '-r<begin>:<end>' in a way similar to "svn log"
to skip commits:

  git svn fetch -r5:200

-- 
Eric Wong
