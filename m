From: John Locke <mail@freelock.com>
Subject: Re: git svn clone a non-standard repository
Date: Thu, 26 Jun 2008 11:29:50 -0700
Message-ID: <4863E01E.9050108@freelock.com>
References: <48613DC5.2000506@freelock.com> <g3to0t$35n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:30:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwF1-0003Ns-0u
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbYFZS3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036AbYFZS3p
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:29:45 -0400
Received: from logan.freelock.com ([216.231.62.127]:58504 "EHLO
	logan.freelock.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbYFZS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:29:43 -0400
Received: from localhost (foraker.freelock.com [127.0.0.1])
	by logan.freelock.com (Postfix) with ESMTP id BA774A0456;
	Thu, 26 Jun 2008 11:29:42 -0700 (PDT)
Received: from logan.freelock.com ([127.0.0.1])
 by localhost (foraker.freelock.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05136-01; Thu, 26 Jun 2008 11:29:42 -0700 (PDT)
Received: from [192.168.9.243] (router.freelock.lan [192.168.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by logan.freelock.com (Postfix) with ESMTP id 7983CA0448;
	Thu, 26 Jun 2008 11:29:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <g3to0t$35n$1@ger.gmane.org>
X-Virus-Scanned: by amavisd-new at freelock.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86469>

Hi, Michael,

Michael J Gruber wrote:
>>
>> moduleA/trunk <- contains trunk development of moduleA
>> moduleA/tags   <- empty
>> moduleA/branches <- empty
>> moduleB/trunk
>> moduleB/tags
>> moduleB/branches
>> moduleC/trunk
>> moduleC/tags
>> moduleC/branches
>> moduleD/trunk
>> moduleD/tags
>> moduleD/branches
>
> All of those module?/{tags,branches} are empty, right? I assume 
> branches follow the pattern below for tags.
Yup.

>
>> moduleE/trunk <- I don't care about this one...
>> trunk/   <- contains ancient version, not actual trunk
>> tags/1.0.0/moduleA <- contains tagged version of moduleA
>> tags/1.0.0/moduleB <- contains tagged version of moduleB
>> tags/1.0.0/moduleC <- contains tagged version of moduleC
>> tags/1.0.0/moduleD <- contains tagged version of moduleD
>> tags/1.0.1/moduleA
>> tags/1.0.1/moduleB
>> ...
>>
>> So I'd like to set up a git repo that tracks this SVN repository, and 
>> allows me to see:
>> moduleA/
>> moduleB/
>> moduleC/
>> moduleD/
>> ... in my checkout, whether I'm on trunk or a tag.
>
> So you want one git repo, reflecting the modules simply by different 
> subdirs? I'm afraid that raises similar problems like those I asked 
> about in my (yet unanswered) post
>
> http://permalink.gmane.org/gmane.comp.version-control.git/85861

I saw your post, and flagged it to see if anybody answered it, yes it 
does seem similar.
>
>> I've started with "git svn clone http://path/to/svn -T moduleA/trunk 
>> -t tags -b branches", and it's been sucking down branches for a 
>> couple days 
>
> This should give you all "modules" (as subsdirs) for all branches and 
> tags already. svn branch "branchname" becomes git remote branch 
> "branchname", svn tag "tagname" becomes git remote branch "tags/tagname".
> Note that your new git branch trunk will contain the contents of 
> "moduleA" only.

That's exactly what happened.
>
>> now, still not done. Can I set up moduleB/moduleC/moduleD as 
>> additional remotes in this same repository, and end up with the 
>> desired result? Was thinking I would add additional svn sections to 
>> .git/config, and then git svn fetch -- will this work, or is there a 
>> better way?
>
> If I understand your layout (and "desires") correctly then trunk will 
> be your only problem: you want to map "module?/trunk" to subdir 
> "module?" of branch "trunk". This is more or less the problem I'm 
> facing. Regular expressions (other than the ones for branches and 
> tags) in git svn config would solve this.
>

I found in the docs a section on subtrees, and with a bit of trickery, I 
think I'm getting what I want, though it's not simple to update. What 
I've done so far is change .git/config to:

[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[svn-remote "svn"]
    url = http://svn.dojotoolkit.org/src
    branches = branches/*:refs/remotes/*
    tags = tags/*:refs/remotes/tags/*
[svn-remote "dojo"]
    url = http://svn.dojotoolkit.org/src
    fetch = dojo/trunk:refs/remotes/dojo-trunk
[svn-remote "dijit"]
    url = http://svn.dojotoolkit.org/src
    fetch = dijit/trunk:refs/remotes/dijit-trunk
[svn-remote "dojox"]
    url = http://svn.dojotoolkit.org/src
    fetch = dojox/trunk:refs/remotes/dojox-trunk
[svn-remote "util"]
    url = http://svn.dojotoolkit.org/src
    fetch = util/trunk:refs/remotes/util-trunk


... dojo, dijit, dojox, and util correspond to moduleA-D in my previous 
example. So I have "svn" for the branches, and separate SVN sections for 
the trunk of each module. Then I used git svn fetch 
[dojo|dijit|dojox|util] to suck down those as individual branches.

Now the tricky part: I checked out a new "work" branch, and deleted 
everything in the working copy. Then, 4 steps out of the howto, adjusted 
to pull the particular branch from the current repository (instead of an 
outside one):

git remote add -t dojo -f dojo ./
git merge -s ours --no-commit dojo-trunk
git read-tree --prefix=dojo/ -u dojo-trunk
git commit -m "merge dojo into subdirectory"

... repeat for the other modules, and I ended up with my "work" branch 
containing the full trunk for all 4 modules.

Now for tracking the original project. According to the howto, you use 
this syntax to pull down changes:

 git pull -s subtree Bproject master
... when I try git pull -s subtree ./ dojo, I get "Already up to date", 
even though I know there are new changes. Still need to mess around with 
git svn rebase, I guess, to get the updates working correctly.

Cheers,

-- 
John Locke
"Open Source Solutions for Small Business Problems"
published by Charles River Media, June 2004
http://www.freelock.com
