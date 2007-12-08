From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn branch naming question
Date: Sat, 8 Dec 2007 17:56:57 +0100
Message-ID: <20071208165657.GC2844@xp.machine.xx>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 17:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J12zn-0001Ny-Cs
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 17:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXLHQ5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 11:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXLHQ5B
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 11:57:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:36696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbXLHQ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 11:57:01 -0500
Received: (qmail invoked by alias); 08 Dec 2007 16:56:58 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp024) with SMTP; 08 Dec 2007 17:56:58 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18ZJ/VqARYZzyl2ZIbYQtX4xVWYGSPut+1Fj9E24k
	WsoMra6Kt7XQQN
Content-Disposition: inline
In-Reply-To: <20071208141449.GH3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67559>

On Sat, Dec 08, 2007 at 03:14:49PM +0100, Miklos Vajna wrote:
> On Sat, Dec 08, 2007 at 11:59:01AM +0100, Peter Baumann <waste.manager@gmx.de> wrote:
> > Look up  --prefix in the manpage for git-svn.
> 
> great, --prefix is what i missed.
> 
> a related question: is it possible to avoid even the "remotes" prefix?
> 
> it could be useful when creating an incremental import of an svn repo.
> (ie when using git-svn as a replacement of git-svnimport.)
> 

git svn init --stdlayout creates this entry in your .git/config per default

  [svn-remote "svn"]
        url = https://url/to/your/svn/repo
        fetch = trunk:refs/remotes/trunk
        branches = branches/*:refs/remotes/*
        tags = tags/*:refs/remotes/tags/*

You could change this to

  [svn-remote "svn"]
        url = https://url/to/your/svn/repo
        fetch = trunk:refs/remotes/origin/trunk
        branches = branches/*:refs/remotes/origin/*
        tags = tags/*:refs/remotes/origin/tags/*

to get what --prefix origin would do.


 On the other hand you could forget completly the remote part by specifying

  [svn-remote "svn"]
        url = https://url/to/your/svn/repo
        fetch = trunk:refs/heads/trunk
        branches = branches/*:refs/heads/*
        tags = tags/*:refs/heads/tags/*

but I advice you to not do this. refs/remotes has a special meaning in git,
e.g.  you can't commit directly to it (which makes sense, because it only
tracks the state of the remote repo. On the other hand remote branches won't
get cloned per default.)

Side note, if you want to track only some branches, or if you have a strange
svn layout, you could use something like this:

  [svn-remote "svn"]
        url = https://url/to/your/svn/repo
        fetch = trunk:refs/remotes/origin/trunk
        fetch = branches/branchA:refs/remotes/origin/branchA
        fetch = branches/branchB:refs/remotes/origin/branchB
	...


-Peter
