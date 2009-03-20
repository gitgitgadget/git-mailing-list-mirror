From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn with multiple branch directories
Date: Fri, 20 Mar 2009 03:04:11 -0700
Message-ID: <20090320100411.GB17287@dcvr.yhbt.net>
References: <alpine.LSU.2.01.0903200002390.29898@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkbbx-00009U-K7
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222AbZCTKEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759180AbZCTKEO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:04:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48967 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129AbZCTKEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:04:13 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDC11F5FC;
	Fri, 20 Mar 2009 10:04:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.01.0903200002390.29898@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113930>

Guido Ostkamp <git@ostkamp.fastmail.fm> wrote:
> Hello,
>
> I am trying to create a git repo that tracks an SVN repo with multiple  
> branch directories.
>
> Is there any way to get this done easily?
>
> It seems the 'git svn' command allows only to specify one 'trunk',  
> 'branches' and 'tag' directory.
>
> The example usecase is the OpenOffice.org repo (it's just a private  
> experiment). I got this svn-sync'ed within 4 evening sessions, the SVN  
> size is about ~8 GB with ~270000 commits. Unfortunately their structure 
> is
>
>   branches/
>   contrib/
>   cws/
>   dist/
>   patches/
>   tags/
>   trunk/
>
> where 'cws' and 'branches' both hold branches.
>
> I have seen a web-based article telling one should
>
>   git svn clone <URL>/trunk repo.git
>
> first, and then hack the repo.git/.git/config file manually to add 
> entries like
>
>   [svn-remote "b1"]
>         url = $SVN_REPO_URL/branches/b1
>         fetch = :refs/remotes/b1
>   [svn-remote "b2"]
>         url = $SVN_REPO_URL/branches/b2
>         fetch = :refs/remotes/b2
>   [svn-remote "c1"]
>         url = $SVN_REPO_URL/cws/c1
>         fetch = :refs/remotes/c1
>   ...
>
> to later use
>
>   git svn fetch <branchname>
>
> for each branch. But even if that worked, their seems to be no easy way 
> to detect newly created branches etc. Additionally, I get two entries 
> listed in 'git branch' for each, one of which with extension '@1' (seems 
> to point ot the branch point). This doesn't seem to be the case for 
> repo's with only one branch directory converted the normal way.
>
> Any ideas?


You should be able to do something like this:

[svn-remote "svn"]
	url = $SVN_REPO_URL
	branches = branches/*:refs/remotes/branches/*
	tags = tags/*:refs/remotes/tags/*
	fetch = cws/c1:refs/remotes/cws/c1
	fetch = cws/c2:refs/remotes/cws/c2
	fetch = cws/c3:refs/remotes/cws/c3
	...

As for generating the individual fetch lines, I would just pipe
svn ls $SVN_REPO_URL/cws to awk/sed/perl...

-- 
Eric Wong (who just realized he programs in ASP :x)
