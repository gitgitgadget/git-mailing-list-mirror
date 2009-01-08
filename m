From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Error : git svn fetch
Date: Wed, 7 Jan 2009 18:55:54 -0800
Message-ID: <20090108025554.GA28599@dcvr.yhbt.net>
References: <E48CF49FF0FE4F96BE206B2689165AF9@VMware>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chongyc <chongyc27@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 04:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlDs-0007Su-S1
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbZAHDEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZAHDEx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:04:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55160 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbZAHDEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 22:04:52 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jan 2009 22:04:52 EST
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F14F20068;
	Thu,  8 Jan 2009 02:55:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E48CF49FF0FE4F96BE206B2689165AF9@VMware>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104881>

chongyc <chongyc27@gmail.com> wrote:
> Hi
> 
> I found that 'git svn fetch' failed in cloning the hudson svn reposotory.
> 
> I want to git-clone the svn repository
> 
> svn repository URL : https://svn.dev.java.net/svn/hudson/
> username : guest
> password :
> 
> 
> So I run followings to git-clone
> 
> [root@localhost hudson]# git --version
> git version 1.6.0.6
> [root@localhost hudson]# git svn init -T trunk -t tags -b branches 
> https://svn.dev.java.net/svn/hudson/
> [root@localhost hudson]# git svn fetch
> Found possible branch point: 
> https://svn.dev.java.net/svn/hudson/tags/hudson-1_230 => 
> https://svn.dev.java.net/svn/hudson/branches/buildnav-1636, 10490
> Initializing parent: buildnav-1636@10490
> Found possible branch point: 
> https://svn.dev.java.net/svn/hudson/trunk/hudson/main => 
> https://svn.dev.java.net/svn/hudson/tags/hudson-1_230, 10450
> Initializing parent: buildnav-1636@10450
> Found branch parent: (buildnav-1636@10490) a1c395e5db063ca1ffbbe008e309c5
> 11d56219e0
> Following parent with do_switch
> remoting/pom.xml was not found in commit 
> a1c395e5db063ca1ffbbe008e309c511d56219e0 (r10447)
> [root@localhost hudson]#
> 
> What shall I do to git-clone it ?
> 
> Please help me

Hi, sorry for the late reply, I've been very distracted.

Looking at the hudson repository, the layout is non-standard and very
complex, with subdirectories being branched and tagged all over.  The
standard globbing that git-svn uses for most repositories does won't
work.  You'll have to map things manually:

[svn-remote "svn"]
        url = https://svn.dev.java.net/svn/hudson
        fetch = trunk/hudson:refs/remotes/trunk
        fetch = branches/tom:refs/remotes/tom
	...

Alternately, you could just clone the root and have all the branches all
over the place in one tree (your eventually working copy will be huge).

  git svn clone https://svn.dev.java.net/svn/hudson


Basically this is the equivalent of:

  svn co https://svn.dev.java.net/svn/hudson

Except you'll have the full history.

-- 
Eric Wong
