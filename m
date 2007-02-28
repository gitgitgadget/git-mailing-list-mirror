From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 18:31:26 +0100
Message-ID: <slrneubf3e.54h.siprbaum@xp.machine.xx>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 18:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMScL-00064T-7t
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbXB1R31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933248AbXB1R31
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:29:27 -0500
Received: from main.gmane.org ([80.91.229.2]:37613 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247AbXB1R30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:29:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMSbw-0003x2-Ln
	for git@vger.kernel.org; Wed, 28 Feb 2007 18:29:05 +0100
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 18:28:59 +0100
Received: from siprbaum by magnum.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 18:28:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: magnum.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40972>

Andy Parkins <andyparkins@gmail.com> schrieb:
> On Wednesday 2007 February 28 14:53, Paolo Bonzini wrote:
>> As can be seen from my other messages, I'm experimenting a little with
>> git and trying to understand how its workflow compares with arch.  Right
>> now, my procedure for branching off a remote archive is:
>>
>>    git checkout -b branchname remote/upstreambranch
>>    git config --add branch.branchname.remote remote
>>    git config --add branch.branchname.merge refs/heads/upstreambranch
>>
>> Is there a reason why "git branch" and "git checkout -b" should not
>> automatically do the two "git-config --add"s when the source branch is
>> remote?
>
> I can see why that would be handy, but I often make short lived branches off a 
> remote; and I wouldn't want my config cluttered up with branch defintions.
>
>> In case the source branch is not remote, would "origin" be a good choice
>> for the "branch.branchname.remote" variable?
>
> No.  That would still reference a remote.  As in:
>
> [remote "origin"]
>         url = git://git.kernel.org/pub/scm/git/git.git
>         fetch = refs/heads/master:refs/remotes/origin/master
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
> The remote = origin tells git to use the [remote "origin"] section.
>
> I think what you want is something that I would like too.  If you specify "." 
> to a git-pull it means to use the local repository not a remote.  It would be 
> great if one could have:
>
> [remote "origin"]
>         url = git://git.kernel.org/pub/scm/git/git.git
>         fetch = refs/heads/master:refs/remotes/origin/master
> [branch "master"]
>         remote = .
>         merge = refs/remotes/origin/master
>
> That way a "git pull" on master wouldn't need to make a remote connection in 
> order to do a merge (which is the way I like it).  However, I remember there 
> was a reason this wouldn't work, but I don't remember what it was :-)
>
>
> Andy

This doesn't work (AIUI). In your example you need to have a remote named ".",
which you havened (and I don't think . is valid for a remote name ).

But this works for me:

[remote "origin"]
        url = host:/path/to/your/repo
        fetch = refs/heads/*:refs/remotes/origin/*

[remote "local"]
        url = .
        fetch = refs/remotes/*:refs/remotes/*	# fetch into itself -> do nothing
						# needed to get the LHS of the fetch

[branch "testbranch"]
        remote = local
        merge = refs/remotes/origin/master	# specifying the LHS of the fetch


When on branch 'testbranch', a	'git pull local' merges
'refs/remotes/origin/master'.

Peter
