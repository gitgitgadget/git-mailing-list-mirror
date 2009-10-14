From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn with non-standard svn layout
Date: Tue, 13 Oct 2009 23:33:50 -0700
Message-ID: <20091014063350.GB17178@dcvr.yhbt.net>
References: <loom.20091010T001433-536@post.gmane.org> <20091011070937.GC16264@dcvr.yhbt.net> <loom.20091011T205226-197@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabian Molder <fm122@arcor.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxxdi-0005dq-LZ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZJNGeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbZJNGea
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:34:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44223 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbZJNGea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:34:30 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4006F1F92E;
	Wed, 14 Oct 2009 06:33:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20091011T205226-197@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130260>

Fabian Molder <fm122@arcor.de> wrote:
> Eric Wong <normalperson <at> yhbt.net> writes:
> > Hi Fabian,
> > 
> > Since you don't want to track the entire repo and these seem like
> > unrelated (history-wise) trees, you probably want the simplest cases:
> > 
> >   git svn clone svn://example.com/path/to/xapplication2
> >   git svn clone svn://example.com/path/to/aa/bb/cc/xapplication1
> > 
> > These commands are like doing the following with plain old svn:
> > 
> >   svn co svn://example.com/path/to/xapplication2
> >   svn co svn://example.com/path/to/aa/bb/cc/xapplication1
> > 
> > > I tried to use "git config svn-remote.svn.branches" to do this,
> > >  please see in function "do_git_svn" in bash-script - but no success
> > 
> > svn-remote.svn.branches and tags are really only for repos with
> > standard layouts.
> > 
> 
> Hello Eric,
>   hmm, understand,
>   but this just does an checkout to the working dir
> 
>   the reason for using git is:
>     - work offline, with (at least read) access to all the svn branches
>     - have some more (privat, not commit back to svn) branches for experiments
>     - all the nice git stuff ..

Sorry, not sure if I understood you the first time.  The pastie was
hard to read on my screen (big fonts, low res).

I think what you need is to match the number of globs (*) on
both the remote and local sides:

  REMOTE=branches/*/*/aa/bb/cc/zapplication1
  LOCAL=refs/remotes/svn/aa/bb/cc/zapplication1/*/*
  git config svn-remote.svn.branches "${REMOTE}:${LOCAL}"

  #---> matches all in svn repo and also creates subdirs
#
#  git config svn-remote.svn.branches \
#  "branches/r*/development/aa/bb/cc/zapplication1:refs/remotes/svn/branches/*"
#
  #--> Missing trailing '/' on left side of: 'branches/r*/development/aa/bb/cc/zapplication1' (branches/r)

The glob code is still a bit wonky, but it needs to be "/*/" (that is
"*" must have a "/" or nothing, but not "/r*/"

But it looks like the example with 2 globs works.

-- 
Eric Wong
