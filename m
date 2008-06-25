From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git svn clone a non-standard repository
Date: Wed, 25 Jun 2008 17:25:15 +0200
Message-ID: <g3to0t$35n$1@ger.gmane.org>
References: <48613DC5.2000506@freelock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 17:27:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWtz-0001IV-4z
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbYFYPZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbYFYPZp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:25:45 -0400
Received: from main.gmane.org ([80.91.229.2]:58162 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758956AbYFYPZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:25:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBWs9-0002SQ-Tp
	for git@vger.kernel.org; Wed, 25 Jun 2008 15:25:25 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 15:25:25 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 15:25:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <48613DC5.2000506@freelock.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86289>

John Locke venit, vidit, dixit 24.06.2008 20:32:
> Hi,
> 
> I'm trying to create a git repo of the Dojo Toolkit, which has a quite 
> non-standard layout. There are 4 modules to the current Dojo project 
> that I care about (and some others in the repo that I'm not interested 
> in). The problem is, the trunk code is split out into 
> <modulename>/trunk, while tags are in tags/<tagname>/<modulename> and 
> branches are in branches/<branchname>/<modulename>. e.g:
> 
> moduleA/trunk <- contains trunk development of moduleA
> moduleA/tags   <- empty
> moduleA/branches <- empty
> moduleB/trunk
> moduleB/tags
> moduleB/branches
> moduleC/trunk
> moduleC/tags
> moduleC/branches
> moduleD/trunk
> moduleD/tags
> moduleD/branches

All of those module?/{tags,branches} are empty, right? I assume branches 
follow the pattern below for tags.

> moduleE/trunk <- I don't care about this one...
> trunk/   <- contains ancient version, not actual trunk
> tags/1.0.0/moduleA <- contains tagged version of moduleA
> tags/1.0.0/moduleB <- contains tagged version of moduleB
> tags/1.0.0/moduleC <- contains tagged version of moduleC
> tags/1.0.0/moduleD <- contains tagged version of moduleD
> tags/1.0.1/moduleA
> tags/1.0.1/moduleB
> ...
> 
> So I'd like to set up a git repo that tracks this SVN repository, and 
> allows me to see:
> moduleA/
> moduleB/
> moduleC/
> moduleD/
> ... in my checkout, whether I'm on trunk or a tag.

So you want one git repo, reflecting the modules simply by different 
subdirs? I'm afraid that raises similar problems like those I asked 
about in my (yet unanswered) post

http://permalink.gmane.org/gmane.comp.version-control.git/85861

> I've started with "git svn clone http://path/to/svn -T moduleA/trunk -t 
> tags -b branches", and it's been sucking down branches for a couple days 

This should give you all "modules" (as subsdirs) for all branches and 
tags already. svn branch "branchname" becomes git remote branch 
"branchname", svn tag "tagname" becomes git remote branch "tags/tagname".
Note that your new git branch trunk will contain the contents of 
"moduleA" only.

> now, still not done. Can I set up moduleB/moduleC/moduleD as additional 
> remotes in this same repository, and end up with the desired result? Was 
> thinking I would add additional svn sections to .git/config, and then 
> git svn fetch -- will this work, or is there a better way?

If I understand your layout (and "desires") correctly then trunk will be 
your only problem: you want to map "module?/trunk" to subdir "module?" 
of branch "trunk". This is more or less the problem I'm facing. Regular 
expressions (other than the ones for branches and tags) in git svn 
config would solve this.

Michael
