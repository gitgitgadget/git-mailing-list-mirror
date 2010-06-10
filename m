From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Question about tracking multiple Subversion repository from
	the same git repository with git-svn
Date: Thu, 10 Jun 2010 12:04:17 -0700
Message-ID: <20100610190417.GA15731@dcvr.yhbt.net>
References: <AANLkTimMOPXecB0lZM3v2MaZgbhJWwtxOUIGgkxr_PGF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:04:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMn3A-0007q2-M3
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689Ab0FJTET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 15:04:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37226 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759680Ab0FJTES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 15:04:18 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E141F78B;
	Thu, 10 Jun 2010 19:04:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTimMOPXecB0lZM3v2MaZgbhJWwtxOUIGgkxr_PGF@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148912>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> Hi all,
> 
> Say that I have 3 subversion repository
> 
> svn: an online repo which I only have read-only rights.
> abc, xyz: two project in two private repo where I have write rights.
> 
> [svn-remote "svn"]
> 	url = http://svn.online-repo.com/repos/public
> 	fetch = path/to/trunk:refs/remotes/svn/trunk
> 	branches = path/to/branches/*:refs/remotes/svn/*
> 	tags = path/to/tags/*:refs/remotes/svn/tags/*
> 
> [svn-remote "abc"]
> 	url = https://svn.local-repo/repos/public
> 	fetch = path/to/trunk:refs/remotes/abc/trunk
> 	branches = path/to/branches/*:refs/remotes/abc/*
> 	tags = path/to/tags/*:refs/remotes/abc/tags/*
> 
> [svn-remote "xyz"]
> 	url = https://svn.local-repo/repos/public
> 	fetch = path/to/trunk:refs/remotes/xyz/trunk
> 	branches = path/to/branches/*:refs/remotes/xyz/*
> 	tags = path/to/tags/*:refs/remotes/xyz/tags/*
> 
> Reading the man page of git-svn it seems this is possible and
> specifically supported.
> 
> 
> But I have some doubt.
> 
> Suppose I've already created the project "abc" starting with trunk
> copied from a specific commit (tag) of the "svn" project.
> 
> 1. Is there a way to tell git that abc/trunk is a branch of svn/tags/1.2.3 ?

You need to use grafts.

> 2. can I rename svn-remote "svn" to something like "main" without side effect?

You should be able to (and use GIT_SVN_ID=main in the env),
though I haven't used these features in a while.

> 3. after 2) can I also rename all the names of the remote branches to
> main/* instead of svn/* ?

It should be possible...  you need to edit $GIT_DIR/svn/.metadata, too.

> 4. if project xyz is no more of interest to me can I "discard" it and
> remove the remote branches I don't need anymore?

Yes.

> 5. when I'll decide to upgrade project abc to main version 2.0.0 I'll do:
> git merge --squash main/tags/2.0.0
> is this the best way?

Probably, yes.

> 6. after point 5) when I'll further upgrade the project abc to main
> version 2.1.0 can I still do:
> git merge --squash main/tags/2.1.0
> or this will cause me problem? (the rerere option is set to true, so
> conflicts already solved shouldn't be asked twice).

merge --squash should always be safe when dealing with SVN repos.

> 7. if the merge --squash cause a lot of conflicts is there a way to
> split the conflict resolution across different persons?

I'm not sure what you mean... multiple people working on the same
working tree?  On a shared screen session?  I don't see why not.

-- 
Eric Wong
